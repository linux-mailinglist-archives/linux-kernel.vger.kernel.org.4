Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECBC608EA5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 18:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiJVQog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 12:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiJVQod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 12:44:33 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951B8765A
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 09:44:25 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id n6-20020a056e021ba600b002fc99858e34so5871449ili.14
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 09:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DdCR4tsWSRVtW0jXptYj1WZRooswmUP38mopUatFdd8=;
        b=GdrlYIIZ9WGg4cGW7XrYXyOiz6wQxzILC5N2cYHY/ntRpDrFRy3d5CrAt5XEjPZlxr
         L/Sg/jz6OMAlMNQe5LeGT+jLSsHyGEgeVA/dXBO1UNP0Q4iHqH/dEt/94/5Cib46l5r9
         MAh8Mu6vVEIiWLlBR29T1JgLCrGjxZIChBEOpPUtLegNlj0YpLbMDGcEvcI/riWvM2jm
         qisMzuHAlr1yagJyRcJrnXc0NklieuJ7gvki7KZFTL0jTudXaAzJzzFoA0rtA2pUobr9
         th4p/xo7IrHBASRP/zSurbJhDzKJP7TEex5FygdImFhqegPrRFT7KJaa3zIwtVx+8kgn
         W3oQ==
X-Gm-Message-State: ACrzQf3E8ufBLPY9UU6FfOo+qrYZxBk6vLHRfhhzFuN4uu8s2Kl/ucEz
        kWxMbLaaaRt03YD4MzzB9aCxD7B8qRr41/i3+ZYmGodatm2b
X-Google-Smtp-Source: AMsMyM7kQ8oXbSKD/cqyEXazGIeZSF1yQ87NZoxYGNsvNlfJJ3V1xAzkdWHAlv3XTWwoMDCcsPKib+9UE2FB5D8qTXm9eeNEjpr0
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1989:b0:2fa:f3da:a013 with SMTP id
 g9-20020a056e02198900b002faf3daa013mr15623792ilf.314.1666457064984; Sat, 22
 Oct 2022 09:44:24 -0700 (PDT)
Date:   Sat, 22 Oct 2022 09:44:24 -0700
In-Reply-To: <20221022123406.1978-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000645a8505eba24506@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in kernfs_add_one
From:   syzbot <syzbot+ef17b5b364116518fd65@syzkaller.appspotmail.com>
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
UBSAN: object-size-mismatch in wg_xmit

================================================================================
UBSAN: object-size-mismatch in ./include/linux/skbuff.h:2048:28
member access within address ffffc900000074c0 with insufficient space
for an object of type 'struct sk_buff'
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.15.0-rc5-syzkaller-00376-gcf52ad5ff16c-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 handle_object_size_mismatch lib/ubsan.c:232 [inline]
 ubsan_type_mismatch_common+0x1e6/0x390 lib/ubsan.c:245
 __ubsan_handle_type_mismatch_v1+0x4a/0x60 lib/ubsan.c:274
 __skb_queue_before include/linux/skbuff.h:2048 [inline]
 __skb_queue_tail include/linux/skbuff.h:2081 [inline]
 wg_xmit+0x565/0xda0 drivers/net/wireguard/device.c:182
 __netdev_start_xmit include/linux/netdevice.h:4988 [inline]
 netdev_start_xmit+0x7b/0x140 include/linux/netdevice.h:5002
 xmit_one net/core/dev.c:3576 [inline]
 dev_hard_start_xmit+0x182/0x2e0 net/core/dev.c:3592
 __dev_queue_xmit+0x1497/0x2140 net/core/dev.c:4202
 neigh_output include/net/neighbour.h:510 [inline]
 ip6_finish_output2+0xf45/0x1300 net/ipv6/ip6_output.c:126
 dst_output include/net/dst.h:450 [inline]
 NF_HOOK include/linux/netfilter.h:307 [inline]
 ndisc_send_skb+0x8c3/0xdd0 net/ipv6/ndisc.c:508
 addrconf_rs_timer+0x38c/0x5f0 net/ipv6/addrconf.c:3893
 call_timer_fn+0xf6/0x210 kernel/time/timer.c:1421
 expire_timers kernel/time/timer.c:1466 [inline]
 __run_timers+0x685/0x7e0 kernel/time/timer.c:1734
 run_timer_softirq+0x63/0xf0 kernel/time/timer.c:1747
 __do_softirq+0x382/0x793 kernel/softirq.c:558
 __irq_exit_rcu+0xec/0x170 kernel/softirq.c:636
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:648
 sysvec_apic_timer_interrupt+0x91/0xb0 arch/x86/kernel/apic/apic.c:1097
 </IRQ>
 asm_sysvec_apic_timer_interrupt+0x12/0x20
RIP: 0010:native_save_fl arch/x86/include/asm/irqflags.h:22 [inline]
RIP: 0010:arch_local_save_flags arch/x86/include/asm/irqflags.h:70 [inline]
RIP: 0010:arch_irqs_disabled arch/x86/include/asm/irqflags.h:132 [inline]
RIP: 0010:acpi_safe_halt+0xbc/0x160 drivers/acpi/processor_idle.c:110
Code: 83 e6 08 31 ff e8 24 39 89 f8 48 83 e3 08 75 73 4c 8d 64 24 20 e8 a4 1b 8f f8 eb 0c e8 4d 34 89 f8 0f 00 2d 16 3b c6 00 fb f4 <4c> 89 e3 48 c1 eb 03 42 80 3c 33 00 74 08 4c 89 e7 e8 9e c6 c8 f8
RSP: 0018:ffffffff8b407bc0 EFLAGS: 00000282
RAX: d4f825addbe56c00 RBX: 0000000000000000 RCX: ffffffff8f975703
RDX: ffffffff8b4bbf58 RSI: ffffffff894c55a0 RDI: ffffffff89a4bbe0
RBP: ffffffff8b407c40 R08: ffffffff81787bf0 R09: fffffbfff16976a9
R10: fffffbfff16976a9 R11: 1ffffffff16976a8 R12: ffffffff8b407be0
R13: ffff8880157d0064 R14: dffffc0000000000 R15: 1ffffffff1680f78
 acpi_idle_enter+0x371/0x520 drivers/acpi/processor_idle.c:688
 cpuidle_enter_state+0x2a8/0xaf0 drivers/cpuidle/cpuidle.c:237
 cpuidle_enter+0x59/0x90 drivers/cpuidle/cpuidle.c:351
 cpuidle_idle_call kernel/sched/idle.c:239 [inline]
 do_idle+0x389/0x590 kernel/sched/idle.c:306
 cpu_startup_entry+0x15/0x20 kernel/sched/idle.c:403
 start_kernel+0x4b9/0x568 init/main.c:1142
 secondary_startup_64_no_verify+0xb1/0xbb
================================================================================
----------------
Code disassembly (best guess):
   0:	83 e6 08             	and    $0x8,%esi
   3:	31 ff                	xor    %edi,%edi
   5:	e8 24 39 89 f8       	callq  0xf889392e
   a:	48 83 e3 08          	and    $0x8,%rbx
   e:	75 73                	jne    0x83
  10:	4c 8d 64 24 20       	lea    0x20(%rsp),%r12
  15:	e8 a4 1b 8f f8       	callq  0xf88f1bbe
  1a:	eb 0c                	jmp    0x28
  1c:	e8 4d 34 89 f8       	callq  0xf889346e
  21:	0f 00 2d 16 3b c6 00 	verw   0xc63b16(%rip)        # 0xc63b3e
  28:	fb                   	sti
  29:	f4                   	hlt
* 2a:	4c 89 e3             	mov    %r12,%rbx <-- trapping instruction
  2d:	48 c1 eb 03          	shr    $0x3,%rbx
  31:	42 80 3c 33 00       	cmpb   $0x0,(%rbx,%r14,1)
  36:	74 08                	je     0x40
  38:	4c 89 e7             	mov    %r12,%rdi
  3b:	e8 9e c6 c8 f8       	callq  0xf8c8c6de


Tested on:

commit:         cf52ad5f Merge tag 'driver-core-5.15-rc6' of git://git..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10f1b16a880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e25c48e302d3bf01
dashboard link: https://syzkaller.appspot.com/bug?extid=ef17b5b364116518fd65
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14ca1022880000

