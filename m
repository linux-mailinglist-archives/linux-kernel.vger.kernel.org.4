Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B8A5F1C88
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 15:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiJANuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 09:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiJANtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 09:49:49 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1478F001
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 06:49:44 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id f25-20020a5d8799000000b006a44e33ddb6so4423553ion.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 06:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=xR70BMz8QvON4/sXMTRjelQM5rUtj9wQqGGO3J5zk8g=;
        b=EHWMroFiZHGtzxsyhh5do8LPPAJ3BdpUWr6hQb5CxTzUkGWU/eubXY65Ix32e0TYHn
         iAxOnRev0rKD5z3kEjguC3k5Kcd7DlTY7ZloeYGzatDyZfGeTt51GhSgasm+32OLJZ62
         yvWjKxrKTULIGkmTBDBVVygsq1TmKiG+tV2Yycs2cSr2bwYGWmB8lCI8FselPgW+8qUF
         u6i8q/XIn5kComgvcWf9vBFvHChhL9nqEHgCm92y11Ltider0iwS8ULD6tE/3fa7sVN3
         CQDXczOHmipgpLvvkzxGt/J0fKSTi514TNxD3eUu8p4v+VKWGFsmEFH6mCSLmg7zrofN
         YUYQ==
X-Gm-Message-State: ACrzQf3LIlzKCkMr1dzjhmuvRUc44v9U4RuN6ss3384DQlBywxxfGnzg
        QIvRSS5xHynqvSSCJE6CjcKUu7gThhlh1CkwG35uwWLIyHwV
X-Google-Smtp-Source: AMsMyM62GgIJFUkNgwQH1lf3S351qxSJmHZG37hc1F3GxGJ/nFWF/oAlGeXnJtpl/gA7gGQ2CD0FoLGRprD5mlgU6F6Wy/J9wVge
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d94:b0:35a:6828:6804 with SMTP id
 l20-20020a0566380d9400b0035a68286804mr7232790jaj.149.1664632184034; Sat, 01
 Oct 2022 06:49:44 -0700 (PDT)
Date:   Sat, 01 Oct 2022 06:49:44 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000002db2205e9f9621d@google.com>
Subject: [syzbot] INFO: rcu detected stall in kernfs_fop_release
From:   syzbot <syzbot+74de79467b28a6242ae0@syzkaller.appspotmail.com>
To:     andriy.shevchenko@linux.intel.com, etremblay@distech-controls.com,
        gregkh@linuxfoundation.org, ilpo.jarvinen@linux.intel.com,
        jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        u.kleine-koenig@pengutronix.de, wander@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    aaa11ce2ffc8 Add linux-next specific files for 20220923
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10e00d2f080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=186d1ff305f10294
dashboard link: https://syzkaller.appspot.com/bug?extid=74de79467b28a6242ae0
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1258b59c880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10874800880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/95c7bf83c07e/disk-aaa11ce2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b161cd56a7a3/vmlinux-aaa11ce2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+74de79467b28a6242ae0@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {
 0-....
 } 2686 jiffies s: 481 root: 0x1/.
rcu: blocking rcu_node structures (internal RCU debug):

Sending NMI from CPU 1 to CPUs 0:
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
NMI backtrace for cpu 0
CPU: 0 PID: 3659 Comm: udevd Not tainted 6.0.0-rc6-next-20220923-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:io_serial_out+0x8b/0xa0 drivers/tty/serial/8250/8250_port.c:467
Code: 48 8d 7d 40 44 89 e1 48 b8 00 00 00 00 00 fc ff df 48 89 fa d3 e3 48 c1 ea 03 80 3c 02 00 75 18 66 03 5d 40 44 89 e8 89 da ee <5b> 5d 41 5c 41 5d c3 e8 09 58 8c fd eb a4 e8 32 58 8c fd eb e1 41
RSP: 0018:ffffc900000073b0 EFLAGS: 00000002
RAX: 0000000000000020 RBX: 00000000000003f8 RCX: 0000000000000000
RDX: 00000000000003f8 RSI: ffffffff843c83b1 RDI: ffffffff91379960
RBP: ffffffff91379920 R08: 0000000000000001 R09: 000000000000001f
R10: 0000000000000000 R11: 3a30207355504353 R12: 0000000000000000
R13: 0000000000000020 R14: ffffffff843c8350 R15: 0000000000000000
FS:  00007f2bfe18b840(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffcc9ebd7b8 CR3: 0000000027f7e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 serial_out drivers/tty/serial/8250/8250.h:123 [inline]
 serial8250_console_fifo_write drivers/tty/serial/8250/8250_port.c:3352 [inline]
 serial8250_console_write+0xc22/0xf10 drivers/tty/serial/8250/8250_port.c:3423
 call_console_driver kernel/printk/printk.c:1945 [inline]
 console_emit_next_record.constprop.0+0x3de/0x840 kernel/printk/printk.c:2732
 console_flush_all kernel/printk/printk.c:2794 [inline]
 console_unlock+0x3be/0x600 kernel/printk/printk.c:2861
 vprintk_emit+0x1b9/0x5f0 kernel/printk/printk.c:2271
 dev_vprintk_emit+0x36e/0x3b2 drivers/base/core.c:4736
 dev_printk_emit+0xba/0xf1 drivers/base/core.c:4747
 __dev_printk+0xcf/0xf5 drivers/base/core.c:4759
 _dev_warn+0xd7/0x109 drivers/base/core.c:4803
 usb_rx_callback_intf0.cold+0x34/0x43 drivers/media/rc/imon.c:1773
 __usb_hcd_giveback_urb+0x2b0/0x5c0 drivers/usb/core/hcd.c:1671
 usb_hcd_giveback_urb+0x380/0x430 drivers/usb/core/hcd.c:1754
 dummy_timer+0x11ff/0x32c0 drivers/usb/gadget/udc/dummy_hcd.c:1988
 call_timer_fn+0x1da/0x7c0 kernel/time/timer.c:1474
 expire_timers kernel/time/timer.c:1519 [inline]
 __run_timers.part.0+0x6a2/0xaf0 kernel/time/timer.c:1790
 __run_timers kernel/time/timer.c:1768 [inline]
 run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1803
 __do_softirq+0x1f7/0xad8 kernel/softirq.c:571
 invoke_softirq kernel/softirq.c:445 [inline]
 __irq_exit_rcu+0x123/0x180 kernel/softirq.c:650
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:662
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1107
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x16/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:on_stack arch/x86/include/asm/stacktrace.h:58 [inline]
RIP: 0010:stack_access_ok+0x17/0x1d0 arch/x86/kernel/unwind_orc.c:347
Code: e8 de 41 93 00 eb c4 48 89 ef e8 d4 41 93 00 eb de 66 90 48 b8 00 00 00 00 00 fc ff df 41 56 41 55 41 54 49 89 d4 48 89 fa 55 <48> c1 ea 03 48 89 f5 53 48 89 fb 48 83 ec 08 0f b6 04 02 84 c0 74
RSP: 0018:ffffc90003f9f870 EFLAGS: 00000283
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: 0000000000000001
RDX: ffffc90003f9f958 RSI: ffffc90003f9f9e0 RDI: ffffc90003f9f958
RBP: ffffc90003f9f9a0 R08: ffffffff8e5e483a R09: ffffc90003f9f98c
R10: fffff520007f3f36 R11: ffffc90003f9f9e8 R12: 0000000000000008
R13: ffffc90003f9f958 R14: ffffc90003f9f9e0 R15: ffffffff8e5e483e
 deref_stack_reg arch/x86/kernel/unwind_orc.c:357 [inline]
 unwind_next_frame+0x12b4/0x1cc0 arch/x86/kernel/unwind_orc.c:605
 __unwind_start+0x51b/0x800 arch/x86/kernel/unwind_orc.c:717
 unwind_start arch/x86/include/asm/unwind.h:64 [inline]
 arch_stack_walk+0x5c/0xe0 arch/x86/kernel/stacktrace.c:24
 stack_trace_save+0x8c/0xc0 kernel/stacktrace.c:122
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:45
 kasan_set_track+0x21/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2a/0x40 mm/kasan/generic.c:511
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x160/0x1c0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:177 [inline]
 slab_free_hook mm/slub.c:1669 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1695
 slab_free mm/slub.c:3599 [inline]
 kmem_cache_free+0xea/0x5b0 mm/slub.c:3621
 seq_release+0x5e/0x80 fs/seq_file.c:356
 kernfs_fop_release+0xf2/0x1e0 fs/kernfs/file.c:802
 __fput+0x27c/0xa90 fs/file_table.c:320
 task_work_run+0x16b/0x270 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:296
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f2bfdd2a467
Code: 44 00 00 48 8b 15 11 aa 0c 00 f7 d8 64 89 02 b8 ff ff ff ff eb bc 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 e1 a9 0c 00 f7 d8 64 89 02 b8
RSP: 002b:00007ffcc9ec17a8 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 000055c04cd1ee30 RCX: 00007f2bfdd2a467
RDX: 00007f2bfddf1780 RSI: 0000000000000000 RDI: 0000000000000008
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000800000 R11: 0000000000000202 R12: 00007f2bfddf2380
R13: 0000000000000000 R14: 0000000000000000 R15: 000055c04bcaaa7c
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 4.629 msecs
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_in

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
