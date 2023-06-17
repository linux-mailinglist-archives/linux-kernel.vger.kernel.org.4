Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087BA73420B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 17:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjFQPs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 11:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjFQPsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 11:48:24 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1AA13E
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 08:48:23 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-77b257b9909so185445239f.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 08:48:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687016902; x=1689608902;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zu8NPYccoUGuTMk9tcVfDzhkpPVauomSUWz/sfEJVoI=;
        b=jfandTGj4FIzpkkWvA0fzmK6ZGqmndMApdJpOHAXXbnj94RDTqfk5KqO190JL39Et9
         mslq2Wp7jUn1Ohzg4f1nup1XewLAnfv84XeV+vjjGEsPqmDXI8aRPfKh5LX57sbKqkpL
         FsByYt2J35oWpd8F1iBlzDCRqrYqBXYEc21B20S4RUOG8qZ/F17zWavF8hOw7pNmeRZq
         YCOj7ahM20sNZre58Q0rL03KMcCa8hJWfKvxt/gpOlL3md5DrFc8jZY1einNgac83b9b
         SnKV8TfQUunO41FGjvQ7OaxbsZtVY93LLnZ0k6+sxrkd8Gvb/Iw2rmstza44WEoHdwx9
         G4xA==
X-Gm-Message-State: AC+VfDzT521ueAUO+WHGnTtL8yuw4vsGxz3SHCs+nxcqerbXR4XMMFEn
        skpyIhRgiG7NgGX2ZV8QYRl/QyaVKRa9jGwQHjGg96TV4Llp
X-Google-Smtp-Source: ACHHUZ7SZ+DLDqw7tBymIVCOy7Fm4sbgS49zk2sXfcFpzVKlv7uxUjLUqYuCp1dr4qi5z0b5MEIF/YcCXzv0tHGD/+SSeBbequg2
MIME-Version: 1.0
X-Received: by 2002:a02:95a2:0:b0:420:f404:40b6 with SMTP id
 b31-20020a0295a2000000b00420f40440b6mr1296752jai.1.1687016902398; Sat, 17 Jun
 2023 08:48:22 -0700 (PDT)
Date:   Sat, 17 Jun 2023 08:48:22 -0700
In-Reply-To: <20230617134704.1211-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000032996005fe553bc1@google.com>
Subject: Re: [syzbot] [f2fs?] possible deadlock in f2fs_release_file
From:   syzbot <syzbot+e5b81eaab292e00e7d98@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in user_get_super

INFO: task syz-executor272:7088 blocked for more than 143 seconds.
      Not tainted 6.4.0-rc6-syzkaller-00037-gb6dad5178cea-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor272 state:D stack:29016 pid:7088  ppid:7046   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5343 [inline]
 __schedule+0xc9a/0x5880 kernel/sched/core.c:6669
 schedule+0xde/0x1a0 kernel/sched/core.c:6745
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6804
 rwsem_down_write_slowpath+0x3e2/0x1220 kernel/locking/rwsem.c:1178
 __down_write_common kernel/locking/rwsem.c:1306 [inline]
 __down_write kernel/locking/rwsem.c:1315 [inline]
 down_write+0x1d2/0x200 kernel/locking/rwsem.c:1574
 user_get_super+0x230/0x310 fs/super.c:875
 quotactl_block+0x26d/0x410 fs/quota/quota.c:890
 __do_sys_quotactl fs/quota/quota.c:954 [inline]
 __se_sys_quotactl fs/quota/quota.c:916 [inline]
 __x64_sys_quotactl+0x32b/0x410 fs/quota/quota.c:916
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fb71dc27649
RSP: 002b:00007fb717697318 EFLAGS: 00000246 ORIG_RAX: 00000000000000b3
RAX: ffffffffffffffda RBX: 00007fb71dcb47b8 RCX: 00007fb71dc27649
RDX: 0000000000000000 RSI: 0000000020000080 RDI: ffffffff80000202
RBP: 00007fb71dcb47b0 R08: 00007fb717697700 R09: 0000000000000000
R10: 0000000020008040 R11: 0000000000000246 R12: 6f6f6c2f7665642f
R13: 00007ffe21a598bf R14: 00007fb717697400 R15: 0000000000022000
 </TASK>

Showing all locks held in the system:
4 locks held by kworker/u4:0/10:
 #0: ffff8880b993c5d8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2f/0x120 kernel/sched/core.c:558
 #1: ffff8880b9928848 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x2de/0x950 kernel/sched/psi.c:996
 #2: ffff888029ae4d40 (&wdev->mtx){+.+.}-{3:3}, at: sdata_lock net/mac80211/ieee80211_i.h:1129 [inline]
 #2: ffff888029ae4d40 (&wdev->mtx){+.+.}-{3:3}, at: ieee80211_ibss_work+0x94/0x14a0 net/mac80211/ibss.c:1680
 #3: ffffffff8c7990c0 (rcu_read_lock){....}-{1:2}, at: sdata_assert_lock net/mac80211/ieee80211_i.h:1146 [inline]
 #3: ffffffff8c7990c0 (rcu_read_lock){....}-{1:2}, at: ieee80211_sta_active_ibss+0x86/0x390 net/mac80211/ibss.c:652
1 lock held by rcu_tasks_kthre/13:
 #0: ffffffff8c7984b0 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0xd80 kernel/rcu/tasks.h:518
1 lock held by rcu_tasks_trace/14:
 #0: ffffffff8c7981b0 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0xd80 kernel/rcu/tasks.h:518
1 lock held by khungtaskd/27:
 #0: ffffffff8c7990c0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x340 kernel/locking/lockdep.c:6559
5 locks held by kworker/u4:2/40:
2 locks held by kworker/u4:5/2832:
 #0: ffff8880b993c5d8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2f/0x120 kernel/sched/core.c:558
 #1: ffff8880b9928848 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x2de/0x950 kernel/sched/psi.c:996
2 locks held by getty/4753:
 #0: ffff88802ce02098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x26/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900015a02f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xef4/0x13e0 drivers/tty/n_tty.c:2176
4 locks held by syz-executor.3/5377:
 #0: ffff88807dae80e0 (&type->s_umount_key#50){+.+.}-{3:3}, at: deactivate_super+0xa9/0xd0 fs/super.c:361
 #1: ffff888023ae4318 (&sbi->cp_global_sem){+.+.}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2112 [inline]
 #1: ffff888023ae4318 (&sbi->cp_global_sem){+.+.}-{3:3}, at: f2fs_write_checkpoint+0x4a6/0x4b40 fs/f2fs/checkpoint.c:1638
 #2: ffff888023ae43b0 (&sbi->cp_rwsem){++++}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2112 [inline]
 #2: ffff888023ae43b0 (&sbi->cp_rwsem){++++}-{3:3}, at: f2fs_lock_all fs/f2fs/f2fs.h:2147 [inline]
 #2: ffff888023ae43b0 (&sbi->cp_rwsem){++++}-{3:3}, at: block_operations+0x10d/0xe80 fs/f2fs/checkpoint.c:1219
 #3: ffff888023ae4448 (&sbi->node_write){++++}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2112 [inline]
 #3: ffff888023ae4448 (&sbi->node_write){++++}-{3:3}, at: block_operations+0x8fe/0xe80 fs/f2fs/checkpoint.c:1267
4 locks held by syz-executor272/7043:
 #0: ffff888065c100e0 (&type->s_umount_key#50){+.+.}-{3:3}, at: deactivate_super+0xa9/0xd0 fs/super.c:361
 #1: ffff888049488318 (&sbi->cp_global_sem){+.+.}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2112 [inline]
 #1: ffff888049488318 (&sbi->cp_global_sem){+.+.}-{3:3}, at: f2fs_write_checkpoint+0x4a6/0x4b40 fs/f2fs/checkpoint.c:1638
 #2: ffff8880494883b0 (&sbi->cp_rwsem){++++}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2112 [inline]
 #2: ffff8880494883b0 (&sbi->cp_rwsem){++++}-{3:3}, at: f2fs_lock_all fs/f2fs/f2fs.h:2147 [inline]
 #2: ffff8880494883b0 (&sbi->cp_rwsem){++++}-{3:3}, at: block_operations+0x10d/0xe80 fs/f2fs/checkpoint.c:1219
 #3: ffff888049488448 (&sbi->node_write){++++}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2112 [inline]
 #3: ffff888049488448 (&sbi->node_write){++++}-{3:3}, at: block_operations+0x8fe/0xe80 fs/f2fs/checkpoint.c:1267
4 locks held by syz-executor272/7044:
 #0: ffff888032a700e0 (&type->s_umount_key#50){+.+.}-{3:3}, at: deactivate_super+0xa9/0xd0 fs/super.c:361
 #1: ffff888017ad4318 (&sbi->cp_global_sem){+.+.}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2112 [inline]
 #1: ffff888017ad4318 (&sbi->cp_global_sem){+.+.}-{3:3}, at: f2fs_write_checkpoint+0x4a6/0x4b40 fs/f2fs/checkpoint.c:1638
 #2: ffff888017ad43b0 (&sbi->cp_rwsem){++++}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2112 [inline]
 #2: ffff888017ad43b0 (&sbi->cp_rwsem){++++}-{3:3}, at: f2fs_lock_all fs/f2fs/f2fs.h:2147 [inline]
 #2: ffff888017ad43b0 (&sbi->cp_rwsem){++++}-{3:3}, at: block_operations+0x10d/0xe80 fs/f2fs/checkpoint.c:1219
 #3: ffff888017ad4448 (&sbi->node_write){++++}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2112 [inline]
 #3: ffff888017ad4448 (&sbi->node_write){++++}-{3:3}, at: block_operations+0x8fe/0xe80 fs/f2fs/checkpoint.c:1267
4 locks held by syz-executor272/7045:
 #0: ffff88806a81e0e0 (&type->s_umount_key#50){+.+.}-{3:3}, at: deactivate_super+0xa9/0xd0 fs/super.c:361
 #1: ffff8880762a8318 (&sbi->cp_global_sem){+.+.}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2112 [inline]
 #1: ffff8880762a8318 (&sbi->cp_global_sem){+.+.}-{3:3}, at: f2fs_write_checkpoint+0x4a6/0x4b40 fs/f2fs/checkpoint.c:1638
 #2: ffff8880762a83b0 (&sbi->cp_rwsem){++++}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2112 [inline]
 #2: ffff8880762a83b0 (&sbi->cp_rwsem){++++}-{3:3}, at: f2fs_lock_all fs/f2fs/f2fs.h:2147 [inline]
 #2: ffff8880762a83b0 (&sbi->cp_rwsem){++++}-{3:3}, at: block_operations+0x10d/0xe80 fs/f2fs/checkpoint.c:1219
 #3: ffff8880762a8448 (&sbi->node_write){++++}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2112 [inline]
 #3: ffff8880762a8448 (&sbi->node_write){++++}-{3:3}, at: block_operations+0x8fe/0xe80 fs/f2fs/checkpoint.c:1267
4 locks held by syz-executor272/7047:
 #0: ffff88807d2ec0e0 (&type->s_umount_key#50){+.+.}-{3:3}, at: deactivate_super+0xa9/0xd0 fs/super.c:361
 #1: ffff88807fa84318 (&sbi->cp_global_sem){+.+.}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2112 [inline]
 #1: ffff88807fa84318 (&sbi->cp_global_sem){+.+.}-{3:3}, at: f2fs_write_checkpoint+0x4a6/0x4b40 fs/f2fs/checkpoint.c:1638
 #2: ffff88807fa843b0 (&sbi->cp_rwsem){++++}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2112 [inline]
 #2: ffff88807fa843b0 (&sbi->cp_rwsem){++++}-{3:3}, at: f2fs_lock_all fs/f2fs/f2fs.h:2147 [inline]
 #2: ffff88807fa843b0 (&sbi->cp_rwsem){++++}-{3:3}, at: block_operations+0x10d/0xe80 fs/f2fs/checkpoint.c:1219
 #3: ffff88807fa84448 (&sbi->node_write){++++}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2112 [inline]
 #3: ffff88807fa84448 (&sbi->node_write){++++}-{3:3}, at: block_operations+0x8fe/0xe80 fs/f2fs/checkpoint.c:1267
1 lock held by syz-executor272/7048:
 #0: ffff8880763cc0e0 (&type->s_umount_key#50){+.+.}-{3:3}, at: deactivate_super+0xa9/0xd0 fs/super.c:361
1 lock held by syz-executor272/7088:
 #0: ffff88807dae80e0 (&type->s_umount_key#50){+.+.}-{3:3}, at: user_get_super+0x230/0x310 fs/super.c:875

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 27 Comm: khungtaskd Not tainted 6.4.0-rc6-syzkaller-00037-gb6dad5178cea-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x29c/0x350 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x2a4/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:148 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xe16/0x1090 kernel/hung_task.c:379
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 2832 Comm: kworker/u4:5 Not tainted 6.4.0-rc6-syzkaller-00037-gb6dad5178cea-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Workqueue: bat_events batadv_nc_worker
RIP: 0010:preempt_count_sub+0x2b/0x150 kernel/sched/core.c:5839
Code: 0f 1e fa 48 c7 c0 00 84 df 91 53 89 fb 48 ba 00 00 00 00 00 fc ff df 48 89 c1 83 e0 07 48 c1 e9 03 83 c0 03 0f b6 14 11 38 d0 <7c> 08 84 d2 0f 85 e4 00 00 00 8b 0d 55 57 87 10 85 c9 75 1b 65 8b
RSP: 0018:ffffc9000b01fbf8 EFLAGS: 00000097
RAX: 0000000000000003 RBX: 0000000000000001 RCX: 1ffffffff23bf080
RDX: 0000000000000004 RSI: 0000000000000001 RDI: 0000000000000001
RBP: ffffffff89db728c R08: 0000000000000000 R09: ffffffff8e7a8957
R10: fffffbfff1cf512a R11: 0000000000000000 R12: ffff8880223017a8
R13: ffff888022300c80 R14: dffffc0000000000 R15: ffffffff89db7480
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:00000000000000


Tested on:

commit:         b6dad517 Merge tag 'nios2_fix_v6.4' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14ef9b7f280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ac246111fb601aec
dashboard link: https://syzkaller.appspot.com/bug?extid=e5b81eaab292e00e7d98
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1339a97f280000

