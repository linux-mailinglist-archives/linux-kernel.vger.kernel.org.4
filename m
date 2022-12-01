Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A9163EFEE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbiLALwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiLALwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:52:43 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712A9C38
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 03:52:33 -0800 (PST)
Received: from dggpemm500015.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NNDr26w54zJp0S;
        Thu,  1 Dec 2022 19:49:06 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500015.china.huawei.com
 (7.185.36.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 1 Dec
 2022 19:52:31 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
CC:     <liwei391@huawei.com>, <rpeterso@redhat.com>,
        <agruenba@redhat.com>, <cluster-devel@redhat.com>,
        <syzkaller-bugs@googlegroups.com>, <linux-kernel@vger.kernel.org>,
        <bobo.shaobowang@huawei.com>
Subject: [RFC PATCH] gfs2: Fix missing cleanup quota in gfs2_put_super()
Date:   Thu, 1 Dec 2022 19:50:32 +0800
Message-ID: <20221201115032.3540859-1-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500015.china.huawei.com (7.185.36.181)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has reported an interesting issue:

INFO: task syz-executor888:3126 blocked for more than 143 seconds.
      Not tainted 6.1.0-rc6-syzkaller-32662-g6d464646530f #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor888 state:D stack:0     pid:3126  ppid:3124   flags:0x00000000
Call trace:
 __switch_to+0x180/0x298 arch/arm64/kernel/process.c:553
 context_switch kernel/sched/core.c:5209 [inline]
 __schedule+0x408/0x594 kernel/sched/core.c:6521
 schedule+0x64/0xa4 kernel/sched/core.c:6597
 schedule_timeout+0x108/0x1b4 kernel/time/timer.c:1935
 gfs2_gl_hash_clear+0xd4/0x1b0 fs/gfs2/glock.c:2263
 gfs2_put_super+0x318/0x390 fs/gfs2/super.c:620
 generic_shutdown_super+0x94/0x198 fs/super.c:492
 kill_block_super+0x30/0x78 fs/super.c:1428
 gfs2_kill_sb+0x68/0x78
 deactivate_locked_super+0x70/0xe8 fs/super.c:332
 deactivate_super+0xd0/0xd4 fs/super.c:363
 cleanup_mnt+0x184/0x1c0 fs/namespace.c:1186
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1193
 task_work_run+0x100/0x148 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x174/0x1f0 arch/arm64/kernel/signal.c:1127
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0x9c/0x150 arch/arm64/kernel/entry-common.c:638
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/11:
 #0: ffff80000d4a4768 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x3c/0x450 kernel/rcu/tasks.h:507
1 lock held by rcu_tasks_trace/12:
 #0: ffff80000d4a4db8 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x3c/0x450 kernel/rcu/tasks.h:507
1 lock held by khungtaskd/27:
 #0: ffff80000d4a4640 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x4/0x48 include/linux/rcupdate.h:303
2 locks held by getty/2759:
 #0: ffff0000c7d7e098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x28/0x58 drivers/tty/tty_ldisc.c:244
 #1: ffff80000f6be2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x19c/0x89c drivers/tty/n_tty.c:2177
1 lock held by syz-executor888/3126:
 #0: ffff0000cae680e0 (&type->s_umount_key#41){+.+.}-{3:3}, at: deactivate_super+0xc8/0xd4 fs/super.c:362

=============================================

One task blocked after executing gfs2_gl_hash_clear(), it looks
like go to sleep for waiting the condition (&sdp->sd_glock_disposal == 0),
this field sd_glock_disposal is used to count the getting times
that calling gfs2_glock_get() success, In most cases, when we operate
the mount interface, we will finally call this function:

                              do_mount()
                              path_mount()
                              vfs_get_tree()
                              gfs2_get_tree()
                              get_tree_bdev()
                              gfs2_fill_super()
                     ________ init_inodes()_____________
                    V                                   V
       gfs2_lookup_simple()                         gfs2_rindex_update()
       gfs2_lookupi()                               gfs2_ri_update()
       gfs2_dir_search()                         -> read_rindex_entry() //*gfs2_rgrpd->rd_gl
    -> gfs2_inode_lookup() //*gfs2_inode->i_gl  |__ gfs2_glock_get()
   |__gfs2_glock_get()

Correspondingly, release this glock's reference and decrease
sdp->sd_glock_disposal through this path when umount:

                              cleanup_mnt()
                              deactivate_super()
                              deactivate_locked_super()
                              gfs2_kill_sb()
                              kill_block_super()
                              generic_shutdown_super()
          _gfs2_rgrpd->rd_gl__gfs2_put_super()__gfs2_inode->i_gl__
         V                                                        V
	gfs2_clear_rgrpd()                           gfs2_put_super()
	gfs2_glock_put()                             iput()
        gfs2_glock_free()                            evict()
                                                     gfs2_evict_inode()
                                                     gfs2_glock_put_eventually()
                                                     gfs2_glock_put()
                                                     gfs2_glock_free()

But if calling reconfigure_super() from sysfs between mount and umount,
this path will also take the glock lock and increase sdp->sd_glock_disposal
as it also call gfs2_glock_get():

   reconfigure_super()
    gfs2_reconfigure()
      gfs2_make_fs_rw() //remount filesystem read-write
       gfs2_quota_init()
     -> qd_alloc()      //*gfs2_quota_data->qd_gl
    |___ gfs2_glock_get()

This relies on gfs2_quota_cleanup() that is eventually called by
gfs2_make_fs_ro() to clean up but unfortunately the file system
has not been remounted at this time, the condition (!sb_rdonly(sb))
is false and gfs2_make_fs_ro() can not be called, ultimately makes
sdp->sd_glock_disposal never be 0.

This add calling gfs2_quota_cleanup() when this filesystem remains
readOnly, in this case we don't need sync quota or other operation
otherwise the filesystem was really remounted.

But this modification will trigger this warning:

   WARNING: CPU: 7 PID: 2595 at include/linux/backing-dev.h:246 __folio_mark_dirty+0x559/0x7b0

We can filter this warning with adding a parameter as it doesn't
really make sense here.

Fixes: 9e6e0a128bca ("GFS2: Merge mount.c and ops_super.c into super.c")
Reported-by: syzbot+ed7d0f71a89e28557a77@syzkaller.appspotmail.com
Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---
 fs/gfs2/super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index b018957a1bb2..9a3c6da8db55 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -586,7 +586,10 @@ static void gfs2_put_super(struct super_block *sb)
 
 	if (!sb_rdonly(sb)) {
 		gfs2_make_fs_ro(sdp);
+	} else {
+		gfs2_quota_cleanup(sdp);
 	}
+
 	WARN_ON(gfs2_withdrawing(sdp));
 
 	/*  At this point, we're through modifying the disk  */
-- 
2.25.1

