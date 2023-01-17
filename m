Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFF766D41F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbjAQCMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235116AbjAQCM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:12:28 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21D21EFF8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:12:26 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id t3-20020a6bc303000000b006f7844c6298so18836521iof.23
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:12:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jpd1SJ/a5oo+Oy5OTgXjCalwVo4Z6x55JgtATVksOlI=;
        b=K0pg5JLZZDmXzb8++AwDSn7Z6jXitYrrf1j+JT0vTbRz89/DR02wnkKVDurINtF1Za
         5GK0duCjy1bQjDSzUQbZ3esQeqSO9skJxYxIoopxyg6SvfHtjzc5513lo1AiuMvk6WaJ
         e40k20YC9mHHJ7KvPB6qD2gFNkvIKyn2/bACNORJ4+UlG7AN8B14/8Hqx+QAJjeRLbWb
         kod0gw2EE8CdxdQPrI+gSc4KMztTqnQAFdoBGzs0RmABCqout1uvLcXAvGWcB2fDc2EM
         nb91I4B60fhDCQhMRKGDVtePRqtmNS26g1POQMjeANCigYJiZrZ0A14zABNsqsE+vURR
         JvKw==
X-Gm-Message-State: AFqh2kplldKSvhehNkqjWZh1ABpg2UGgJSnhCGYbsTxXiGNPj/PekXVM
        pARmV6XMU+aTJqivwQi+uTSKyxqc+PGWmMoHpdjdqBO8P5xC
X-Google-Smtp-Source: AMrXdXs96n4oMfbUlJLasnDI4PVUJQEs2GJEo+5X6nBg+IJyfP49dQnZ69ibzmqA2cAKjE3E6ZRcF3Ibt3lfNzYck0DMTtXvIy43
MIME-Version: 1.0
X-Received: by 2002:a5d:8485:0:b0:6f3:5bef:9ad7 with SMTP id
 t5-20020a5d8485000000b006f35bef9ad7mr104804iom.142.1673921546149; Mon, 16 Jan
 2023 18:12:26 -0800 (PST)
Date:   Mon, 16 Jan 2023 18:12:26 -0800
In-Reply-To: <20230117000535.2071-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000023e55905f26c3be2@google.com>
Subject: Re: [syzbot] possible deadlock in br_multicast_rcv (3)
From:   syzbot <syzbot+d7b7f1412c02134efa6d@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in linkwatch_event

INFO: task kworker/1:1:26 blocked for more than 143 seconds.
      Not tainted 6.2.0-rc2-syzkaller-00378-g60d86034b14e-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:1     state:D stack:25400 pid:26    ppid:2      flags:0x00004000
Workqueue: events linkwatch_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0xb8a/0x5450 kernel/sched/core.c:6555
 schedule+0xde/0x1b0 kernel/sched/core.c:6631
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6690
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0xa48/0x1360 kernel/locking/mutex.c:747
 linkwatch_event+0xf/0x70 net/core/link_watch.c:277
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
INFO: task dhcpcd:4647 blocked for more than 143 seconds.
      Not tainted 6.2.0-rc2-syzkaller-00378-g60d86034b14e-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:dhcpcd          state:D stack:22928 pid:4647  ppid:4646   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0xb8a/0x5450 kernel/sched/core.c:6555
 schedule+0xde/0x1b0 kernel/sched/core.c:6631
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6690
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0xa48/0x1360 kernel/locking/mutex.c:747
 devinet_ioctl+0x1c4/0x1d70 net/ipv4/devinet.c:1071
 inet_ioctl+0x33f/0x380 net/ipv4/af_inet.c:979
 sock_do_ioctl+0xcc/0x230 net/socket.c:1169
 sock_ioctl+0x1f8/0x680 net/socket.c:1286
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5d168aa0e7
RSP: 002b:00007ffe2bbe6e08 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f5d167bc6c8 RCX: 00007f5d168aa0e7
RDX: 00007ffe2bbf6ff8 RSI: 0000000000008914 RDI: 0000000000000018
RBP: 00007ffe2bc071a8 R08: 00007ffe2bbf6fb8 R09: 00007ffe2bbf6f68
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe2bbf6ff8 R14: 0000000000000028 R15: 0000000000008914
 </TASK>
INFO: task kworker/0:4:5081 blocked for more than 143 seconds.
      Not tainted 6.2.0-rc2-syzkaller-00378-g60d86034b14e-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:4     state:D stack:25360 pid:5081  ppid:2      flags:0x00004000
Workqueue: events switchdev_deferred_process_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0xb8a/0x5450 kernel/sched/core.c:6555
 schedule+0xde/0x1b0 kernel/sched/core.c:6631
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6690
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0xa48/0x1360 kernel/locking/mutex.c:747
 switchdev_deferred_process_work+0xe/0x20 net/switchdev/switchdev.c:75
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
INFO: task syz-executor.0:9395 blocked for more than 143 seconds.
      Not tainted 6.2.0-rc2-syzkaller-00378-g60d86034b14e-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:25048 pid:9395  ppid:1      flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0xb8a/0x5450 kernel/sched/core.c:6555
 schedule+0xde/0x1b0 kernel/sched/core.c:6631
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6690
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0xa48/0x1360 kernel/locking/mutex.c:747
 rtnl_lock net/core/rtnetlink.c:75 [inline]
 rtnetlink_rcv_msg+0x3e9/0xca0 net/core/rtnetlink.c:6138
 netlink_rcv_skb+0x165/0x440 net/netlink/af_netlink.c:2564
 netlink_unicast_kernel net/netlink/af_netlink.c:1330 [inline]
 netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1356
 netlink_sendmsg+0x91b/0xe10 net/netlink/af_netlink.c:1932
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg+0xd3/0x120 net/socket.c:734
 __sys_sendto+0x23a/0x340 net/socket.c:2117
 __do_sys_sendto net/socket.c:2129 [inline]
 __se_sys_sendto net/socket.c:2125 [inline]
 __x64_sys_sendto+0xe1/0x1b0 net/socket.c:2125
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f09f9e3e0fc
RSP: 002b:00007fff29484970 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f09faad4620 RCX: 00007f09f9e3e0fc
RDX: 0000000000000028 RSI: 00007f09faad4670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007fff294849c4 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 00007f09faad4670 R14: 0000000000000003 R15: 0000000000000000
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/12:
 #0: ffffffff8c791030 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x26/0xc70 kernel/rcu/tasks.h:507
1 lock held by rcu_tasks_trace/13:
 #0: ffffffff8c790d30 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x26/0xc70 kernel/rcu/tasks.h:507
3 locks held by kworker/1:1/26:
 #0: ffff888012470d38 ((wq_completion)events){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888012470d38 ((wq_completion)events){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888012470d38 ((wq_completion)events){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888012470d38 ((wq_completion)events){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff888012470d38 ((wq_completion)events){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff888012470d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x86d/0x1710 kernel/workqueue.c:2260
 #1: ffffc90000a1fda8 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work+0x8a1/0x1710 kernel/workqueue.c:2264
 #2: ffffffff8e0be7a8 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0xf/0x70 net/core/link_watch.c:277
1 lock held by khungtaskd/28:
 #0: ffffffff8c791b80 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x57/0x264 kernel/locking/lockdep.c:6494
5 locks held by kworker/u4:4/57:
 #0: ffff8880125df938 ((wq_completion)netns){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880125df938 ((wq_completion)netns){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880125df938 ((wq_completion)netns){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880125df938 ((wq_completion)netns){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff8880125df938 ((wq_completion)netns){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff8880125df938 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work+0x86d/0x1710 kernel/workqueue.c:2260
 #1: ffffc90001587da8 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work+0x8a1/0x1710 kernel/workqueue.c:2264
 #2: ffffffff8e0aab10 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x9f/0xb10 net/core/net_namespace.c:568
 #3: ffffffff8e0be7a8 (rtnl_mutex){+.+.}-{3:3}, at: default_device_exit_batch+0x92/0x590 net/core/dev.c:11334
 #4: ffffffff8c79c700 (rcu_state.barrier_mutex){+.+.}-{3:3}, at: rcu_barrier+0x48/0x6d0 kernel/rcu/tree.c:3997
3 locks held by kworker/0:2/900:
 #0: ffff88814a1f5538 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88814a1f5538 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88814a1f5538 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88814a1f5538 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88814a1f5538 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88814a1f5538 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x86d/0x1710 kernel/workqueue.c:2260
 #1: ffffc900046c7da8 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_one_work+0x8a1/0x1710 kernel/workqueue.c:2264
 #2: ffffffff8e0be7a8 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_verify_work+0x12/0x30 net/ipv6/addrconf.c:4624
1 lock held by dhcpcd/4647:
 #0: ffffffff8e0be7a8 (rtnl_mutex){+.+.}-{3:3}, at: devinet_ioctl+0x1c4/0x1d70 net/ipv4/devinet.c:1071
3 locks held by kworker/1:3/4732:
 #0: ffff88814a1f5538 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88814a1f5538 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88814a1f5538 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88814a1f5538 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88814a1f5538 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88814a1f5538 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x86d/0x1710 kernel/workqueue.c:2260
 #1: ffffc900035afda8 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_one_work+0x8a1/0x1710 kernel/workqueue.c:2264
 #2: ffffffff8e0be7a8 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_verify_work+0x12/0x30 net/ipv6/addrconf.c:4624
2 locks held by getty/4750:
 #0: ffff88814a4c6098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x26/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffffc900015902f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xef4/0x13e0 drivers/tty/n_tty.c:2177
3 locks held by kworker/0:4/5081:
 #0: ffff888012470d38 ((wq_completion)events){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888012470d38 ((wq_completion)events){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888012470d38 ((wq_completion)events){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888012470d38 ((wq_completion)events){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff888012470d38 ((wq_completion)events){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff888012470d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x86d/0x1710 kernel/workqueue.c:2260
 #1: ffffc90003f2fda8 (deferred_process_work){+.+.}-{0:0}, at: process_one_work+0x8a1/0x1710 kernel/workqueue.c:2264
 #2: ffffffff8e0be7a8 (rtnl_mutex){+.+.}-{3:3}, at: switchdev_deferred_process_work+0xe/0x20 net/switchdev/switchdev.c:75
1 lock held by syz-executor.0/9395:
 #0: ffffffff8e0be7a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:75 [inline]
 #0: ffffffff8e0be7a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x3e9/0xca0 net/core/rtnetlink.c:6138
1 lock held by syz-executor.0/9430:
 #0: ffffffff8e0be7a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:75 [inline]
 #0: ffffffff8e0be7a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x3e9/0xca0 net/core/rtnetlink.c:6138
1 lock held by syz-executor.0/9435:
 #0: ffffffff8e0be7a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:75 [inline]
 #0: ffffffff8e0be7a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x3e9/0xca0 net/core/rtnetlink.c:6138

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 28 Comm: khungtaskd Not tainted 6.2.0-rc2-syzkaller-00378-g60d86034b14e-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x24/0x18a lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x333/0x3c0 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:148 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:220 [inline]
 watchdog+0xc75/0xfc0 kernel/hung_task.c:377
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 11 Comm: kworker/u4:1 Not tainted 6.2.0-rc2-syzkaller-00378-g60d86034b14e-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:text_poke_loc_init+0xf7/0x450 arch/x86/kernel/alternative.c:2055
Code: d8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 c6 02 00 00 48 8d 7b 08 89 2b 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 c4 02 00 00
RSP: 0018:ffffc90000107a40 EFLAGS: 00000a02
RAX: dffffc0000000000 RBX: ffffffff8ff4b690 RCX: 0000000000000000
RDX: 1ffffffff1fe96d3 RSI: ffffffff89be389e RDI: ffffffff8ff4b698
RBP: 0000000000ceeb80 R08: dffffc0000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffffff8a465aea
R13: 0000000000000005 R14: 1ffff92000020f4a R15: ffffffff8a465aea
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d3950bd088 CR3: 000000000c48e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 arch_jump_label_transform_queue+0x98/0x100 arch/x86/kernel/jump_label.c:138
 __jump_label_update+0x12e/0x410 kernel/jump_label.c:475
 jump_label_update+0x32f/0x410 kernel/jump_label.c:829
 static_key_disable_cpuslocked+0x156/0x1b0 kernel/jump_label.c:235
 static_key_disable+0x1a/0x20 kernel/jump_label.c:243
 toggle_allocation_gate mm/kfence/core.c:804 [inline]
 toggle_allocation_gate+0x143/0x230 mm/kfence/core.c:791
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


Tested on:

commit:         60d86034 Merge tag 'mlx5-updates-2023-01-10' of git://..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16b49686480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=de2f853811ba4e08
dashboard link: https://syzkaller.appspot.com/bug?extid=d7b7f1412c02134efa6d
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=114331ce480000

