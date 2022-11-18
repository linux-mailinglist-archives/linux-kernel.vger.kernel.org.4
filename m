Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADDC62F8CF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 16:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240700AbiKRPEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 10:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242021AbiKRPDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 10:03:39 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D63B111C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 07:02:22 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id g13-20020a056602072d00b006c60d59110fso2703716iox.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 07:02:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RVYdx6zEEyAxb51YuE4WOOyd9Xf1dEz9c7jqCXODBBM=;
        b=p9A9AK5EDsfVw4y8vcQvXeOtv0JvMAhtsFvQ48SKDf+nWDjvwSGKPzVssPcwOMwo6e
         7mYSjVMpHlvlqXjmKt1/gYtuynbFFG0ItlszS5F+xzMImK1HxoE/8kmxX6RnbogMJ0Fq
         EljKf23ane1FDapddFxcLTrBmYIRQYbzcIuPCxEjWR7fhOlk08f12QOgKqSjFBO9pgwO
         +xg6vRnY4IbmJEilh7PTutqk4kds//uoh5ZNDC4bqq8nAnJYgMzcUTj3SgP4yaoyqBQE
         SGiybuNDiRaTd53HxFFVNiP9/lM42i+AJ/DKIbdVSCbX4pawvyeGHODK2B3ynskDS6FV
         pjAA==
X-Gm-Message-State: ANoB5pkB66euSEXZCCMGcWvy2sWNT6ua/3GGNhYg4U/d+JMu7OJuek5T
        t6F5pLnkIdtI2VdZayRqSrpNJvXwhHGw9UoreDV+FKWZhiTB
X-Google-Smtp-Source: AA0mqf7w09MtScb9K8O6Of4J51OFypEI0bYqGGZPC5DeKeKBxo3g5u4+MTdYF/CdxCO5daZ/zelA1wM/e7jzutGYygtamoMJBsVx
MIME-Version: 1.0
X-Received: by 2002:a92:a30b:0:b0:302:555a:f761 with SMTP id
 a11-20020a92a30b000000b00302555af761mr3235243ili.323.1668783741937; Fri, 18
 Nov 2022 07:02:21 -0800 (PST)
Date:   Fri, 18 Nov 2022 07:02:21 -0800
In-Reply-To: <20221118030902.3924-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000252f3305edbffee2@google.com>
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in static_key_slow_inc
From:   syzbot <syzbot+703d9e154b3b58277261@syzkaller.appspotmail.com>
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
inconsistent lock state in l2tp_tunnel_destruct

================================
WARNING: inconsistent lock state
6.1.0-rc4-syzkaller-00212-g064bc7312bd0-dirty #0 Not tainted
--------------------------------
inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
swapper/0/0 [HC0[0]:SC1[3]:HE1:SE0] takes:
ffff888145ea44f8 (k-clock-AF_INET){++?.}-{2:2}, at: l2tp_tunnel_destruct+0xe6/0x2d0 net/l2tp/l2tp_core.c:1153
{SOFTIRQ-ON-W} state was registered at:
  lock_acquire kernel/locking/lockdep.c:5668 [inline]
  lock_acquire+0x1e3/0x630 kernel/locking/lockdep.c:5633
  __raw_write_lock include/linux/rwlock_api_smp.h:209 [inline]
  _raw_write_lock+0x2e/0x40 kernel/locking/spinlock.c:300
  l2tp_tunnel_register+0xc61/0x1200 net/l2tp/l2tp_core.c:1509
  l2tp_nl_cmd_tunnel_create+0x3d6/0x8b0 net/l2tp/l2tp_netlink.c:245
  genl_family_rcv_msg_doit+0x228/0x320 net/netlink/genetlink.c:756
  genl_family_rcv_msg net/netlink/genetlink.c:833 [inline]
  genl_rcv_msg+0x445/0x780 net/netlink/genetlink.c:850
  netlink_rcv_skb+0x157/0x430 net/netlink/af_netlink.c:2540
  genl_rcv+0x28/0x40 net/netlink/genetlink.c:861
  netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
  netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1345
  netlink_sendmsg+0x91b/0xe10 net/netlink/af_netlink.c:1921
  sock_sendmsg_nosec net/socket.c:714 [inline]
  sock_sendmsg+0xd3/0x120 net/socket.c:734
  ____sys_sendmsg+0x712/0x8c0 net/socket.c:2482
  ___sys_sendmsg+0x110/0x1b0 net/socket.c:2536
  __sys_sendmsg+0xf7/0x1c0 net/socket.c:2565
  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
  entry_SYSCALL_64_after_hwframe+0x63/0xcd
irq event stamp: 5256464
hardirqs last  enabled at (5256464): [<ffffffff89f47d84>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (5256464): [<ffffffff89f47d84>] _raw_spin_unlock_irqrestore+0x54/0x70 kernel/locking/spinlock.c:194
hardirqs last disabled at (5256463): [<ffffffff89f47b12>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
hardirqs last disabled at (5256463): [<ffffffff89f47b12>] _raw_spin_lock_irqsave+0x52/0x60 kernel/locking/spinlock.c:162
softirqs last  enabled at (5256370): [<ffffffff814c1d03>] invoke_softirq kernel/softirq.c:445 [inline]
softirqs last  enabled at (5256370): [<ffffffff814c1d03>] __irq_exit_rcu+0x123/0x180 kernel/softirq.c:650
softirqs last disabled at (5256383): [<ffffffff814c1d03>] invoke_softirq kernel/softirq.c:445 [inline]
softirqs last disabled at (5256383): [<ffffffff814c1d03>] __irq_exit_rcu+0x123/0x180 kernel/softirq.c:650

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(k-clock-AF_INET);
  <Interrupt>
    lock(k-clock-AF_INET);

 *** DEADLOCK ***

1 lock held by swapper/0/0:
 #0: ffffffff8c58fc60 (rcu_callback){....}-{0:0}, at: rcu_do_batch kernel/rcu/tree.c:2239 [inline]
 #0: ffffffff8c58fc60 (rcu_callback){....}-{0:0}, at: rcu_core+0x7ab/0x1980 kernel/rcu/tree.c:2510

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.1.0-rc4-syzkaller-00212-g064bc7312bd0-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_usage_bug kernel/locking/lockdep.c:3963 [inline]
 valid_state kernel/locking/lockdep.c:3975 [inline]
 mark_lock_irq kernel/locking/lockdep.c:4178 [inline]
 mark_lock.part.0.cold+0x18/0xd8 kernel/locking/lockdep.c:4634
 mark_lock kernel/locking/lockdep.c:4598 [inline]
 mark_usage kernel/locking/lockdep.c:4529 [inline]
 __lock_acquire+0x11d9/0x56d0 kernel/locking/lockdep.c:5009
 lock_acquire kernel/locking/lockdep.c:5668 [inline]
 lock_acquire+0x1e3/0x630 kernel/locking/lockdep.c:5633
 __raw_write_lock_bh include/linux/rwlock_api_smp.h:202 [inline]
 _raw_write_lock_bh+0x33/0x40 kernel/locking/spinlock.c:334
 l2tp_tunnel_destruct+0xe6/0x2d0 net/l2tp/l2tp_core.c:1153
 __sk_destruct+0x51/0x710 net/core/sock.c:2122
 rcu_do_batch kernel/rcu/tree.c:2250 [inline]
 rcu_core+0x81f/0x1980 kernel/rcu/tree.c:2510
 __do_softirq+0x1fb/0xadc kernel/softirq.c:571
 invoke_softirq kernel/softirq.c:445 [inline]
 __irq_exit_rcu+0x123/0x180 kernel/softirq.c:650
 irq_exit_rcu+0x9/0x20 kernel/softirq.c:662
 sysvec_apic_timer_interrupt+0x97/0xc0 arch/x86/kernel/apic/apic.c:1107
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:native_save_fl arch/x86/include/asm/irqflags.h:29 [inline]
RIP: 0010:arch_local_save_flags arch/x86/include/asm/irqflags.h:70 [inline]
RIP: 0010:arch_irqs_disabled arch/x86/include/asm/irqflags.h:130 [inline]
RIP: 0010:acpi_safe_halt drivers/acpi/processor_idle.c:113 [inline]
RIP: 0010:acpi_idle_do_entry+0x1fd/0x2a0 drivers/acpi/processor_idle.c:572
Code: 89 de e8 66 ac 8b f7 84 db 75 ac e8 ed af 8b f7 e8 78 30 92 f7 eb 0c e8 e1 af 8b f7 0f 00 2d 7a 63 be 00 e8 d5 af 8b f7 fb f4 <9c> 5b 81 e3 00 02 00 00 fa 31 ff 48 89 de e8 90 ac 8b f7 48 85 db
RSP: 0018:ffffffff8c207d28 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffffffff8c2bc9c0 RSI: ffffffff89f469ab RDI: 0000000000000000
RBP: ffff888145cc0064 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000001
R13: ffff888145cc0000 R14: ffff888145cc0064 R15: ffff888145ebe804
 acpi_idle_enter+0x368/0x510 drivers/acpi/processor_idle.c:709
 cpuidle_enter_state+0x1af/0xd40 drivers/cpuidle/cpuidle.c:239
 cpuidle_enter+0x4e/0xa0 drivers/cpuidle/cpuidle.c:356
 call_cpuidle kernel/sched/idle.c:155 [inline]
 cpuidle_idle_call kernel/sched/idle.c:236 [inline]
 do_idle+0x3f7/0x590 kernel/sched/idle.c:303
 cpu_startup_entry+0x18/0x20 kernel/sched/idle.c:400
 rest_init+0x16d/0x270 init/main.c:729
 arch_call_rest_init+0x13/0x1c init/main.c:890
 start_kernel+0x477/0x498 init/main.c:1145
 secondary_startup_64_no_verify+0xce/0xdb
 </TASK>
----------------
Code disassembly (best guess):
   0:	89 de                	mov    %ebx,%esi
   2:	e8 66 ac 8b f7       	callq  0xf78bac6d
   7:	84 db                	test   %bl,%bl
   9:	75 ac                	jne    0xffffffb7
   b:	e8 ed af 8b f7       	callq  0xf78baffd
  10:	e8 78 30 92 f7       	callq  0xf792308d
  15:	eb 0c                	jmp    0x23
  17:	e8 e1 af 8b f7       	callq  0xf78baffd
  1c:	0f 00 2d 7a 63 be 00 	verw   0xbe637a(%rip)        # 0xbe639d
  23:	e8 d5 af 8b f7       	callq  0xf78baffd
  28:	fb                   	sti
  29:	f4                   	hlt
* 2a:	9c                   	pushfq <-- trapping instruction
  2b:	5b                   	pop    %rbx
  2c:	81 e3 00 02 00 00    	and    $0x200,%ebx
  32:	fa                   	cli
  33:	31 ff                	xor    %edi,%edi
  35:	48 89 de             	mov    %rbx,%rsi
  38:	e8 90 ac 8b f7       	callq  0xf78baccd
  3d:	48 85 db             	test   %rbx,%rbx


Tested on:

commit:         064bc731 netdevsim: Fix memory leak of nsim_dev->fa_co..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=148c924e880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a33ac7bbc22a8c35
dashboard link: https://syzkaller.appspot.com/bug?extid=703d9e154b3b58277261
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=110210f9880000

