Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0144D5F1CAD
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 16:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiJAOZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 10:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJAOZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 10:25:18 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109713608A
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 07:25:16 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id by7so1817020ljb.6
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 07:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=iEz9nX/7lHX3Y0t7zBvpwhfC4TBuaFKFhmnM7XvXSC0=;
        b=HQ+MZHKjmI6PmXVGtsWGJ7Z5T87Uy5E1We0lBdjGXDQKuL4IRVcBywZ1WhBRBhmbbG
         XAX8vFR3vJVcg4QIr88qzIqGbki9eiIykQ/TqD8+bId3crWbu6mqPjl2isqT0UAY2L60
         dbm8mr4QRNdjnZh5JYaLIYoPDzXjm7SzF0UukzaCZ5KWbpepJrWPG8Rj2ZN6FRL56SqO
         KEKBovj5IV1H1wvSAaIsuaQGQ7fw928NgQiR8G1lexscOvc9jR5EXuNFv8/Wm6U8LfvU
         yBTxbkVqn2I7bwIByeo4ujPU0UBeedWZGmOP1WOeZ7tmvSapm7HHoN3BjC7ACHSzPqHK
         mOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=iEz9nX/7lHX3Y0t7zBvpwhfC4TBuaFKFhmnM7XvXSC0=;
        b=VWp8nVyeS7l2D4/phhs2hjKSk7Qtzt78GivPeSAijcj+p4dlByQjnSgx/rsPtk4zdM
         4FgcaeA1efonJgjVdPioE+YR7pQsctO/85IZfhe9+QdTGjB32Q71BSFcGytHRgWN5M7B
         HIB5TLEApALzBtvt5mOUVk8VyYvF+PfyOQLObESwY3qtWflS+xv8QBSJR9rd3SPjcvn6
         Ophx1nI8rUkfcph1ZQ70JNtYo6NXCN0ut8pn6YymwBLe1wgqwnl18qmtqOi3z1930Toz
         jAhnSifNlWd68guOdMLK13r2ueU8vdQCwO+Cy3ZVvRpQi//7cOoxkDsFAS34Cw9Ycwwf
         R4mA==
X-Gm-Message-State: ACrzQf05z+T17uB+i0ucGZQvzQI8k3+oT0MAgwxUo/j8HCMhDK6Z9MF6
        RXnkmB+Ei0XbzoU6NOycIT+q5E9R9cCVMxVcJS+fZQ==
X-Google-Smtp-Source: AMsMyM6Xr2ZEs5m0TT+g/v7FBr458S0qMUyXN51NbRdmxhAbopLV2X9/AT+6rlnXjtln4/R2ft/SZLgXb/xVqOiQq+I=
X-Received: by 2002:a2e:9bd9:0:b0:26c:28e8:863f with SMTP id
 w25-20020a2e9bd9000000b0026c28e8863fmr4442803ljj.33.1664634314047; Sat, 01
 Oct 2022 07:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000002db2205e9f9621d@google.com>
In-Reply-To: <00000000000002db2205e9f9621d@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 1 Oct 2022 16:25:02 +0200
Message-ID: <CACT4Y+aKijWXNAkrvLbXjmdnka+O8ztAUs0n2TEnG76PX+LYXg@mail.gmail.com>
Subject: Re: [syzbot] INFO: rcu detected stall in kernfs_fop_release
To:     syzbot <syzbot+74de79467b28a6242ae0@syzkaller.appspotmail.com>,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     andriy.shevchenko@linux.intel.com, etremblay@distech-controls.com,
        gregkh@linuxfoundation.org, ilpo.jarvinen@linux.intel.com,
        jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        u.kleine-koenig@pengutronix.de, wander@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Oct 2022 at 15:49, syzbot
<syzbot+74de79467b28a6242ae0@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    aaa11ce2ffc8 Add linux-next specific files for 20220923
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=10e00d2f080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=186d1ff305f10294
> dashboard link: https://syzkaller.appspot.com/bug?extid=74de79467b28a6242ae0
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1258b59c880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10874800880000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/95c7bf83c07e/disk-aaa11ce2.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/b161cd56a7a3/vmlinux-aaa11ce2.xz

+ drivers/media/rc/imon.c maintainers, I think the culprit is this
message printed infinitely:

imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored

> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+74de79467b28a6242ae0@syzkaller.appspotmail.com
>
> rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {
>  0-....
>  } 2686 jiffies s: 481 root: 0x1/.
> rcu: blocking rcu_node structures (internal RCU debug):
>
> Sending NMI from CPU 1 to CPUs 0:
> imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
> NMI backtrace for cpu 0
> CPU: 0 PID: 3659 Comm: udevd Not tainted 6.0.0-rc6-next-20220923-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
> RIP: 0010:io_serial_out+0x8b/0xa0 drivers/tty/serial/8250/8250_port.c:467
> Code: 48 8d 7d 40 44 89 e1 48 b8 00 00 00 00 00 fc ff df 48 89 fa d3 e3 48 c1 ea 03 80 3c 02 00 75 18 66 03 5d 40 44 89 e8 89 da ee <5b> 5d 41 5c 41 5d c3 e8 09 58 8c fd eb a4 e8 32 58 8c fd eb e1 41
> RSP: 0018:ffffc900000073b0 EFLAGS: 00000002
> RAX: 0000000000000020 RBX: 00000000000003f8 RCX: 0000000000000000
> RDX: 00000000000003f8 RSI: ffffffff843c83b1 RDI: ffffffff91379960
> RBP: ffffffff91379920 R08: 0000000000000001 R09: 000000000000001f
> R10: 0000000000000000 R11: 3a30207355504353 R12: 0000000000000000
> R13: 0000000000000020 R14: ffffffff843c8350 R15: 0000000000000000
> FS:  00007f2bfe18b840(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffcc9ebd7b8 CR3: 0000000027f7e000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <IRQ>
>  serial_out drivers/tty/serial/8250/8250.h:123 [inline]
>  serial8250_console_fifo_write drivers/tty/serial/8250/8250_port.c:3352 [inline]
>  serial8250_console_write+0xc22/0xf10 drivers/tty/serial/8250/8250_port.c:3423
>  call_console_driver kernel/printk/printk.c:1945 [inline]
>  console_emit_next_record.constprop.0+0x3de/0x840 kernel/printk/printk.c:2732
>  console_flush_all kernel/printk/printk.c:2794 [inline]
>  console_unlock+0x3be/0x600 kernel/printk/printk.c:2861
>  vprintk_emit+0x1b9/0x5f0 kernel/printk/printk.c:2271
>  dev_vprintk_emit+0x36e/0x3b2 drivers/base/core.c:4736
>  dev_printk_emit+0xba/0xf1 drivers/base/core.c:4747
>  __dev_printk+0xcf/0xf5 drivers/base/core.c:4759
>  _dev_warn+0xd7/0x109 drivers/base/core.c:4803
>  usb_rx_callback_intf0.cold+0x34/0x43 drivers/media/rc/imon.c:1773
>  __usb_hcd_giveback_urb+0x2b0/0x5c0 drivers/usb/core/hcd.c:1671
>  usb_hcd_giveback_urb+0x380/0x430 drivers/usb/core/hcd.c:1754
>  dummy_timer+0x11ff/0x32c0 drivers/usb/gadget/udc/dummy_hcd.c:1988
>  call_timer_fn+0x1da/0x7c0 kernel/time/timer.c:1474
>  expire_timers kernel/time/timer.c:1519 [inline]
>  __run_timers.part.0+0x6a2/0xaf0 kernel/time/timer.c:1790
>  __run_timers kernel/time/timer.c:1768 [inline]
>  run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1803
>  __do_softirq+0x1f7/0xad8 kernel/softirq.c:571
>  invoke_softirq kernel/softirq.c:445 [inline]
>  __irq_exit_rcu+0x123/0x180 kernel/softirq.c:650
>  irq_exit_rcu+0x5/0x20 kernel/softirq.c:662
>  sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1107
>  </IRQ>
>  <TASK>
>  asm_sysvec_apic_timer_interrupt+0x16/0x20 arch/x86/include/asm/idtentry.h:649
> RIP: 0010:on_stack arch/x86/include/asm/stacktrace.h:58 [inline]
> RIP: 0010:stack_access_ok+0x17/0x1d0 arch/x86/kernel/unwind_orc.c:347
> Code: e8 de 41 93 00 eb c4 48 89 ef e8 d4 41 93 00 eb de 66 90 48 b8 00 00 00 00 00 fc ff df 41 56 41 55 41 54 49 89 d4 48 89 fa 55 <48> c1 ea 03 48 89 f5 53 48 89 fb 48 83 ec 08 0f b6 04 02 84 c0 74
> RSP: 0018:ffffc90003f9f870 EFLAGS: 00000283
> RAX: dffffc0000000000 RBX: 0000000000000001 RCX: 0000000000000001
> RDX: ffffc90003f9f958 RSI: ffffc90003f9f9e0 RDI: ffffc90003f9f958
> RBP: ffffc90003f9f9a0 R08: ffffffff8e5e483a R09: ffffc90003f9f98c
> R10: fffff520007f3f36 R11: ffffc90003f9f9e8 R12: 0000000000000008
> R13: ffffc90003f9f958 R14: ffffc90003f9f9e0 R15: ffffffff8e5e483e
>  deref_stack_reg arch/x86/kernel/unwind_orc.c:357 [inline]
>  unwind_next_frame+0x12b4/0x1cc0 arch/x86/kernel/unwind_orc.c:605
>  __unwind_start+0x51b/0x800 arch/x86/kernel/unwind_orc.c:717
>  unwind_start arch/x86/include/asm/unwind.h:64 [inline]
>  arch_stack_walk+0x5c/0xe0 arch/x86/kernel/stacktrace.c:24
>  stack_trace_save+0x8c/0xc0 kernel/stacktrace.c:122
>  kasan_save_stack+0x1e/0x40 mm/kasan/common.c:45
>  kasan_set_track+0x21/0x30 mm/kasan/common.c:52
>  kasan_save_free_info+0x2a/0x40 mm/kasan/generic.c:511
>  ____kasan_slab_free mm/kasan/common.c:236 [inline]
>  ____kasan_slab_free+0x160/0x1c0 mm/kasan/common.c:200
>  kasan_slab_free include/linux/kasan.h:177 [inline]
>  slab_free_hook mm/slub.c:1669 [inline]
>  slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1695
>  slab_free mm/slub.c:3599 [inline]
>  kmem_cache_free+0xea/0x5b0 mm/slub.c:3621
>  seq_release+0x5e/0x80 fs/seq_file.c:356
>  kernfs_fop_release+0xf2/0x1e0 fs/kernfs/file.c:802
>  __fput+0x27c/0xa90 fs/file_table.c:320
>  task_work_run+0x16b/0x270 kernel/task_work.c:179
>  resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
>  exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:203
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
>  syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:296
>  do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f2bfdd2a467
> Code: 44 00 00 48 8b 15 11 aa 0c 00 f7 d8 64 89 02 b8 ff ff ff ff eb bc 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 e1 a9 0c 00 f7 d8 64 89 02 b8
> RSP: 002b:00007ffcc9ec17a8 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
> RAX: 0000000000000000 RBX: 000055c04cd1ee30 RCX: 00007f2bfdd2a467
> RDX: 00007f2bfddf1780 RSI: 0000000000000000 RDI: 0000000000000008
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000800000 R11: 0000000000000202 R12: 00007f2bfddf2380
> R13: 0000000000000000 R14: 0000000000000000 R15: 000055c04bcaaa7c
>  </TASK>
> INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 4.629 msecs
> imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
> imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
> imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
> imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
> imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
> imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
> imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
> imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
> imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
> imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
> imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
> imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
> imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
> imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
> imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
> imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
> imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
> imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
> imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
> imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
> imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
> imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
> imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
> imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
> imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
> imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
> imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
> imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
> imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
> imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
