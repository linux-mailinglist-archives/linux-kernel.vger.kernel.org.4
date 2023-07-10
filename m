Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4484374DCD5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjGJRyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjGJRyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:54:01 -0400
Received: from mail-pl1-f207.google.com (mail-pl1-f207.google.com [209.85.214.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9026912E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 10:53:58 -0700 (PDT)
Received: by mail-pl1-f207.google.com with SMTP id d9443c01a7336-1b8a7734734so59341165ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 10:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689011638; x=1691603638;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s7hVIe12owKpTtlFQGjlo8cdWND75WSN9V3GkFsCPlY=;
        b=EtSSSzLe9xIBSd/T8b748wymfFrZzeJk+Nj5GCq30HdspygxHo1hhBorAtgbyQxDOz
         3h1vVSRhsqbsA1yBSwkL8G1nCqeyjFGnZ7JddMwAJ4RrtZhccO5iFKApUAs843Aus+n1
         VXCLMBY3+AlzUVUmDu2r/Y7gbC618xv8TwLWF9ITn6xCIIm0SAQSiqShEtrk7wlh4Toa
         VSiowMNQj4258Pilue6t1JuMCCzcj27pm564/64ZmXQB6LG1pc5HGkAptlaqHhRnzRmy
         Yd1HIHGgZjsrorfRXbnEvMGifXC/0d23P7eWV0byVEx839Rsh1REVZemiIlruPo+6DXC
         LGgQ==
X-Gm-Message-State: ABy/qLY41o9Xmu0TaSpCxt6qEphF06GRlmEODuPtCK3QkYp7wtbCTGcW
        mDydJrDoBwT504a2BGTejCG5q5wI9+xnNAMzaFekOBrv1QcQ
X-Google-Smtp-Source: APBJJlF20JdbFgJIJ2erkANhjva4OnNJRkaqCIcJELYiOog2zSMJ12R399YCvikukee25Q+HZ2YihzlC8eoh2JmBTrOKP1CVq7ar
MIME-Version: 1.0
X-Received: by 2002:a17:902:dacc:b0:1b8:866f:6fc1 with SMTP id
 q12-20020a170902dacc00b001b8866f6fc1mr13436030plx.0.1689011638072; Mon, 10
 Jul 2023 10:53:58 -0700 (PDT)
Date:   Mon, 10 Jul 2023 10:53:57 -0700
In-Reply-To: <0000000000008981d905ffa345de@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b57ce3060025aa46@google.com>
Subject: Re: [syzbot] [can?] possible deadlock in j1939_sk_errqueue (2)
From:   syzbot <syzbot+1591462f226d9cbf0564@syzkaller.appspotmail.com>
To:     astrajoan@yahoo.com, davem@davemloft.net, dvyukov@google.com,
        edumazet@google.com, ivan.orlov0322@gmail.com,
        kernel@pengutronix.de, kuba@kernel.org, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@rempel-privat.de,
        mkl@pengutronix.de, netdev@vger.kernel.org,
        o.rempel@pengutronix.de, pabeni@redhat.com, robin@protonic.nl,
        skhan@linuxfoundation.org, socketcan@hartkopp.net,
        syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    e40939bbfc68 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=17ce67d8a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c84f463eb74eab24
dashboard link: https://syzkaller.appspot.com/bug?extid=1591462f226d9cbf0564
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1580fc5ca80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=178f78d4a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/257596b75aaf/disk-e40939bb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9c75b8d61081/vmlinux-e40939bb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8f0233129f4f/Image-e40939bb.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1591462f226d9cbf0564@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.4.0-rc7-syzkaller-ge40939bbfc68 #0 Not tainted
------------------------------------------------------
syz-executor375/6045 is trying to acquire lock:
ffff0000d2e690d0 (&priv->j1939_socks_lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:355 [inline]
ffff0000d2e690d0 (&priv->j1939_socks_lock){+.-.}-{2:2}, at: j1939_sk_errqueue+0x90/0x144 net/can/j1939/socket.c:1081

but task is already holding lock:
ffff0000d2e69088 (&priv->active_session_list_lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:355 [inline]
ffff0000d2e69088 (&priv->active_session_list_lock){+.-.}-{2:2}, at: j1939_session_list_lock net/can/j1939/transport.c:238 [inline]
ffff0000d2e69088 (&priv->active_session_list_lock){+.-.}-{2:2}, at: j1939_cancel_active_session+0x54/0x414 net/can/j1939/transport.c:2183

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&priv->active_session_list_lock){+.-.}-{2:2}:
       __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
       _raw_spin_lock_bh+0x48/0x60 kernel/locking/spinlock.c:178
       spin_lock_bh include/linux/spinlock.h:355 [inline]
       j1939_session_list_lock net/can/j1939/transport.c:238 [inline]
       j1939_session_activate+0x60/0x378 net/can/j1939/transport.c:1564
       j1939_sk_queue_activate_next_locked net/can/j1939/socket.c:181 [inline]
       j1939_sk_queue_activate_next+0x230/0x3b4 net/can/j1939/socket.c:208
       j1939_session_deactivate_activate_next net/can/j1939/transport.c:1108 [inline]
       j1939_session_completed net/can/j1939/transport.c:1222 [inline]
       j1939_xtp_rx_eoma_one net/can/j1939/transport.c:1395 [inline]
       j1939_xtp_rx_eoma+0x2c0/0x4c0 net/can/j1939/transport.c:1410
       j1939_tp_cmd_recv net/can/j1939/transport.c:2099 [inline]
       j1939_tp_recv+0x714/0xe14 net/can/j1939/transport.c:2144
       j1939_can_recv+0x5bc/0x930 net/can/j1939/main.c:112
       deliver net/can/af_can.c:572 [inline]
       can_rcv_filter+0x308/0x714 net/can/af_can.c:606
       can_receive+0x338/0x498 net/can/af_can.c:663
       can_rcv+0x128/0x23c net/can/af_can.c:687
       __netif_receive_skb_one_core net/core/dev.c:5493 [inline]
       __netif_receive_skb+0x18c/0x400 net/core/dev.c:5607
       process_backlog+0x3c0/0x70c net/core/dev.c:5935
       __napi_poll+0xb4/0x648 net/core/dev.c:6498
       napi_poll net/core/dev.c:6565 [inline]
       net_rx_action+0x5e4/0xdc4 net/core/dev.c:6698
       __do_softirq+0x2d0/0xd54 kernel/softirq.c:571
       run_ksoftirqd+0x6c/0x158 kernel/softirq.c:939
       smpboot_thread_fn+0x4b0/0x920 kernel/smpboot.c:164
       kthread+0x288/0x310 kernel/kthread.c:379
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:853

-> #1 (&jsk->sk_session_queue_lock){+.-.}-{2:2}:
       __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
       _raw_spin_lock_bh+0x48/0x60 kernel/locking/spinlock.c:178
       spin_lock_bh include/linux/spinlock.h:355 [inline]
       j1939_sk_queue_drop_all+0x4c/0x200 net/can/j1939/socket.c:139
       j1939_sk_netdev_event_netdown+0xe0/0x144 net/can/j1939/socket.c:1280
       j1939_netdev_notify+0xf0/0x144 net/can/j1939/main.c:381
       notifier_call_chain+0x1a4/0x510 kernel/notifier.c:93
       raw_notifier_call_chain+0x3c/0x50 kernel/notifier.c:461
       __dev_notify_flags+0x2bc/0x544
       dev_change_flags+0xd0/0x15c net/core/dev.c:8645
       do_setlink+0xc68/0x35c8 net/core/rtnetlink.c:2867
       __rtnl_newlink net/core/rtnetlink.c:3648 [inline]
       rtnl_newlink+0x1354/0x1b1c net/core/rtnetlink.c:3695
       rtnetlink_rcv_msg+0x744/0xdb8 net/core/rtnetlink.c:6417
       netlink_rcv_skb+0x214/0x3c4 net/netlink/af_netlink.c:2546
       rtnetlink_rcv+0x28/0x38 net/core/rtnetlink.c:6435
       netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
       netlink_unicast+0x660/0x8d4 net/netlink/af_netlink.c:1365
       netlink_sendmsg+0x834/0xb18 net/netlink/af_netlink.c:1913
       sock_sendmsg_nosec net/socket.c:724 [inline]
       sock_sendmsg net/socket.c:747 [inline]
       ____sys_sendmsg+0x568/0x81c net/socket.c:2503
       ___sys_sendmsg net/socket.c:2557 [inline]
       __sys_sendmsg+0x26c/0x33c net/socket.c:2586
       __do_sys_sendmsg net/socket.c:2595 [inline]
       __se_sys_sendmsg net/socket.c:2593 [inline]
       __arm64_sys_sendmsg+0x80/0x94 net/socket.c:2593
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
       el0_svc_common+0x138/0x244 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:191
       el0_svc+0x4c/0x160 arch/arm64/kernel/entry-common.c:647
       el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591

-> #0 (&priv->j1939_socks_lock){+.-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3113 [inline]
       check_prevs_add kernel/locking/lockdep.c:3232 [inline]
       validate_chain kernel/locking/lockdep.c:3847 [inline]
       __lock_acquire+0x3308/0x7604 kernel/locking/lockdep.c:5088
       lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5705
       __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
       _raw_spin_lock_bh+0x48/0x60 kernel/locking/spinlock.c:178
       spin_lock_bh include/linux/spinlock.h:355 [inline]
       j1939_sk_errqueue+0x90/0x144 net/can/j1939/socket.c:1081
       __j1939_session_release net/can/j1939/transport.c:294 [inline]
       kref_put include/linux/kref.h:65 [inline]
       j1939_session_put+0xf0/0x4b4 net/can/j1939/transport.c:299
       j1939_session_deactivate_locked net/can/j1939/transport.c:1086 [inline]
       j1939_cancel_active_session+0x2ec/0x414 net/can/j1939/transport.c:2194
       j1939_netdev_notify+0xe8/0x144 net/can/j1939/main.c:380
       notifier_call_chain+0x1a4/0x510 kernel/notifier.c:93
       raw_notifier_call_chain+0x3c/0x50 kernel/notifier.c:461
       __dev_notify_flags+0x2bc/0x544
       dev_change_flags+0xd0/0x15c net/core/dev.c:8645
       do_setlink+0xc68/0x35c8 net/core/rtnetlink.c:2867
       __rtnl_newlink net/core/rtnetlink.c:3648 [inline]
       rtnl_newlink+0x1354/0x1b1c net/core/rtnetlink.c:3695
       rtnetlink_rcv_msg+0x744/0xdb8 net/core/rtnetlink.c:6417
       netlink_rcv_skb+0x214/0x3c4 net/netlink/af_netlink.c:2546
       rtnetlink_rcv+0x28/0x38 net/core/rtnetlink.c:6435
       netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
       netlink_unicast+0x660/0x8d4 net/netlink/af_netlink.c:1365
       netlink_sendmsg+0x834/0xb18 net/netlink/af_netlink.c:1913
       sock_sendmsg_nosec net/socket.c:724 [inline]
       sock_sendmsg net/socket.c:747 [inline]
       ____sys_sendmsg+0x568/0x81c net/socket.c:2503
       ___sys_sendmsg net/socket.c:2557 [inline]
       __sys_sendmsg+0x26c/0x33c net/socket.c:2586
       __do_sys_sendmsg net/socket.c:2595 [inline]
       __se_sys_sendmsg net/socket.c:2593 [inline]
       __arm64_sys_sendmsg+0x80/0x94 net/socket.c:2593
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
       el0_svc_common+0x138/0x244 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:191
       el0_svc+0x4c/0x160 arch/arm64/kernel/entry-common.c:647
       el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591

other info that might help us debug this:

Chain exists of:
  &priv->j1939_socks_lock --> &jsk->sk_session_queue_lock --> &priv->active_session_list_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&priv->active_session_list_lock);
                               lock(&jsk->sk_session_queue_lock);
                               lock(&priv->active_session_list_lock);
  lock(&priv->j1939_socks_lock);

 *** DEADLOCK ***

2 locks held by syz-executor375/6045:
 #0: ffff80009080db68 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:78 [inline]
 #0: ffff80009080db68 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x700/0xdb8 net/core/rtnetlink.c:6414
 #1: ffff0000d2e69088 (&priv->active_session_list_lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:355 [inline]
 #1: ffff0000d2e69088 (&priv->active_session_list_lock){+.-.}-{2:2}, at: j1939_session_list_lock net/can/j1939/transport.c:238 [inline]
 #1: ffff0000d2e69088 (&priv->active_session_list_lock){+.-.}-{2:2}, at: j1939_cancel_active_session+0x54/0x414 net/can/j1939/transport.c:2183

stack backtrace:
CPU: 1 PID: 6045 Comm: syz-executor375 Not tainted 6.4.0-rc7-syzkaller-ge40939bbfc68 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:233
 show_stack+0x2c/0x44 arch/arm64/kernel/stacktrace.c:240
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 dump_stack+0x1c/0x28 lib/dump_stack.c:113
 print_circular_bug+0x150/0x1b8 kernel/locking/lockdep.c:2066
 check_noncircular+0x2cc/0x378 kernel/locking/lockdep.c:2188
 check_prev_add kernel/locking/lockdep.c:3113 [inline]
 check_prevs_add kernel/locking/lockdep.c:3232 [inline]
 validate_chain kernel/locking/lockdep.c:3847 [inline]
 __lock_acquire+0x3308/0x7604 kernel/locking/lockdep.c:5088
 lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5705
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
 _raw_spin_lock_bh+0x48/0x60 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:355 [inline]
 j1939_sk_errqueue+0x90/0x144 net/can/j1939/socket.c:1081
 __j1939_session_release net/can/j1939/transport.c:294 [inline]
 kref_put include/linux/kref.h:65 [inline]
 j1939_session_put+0xf0/0x4b4 net/can/j1939/transport.c:299
 j1939_session_deactivate_locked net/can/j1939/transport.c:1086 [inline]
 j1939_cancel_active_session+0x2ec/0x414 net/can/j1939/transport.c:2194
 j1939_netdev_notify+0xe8/0x144 net/can/j1939/main.c:380
 notifier_call_chain+0x1a4/0x510 kernel/notifier.c:93
 raw_notifier_call_chain+0x3c/0x50 kernel/notifier.c:461
 __dev_notify_flags+0x2bc/0x544
 dev_change_flags+0xd0/0x15c net/core/dev.c:8645
 do_setlink+0xc68/0x35c8 net/core/rtnetlink.c:2867
 __rtnl_newlink net/core/rtnetlink.c:3648 [inline]
 rtnl_newlink+0x1354/0x1b1c net/core/rtnetlink.c:3695
 rtnetlink_rcv_msg+0x744/0xdb8 net/core/rtnetlink.c:6417
 netlink_rcv_skb+0x214/0x3c4 net/netlink/af_netlink.c:2546
 rtnetlink_rcv+0x28/0x38 net/core/rtnetlink.c:6435
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x660/0x8d4 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x834/0xb18 net/netlink/af_netlink.c:1913
 sock_sendmsg_nosec net/socket.c:724 [inline]
 sock_sendmsg net/socket.c:747 [inline]
 ____sys_sendmsg+0x568/0x81c net/socket.c:2503
 ___sys_sendmsg net/socket.c:2557 [inline]
 __sys_sendmsg+0x26c/0x33c net/socket.c:2586
 __do_sys_sendmsg net/socket.c:2595 [inline]
 __se_sys_sendmsg net/socket.c:2593 [inline]
 __arm64_sys_sendmsg+0x80/0x94 net/socket.c:2593
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x244 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:191
 el0_svc+0x4c/0x160 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
