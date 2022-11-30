Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A01363D2AB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235190AbiK3KCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbiK3KCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:02:01 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9424E2B185
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:01:59 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NMZQC0LjWzqSpt;
        Wed, 30 Nov 2022 17:57:55 +0800 (CST)
Received: from dggpemm500015.china.huawei.com (7.185.36.181) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 30 Nov 2022 18:01:57 +0800
Received: from [10.174.177.133] (10.174.177.133) by
 dggpemm500015.china.huawei.com (7.185.36.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 30 Nov 2022 18:01:56 +0800
Subject: Re: [syzbot] INFO: task hung in gfs2_gl_hash_clear (3)
To:     syzbot <syzbot+ed7d0f71a89e28557a77@syzkaller.appspotmail.com>,
        <brauner@kernel.org>, <broonie@kernel.org>,
        <catalin.marinas@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <madvenka@linux.microsoft.com>,
        <scott@os.amperecomputing.com>, <syzkaller-bugs@googlegroups.com>,
        <will@kernel.org>, "liwei (GF)" <liwei391@huawei.com>,
        <bobo.shaobowang@huawei.com>
References: <000000000000d482ba05ee97d4e3@google.com>
From:   "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
Message-ID: <cd4158d0-bfc0-099c-c914-4889eaf95036@huawei.com>
Date:   Wed, 30 Nov 2022 18:01:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <000000000000d482ba05ee97d4e3@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.133]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500015.china.huawei.com (7.185.36.181)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix missing call gfs2_make_fs_ro() int gfs2_put_super()

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

b7b275e60bcd

--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -584,9 +584,7 @@ static void gfs2_put_super(struct super_block *sb)
         }
         spin_unlock(&sdp->sd_jindex_spin);

-       if (!sb_rdonly(sb)) {
-               gfs2_make_fs_ro(sdp);
-       }
+       gfs2_make_fs_ro(sdp);
         WARN_ON(gfs2_withdrawing(sdp));

         /*  At this point, we're through modifying the disk  */
--

在 2022/11/29 16:32, syzbot 写道:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    6d464646530f Merge branch 'for-next/core' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=167aebbb880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=54b747d981acc7b7
> dashboard link: https://syzkaller.appspot.com/bug?extid=ed7d0f71a89e28557a77
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16467353880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=168c3d03880000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/d75f5f77b3a3/disk-6d464646.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/9382f86e4d95/vmlinux-6d464646.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/cf2b5f0d51dd/Image-6d464646.gz.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/04ef22130add/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ed7d0f71a89e28557a77@syzkaller.appspotmail.com
> 
> INFO: task syz-executor888:3126 blocked for more than 143 seconds.
>        Not tainted 6.1.0-rc6-syzkaller-32662-g6d464646530f #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor888 state:D stack:0     pid:3126  ppid:3124   flags:0x00000000
> Call trace:
>   __switch_to+0x180/0x298 arch/arm64/kernel/process.c:553
>   context_switch kernel/sched/core.c:5209 [inline]
>   __schedule+0x408/0x594 kernel/sched/core.c:6521
>   schedule+0x64/0xa4 kernel/sched/core.c:6597
>   schedule_timeout+0x108/0x1b4 kernel/time/timer.c:1935
>   gfs2_gl_hash_clear+0xd4/0x1b0 fs/gfs2/glock.c:2263
>   gfs2_put_super+0x318/0x390 fs/gfs2/super.c:620
>   generic_shutdown_super+0x94/0x198 fs/super.c:492
>   kill_block_super+0x30/0x78 fs/super.c:1428
>   gfs2_kill_sb+0x68/0x78
>   deactivate_locked_super+0x70/0xe8 fs/super.c:332
>   deactivate_super+0xd0/0xd4 fs/super.c:363
>   cleanup_mnt+0x184/0x1c0 fs/namespace.c:1186
>   __cleanup_mnt+0x20/0x30 fs/namespace.c:1193
>   task_work_run+0x100/0x148 kernel/task_work.c:179
>   resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
>   do_notify_resume+0x174/0x1f0 arch/arm64/kernel/signal.c:1127
>   prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
>   exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
>   el0_svc+0x9c/0x150 arch/arm64/kernel/entry-common.c:638
>   el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
>   el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
> 
> Showing all locks held in the system:
> 1 lock held by rcu_tasks_kthre/11:
>   #0: ffff80000d4a4768 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x3c/0x450 kernel/rcu/tasks.h:507
> 1 lock held by rcu_tasks_trace/12:
>   #0: ffff80000d4a4db8 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x3c/0x450 kernel/rcu/tasks.h:507
> 1 lock held by khungtaskd/27:
>   #0: ffff80000d4a4640 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x4/0x48 include/linux/rcupdate.h:303
> 2 locks held by getty/2759:
>   #0: ffff0000c7d7e098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x28/0x58 drivers/tty/tty_ldisc.c:244
>   #1: ffff80000f6be2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x19c/0x89c drivers/tty/n_tty.c:2177
> 1 lock held by syz-executor888/3126:
>   #0: ffff0000cae680e0 (&type->s_umount_key#41){+.+.}-{3:3}, at: deactivate_super+0xc8/0xd4 fs/super.c:362
> 
> =============================================
> 
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
> 
> .
> 
