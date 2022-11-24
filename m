Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86F1637257
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 07:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiKXGYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 01:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiKXGYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 01:24:40 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB0EB962C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 22:24:34 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id h20-20020a056e021d9400b00300581edaa5so675341ila.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 22:24:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R6Y8H/Sp73pf6yjCTwrmVFS0cXIrBxro9F//MsPHiVw=;
        b=RZdMunV6674SlrU5UGt/Lg8pJb+gn+AgQVYxDmu1T+hgcQK4x7DvKa/46SzqErkAJv
         nlkiYXqgLwXthezwYcIILTD6MiBf4uIjzxDzDpZqEk/bD6vqPvkQcDX0DmO46iTGallh
         d4ildkhNqfJ1RWJPDbyN4XF2tqe9Ypm5xnZHz4DrKiKoCgox/ehvNXDFJ/LZSBOqaL8S
         9AhL+c2MBTPiAE49aTMb1H3xl6pdjrMs5S8BQcQaP3Q3l/KzI1EgBB93p6Ds2lhuwgP7
         wkADyKifLaBkYkOwjzjyq99E2XEkUUbvvw92e+Wj2SJYVTeS1xOhFnbHtUsVA4VUTUrQ
         jFFA==
X-Gm-Message-State: ANoB5pm3hK5Zy1HLJVzobT1HExQjv5YM+Tv10Y3ooEd347c0+q/X5Spi
        0vkkQiilI9zUtMYx6z3mH8GqGHN7dUXhjW8g0iNshVOxr1Rt
X-Google-Smtp-Source: AA0mqf4KUoxsB6PcB/zCm+fkXHVSMSEg/mv6W1rChNyuzGUlrVXs+iUnWYopZyN6HpKBD1jC9ewxLiA0iS7yEtBAmQ9qOzM+KA/n
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8c:b0:2ff:e41c:7236 with SMTP id
 h12-20020a056e021d8c00b002ffe41c7236mr6217304ila.269.1669271074993; Wed, 23
 Nov 2022 22:24:34 -0800 (PST)
Date:   Wed, 23 Nov 2022 22:24:34 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007582e705ee317534@google.com>
Subject: [syzbot] KASAN: use-after-free Write in collect_expired_timers
From:   syzbot <syzbot+8bba845192b07c0f06a1@syzkaller.appspotmail.com>
To:     arnd@arndb.de, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, will@kernel.org,
        zhengqi.arch@bytedance.com
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

HEAD commit:    fe24a97cf254 Merge tag 'input-for-v6.1-rc5' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14802765880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95fb379f123ba8ce
dashboard link: https://syzkaller.appspot.com/bug?extid=8bba845192b07c0f06a1
compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8bba845192b07c0f06a1@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in hlist_move_list include/linux/list.h:1013 [inline]
BUG: KASAN: use-after-free in collect_expired_timers+0x60/0x8c kernel/time/timer.c:1540
Write at addr f0ff000005295858 by task modprobe/17778
Pointer tag: [f0], memory tag: [fe]

CPU: 1 PID: 17778 Comm: modprobe Not tainted 6.1.0-rc5-syzkaller-00307-gfe24a97cf254 #0
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace.part.0+0xe0/0xf0 arch/arm64/kernel/stacktrace.c:156
 dump_backtrace arch/arm64/kernel/stacktrace.c:162 [inline]
 show_stack+0x18/0x40 arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x68/0x84 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:284 [inline]
 print_report+0x1a8/0x4a0 mm/kasan/report.c:395
 kasan_report+0x94/0xb4 mm/kasan/report.c:495
 __do_kernel_fault+0x164/0x1e0 arch/arm64/mm/fault.c:320
 do_bad_area arch/arm64/mm/fault.c:473 [inline]
 do_tag_check_fault+0x78/0x8c arch/arm64/mm/fault.c:749
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:825
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:576
 hlist_move_list include/linux/list.h:1013 [inline]
 collect_expired_timers+0x60/0x8c kernel/time/timer.c:1540
 _stext+0x124/0x2a4
 ____do_softirq+0x10/0x20 arch/arm64/kernel/irq.c:79
 call_on_irq_stack+0x2c/0x5c arch/arm64/kernel/entry.S:889
 do_softirq_own_stack+0x1c/0x30 arch/arm64/kernel/irq.c:84
 invoke_softirq kernel/softirq.c:452 [inline]
 __irq_exit_rcu+0xcc/0xf4 kernel/softirq.c:650
 irq_exit_rcu+0x10/0x20 kernel/softirq.c:662
 __el1_irq arch/arm64/kernel/entry-common.c:472 [inline]
 el1_interrupt+0x38/0x6c arch/arm64/kernel/entry-common.c:486
 el1h_64_irq_handler+0x18/0x2c arch/arm64/kernel/entry-common.c:491
 el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:577
 folio_test_hugetlb include/linux/page-flags.h:831 [inline]
 folio_file_page include/linux/pagemap.h:683 [inline]
 filemap_map_pages+0x308/0x5e4 mm/filemap.c:3365
 do_fault_around mm/memory.c:4523 [inline]
 do_read_fault mm/memory.c:4549 [inline]
 do_fault mm/memory.c:4683 [inline]
 handle_pte_fault mm/memory.c:4955 [inline]
 __handle_mm_fault+0x938/0xeb0 mm/memory.c:5097
 handle_mm_fault+0xec/0x280 mm/memory.c:5218
 __do_page_fault arch/arm64/mm/fault.c:506 [inline]
 do_page_fault+0x17c/0x3d0 arch/arm64/mm/fault.c:606
 do_translation_fault+0xac/0xc0 arch/arm64/mm/fault.c:689
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:825
 el0_ia+0x5c/0x11c arch/arm64/kernel/entry-common.c:533
 el0t_64_sync_handler+0x78/0xc0 arch/arm64/kernel/entry-common.c:661
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:581

Freed by task 17715:
 kasan_save_stack+0x2c/0x60 mm/kasan/common.c:45
 save_stack_info+0x38/0x130 mm/kasan/tags.c:104
 kasan_save_free_info+0x18/0x30 mm/kasan/tags.c:143
 ____kasan_slab_free.constprop.0+0x1b8/0x230 mm/kasan/common.c:236
 __kasan_slab_free+0x10/0x1c mm/kasan/common.c:244
 kasan_slab_free include/linux/kasan.h:177 [inline]
 slab_free_hook mm/slub.c:1724 [inline]
 slab_free_freelist_hook+0xbc/0x1fc mm/slub.c:1750
 slab_free mm/slub.c:3661 [inline]
 __kmem_cache_free+0x16c/0x2ec mm/slub.c:3674
 kfree+0x60/0xb0 mm/slab_common.c:1007
 nci_free_device+0x30/0x40 net/nfc/nci/core.c:1205
 virtual_ncidev_close+0x74/0x80 drivers/nfc/virtual_ncidev.c:167
 __fput+0x78/0x260 fs/file_table.c:320
 ____fput+0x10/0x20 fs/file_table.c:348
 task_work_run+0x80/0xe0 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x218/0x13b0 arch/arm64/kernel/signal.c:1127
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0xac/0xb0 arch/arm64/kernel/entry-common.c:638
 el0t_64_sync_handler+0xb8/0xc0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:581

The buggy address belongs to the object at ffff000005295800
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 88 bytes inside of
 2048-byte region [ffff000005295800, ffff000005296000)

The buggy address belongs to the physical page:
page:000000004b7f1e57 refcount:1 mapcount:0 mapping:0000000000000000 index:0xf0ff000005295800 pfn:0x45290
head:000000004b7f1e57 order:3 compound_mapcount:0 compound_pincount:0
flags: 0x1ffc00000010200(slab|head|node=0|zone=0|lastcpupid=0x7ff|kasantag=0x0)
raw: 01ffc00000010200 0000000000000000 dead000000000001 f1ff000002c01600
raw: f0ff000005295800 000000008010000c 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff000005295600: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
 ffff000005295700: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>ffff000005295800: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
                                  ^
 ffff000005295900: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
 ffff000005295a00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
==================================================================
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff80007592d000
WARNING: CPU: 1 PID: 17778 at arch/arm64/mm/fault.c:369 __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
Modules linked in:
CPU: 1 PID: 17778 Comm: modprobe Tainted: G    B              6.1.0-rc5-syzkaller-00307-gfe24a97cf254 #0
Hardware name: linux,dummy-virt (DT)
pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
lr : __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
sp : ffff80000800bbc0
x29: ffff80000800bbc0 x28: f8ff000025d88fc0 x27: 0000000000000008
x26: ffff80000a29c008 x25: ffff80000a2a2cc0 x24: ffff80000a2c3388
x23: 00000000a04000c9 x22: 0000000000000025 x21: ffff80007592d000
x20: ffff80000800bc80 x19: 0000000097c18005 x18: 00000000fffffffe
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80000a2eda70 x13: 0000000000001536 x12: 0000000000000712
x11: 2073736572646461 x10: ffff80000a39da70 x9 : 00000000ffffe000
x8 : ffff80000a2eda70 x7 : ffff80000a39da70 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f8ff000025d88fc0
Call trace:
 __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
 do_bad_area arch/arm64/mm/fault.c:473 [inline]
 do_translation_fault+0x50/0xc0 arch/arm64/mm/fault.c:691
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:825
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:576
 get_work_pool kernel/workqueue.c:741 [inline]
 __queue_work+0xf4/0x4a0 kernel/workqueue.c:1458
 queue_work_on+0x6c/0x90 kernel/workqueue.c:1545
 queue_work include/linux/workqueue.h:503 [inline]
 nci_cmd_timer+0x28/0x34 net/nfc/nci/core.c:615
 call_timer_fn.constprop.0+0x24/0x80 kernel/time/timer.c:1474
 expire_timers+0x98/0xc4 kernel/time/timer.c:1519
 __run_timers kernel/time/timer.c:1790 [inline]
 __run_timers kernel/time/timer.c:1763 [inline]
 run_timer_softirq+0xf4/0x254 kernel/time/timer.c:1803
 _stext+0x124/0x2a4
 ____do_softirq+0x10/0x20 arch/arm64/kernel/irq.c:79
 call_on_irq_stack+0x2c/0x5c arch/arm64/kernel/entry.S:889
 do_softirq_own_stack+0x1c/0x30 arch/arm64/kernel/irq.c:84
 invoke_softirq kernel/softirq.c:452 [inline]
 __irq_exit_rcu+0xcc/0xf4 kernel/softirq.c:650
 irq_exit_rcu+0x10/0x20 kernel/softirq.c:662
 __el1_irq arch/arm64/kernel/entry-common.c:472 [inline]
 el1_interrupt+0x38/0x6c arch/arm64/kernel/entry-common.c:486
 el1h_64_irq_handler+0x18/0x2c arch/arm64/kernel/entry-common.c:491
 el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:577
 folio_test_hugetlb include/linux/page-flags.h:831 [inline]
 folio_file_page include/linux/pagemap.h:683 [inline]
 filemap_map_pages+0x308/0x5e4 mm/filemap.c:3365
 do_fault_around mm/memory.c:4523 [inline]
 do_read_fault mm/memory.c:4549 [inline]
 do_fault mm/memory.c:4683 [inline]
 handle_pte_fault mm/memory.c:4955 [inline]
 __handle_mm_fault+0x938/0xeb0 mm/memory.c:5097
 handle_mm_fault+0xec/0x280 mm/memory.c:5218
 __do_page_fault arch/arm64/mm/fault.c:506 [inline]
 do_page_fault+0x17c/0x3d0 arch/arm64/mm/fault.c:606
 do_translation_fault+0xac/0xc0 arch/arm64/mm/fault.c:689
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:825
 el0_ia+0x5c/0x11c arch/arm64/kernel/entry-common.c:533
 el0t_64_sync_handler+0x78/0xc0 arch/arm64/kernel/entry-common.c:661
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:581
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff80007592d000
WARNING: CPU: 1 PID: 17778 at arch/arm64/mm/fault.c:369 __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
Modules linked in:
CPU: 1 PID: 17778 Comm: modprobe Tainted: G    B   W          6.1.0-rc5-syzkaller-00307-gfe24a97cf254 #0
Hardware name: linux,dummy-virt (DT)
pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
lr : __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
sp : ffff80000800bbc0
x29: ffff80000800bbc0 x28: f8ff000025d88fc0 x27: 0000000000000008
x26: ffff80000a29c008 x25: ffff80000a2a2cc0 x24: ffff80000a2c3388
x23: 00000000a04000c9 x22: 0000000000000025 x21: ffff80007592d000
x20: ffff80000800bc80 x19: 0000000097c18005 x18: 00000000fffffffe
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80000a2eda70 x13: 00000000000015d2 x12: 0000000000000746
x11: 2073736572646461 x10: ffff80000a39da70 x9 : 00000000ffffe000
x8 : ffff80000a2eda70 x7 : ffff80000a39da70 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f8ff000025d88fc0
Call trace:
 __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
 do_bad_area arch/arm64/mm/fault.c:473 [inline]
 do_translation_fault+0x50/0xc0 arch/arm64/mm/fault.c:691
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:825
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:576
 get_work_pool kernel/workqueue.c:741 [inline]
 __queue_work+0xf4/0x4a0 kernel/workqueue.c:1458
 queue_work_on+0x6c/0x90 kernel/workqueue.c:1545
 queue_work include/linux/workqueue.h:503 [inline]
 nci_cmd_timer+0x28/0x34 net/nfc/nci/core.c:615
 call_timer_fn.constprop.0+0x24/0x80 kernel/time/timer.c:1474
 expire_timers+0x98/0xc4 kernel/time/timer.c:1519
 __run_timers kernel/time/timer.c:1790 [inline]
 __run_timers kernel/time/timer.c:1763 [inline]
 run_timer_softirq+0xf4/0x254 kernel/time/timer.c:1803
 _stext+0x124/0x2a4
 ____do_softirq+0x10/0x20 arch/arm64/kernel/irq.c:79
 call_on_irq_stack+0x2c/0x5c arch/arm64/kernel/entry.S:889
 do_softirq_own_stack+0x1c/0x30 arch/arm64/kernel/irq.c:84
 invoke_softirq kernel/softirq.c:452 [inline]
 __irq_exit_rcu+0xcc/0xf4 kernel/softirq.c:650
 irq_exit_rcu+0x10/0x20 kernel/softirq.c:662
 __el1_irq arch/arm64/kernel/entry-common.c:472 [inline]
 el1_interrupt+0x38/0x6c arch/arm64/kernel/entry-common.c:486
 el1h_64_irq_handler+0x18/0x2c arch/arm64/kernel/entry-common.c:491
 el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:577
 folio_test_hugetlb include/linux/page-flags.h:831 [inline]
 folio_file_page include/linux/pagemap.h:683 [inline]
 filemap_map_pages+0x308/0x5e4 mm/filemap.c:3365
 do_fault_around mm/memory.c:4523 [inline]
 do_read_fault mm/memory.c:4549 [inline]
 do_fault mm/memory.c:4683 [inline]
 handle_pte_fault mm/memory.c:4955 [inline]
 __handle_mm_fault+0x938/0xeb0 mm/memory.c:5097
 handle_mm_fault+0xec/0x280 mm/memory.c:5218
 __do_page_fault arch/arm64/mm/fault.c:506 [inline]
 do_page_fault+0x17c/0x3d0 arch/arm64/mm/fault.c:606
 do_translation_fault+0xac/0xc0 arch/arm64/mm/fault.c:689
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:825
 el0_ia+0x5c/0x11c arch/arm64/kernel/entry-common.c:533
 el0t_64_sync_handler+0x78/0xc0 arch/arm64/kernel/entry-common.c:661
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:581
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff80007592d000
WARNING: CPU: 1 PID: 17778 at arch/arm64/mm/fault.c:369 __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
Modules linked in:
CPU: 1 PID: 17778 Comm: modprobe Tainted: G    B   W          6.1.0-rc5-syzkaller-00307-gfe24a97cf254 #0
Hardware name: linux,dummy-virt (DT)
pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
lr : __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
sp : ffff80000800bbc0
x29: ffff80000800bbc0 x28: f8ff000025d88fc0 x27: 0000000000000008
x26: ffff80000a29c008 x25: ffff80000a2a2cc0 x24: ffff80000a2c3388
x23: 00000000a04000c9 x22: 0000000000000025 x21: ffff80007592d000
x20: ffff80000800bc80 x19: 0000000097c18005 x18: 00000000fffffffe
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80000a2eda70 x13: 000000000000166e x12: 000000000000077a
x11: 2073736572646461 x10: ffff80000a39da70 x9 : 00000000ffffe000
x8 : ffff80000a2eda70 x7 : ffff80000a39da70 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f8ff000025d88fc0
Call trace:
 __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
 do_bad_area arch/arm64/mm/fault.c:473 [inline]
 do_translation_fault+0x50/0xc0 arch/arm64/mm/fault.c:691
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:825
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:576
 get_work_pool kernel/workqueue.c:741 [inline]
 __queue_work+0xf4/0x4a0 kernel/workqueue.c:1458
 queue_work_on+0x6c/0x90 kernel/workqueue.c:1545
 queue_work include/linux/workqueue.h:503 [inline]
 nci_cmd_timer+0x28/0x34 net/nfc/nci/core.c:615
 call_timer_fn.constprop.0+0x24/0x80 kernel/time/timer.c:1474
 expire_timers+0x98/0xc4 kernel/time/timer.c:1519
 __run_timers kernel/time/timer.c:1790 [inline]
 __run_timers kernel/time/timer.c:1763 [inline]
 run_timer_softirq+0xf4/0x254 kernel/time/timer.c:1803
 _stext+0x124/0x2a4
 ____do_softirq+0x10/0x20 arch/arm64/kernel/irq.c:79
 call_on_irq_stack+0x2c/0x5c arch/arm64/kernel/entry.S:889
 do_softirq_own_stack+0x1c/0x30 arch/arm64/kernel/irq.c:84
 invoke_softirq kernel/softirq.c:452 [inline]
 __irq_exit_rcu+0xcc/0xf4 kernel/softirq.c:650
 irq_exit_rcu+0x10/0x20 kernel/softirq.c:662
 __el1_irq arch/arm64/kernel/entry-common.c:472 [inline]
 el1_interrupt+0x38/0x6c arch/arm64/kernel/entry-common.c:486
 el1h_64_irq_handler+0x18/0x2c arch/arm64/kernel/entry-common.c:491
 el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:577
 folio_test_hugetlb include/linux/page-flags.h:831 [inline]
 folio_file_page include/linux/pagemap.h:683 [inline]
 filemap_map_pages+0x308/0x5e4 mm/filemap.c:3365
 do_fault_around mm/memory.c:4523 [inline]
 do_read_fault mm/memory.c:4549 [inline]
 do_fault mm/memory.c:4683 [inline]
 handle_pte_fault mm/memory.c:4955 [inline]
 __handle_mm_fault+0x938/0xeb0 mm/memory.c:5097
 handle_mm_fault+0xec/0x280 mm/memory.c:5218
 __do_page_fault arch/arm64/mm/fault.c:506 [inline]
 do_page_fault+0x17c/0x3d0 arch/arm64/mm/fault.c:606
 do_translation_fault+0xac/0xc0 arch/arm64/mm/fault.c:689
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:825
 el0_ia+0x5c/0x11c arch/arm64/kernel/entry-common.c:533
 el0t_64_sync_handler+0x78/0xc0 arch/arm64/kernel/entry-common.c:661
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:581
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff80007592d000
WARNING: CPU: 1 PID: 17778 at arch/arm64/mm/fault.c:369 __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
Modules linked in:
CPU: 1 PID: 17778 Comm: modprobe Tainted: G    B   W          6.1.0-rc5-syzkaller-00307-gfe24a97cf254 #0
Hardware name: linux,dummy-virt (DT)
pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
lr : __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
sp : ffff80000800bbc0
x29: ffff80000800bbc0 x28: f8ff000025d88fc0 x27: 0000000000000008
x26: ffff80000a29c008 x25: ffff80000a2a2cc0 x24: ffff80000a2c3388
x23: 00000000a04000c9 x22: 0000000000000025 x21: ffff80007592d000
x20: ffff80000800bc80 x19: 0000000097c18005 x18: 00000000fffffffe
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80000a2eda70 x13: 000000000000170a x12: 00000000000007ae
x11: 2073736572646461 x10: ffff80000a39da70 x9 : 00000000ffffe000
x8 : ffff80000a2eda70 x7 : ffff80000a39da70 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f8ff000025d88fc0
Call trace:
 __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
 do_bad_area arch/arm64/mm/fault.c:473 [inline]
 do_translation_fault+0x50/0xc0 arch/arm64/mm/fault.c:691
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:825
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:576
 get_work_pool kernel/workqueue.c:741 [inline]
 __queue_work+0xf4/0x4a0 kernel/workqueue.c:1458
 queue_work_on+0x6c/0x90 kernel/workqueue.c:1545
 queue_work include/linux/workqueue.h:503 [inline]
 nci_cmd_timer+0x28/0x34 net/nfc/nci/core.c:615
 call_timer_fn.constprop.0+0x24/0x80 kernel/time/timer.c:1474
 expire_timers+0x98/0xc4 kernel/time/timer.c:1519
 __run_timers kernel/time/timer.c:1790 [inline]
 __run_timers kernel/time/timer.c:1763 [inline]
 run_timer_softirq+0xf4/0x254 kernel/time/timer.c:1803
 _stext+0x124/0x2a4
 ____do_softirq+0x10/0x20 arch/arm64/kernel/irq.c:79
 call_on_irq_stack+0x2c/0x5c arch/arm64/kernel/entry.S:889
 do_softirq_own_stack+0x1c/0x30 arch/arm64/kernel/irq.c:84
 invoke_softirq kernel/softirq.c:452 [inline]
 __irq_exit_rcu+0xcc/0xf4 kernel/softirq.c:650
 irq_exit_rcu+0x10/0x20 kernel/softirq.c:662
 __el1_irq arch/arm64/kernel/entry-common.c:472 [inline]
 el1_interrupt+0x38/0x6c arch/arm64/kernel/entry-common.c:486
 el1h_64_irq_handler+0x18/0x2c arch/arm64/kernel/entry-common.c:491
 el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:577
 folio_test_hugetlb include/linux/page-flags.h:831 [inline]
 folio_file_page include/linux/pagemap.h:683 [inline]
 filemap_map_pages+0x308/0x5e4 mm/filemap.c:3365
 do_fault_around mm/memory.c:4523 [inline]
 do_read_fault mm/memory.c:4549 [inline]
 do_fault mm/memory.c:4683 [inline]
 handle_pte_fault mm/memory.c:4955 [inline]
 __handle_mm_fault+0x938/0xeb0 mm/memory.c:5097
 handle_mm_fault+0xec/0x280 mm/memory.c:5218
 __do_page_fault arch/arm64/mm/fault.c:506 [inline]
 do_page_fault+0x17c/0x3d0 arch/arm64/mm/fault.c:606
 do_translation_fault+0xac/0xc0 arch/arm64/mm/fault.c:689
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:825
 el0_ia+0x5c/0x11c arch/arm64/kernel/entry-common.c:533
 el0t_64_sync_handler+0x78/0xc0 arch/arm64/kernel/entry-common.c:661
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:581
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff80007592d000
WARNING: CPU: 1 PID: 17778 at arch/arm64/mm/fault.c:369 __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
Modules linked in:
CPU: 1 PID: 17778 Comm: modprobe Tainted: G    B   W          6.1.0-rc5-syzkaller-00307-gfe24a97cf254 #0
Hardware name: linux,dummy-virt (DT)
pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
lr : __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
sp : ffff80000800bbc0
x29: ffff80000800bbc0 x28: f8ff000025d88fc0 x27: 0000000000000008
x26: ffff80000a29c008 x25: ffff80000a2a2cc0 x24: ffff80000a2c3388
x23: 00000000a04000c9 x22: 0000000000000025 x21: ffff80007592d000
x20: ffff80000800bc80 x19: 0000000097c18005 x18: 00000000fffffffe
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80000a2eda70 x13: 00000000000017a6 x12: 00000000000007e2
x11: 2073736572646461 x10: ffff80000a39da70 x9 : 00000000ffffe000
x8 : ffff80000a2eda70 x7 : ffff80000a39da70 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f8ff000025d88fc0
Call trace:
 __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
 do_bad_area arch/arm64/mm/fault.c:473 [inline]
 do_translation_fault+0x50/0xc0 arch/arm64/mm/fault.c:691
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:825
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:576
 get_work_pool kernel/workqueue.c:741 [inline]
 __queue_work+0xf4/0x4a0 kernel/workqueue.c:1458
 queue_work_on+0x6c/0x90 kernel/workqueue.c:1545
 queue_work include/linux/workqueue.h:503 [inline]
 nci_cmd_timer+0x28/0x34 net/nfc/nci/core.c:615
 call_timer_fn.constprop.0+0x24/0x80 kernel/time/timer.c:1474
 expire_timers+0x98/0xc4 kernel/time/timer.c:1519
 __run_timers kernel/time/timer.c:1790 [inline]
 __run_timers kernel/time/timer.c:1763 [inline]
 run_timer_softirq+0xf4/0x254 kernel/time/timer.c:1803
 _stext+0x124/0x2a4
 ____do_softirq+0x10/0x20 arch/arm64/kernel/irq.c:79
 call_on_irq_stack+0x2c/0x5c arch/arm64/kernel/entry.S:889
 do_softirq_own_stack+0x1c/0x30 arch/arm64/kernel/irq.c:84
 invoke_softirq kernel/softirq.c:452 [inline]
 __irq_exit_rcu+0xcc/0xf4 kernel/softirq.c:650
 irq_exit_rcu+0x10/0x20 kernel/softirq.c:662
 __el1_irq arch/arm64/kernel/entry-common.c:472 [inline]
 el1_interrupt+0x38/0x6c arch/arm64/kernel/entry-common.c:486
 el1h_64_irq_handler+0x18/0x2c arch/arm64/kernel/entry-common.c:491
 el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:577
 folio_test_hugetlb include/linux/page-flags.h:831 [inline]
 folio_file_page include/linux/pagemap.h:683 [inline]
 filemap_map_pages+0x308/0x5e4 mm/filemap.c:3365
 do_fault_around mm/memory.c:4523 [inline]
 do_read_fault mm/memory.c:4549 [inline]
 do_fault mm/memory.c:4683 [inline]
 handle_pte_fault mm/memory.c:4955 [inline]
 __handle_mm_fault+0x938/0xeb0 mm/memory.c:5097
 handle_mm_fault+0xec/0x280 mm/memory.c:5218
 __do_page_fault arch/arm64/mm/fault.c:506 [inline]
 do_page_fault+0x17c/0x3d0 arch/arm64/mm/fault.c:606
 do_translation_fault+0xac/0xc0 arch/arm64/mm/fault.c:689
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:825
 el0_ia+0x5c/0x11c arch/arm64/kernel/entry-common.c:533
 el0t_64_sync_handler+0x78/0xc0 arch/arm64/kernel/entry-common.c:661
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:581
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff80007592d000
WARNING: CPU: 1 PID: 17778 at arch/arm64/mm/fault.c:369 __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
Modules linked in:
CPU: 1 PID: 17778 Comm: modprobe Tainted: G    B   W          6.1.0-rc5-syzkaller-00307-gfe24a97cf254 #0
Hardware name: linux,dummy-virt (DT)
pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
lr : __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
sp : ffff80000800bbc0
x29: ffff80000800bbc0 x28: f8ff000025d88fc0 x27: 0000000000000008
x26: ffff80000a29c008 x25: ffff80000a2a2cc0 x24: ffff80000a2c3388
x23: 00000000a04000c9 x22: 0000000000000025 x21: ffff80007592d000
x20: ffff80000800bc80 x19: 0000000097c18005 x18: 00000000fffffffe
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80000a2eda70 x13: 0000000000001842 x12: 0000000000000816
x11: 2073736572646461 x10: ffff80000a39da70 x9 : 00000000ffffe000
x8 : ffff80000a2eda70 x7 : ffff80000a39da70 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f8ff000025d88fc0
Call trace:
 __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
 do_bad_area arch/arm64/mm/fault.c:473 [inline]
 do_translation_fault+0x50/0xc0 arch/arm64/mm/fault.c:691
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:825
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:576
 get_work_pool kernel/workqueue.c:741 [inline]
 __queue_work+0xf4/0x4a0 kernel/workqueue.c:1458
 queue_work_on+0x6c/0x90 kernel/workqueue.c:1545
 queue_work include/linux/workqueue.h:503 [inline]
 nci_cmd_timer+0x28/0x34 net/nfc/nci/core.c:615
 call_timer_fn.constprop.0+0x24/0x80 kernel/time/timer.c:1474
 expire_timers+0x98/0xc4 kernel/time/timer.c:1519
 __run_timers kernel/time/timer.c:1790 [inline]
 __run_timers kernel/time/timer.c:1763 [inline]
 run_timer_softirq+0xf4/0x254 kernel/time/timer.c:1803
 _stext+0x124/0x2a4
 ____do_softirq+0x10/0x20 arch/arm64/kernel/irq.c:79
 call_on_irq_stack+0x2c/0x5c arch/arm64/kernel/entry.S:889
 do_softirq_own_stack+0x1c/0x30 arch/arm64/kernel/irq.c:84
 invoke_softirq kernel/softirq.c:452 [inline]
 __irq_exit_rcu+0xcc/0xf4 kernel/softirq.c:650
 irq_exit_rcu+0x10/0x20 kernel/softirq.c:662
 __el1_irq arch/arm64/kernel/entry-common.c:472 [inline]
 el1_interrupt+0x38/0x6c arch/arm64/kernel/entry-common.c:486
 el1h_64_irq_handler+0x18/0x2c arch/arm64/kernel/entry-common.c:491
 el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:577
 folio_test_hugetlb include/linux/page-flags.h:831 [inline]
 folio_file_page include/linux/pagemap.h:683 [inline]
 filemap_map_pages+0x308/0x5e4 mm/filemap.c:3365
 do_fault_around mm/memory.c:4523 [inline]
 do_read_fault mm/memory.c:4549 [inline]
 do_fault mm/memory.c:4683 [inline]
 handle_pte_fault mm/memory.c:4955 [inline]
 __handle_mm_fault+0x938/0xeb0 mm/memory.c:5097
 handle_mm_fault+0xec/0x280 mm/memory.c:5218
 __do_page_fault arch/arm64/mm/fault.c:506 [inline]
 do_page_fault+0x17c/0x3d0 arch/arm64/mm/fault.c:606
 do_translation_fault+0xac/0xc0 arch/arm64/mm/fault.c:689
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:825
 el0_ia+0x5c/0x11c arch/arm64/kernel/entry-common.c:533
 el0t_64_sync_handler+0x78/0xc0 arch/arm64/kernel/entry-common.c:661
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:581
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff80007592d000
WARNING: CPU: 1 PID: 17778 at arch/arm64/mm/fault.c:369 __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
Modules linked in:
CPU: 1 PID: 17778 Comm: modprobe Tainted: G    B   W          6.1.0-rc5-syzkaller-00307-gfe24a97cf254 #0
Hardware name: linux,dummy-virt (DT)
pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
lr : __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
sp : ffff80000800bbc0
x29: ffff80000800bbc0 x28: f8ff000025d88fc0 x27: 0000000000000008
x26: ffff80000a29c008 x25: ffff80000a2a2cc0 x24: ffff80000a2c3388
x23: 00000000a04000c9 x22: 0000000000000025 x21: ffff80007592d000
x20: ffff80000800bc80 x19: 0000000097c18005 x18: 00000000fffffffe
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80000a2eda70 x13: 00000000000018de x12: 000000000000084a
x11: 2073736572646461 x10: ffff80000a39da70 x9 : 00000000ffffe000
x8 : ffff80000a2eda70 x7 : ffff80000a39da70 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f8ff000025d88fc0
Call trace:
 __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
 do_bad_area arch/arm64/mm/fault.c:473 [inline]
 do_translation_fault+0x50/0xc0 arch/arm64/mm/fault.c:691
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:825
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:576
 get_work_pool kernel/workqueue.c:741 [inline]
 __queue_work+0xf4/0x4a0 kernel/workqueue.c:1458
 queue_work_on+0x6c/0x90 kernel/workqueue.c:1545
 queue_work include/linux/workqueue.h:503 [inline]
 nci_cmd_timer+0x28/0x34 net/nfc/nci/core.c:615
 call_timer_fn.constprop.0+0x24/0x80 kernel/time/timer.c:1474
 expire_timers+0x98/0xc4 kernel/time/timer.c:1519
 __run_timers kernel/time/timer.c:1790 [inline]
 __run_timers kernel/time/timer.c:1763 [inline]
 run_timer_softirq+0xf4/0x254 kernel/time/timer.c:1803
 _stext+0x124/0x2a4
 ____do_softirq+0x10/0x20 arch/arm64/kernel/irq.c:79
 call_on_irq_stack+0x2c/0x5c arch/arm64/kernel/entry.S:889
 do_softirq_own_stack+0x1c/0x30 arch/arm64/kernel/irq.c:84
 invoke_softirq kernel/softirq.c:452 [inline]
 __irq_exit_rcu+0xcc/0xf4 kernel/softirq.c:650
 irq_exit_rcu+0x10/0x20 kernel/softirq.c:662
 __el1_irq arch/arm64/kernel/entry-common.c:472 [inline]
 el1_interrupt+0x38/0x6c arch/arm64/kernel/entry-common.c:486
 el1h_64_irq_handler+0x18/0x2c arch/arm64/kernel/entry-common.c:491
 el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:577
 folio_test_hugetlb include/linux/page-flags.h:831 [inline]
 folio_file_page include/linux/pagemap.h:683 [inline]
 filemap_map_pages+0x308/0x5e4 mm/filemap.c:3365
 do_fault_around mm/memory.c:4523 [inline]
 do_read_fault mm/memory.c:4549 [inline]
 do_fault mm/memory.c:4683 [inline]
 handle_pte_fault mm/memory.c:4955 [inline]
 __handle_mm_fault+0x938/0xeb0 mm/memory.c:5097
 handle_mm_fault+0xec/0x280 mm/memory.c:5218
 __do_page_fault arch/arm64/mm/fault.c:506 [inline]
 do_page_fault+0x17c/0x3d0 arch/arm64/mm/fault.c:606
 do_translation_fault+0xac/0xc0 arch/arm64/mm/fault.c:689
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:825
 el0_ia+0x5c/0x11c arch/arm64/kernel/entry-common.c:533
 el0t_64_sync_handler+0x78/0xc0 arch/arm64/kernel/entry-common.c:661
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:581
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff80007592d000
WARNING: CPU: 1 PID: 17778 at arch/arm64/mm/fault.c:369 __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
Modules linked in:
CPU: 1 PID: 17778 Comm: modprobe Tainted: G    B   W          6.1.0-rc5-syzkaller-00307-gfe24a97cf254 #0
Hardware name: linux,dummy-virt (DT)
pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
lr : __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
sp : ffff80000800bbc0
x29: ffff80000800bbc0 x28: f8ff000025d88fc0 x27: 0000000000000008
x26: ffff80000a29c008 x25: ffff80000a2a2cc0 x24: ffff80000a2c3388
x23: 00000000a04000c9 x22: 0000000000000025 x21: ffff80007592d000
x20: ffff80000800bc80 x19: 0000000097c18005 x18: 00000000fffffffe
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80000a2eda70 x13: 000000000000197a x12: 000000000000087e
x11: 2073736572646461 x10: ffff80000a39da70 x9 : 00000000ffffe000
x8 : ffff80000a2eda70 x7 : ffff80000a39da70 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f8ff000025d88fc0
Call trace:
 __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
 do_bad_area arch/arm64/mm/fault.c:473 [inline]
 do_translation_fault+0x50/0xc0 arch/arm64/mm/fault.c:691
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:825
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:576
 get_work_pool kernel/workqueue.c:741 [inline]
 __queue_work+0xf4/0x4a0 kernel/workqueue.c:1458
 queue_work_on+0x6c/0x90 kernel/workqueue.c:1545
 queue_work include/linux/workqueue.h:503 [inline]
 nci_cmd_timer+0x28/0x34 net/nfc/nci/core.c:615
 call_timer_fn.constprop.0+0x24/0x80 kernel/time/timer.c:1474
 expire_timers+0x98/0xc4 kernel/time/timer.c:1519
 __run_timers kernel/time/timer.c:1790 [inline]
 __run_timers kernel/time/timer.c:1763 [inline]
 run_timer_softirq+0xf4/0x254 kernel/time/timer.c:1803
 _stext+0x124/0x2a4
 ____do_softirq+0x10/0x20 arch/arm64/kernel/irq.c:79
 call_on_irq_stack+0x2c/0x5c arch/arm64/kernel/entry.S:889
 do_softirq_own_stack+0x1c/0x30 arch/arm64/kernel/irq.c:84
 invoke_softirq kernel/softirq.c:452 [inline]
 __irq_exit_rcu+0xcc/0xf4 kernel/softirq.c:650
 irq_exit_rcu+0x10/0x20 kernel/softirq.c:662
 __el1_irq arch/arm64/kernel/entry-common.c:472 [inline]
 el1_interrupt+0x38/0x6c arch/arm64/kernel/entry-common.c:486
 el1h_64_irq_handler+0x18/0x2c arch/arm64/kernel/entry-common.c:491
 el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:577
 folio_test_hugetlb include/linux/page-flags.h:831 [inline]
 folio_file_page include/linux/pagemap.h:683 [inline]
 filemap_map_pages+0x308/0x5e4 mm/filemap.c:3365
 do_fault_around mm/memory.c:4523 [inline]
 do_read_fault mm/memory.c:4549 [inline]
 do_fault mm/memory.c:4683 [inline]
 handle_pte_fault mm/memory.c:4955 [inline]
 __handle_mm_fault+0x938/0xeb0 mm/memory.c:5097
 handle_mm_fault+0xec/0x280 mm/memory.c:5218
 __do_page_fault arch/arm64/mm/fault.c:506 [inline]
 do_page_fault+0x17c/0x3d0 arch/arm64/mm/fault.c:606
 do_translation_fault+0xac/0xc0 arch/arm64/mm/fault.c:689
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:825
 el0_ia+0x5c/0x11c arch/arm64/kernel/entry-common.c:533
 el0t_64_sync_handler+0x78/0xc0 arch/arm64/kernel/entry-common.c:661
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:581
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff80007592d000
WARNING: CPU: 1 PID: 17778 at arch/arm64/mm/fault.c:369 __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
Modules linked in:
CPU: 1 PID: 17778 Comm: modprobe Tainted: G    B   W          6.1.0-rc5-syzkaller-00307-gfe24a97cf254 #0
Hardware name: linux,dummy-virt (DT)
pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
lr : __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
sp : ffff80000800bbc0
x29: ffff80000800bbc0 x28: f8ff000025d88fc0 x27: 0000000000000008
x26: ffff80000a29c008 x25: ffff80000a2a2cc0 x24: ffff80000a2c3388
x23: 00000000a04000c9 x22: 0000000000000025 x21: ffff80007592d000
x20: ffff80000800bc80 x19: 0000000097c18005 x18: 00000000fffffffe
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80000a2eda70 x13: 0000000000001a16 x12: 00000000000008b2
x11: 2073736572646461 x10: ffff80000a39da70 x9 : 00000000ffffe000
x8 : ffff80000a2eda70 x7 : ffff80000a39da70 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f8ff000025d88fc0
Call trace:
 __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
 do_bad_area arch/arm64/mm/fault.c:473 [inline]
 do_translation_fault+0x50/0xc0 arch/arm64/mm/fault.c:691
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:825
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:576
 get_work_pool kernel/workqueue.c:741 [inline]
 __queue_work+0xf4/0x4a0 kernel/workqueue.c:1458
 queue_work_on+0x6c/0x90 kernel/workqueue.c:1545
 queue_work include/linux/workqueue.h:503 [inline]
 nci_cmd_timer+0x28/0x34 net/nfc/nci/core.c:615
 call_timer_fn.constprop.0+0x24/0x80 kernel/time/timer.c:1474
 expire_timers+0x98/0xc4 kernel/time/timer.c:1519
 __run_timers kernel/time/timer.c:1790 [inline]
 __run_timers kernel/time/timer.c:1763 [inline]
 run_timer_softirq+0xf4/0x254 kernel/time/timer.c:1803
 _stext+0x124/0x2a4
 ____do_softirq+0x10/0x20 arch/arm64/kernel/irq.c:79
 call_on_irq_stack+0x2c/0x5c arch/arm64/kernel/entry.S:889
 do_softirq_own_stack+0x1c/0x30 arch/arm64/kernel/irq.c:84
 invoke_softirq kernel/softirq.c:452 [inline]
 __irq_exit_rcu+0xcc/0xf4 kernel/softirq.c:650
 irq_exit_rcu+0x10/0x20 kernel/softirq.c:662
 __el1_irq arch/arm64/kernel/entry-common.c:472 [inline]
 el1_interrupt+0x38/0x6c arch/arm64/kernel/entry-common.c:486
 el1h_64_irq_handler+0x18/0x2c arch/arm64/kernel/entry-common.c:491
 el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:577
 folio_test_hugetlb include/linux/page-flags.h:831 [inline]
 folio_file_page include/linux/pagemap.h:683 [inline]
 filemap_map_pages+0x308/0x5e4 mm/filemap.c:3365
 do_fault_around mm/memory.c:4523 [inline]
 do_read_fault mm/memory.c:4549 [inline]
 do_fault mm/memory.c:4683 [inline]
 handle_pte_fault mm/memory.c:4955 [inline]
 __handle_mm_fault+0x938/0xeb0 mm/memory.c:5097
 handle_mm_fault+0xec/0x280 mm/memory.c:5218
 __do_page_fault arch/arm64/mm/fault.c:506 [inline]
 do_page_fault+0x17c/0x3d0 arch/arm64/mm/fault.c:606
 do_translation_fault+0xac/0xc0 arch/arm64/mm/fault.c:689
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:825
 el0_ia+0x5c/0x11c arch/arm64/kernel/entry-common.c:533
 el0t_64_sync_handler+0x78/0xc0 arch/arm64/kernel/entry-common.c:661
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:581
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff80007592d000
WARNING: CPU: 1 PID: 17778 at arch/arm64/mm/fault.c:369 __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
Modules linked in:
CPU: 1 PID: 17778 Comm: modprobe Tainted: G    B   W          6.1.0-rc5-syzkaller-00307-gfe24a97cf254 #0
Hardware name: linux,dummy-virt (DT)
pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
lr : __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
sp : ffff80000800bbc0
x29: ffff80000800bbc0 x28: f8ff000025d88fc0 x27: 0000000000000008
x26: ffff80000a29c008 x25: ffff80000a2a2cc0 x24: ffff80000a2c3388
x23: 00000000a04000c9 x22: 0000000000000025 x21: ffff80007592d000
x20: ffff80000800bc80 x19: 0000000097c18005 x18: 00000000fffffffe
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80000a2eda70 x13: 0000000000001ab2 x12: 00000000000008e6
x11: 2073736572646461 x10: ffff80000a39da70 x9 : 00000000ffffe000
x8 : ffff80000a2eda70 x7 : ffff80000a39da70 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f8ff000025d88fc0
Call trace:
 __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
 do_bad_area arch/arm64/mm/fault.c:473 [inline]
 do_translation_fault+0x50/0xc0 arch/arm64/mm/fault.c:691
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:825
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:576
 get_work_pool kernel/workqueue.c:741 [inline]
 __queue_work+0xf4/0x4a0 kernel/workqueue.c:1458
 queue_work_on+0x6c/0x90 kernel/workqueue.c:1545
 queue_work include/linux/workqueue.h:503 [inline]
 nci_cmd_timer+0x28/0x34 net/nfc/nci/core.c:615
 call_timer_fn.constprop.0+0x24/0x80 kernel/time/timer.c:1474
 expire_timers+0x98/0xc4 kernel/time/timer.c:1519
 __run_timers kernel/time/timer.c:1790 [inline]
 __run_timers kernel/time/timer.c:1763 [inline]
 run_timer_softirq+0xf4/0x254 kernel/time/timer.c:1803
 _stext+0x124/0x2a4
 ____do_softirq+0x10/0x20 arch/arm64/kernel/irq.c:79
 call_on_irq_stack+0x2c/0x5c arch/arm64/kernel/entry.S:889
 do_softirq_own_stack+0x1c/0x30 arch/arm64/kernel/irq.c:84
 invoke_softirq kernel/softirq.c:452 [inline]
 __irq_exit_rcu+0xcc/0xf4 kernel/softirq.c:650
 irq_exit_rcu+0x10/0x20 kernel/softirq.c:662
 __el1_irq arch/arm64/kernel/entry-common.c:472 [inline]
 el1_interrupt+0x38/0x6c arch/arm64/kernel/entry-common.c:486
 el1h_64_irq_handler+0x18/0x2c arch/arm64/kernel/entry-common.c:491
 el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:577
 folio_test_hugetlb include/linux/page-flags.h:831 [inline]
 folio_file_page include/linux/pagemap.h:683 [inline]
 filemap_map_pages+0x308/0x5e4 mm/filemap.c:3365
 do_fault_around mm/memory.c:4523 [inline]
 do_read_fault mm/memory.c:4549 [inline]
 do_fault mm/memory.c:4683 [inline]
 handle_pte_fault mm/memory.c:4955 [inline]
 __handle_mm_fault+0x938/0xeb0 mm/memory.c:5097
 handle_mm_fault+0xec/0x280 mm/memory.c:5218
 __do_page_fault arch/arm64/mm/fault.c:506 [inline]
 do_page_fault+0x17c/0x3d0 arch/arm64/mm/fault.c:606
 do_translation_fault+0xac/0xc0 arch/arm64/mm/fault.c:689
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:825
 el0_ia+0x5c/0x11c arch/arm64/kernel/entry-common.c:533
 el0t_64_sync_handler+0x78/0xc0 arch/arm64/kernel/entry-common.c:661
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:581
---[ end trace 0000000000000000 ]---
__do_kernel_fault: 74526 callbacks suppressed
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff80007592d000
WARNING: CPU: 1 PID: 17778 at arch/arm64/mm/fault.c:369 __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
Modules linked in:
CPU: 1 PID: 17778 Comm: modprobe Tainted: G    B   W          6.1.0-rc5-syzkaller-00307-gfe24a97cf254 #0
Hardware name: linux,dummy-virt (DT)
pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
lr : __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
sp : ffff80000800bbc0
x29: ffff80000800bbc0 x28: f8ff000025d88fc0 x27: 0000000000000008
x26: ffff80000a29c008 x25: ffff80000a2a2cc0 x24: ffff80000a2c3388
x23: 00000000a04000c9 x22: 0000000000000025 x21: ffff80007592d000
x20: ffff80000800bc80 x19: 0000000097c18005 x18: 00000000fffffffe
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80000a2eda70 x13: 0000000000001b51 x12: 000000000000091b
x11: 2073736572646461 x10: ffff80000a39da70 x9 : 00000000ffffe000
x8 : ffff80000a2eda70 x7 : ffff80000a39da70 x6 : 0000000000000000
x5 : ffff00007fbcba10 x4 : 0000000000000000 x3 : ffff80007592d000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f8ff000025d88fc0
Call trace:
 __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
 do_bad_area arch/arm64/mm/fault.c:473 [inline]
 do_translation_fault+0x50/0xc0 arch/arm64/mm/fault.c:691
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:825
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:576
 get_work_pool kernel/workqueue.c:741 [inline]
 __queue_work+0xf4/0x4a0 kernel/workqueue.c:1458
 queue_work_on+0x6c/0x90 kernel/workqueue.c:1545
 queue_work include/linux/workqueue.h:503 [inline]
 nci_cmd_timer+0x28/0x34 net/nfc/nci/core.c:615
 call_timer_fn.constprop.0+0x24/0x80 kernel/time/timer.c:1474
 expire_timers+0x98/0xc4 kernel/time/timer.c:1519
 __run_timers kernel/time/timer.c:1790 [inline]
 __run_timers kernel/time/timer.c:1763 [inline]
 run_timer_softirq+0xf4/0x254 kernel/time/timer.c:1803
 _stext+0x124/0x2a4
 ____do_softirq+0x10/0x20 arch/arm64/kernel/irq.c:79
 call_on_irq_stack+0x2c/0x5c arch/arm64/kernel/entry.S:889
 do_softirq_own_stack+0x1c/0x30 arch/arm64/kernel/irq.c:84
 invoke_softirq kernel/softirq.c:452 [inline]
 __irq_exit_rcu+0xcc/0xf4 kernel/softirq.c:650
 irq_exit_rcu+0x10/0x20 kernel/softirq.c:662
 __el1_irq arch/arm64/kernel/entry-common.c:472 [inline]
 el1_interrupt+0x38/0x6c arch/arm64/kernel/entry-common.c:486
 el1h_64_irq_handler+0x18/0x2c arch/arm64/kernel/entry-common.c:491
 el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:577
 folio_test_hugetlb include/linux/page-flags.h:831 [inline]
 folio_file_page include/linux/pagemap.h:683 [inline]
 filemap_map_pages+0x308/0x5e4 mm/filemap.c:3365
 do_fault_around mm/memory.c:4523 [inline]
 do_read_fault mm/memory.c:4549 [inline]
 do_fault mm/memory.c:4683 [inline]
 handle_pte_fault mm/memory.c:4955 [inline]
 __handle_mm_fault+0x938/0xeb0 mm/memory.c:5097
 handle_mm_fault+0xec/0x280 mm/memory.c:5218
 __do_page_fault arch/arm64/mm/fault.c:506 [inline]
 do_page_fault+0x17c/0x3d0 arch/arm64/mm/fault.c:606
 do_translation_fault+0xac/0xc0 arch/arm64/mm/fault.c:689
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:825
 el0_ia+0x5c/0x11c arch/arm64/kernel/entry-common.c:533
 el0t_64_sync_handler+0x78/0xc0 arch/arm64/kernel/entry-common.c:661
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:581
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff80007592d000
WARNING: CPU: 1 PID: 17778 at arch/arm64/mm/fault.c:369 __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
Modules linked in:
CPU: 1 PID: 17778 Comm: modprobe Tainted: G    B   W          6.1.0-rc5-syzkaller-00307-gfe24a97cf254 #0
Hardware name: linux,dummy-virt (DT)
pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
lr : __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
sp : ffff80000800bbc0
x29: ffff80000800bbc0 x28: f8ff000025d88fc0 x27: 0000000000000008
x26: ffff80000a29c008 x25: ffff80000a2a2cc0 x24: ffff80000a2c3388
x23: 00000000a04000c9 x22: 0000000000000025 x21: ffff80007592d000
x20: ffff80000800bc80 x19: 0000000097c18005 x18: 00000000fffffffe
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80000a2eda70 x13: 0000000000001bed x12: 000000000000094f
x11: 2073736572646461 x10: ffff80000a39da70 x9 : 00000000ffffe000
x8 : ffff80000a2eda70 x7 : ffff80000a39da70 x6 : 0000000000000000
x5 : ffff00007fbcba10 x4 : 0000000000000000 x3 : ffff80007592d000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f8ff000025d88fc0
Call trace:
 __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
 do_bad_area arch/arm64/mm/fault.c:473 [inline]
 do_translation_fault+0x50/0xc0 arch/arm64/mm/fault.c:691
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:825
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:576
 get_work_pool kernel/workqueue.c:741 [inline]
 __queue_work+0xf4/0x4a0 kernel/workqueue.c:1458
 queue_work_on+0x6c/0x90 kernel/workqueue.c:1545
 queue_work include/linux/workqueue.h:503 [inline]
 nci_cmd_timer+0x28/0x34 net/nfc/nci/core.c:615
 call_timer_fn.constprop.0+0x24/0x80 kernel/time/timer.c:1474
 expire_timers+0x98/0xc4 kernel/time/timer.c:1519
 __run_timers kernel/time/timer.c:1790 [inline]
 __run_timers kernel/time/timer.c:1763 [inline]
 run_timer_softirq+0xf4/0x254 kernel/time/timer.c:1803
 _stext+0x124/0x2a4
 ____do_softirq+0x10/0x20 arch/arm64/kernel/irq.c:79
 call_on_irq_stack+0x2c/0x5c arch/arm64/kernel/entry.S:889
 do_softirq_own_stack+0x1c/0x30 arch/arm64/kernel/irq.c:84
 invoke_softirq kernel/softirq.c:452 [inline]
 __irq_exit_rcu+0xcc/0xf4 kernel/softirq.c:650
 irq_exit_rcu+0x10/0x20 kernel/softirq.c:662
 __el1_irq arch/arm64/kernel/entry-common.c:472 [inline]
 el1_interrupt+0x38/0x6c arch/arm64/kernel/entry-common.c:486
 el1h_64_irq_handler+0x18/0x2c arch/arm64/kernel/entry-common.c:491
 el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:577
 folio_test_hugetlb include/linux/page-flags.h:831 [inline]
 folio_file_page include/linux/pagemap.h:683 [inline]
 filemap_map_pages+0x308/0x5e4 mm/filemap.c:3365
 do_fault_around mm/memory.c:4523 [inline]
 do_read_fault mm/memory.c:4549 [inline]
 do_fault mm/memory.c:4683 [inline]
 handle_pte_fault mm/memory.c:4955 [inline]
 __handle_mm_fault+0x938/0xeb0 mm/memory.c:5097
 handle_mm_fault+0xec/0x280 mm/memory.c:5218
 __do_page_fault arch/arm64/mm/fault.c:506 [inline]
 do_page_fault+0x17c/0x3d0 arch/arm64/mm/fault.c:606
 do_translation_fault+0xac/0xc0 arch/arm64/mm/fault.c:689
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:825
 el0_ia+0x5c/0x11c arch/arm64/kernel/entry-common.c:533
 el0t_64_sync_handler+0x78/0xc0 arch/arm64/kernel/entry-common.c:661
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:581
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff80007592d000
WARNING: CPU: 1 PID: 17778 at arch/arm64/mm/fault.c:369 __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
Modules linked in:
CPU: 1 PID: 17778 Comm: modprobe Tainted: G    B   W          6.1.0-rc5-syzkaller-00307-gfe24a97cf254 #0
Hardware name: linux,dummy-virt (DT)
pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
lr : __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
sp : ffff80000800bbc0
x29: ffff80000800bbc0 x28: f8ff000025d88fc0 x27: 0000000000000008
x26: ffff80000a29c008 x25: ffff80000a2a2cc0 x24: ffff80000a2c3388
x23: 00000000a04000c9 x22: 0000000000000025 x21: ffff80007592d000
x20: ffff80000800bc80 x19: 0000000097c18005 x18: 00000000fffffffe
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80000a2eda70 x13: 0000000000001c89 x12: 0000000000000983
x11: 2073736572646461 x10: ffff80000a39da70 x9 : 00000000ffffe000
x8 : ffff80000a2eda70 x7 : ffff80000a39da70 x6 : 0000000000000000
x5 : ffff00007fbcba10 x4 : 0000000000000000 x3 : ffff80007592d000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f8ff000025d88fc0
Call trace:
 __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
 do_bad_area arch/arm64/mm/fault.c:473 [inline]
 do_translation_fault+0x50/0xc0 arch/arm64/mm/fault.c:691
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:825
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:576
 get_work_pool kernel/workqueue.c:741 [inline]
 __queue_work+0xf4/0x4a0 kernel/workqueue.c:1458
 queue_work_on+0x6c/0x90 kernel/workqueue.c:1545
 queue_work include/linux/workqueue.h:503 [inline]
 nci_cmd_timer+0x28/0x34 net/nfc/nci/core.c:615
 call_timer_fn.constprop.0+0x24/0x80 kernel/time/timer.c:1474
 expire_timers+0x98/0xc4 kernel/time/timer.c:1519
 __run_timers kernel/time/timer.c:1790 [inline]
 __run_timers kernel/time/timer.c:1763 [inline]
 run_timer_softirq+0xf4/0x254 kernel/time/timer.c:1803
 _stext+0x124/0x2a4
 ____do_softirq+0x10/0x20 arch/arm64/kernel/irq.c:79
 call_on_irq_stack+0x2c/0x5c arch/arm64/kernel/entry.S:889
 do_softirq_own_stack+0x1c/0x30 arch/arm64/kernel/irq.c:84
 invoke_softirq kernel/softirq.c:452 [inline]
 __irq_exit_rcu+0xcc/0xf4 kernel/softirq.c:650
 irq_exit_rcu+0x10/0x20 kernel/softirq.c:662
 __el1_irq arch/arm64/kernel/entry-common.c:472 [inline]
 el1_interrupt+0x38/0x6c arch/arm64/kernel/entry-common.c:486
 el1h_64_irq_handler+0x18/0x2c arch/arm64/kernel/entry-common.c:491
 el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:577
 folio_test_hugetlb include/linux/page-flags.h:831 [inline]
 folio_file_page include/linux/pagemap.h:683 [inline]
 filemap_map_pages+0x308/0x5e4 mm/filemap.c:3365
 do_fault_around mm/memory.c:4523 [inline]
 do_read_fault mm/memory.c:4549 [inline]
 do_fault mm/memory.c:4683 [inline]
 handle_pte_fault mm/memory.c:4955 [inline]
 __handle_mm_fault+0x938/0xeb0 mm/memory.c:5097
 handle_mm_fault+0xec/0x280 mm/memory.c:5218
 __do_page_fault arch/arm64/mm/fault.c:506 [inline]
 do_page_fault+0x17c/0x3d0 arch/arm64/mm/fault.c:606
 do_translation_fault+0xac/0xc0 arch/arm64/mm/fault.c:689
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:825
 el0_ia+0x5c/0x11c arch/arm64/kernel/entry-common.c:533
 el0t_64_sync_handler+0x78/0xc0 arch/arm64/kernel/entry-common.c:661
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:581
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff80007592d000
WARNING: CPU: 1 PID: 17778 at arch/arm64/mm/fault.c:369 __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
Modules linked in:
CPU: 1 PID: 17778 Comm: modprobe Tainted: G    B   W          6.1.0-rc5-syzkaller-00307-gfe24a97cf254 #0
Hardware name: linux,dummy-virt (DT)
pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
lr : __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
sp : ffff80000800bbc0
x29: ffff80000800bbc0 x28: f8ff000025d88fc0 x27: 0000000000000008
x26: ffff80000a29c008 x25: ffff80000a2a2cc0 x24: ffff80000a2c3388
x23: 00000000a04000c9 x22: 0000000000000025 x21: ffff80007592d000
x20: ffff80000800bc80 x19: 0000000097c18005 x18: 00000000fffffffe
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80000a2eda70 x13: 0000000000001d25 x12: 00000000000009b7
x11: 2073736572646461 x10: ffff80000a39da70 x9 : 00000000ffffe000
x8 : ffff80000a2eda70 x7 : ffff80000a39da70 x6 : 0000000000000000
x5 : ffff00007fbcba10 x4 : 0000000000000000 x3 : ffff80007592d000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f8ff000025d88fc0
Call trace:
 __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
 do_bad_area arch/arm64/mm/fault.c:473 [inline]
 do_translation_fault+0x50/0xc0 arch/arm64/mm/fault.c:691
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:825
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:576
 get_work_pool kernel/workqueue.c:741 [inline]
 __queue_work+0xf4/0x4a0 kernel/workqueue.c:1458
 queue_work_on+0x6c/0x90 kernel/workqueue.c:1545
 queue_work include/linux/workqueue.h:503 [inline]
 nci_cmd_timer+0x28/0x34 net/nfc/nci/core.c:615
 call_timer_fn.constprop.0+0x24/0x80 kernel/time/timer.c:1474
 expire_timers+0x98/0xc4 kernel/time/timer.c:1519
 __run_timers kernel/time/timer.c:1790 [inline]
 __run_timers kernel/time/timer.c:1763 [inline]
 run_timer_softirq+0xf4/0x254 kernel/time/timer.c:1803
 _stext+0x124/0x2a4
 ____do_softirq+0x10/0x20 arch/arm64/kernel/irq.c:79
 call_on_irq_stack+0x2c/0x5c arch/arm64/kernel/entry.S:889
 do_softirq_own_stack+0x1c/0x30 arch/arm64/kernel/irq.c:84
 invoke_softirq kernel/softirq.c:452 [inline]
 __irq_exit_rcu+0xcc/0xf4 kernel/softirq.c:650
 irq_exit_rcu+0x10/0x20 kernel/softirq.c:662
 __el1_irq arch/arm64/kernel/entry-common.c:472 [inline]
 el1_interrupt+0x38/0x6c arch/arm64/kernel/entry-common.c:486
 el1h_64_irq_handler+0x18/0x2c arch/arm64/kernel/entry-common.c:491
 el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:577
 folio_test_hugetlb include/linux/page-flags.h:831 [inline]
 folio_file_page include/linux/pagemap.h:683 [inline]
 filemap_map_pages+0x308/0x5e4 mm/filemap.c:3365
 do_fault_around mm/memory.c:4523 [inline]
 do_read_fault mm/memory.c:4549 [inline]
 do_fault mm/memory.c:4683 [inline]
 handle_pte_fault mm/memory.c:4955 [inline]
 __handle_mm_fault+0x938/0xeb0 mm/memory.c:5097
 handle_mm_fault+0xec/0x280 mm/memory.c:5218
 __do_page_fault arch/arm64/mm/fault.c:506 [inline]
 do_page_fault+0x17c/0x3d0 arch/arm64/mm/fault.c:606
 do_translation_fault+0xac/0xc0 arch/arm64/mm/fault.c:689
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:825
 el0_ia+0x5c/0x11c arch/arm64/kernel/entry-common.c:533
 el0t_64_sync_handler+0x78/0xc0 arch/arm64/kernel/entry-common.c:661
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:581
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff80007592d000
WARNING: CPU: 1 PID: 17778 at arch/arm64/mm/fault.c:369 __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
Modules linked in:
CPU: 1 PID: 17778 Comm: modprobe Tainted: G    B   W          6.1.0-rc5-syzkaller-00307-gfe24a97cf254 #0
Hardware name: linux,dummy-virt (DT)
pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
lr : __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
sp : ffff80000800bbc0
x29: ffff80000800bbc0 x28: f8ff000025d88fc0 x27: 0000000000000008
x26: ffff80000a29c008 x25: ffff80000a2a2cc0 x24: ffff80000a2c3388
x23: 00000000a04000c9 x22: 0000000000000025 x21: ffff80007592d000
x20: ffff80000800bc80 x19: 0000000097c18005 x18: 00000000fffffffe
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80000a2eda70 x13: 0000000000001dc1 x12: 00000000000009eb
x11: 2073736572646461 x10: ffff80000a39da70 x9 : 00000000ffffe000
x8 : ffff80000a2eda70 x7 : ffff80000a39da70 x6 : 0000000000000000
x5 : ffff00007fbcba10 x4 : 0000000000000000 x3 : ffff80007592d000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f8ff000025d88fc0
Call trace:
 __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
 do_bad_area arch/arm64/mm/fault.c:473 [inline]
 do_translation_fault+0x50/0xc0 arch/arm64/mm/fault.c:691
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:825
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:576
 get_work_pool kernel/workqueue.c:741 [inline]
 __queue_work+0xf4/0x4a0 kernel/workqueue.c:1458
 queue_work_on+0x6c/0x90 kernel/workqueue.c:1545
 queue_work include/linux/workqueue.h:503 [inline]
 nci_cmd_timer+0x28/0x34 net/nfc/nci/core.c:615
 call_timer_fn.constprop.0+0x24/0x80 kernel/time/timer.c:1474
 expire_timers+0x98/0xc4 kernel/time/timer.c:1519
 __run_timers kernel/time/timer.c:1790 [inline]
 __run_timers kernel/time/timer.c:1763 [inline]
 run_timer_softirq+0xf4/0x254 kernel/time/timer.c:1803
 _stext+0x124/0x2a4
 ____do_softirq+0x10/0x20 arch/arm64/kernel/irq.c:79
 call_on_irq_stack+0x2c/0x5c arch/arm64/kernel/entry.S:889
 do_softirq_own_stack+0x1c/0x30 arch/arm64/kernel/irq.c:84
 invoke_softirq kernel/softirq.c:452 [inline]
 __irq_exit_rcu+0xcc/0xf4 kernel/softirq.c:650
 irq_exit_rcu+0x10/0x20 kernel/softirq.c:662
 __el1_irq arch/arm64/kernel/entry-common.c:472 [inline]
 el1_interrupt+0x38/0x6c arch/arm64/kernel/entry-common.c:486
 el1h_64_irq_handler+0x18/0x2c arch/arm64/kernel/entry-common.c:491
 el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:577
 folio_test_hugetlb include/linux/page-flags.h:831 [inline]
 folio_file_page include/linux/pagemap.h:683 [inline]
 filemap_map_pages+0x308/0x5e4 mm/filemap.c:3365
 do_fault_around mm/memory.c:4523 [inline]
 do_read_fault mm/memory.c:4549 [inline]
 do_fault mm/memory.c:4683 [inline]
 handle_pte_fault mm/memory.c:4955 [inline]
 __handle_mm_fault+0x938/0xeb0 mm/memory.c:5097
 handle_mm_fault+0xec/0x280 mm/memory.c:5218
 __do_page_fault arch/arm64/mm/fault.c:506 [inline]
 do_page_fault+0x17c/0x3d0 arch/arm64/mm/fault.c:606
 do_translation_fault+0xac/0xc0 arch/arm64/mm/fault.c:689
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:825
 el0_ia+0x5c/0x11c arch/arm64/kernel/entry-common.c:533
 el0t_64_sync_handler+0x78/0xc0 arch/arm64/kernel/entry-common.c:661
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:581
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff80007592d000
WARNING: CPU: 1 PID: 17778 at arch/arm64/mm/fault.c:369 __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
Modules linked in:
CPU: 1 PID: 17778 Comm: modprobe Tainted: G    B   W          6.1.0-rc5-syzkaller-00307-gfe24a97cf254 #0
Hardware name: linux,dummy-virt (DT)
pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
lr : __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
sp : ffff80000800bbc0
x29: ffff80000800bbc0 x28: f8ff000025d88fc0 x27: 0000000000000008
x26: ffff80000a29c008 x25: ffff80000a2a2cc0 x24: ffff80000a2c3388
x23: 00000000a04000c9 x22: 0000000000000025 x21: ffff80007592d000
x20: ffff80000800bc80 x19: 0000000097c18005 x18: 00000000fffffffe
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80000a2eda70 x13: 0000000000001e5d x12: 0000000000000a1f
x11: 2073736572646461 x10: ffff80000a39da70 x9 : 00000000ffffe000
x8 : ffff80000a2eda70 x7 : ffff80000a39da70 x6 : 0000000000000000
x5 : ffff00007fbcba10 x4 : 0000000000000000 x3 : ffff80007592d000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f8ff000025d88fc0
Call trace:
 __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
 do_bad_area arch/arm64/mm/fault.c:473 [inline]
 do_translation_fault+0x50/0xc0 arch/arm64/mm/fault.c:691
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:825
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:576
 get_work_pool kernel/workqueue.c:741 [inline]
 __queue_work+0xf4/0x4a0 kernel/workqueue.c:1458
 queue_work_on+0x6c/0x90 kernel/workqueue.c:1545
 queue_work include/linux/workqueue.h:503 [inline]
 nci_cmd_timer+0x28/0x34 net/nfc/nci/core.c:615
 call_timer_fn.constprop.0+0x24/0x80 kernel/time/timer.c:1474
 expire_timers+0x98/0xc4 kernel/time/timer.c:1519
 __run_timers kernel/time/timer.c:1790 [inline]
 __run_timers kernel/time/timer.c:1763 [inline]
 run_timer_softirq+0xf4/0x254 kernel/time/timer.c:1803
 _stext+0x124/0x2a4
 ____do_softirq+0x10/0x20 arch/arm64/kernel/irq.c:79
 call_on_irq_stack+0x2c/0x5c arch/arm64/kernel/entry.S:889
 do_softirq_own_stack+0x1c/0x30 arch/arm64/kernel/irq.c:84
 invoke_softirq kernel/softirq.c:452 [inline]
 __irq_exit_rcu+0xcc/0xf4 kernel/softirq.c:650
 irq_exit_rcu+0x10/0x20 kernel/softirq.c:662
 __el1_irq arch/arm64/kernel/entry-common.c:472 [inline]
 el1_interrupt+0x38/0x6c arch/arm64/kernel/entry-common.c:486
 el1h_64_irq_handler+0x18/0x2c arch/arm64/kernel/entry-common.c:491
 el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:577
 folio_test_hugetlb include/linux/page-flags.h:831 [inline]
 folio_file_page include/linux/pagemap.h:683 [inline]
 filemap_map_pages+0x308/0x5e4 mm/filemap.c:3365
 do_fault_around mm/memory.c:4523 [inline]
 do_read_fault mm/memory.c:4549 [inline]
 do_fault mm/memory.c:4683 [inline]
 handle_pte_fault mm/memory.c:4955 [inline]
 __handle_mm_fault+0x938/0xeb0 mm/memory.c:5097
 handle_mm_fault+0xec/0x280 mm/memory.c:5218
 __do_page_fault arch/arm64/mm/fault.c:506 [inline]
 do_page_fault+0x17c/0x3d0 arch/arm64/mm/fault.c:606
 do_translation_fault+0xac/0xc0 arch/arm64/mm/fault.c:689
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:825
 el0_ia+0x5c/0x11c arch/arm64/kernel/entry-common.c:533
 el0t_64_sync_handler+0x78/0xc0 arch/arm64/kernel/entry-common.c:661
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:581
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff80007592d000
WARNING: CPU: 1 PID: 17778 at arch/arm64/mm/fault.c:369 __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
Modules linked in:
CPU: 1 PID: 17778 Comm: modprobe Tainted: G    B   W          6.1.0-rc5-syzkaller-00307-gfe24a97cf254 #0
Hardware name: linux,dummy-virt (DT)
pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
lr : __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
sp : ffff80000800bbc0
x29: ffff80000800bbc0 x28: f8ff000025d88fc0 x27: 0000000000000008
x26: ffff80000a29c008 x25: ffff80000a2a2cc0 x24: ffff80000a2c3388
x23: 00000000a04000c9 x22: 0000000000000025 x21: ffff80007592d000
x20: ffff80000800bc80 x19: 0000000097c18005 x18: 00000000fffffffe
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80000a2eda70 x13: 0000000000001ef9 x12: 0000000000000a53
x11: 2073736572646461 x10: ffff80000a39da70 x9 : 00000000ffffe000
x8 : ffff80000a2eda70 x7 : ffff80000a39da70 x6 : 0000000000000000
x5 : ffff00007fbcba10 x4 : 0000000000000000 x3 : ffff80007592d000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f8ff000025d88fc0
Call trace:
 __do_kernel_fault+0x1ac/0x1e0 arch/arm64/mm/fault.c:369
 do_bad_area arch/arm64/mm/fault.c:473 [inline]
 do_translation_fault+0x50/0xc0 arch/arm64/mm/fault.c:691
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:825
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:576
 get_work_pool kernel/workqueue.c:741 [inline]
 __queue_work+0xf4/0x4a0 kernel/workqueue.c:1458
 queue_work_on+0x6c/0x90 kernel/workqueue.c:1545
 queue_work include/linux/workqueue.h:503 [inline]
 nci_cmd_timer+0x28/0x34 net/nfc/nci/core.c:615
 call_timer_fn.constprop.0+0x24/0x80 kernel/time/timer.c:1474
 expire_timers+0x98/0xc4 kernel/time/timer.c:1519
 __run_timers kernel/time/timer.c:1790 [inline]
 __run_timers kernel/time/timer.c:1763 [inline]
 run_timer_softirq+0xf4/0x254 kernel/time/timer.c:1803
 _stext+0x124/0x2a4
 ____do_softirq+0x10/0x20 arch/arm64/kernel/irq.c:79
 call_on_irq_stack+0x2c/0x5c arch/arm64/kernel/entry.S:889
 do_softirq_own_stack+0x1c/0x30 arch/arm64/kernel/irq.c:84
 invoke_softirq kernel/softirq.c:452 [inline]
 __irq_exit_rcu+0xcc/0xf4 kernel/softirq.c:650
 irq_exit_rcu+0x10/0x20 kernel/softirq.c:662
 __el1_irq arch/arm64/kernel/entry-common.c:472 [inline]
 el1_interrupt+0x38/0x6c arch/arm64/kernel/entry-common.c:486
 el1h_64_irq_handler+0x18/0x2c arch/arm64/kernel/entry-common.c:491
 el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:577
 folio_test_hugetlb include/linux/page-flags.h:831 [inline]
 folio_file_page include/linux/pagem

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
