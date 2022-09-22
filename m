Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23895E6230
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 14:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiIVMTy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 22 Sep 2022 08:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbiIVMTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 08:19:50 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F3A17051
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 05:19:48 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id e15-20020a5d8acf000000b006a3ed059e49so887172iot.14
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 05:19:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=TdEP6jU3ZEkrFJxrwS8rM/nOPQdEmhlyR0DNdPVZwRw=;
        b=XfHnufLw/UH9CNxjXsIg/dZRIoohfeQRvjgC9eUztU+ncKZL8j4XSUTLvA6v+NdWfw
         GKqX+8LenoZsGTnLdd7OIqHkHUn1wfuHVfrieDzSiew8TRDdxwYvCUgb1JooMdE8FfiT
         8r6JV9nHAgAcg4Dp0/wukqguWMbeho5JiR+mrdsZFrf4abyE1JLbnVvTkk8nvRkllrtT
         hn5bwKL3GTKWZ2HgeCWjzB7OaeHpjBc1VGAb6IMpSVDzP135X4wmnbalbAPl7BhAf1Zm
         gL960AE/F3/S1APHVOddxh+gXqYdxP/XFXadgQsHmh+MNPvy9bZtadp0qvsVyf2X7miG
         0oaQ==
X-Gm-Message-State: ACrzQf0baFLbQECW259BaqEeikhMge4AyVF1YYdSL3jGvNbEcGIpbssM
        Qw4E8N1CCtE2vDgKYjAGXAHvO1ouvLecphOStQV9nlh/Y6Zy
X-Google-Smtp-Source: AMsMyM4gE20baY05XB3WRqDWF4s9xfPYJs1KLCehjIDieDsB/l02lAE953a3+KSG1LwIVGo0VMc12baJ56pnVNDb1CyjjvW2kajc
MIME-Version: 1.0
X-Received: by 2002:a05:6638:150c:b0:35a:f7a9:c3d8 with SMTP id
 b12-20020a056638150c00b0035af7a9c3d8mr1774227jat.38.1663849187908; Thu, 22
 Sep 2022 05:19:47 -0700 (PDT)
Date:   Thu, 22 Sep 2022 05:19:47 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ce24cc05e943136e@google.com>
Subject: [syzbot] possible deadlock in try_to_wake_up (2)
From:   syzbot <syzbot+7bc265e379a1a72d6d97@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a335366bad13 Merge tag 'gpio-fixes-for-v6.0-rc6' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14d28ef7080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98a30118ec9215e9
dashboard link: https://syzkaller.appspot.com/bug?extid=7bc265e379a1a72d6d97
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7bc265e379a1a72d6d97@syzkaller.appspotmail.com

chnl_net:caif_netlink_parms(): no params data found
======================================================
WARNING: possible circular locking dependency detected
6.0.0-rc5-syzkaller-00094-ga335366bad13 #0 Not tainted
------------------------------------------------------
syz-executor.0/3713 is trying to acquire lock:
ffff888016e02730 (&p->pi_lock){-.-.}-{2:2}, at: try_to_wake_up+0xab/0x1e60 kernel/sched/core.c:4082

but task is already holding lock:
ffff88803fffeba0 (&pgdat->kswapd_wait){....}-{2:2}, at: __wake_up_common_lock+0xb4/0x130 kernel/sched/wait.c:136

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&pgdat->kswapd_wait){....}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
       __wake_up_common_lock+0xb4/0x130 kernel/sched/wait.c:136
       wakeup_kswapd+0x3fa/0x650 mm/vmscan.c:4597
       wake_all_kswapds+0x182/0x2d0 mm/page_alloc.c:4785
       __alloc_pages_slowpath.constprop.0+0x1732/0x2240 mm/page_alloc.c:5052
       __alloc_pages+0x43d/0x510 mm/page_alloc.c:5528
       alloc_pages+0x1a6/0x270 mm/mempolicy.c:2270
       alloc_slab_page mm/slub.c:1824 [inline]
       allocate_slab+0x27e/0x3d0 mm/slub.c:1969
       new_slab mm/slub.c:2029 [inline]
       ___slab_alloc+0x7f1/0xe10 mm/slub.c:3031
       __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3118
       slab_alloc_node mm/slub.c:3209 [inline]
       slab_alloc mm/slub.c:3251 [inline]
       __kmem_cache_alloc_lru mm/slub.c:3258 [inline]
       kmem_cache_alloc+0x38c/0x3b0 mm/slub.c:3268
       kmem_cache_zalloc include/linux/slab.h:723 [inline]
       fill_pool+0x264/0x5c0 lib/debugobjects.c:168
       __debug_object_init+0x7a/0xd10 lib/debugobjects.c:562
       debug_object_init lib/debugobjects.c:617 [inline]
       debug_object_activate+0x32c/0x3e0 lib/debugobjects.c:703
       debug_timer_activate kernel/time/timer.c:782 [inline]
       __mod_timer+0x77d/0xe30 kernel/time/timer.c:1103
       __queue_delayed_work+0x1a7/0x270 kernel/workqueue.c:1676
       queue_delayed_work_on+0x105/0x120 kernel/workqueue.c:1701
       queue_delayed_work include/linux/workqueue.h:518 [inline]
       wg_ratelimiter_init+0x198/0x2c0 drivers/net/wireguard/ratelimiter.c:191
       wg_newlink+0x4f2/0x9a0 drivers/net/wireguard/device.c:367
       rtnl_newlink_create net/core/rtnetlink.c:3363 [inline]
       __rtnl_newlink+0x1087/0x17e0 net/core/rtnetlink.c:3580
       rtnl_newlink+0x64/0xa0 net/core/rtnetlink.c:3593
       rtnetlink_rcv_msg+0x43a/0xca0 net/core/rtnetlink.c:6090
       netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2501
       netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
       netlink_unicast+0x543/0x7f0 net/netlink/af_netlink.c:1345
       netlink_sendmsg+0x917/0xe10 net/netlink/af_netlink.c:1921
       sock_sendmsg_nosec net/socket.c:714 [inline]
       sock_sendmsg+0xcf/0x120 net/socket.c:734
       __sys_sendto+0x236/0x340 net/socket.c:2117
       __do_compat_sys_socketcall+0x47f/0x660 net/compat.c:472
       do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
       __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
       do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
       entry_SYSENTER_compat_after_hwframe+0x70/0x82

-> #2 (&base->lock){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
       lock_timer_base+0x5a/0x1f0 kernel/time/timer.c:999
       __mod_timer+0x398/0xe30 kernel/time/timer.c:1072
       __queue_delayed_work+0x1a7/0x270 kernel/workqueue.c:1676
       queue_delayed_work_on+0x105/0x120 kernel/workqueue.c:1701
       psi_enqueue kernel/sched/stats.h:136 [inline]
       enqueue_task+0x1ec/0x3a0 kernel/sched/core.c:2062
       activate_task kernel/sched/core.c:2091 [inline]
       wake_up_new_task+0x582/0xbf0 kernel/sched/core.c:4680
       kernel_clone+0x1eb/0xab0 kernel/fork.c:2698
       user_mode_thread+0xad/0xe0 kernel/fork.c:2743
       rest_init+0x23/0x270 init/main.c:692
       arch_call_rest_init+0xf/0x14 init/main.c:883
       start_kernel+0x46e/0x48f init/main.c:1138
       secondary_startup_64_no_verify+0xce/0xdb

-> #1 (&rq->__lock){-.-.}-{2:2}:
       _raw_spin_lock_nested+0x30/0x40 kernel/locking/spinlock.c:378
       raw_spin_rq_lock_nested+0x2b/0x120 kernel/sched/core.c:544
       raw_spin_rq_lock kernel/sched/sched.h:1355 [inline]
       rq_lock kernel/sched/sched.h:1653 [inline]
       task_fork_fair+0x68/0x520 kernel/sched/fair.c:11440
       sched_cgroup_fork+0x340/0x480 kernel/sched/core.c:4624
       copy_process+0x4427/0x7090 kernel/fork.c:2374
       kernel_clone+0xe7/0xab0 kernel/fork.c:2674
       user_mode_thread+0xad/0xe0 kernel/fork.c:2743
       rest_init+0x23/0x270 init/main.c:692
       arch_call_rest_init+0xf/0x14 init/main.c:883
       start_kernel+0x46e/0x48f init/main.c:1138
       secondary_startup_64_no_verify+0xce/0xdb

-> #0 (&p->pi_lock){-.-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3095 [inline]
       check_prevs_add kernel/locking/lockdep.c:3214 [inline]
       validate_chain kernel/locking/lockdep.c:3829 [inline]
       __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5053
       lock_acquire kernel/locking/lockdep.c:5666 [inline]
       lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
       try_to_wake_up+0xab/0x1e60 kernel/sched/core.c:4082
       autoremove_wake_function+0x12/0x140 kernel/sched/wait.c:415
       __wake_up_common+0x147/0x650 kernel/sched/wait.c:107
       __wake_up_common_lock+0xd0/0x130 kernel/sched/wait.c:137
       wakeup_kswapd+0x3fa/0x650 mm/vmscan.c:4597
       wake_all_kswapds+0x182/0x2d0 mm/page_alloc.c:4785
       __alloc_pages_slowpath.constprop.0+0x1732/0x2240 mm/page_alloc.c:5052
       __alloc_pages+0x43d/0x510 mm/page_alloc.c:5528
       alloc_pages+0x1a6/0x270 mm/mempolicy.c:2270
       alloc_slab_page mm/slub.c:1824 [inline]
       allocate_slab+0x27e/0x3d0 mm/slub.c:1969
       new_slab mm/slub.c:2029 [inline]
       ___slab_alloc+0x7f1/0xe10 mm/slub.c:3031
       __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3118
       slab_alloc_node mm/slub.c:3209 [inline]
       slab_alloc mm/slub.c:3251 [inline]
       __kmem_cache_alloc_lru mm/slub.c:3258 [inline]
       kmem_cache_alloc+0x38c/0x3b0 mm/slub.c:3268
       kmem_cache_zalloc include/linux/slab.h:723 [inline]
       fill_pool+0x264/0x5c0 lib/debugobjects.c:168
       __debug_object_init+0x7a/0xd10 lib/debugobjects.c:562
       debug_object_init lib/debugobjects.c:617 [inline]
       debug_object_activate+0x32c/0x3e0 lib/debugobjects.c:703
       debug_timer_activate kernel/time/timer.c:782 [inline]
       __mod_timer+0x77d/0xe30 kernel/time/timer.c:1103
       __queue_delayed_work+0x1a7/0x270 kernel/workqueue.c:1676
       queue_delayed_work_on+0x105/0x120 kernel/workqueue.c:1701
       queue_delayed_work include/linux/workqueue.h:518 [inline]
       wg_ratelimiter_init+0x198/0x2c0 drivers/net/wireguard/ratelimiter.c:191
       wg_newlink+0x4f2/0x9a0 drivers/net/wireguard/device.c:367
       rtnl_newlink_create net/core/rtnetlink.c:3363 [inline]
       __rtnl_newlink+0x1087/0x17e0 net/core/rtnetlink.c:3580
       rtnl_newlink+0x64/0xa0 net/core/rtnetlink.c:3593
       rtnetlink_rcv_msg+0x43a/0xca0 net/core/rtnetlink.c:6090
       netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2501
       netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
       netlink_unicast+0x543/0x7f0 net/netlink/af_netlink.c:1345
       netlink_sendmsg+0x917/0xe10 net/netlink/af_netlink.c:1921
       sock_sendmsg_nosec net/socket.c:714 [inline]
       sock_sendmsg+0xcf/0x120 net/socket.c:734
       __sys_sendto+0x236/0x340 net/socket.c:2117
       __do_compat_sys_socketcall+0x47f/0x660 net/compat.c:472
       do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
       __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
       do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
       entry_SYSENTER_compat_after_hwframe+0x70/0x82

other info that might help us debug this:

Chain exists of:
  &p->pi_lock --> &base->lock --> &pgdat->kswapd_wait

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&pgdat->kswapd_wait);
                               lock(&base->lock);
                               lock(&pgdat->kswapd_wait);
  lock(&p->pi_lock);

 *** DEADLOCK ***

4 locks held by syz-executor.0/3713:
 #0: ffffffff8d7b1128 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:74 [inline]
 #0: ffffffff8d7b1128 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x3e5/0xca0 net/core/rtnetlink.c:6087
 #1: ffffffff8ccb32e8 (init_lock){+.+.}-{3:3}, at: wg_ratelimiter_init+0x17/0x2c0 drivers/net/wireguard/ratelimiter.c:160
 #2: ffff88802c829498 (&base->lock){-.-.}-{2:2}, at: lock_timer_base+0x5a/0x1f0 kernel/time/timer.c:999
 #3: ffff88803fffeba0 (&pgdat->kswapd_wait){....}-{2:2}, at: __wake_up_common_lock+0xb4/0x130 kernel/sched/wait.c:136

stack backtrace:
CPU: 0 PID: 3713 Comm: syz-executor.0 Not tainted 6.0.0-rc5-syzkaller-00094-ga335366bad13 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3095 [inline]
 check_prevs_add kernel/locking/lockdep.c:3214 [inline]
 validate_chain kernel/locking/lockdep.c:3829 [inline]
 __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5053
 lock_acquire kernel/locking/lockdep.c:5666 [inline]
 lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
 try_to_wake_up+0xab/0x1e60 kernel/sched/core.c:4082
 autoremove_wake_function+0x12/0x140 kernel/sched/wait.c:415
 __wake_up_common+0x147/0x650 kernel/sched/wait.c:107
 __wake_up_common_lock+0xd0/0x130 kernel/sched/wait.c:137
 wakeup_kswapd+0x3fa/0x650 mm/vmscan.c:4597
 wake_all_kswapds+0x182/0x2d0 mm/page_alloc.c:4785
 __alloc_pages_slowpath.constprop.0+0x1732/0x2240 mm/page_alloc.c:5052
 __alloc_pages+0x43d/0x510 mm/page_alloc.c:5528
 alloc_pages+0x1a6/0x270 mm/mempolicy.c:2270
 alloc_slab_page mm/slub.c:1824 [inline]
 allocate_slab+0x27e/0x3d0 mm/slub.c:1969
 new_slab mm/slub.c:2029 [inline]
 ___slab_alloc+0x7f1/0xe10 mm/slub.c:3031
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3118
 slab_alloc_node mm/slub.c:3209 [inline]
 slab_alloc mm/slub.c:3251 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3258 [inline]
 kmem_cache_alloc+0x38c/0x3b0 mm/slub.c:3268
 kmem_cache_zalloc include/linux/slab.h:723 [inline]
 fill_pool+0x264/0x5c0 lib/debugobjects.c:168
 __debug_object_init+0x7a/0xd10 lib/debugobjects.c:562
 debug_object_init lib/debugobjects.c:617 [inline]
 debug_object_activate+0x32c/0x3e0 lib/debugobjects.c:703
 debug_timer_activate kernel/time/timer.c:782 [inline]
 __mod_timer+0x77d/0xe30 kernel/time/timer.c:1103
 __queue_delayed_work+0x1a7/0x270 kernel/workqueue.c:1676
 queue_delayed_work_on+0x105/0x120 kernel/workqueue.c:1701
 queue_delayed_work include/linux/workqueue.h:518 [inline]
 wg_ratelimiter_init+0x198/0x2c0 drivers/net/wireguard/ratelimiter.c:191
 wg_newlink+0x4f2/0x9a0 drivers/net/wireguard/device.c:367
 rtnl_newlink_create net/core/rtnetlink.c:3363 [inline]
 __rtnl_newlink+0x1087/0x17e0 net/core/rtnetlink.c:3580
 rtnl_newlink+0x64/0xa0 net/core/rtnetlink.c:3593
 rtnetlink_rcv_msg+0x43a/0xca0 net/core/rtnetlink.c:6090
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2501
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x543/0x7f0 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x917/0xe10 net/netlink/af_netlink.c:1921
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:734
 __sys_sendto+0x236/0x340 net/socket.c:2117
 __do_compat_sys_socketcall+0x47f/0x660 net/compat.c:472
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82
RIP: 0023:0xf7f06549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ffa72970 EFLAGS: 00000286 ORIG_RAX: 0000000000000066
RAX: ffffffffffffffda RBX: 000000000000000b RCX: 00000000ffa72984
RDX: 0000000000000000 RSI: 00000000f6f37000 RDI: 00000000f7e94288
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000286 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
bridge0: port 1(bridge_slave_0) entered blocking state
bridge0: port 1(bridge_slave_0) entered disabled state
device bridge_slave_0 entered promiscuous mode
bridge0: port 2(bridge_slave_1) entered blocking state
bridge0: port 2(bridge_slave_1) entered disabled state
device bridge_slave_1 entered promiscuous mode
bond0: (slave bond_slave_0): Enslaving as an active interface with an up link
bond0: (slave bond_slave_1): Enslaving as an active interface with an up link
team0: Port device team_slave_0 added
team0: Port device team_slave_1 added
batman_adv: batadv0: Adding interface: batadv_slave_0
batman_adv: batadv0: The MTU of interface batadv_slave_0 is too small (1500) to handle the transport of batman-adv packets. Packets going over this interface will be fragmented on layer2 which could impact the performance. Setting the MTU to 1560 would solve the problem.
batman_adv: batadv0: Not using interface batadv_slave_0 (retrying later): interface not active
batman_adv: batadv0: Adding interface: batadv_slave_1
batman_adv: batadv0: The MTU of interface batadv_slave_1 is too small (1500) to handle the transport of batman-adv packets. Packets going over this interface will be fragmented on layer2 which could impact the performance. Setting the MTU to 1560 would solve the problem.
batman_adv: batadv0: Not using interface batadv_slave_1 (retrying later): interface not active
device hsr_slave_0 entered promiscuous mode
device hsr_slave_1 entered promiscuous mode
netdevsim netdevsim0 netdevsim0: renamed from eth0
netdevsim netdevsim0 netdevsim1: renamed from eth1
netdevsim netdevsim0 netdevsim2: renamed from eth2
netdevsim netdevsim0 netdevsim3: renamed from eth3
8021q: adding VLAN 0 to HW filter on device bond0
8021q: adding VLAN 0 to HW filter on device team0
hsr0: Slave A (hsr_slave_0) is not up; please bring it up to get a fully working HSR network
hsr0: Slave B (hsr_slave_1) is not up; please bring it up to get a fully working HSR network
8021q: adding VLAN 0 to HW filter on device batadv0
device veth0_vlan entered promiscuous mode
device veth1_vlan entered promiscuous mode
device veth0_macvtap entered promiscuous mode
device veth1_macvtap entered promiscuous mode
batman_adv: The newly added mac address (aa:aa:aa:aa:aa:3d) already exists on: batadv_slave_0
batman_adv: It is strongly recommended to keep mac addresses unique to avoid problems!
batman_adv: batadv0: Interface activated: batadv_slave_0
batman_adv: The newly added mac address (aa:aa:aa:aa:aa:3e) already exists on: batadv_slave_1
batman_adv: It is strongly recommended to keep mac addresses unique to avoid problems!
batman_adv: batadv0: Interface activated: batadv_slave_1
netdevsim netdevsim0 netdevsim0: set [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 family 0 port 6081 - 0
----------------
Code disassembly (best guess):
   0:	03 74 c0 01          	add    0x1(%rax,%rax,8),%esi
   4:	10 05 03 74 b8 01    	adc    %al,0x1b87403(%rip)        # 0x1b8740d
   a:	10 06                	adc    %al,(%rsi)
   c:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
  10:	10 07                	adc    %al,(%rdi)
  12:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
  16:	10 08                	adc    %cl,(%rax)
  18:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1c:	00 00                	add    %al,(%rax)
  1e:	00 00                	add    %al,(%rax)
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:	55                   	push   %rbp
  24:	89 e5                	mov    %esp,%ebp
  26:	0f 34                	sysenter
  28:	cd 80                	int    $0x80
* 2a:	5d                   	pop    %rbp <-- trapping instruction
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	retq
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  39:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
