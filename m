Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF86D713192
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 03:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241582AbjE0BmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 21:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjE0BmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 21:42:01 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F160AF3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 18:41:58 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QSktX5hpMz18Ldx;
        Sat, 27 May 2023 09:37:24 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sat, 27 May
 2023 09:41:57 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <jack@suse.com>, <linux-kernel@vger.kernel.org>
CC:     <yebin10@huawei.com>,
        <syzbot+e633c79ceaecbf479854@syzkaller.appspotmail.com>
Subject: [PATCH 1/2] quota: fix null-ptr-deref in ext4_acquire_dquot()
Date:   Sat, 27 May 2023 09:40:17 +0800
Message-ID: <20230527014018.47396-2-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230527014018.47396-1-yebin10@huawei.com>
References: <20230527014018.47396-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

Syzbot found the following issue:
Unable to handle kernel paging request at virtual address dfff800000000005
KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
[dfff800000000005] address between user and kernel address ranges
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 6080 Comm: syz-executor747 Not tainted 6.3.0-rc7-syzkaller-g14f8db1c0f9a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : ext4_acquire_dquot+0x1d4/0x398 fs/ext4/super.c:6766
lr : dquot_to_inode fs/ext4/super.c:6740 [inline]
lr : ext4_acquire_dquot+0x1ac/0x398 fs/ext4/super.c:6766
sp : ffff80001eb27280
x29: ffff80001eb27280 x28: 1fffe0001c3c01fc x27: ffff800015d705b0
x26: ffff0000dd93c000 x25: ffff0000dd93e000 x24: 1fffe0001c3c021c
x23: dfff800000000000 x22: 0000000000000049 x21: 0000000000000028
x20: 0000000000000000 x19: ffff0000e1e00fc0 x18: ffff0001b426cca8
x17: 0000000000000000 x16: ffff8000089669b0 x15: 0000000000000001
x14: 1ffff00002bae0b0 x13: dfff800000000000 x12: 0000000000000001
x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
x8 : 0000000000000005 x7 : ffff800008c11f68 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff800012441b4c
x2 : 0000000000000001 x1 : 0000000000000001 x0 : 0000000000000003
Call trace:
 ext4_acquire_dquot+0x1d4/0x398 fs/ext4/super.c:6766
 dqget+0x844/0xc48 fs/quota/dquot.c:914
 __dquot_initialize+0x2cc/0xb54 fs/quota/dquot.c:1492
 dquot_initialize fs/quota/dquot.c:1550 [inline]
 dquot_file_open+0x90/0xc8 fs/quota/dquot.c:2181
 ext4_file_open+0x230/0x590 fs/ext4/file.c:903
 do_dentry_open+0x724/0xf90 fs/open.c:920
 vfs_open+0x7c/0x90 fs/open.c:1051
 do_open fs/namei.c:3560 [inline]
 path_openat+0x1f2c/0x27f8 fs/namei.c:3715
 do_filp_open+0x1bc/0x3cc fs/namei.c:3742
 do_sys_openat2+0x128/0x3d8 fs/open.c:1348
 do_sys_open fs/open.c:1364 [inline]
 __do_sys_openat fs/open.c:1380 [inline]
 __se_sys_openat fs/open.c:1375 [inline]
 __arm64_sys_openat+0x1f0/0x240 fs/open.c:1375
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
 el0_svc+0x4c/0x15c arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
Code: 97e8a7df f94002a8 9100a115 d343fea8 (38776908)
---[ end trace 0000000000000000 ]---

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
						    if (!test_bit(DQ_ACTIVE_B, &dquot->dq_flags))

			  __dquot_initialize
			   __dquot_initialize
			    dqget
			     if (!test_bit(DQ_ACTIVE_B, &dquot->dq_flags))
	                       ext4_acquire_dquot -> Return error
		       if (ret < 0)
	                 vfs_cleanup_quota_inode
			  dqopt->files[type] = NULL;

			                              ext4_acquire_dquot
						       -->dquot_to_inode(dquot) is NULL

To solve above issue, if quota has been loaded, there's unneed to cleaup quota
inode if dquot_load_quota_sb() return failed when do dquot_resume();

Reported-by: syzbot+e633c79ceaecbf479854@syzkaller.appspotmail.com
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/quota/dquot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index ffd40dc3e4e9..4b913faa48ec 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2476,7 +2476,7 @@ int dquot_resume(struct super_block *sb, int type)
 		flags = dquot_generic_flag(flags, cnt);
 		ret = dquot_load_quota_sb(sb, cnt, dqopt->info[cnt].dqi_fmt_id,
 					  flags);
-		if (ret < 0)
+		if (ret < 0 && !sb_has_quota_loaded(sb, cnt))
 			vfs_cleanup_quota_inode(sb, cnt);
 	}
 
-- 
2.31.1

