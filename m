Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5600774697D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 08:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjGDGT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 02:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjGDGT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 02:19:57 -0400
Received: from mail-pj1-f78.google.com (mail-pj1-f78.google.com [209.85.216.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9811AA
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 23:19:55 -0700 (PDT)
Received: by mail-pj1-f78.google.com with SMTP id 98e67ed59e1d1-262d296873aso7476957a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 23:19:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688451595; x=1691043595;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h9zJkpdhcz8ZoyIzxv3ROL8wp9vBldRBuKkdUxQuZ4E=;
        b=IfwcanFHokKk0L+uFhU1qMG8v+OSgbmJQ25WkeJ//haZZWw9a/Nbuf2SVNKIPhBrd1
         LVY/D9K4oMNcHMHWsmy5zTlRYlPmlBCmG73+igzmMhbSdKol5pMP3GtYw9gFpeLT9kzk
         WeJ2ralawqaG7emyT6xu77Dt8RLsmzGn+tU7ofbC2tr2o3IG8iP0bMqJS9kHR/Nm6GGw
         MZYyNJDiRL6G2SL644kBhzptIRv+ThTZSwtNxEyRLz1sHkDlwDc44ceJFgK9RfFf7EiE
         xW8m6a3mFtw7t3utIBQt2+EsyLu5mDh/Y1A+WFiBz4CS6Xc/7cj+YPp3gzQgchkYgQ8j
         zWqw==
X-Gm-Message-State: ABy/qLZus2X/NMvf3Smb+jwAC/6dH7LSzBeX3zExFexsgqBnPT6xMimG
        n0Ck7OTRYluN0Znn3AzugLletDNErERh48It7CvkX/yPNJzo
X-Google-Smtp-Source: APBJJlGawPdYOWZZ3ie+Mq4hPSlDIM7HxaeHDsNLF7Q6XKAfvraucuVN28bpAwvEJmA0IyQM55WdWEP/PY4yFaZgJcvow058N5nN
MIME-Version: 1.0
X-Received: by 2002:a17:903:2790:b0:1b5:2496:8c10 with SMTP id
 jw16-20020a170903279000b001b524968c10mr10327455plb.2.1688451594943; Mon, 03
 Jul 2023 23:19:54 -0700 (PDT)
Date:   Mon, 03 Jul 2023 23:19:54 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008981d905ffa345de@google.com>
Subject: [syzbot] [can?] possible deadlock in j1939_sk_errqueue (2)
From:   syzbot <syzbot+1591462f226d9cbf0564@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, kernel@pengutronix.de,
        kuba@kernel.org, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@rempel-privat.de,
        mkl@pengutronix.de, netdev@vger.kernel.org, pabeni@redhat.com,
        robin@protonic.nl, socketcan@hartkopp.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ae230642190a Merge branch 'af_unix-followup-fixes-for-so_p..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1771bf67280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c9bf1936936ca698
dashboard link: https://syzkaller.appspot.com/bug?extid=1591462f226d9cbf0564
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8c060db03f09/disk-ae230642.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1b9b937ece91/vmlinux-ae230642.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0c7eb1c82bf0/bzImage-ae230642.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1591462f226d9cbf0564@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.4.0-rc7-syzkaller-01948-gae230642190a #0 Not tainted
------------------------------------------------------
syz-executor.2/11224 is trying to acquire lock:
ffff88803bee50d0 (&priv->j1939_socks_lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:355 [inline]
ffff88803bee50d0 (&priv->j1939_socks_lock){+.-.}-{2:2}, at: j1939_sk_errqueue+0xa3/0x1a0 net/can/j1939/socket.c:1081

but task is already holding lock:
ffff88803bee5088 (&priv->active_session_list_lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:355 [inline]
ffff88803bee5088 (&priv->active_session_list_lock){+.-.}-{2:2}, at: j1939_session_list_lock net/can/j1939/transport.c:238 [inline]
ffff88803bee5088 (&priv->active_session_list_lock){+.-.}-{2:2}, at: j1939_cancel_active_session+0x41/0x360 net/can/j1939/transport.c:2183

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&priv->active_session_list_lock){+.-.}-{2:2}:
       __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
       _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
       spin_lock_bh include/linux/spinlock.h:355 [inline]
       j1939_session_list_lock net/can/j1939/transport.c:238 [inline]
       j1939_session_activate+0x47/0x4b0 net/can/j1939/transport.c:1564
       j1939_sk_queue_activate_next_locked net/can/j1939/socket.c:181 [inline]
       j1939_sk_queue_activate_next+0x2bf/0x4d0 net/can/j1939/socket.c:208
       j1939_session_deactivate_activate_next net/can/j1939/transport.c:1108 [inline]
       j1939_xtp_rx_abort_one+0x3c0/0x5b0 net/can/j1939/transport.c:1351
       j1939_xtp_rx_abort net/can/j1939/transport.c:1362 [inline]
       j1939_tp_cmd_recv net/can/j1939/transport.c:2111 [inline]
       j1939_tp_recv+0xd98/0xf50 net/can/j1939/transport.c:2144
       j1939_can_recv net/can/j1939/main.c:112 [inline]
       j1939_can_recv+0x78e/0xa80 net/can/j1939/main.c:38
       deliver net/can/af_can.c:572 [inline]
       can_rcv_filter+0x5d4/0x8d0 net/can/af_can.c:606
       can_receive+0x31d/0x5c0 net/can/af_can.c:663
       can_rcv+0x1e1/0x280 net/can/af_can.c:687
       __netif_receive_skb_one_core+0x114/0x180 net/core/dev.c:5452
       __netif_receive_skb+0x1f/0x1c0 net/core/dev.c:5566
       process_backlog+0x101/0x670 net/core/dev.c:5894
       __napi_poll+0xb7/0x6f0 net/core/dev.c:6460
       napi_poll net/core/dev.c:6527 [inline]
       net_rx_action+0x8a9/0xcb0 net/core/dev.c:6660
       __do_softirq+0x1d4/0x905 kernel/softirq.c:571
       run_ksoftirqd kernel/softirq.c:939 [inline]
       run_ksoftirqd+0x31/0x60 kernel/softirq.c:931
       smpboot_thread_fn+0x659/0x9e0 kernel/smpboot.c:164
       kthread+0x344/0x440 kernel/kthread.c:379
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

-> #1 (&jsk->sk_session_queue_lock){+.-.}-{2:2}:
       __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
       _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
       spin_lock_bh include/linux/spinlock.h:355 [inline]
       j1939_sk_queue_drop_all+0x3b/0x2f0 net/can/j1939/socket.c:139
       j1939_sk_netdev_event_netdown+0x7f/0x160 net/can/j1939/socket.c:1280
       j1939_netdev_notify+0x19f/0x1d0 net/can/j1939/main.c:381
       notifier_call_chain+0xb6/0x3c0 kernel/notifier.c:93
       call_netdevice_notifiers_info+0xb9/0x130 net/core/dev.c:1962
       call_netdevice_notifiers_extack net/core/dev.c:2000 [inline]
       call_netdevice_notifiers net/core/dev.c:2014 [inline]
       __dev_notify_flags+0x1ea/0x2d0 net/core/dev.c:8571
       dev_change_flags+0x11b/0x170 net/core/dev.c:8607
       do_setlink+0x19e2/0x3ae0 net/core/rtnetlink.c:2867
       __rtnl_newlink+0xd85/0x1860 net/core/rtnetlink.c:3655
       rtnl_newlink+0x68/0xa0 net/core/rtnetlink.c:3702
       rtnetlink_rcv_msg+0x43d/0xd50 net/core/rtnetlink.c:6424
       netlink_rcv_skb+0x165/0x440 net/netlink/af_netlink.c:2549
       netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
       netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1365
       netlink_sendmsg+0x925/0xe30 net/netlink/af_netlink.c:1914
       sock_sendmsg_nosec net/socket.c:724 [inline]
       sock_sendmsg+0xde/0x190 net/socket.c:747
       ____sys_sendmsg+0x733/0x920 net/socket.c:2493
       ___sys_sendmsg+0x110/0x1b0 net/socket.c:2547
       __sys_sendmsg+0xf7/0x1c0 net/socket.c:2576
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&priv->j1939_socks_lock){+.-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3113 [inline]
       check_prevs_add kernel/locking/lockdep.c:3232 [inline]
       validate_chain kernel/locking/lockdep.c:3847 [inline]
       __lock_acquire+0x2fcd/0x5f30 kernel/locking/lockdep.c:5088
       lock_acquire kernel/locking/lockdep.c:5705 [inline]
       lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5670
       __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
       _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
       spin_lock_bh include/linux/spinlock.h:355 [inline]
       j1939_sk_errqueue+0xa3/0x1a0 net/can/j1939/socket.c:1081
       j1939_session_destroy+0x26c/0x4e0 net/can/j1939/transport.c:271
       __j1939_session_release net/can/j1939/transport.c:294 [inline]
       kref_put include/linux/kref.h:65 [inline]
       j1939_session_put net/can/j1939/transport.c:299 [inline]
       j1939_session_deactivate_locked net/can/j1939/transport.c:1086 [inline]
       j1939_session_deactivate_locked+0x293/0x340 net/can/j1939/transport.c:1074
       j1939_cancel_active_session+0x183/0x360 net/can/j1939/transport.c:2194
       j1939_netdev_notify+0x197/0x1d0 net/can/j1939/main.c:380
       notifier_call_chain+0xb6/0x3c0 kernel/notifier.c:93
       call_netdevice_notifiers_info+0xb9/0x130 net/core/dev.c:1962
       call_netdevice_notifiers_extack net/core/dev.c:2000 [inline]
       call_netdevice_notifiers net/core/dev.c:2014 [inline]
       __dev_notify_flags+0x1ea/0x2d0 net/core/dev.c:8571
       dev_change_flags+0x11b/0x170 net/core/dev.c:8607
       do_setlink+0x19e2/0x3ae0 net/core/rtnetlink.c:2867
       __rtnl_newlink+0xd85/0x1860 net/core/rtnetlink.c:3655
       rtnl_newlink+0x68/0xa0 net/core/rtnetlink.c:3702
       rtnetlink_rcv_msg+0x43d/0xd50 net/core/rtnetlink.c:6424
       netlink_rcv_skb+0x165/0x440 net/netlink/af_netlink.c:2549
       netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
       netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1365
       netlink_sendmsg+0x925/0xe30 net/netlink/af_netlink.c:1914
       sock_sendmsg_nosec net/socket.c:724 [inline]
       sock_sendmsg+0xde/0x190 net/socket.c:747
       ____sys_sendmsg+0x733/0x920 net/socket.c:2493
       ___sys_sendmsg+0x110/0x1b0 net/socket.c:2547
       __sys_sendmsg+0xf7/0x1c0 net/socket.c:2576
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

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

2 locks held by syz-executor.2/11224:
 #0: ffffffff8e1194a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:78 [inline]
 #0: ffffffff8e1194a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x3e8/0xd50 net/core/rtnetlink.c:6421
 #1: ffff88803bee5088 (&priv->active_session_list_lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:355 [inline]
 #1: ffff88803bee5088 (&priv->active_session_list_lock){+.-.}-{2:2}, at: j1939_session_list_lock net/can/j1939/transport.c:238 [inline]
 #1: ffff88803bee5088 (&priv->active_session_list_lock){+.-.}-{2:2}, at: j1939_cancel_active_session+0x41/0x360 net/can/j1939/transport.c:2183

stack backtrace:
CPU: 1 PID: 11224 Comm: syz-executor.2 Not tainted 6.4.0-rc7-syzkaller-01948-gae230642190a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2188
 check_prev_add kernel/locking/lockdep.c:3113 [inline]
 check_prevs_add kernel/locking/lockdep.c:3232 [inline]
 validate_chain kernel/locking/lockdep.c:3847 [inline]
 __lock_acquire+0x2fcd/0x5f30 kernel/locking/lockdep.c:5088
 lock_acquire kernel/locking/lockdep.c:5705 [inline]
 lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5670
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
 _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:355 [inline]
 j1939_sk_errqueue+0xa3/0x1a0 net/can/j1939/socket.c:1081
 j1939_session_destroy+0x26c/0x4e0 net/can/j1939/transport.c:271
 __j1939_session_release net/can/j1939/transport.c:294 [inline]
 kref_put include/linux/kref.h:65 [inline]
 j1939_session_put net/can/j1939/transport.c:299 [inline]
 j1939_session_deactivate_locked net/can/j1939/transport.c:1086 [inline]
 j1939_session_deactivate_locked+0x293/0x340 net/can/j1939/transport.c:1074
 j1939_cancel_active_session+0x183/0x360 net/can/j1939/transport.c:2194
 j1939_netdev_notify+0x197/0x1d0 net/can/j1939/main.c:380
 notifier_call_chain+0xb6/0x3c0 kernel/notifier.c:93
 call_netdevice_notifiers_info+0xb9/0x130 net/core/dev.c:1962
 call_netdevice_notifiers_extack net/core/dev.c:2000 [inline]
 call_netdevice_notifiers net/core/dev.c:2014 [inline]
 __dev_notify_flags+0x1ea/0x2d0 net/core/dev.c:8571
 dev_change_flags+0x11b/0x170 net/core/dev.c:8607
 do_setlink+0x19e2/0x3ae0 net/core/rtnetlink.c:2867
 __rtnl_newlink+0xd85/0x1860 net/core/rtnetlink.c:3655
 rtnl_newlink+0x68/0xa0 net/core/rtnetlink.c:3702
 rtnetlink_rcv_msg+0x43d/0xd50 net/core/rtnetlink.c:6424
 netlink_rcv_skb+0x165/0x440 net/netlink/af_netlink.c:2549
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x925/0xe30 net/netlink/af_netlink.c:1914
 sock_sendmsg_nosec net/socket.c:724 [inline]
 sock_sendmsg+0xde/0x190 net/socket.c:747
 ____sys_sendmsg+0x733/0x920 net/socket.c:2493
 ___sys_sendmsg+0x110/0x1b0 net/socket.c:2547
 __sys_sendmsg+0xf7/0x1c0 net/socket.c:2576
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fdb2bc8c389
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdb2cab9168 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fdb2bdabf80 RCX: 00007fdb2bc8c389
RDX: 0000000000000000 RSI: 00000000200000c0 RDI: 0000000000000006
RBP: 00007fdb2bcd7493 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd70d89bbf R14: 00007fdb2cab9300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
