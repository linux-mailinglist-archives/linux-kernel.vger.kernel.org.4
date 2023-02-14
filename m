Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737536970D4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 23:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjBNWkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 17:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBNWku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 17:40:50 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FA2305C9;
        Tue, 14 Feb 2023 14:40:48 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id k13so18586441plg.0;
        Tue, 14 Feb 2023 14:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNcWrT1s+JZEu6y/b+CDQSL4Nb1LRZZX+E7NMjsaQdI=;
        b=XA91pX0Mu1DyTojcc+VR7tUekbRGM60OwJTkpqB1pI2ryvb7R3EM80tYuGa5CC/vud
         tM9xJjamBeFKVUD+ELaq702LQ5s4bk4z5ogfRA/kljsMbXWE6rGaEBIhEMXmSZKMtRVI
         ZWx8/+Itpzz3Es/uzFUjUqL5lnLsowpeG3gFhf4ax5BlWk7kewgmWC6URUc1tgbvTLrV
         xuvxCd12wMn6uuGVfvzLDEhPM6neeh1682cjc4NWi+TxB8UdwZdcGibq2eKwoM669e1S
         sbumNqboIvqpodZQtL82Ts8a7JDfjZ/IXRdIpx4VewXArC4LsveWrLZXve0K7244ldQ0
         +iRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gNcWrT1s+JZEu6y/b+CDQSL4Nb1LRZZX+E7NMjsaQdI=;
        b=EBJc+OvRpyqSJxrCi3Wfjw3FQWmhWevBquZzxNXlqd+J4tpgfyErG5RyNnWhQohZQG
         OcK5DChmrvenaSarSd50A7f0NNpB4MwyBYQ5apEfFvaAEy1pA/SXdg4YmQAmytT1v8qM
         Ds5Lbe6+7y4R2t1zwVx4N5ielDiTH/muvWsRYEGb5nThlU1U5j4yV62DmdznCiR3I+07
         LVqM3JDslb0VUJgJoieSqokv2jmNNn8ByJHwUOKi0eFkxgjHtftAu0/Z+1t8ZQtFdVS+
         qT8Amrztf5k8wgqtVW6POFTswMHS4Z9MUwmGmLqOxlfQxvBIUXZWbIi2fPJF4pouGQKk
         ofKg==
X-Gm-Message-State: AO0yUKWj2uIQfvVQS4KuF2SaV+BGsRm87uobqIVpIirc6QneQyESUk82
        1Kya0p5ftxl82sTIdWqfSfg=
X-Google-Smtp-Source: AK7set9KuAUFq6dSNB/796ma1oEDGMdTmZyxO5VOZYJrb8q9u9iidKi+MrHVv6DZc8pll5wFISdd3w==
X-Received: by 2002:a17:902:c641:b0:19a:723a:8466 with SMTP id s1-20020a170902c64100b0019a723a8466mr182701pls.36.1676414447965;
        Tue, 14 Feb 2023 14:40:47 -0800 (PST)
Received: from carrot.. (i121-118-76-39.s42.a014.ap.plala.or.jp. [121.118.76.39])
        by smtp.gmail.com with ESMTPSA id w2-20020a170902a70200b001965f761e6dsm10694316plq.182.2023.02.14.14.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 14:40:46 -0800 (PST)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        syzbot <syzbot+f0c4082ce5ebebdac63b@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] nilfs2: fix underflow in second superblock position calculations
Date:   Wed, 15 Feb 2023 07:40:43 +0900
Message-Id: <20230214224043.24141-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0000000000004e1dfa05f4a48e6b@google.com>
References: <0000000000004e1dfa05f4a48e6b@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Macro NILFS_SB2_OFFSET_BYTES, which computes the position of the second
superblock, underflows when the argument device size is less than 4096
bytes.  Therefore, when using this macro, it is necessary to check in
advance that the device size is not less than a lower limit, or at least
that underflow does not occur.

The current nilfs2 implementation lacks this check, causing
out-of-bound block access when mounting devices smaller than 4096 bytes:

 I/O error, dev loop0, sector 36028797018963960 op 0x0:(READ) flags 0x0
 phys_seg 1 prio class 2
 NILFS (loop0): unable to read secondary superblock (blocksize = 1024)

In addition, when trying to resize the filesystem to a size below 4096
bytes, this underflow occurs in nilfs_resize_fs(), passing a huge number
of segments to nilfs_sufile_resize(), corrupting parameters such as the
number of segments in superblocks.  This causes excessive loop iterations
in nilfs_sufile_resize() during a subsequent resize ioctl, causing
semaphore ns_segctor_sem to block for a long time and hang the writer
thread:

 INFO: task segctord:5067 blocked for more than 143 seconds.
      Not tainted 6.2.0-rc8-syzkaller-00015-gf6feea56f66d #0
 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 task:segctord        state:D stack:23456 pid:5067  ppid:2
 flags:0x00004000
 Call Trace:
  <TASK>
  context_switch kernel/sched/core.c:5293 [inline]
  __schedule+0x1409/0x43f0 kernel/sched/core.c:6606
  schedule+0xc3/0x190 kernel/sched/core.c:6682
  rwsem_down_write_slowpath+0xfcf/0x14a0 kernel/locking/rwsem.c:1190
  nilfs_transaction_lock+0x25c/0x4f0 fs/nilfs2/segment.c:357
  nilfs_segctor_thread_construct fs/nilfs2/segment.c:2486 [inline]
  nilfs_segctor_thread+0x52f/0x1140 fs/nilfs2/segment.c:2570
  kthread+0x270/0x300 kernel/kthread.c:376
  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
  </TASK>
 ...
 Call Trace:
  <TASK>
  folio_mark_accessed+0x51c/0xf00 mm/swap.c:515
  __nilfs_get_page_block fs/nilfs2/page.c:42 [inline]
  nilfs_grab_buffer+0x3d3/0x540 fs/nilfs2/page.c:61
  nilfs_mdt_submit_block+0xd7/0x8f0 fs/nilfs2/mdt.c:121
  nilfs_mdt_read_block+0xeb/0x430 fs/nilfs2/mdt.c:176
  nilfs_mdt_get_block+0x12d/0xbb0 fs/nilfs2/mdt.c:251
  nilfs_sufile_get_segment_usage_block fs/nilfs2/sufile.c:92 [inline]
  nilfs_sufile_truncate_range fs/nilfs2/sufile.c:679 [inline]
  nilfs_sufile_resize+0x7a3/0x12b0 fs/nilfs2/sufile.c:777
  nilfs_resize_fs+0x20c/0xed0 fs/nilfs2/super.c:422
  nilfs_ioctl_resize fs/nilfs2/ioctl.c:1033 [inline]
  nilfs_ioctl+0x137c/0x2440 fs/nilfs2/ioctl.c:1301
  ...

This fixes these issues by inserting appropriate minimum device size
checks or anti-underflow checks, depending on where the macro is used.

Link: https://lkml.kernel.org/r/0000000000004e1dfa05f4a48e6b@google.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+f0c4082ce5ebebdac63b@syzkaller.appspotmail.com
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: stable@vger.kernel.org
---
 fs/nilfs2/ioctl.c     | 7 +++++++
 fs/nilfs2/super.c     | 9 +++++++++
 fs/nilfs2/the_nilfs.c | 8 +++++++-
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
index 87e1004b606d..b4041d0566a9 100644
--- a/fs/nilfs2/ioctl.c
+++ b/fs/nilfs2/ioctl.c
@@ -1114,7 +1114,14 @@ static int nilfs_ioctl_set_alloc_range(struct inode *inode, void __user *argp)
 
 	minseg = range[0] + segbytes - 1;
 	do_div(minseg, segbytes);
+
+	if (range[1] < 4096)
+		goto out;
+
 	maxseg = NILFS_SB2_OFFSET_BYTES(range[1]);
+	if (maxseg < segbytes)
+		goto out;
+
 	do_div(maxseg, segbytes);
 	maxseg--;
 
diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index 6edb6e0dd61f..1422b8ba24ed 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -408,6 +408,15 @@ int nilfs_resize_fs(struct super_block *sb, __u64 newsize)
 	if (newsize > devsize)
 		goto out;
 
+	/*
+	 * Prevent underflow in second superblock position calculation.
+	 * The exact minimum size check is done in nilfs_sufile_resize().
+	 */
+	if (newsize < 4096) {
+		ret = -ENOSPC;
+		goto out;
+	}
+
 	/*
 	 * Write lock is required to protect some functions depending
 	 * on the number of segments, the number of reserved segments,
diff --git a/fs/nilfs2/the_nilfs.c b/fs/nilfs2/the_nilfs.c
index 2064e6473d30..3a4c9c150cbf 100644
--- a/fs/nilfs2/the_nilfs.c
+++ b/fs/nilfs2/the_nilfs.c
@@ -544,9 +544,15 @@ static int nilfs_load_super_block(struct the_nilfs *nilfs,
 {
 	struct nilfs_super_block **sbp = nilfs->ns_sbp;
 	struct buffer_head **sbh = nilfs->ns_sbh;
-	u64 sb2off = NILFS_SB2_OFFSET_BYTES(bdev_nr_bytes(nilfs->ns_bdev));
+	u64 sb2off, devsize = bdev_nr_bytes(nilfs->ns_bdev);
 	int valid[2], swp = 0;
 
+	if (devsize < NILFS_SEG_MIN_BLOCKS * NILFS_MIN_BLOCK_SIZE + 4096) {
+		nilfs_err(sb, "device size too small");
+		return -EINVAL;
+	}
+	sb2off = NILFS_SB2_OFFSET_BYTES(devsize);
+
 	sbp[0] = nilfs_read_super_block(sb, NILFS_SB_OFFSET_BYTES, blocksize,
 					&sbh[0]);
 	sbp[1] = nilfs_read_super_block(sb, sb2off, blocksize, &sbh[1]);
-- 
2.34.1

