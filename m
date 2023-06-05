Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F93722873
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbjFEOLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234354AbjFEOLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:11:35 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A95E75
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 07:10:06 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QZb2d1hKtz18Lqp;
        Mon,  5 Jun 2023 22:04:41 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 5 Jun
 2023 22:09:26 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <jack@suse.com>, <linux-kernel@vger.kernel.org>
CC:     <yebin10@huawei.com>
Subject: [PATCH v2 2/2] quota: fix warning in dqgrab()
Date:   Mon, 5 Jun 2023 22:07:31 +0800
Message-ID: <20230605140731.2427629-3-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230605140731.2427629-1-yebin10@huawei.com>
References: <20230605140731.2427629-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's issue as follows when do fault injection:
WARNING: CPU: 1 PID: 14870 at include/linux/quotaops.h:51 dquot_disable+0x13b7/0x18c0
Modules linked in:
CPU: 1 PID: 14870 Comm: fsconfig Not tainted 6.3.0-next-20230505-00006-g5107a9c821af-dirty #541
RIP: 0010:dquot_disable+0x13b7/0x18c0
RSP: 0018:ffffc9000acc79e0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff88825e41b980
RDX: 0000000000000000 RSI: ffff88825e41b980 RDI: 0000000000000002
RBP: ffff888179f68000 R08: ffffffff82087ca7 R09: 0000000000000000
R10: 0000000000000001 R11: ffffed102f3ed026 R12: ffff888179f68130
R13: ffff888179f68110 R14: dffffc0000000000 R15: ffff888179f68118
FS:  00007f450a073740(0000) GS:ffff88882fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe96f2efd8 CR3: 000000025c8ad000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 dquot_load_quota_sb+0xd53/0x1060
 dquot_resume+0x172/0x230
 ext4_reconfigure+0x1dc6/0x27b0
 reconfigure_super+0x515/0xa90
 __x64_sys_fsconfig+0xb19/0xd20
 do_syscall_64+0x39/0xb0
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Above issue may happens as follows:
ProcessA              ProcessB                    ProcessC
sys_fsconfig
  vfs_fsconfig_locked
   reconfigure_super
     ext4_remount
      dquot_suspend -> suspend all type quota

                 sys_fsconfig
                  vfs_fsconfig_locked
                    reconfigure_super
                     ext4_remount
                      dquot_resume
                       ret = dquot_load_quota_sb
                        add_dquot_ref
                                           do_open  -> open file O_RDWR
                                            vfs_open
                                             do_dentry_open
                                              get_write_access
                                               atomic_inc_unless_negative(&inode->i_writecount)
                                              ext4_file_open
                                               dquot_file_open
                                                dquot_initialize
                                                  __dquot_initialize
                                                   dqget
						    atomic_inc(&dquot->dq_count);

                          __dquot_initialize
                           __dquot_initialize
                            dqget
                             if (!test_bit(DQ_ACTIVE_B, &dquot->dq_flags))
                               ext4_acquire_dquot
			        -> Return error DQ_ACTIVE_B flag isn't set
                         dquot_disable
			  invalidate_dquots
			   if (atomic_read(&dquot->dq_count))
	                    dqgrab
			     WARN_ON_ONCE(!test_bit(DQ_ACTIVE_B, &dquot->dq_flags))
	                      -> Trigger warning

In the above scenario, 'dquot->dq_flags' has no DQ_ACTIVE_B is normal when
dqgrab().
To solve above issue just replace the dqgrab() use in invalidate_dquots() with
atomic_inc(&dquot->dq_count).

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/quota/dquot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 6beceed34e08..e3e4f4047657 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -555,7 +555,7 @@ static void invalidate_dquots(struct super_block *sb, int type)
 			continue;
 		/* Wait for dquot users */
 		if (atomic_read(&dquot->dq_count)) {
-			dqgrab(dquot);
+			atomic_inc(&dquot->dq_count);
 			spin_unlock(&dq_list_lock);
 			/*
 			 * Once dqput() wakes us up, we know it's time to free
-- 
2.31.1

