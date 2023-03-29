Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7966CD061
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 04:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjC2CxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 22:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjC2CxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 22:53:23 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205A9213B;
        Tue, 28 Mar 2023 19:53:22 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PmWMJ4ztrz4f3jMF;
        Wed, 29 Mar 2023 10:53:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgC3YiAcqCNk4P4AFw--.7921S4;
        Wed, 29 Mar 2023 10:53:18 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     djwong@kernel.org, linux-xfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, yebin10@huawei.com
Subject: [PATCH v3] xfs: fix BUG_ON in xfs_getbmap()
Date:   Wed, 29 Mar 2023 10:52:58 +0800
Message-Id: <20230329025258.1074860-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgC3YiAcqCNk4P4AFw--.7921S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGFy5Gw1UurWxJr43ZFWUurg_yoW5KF1fpr
        Z3Gw1UGr4vgr1UZr1DJw1UKw1UWw4xAF4UAr1xXr4rZ3WUCr17tr18KFWFvry7JrW8Xry7
        Jr4Dtw18t345JaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
        c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
        CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
        MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJV
        Cq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBI
        daVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

There's issue as follows:
XFS: Assertion failed: (bmv->bmv_iflags & BMV_IF_DELALLOC) != 0, file: fs/xfs/xfs_bmap_util.c, line: 329
------------[ cut here ]------------
kernel BUG at fs/xfs/xfs_message.c:102!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 14612 Comm: xfs_io Not tainted 6.3.0-rc2-next-20230315-00006-g2729d23ddb3b-dirty #422
RIP: 0010:assfail+0x96/0xa0
RSP: 0018:ffffc9000fa178c0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffff888179a18000
RDX: 0000000000000000 RSI: ffff888179a18000 RDI: 0000000000000002
RBP: 0000000000000000 R08: ffffffff8321aab6 R09: 0000000000000000
R10: 0000000000000001 R11: ffffed1105f85139 R12: ffffffff8aacc4c0
R13: 0000000000000149 R14: ffff888269f58000 R15: 000000000000000c
FS:  00007f42f27a4740(0000) GS:ffff88882fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000b92388 CR3: 000000024f006000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 xfs_getbmap+0x1a5b/0x1e40
 xfs_ioc_getbmap+0x1fd/0x5b0
 xfs_file_ioctl+0x2cb/0x1d50
 __x64_sys_ioctl+0x197/0x210
 do_syscall_64+0x39/0xb0
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Above issue may happen as follows:
         ThreadA                       ThreadB
do_shared_fault
 __do_fault
  xfs_filemap_fault
   __xfs_filemap_fault
    filemap_fault
                             xfs_ioc_getbmap -> Without BMV_IF_DELALLOC flag
			      xfs_getbmap
			       xfs_ilock(ip, XFS_IOLOCK_SHARED);
			       filemap_write_and_wait
 do_page_mkwrite
  xfs_filemap_page_mkwrite
   __xfs_filemap_fault
    xfs_ilock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
    iomap_page_mkwrite
     ...
     xfs_buffered_write_iomap_begin
      xfs_bmapi_reserve_delalloc -> Allocate delay extent
                              xfs_ilock_data_map_shared(ip)
	                      xfs_getbmap_report_one
			       ASSERT((bmv->bmv_iflags & BMV_IF_DELALLOC) != 0)
	                        -> trigger BUG_ON

As xfs_filemap_page_mkwrite() only hold XFS_MMAPLOCK_SHARED lock, there's
small window mkwrite can produce delay extent after file write in xfs_getbmap().
To solve above issue, just skip delalloc extents.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/xfs/xfs_bmap_util.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index a09dd2606479..f032d3a4b727 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -314,15 +314,13 @@ xfs_getbmap_report_one(
 	if (isnullstartblock(got->br_startblock) ||
 	    got->br_startblock == DELAYSTARTBLOCK) {
 		/*
-		 * Delalloc extents that start beyond EOF can occur due to
-		 * speculative EOF allocation when the delalloc extent is larger
-		 * than the largest freespace extent at conversion time.  These
-		 * extents cannot be converted by data writeback, so can exist
-		 * here even if we are not supposed to be finding delalloc
-		 * extents.
+		 * Take the flush completion as being a point-in-time snapshot
+		 * where there are no delalloc extents, and if any new ones
+		 * have been created racily, just skip them as being 'after'
+		 * the flush and so don't get reported.
 		 */
-		if (got->br_startoff < XFS_B_TO_FSB(ip->i_mount, XFS_ISIZE(ip)))
-			ASSERT((bmv->bmv_iflags & BMV_IF_DELALLOC) != 0);
+		if (!(bmv->bmv_iflags & BMV_IF_DELALLOC))
+			return 0;
 
 		p->bmv_oflags |= BMV_OF_DELALLOC;
 		p->bmv_block = -2;
-- 
2.31.1

