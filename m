Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1927D6AD7DB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 07:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjCGG6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 01:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjCGG5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 01:57:46 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BED86176
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 22:56:44 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 130so7025201pgg.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 22:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678172196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASSD7BghNw/J/hUaiXgWQCknh8Fl8R4TjAxXoZe8rSo=;
        b=gwtF2j6jEh4RIfI6JeZzkRF/pMyUNSc09ILbLx3nVVaFUO9uEdhj33JRDIszQXQGC7
         tFr1nfLXPXzxu61Qs4pZfvZ+lgsXotnOK4kxSA6ErTDJ3W9Yv9udOYJFj30nHSvBFyCK
         6zXZzdciINciHjYiRTh9V7nvLCLygsVJ/+eAkyvaE7v2gDCPhNda8nR9vHnymWdta9XX
         nom7SbNGo2amnoXsU0yzWSGLVguPni1/Zb7foDqZHxvqZtJ3jEqF2qkhQsumFjGyA+Oj
         mW773gxFLzs4+Pd46Q3RYSLslTYbgRVmbhEIspK60CCkH26JKY6i5r6Y+hVwWdew41+A
         rdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678172196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ASSD7BghNw/J/hUaiXgWQCknh8Fl8R4TjAxXoZe8rSo=;
        b=p4YMOrYtQpyNoQJQHU3Qyk2/DIs4eVyLwuZ+c9ucVNHkwvecUHjyfBsibSldVxFK7V
         T4129v1Sx0fHV7NfD6wKlkF2YNM9WTllwyYJa9QnaNeOW/u9CWPiE4R3Dd+NFmJbF7TT
         yPxXDV7GRXRehlQjC0Ooc1LuGfDsw9/CgFpKgtZNqvr/KDu4STTIQtrnmAltwDVyB1UP
         LO/s488Bur/bBZ8eaYwhx0vggiF9GtE+36aeCC2PyXIeqF8b18HuIUoFvU16hXvjDtMt
         EH+ebkcTdDl/88jO3hm5D4eH3BVSbQ5l5Hti62QfUVv4BtYdVvnW0jnx4jUlxq1MRcOW
         DIHg==
X-Gm-Message-State: AO0yUKVhbrf2t+Ob9/laA7EYOCjXC6p01p+qsGXuM+EJhiRtgO8o4sK/
        WU0wN1CBB2lDYD3kxoHa8jxp5w==
X-Google-Smtp-Source: AK7set8ycLeV4ug3Hh8JCVS9nXkkF3OpTneeqDALEmgAnAPJ0FJlAs/ofqR1TK404Yuh4hIX7jHwLw==
X-Received: by 2002:a05:6a00:2d89:b0:5e2:3086:f977 with SMTP id fb9-20020a056a002d8900b005e23086f977mr13567615pfb.2.1678172196363;
        Mon, 06 Mar 2023 22:56:36 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id e5-20020a62ee05000000b00608dae58695sm7230854pfi.209.2023.03.06.22.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 22:56:35 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tkhai@ya.ru, hannes@cmpxchg.org,
        shakeelb@google.com, mhocko@kernel.org, roman.gushchin@linux.dev,
        muchun.song@linux.dev, david@redhat.com, shy828301@gmail.com,
        rppt@kernel.org
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 2/8] mm: vmscan: make global slab shrink lockless
Date:   Tue,  7 Mar 2023 14:55:59 +0800
Message-Id: <20230307065605.58209-3-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230307065605.58209-1-zhengqi.arch@bytedance.com>
References: <20230307065605.58209-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The shrinker_rwsem is a global read-write lock in
shrinkers subsystem, which protects most operations
such as slab shrink, registration and unregistration
of shrinkers, etc. This can easily cause problems in
the following cases.

1) When the memory pressure is high and there are many
   filesystems mounted or unmounted at the same time,
   slab shrink will be affected (down_read_trylock()
   failed).

   Such as the real workload mentioned by Kirill Tkhai:

   ```
   One of the real workloads from my experience is start
   of an overcommitted node containing many starting
   containers after node crash (or many resuming containers
   after reboot for kernel update). In these cases memory
   pressure is huge, and the node goes round in long reclaim.
   ```

2) If a shrinker is blocked (such as the case mentioned
   in [1]) and a writer comes in (such as mount a fs),
   then this writer will be blocked and cause all
   subsequent shrinker-related operations to be blocked.

Even if there is no competitor when shrinking slab, there
may still be a problem. If we have a long shrinker list
and we do not reclaim enough memory with each shrinker,
then the down_read_trylock() may be called with high
frequency. Because of the poor multicore scalability of
atomic operations, this can lead to a significant drop
in IPC (instructions per cycle).

So many times in history ([2],[3],[4],[5]), some people
wanted to replace shrinker_rwsem trylock with SRCU in
the slab shrink, but all these patches were abandoned
because SRCU was not unconditionally enabled.

But now, since commit 1cd0bd06093c ("rcu: Remove CONFIG_SRCU"),
the SRCU is unconditionally enabled. So it's time to use
SRCU to protect readers who previously held shrinker_rwsem.

This commit uses SRCU to make global slab shrink lockless,
the memcg slab shrink is handled in the subsequent patch.

[1]. https://lore.kernel.org/lkml/20191129214541.3110-1-ptikhomirov@virtuozzo.com/
[2]. https://lore.kernel.org/all/1437080113.3596.2.camel@stgolabs.net/
[3]. https://lore.kernel.org/lkml/1510609063-3327-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp/
[4]. https://lore.kernel.org/lkml/153365347929.19074.12509495712735843805.stgit@localhost.localdomain/
[5]. https://lore.kernel.org/lkml/20210927074823.5825-1-sultan@kerneltoast.com/

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/vmscan.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2dcc01682026..8515ac40bcaf 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -202,6 +202,7 @@ static void set_task_reclaim_state(struct task_struct *task,
 
 LIST_HEAD(shrinker_list);
 DECLARE_RWSEM(shrinker_rwsem);
+DEFINE_SRCU(shrinker_srcu);
 
 #ifdef CONFIG_MEMCG
 static int shrinker_nr_max;
@@ -706,7 +707,7 @@ void free_prealloced_shrinker(struct shrinker *shrinker)
 void register_shrinker_prepared(struct shrinker *shrinker)
 {
 	down_write(&shrinker_rwsem);
-	list_add_tail(&shrinker->list, &shrinker_list);
+	list_add_tail_rcu(&shrinker->list, &shrinker_list);
 	shrinker->flags |= SHRINKER_REGISTERED;
 	shrinker_debugfs_add(shrinker);
 	up_write(&shrinker_rwsem);
@@ -760,13 +761,15 @@ void unregister_shrinker(struct shrinker *shrinker)
 		return;
 
 	down_write(&shrinker_rwsem);
-	list_del(&shrinker->list);
+	list_del_rcu(&shrinker->list);
 	shrinker->flags &= ~SHRINKER_REGISTERED;
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
 		unregister_memcg_shrinker(shrinker);
 	debugfs_entry = shrinker_debugfs_remove(shrinker);
 	up_write(&shrinker_rwsem);
 
+	synchronize_srcu(&shrinker_srcu);
+
 	debugfs_remove_recursive(debugfs_entry);
 
 	kfree(shrinker->nr_deferred);
@@ -786,6 +789,7 @@ void synchronize_shrinkers(void)
 {
 	down_write(&shrinker_rwsem);
 	up_write(&shrinker_rwsem);
+	synchronize_srcu(&shrinker_srcu);
 }
 EXPORT_SYMBOL(synchronize_shrinkers);
 
@@ -996,6 +1000,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 {
 	unsigned long ret, freed = 0;
 	struct shrinker *shrinker;
+	int srcu_idx;
 
 	/*
 	 * The root memcg might be allocated even though memcg is disabled
@@ -1007,10 +1012,10 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 	if (!mem_cgroup_disabled() && !mem_cgroup_is_root(memcg))
 		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
 
-	if (!down_read_trylock(&shrinker_rwsem))
-		goto out;
+	srcu_idx = srcu_read_lock(&shrinker_srcu);
 
-	list_for_each_entry(shrinker, &shrinker_list, list) {
+	list_for_each_entry_srcu(shrinker, &shrinker_list, list,
+				 srcu_read_lock_held(&shrinker_srcu)) {
 		struct shrink_control sc = {
 			.gfp_mask = gfp_mask,
 			.nid = nid,
@@ -1021,19 +1026,9 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 		if (ret == SHRINK_EMPTY)
 			ret = 0;
 		freed += ret;
-		/*
-		 * Bail out if someone want to register a new shrinker to
-		 * prevent the registration from being stalled for long periods
-		 * by parallel ongoing shrinking.
-		 */
-		if (rwsem_is_contended(&shrinker_rwsem)) {
-			freed = freed ? : 1;
-			break;
-		}
 	}
 
-	up_read(&shrinker_rwsem);
-out:
+	srcu_read_unlock(&shrinker_srcu, srcu_idx);
 	cond_resched();
 	return freed;
 }
-- 
2.20.1

