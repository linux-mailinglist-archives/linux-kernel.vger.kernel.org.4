Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334AE62A08D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbiKORlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiKORlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:41:44 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C9A303C5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:41:41 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id l9-20020a056e02066900b0030259ce0d5eso4885546ilt.20
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:41:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6lzrTGpNuD5WpRn39fmzoICUymwqNlnZd4YQjkBHO4g=;
        b=6Bu9Jc0lRmRqERZzLK17ymj51E+bPOr+5uBPZNH+2pQrWYPWDyJNveMeXZwyoCdFcZ
         CjcBg4CUQPqsufWtwe/Hq3ULX7Yggdj/w/Gl8gDof8MYAAsJXIzLkqhtOv0ltYQQwgp9
         AW/4yJG20Vs89NPp2+N5Soqd59uYg6t4ZvN84PtXzgV3woDhDetDXylnjVp+7TIOl1T7
         Bpo270N69xYOPbSoxD4w1aNnQdkXGi9vt2MtfVPvzGelRdQ7DSERKuUC++zu/0pCtv3I
         N2+jB7D1orqZxaJaQaAIegmYE9oYMVTEgJ8qsUHLhypLyIwvWCOMlv0DiDA2AN4pG/+H
         NDbA==
X-Gm-Message-State: ANoB5pl6K6XOpeEjIP9cA4eepIQK8N0GJAidXGXo2zwLFXcpp+vGATRH
        fBZUtxtgysZneG7LQ1z51PCbg7plEzdTnOLyeC6t+GQ2ghc/
X-Google-Smtp-Source: AA0mqf5vWiT3lcaXR1PtHnm2eG8zlqwI6344TV0jlaBKJsDDGTnXLjxbQd8pukmM0+Sj7ZVvgndEWdsDDof5j0YoKYttcvJMKawV
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1b07:b0:372:f7ed:9f78 with SMTP id
 cb7-20020a0566381b0700b00372f7ed9f78mr8623687jab.245.1668534100574; Tue, 15
 Nov 2022 09:41:40 -0800 (PST)
Date:   Tue, 15 Nov 2022 09:41:40 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005c4be705ed85de52@google.com>
Subject: [syzbot] UBSAN: shift-out-of-bounds in hid_report_raw_event (2)
From:   syzbot <syzbot+8b1641d2f14732407e23@syzkaller.appspotmail.com>
To:     benjamin.tissoires@redhat.com, jikos@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

syzbot found the following issue on:

HEAD commit:    4bbf3422df78 Merge tag 'net-6.1-rc5' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1001828e880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=480ba0fb2fd243ac
dashboard link: https://syzkaller.appspot.com/bug?extid=8b1641d2f14732407e23
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13556dfe880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16de4db9880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3f5450859d5d/disk-4bbf3422.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d5ef9126ce18/vmlinux-4bbf3422.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a806f631e533/bzImage-4bbf3422.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8b1641d2f14732407e23@syzkaller.appspotmail.com

microsoft 0003:045E:07DA.0001: hid_field_extract() called with n (128) > 32! (swapper/0)
================================================================================
UBSAN: shift-out-of-bounds in drivers/hid/hid-core.c:1323:20
shift exponent 127 is too large for 32-bit type 'int'
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.1.0-rc4-syzkaller-00159-g4bbf3422df78 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_shift_out_of_bounds+0x3a6/0x420 lib/ubsan.c:322
 snto32 drivers/hid/hid-core.c:1323 [inline]
 hid_input_fetch_field drivers/hid/hid-core.c:1572 [inline]
 hid_process_report drivers/hid/hid-core.c:1665 [inline]
 hid_report_raw_event+0xd56/0x18b0 drivers/hid/hid-core.c:1998
 hid_input_report+0x408/0x4f0 drivers/hid/hid-core.c:2066
 hid_irq_in+0x459/0x690 drivers/hid/usbhid/hid-core.c:284
 __usb_hcd_giveback_urb+0x369/0x530 drivers/usb/core/hcd.c:1671
 dummy_timer+0x86b/0x3110 drivers/usb/gadget/udc/dummy_hcd.c:1988
 call_timer_fn+0xf5/0x210 kernel/time/timer.c:1474
 expire_timers kernel/time/timer.c:1519 [inline]
 __run_timers+0x76a/0x980 kernel/time/timer.c:1790
 run_timer_softirq+0x63/0xf0 kernel/time/timer.c:1803
 __do_softirq+0x277/0x75b kernel/softirq.c:571
 __irq_exit_rcu+0xec/0x170 kernel/softirq.c:650
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:662
 sysvec_apic_timer_interrupt+0x91/0xb0 arch/x86/kernel/apic/apic.c:1107
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x16/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:native_save_fl arch/x86/include/asm/irqflags.h:22 [inline]
RIP: 0010:arch_local_save_flags arch/x86/include/asm/irqflags.h:70 [inline]
RIP: 0010:arch_irqs_disabled arch/x86/include/asm/irqflags.h:130 [inline]
RIP: 0010:acpi_safe_halt drivers/acpi/processor_idle.c:113 [inline]
RIP: 0010:acpi_idle_do_entry drivers/acpi/processor_idle.c:572 [inline]
RIP: 0010:acpi_idle_enter+0x43d/0x800 drivers/acpi/processor_idle.c:709
Code: ff e8 a7 8d 38 f7 48 83 e3 08 44 8b 7c 24 04 0f 85 00 01 00 00 e8 33 4d 3f f7 66 90 e8 cc 88 38 f7 0f 00 2d f5 af c4 00 fb f4 <4c> 89 e3 48 c1 eb 03 42 80 3c 2b 00 74 08 4c 89 e7 e8 7d 64 8d f7
RSP: 0018:ffffffff8ca07b80 EFLAGS: 000002d3
RAX: ffffffff8a512d84 RBX: 0000000000000000 RCX: ffffffff8cabb7c0
RDX: 0000000000000000 RSI: ffffffff8aad68a0 RDI: ffffffff8b0ac540
RBP: ffffffff8ca07c30 R08: ffffffff8a512d69 R09: fffffbfff19576f9
R10: fffffbfff19576f9 R11: 1ffffffff19576f8 R12: ffffffff8ca07bc0
R13: dffffc0000000000 R14: ffff8880121c6800 R15: 0000000000000001
 cpuidle_enter_state+0x50b/0xf50 drivers/cpuidle/cpuidle.c:239
 cpuidle_enter+0x59/0x90 drivers/cpuidle/cpuidle.c:356
 call_cpuidle kernel/sched/idle.c:155 [inline]
 cpuidle_idle_call kernel/sched/idle.c:236 [inline]
 do_idle+0x3da/0x680 kernel/sched/idle.c:303
 cpu_startup_entry+0x15/0x20 kernel/sched/idle.c:400
 rest_init+0x24f/0x270 init/main.c:729
 arch_call_rest_init+0xa/0xa init/main.c:890
 start_kernel+0x4b6/0x565 init/main.c:1145
 secondary_startup_64_no_verify+0xcf/0xdb
 </TASK>
================================================================================
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	e8 a7 8d 38 f7       	callq  0xf7388dac
   5:	48 83 e3 08          	and    $0x8,%rbx
   9:	44 8b 7c 24 04       	mov    0x4(%rsp),%r15d
   e:	0f 85 00 01 00 00    	jne    0x114
  14:	e8 33 4d 3f f7       	callq  0xf73f4d4c
  19:	66 90                	xchg   %ax,%ax
  1b:	e8 cc 88 38 f7       	callq  0xf73888ec
  20:	0f 00 2d f5 af c4 00 	verw   0xc4aff5(%rip)        # 0xc4b01c
  27:	fb                   	sti
  28:	f4                   	hlt
* 29:	4c 89 e3             	mov    %r12,%rbx <-- trapping instruction
  2c:	48 c1 eb 03          	shr    $0x3,%rbx
  30:	42 80 3c 2b 00       	cmpb   $0x0,(%rbx,%r13,1)
  35:	74 08                	je     0x3f
  37:	4c 89 e7             	mov    %r12,%rdi
  3a:	e8 7d 64 8d f7       	callq  0xf78d64bc


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
