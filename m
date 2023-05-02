Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B83E6F3CBA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 06:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbjEBEa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 00:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEBEaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 00:30:24 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71BE273A
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 21:30:22 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-760eead6a4aso194767939f.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 21:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683001822; x=1685593822;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4OgXGb5KtBNyMjlxbl3Ue8d0ovJA2ijNrWvIuloGrHs=;
        b=O7ZgVP6897f85ZsB7KQVCCnnrfceOSq6Vh9uz7kHDS3GkV+zkXwFBHwpCI+de0TJEX
         reOWNQLuWwjVrlBHjD7FsMsBMdj25NUvbF3eOZWiqe3xhqwPmaJzXttR91LcIpj5xIko
         x2uBYphllPUSXejTN+Ld9OrXm0om0hyukb6ZgIhYmNXtw/ZBMjM+T3TfOX9uy81MrkgC
         Q8qfXncA4zOXlkIiaV2mjcXAvMGYMv9hhVY0FEiyAE47JtVReXRI+j7y4lwALR+R1Vjq
         osJ0DaUv3ksef/sVF+wkDlYo/XlfMkHIiMpGFL70RZ3ArB3zxjeOcFglemDv2SauIVgI
         LWSA==
X-Gm-Message-State: AC+VfDzqBKKpbpjwAbs/8HPbnnuGuOHJu/8ieKdI95uhAxGpmWzK5BPJ
        Yi1ygQ74KRDf440xa5ddNf3Sml9lzRkETbFaWKmcREGVpnr6
X-Google-Smtp-Source: ACHHUZ4V4nB2SEMOa1xMRdM2TxjFYpAfKkVdkLOZAbkwCuemt2a8fGQEwMipy49jHE77vbiO2a2qDvrZrR4upGkdDUAPR7+EV1/P
MIME-Version: 1.0
X-Received: by 2002:a02:9646:0:b0:3c5:14ca:58c6 with SMTP id
 c64-20020a029646000000b003c514ca58c6mr6994586jai.4.1683001822102; Mon, 01 May
 2023 21:30:22 -0700 (PDT)
Date:   Mon, 01 May 2023 21:30:22 -0700
In-Reply-To: <20230502040924.3458-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c34f6405faae6554@google.com>
Subject: Re: [syzbot] [usb?] KASAN: slab-use-after-free Write in usb_anchor_suspend_wakeups
From:   syzbot <syzbot+d6b0b0ea0781c14b2ecf@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in usbtmc_read_bulk_cb

general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 1 PID: 4415 Comm: kworker/1:2 Not tainted 6.3.0-syzkaller-11025-g89d77f71f493-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
Workqueue: usb_hub_wq hub_event
RIP: 0010:usbtmc_read_bulk_cb+0x313/0x3e0 drivers/usb/class/usbtmc.c:782
Code: 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 d1 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 2b 49 8d 7d 10 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 a5 00 00 00 49 8b 7d 10 44 89 e1 48 c7 c2 a0 fa
RSP: 0018:ffffc900001e0a68 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: ffff88807581d800 RCX: 0000000000000100
RDX: 0000000000000002 RSI: ffffffff864d80e0 RDI: 0000000000000010
RBP: ffff88801571d300 R08: 0000000000000005 R09: 0000000000000000
R10: 000000000000006a R11: 0000000000000001 R12: 00000000fffffffe
R13: 0000000000000000 R14: ffff88807581d830 R15: 00000000fffffffe
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc735f73718 CR3: 00000000271df000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 __usb_hcd_giveback_urb+0x2b6/0x5c0 drivers/usb/core/hcd.c:1671
 usb_hcd_giveback_urb+0x384/0x430 drivers/usb/core/hcd.c:1754
 dummy_timer+0x13b6/0x3400 drivers/usb/gadget/udc/dummy_hcd.c:1988
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
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x70 kernel/kcov.c:200
Code: b6 21 8e 02 66 0f 1f 44 00 00 f3 0f 1e fa 48 8b be a8 01 00 00 e8 b0 ff ff ff 31 c0 c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 <f3> 0f 1e fa 65 8b 05 cd 6a 7f 7e 89 c1 48 8b 34 24 81 e1 00 01 00
RSP: 0018:ffffc90005c0f5d8 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000000
RDX: ffff88802a50bb80 RSI: ffffffff81686875 RDI: 0000000000000007
RBP: ffffffff8d263038 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000200 R11: 0000000000000000 R12: 0000000000000000
R13: ffffffff8d262fe0 R14: dffffc0000000000 R15: 0000000000000001
 console_emit_next_record arch/x86/include/asm/irqflags.h:42 [inline]
 console_flush_all+0x61b/0xcc0 kernel/printk/printk.c:2933
 console_unlock+0xb8/0x1f0 kernel/printk/printk.c:3007
 vprintk_emit+0x1bd/0x600 kernel/printk/printk.c:2307
 dev_vprintk_emit drivers/base/core.c:4840 [inline]
 dev_printk_emit+0xda/0x120 drivers/base/core.c:4851
 __dev_printk+0xf8/0x270 drivers/base/core.c:4863
 _dev_info+0xdc/0x120 drivers/base/core.c:4909
 usb_disconnect+0xe1/0x8a0 drivers/usb/core/hub.c:2220
 hub_port_connect drivers/usb/core/hub.c:5246 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5551 [inline]
 port_event drivers/usb/core/hub.c:5711 [inline]
 hub_event+0x1fbf/0x4e40 drivers/usb/core/hub.c:5793
 process_one_work+0x991/0x15c0 kernel/workqueue.c:2390
 process_scheduled_works kernel/workqueue.c:2453 [inline]
 worker_thread+0x858/0x1090 kernel/workqueue.c:2539
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:usbtmc_read_bulk_cb+0x313/0x3e0 drivers/usb/class/usbtmc.c:782
Code: 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 d1 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 2b 49 8d 7d 10 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 a5 00 00 00 49 8b 7d 10 44 89 e1 48 c7 c2 a0 fa
RSP: 0018:ffffc900001e0a68 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: ffff88807581d800 RCX: 0000000000000100
RDX: 0000000000000002 RSI: ffffffff864d80e0 RDI: 0000000000000010
RBP: ffff88801571d300 R08: 0000000000000005 R09: 0000000000000000
R10: 000000000000006a R11: 0000000000000001 R12: 00000000fffffffe
R13: 0000000000000000 R14: ffff88807581d830 R15: 00000000fffffffe
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc735f73718 CR3: 00000000271df000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 4 bytes skipped:
   0:	48 c1 ea 03          	shr    $0x3,%rdx
   4:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   8:	0f 85 d1 00 00 00    	jne    0xdf
   e:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  15:	fc ff df
  18:	4c 8b 2b             	mov    (%rbx),%r13
  1b:	49 8d 7d 10          	lea    0x10(%r13),%rdi
  1f:	48 89 fa             	mov    %rdi,%rdx
  22:	48 c1 ea 03          	shr    $0x3,%rdx
* 26:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2a:	0f 85 a5 00 00 00    	jne    0xd5
  30:	49 8b 7d 10          	mov    0x10(%r13),%rdi
  34:	44 89 e1             	mov    %r12d,%ecx
  37:	48                   	rex.W
  38:	c7                   	.byte 0xc7
  39:	c2 a0 fa             	retq   $0xfaa0


Tested on:

commit:         89d77f71 Merge tag 'riscv-for-linus-6.4-mw1' of git://..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14f08158280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d963e7536cbe545e
dashboard link: https://syzkaller.appspot.com/bug?extid=d6b0b0ea0781c14b2ecf
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=148dd72c280000

