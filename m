Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893DD738934
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbjFUPcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbjFUPbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:31:44 -0400
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44ADF1988
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:31:18 -0700 (PDT)
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-77d99de0e9bso548041739f.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687361467; x=1689953467;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MjsUVnFk8eOEzkwWUeTDGT5qsOOJTHmbl4qYcExeKtw=;
        b=X95kyNhnRvThU+xc6Fmo7GIV0pM1Ex6vAQPtdJ+dQQuEkqaqOfsaRpdY0IF2enbJ+D
         83XsssIMx3cXyQA+acWtwQlJtDsuc7Kzdwm1aPRK35sg60qB63530r6y7ico/5PHWKXe
         +qnyEUmSqoZNQaAx/2rlBe4r7nM4ElkH3Nqv8FEMu7enSq5OmBI9lyGgSVDglvCikv8K
         X1rxHQr76nTZ6mPNMtR5nG6CAV94R5P+DBtK+hRl4NrTxiku+5DfLyi4YBAp2eOHUfwD
         f18CZILoa2h8Slv1sG2LKy+YNK0k9+zSRjKxu6bd+eF+VZRNnIICw4pnCvJIoEdIwPrR
         2FwQ==
X-Gm-Message-State: AC+VfDyFXxF4xxRuwhjEjBI2M3ww/QzpkORIxAMIwbJ84fGy36joZ9G6
        COqCJQKfRBQSH/OEP2ybfOoXTLmmtBqtiQYcQrnpLvjZy0Rw
X-Google-Smtp-Source: ACHHUZ616R4kT3wh7IPwIkpQ5nimULLQphrr9UCy8wkm2hUfKYvRNiXo2B7fU7h2YmODyJp1usYfyPgWSg9O/yJZC9bABDNFbH/4
MIME-Version: 1.0
X-Received: by 2002:a02:a103:0:b0:423:d1b:9c8c with SMTP id
 f3-20020a02a103000000b004230d1b9c8cmr5618648jag.3.1687361467679; Wed, 21 Jun
 2023 08:31:07 -0700 (PDT)
Date:   Wed, 21 Jun 2023 08:31:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e38d1605fea5747e@google.com>
Subject: [syzbot] [net?] possible deadlock in netlink_set_err
From:   syzbot <syzbot+a7d200a347f912723e5c@syzkaller.appspotmail.com>
To:     bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4e9f0ec38852 wifi: iwlwifi: pcie: Handle SO-F device for P..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=159c29eb280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ac246111fb601aec
dashboard link: https://syzkaller.appspot.com/bug?extid=a7d200a347f912723e5c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8866213bd704/disk-4e9f0ec3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5ae048a89b9b/vmlinux-4e9f0ec3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2a5e193eed3a/bzImage-4e9f0ec3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a7d200a347f912723e5c@syzkaller.appspotmail.com

RAX: ffffffffffffffda RBX: 00007f887bbabf80 RCX: 00007f887ba8c389
RDX: 0000000000000000 RSI: 0000000020000080 RDI: 0000000000000006
RBP: 00007f887c7651d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffc4dd1155f R14: 00007f887c765300 R15: 0000000000022000
 </TASK>
========================================================
WARNING: possible irq lock inversion dependency detected
6.4.0-rc6-syzkaller-00240-g4e9f0ec38852 #0 Not tainted
--------------------------------------------------------
syz-executor.2/23011 just changed the state of lock:
ffffffff8e1a7a58 (nl_table_lock){.+.?}-{2:2}, at: netlink_set_err+0x2e/0x3a0 net/netlink/af_netlink.c:1612
but this lock was taken by another, SOFTIRQ-safe lock in the past:
 (&local->queue_stop_reason_lock){..-.}-{2:2}


and interrupts could create inverse lock ordering between them.


other info that might help us debug this:
 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(nl_table_lock);
                               local_irq_disable();
                               lock(&local->queue_stop_reason_lock);
                               lock(nl_table_lock);
  <Interrupt>
    lock(&local->queue_stop_reason_lock);

 *** DEADLOCK ***

1 lock held by syz-executor.2/23011:
 #0: ffffffff8e115ba8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:78 [inline]
 #0: ffffffff8e115ba8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x3e8/0xd50 net/core/rtnetlink.c:6414

the shortest dependencies between 2nd lock and 1st lock:
 -> (&local->queue_stop_reason_lock){..-.}-{2:2} {
    IN-SOFTIRQ-W at:
                      lock_acquire kernel/locking/lockdep.c:5705 [inline]
                      lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5670
                      __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                      _raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:162
                      ieee80211_tx_dequeue+0x1f2/0x1d50 net/mac80211/tx.c:3803
                      wake_tx_push_queue net/mac80211/util.c:301 [inline]
                      ieee80211_handle_wake_tx_queue+0x197/0x260 net/mac80211/util.c:322
                      drv_wake_tx_queue net/mac80211/driver-ops.h:1241 [inline]
                      schedule_and_wake_txq net/mac80211/driver-ops.h:1248 [inline]
                      ieee80211_queue_skb+0x1281/0x2040 net/mac80211/tx.c:1680
                      ieee80211_tx+0x2d2/0x420 net/mac80211/tx.c:1982
                      ieee80211_xmit+0x30e/0x3e0 net/mac80211/tx.c:2078
                      __ieee80211_subif_start_xmit+0xa62/0x1390 net/mac80211/tx.c:4312
                      ieee80211_subif_start_xmit+0xf0/0x1370 net/mac80211/tx.c:4504
                      __netdev_start_xmit include/linux/netdevice.h:4918 [inline]
                      netdev_start_xmit include/linux/netdevice.h:4932 [inline]
                      xmit_one net/core/dev.c:3578 [inline]
                      dev_hard_start_xmit+0x187/0x700 net/core/dev.c:3594
                      __dev_queue_xmit+0x2be2/0x3b10 net/core/dev.c:4244
                      dev_queue_xmit include/linux/netdevice.h:3088 [inline]
                      neigh_hh_output include/net/neighbour.h:528 [inline]
                      neigh_output include/net/neighbour.h:542 [inline]
                      ip6_finish_output2+0xfbd/0x1560 net/ipv6/ip6_output.c:134
                      __ip6_finish_output net/ipv6/ip6_output.c:195 [inline]
                      ip6_finish_output+0x69a/0x1170 net/ipv6/ip6_output.c:206
                      NF_HOOK_COND include/linux/netfilter.h:292 [inline]
                      ip6_output+0x1f1/0x540 net/ipv6/ip6_output.c:227
                      dst_output include/net/dst.h:458 [inline]
                      NF_HOOK include/linux/netfilter.h:303 [inline]
                      ndisc_send_skb+0xa63/0x1850 net/ipv6/ndisc.c:508
                      ndisc_send_rs+0x132/0x6f0 net/ipv6/ndisc.c:718
                      addrconf_rs_timer+0x3f1/0x870 net/ipv6/addrconf.c:3936
                      call_timer_fn+0x1a0/0x580 kernel/time/timer.c:1700
                      expire_timers+0x29b/0x4b0 kernel/time/timer.c:1751
                      __run_timers kernel/time/timer.c:2022 [inline]
                      __run_timers kernel/time/timer.c:1995 [inline]
                      run_timer_softirq+0x326/0x910 kernel/time/timer.c:2035
                      __do_softirq+0x1d4/0x905 kernel/softirq.c:571
                      invoke_softirq kernel/softirq.c:445 [inline]
                      __irq_exit_rcu+0x114/0x190 kernel/softirq.c:650
                      irq_exit_rcu+0x9/0x20 kernel/softirq.c:662
                      sysvec_apic_timer_interrupt+0x97/0xc0 arch/x86/kernel/apic/apic.c:1106
                      asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
                      __sanitizer_cov_trace_pc+0x60/0x70 kernel/kcov.c:223
                      is_cow_mapping include/linux/mm.h:1543 [inline]
                      copy_present_pte mm/memory.c:957 [inline]
                      copy_pte_range mm/memory.c:1064 [inline]
                      copy_pmd_range mm/memory.c:1150 [inline]
                      copy_pud_range mm/memory.c:1187 [inline]
                      copy_p4d_range mm/memory.c:1211 [inline]
                      copy_page_range+0xfc4/0x3830 mm/memory.c:1309
                      dup_mmap+0x10bc/0x19d0 kernel/fork.c:761
                      dup_mm kernel/fork.c:1692 [inline]
                      copy_mm kernel/fork.c:1741 [inline]
                      copy_process+0x6663/0x75c0 kernel/fork.c:2507
                      kernel_clone+0xeb/0x890 kernel/fork.c:2915
                      __do_sys_clone+0xba/0x100 kernel/fork.c:3058
                      do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                      do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
                      entry_SYSCALL_64_after_hwframe+0x63/0xcd
    INITIAL USE at:
                     lock_acquire kernel/locking/lockdep.c:5705 [inline]
                     lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5670
                     __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                     _raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:162
                     ieee80211_tx_dequeue+0x1f2/0x1d50 net/mac80211/tx.c:3803
                     wake_tx_push_queue net/mac80211/util.c:301 [inline]
                     ieee80211_handle_wake_tx_queue+0x197/0x260 net/mac80211/util.c:322
                     drv_wake_tx_queue net/mac80211/driver-ops.h:1241 [inline]
                     schedule_and_wake_txq net/mac80211/driver-ops.h:1248 [inline]
                     ieee80211_queue_skb+0x1281/0x2040 net/mac80211/tx.c:1680
                     ieee80211_tx+0x2d2/0x420 net/mac80211/tx.c:1982
                     ieee80211_xmit+0x30e/0x3e0 net/mac80211/tx.c:2078
                     __ieee80211_subif_start_xmit+0xa62/0x1390 net/mac80211/tx.c:4312
                     ieee80211_subif_start_xmit+0xf0/0x1370 net/mac80211/tx.c:4504
                     __netdev_start_xmit include/linux/netdevice.h:4918 [inline]
                     netdev_start_xmit include/linux/netdevice.h:4932 [inline]
                     xmit_one net/core/dev.c:3578 [inline]
                     dev_hard_start_xmit+0x187/0x700 net/core/dev.c:3594
                     __dev_queue_xmit+0x2be2/0x3b10 net/core/dev.c:4244
                     dev_queue_xmit include/linux/netdevice.h:3088 [inline]
                     neigh_resolve_output net/core/neighbour.c:1552 [inline]
                     neigh_resolve_output+0x51b/0x870 net/core/neighbour.c:1532
                     neigh_output include/net/neighbour.h:544 [inline]
                     ip6_finish_output2+0x55a/0x1560 net/ipv6/ip6_output.c:134
                     __ip6_finish_output net/ipv6/ip6_output.c:195 [inline]
                     ip6_finish_output+0x69a/0x1170 net/ipv6/ip6_output.c:206
                     NF_HOOK_COND include/linux/netfilter.h:292 [inline]
                     ip6_output+0x1f1/0x540 net/ipv6/ip6_output.c:227
                     dst_output include/net/dst.h:458 [inline]
                     NF_HOOK include/linux/netfilter.h:303 [inline]
                     NF_HOOK include/linux/netfilter.h:297 [inline]
                     mld_sendpack+0xa09/0xed0 net/ipv6/mcast.c:1820
                     mld_send_cr net/ipv6/mcast.c:2121 [inline]
                     mld_ifc_work+0x73c/0xe20 net/ipv6/mcast.c:2653
                     process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
                     worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
                     kthread+0x344/0x440 kernel/kthread.c:379
                     ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
  }
  ... key      at: [<ffffffff921be140>] __key.19+0x0/0x40
  ... acquired at:
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
   _raw_read_lock_irqsave+0x74/0x90 kernel/locking/spinlock.c:236
   netlink_lock_table net/netlink/af_netlink.c:472 [inline]
   netlink_broadcast+0x74/0xd90 net/netlink/af_netlink.c:1533
   nlmsg_multicast include/net/netlink.h:1083 [inline]
   genlmsg_multicast_netns include/net/genetlink.h:392 [inline]
   nl80211_frame_tx_status+0x9dc/0xc20 net/wireless/nl80211.c:18807
   ieee80211_report_ack_skb net/mac80211/status.c:680 [inline]
   ieee80211_report_used_skb+0x107f/0x1a10 net/mac80211/status.c:763
   ieee80211_free_txskb+0x24/0x40 net/mac80211/status.c:1260
   ieee80211_do_stop+0xc71/0x1f50 net/mac80211/iface.c:640
   ieee80211_runtime_change_iftype net/mac80211/iface.c:1866 [inline]
   ieee80211_if_change_type+0x416/0x8b0 net/mac80211/iface.c:1904
   ieee80211_change_iface+0x5b/0x440 net/mac80211/cfg.c:217
   rdev_change_virtual_intf net/wireless/rdev-ops.h:74 [inline]
   cfg80211_change_iface+0x5c1/0xe00 net/wireless/util.c:1163
   nl80211_set_interface+0x695/0x960 net/wireless/nl80211.c:4217
   genl_family_rcv_msg_doit.isra.0+0x1e6/0x2d0 net/netlink/genetlink.c:968
   genl_family_rcv_msg net/netlink/genetlink.c:1048 [inline]
   genl_rcv_msg+0x4ff/0x7e0 net/netlink/genetlink.c:1065
   netlink_rcv_skb+0x165/0x440 net/netlink/af_netlink.c:2546
   genl_rcv+0x28/0x40 net/netlink/genetlink.c:1076
   netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
   netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1365
   netlink_sendmsg+0x925/0xe30 net/netlink/af_netlink.c:1913
   sock_sendmsg_nosec net/socket.c:724 [inline]
   sock_sendmsg+0xde/0x190 net/socket.c:747
   ____sys_sendmsg+0x71c/0x900 net/socket.c:2503
   ___sys_sendmsg+0x110/0x1b0 net/socket.c:2557
   __sys_sendmsg+0xf7/0x1c0 net/socket.c:2586
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> (nl_table_lock){.+.?}-{2:2} {
   HARDIRQ-ON-R at:
                    lock_acquire kernel/locking/lockdep.c:5705 [inline]
                    lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5670
                    __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                    _raw_read_lock+0x5f/0x70 kernel/locking/spinlock.c:228
                    netlink_set_err+0x2e/0x3a0 net/netlink/af_netlink.c:1612
                    rtnl_set_sk_err net/core/rtnetlink.c:779 [inline]
                    rtmsg_ifinfo_build_skb+0x226/0x280 net/core/rtnetlink.c:4029
                    rtmsg_ifinfo_event net/core/rtnetlink.c:4051 [inline]
                    rtmsg_ifinfo_event net/core/rtnetlink.c:4041 [inline]
                    rtmsg_ifinfo+0x9f/0x1a0 net/core/rtnetlink.c:4060
                    netdev_state_change net/core/dev.c:1319 [inline]
                    netdev_state_change+0x11e/0x130 net/core/dev.c:1310
                    do_setlink+0x2f6a/0x3b70 net/core/rtnetlink.c:3102
                    rtnl_group_changelink net/core/rtnetlink.c:3402 [inline]
                    __rtnl_newlink+0xb90/0x1840 net/core/rtnetlink.c:3658
                    rtnl_newlink+0x68/0xa0 net/core/rtnetlink.c:3695
                    rtnetlink_rcv_msg+0x43d/0xd50 net/core/rtnetlink.c:6417
                    netlink_rcv_skb+0x165/0x440 net/netlink/af_netlink.c:2546
                    netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
                    netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1365
                    netlink_sendmsg+0x925/0xe30 net/netlink/af_netlink.c:1913
                    sock_sendmsg_nosec net/socket.c:724 [inline]
                    sock_sendmsg+0xde/0x190 net/socket.c:747
                    ____sys_sendmsg+0x71c/0x900 net/socket.c:2503
                    ___sys_sendmsg+0x110/0x1b0 net/socket.c:2557
                    __sys_sendmsg+0xf7/0x1c0 net/socket.c:2586
                    do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                    do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
                    entry_SYSCALL_64_after_hwframe+0x63/0xcd
   IN-SOFTIRQ-R at:
                    lock_acquire kernel/locking/lockdep.c:5705 [inline]
                    lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5670
                    __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
                    _raw_read_lock_irqsave+0x49/0x90 kernel/locking/spinlock.c:236
                    netlink_lock_table net/netlink/af_netlink.c:472 [inline]
                    netlink_broadcast+0x74/0xd90 net/netlink/af_netlink.c:1533
                    nlmsg_multicast include/net/netlink.h:1083 [inline]
                    nlmsg_notify+0x93/0x280 net/netlink/af_netlink.c:2589
                    __neigh_notify+0xdc/0x160 net/core/neighbour.c:3513
                    neigh_update_notify net/core/neighbour.c:2655 [inline]
                    __neigh_update+0x109a/0x2bb0 net/core/neighbour.c:1469
                    arp_process+0x863/0x21b0 net/ipv4/arp.c:932
                    NF_HOOK include/linux/netfilter.h:303 [inline]
                    NF_HOOK include/linux/netfilter.h:297 [inline]
                    arp_rcv net/ipv4/arp.c:988 [inline]
                    arp_rcv+0x3d2/0x540 net/ipv4/arp.c:963
                    __netif_receive_skb_list_ptype net/core/dev.c:5541 [inline]
                    __netif_receive_skb_list_ptype net/core/dev.c:5525 [inline]
                    __netif_receive_skb_list_core+0x6c6/0x8f0 net/core/dev.c:5584
                    __netif_receive_skb_list net/core/dev.c:5636 [inline]
                    netif_receive_skb_list_internal+0x75f/0xdc0 net/core/dev.c:5727
                    gro_normal_list include/net/gro.h:433 [inline]
                    gro_normal_list include/net/gro.h:429 [inline]
                    napi_complete_done+0x243/0x9a0 net/core/dev.c:6067
                    virtqueue_napi_complete drivers/net/virtio_net.c:408 [inline]
                    virtnet_poll+0xe2b/0x14b0 drivers/net/virtio_net.c:1858
                    __napi_poll+0xb7/0x6f0 net/core/dev.c:6498
                    napi_poll net/core/dev.c:6565 [inline]
                    net_rx_action+0x8a9/0xcb0 net/core/dev.c:6698
                    __do_softirq+0x1d4/0x905 kernel/softirq.c:571
                    invoke_softirq kernel/softirq.c:445 [inline]
                    __irq_exit_rcu+0x114/0x190 kernel/softirq.c:650
                    irq_exit_rcu+0x9/0x20 kernel/softirq.c:662
                    common_interrupt+0xad/0xd0 arch/x86/kernel/irq.c:240
                    asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:636
                    rep_nop arch/x86/include/asm/vdso/processor.h:13 [inline]
                    cpu_relax arch/x86/include/asm/vdso/processor.h:18 [inline]
                    csd_lock_wait kernel/smp.c:285 [inline]
                    smp_call_function_many_cond+0x67f/0x15a0 kernel/smp.c:828
                    on_each_cpu_cond_mask+0x5a/0xa0 kernel/smp.c:996
                    on_each_cpu include/linux/smp.h:71 [inline]
                    text_poke_sync arch/x86/kernel/alternative.c:1770 [inline]
                    text_poke_bp_batch+0x634/0x770 arch/x86/kernel/alternative.c:2053
                    text_poke_flush arch/x86/kernel/alternative.c:2161 [inline]
                    text_poke_flush arch/x86/kernel/alternative.c:2158 [inline]
                    text_poke_finish+0x1a/0x30 arch/x86/kernel/alternative.c:2168
                    arch_jump_label_transform_apply+0x17/0x30 arch/x86/kernel/jump_label.c:146
                    jump_label_update+0x32f/0x410 kernel/jump_label.c:829
                    static_key_disable_cpuslocked+0x156/0x1b0 kernel/jump_label.c:235
                    static_key_disable+0x1a/0x20 kernel/jump_label.c:243
                    once_deferred+0x68/0xc0 lib/once.c:20
                    process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
                    worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
                    kthread+0x344/0x440 kernel/kthread.c:379
                    ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
   SOFTIRQ-ON-R at:
                    lock_acquire kernel/locking/lockdep.c:5705 [inline]
                    lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5670
                    __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                    _raw_read_lock+0x5f/0x70 kernel/locking/spinlock.c:228
                    netlink_set_err+0x2e/0x3a0 net/netlink/af_netlink.c:1612
                    rtnl_set_sk_err net/core/rtnetlink.c:779 [inline]
                    rtmsg_ifinfo_build_skb+0x226/0x280 net/core/rtnetlink.c:4029
                    rtmsg_ifinfo_event net/core/rtnetlink.c:4051 [inline]
                    rtmsg_ifinfo_event net/core/rtnetlink.c:4041 [inline]
                    rtmsg_ifinfo+0x9f/0x1a0 net/core/rtnetlink.c:4060
                    netdev_state_change net/core/dev.c:1319 [inline]
                    netdev_state_change+0x11e/0x130 net/core/dev.c:1310
                    do_setlink+0x2f6a/0x3b70 net/core/rtnetlink.c:3102
                    rtnl_group_changelink net/core/rtnetlink.c:3402 [inline]
                    __rtnl_newlink+0xb90/0x1840 net/core/rtnetlink.c:3658
                    rtnl_newlink+0x68/0xa0 net/core/rtnetlink.c:3695
                    rtnetlink_rcv_msg+0x43d/0xd50 net/core/rtnetlink.c:6417
                    netlink_rcv_skb+0x165/0x440 net/netlink/af_netlink.c:2546
                    netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
                    netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1365
                    netlink_sendmsg+0x925/0xe30 net/netlink/af_netlink.c:1913
                    sock_sendmsg_nosec net/socket.c:724 [inline]
                    sock_sendmsg+0xde/0x190 net/socket.c:747
                    ____sys_sendmsg+0x71c/0x900 net/socket.c:2503
                    ___sys_sendmsg+0x110/0x1b0 net/socket.c:2557
                    __sys_sendmsg+0xf7/0x1c0 net/socket.c:2586
                    do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                    do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
                    entry_SYSCALL_64_after_hwframe+0x63/0xcd
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5705 [inline]
                   lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5670
                   __raw_write_lock_irq include/linux/rwlock_api_smp.h:195 [inline]
                   _raw_write_lock_irq+0x36/0x50 kernel/locking/spinlock.c:326
                   netlink_table_grab net/netlink/af_netlink.c:438 [inline]
                   netlink_add_usersock_entry net/netlink/af_netlink.c:2851 [inline]
                   netlink_proto_init+0x158/0x3d0 net/netlink/af_netlink.c:2942
                   do_one_initcall+0x102/0x540 init/main.c:1246
                   do_initcall_level init/main.c:1319 [inline]
                   do_initcalls init/main.c:1335 [inline]
                   do_basic_setup init/main.c:1354 [inline]
                   kernel_init_freeable+0x64e/0xba0 init/main.c:1571
                   kernel_init+0x1e/0x2c0 init/main.c:1462
                   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
   INITIAL READ USE at:
                        lock_acquire kernel/locking/lockdep.c:5705 [inline]
                        lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5670
                        __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
                        _raw_read_lock_irqsave+0x74/0x90 kernel/locking/spinlock.c:236
                        netlink_lock_table net/netlink/af_netlink.c:472 [inline]
                        netlink_broadcast+0x74/0xd90 net/netlink/af_netlink.c:1533
                        nlmsg_multicast include/net/netlink.h:1083 [inline]
                        genlmsg_multicast_netns include/net/genetlink.h:392 [inline]
                        genl_ctrl_event.isra.0+0x3be/0xa50 net/netlink/genetlink.c:1360
                        genl_register_family.part.0+0x72b/0xf20 net/netlink/genetlink.c:675
                        genl_register_family+0x35/0x50 net/netlink/genetlink.c:635
                        thermal_init+0x16/0x370 drivers/thermal/thermal_core.c:1533
                        do_one_initcall+0x102/0x540 init/main.c:1246
                        do_initcall_level init/main.c:1319 [inline]
                        do_initcalls init/main.c:1335 [inline]
                        do_basic_setup init/main.c:1354 [inline]
                        kernel_init_freeable+0x64e/0xba0 init/main.c:1571
                        kernel_init+0x1e/0x2c0 init/main.c:1462
                        ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 }
 ... key      at: [<ffffffff8e1a7a58>] nl_table_lock+0x18/0x60
 ... acquired at:
   mark_lock kernel/locking/lockdep.c:4620 [inline]
   mark_usage kernel/locking/lockdep.c:4569 [inline]
   __lock_acquire+0x8ef/0x5f30 kernel/locking/lockdep.c:5042
   lock_acquire kernel/locking/lockdep.c:5705 [inline]
   lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5670
   __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
   _raw_read_lock+0x5f/0x70 kernel/locking/spinlock.c:228
   netlink_set_err+0x2e/0x3a0 net/netlink/af_netlink.c:1612
   rtnl_set_sk_err net/core/rtnetlink.c:779 [inline]
   rtmsg_ifinfo_build_skb+0x226/0x280 net/core/rtnetlink.c:4029
   rtmsg_ifinfo_event net/core/rtnetlink.c:4051 [inline]
   rtmsg_ifinfo_event net/core/rtnetlink.c:4041 [inline]
   rtmsg_ifinfo+0x9f/0x1a0 net/core/rtnetlink.c:4060
   netdev_state_change net/core/dev.c:1319 [inline]
   netdev_state_change+0x11e/0x130 net/core/dev.c:1310
   do_setlink+0x2f6a/0x3b70 net/core/rtnetlink.c:3102
   rtnl_group_changelink net/core/rtnetlink.c:3402 [inline]
   __rtnl_newlink+0xb90/0x1840 net/core/rtnetlink.c:3658
   rtnl_newlink+0x68/0xa0 net/core/rtnetlink.c:3695
   rtnetlink_rcv_msg+0x43d/0xd50 net/core/rtnetlink.c:6417
   netlink_rcv_skb+0x165/0x440 net/netlink/af_netlink.c:2546
   netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
   netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1365
   netlink_sendmsg+0x925/0xe30 net/netlink/af_netlink.c:1913
   sock_sendmsg_nosec net/socket.c:724 [inline]
   sock_sendmsg+0xde/0x190 net/socket.c:747
   ____sys_sendmsg+0x71c/0x900 net/socket.c:2503
   ___sys_sendmsg+0x110/0x1b0 net/socket.c:2557
   __sys_sendmsg+0xf7/0x1c0 net/socket.c:2586
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x63/0xcd


stack backtrace:
CPU: 0 PID: 23011 Comm: syz-executor.2 Not tainted 6.4.0-rc6-syzkaller-00240-g4e9f0ec38852 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_irq_inversion_bug.part.0+0x3d9/0x580 kernel/locking/lockdep.c:4058
 print_irq_inversion_bug kernel/locking/lockdep.c:4011 [inline]
 check_usage_backwards kernel/locking/lockdep.c:4124 [inline]
 mark_lock_irq kernel/locking/lockdep.c:4214 [inline]
 mark_lock.part.0+0x822/0x1970 kernel/locking/lockdep.c:4656
 mark_lock kernel/locking/lockdep.c:4620 [inline]
 mark_usage kernel/locking/lockdep.c:4569 [inline]
 __lock_acquire+0x8ef/0x5f30 kernel/locking/lockdep.c:5042
 lock_acquire kernel/locking/lockdep.c:5705 [inline]
 lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5670
 __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
 _raw_read_lock+0x5f/0x70 kernel/locking/spinlock.c:228
 netlink_set_err+0x2e/0x3a0 net/netlink/af_netlink.c:1612
 rtnl_set_sk_err net/core/rtnetlink.c:779 [inline]
 rtmsg_ifinfo_build_skb+0x226/0x280 net/core/rtnetlink.c:4029
 rtmsg_ifinfo_event net/core/rtnetlink.c:4051 [inline]
 rtmsg_ifinfo_event net/core/rtnetlink.c:4041 [inline]
 rtmsg_ifinfo+0x9f/0x1a0 net/core/rtnetlink.c:4060
 netdev_state_change net/core/dev.c:1319 [inline]
 netdev_state_change+0x11e/0x130 net/core/dev.c:1310
 do_setlink+0x2f6a/0x3b70 net/core/rtnetlink.c:3102
 rtnl_group_changelink net/core/rtnetlink.c:3402 [inline]
 __rtnl_newlink+0xb90/0x1840 net/core/rtnetlink.c:3658
 rtnl_newlink+0x68/0xa0 net/core/rtnetlink.c:3695
 rtnetlink_rcv_msg+0x43d/0xd50 net/core/rtnetlink.c:6417
 netlink_rcv_skb+0x165/0x440 net/netlink/af_netlink.c:2546
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x925/0xe30 net/netlink/af_netlink.c:1913
 sock_sendmsg_nosec net/socket.c:724 [inline]
 sock_sendmsg+0xde/0x190 net/socket.c:747
 ____sys_sendmsg+0x71c/0x900 net/socket.c:2503
 ___sys_sendmsg+0x110/0x1b0 net/socket.c:2557
 __sys_sendmsg+0xf7/0x1c0 net/socket.c:2586
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f887ba8c389
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f887c765168 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f887bbabf80 RCX: 00007f887ba8c389
RDX: 0000000000000000 RSI: 0000000020000080 RDI: 0000000000000006
RBP: 00007f887c7651d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffc4dd1155f R14: 00007f887c765300 R15: 0000000000022000
 </TASK>
IPv6: ADDRCONF(NETDEV_CHANGE): vcan0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): vxcan0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): vxcan1: link becomes ready


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
