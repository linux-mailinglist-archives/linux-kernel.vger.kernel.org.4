Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2432663725E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 07:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiKXGaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 01:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiKXGaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 01:30:06 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFC3A8C3A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 22:30:00 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id n205so710521oib.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 22:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kXOyo4HnFvsuhoWmmSBzQJF7eh9dhhrJCbYJ5TI9WW8=;
        b=BDNPkDf2PV9te9oCIttxQ31EyRbbphpbd/f+kY8bpVMkFHoo0BX8LTIJg9uvrkqRXZ
         BVAMdzQkR0BlK2tHL/LIkQGQC7B4HseyZLE8TMVvys8+a98eUKi5WUWn5fyEBQZvckzg
         fVXPsFxwrQQlSLmRgwMkFmj8/T0IdWxHIVA2S8ifBqgHI3GJjqrkIj2xqAL46fQd+U12
         lA70dTALIoOwH3q9HMkuJSCUcCrcgqCy12Yq1xtnMY5+CrtHjQDyAXMpsImDSkDz2vHC
         8TlNGYGkNyvbOkIP6l0Zwq6UbJSzrd1bgHg1Fpej7AzxrrUkJssUhCNTMwpf/xrTHJOs
         ZBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kXOyo4HnFvsuhoWmmSBzQJF7eh9dhhrJCbYJ5TI9WW8=;
        b=zFsYIuu4ZPp7ZW+ykYP/VptlHRzZaRJyrH72nwZR3RAsu+KreiqeSCVhDN92X3HOf+
         JgNTcGWtJvR5mT/RcwxEeeYKSMCAu/yDX3ynb2xEzw8fVOELUSPscGEZr2gtSW1S/yfH
         Ze1QvS7PAYyrefiQ9ie1em3UxSPcA3BOtuBFc80bWagm7clwVh+rj9sEiJQy77zir8c0
         /SK4CgimdgaihNUhPBAeXvOn2yigjI+PigO07ndaDLt+ZixOcw1LUsMNKysTGpPHk1Hq
         zB5gLGNUNJbEJqOzO4yMTMWZVKKFC82J+J+KHgsUqsrLR5tHo6Koj84QHamLhLOjpUj7
         ScuA==
X-Gm-Message-State: ANoB5plUz8teJAJLYyv03eILchUBh1350V+RSsGK1oBaQLdYl5Wict5v
        TnfHttSPxnii5ZKMBDuU9Hiqj7vocLosArhpcCV3Vw==
X-Google-Smtp-Source: AA0mqf5IxNLq8/DvNqfVifEK2iqiuUWcHs2nUxN7ngSEol6mbnisynad/LkZzF6PoHXNuyHKAzmMpeIAVXhgcYifsM4=
X-Received: by 2002:aca:1110:0:b0:35a:7e1d:3d72 with SMTP id
 16-20020aca1110000000b0035a7e1d3d72mr18352352oir.233.1669271400945; Wed, 23
 Nov 2022 22:30:00 -0800 (PST)
MIME-Version: 1.0
References: <0000000000006ca1a705edff52cf@google.com>
In-Reply-To: <0000000000006ca1a705edff52cf@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 24 Nov 2022 07:29:50 +0100
Message-ID: <CACT4Y+Zchj3WnRU9co8ZiP=Gy2m5ASZX1gPcMZTh6QNrx=qrgQ@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Write in expire_timers
To:     syzbot <syzbot+38ee3533e07da8749f85@syzkaller.appspotmail.com>,
        krzysztof.kozlowski@linaro.org,
        Bongsu Jeon <bongsu.jeon@samsung.com>
Cc:     arnd@arndb.de, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, will@kernel.org,
        zhengqi.arch@bytedance.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2022 at 19:35, syzbot
<syzbot+38ee3533e07da8749f85@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    b6e7fdfd6f6a Merge tag 'iommu-fixes-v6.1-rc5' of git://git..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11c28f95880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=95fb379f123ba8ce
> dashboard link: https://syzkaller.appspot.com/bug?extid=38ee3533e07da8749f85
> compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm64
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+38ee3533e07da8749f85@syzkaller.appspotmail.com

Looks like an issue in NCI core.
+Krzysztof, Bongsu

> ==================================================================
> BUG: KASAN: use-after-free in __hlist_del include/linux/list.h:885 [inline]
> BUG: KASAN: use-after-free in detach_timer kernel/time/timer.c:880 [inline]
> BUG: KASAN: use-after-free in expire_timers+0x74/0xc4 kernel/time/timer.c:1508
> Write at addr f8ff000005c37858 by task syz-executor.1/2271
> Pointer tag: [f8], memory tag: [fe]
>
> CPU: 0 PID: 2271 Comm: syz-executor.1 Not tainted 6.1.0-rc5-syzkaller-00320-gb6e7fdfd6f6a #0
> Hardware name: linux,dummy-virt (DT)
> Call trace:
>  dump_backtrace.part.0+0xe0/0xf0 arch/arm64/kernel/stacktrace.c:156
>  dump_backtrace arch/arm64/kernel/stacktrace.c:162 [inline]
>  show_stack+0x18/0x40 arch/arm64/kernel/stacktrace.c:163
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x68/0x84 lib/dump_stack.c:106
>  print_address_description mm/kasan/report.c:284 [inline]
>  print_report+0x1a8/0x4a0 mm/kasan/report.c:395
>  kasan_report+0x94/0xb4 mm/kasan/report.c:495
>  __do_kernel_fault+0x164/0x1e0 arch/arm64/mm/fault.c:320
>  do_bad_area arch/arm64/mm/fault.c:473 [inline]
>  do_tag_check_fault+0x78/0x8c arch/arm64/mm/fault.c:749
>  do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:825
>  el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
>  el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
>  el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:576
>  __hlist_del include/linux/list.h:885 [inline]
>  detach_timer kernel/time/timer.c:880 [inline]
>  expire_timers+0x74/0xc4 kernel/time/timer.c:1508
>  __run_timers kernel/time/timer.c:1790 [inline]
>  __run_timers kernel/time/timer.c:1763 [inline]
>  run_timer_softirq+0xf4/0x254 kernel/time/timer.c:1803
>  _stext+0x124/0x2a4
>  ____do_softirq+0x10/0x20 arch/arm64/kernel/irq.c:79
>  call_on_irq_stack+0x2c/0x5c arch/arm64/kernel/entry.S:889
>  do_softirq_own_stack+0x1c/0x30 arch/arm64/kernel/irq.c:84
>  invoke_softirq kernel/softirq.c:452 [inline]
>  __irq_exit_rcu+0xcc/0xf4 kernel/softirq.c:650
>  irq_exit_rcu+0x10/0x20 kernel/softirq.c:662
>  el0_interrupt+0x54/0x104 arch/arm64/kernel/entry-common.c:717
>  __el0_irq_handler_common+0x18/0x2c arch/arm64/kernel/entry-common.c:724
>  el0t_64_irq_handler+0x10/0x20 arch/arm64/kernel/entry-common.c:729
>  el0t_64_irq+0x198/0x19c arch/arm64/kernel/entry.S:582
>
> Allocated by task 3867:
>  kasan_save_stack+0x2c/0x60 mm/kasan/common.c:45
>  save_stack_info+0x38/0x130 mm/kasan/tags.c:104
>  kasan_save_alloc_info+0x14/0x20 mm/kasan/tags.c:138
>  ____kasan_kmalloc mm/kasan/common.c:371 [inline]
>  ____kasan_kmalloc mm/kasan/common.c:330 [inline]
>  __kasan_kmalloc+0x9c/0xb0 mm/kasan/common.c:380
>  kasan_kmalloc include/linux/kasan.h:211 [inline]
>  kmalloc_trace+0x5c/0x70 mm/slab_common.c:1050
>  kmalloc include/linux/slab.h:553 [inline]
>  kzalloc include/linux/slab.h:689 [inline]
>  nci_allocate_device net/nfc/nci/core.c:1157 [inline]
>  nci_allocate_device+0x5c/0x170 net/nfc/nci/core.c:1143
>  virtual_ncidev_open+0x54/0xe0 drivers/nfc/virtual_ncidev.c:139
>  misc_open+0x124/0x170 drivers/char/misc.c:143
>  chrdev_open+0xc0/0x260 fs/char_dev.c:414
>  do_dentry_open+0x13c/0x4d0 fs/open.c:882
>  vfs_open+0x2c/0x40 fs/open.c:1013
>  do_open fs/namei.c:3557 [inline]
>  path_openat+0x568/0xee0 fs/namei.c:3713
>  do_filp_open+0x80/0x130 fs/namei.c:3740
>  do_sys_openat2+0xb4/0x16c fs/open.c:1310
>  do_sys_open fs/open.c:1326 [inline]
>  __do_sys_openat fs/open.c:1342 [inline]
>  __se_sys_openat fs/open.c:1337 [inline]
>  __arm64_sys_openat+0x64/0xb0 fs/open.c:1337
>  __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
>  invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
>  el0_svc_common.constprop.0+0x44/0xec arch/arm64/kernel/syscall.c:142
>  do_el0_svc+0x2c/0xd0 arch/arm64/kernel/syscall.c:206
>  el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:637
>  el0t_64_sync_handler+0xb8/0xc0 arch/arm64/kernel/entry-common.c:655
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:581
>
> Freed by task 3864:
>  kasan_save_stack+0x2c/0x60 mm/kasan/common.c:45
>  save_stack_info+0x38/0x130 mm/kasan/tags.c:104
>  kasan_save_free_info+0x18/0x30 mm/kasan/tags.c:143
>  ____kasan_slab_free.constprop.0+0x1b8/0x230 mm/kasan/common.c:236
>  __kasan_slab_free+0x10/0x1c mm/kasan/common.c:244
>  kasan_slab_free include/linux/kasan.h:177 [inline]
>  slab_free_hook mm/slub.c:1724 [inline]
>  slab_free_freelist_hook+0xbc/0x1fc mm/slub.c:1750
>  slab_free mm/slub.c:3661 [inline]
>  __kmem_cache_free+0x16c/0x2ec mm/slub.c:3674
>  kfree+0x60/0xb0 mm/slab_common.c:1007
>  nci_free_device+0x30/0x40 net/nfc/nci/core.c:1205
>  virtual_ncidev_close+0x74/0x80 drivers/nfc/virtual_ncidev.c:167
>  __fput+0x78/0x260 fs/file_table.c:320
>  ____fput+0x10/0x20 fs/file_table.c:348
>  task_work_run+0x80/0xe0 kernel/task_work.c:179
>  resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
>  do_notify_resume+0x218/0x13b0 arch/arm64/kernel/signal.c:1127
>  prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
>  exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
>  el0_svc+0xac/0xb0 arch/arm64/kernel/entry-common.c:638
>  el0t_64_sync_handler+0xb8/0xc0 arch/arm64/kernel/entry-common.c:655
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:581
>
> The buggy address belongs to the object at ffff000005c37800
>  which belongs to the cache kmalloc-2k of size 2048
> The buggy address is located 88 bytes inside of
>  2048-byte region [ffff000005c37800, ffff000005c38000)
>
> The buggy address belongs to the physical page:
> page:000000007e5956af refcount:1 mapcount:0 mapping:0000000000000000 index:0xfcff000005c37800 pfn:0x45c30
> head:000000007e5956af order:3 compound_mapcount:0 compound_pincount:0
> flags: 0x1ffc00000010200(slab|head|node=0|zone=0|lastcpupid=0x7ff|kasantag=0x0)
> raw: 01ffc00000010200 0000000000000000 dead000000000001 f6ff000002c01600
> raw: fcff000005c37800 000000008010000d 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff000005c37600: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>  ffff000005c37700: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> >ffff000005c37800: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>                                   ^
>  ffff000005c37900: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>  ffff000005c37a00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> ==================================================================
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> Mem abort info:
>   ESR = 0x0000000086000005
>   EC = 0x21: IABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x05: level 1 translation fault
> user pgtable: 4k pages, 48-bit VAs, pgdp=000000004526f000
> [0000000000000000] pgd=0800000045ef2003, p4d=0800000045ef2003, pud=0000000000000000
> Internal error: Oops: 0000000086000005 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 0 PID: 2271 Comm: syz-executor.1 Tainted: G    B              6.1.0-rc5-syzkaller-00320-gb6e7fdfd6f6a #0
> Hardware name: linux,dummy-virt (DT)
> pstate: 60400809 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=-c)
> pc : 0x0
> lr : call_timer_fn.constprop.0+0x24/0x80 kernel/time/timer.c:1474
> sp : ffff800008003e70
> x29: ffff800008003e70 x28: 0000000000000007 x27: 0000000000000080
> x26: fcff000002c5ee40 x25: ffff80000a2b60c0 x24: ffff80000a2b60c8
> x23: dead000000000122 x22: 0000000000000000 x21: 0000000000000100
> x20: fcff000002c5ee40 x19: 0000000000000000 x18: 0000000000000000
> x17: ffff800075918000 x16: ffff800008004000 x15: 0000000000004000
> x14: 00000000000000f7 x13: 0000000000000001 x12: ffff00007fbb7068
> x11: 0000000000000001 x10: 408a800000000a00 x9 : 000000000000006e
> x8 : 2000000000000000 x7 : 0000000000000001 x6 : ffff00007fbb7028
> x5 : 0000000000000001 x4 : 0000000000000000 x3 : ffff800008003f20
> x2 : 0000000000000000 x1 : 0000000000000000 x0 : f8ff000005c37850
> Call trace:
>  0x0
>  expire_timers+0x98/0xc4 kernel/time/timer.c:1519
>  __run_timers kernel/time/timer.c:1790 [inline]
>  __run_timers kernel/time/timer.c:1763 [inline]
>  run_timer_softirq+0xf4/0x254 kernel/time/timer.c:1803
>  _stext+0x124/0x2a4
>  ____do_softirq+0x10/0x20 arch/arm64/kernel/irq.c:79
>  call_on_irq_stack+0x2c/0x5c arch/arm64/kernel/entry.S:889
>  do_softirq_own_stack+0x1c/0x30 arch/arm64/kernel/irq.c:84
>  invoke_softirq kernel/softirq.c:452 [inline]
>  __irq_exit_rcu+0xcc/0xf4 kernel/softirq.c:650
>  irq_exit_rcu+0x10/0x20 kernel/softirq.c:662
>  el0_interrupt+0x54/0x104 arch/arm64/kernel/entry-common.c:717
>  __el0_irq_handler_common+0x18/0x2c arch/arm64/kernel/entry-common.c:724
>  el0t_64_irq_handler+0x10/0x20 arch/arm64/kernel/entry-common.c:729
>  el0t_64_irq+0x198/0x19c arch/arm64/kernel/entry.S:582
> Code: bad PC value
> ---[ end trace 0000000000000000 ]---
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000006ca1a705edff52cf%40google.com.
