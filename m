Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A11672DE5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 02:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjASBNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 20:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjASBNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 20:13:25 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E278539BA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 17:13:18 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id s12-20020a056e021a0c00b0030efd0ed890so594588ild.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 17:13:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=THrHwLIFJZ1jbjLr9MCxv7p7qYgPa3kxyIZJ3N6KufU=;
        b=bfLmf+xaUj1HzZrmHX4FKl09pGUs4V9XzSaA0YRKzZoYtFMcK8U8voSOMS8qUHeFRv
         XpxcPYzoliQTHtlpOt6ARxDJKiYz1rDq0O6qJGOqKJ7ateH43AsnlMqff66H3LmMM5PL
         wL6utnD5JjzsxqZH+wO9V6m2p13B3T6FUU0o4cHGBqw5j3lkjudBAtY/wQ4fS1+eAhEZ
         nFI69jtzmqKXleds8RI3qOo9b6PTigviFkhJbjQ3wMOEakGPLi3okjBQsXiUi+zskFY2
         Z7acoFfa2cH0/oheqkJSPiO/im9TJ/BxScddGvAPThfofk+i7gA5FVMBqGhuXLo4fBJU
         izTg==
X-Gm-Message-State: AFqh2kqfFckAeaPrz10E3uadDItFBI/OofXj5FrFI0ZMr1t3Q87cLrfI
        fuZ3BKdV8xmWosaW3H5aJMhEx8UYpW4Rvx94A6/KLAXthCwD
X-Google-Smtp-Source: AMrXdXuNklgoCcMVRjEfweiE4mYBE+SH5wy/9Omec+JTRNHW/emeCLD3yKTqliXZdJahDMOiz4SZKmAwW/Jj5rNM1rj9YBdGqusA
MIME-Version: 1.0
X-Received: by 2002:a02:caac:0:b0:3a3:1d2f:1a23 with SMTP id
 e12-20020a02caac000000b003a31d2f1a23mr857114jap.85.1674090797683; Wed, 18 Jan
 2023 17:13:17 -0800 (PST)
Date:   Wed, 18 Jan 2023 17:13:17 -0800
In-Reply-To: <20230118222858.3127-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000051626305f293a395@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in snd_pcm_post_stop
From:   syzbot <syzbot+e29d28728f38190cecfc@syzkaller.appspotmail.com>
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
KASAN: use-after-free Read in io_fallback_req_func

==================================================================
BUG: KASAN: use-after-free in io_fallback_req_func+0xc7/0x204 io_uring/io_uring.c:251
Read of size 8 at addr ffff888070652948 by task kworker/0:4/5090

CPU: 0 PID: 5090 Comm: kworker/0:4 Not tainted 6.2.0-rc3-next-20230112-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
Workqueue: events io_fallback_req_func
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:306 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:417
 kasan_report+0xc0/0xf0 mm/kasan/report.c:517
 io_fallback_req_func+0xc7/0x204 io_uring/io_uring.c:251
 process_one_work+0x9bf/0x1750 kernel/workqueue.c:2293
 worker_thread+0x669/0x1090 kernel/workqueue.c:2440
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

Allocated by task 5603:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x7f/0x90 mm/kasan/common.c:325
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:769 [inline]
 kmem_cache_alloc_bulk+0x3aa/0x730 mm/slub.c:4033
 __io_alloc_req_refill+0xcc/0x40b io_uring/io_uring.c:1063
 io_alloc_req_refill io_uring/io_uring.h:348 [inline]
 io_submit_sqes.cold+0x7c/0xc2 io_uring/io_uring.c:2414
 __do_sys_io_uring_enter+0x9e4/0x2c10 io_uring/io_uring.c:3436
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 9:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2e/0x40 mm/kasan/generic.c:518
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x160/0x1c0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1807
 slab_free mm/slub.c:3787 [inline]
 kmem_cache_free+0xec/0x4e0 mm/slub.c:3809
 io_req_caches_free+0x1a9/0x1e6 io_uring/io_uring.c:2744
 io_ring_exit_work+0x2e7/0xc80 io_uring/io_uring.c:2974
 process_one_work+0x9bf/0x1750 kernel/workqueue.c:2293
 worker_thread+0x669/0x1090 kernel/workqueue.c:2440
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

The buggy address belongs to the object at ffff8880706528c0
 which belongs to the cache io_kiocb of size 224
The buggy address is located 136 bytes inside of
 224-byte region [ffff8880706528c0, ffff8880706529a0)

The buggy address belongs to the physical page:
page:ffffea0001c19480 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x70652
memcg:ffff888026aa6301
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffff888146499780 dead000000000122 0000000000000000
raw: 0000000000000000 00000000800c000c 00000001ffffffff ffff888026aa6301
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 5603, tgid 5602 (syz-executor.0), ts 88591275349, free_ts 64543666654
 prep_new_page mm/page_alloc.c:2549 [inline]
 get_page_from_freelist+0x11bb/0x2d50 mm/page_alloc.c:4324
 __alloc_pages+0x1cb/0x5c0 mm/page_alloc.c:5590
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2281
 alloc_slab_page mm/slub.c:1851 [inline]
 allocate_slab+0x25f/0x350 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3193
 __kmem_cache_alloc_bulk mm/slub.c:3951 [inline]
 kmem_cache_alloc_bulk+0x23d/0x730 mm/slub.c:4026
 __io_alloc_req_refill+0xcc/0x40b io_uring/io_uring.c:1063
 io_alloc_req_refill io_uring/io_uring.h:348 [inline]
 io_submit_sqes.cold+0x7c/0xc2 io_uring/io_uring.c:2414
 __do_sys_io_uring_enter+0x9e4/0x2c10 io_uring/io_uring.c:3436
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1451 [inline]
 __free_pages_ok+0x6ac/0xdc0 mm/page_alloc.c:1707
 kvfree+0x46/0x50 mm/util.c:649
 wg_destruct+0x2f4/0x400 drivers/net/wireguard/device.c:265
 netdev_run_todo+0x6bf/0x1100 net/core/dev.c:10352
 default_device_exit_batch+0x456/0x590 net/core/dev.c:11349
 ops_exit_list+0x125/0x170 net/core/net_namespace.c:174
 cleanup_net+0x4ee/0xb10 net/core/net_namespace.c:606
 process_one_work+0x9bf/0x1750 kernel/workqueue.c:2293
 worker_thread+0x669/0x1090 kernel/workqueue.c:2440
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Memory state around the buggy address:
 ffff888070652800: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff888070652880: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
>ffff888070652900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                              ^
 ffff888070652980: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888070652a00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         0a093b28 Add linux-next specific files for 20230112
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=151c52a9480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=835f3591019836d5
dashboard link: https://syzkaller.appspot.com/bug?extid=e29d28728f38190cecfc
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14f99661480000

