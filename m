Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547C168B7AA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 09:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjBFIrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 03:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjBFIrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 03:47:08 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA3311178
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 00:46:57 -0800 (PST)
Received: from kwepemm600015.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4P9KZQ2YnGznW3B;
        Mon,  6 Feb 2023 16:44:46 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemm600015.china.huawei.com
 (7.193.23.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 6 Feb
 2023 16:46:51 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <rpeterso@redhat.com>, <agruenba@redhat.com>
CC:     <cluster-devel@redhat.com>, <linux-kernel@vger.kernel.org>,
        <chenxiaosong2@huawei.com>
Subject: [PATCH 2/2] gfs2: fix sleep from invalid context bug in gfs2_glock_wait()
Date:   Mon, 6 Feb 2023 17:55:43 +0800
Message-ID: <20230206095543.539186-3-chenxiaosong2@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230206095543.539186-1-chenxiaosong2@huawei.com>
References: <20230206095543.539186-1-chenxiaosong2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzkaller reported BUG as follows:

  BUG: sleeping function called from invalid context at
       fs/gfs2/glock.c:1316
  Call Trace:
   __dump_stack lib/dump_stack.c:88 [inline]
   dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
   __might_resched+0x4e9/0x6b0 kernel/sched/core.c:10036
   gfs2_glock_wait+0x52/0x2a0 fs/gfs2/glock.c:1316
   gfs2_glock_nq_init fs/gfs2/glock.h:262 [inline]
   gfs2_freeze_lock+0x5f/0xc0 fs/gfs2/util.c:107
   signal_our_withdraw fs/gfs2/util.c:160 [inline]
   gfs2_withdraw+0x5cc/0x1540 fs/gfs2/util.c:351
   gfs2_ail1_empty+0x8c9/0x950 fs/gfs2/log.c:368
   gfs2_flush_revokes+0x59/0x80 fs/gfs2/log.c:806
   revoke_lo_before_commit+0x2b/0xcf0 fs/gfs2/lops.c:869
   lops_before_commit fs/gfs2/lops.h:40 [inline]
   gfs2_log_flush+0xc8e/0x26a0 fs/gfs2/log.c:1093
   do_sync+0xa3c/0xc80 fs/gfs2/quota.c:975
   gfs2_quota_sync+0x3da/0x8b0 fs/gfs2/quota.c:1318
   gfs2_sync_fs+0x49/0xb0 fs/gfs2/super.c:650
   sync_filesystem+0xe8/0x220 fs/sync.c:56
   generic_shutdown_super+0x6b/0x310 fs/super.c:474
   kill_block_super+0x79/0xd0 fs/super.c:1386
   deactivate_locked_super+0xa7/0xf0 fs/super.c:332
   cleanup_mnt+0x494/0x520 fs/namespace.c:1291
   task_work_run+0x243/0x300 kernel/task_work.c:179
   exit_task_work include/linux/task_work.h:38 [inline]
   do_exit+0x644/0x2150 kernel/exit.c:867
   do_group_exit+0x1fd/0x2b0 kernel/exit.c:1012
   __do_sys_exit_group kernel/exit.c:1023 [inline]
   __se_sys_exit_group kernel/exit.c:1021 [inline]
   __x64_sys_exit_group+0x3b/0x40 kernel/exit.c:1021
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x63/0xcd

Fix this by calling gfs2_withdraw() outside of the spinlock context.

Link: https://syzkaller.appspot.com/bug?id=7bd882c47078df844b5a82550559d69482d5c3c1
Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
---
 fs/gfs2/log.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index c62c914702ba..945540c0a3cf 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -825,8 +825,10 @@ void gfs2_flush_revokes(struct gfs2_sbd *sdp)
 	unsigned int max_revokes = atomic_read(&sdp->sd_log_revokes_available);
 
 	gfs2_log_lock(sdp);
-	gfs2_ail1_empty(sdp, max_revokes);
+	__gfs2_ail1_empty(sdp, max_revokes);
 	gfs2_log_unlock(sdp);
+
+	gfs2_ail1_withdraw(sdp);
 }
 
 /**
-- 
2.31.1

