Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166E8650A42
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 11:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiLSKkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 05:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiLSKkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 05:40:21 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B39665E6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 02:40:20 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id o16-20020a056602225000b006e032e361ccso3889459ioo.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 02:40:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=stcJoNXp4doLwbzXd/6+RorKvTfar5c2gKfBs65+OwI=;
        b=j2kG9JdRytz2iZaRgpeOezHa3TuI/qoc9CmcorsIgLayPmncKVM01bY9DO6G3M7ZJk
         NsbsTN/B6Q48A5mFX3AEz30+eciJKIkL3NLJCkY6/UEVqJbZZEDXkDYffiIkXYqkXieN
         RE/gjv534r6rkMijY94UKlUpXXNvyZ+t+CbZWjIJqKJJQxZO4cbpgWRYfqk/lgjPSfHW
         WxE/5gYcZWXsMXBP+v4BfuCcpGCJonyMAe96Y3UZlE2EzUK0nbjey5jveQ007PbtA+fj
         JSs2FbHZ2gOwk7GqkO679+T4ZpKSR5igG4Sjy/rVAB/JCFYu/FIrCozxXg/5s27hfm5l
         Nnag==
X-Gm-Message-State: ANoB5pm0hdyH3EA60N6+A7uCUE0GhOysO0pJsVFoDf+lVUI2XhIypWqi
        J4klHTBG/yGz0CQBuqywgg/6RGAqeoUb3yAVJFRkqRGN3b/x
X-Google-Smtp-Source: AA0mqf6l39XRCxM5VzPUKB0r5z5e/IUgGkGhLtt2ry/C7/k02cyGYAE77mW3+ooKoRdw7yKEIPkRR6UQMpmjXeKdroJKoYply5cG
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2196:b0:304:b36f:8091 with SMTP id
 j22-20020a056e02219600b00304b36f8091mr2884147ila.46.1671446419525; Mon, 19
 Dec 2022 02:40:19 -0800 (PST)
Date:   Mon, 19 Dec 2022 02:40:19 -0800
In-Reply-To: <20221219100606.1438-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000018d85c05f02bf2e7@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in put_pmu_ctx
From:   syzbot <syzbot+b8e8c01c8ade4fe6e48f@syzkaller.appspotmail.com>
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
KASAN: use-after-free Read in __perf_event_task_sched_in

==================================================================
BUG: KASAN: use-after-free in __lock_acquire+0x3ee7/0x56d0 kernel/locking/lockdep.c:4925
Read of size 8 at addr ffff888070350018 by task syz-executor.0/5763

CPU: 0 PID: 5763 Comm: syz-executor.0 Not tainted 6.1.0-syzkaller-13139-gf9ff5644bcc0-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:306 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:417
 kasan_report+0xbf/0x1f0 mm/kasan/report.c:517
 __lock_acquire+0x3ee7/0x56d0 kernel/locking/lockdep.c:4925
 lock_acquire kernel/locking/lockdep.c:5668 [inline]
 lock_acquire+0x1e3/0x630 kernel/locking/lockdep.c:5633
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 perf_ctx_lock kernel/events/core.c:163 [inline]
 perf_event_context_sched_in kernel/events/core.c:3925 [inline]
 __perf_event_task_sched_in+0x19c/0x6c0 kernel/events/core.c:3976
 perf_event_task_sched_in include/linux/perf_event.h:1328 [inline]
 finish_task_switch.isra.0+0x5e5/0xc80 kernel/sched/core.c:5118
 context_switch kernel/sched/core.c:5247 [inline]
 __schedule+0xb92/0x5450 kernel/sched/core.c:6555
 schedule+0xde/0x1b0 kernel/sched/core.c:6631
 do_nanosleep+0x154/0x4f0 kernel/time/hrtimer.c:2044
 hrtimer_nanosleep+0x1fd/0x4b0 kernel/time/hrtimer.c:2097
 common_nsleep+0xa6/0xd0 kernel/time/posix-timers.c:1236
 __do_sys_clock_nanosleep kernel/time/posix-timers.c:1276 [inline]
 __se_sys_clock_nanosleep kernel/time/posix-timers.c:1254 [inline]
 __x64_sys_clock_nanosleep+0x2f8/0x430 kernel/time/posix-timers.c:1254
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f6101eb0e01
Code: 24 0c 89 3c 24 48 89 4c 24 18 e8 aa e7 ff ff 4c 8b 54 24 18 48 8b 54 24 10 41 89 c0 8b 74 24 0c 8b 3c 24 b8 e6 00 00 00 0f 05 <44> 89 c7 48 89 04 24 e8 e3 e7 ff ff 48 8b 04 24 eb 97 66 2e 0f 1f
RSP: 002b:00007f6102cc20b0 EFLAGS: 00000293 ORIG_RAX: 00000000000000e6
RAX: ffffffffffffffda RBX: 00007f6101fabf80 RCX: 00007f6101eb0e01
RDX: 00007f6102cc20f0 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007f6101ee7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 00007fffb7c30faf R14: 00007f6102cc2300 R15: 0000000000022000
 </TASK>

Allocated by task 5762:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:371 [inline]
 ____kasan_kmalloc mm/kasan/common.c:330 [inline]
 __kasan_kmalloc+0xa5/0xb0 mm/kasan/common.c:380
 kmalloc include/linux/slab.h:580 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 alloc_perf_context kernel/events/core.c:4693 [inline]
 find_get_context+0xcc/0x810 kernel/events/core.c:4763
 __do_sys_perf_event_open+0x963/0x2980 kernel/events/core.c:12478
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 5759:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2e/0x40 mm/kasan/generic.c:518
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x160/0x1c0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:177 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1807
 slab_free mm/slub.c:3787 [inline]
 __kmem_cache_free+0xaf/0x3b0 mm/slub.c:3800
 rcu_do_batch kernel/rcu/tree.c:2244 [inline]
 rcu_core+0x81f/0x1980 kernel/rcu/tree.c:2504
 __do_softirq+0x1fb/0xadc kernel/softirq.c:571

Last potentially related work creation:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:488
 __call_rcu_common.constprop.0+0x99/0x820 kernel/rcu/tree.c:2753
 put_ctx kernel/events/core.c:1180 [inline]
 put_ctx+0x116/0x1e0 kernel/events/core.c:1173
 put_pmu_ctx kernel/events/core.c:4918 [inline]
 put_pmu_ctx+0x1db/0x390 kernel/events/core.c:4894
 _free_event+0x3c5/0x13d0 kernel/events/core.c:5198
 free_event+0x58/0xc0 kernel/events/core.c:5226
 __do_sys_perf_event_open+0x66d/0x2980 kernel/events/core.c:12703
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888070350000
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 24 bytes inside of
 512-byte region [ffff888070350000, ffff888070350200)

The buggy address belongs to the physical page:
page:ffffea0001c0d400 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x70350
head:ffffea0001c0d400 order:2 compound_mapcount:0 subpages_mapcount:0 compound_pincount:0
anon flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffff888012041c80 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 5565, tgid 5565 (syz-executor.1), ts 81058806266, free_ts 76174174820
 prep_new_page mm/page_alloc.c:2531 [inline]
 get_page_from_freelist+0x119c/0x2ce0 mm/page_alloc.c:4283
 __alloc_pages+0x1cb/0x5b0 mm/page_alloc.c:5549
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2285
 alloc_slab_page mm/slub.c:1851 [inline]
 allocate_slab+0x25f/0x350 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3193
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3292
 __slab_alloc_node mm/slub.c:3345 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 __kmem_cache_alloc_node+0x1a4/0x430 mm/slub.c:3491
 __do_kmalloc_node mm/slab_common.c:967 [inline]
 __kmalloc_node_track_caller+0x4b/0xc0 mm/slab_common.c:988
 kmalloc_reserve net/core/skbuff.c:492 [inline]
 __alloc_skb+0xe9/0x310 net/core/skbuff.c:565
 alloc_skb include/linux/skbuff.h:1270 [inline]
 nlmsg_new include/net/netlink.h:1002 [inline]
 mpls_netconf_notify_devconf+0x4a/0x110 net/mpls/af_mpls.c:1188
 mpls_dev_sysctl_register+0x1fe/0x2d0 net/mpls/af_mpls.c:1425
 mpls_add_dev net/mpls/af_mpls.c:1472 [inline]
 mpls_dev_notify+0x450/0x930 net/mpls/af_mpls.c:1612
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:87
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:1944
 call_netdevice_notifiers_extack net/core/dev.c:1982 [inline]
 call_netdevice_notifiers net/core/dev.c:1996 [inline]
 register_netdevice+0xfb4/0x1640 net/core/dev.c:10078
 rtnl_newlink_create net/core/rtnetlink.c:3409 [inline]
 __rtnl_newlink+0x15a1/0x1840 net/core/rtnetlink.c:3624
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1446 [inline]
 free_pcp_prepare+0x65c/0xc00 mm/page_alloc.c:1496
 free_unref_page_prepare mm/page_alloc.c:3369 [inline]
 free_unref_page+0x1d/0x490 mm/page_alloc.c:3464
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x192/0x220 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x66/0x90 mm/kasan/common.c:302
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:761 [inline]
 slab_alloc_node mm/slub.c:3452 [inline]
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc+0x1e4/0x430 mm/slub.c:3476
 vm_area_alloc+0x20/0x100 kernel/fork.c:458
 mmap_region+0x44c/0x1dd0 mm/mmap.c:2601
 do_mmap+0x831/0xf60 mm/mmap.c:1411
 vm_mmap_pgoff+0x1af/0x280 mm/util.c:520
 ksys_mmap_pgoff+0x7d/0x5a0 mm/mmap.c:1457
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88807034ff00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
 ffff88807034ff80: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>ffff888070350000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff888070350080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888070350100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         f9ff5644 Merge tag 'hsi-for-6.2' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=13ef5baf880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3263313469e7ca77
dashboard link: https://syzkaller.appspot.com/bug?extid=b8e8c01c8ade4fe6e48f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=158d1327880000

