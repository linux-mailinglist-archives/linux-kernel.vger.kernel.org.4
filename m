Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29DCB707C23
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 10:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjERIeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 04:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjERIem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 04:34:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCAD98
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 01:34:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B243564D8B
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 08:34:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C023CC433EF;
        Thu, 18 May 2023 08:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684398880;
        bh=nidHw/D03k42QIJ2HSyH6xaiVhz5OqrDcGXUjy+MrJc=;
        h=From:To:Cc:Subject:Date:From;
        b=pnyHYexrYMeifCfebpTF0Rkw7h634aIyi4JbvLnS4qDLee7NJj2qOZvST332fS0Xx
         xZ8MlLw+FO8wztUJij818iuew53MrYVTVVMYi8XFEPBDTOZvykzJfXJ0Km44BQ/E11
         hUK1itLLK1bIGtRPWMvhoxrdOVJEYNCkq3j4wLQfWyw+PmT8MVeseWdUi+qmNev9D+
         +W/iWnXbqaGcgVtJdMZMrxQyYLxqjafLYySNiZ/MwzMgvBhmdq6tG5UfesAS7AyO5R
         qqDUTDg7wzazVZQcmk59bsDkK1Nkx4/tnjJITnlVwkAhR86+UbBTRDFr573dzbP2/F
         8keJKajePiTJw==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
        Weichao Guo <guoweichao@oppo.com>
Subject: [PATCH v2] f2fs: support background_gc=adjust mount option
Date:   Thu, 18 May 2023 16:34:21 +0800
Message-Id: <20230518083421.2242787-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As JuHyung reported in [1]:

"In most consumer-grade blackbox SSDs, device-side GCs are handled
automatically for various workloads. f2fs, however, leaves that
responsibility to the userspace with conservative tuning on the
kernel-side by default. Android handles this by init.rc tunings and a
separate code running in vold to trigger gc_urgent.

For regular Linux desktop distros, f2fs just runs on the default
configuration set on the kernel and unless it’s running 24/7 with
plentiful idle time, it quickly runs out of free segments and starts
triggering foreground GC. This is giving people the wrong impression
that f2fs slows down far drastically than other file-systems when
that’s quite the contrary (i.e., less fragmentation overtime)."

This patch supports background_gc=adjust mount option.

If background_gc=adjust, gc will adjust its policy depends
on conditions: speed up if there no free segments, and slow
down if there is no free space.

The main logic is as below:

1. performance mode
- condition: if free_segments is less than 10 * ovp_segments and
reclaimable_block is more than 20 * unused_user_block
- action:
 a) reduce sleep time of GC thread based on free user block
    ratio, that is to say, the more reclaimable blocks, the less time
    thread will sleep
 b) disable IO aware

2. lifetime mode:
- condition: if free space is less than 90%
- action:
 a) reset min_sleep_time to default 30000 ms
 b) reduce cost weight of age when cacluating cost of dirty
 segment, so that GC may select victim which contains less blocks
 c) disable IO aware

3. balance mode
- condition: it is default mode
- action:
 a) reduce min_sleep_time from 30000 ms to 10000 ms
 b) enable IO aware

[1] https://lore.kernel.org/linux-f2fs-devel/CAD14+f3z=kS9E+NTKH7t1J2xL1PpLOVMNx=CabD_t2K6U=T9uQ@mail.gmail.com

Original patch was developed by Weichao Guo, I refactor it a bit and
rebase the code.

Signed-off-by: Weichao Guo <guoweichao@oppo.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- fix typo
- disable IO aware for perf/lifetime mode
- check bggc mode in get_max_age()
 Documentation/filesystems/f2fs.rst |  7 ++-
 fs/f2fs/f2fs.h                     |  4 ++
 fs/f2fs/gc.c                       | 94 +++++++++++++++++++++++++++++-
 fs/f2fs/gc.h                       | 23 ++++++++
 fs/f2fs/super.c                    |  4 ++
 5 files changed, 128 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 9359978a5af2..764301f7391e 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -112,8 +112,11 @@ background_gc=%s	 Turn on/off cleaning operations, namely garbage
 			 collection and if background_gc=off, garbage collection
 			 will be turned off. If background_gc=sync, it will turn
 			 on synchronous garbage collection running in background.
-			 Default value for this option is on. So garbage
-			 collection is on by default.
+			 If background_gc=adjust, gc will adjust its policy depends
+			 on conditions: speed up if there no free segments, and slow
+			 down if there is no free space.
+			 Default value for this option is on. So garbage collection
+			 is on by default.
 gc_merge		 When background_gc is on, this option can be enabled to
 			 let background GC thread to handle foreground GC requests,
 			 it can eliminate the sluggish issue caused by slow foreground
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8d4eaf4d2246..e82af8a09d11 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1333,6 +1333,10 @@ enum {
 				 * background gc is on, migrating blocks
 				 * like foreground gc
 				 */
+	BGGC_MODE_ADJUST,	/*
+				 * background gc is on, and tune its speed
+				 * depends on conditions
+				 */
 };
 
 enum {
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 51d7e8d29bf1..35b95b3d57ef 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -28,6 +28,67 @@ static struct kmem_cache *victim_entry_slab;
 static unsigned int count_bits(const unsigned long *addr,
 				unsigned int offset, unsigned int len);
 
+static inline int free_user_block_ratio(struct f2fs_sb_info *sbi)
+{
+	block_t unused_user_blocks = sbi->user_block_count -
+					written_block_count(sbi);
+	return unused_user_blocks == 0 ? 100 :
+		(100 * free_user_blocks(sbi) / unused_user_blocks);
+}
+
+static bool has_few_free_segments(struct f2fs_sb_info *sbi)
+{
+	unsigned int free_segs = free_segments(sbi);
+	unsigned int ovp_segs = overprovision_segments(sbi);
+
+	return free_segs <= DEF_FEW_FREE_SEGMENT_MULTIPLE * ovp_segs;
+}
+
+static bool has_few_free_space(struct f2fs_sb_info *sbi)
+{
+	block_t total_user_block = sbi->user_block_count;
+	block_t free_user_blocks = total_user_block - written_block_count(sbi);
+
+	return 100 * free_user_blocks / total_user_block <=
+					DEF_FEW_FREE_SPACE_RATIO;
+}
+
+static bool has_enough_reclaimable_blocks(struct f2fs_sb_info *sbi)
+{
+	return 100 - free_user_block_ratio(sbi) >=
+			DEF_ENOUGH_RECLAIMABLE_BLOCK_RATIO;
+}
+
+static void adjust_gc_perference(struct f2fs_sb_info *sbi,
+						unsigned int *wait_ms)
+{
+	struct f2fs_gc_kthread *gc_th = sbi->gc_thread;
+
+	if (has_few_free_space(sbi))
+		gc_th->gc_preference = GC_LIFETIME_MODE;
+	else if (has_few_free_segments(sbi) &&
+			has_enough_reclaimable_blocks(sbi))
+		gc_th->gc_preference = GC_PERFORMANCE_MODE;
+	else
+		gc_th->gc_preference = GC_BALANCE_MODE;
+
+	switch (gc_th->gc_preference) {
+	case GC_PERFORMANCE_MODE:
+		*wait_ms = max(DEF_GC_BALANCE_MIN_SLEEP_TIME *
+					free_user_block_ratio(sbi) / 100,
+					DEF_GC_PERFORMANCE_MIN_SLEEP_TIME);
+		break;
+	case GC_LIFETIME_MODE:
+		gc_th->min_sleep_time = DEF_GC_THREAD_MIN_SLEEP_TIME;
+		break;
+	case GC_BALANCE_MODE:
+		gc_th->min_sleep_time = DEF_GC_BALANCE_MIN_SLEEP_TIME;
+		break;
+	default:
+		f2fs_bug_on(sbi, 1);
+	}
+}
+
 static int gc_thread_func(void *data)
 {
 	struct f2fs_sb_info *sbi = data;
@@ -46,6 +107,9 @@ static int gc_thread_func(void *data)
 	do {
 		bool sync_mode, foreground = false;
 
+		if (F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_ADJUST)
+			adjust_gc_perference(sbi, &wait_ms);
+
 		wait_event_interruptible_timeout(*wq,
 				kthread_should_stop() || freezing(current) ||
 				waitqueue_active(fggc_wq) ||
@@ -109,7 +173,9 @@ static int gc_thread_func(void *data)
 			goto next;
 		}
 
-		if (!is_idle(sbi, GC_TIME)) {
+		if (!is_idle(sbi, GC_TIME) &&
+			(F2FS_OPTION(sbi).bggc_mode != BGGC_MODE_ADJUST ||
+				gc_th->gc_preference == GC_BALANCE_MODE)) {
 			increase_sleep_time(gc_th, &wait_ms);
 			f2fs_up_write(&sbi->gc_lock);
 			stat_io_skip_bggc_count(sbi);
@@ -183,6 +249,8 @@ int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
 	gc_th->max_sleep_time = DEF_GC_THREAD_MAX_SLEEP_TIME;
 	gc_th->no_gc_sleep_time = DEF_GC_THREAD_NOGC_SLEEP_TIME;
 
+	gc_th->gc_preference = GC_BALANCE_MODE;
+
 	gc_th->gc_wake = false;
 
 	sbi->gc_thread = gc_th;
@@ -329,6 +397,24 @@ static unsigned int check_bg_victims(struct f2fs_sb_info *sbi)
 	return NULL_SEGNO;
 }
 
+static unsigned char get_max_age(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_gc_kthread *gc_th = sbi->gc_thread;
+	unsigned char max_age = 100;
+	unsigned char ratio;
+
+	if (!gc_th || F2FS_OPTION(sbi).bggc_mode != BGGC_MODE_ADJUST ||
+			gc_th->gc_preference != GC_LIFETIME_MODE)
+		goto out;
+
+	/* if free block count is less than 10%, reduce cost weight of age */
+	ratio = free_user_block_ratio(sbi);
+	if (ratio <= DEF_FEW_FREE_SEGMENT_RATIO)
+		max_age = max(10 * ratio, 1);
+out:
+	return max_age;
+}
+
 static unsigned int get_cb_cost(struct f2fs_sb_info *sbi, unsigned int segno)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
@@ -336,6 +422,7 @@ static unsigned int get_cb_cost(struct f2fs_sb_info *sbi, unsigned int segno)
 	unsigned int start = GET_SEG_FROM_SEC(sbi, secno);
 	unsigned long long mtime = 0;
 	unsigned int vblocks;
+	unsigned char max_age;
 	unsigned char age = 0;
 	unsigned char u;
 	unsigned int i;
@@ -355,8 +442,11 @@ static unsigned int get_cb_cost(struct f2fs_sb_info *sbi, unsigned int segno)
 		sit_i->min_mtime = mtime;
 	if (mtime > sit_i->max_mtime)
 		sit_i->max_mtime = mtime;
+
+	max_age = get_max_age(sbi);
+
 	if (sit_i->max_mtime != sit_i->min_mtime)
-		age = 100 - div64_u64(100 * (mtime - sit_i->min_mtime),
+		age = max_age - div64_u64(max_age * (mtime - sit_i->min_mtime),
 				sit_i->max_mtime - sit_i->min_mtime);
 
 	return UINT_MAX - ((100 * (100 - u) * age) / (100 + u));
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index 28a00942802c..66f6a30dd494 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -15,6 +15,14 @@
 #define DEF_GC_THREAD_MAX_SLEEP_TIME	60000
 #define DEF_GC_THREAD_NOGC_SLEEP_TIME	300000	/* wait 5 min */
 
+/* for BGGC_MODE_ADJUST */
+#define DEF_GC_PERFORMANCE_MIN_SLEEP_TIME	100	/* 100 ms */
+#define DEF_GC_BALANCE_MIN_SLEEP_TIME		10000	/* 10 sec */
+#define DEF_FEW_FREE_SPACE_RATIO		10	/* few free space ratio */
+#define DEF_FEW_FREE_SEGMENT_MULTIPLE		10	/* few free segments multiple */
+#define DEF_ENOUGH_RECLAIMABLE_BLOCK_RATIO	20	/* enough reclaimable block ratio */
+#define DEF_FEW_FREE_SEGMENT_RATIO		10	/* few free segment ratio */
+
 /* choose candidates from sections which has age of more than 7 days */
 #define DEF_GC_THREAD_AGE_THRESHOLD		(60 * 60 * 24 * 7)
 #define DEF_GC_THREAD_CANDIDATE_RATIO		20	/* select 20% oldest sections as candidates */
@@ -32,6 +40,19 @@
 
 #define NR_GC_CHECKPOINT_SECS (3)	/* data/node/dentry sections */
 
+/* GC preference */
+enum {
+	GC_PERFORMANCE_MODE,		/*
+					 * speed up background gc to recycle
+					 * slack space for better performance
+					 */
+	GC_LIFETIME_MODE,		/*
+					 * slow down background gc to avoid high
+					 * WAF if there is less free space.
+					 */
+	GC_BALANCE_MODE,		/* tradeoff in between perf and lifetime */
+};
+
 struct f2fs_gc_kthread {
 	struct task_struct *f2fs_gc_task;
 	wait_queue_head_t gc_wait_queue_head;
@@ -42,6 +63,8 @@ struct f2fs_gc_kthread {
 	unsigned int max_sleep_time;
 	unsigned int no_gc_sleep_time;
 
+	unsigned char gc_preference;	/* gc perference */
+
 	/* for changing gc mode */
 	bool gc_wake;
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f19217219c3b..806c8119f021 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -693,6 +693,8 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 				F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_OFF;
 			} else if (!strcmp(name, "sync")) {
 				F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_SYNC;
+			} else if (!strcmp(name, "adjust")) {
+				F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_ADJUST;
 			} else {
 				kfree(name);
 				return -EINVAL;
@@ -1927,6 +1929,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_printf(seq, ",background_gc=%s", "on");
 	else if (F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_OFF)
 		seq_printf(seq, ",background_gc=%s", "off");
+	else if (F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_ADJUST)
+		seq_printf(seq, ",background_gc=%s", "adjust");
 
 	if (test_opt(sbi, GC_MERGE))
 		seq_puts(seq, ",gc_merge");
-- 
2.40.1

