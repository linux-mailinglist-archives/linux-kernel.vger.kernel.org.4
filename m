Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEC564211B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 02:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbiLEBgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 20:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbiLEBgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 20:36:07 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A83E081
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 17:36:06 -0800 (PST)
Received: from dggpemm500015.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NQQy51B3yzqSr5;
        Mon,  5 Dec 2022 09:31:57 +0800 (CST)
Received: from [10.174.177.133] (10.174.177.133) by
 dggpemm500015.china.huawei.com (7.185.36.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Dec 2022 09:36:04 +0800
Subject: Re: [RFC PATCH] gfs2: Fix missing cleanup quota in gfs2_put_super()
To:     Andreas Gruenbacher <agruenba@redhat.com>
CC:     <liwei391@huawei.com>, <rpeterso@redhat.com>,
        <cluster-devel@redhat.com>, <syzkaller-bugs@googlegroups.com>,
        <linux-kernel@vger.kernel.org>
References: <20221201115032.3540859-1-bobo.shaobowang@huawei.com>
 <5c66dbe3-5701-ba42-7933-73a31c2dc891@huawei.com>
 <CAHc6FU7b3geKS7sjt5ehiaenALemWtaGTdWJvNt2JftRFuLG_Q@mail.gmail.com>
From:   "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
Message-ID: <7ca13049-c828-9506-c3a6-cb4a7dbb8bd4@huawei.com>
Date:   Mon, 5 Dec 2022 09:36:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAHc6FU7b3geKS7sjt5ehiaenALemWtaGTdWJvNt2JftRFuLG_Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.133]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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



在 2022/12/3 21:15, Andreas Gruenbacher 写道:
> Hello,
> 
> thank you for this bug report.
> 
> On Sat, Dec 3, 2022 at 8:28 AM Wangshaobo (bobo)
> <bobo.shaobowang@huawei.com> wrote:
>> 在 2022/12/1 19:50, Wang ShaoBo 写道:
>>> syzbot has reported an interesting issue:
>>>
>>> INFO: task syz-executor888:3126 blocked for more than 143 seconds.
>>>         Not tainted 6.1.0-rc6-syzkaller-32662-g6d464646530f #0
>>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>> task:syz-executor888 state:D stack:0     pid:3126  ppid:3124   flags:0x00000000
>>> Call trace:
>>>    __switch_to+0x180/0x298 arch/arm64/kernel/process.c:553
>>>    context_switch kernel/sched/core.c:5209 [inline]
>>>    __schedule+0x408/0x594 kernel/sched/core.c:6521
>>>    schedule+0x64/0xa4 kernel/sched/core.c:6597
>>>    schedule_timeout+0x108/0x1b4 kernel/time/timer.c:1935
>>>    gfs2_gl_hash_clear+0xd4/0x1b0 fs/gfs2/glock.c:2263
>>>    gfs2_put_super+0x318/0x390 fs/gfs2/super.c:620
>>>    generic_shutdown_super+0x94/0x198 fs/super.c:492
>>>    kill_block_super+0x30/0x78 fs/super.c:1428
>>>    gfs2_kill_sb+0x68/0x78
>>>    deactivate_locked_super+0x70/0xe8 fs/super.c:332
>>>    deactivate_super+0xd0/0xd4 fs/super.c:363
>>>    cleanup_mnt+0x184/0x1c0 fs/namespace.c:1186
>>>    __cleanup_mnt+0x20/0x30 fs/namespace.c:1193
>>>    task_work_run+0x100/0x148 kernel/task_work.c:179
>>>    resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
>>>    do_notify_resume+0x174/0x1f0 arch/arm64/kernel/signal.c:1127
>>>    prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
>>>    exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
>>>    el0_svc+0x9c/0x150 arch/arm64/kernel/entry-common.c:638
>>>    el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
>>>    el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
>>>
>>> Showing all locks held in the system:
>>> 1 lock held by rcu_tasks_kthre/11:
>>>    #0: ffff80000d4a4768 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x3c/0x450 kernel/rcu/tasks.h:507
>>> 1 lock held by rcu_tasks_trace/12:
>>>    #0: ffff80000d4a4db8 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x3c/0x450 kernel/rcu/tasks.h:507
>>> 1 lock held by khungtaskd/27:
>>>    #0: ffff80000d4a4640 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x4/0x48 include/linux/rcupdate.h:303
>>> 2 locks held by getty/2759:
>>>    #0: ffff0000c7d7e098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x28/0x58 drivers/tty/tty_ldisc.c:244
>>>    #1: ffff80000f6be2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x19c/0x89c drivers/tty/n_tty.c:2177
>>> 1 lock held by syz-executor888/3126:
>>>    #0: ffff0000cae680e0 (&type->s_umount_key#41){+.+.}-{3:3}, at: deactivate_super+0xc8/0xd4 fs/super.c:362
>>>
>>> =============================================
>>>
>>> One task blocked after executing gfs2_gl_hash_clear(), it looks
>>> like go to sleep for waiting the condition (&sdp->sd_glock_disposal == 0),
>>> this field sd_glock_disposal is used to count the getting times
>>> that calling gfs2_glock_get() success, In most cases, when we operate
>>> the mount interface, we will finally call this function:
>>>
>>>                                 do_mount()
>>>                                 path_mount()
>>>                                 vfs_get_tree()
>>>                                 gfs2_get_tree()
>>>                                 get_tree_bdev()
>>>                                 gfs2_fill_super()
>>>                        ________ init_inodes()_____________
>>>                       V                                   V
>>>          gfs2_lookup_simple()                         gfs2_rindex_update()
>>>          gfs2_lookupi()                               gfs2_ri_update()
>>>          gfs2_dir_search()                         -> read_rindex_entry() //*gfs2_rgrpd->rd_gl
>>>       -> gfs2_inode_lookup() //*gfs2_inode->i_gl  |__ gfs2_glock_get()
>>>      |__gfs2_glock_get()
>>>
>>> Correspondingly, release this glock's reference and decrease
>>> sdp->sd_glock_disposal through this path when umount:
>>>
>>>                                 cleanup_mnt()
>>>                                 deactivate_super()
>>>                                 deactivate_locked_super()
>>>                                 gfs2_kill_sb()
>>>                                 kill_block_super()
>>>                                 generic_shutdown_super()
>>>             _gfs2_rgrpd->rd_gl__gfs2_put_super()__gfs2_inode->i_gl__
>>>            V                                                        V
>>>        gfs2_clear_rgrpd()                           gfs2_put_super()
>>>        gfs2_glock_put()                             iput()
>>>           gfs2_glock_free()                            evict()
>>>                                                        gfs2_evict_inode()
>>>                                                        gfs2_glock_put_eventually()
>>>                                                        gfs2_glock_put()
>>>                                                        gfs2_glock_free()
>>>
>>> But if calling reconfigure_super() from sysfs between mount and umount,
> 
> How are you doing that?
> 
I tested multiple times and trace corresponding path, and analyzed the 
trigger mechanism, it looks a bit complicated - -.

>>> this path will also take the glock lock and increase sdp->sd_glock_disposal
>>> as it also call gfs2_glock_get():
>>>
>>>      reconfigure_super()
>>>       gfs2_reconfigure()
>>>         gfs2_make_fs_rw() //remount filesystem read-write
>>>          gfs2_quota_init()
>>>        -> qd_alloc()      //*gfs2_quota_data->qd_gl
>>>       |___ gfs2_glock_get()
>>>
>>> This relies on gfs2_quota_cleanup() that is eventually called by
>>> gfs2_make_fs_ro() to clean up but unfortunately the file system
>>> has not been remounted at this time, the condition (!sb_rdonly(sb))
>>> is false and gfs2_make_fs_ro() can not be called, ultimately makes
>>> sdp->sd_glock_disposal never be 0.
>>>
>>> This add calling gfs2_quota_cleanup() when this filesystem remains
>>> readOnly, in this case we don't need sync quota or other operation
>>> otherwise the filesystem was really remounted.
>>>
>>> But this modification will trigger this warning:
>>>
>>>      WARNING: CPU: 7 PID: 2595 at include/linux/backing-dev.h:246 __folio_mark_dirty+0x559/0x7b0
>> I paste wrong, the warning is:
>> gfs2: fsid=mounts.0: warning: assertion "!qd->qd_change" failed at
>> function = gfs2_quota_cleanup, file = fs/gfs2/quota.c, line = 1474
> 
> Thanks, this is making more sense now.
> 
why it makes more sense now ?
>> qd->qd_change has been changed in gfs2_quota_init(), but it looks
>> we don't need to do anything before remounting the file system as
>> read-write.
>>>
>>> We can filter this warning with adding a parameter as it doesn't
>>> really make sense here.
>>>
>>> Fixes: 9e6e0a128bca ("GFS2: Merge mount.c and ops_super.c into super.c")
>>> Reported-by: syzbot+ed7d0f71a89e28557a77@syzkaller.appspotmail.com
>>> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
>>> ---
>>>    fs/gfs2/super.c | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
>>> index b018957a1bb2..9a3c6da8db55 100644
>>> --- a/fs/gfs2/super.c
>>> +++ b/fs/gfs2/super.c
>>> @@ -586,7 +586,10 @@ static void gfs2_put_super(struct super_block *sb)
>>>
>>>        if (!sb_rdonly(sb)) {
>>>                gfs2_make_fs_ro(sdp);
>>> +     } else {
>>> +             gfs2_quota_cleanup(sdp);
>>>        }
>>> +
>>>        WARN_ON(gfs2_withdrawing(sdp));
>>>
>>>        /*  At this point, we're through modifying the disk  */
>>>
>>
> 
> Andreas
> 
> .
> 
-- Wang ShaoBo
