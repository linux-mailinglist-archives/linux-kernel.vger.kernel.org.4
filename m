Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2657F6614AF
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 12:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbjAHLMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 06:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbjAHLMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 06:12:00 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888FD8FDA
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 03:11:58 -0800 (PST)
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 308BBuHl050976;
        Sun, 8 Jan 2023 20:11:56 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Sun, 08 Jan 2023 20:11:56 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.20] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 308BBuDo050973
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 8 Jan 2023 20:11:56 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <45699174-cb58-d57d-4c72-c0ae7622aeac@I-love.SAKURA.ne.jp>
Date:   Sun, 8 Jan 2023 20:11:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [syzbot] INFO: task hung in freeze_super (3)
Content-Language: en-US
To:     Hillf Danton <hdanton@sina.com>, Tejun Heo <tj@kernel.org>
Cc:     agruenba@redhat.com, linux-mm@kvack.org,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        rpeterso@redhat.com, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+f51cb4b9afbd87ec06f2@syzkaller.appspotmail.com>
References: <20230104040132.4103-1-hdanton@sina.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20230104040132.4103-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/01/04 13:01, Hillf Danton wrote:
> On 09 Dec 2022 01:08:38 -0800
>> syzbot found the following issue on:
>>
>> HEAD commit:    f3e8416619ce Merge tag 'soc-fixes-6.1-5' of git://git.kern..
>> git tree:       upstream
>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=12fb534d880000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=d58e7fe7f9cf5e24
>> dashboard link: https://syzkaller.appspot.com/bug?extid=f51cb4b9afbd87ec06f2
>> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=123d216b880000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16e46f5b880000
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/628abc27cbe7/disk-f3e84166.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/2f19ea836174/vmlinux-f3e84166.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/f2e1347e85a5/bzImage-f3e84166.xz
>> mounted in repro: https://storage.googleapis.com/syzbot-assets/c239a19c8749/mount_0.gz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+f51cb4b9afbd87ec06f2@syzkaller.appspotmail.com
>>
>> INFO: task kworker/0:1H:120 blocked for more than 143 seconds.
>>       Not tainted 6.1.0-rc8-syzkaller-00035-gf3e8416619ce #0
>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> task:kworker/0:1H    state:D stack:23480 pid:120   ppid:2      flags:0x00004000
>> Workqueue: glock_workqueue glock_work_func
>> Call Trace:
>>  <TASK>
>>  context_switch kernel/sched/core.c:5209 [inline]
>>  __schedule+0x8c9/0xd70 kernel/sched/core.c:6521
>>  schedule+0xcb/0x190 kernel/sched/core.c:6597
>>  rwsem_down_write_slowpath+0xfc1/0x1480 kernel/locking/rwsem.c:1190
>>  __down_write_common kernel/locking/rwsem.c:1305 [inline]
>>  __down_write kernel/locking/rwsem.c:1314 [inline]
>>  down_write+0x231/0x270 kernel/locking/rwsem.c:1563
>>  freeze_super+0x45/0x420 fs/super.c:1697
>>  freeze_go_sync+0x178/0x340 fs/gfs2/glops.c:573
>>  do_xmote+0x34d/0x13d0 fs/gfs2/glock.c:776
>>  glock_work_func+0x2c2/0x450 fs/gfs2/glock.c:1082
>>  process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
>>  worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
>>  kthread+0x266/0x300 kernel/kthread.c:376
>>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
>>  </TASK>
>> INFO: task syz-executor330:3631 blocked for more than 143 seconds.
>>       Not tainted 6.1.0-rc8-syzkaller-00035-gf3e8416619ce #0
>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> task:syz-executor330 state:D stack:20176 pid:3631  ppid:3630   flags:0x00004004
>> Call Trace:
>>  <TASK>
>>  context_switch kernel/sched/core.c:5209 [inline]
>>  __schedule+0x8c9/0xd70 kernel/sched/core.c:6521
>>  schedule+0xcb/0x190 kernel/sched/core.c:6597
>>  schedule_timeout+0x98/0x2f0 kernel/time/timer.c:1911
>>  do_wait_for_common+0x3ea/0x560 kernel/sched/completion.c:85
>>  __wait_for_common kernel/sched/completion.c:106 [inline]
>>  wait_for_common kernel/sched/completion.c:117 [inline]
>>  wait_for_completion+0x46/0x60 kernel/sched/completion.c:138
>>  __flush_workqueue+0x74a/0x1680 kernel/workqueue.c:2861
>>  gfs2_gl_hash_clear+0xbe/0x300 fs/gfs2/glock.c:2262
>>  gfs2_fill_super+0x2202/0x2700 fs/gfs2/ops_fstype.c:1307
>>  get_tree_bdev+0x400/0x620 fs/super.c:1324
>>  gfs2_get_tree+0x50/0x210 fs/gfs2/ops_fstype.c:1330
>>  vfs_get_tree+0x88/0x270 fs/super.c:1531
>>  do_new_mount+0x289/0xad0 fs/namespace.c:3040
>>  do_mount fs/namespace.c:3383 [inline]
>>  __do_sys_mount fs/namespace.c:3591 [inline]
>>  __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
>>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> RIP: 0033:0x7f19da3f458a
>> RSP: 002b:00007ffd6b2d69e8 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
>> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f19da3f458a
>> RDX: 0000000020000040 RSI: 000000002003b300 RDI: 00007ffd6b2d6a00
>> RBP: 00007ffd6b2d6a00 R08: 00007ffd6b2d6a40 R09: 0000000000000002
>> R10: 0000000000000000 R11: 0000000000000282 R12: 0000000000000004
>> R13: 0000555556b0d2c0 R14: 0000000000000000 R15: 00007ffd6b2d6a40
>>  </TASK>
>>
>> Showing all locks held in the system:
>> 1 lock held by rcu_tasks_kthre/12:
>>  #0: ffffffff8d127330 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x30/0xd00 kernel/rcu/tasks.h:507
>> 1 lock held by rcu_tasks_trace/13:
>>  #0: ffffffff8d127b30 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x30/0xd00 kernel/rcu/tasks.h:507
>> 1 lock held by khungtaskd/28:
>>  #0: ffffffff8d127160 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30
>> 3 locks held by kworker/0:1H/120:
>>  #0: ffff8880194f5d38 ((wq_completion)glock_workqueue){+.+.}-{0:0}, at: process_one_work+0x7f2/0xdb0
>>  #1: ffffc90002587d00 ((work_completion)(&(&gl->gl_work)->work)){+.+.}-{0:0}, at: process_one_work+0x831/0xdb0 kernel/workqueue.c:2264
>>  #2: ffff888026c2c0e0 (&type->s_umount_key#42){+.+.}-{3:3}, at: freeze_super+0x45/0x420 fs/super.c:1697
>> 2 locks held by getty/3308:
>>  #0: ffff888028211098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:244
>>  #1: ffffc900031262f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x53b/0x1650 drivers/tty/n_tty.c:2177
>> 1 lock held by syz-executor330/3631:
>>  #0: ffff888026c2c0e0 (&type->s_umount_key#41/1){+.+.}-{3:3}, at: alloc_super+0x212/0x920 fs/super.c:228
>>
> 
> 	syz-executor330/3631			kworker/0:1H/120
> 	---					---
> 	down_write_nested(&s->s_umount);
> 						glock_work_func()
> 						down_write(&sb->s_umount);
> 	flush_workqueue(glock_workqueue);
> 
> 
> No deadlock is reported yet. Whyyy?
> See if extending the aperture of wq->lockdep_map can catch it.

As far as I tested, this patch did not change likeliness of hitting lockdep warning.
I feel that it was just by chance that this test request was able to hit lockdep warning.

> 
> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
> 
> --- x/kernel/workqueue.c
> +++ y/kernel/workqueue.c
> @@ -2807,7 +2807,6 @@ void __flush_workqueue(struct workqueue_
>  		return;
>  
>  	lock_map_acquire(&wq->lockdep_map);
> -	lock_map_release(&wq->lockdep_map);
>  
>  	mutex_lock(&wq->mutex);
>  
> @@ -2867,7 +2866,7 @@ void __flush_workqueue(struct workqueue_
>  	 * handling overflow.  Non-first flushers can simply return.
>  	 */
>  	if (READ_ONCE(wq->first_flusher) != &this_flusher)
> -		return;
> +		goto out;
>  
>  	mutex_lock(&wq->mutex);
>  
> @@ -2942,6 +2941,8 @@ void __flush_workqueue(struct workqueue_
>  
>  out_unlock:
>  	mutex_unlock(&wq->mutex);
> +out:
> +	lock_map_release(&wq->lockdep_map);
>  }
>  EXPORT_SYMBOL(__flush_workqueue);
>  
> --

