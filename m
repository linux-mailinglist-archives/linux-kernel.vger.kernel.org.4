Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C3766B569
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 02:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjAPB4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 20:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjAPB4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 20:56:32 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07119EF5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 17:55:21 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id s12-20020a056e021a0c00b0030efd0ed890so1499273ild.7
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 17:55:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lsTO3Wt6Fuvqtm+5SSngsCyfS6hkMCtHIbCYFCWXt94=;
        b=n2buXp4w/Myv6vIStIwKN3J47Jc75S5zsRDmIK4AotZ7gDJjVqXaUzzdoLDYZtl77Q
         +gHFu9X2oi4Tba0A3/uHO5X1JsKE5aNEwRcQt+zwLKZOFTqZeo4XpZ8k3TX1TdwweOq/
         8ApdqwmfY89AmvNvOZXjRPfiOF8CVqbNuPfR0xrGNZlbpJAq4Ha5J2MtfxdiiEfsVjcK
         5eXGDpU6ilJTNFt2+RQFkzzQ6OVBL35M+VrdxFZITI+MDIaenp3ynFcaXxJg6Nz28Cdf
         H18nsDpF6AJP/1JA7G6mrEUxd+qxvz0+mBB0lnuLzdENzTox+yUx/ZqjXUJadVedw0ZX
         Z07Q==
X-Gm-Message-State: AFqh2koZ6sR39Nb/5nhH3yBYnMq15hSYR67Q/jNrCUQKUy0/TUBKcbjp
        OWZoKrhe5mOw3QPVJI99j4QF07jvyUTo3qJDX/q5dFs9wNNC
X-Google-Smtp-Source: AMrXdXupXx4OHRn5l0n+HZZKivkCTTJl+Afk950OLjfgInGRteLowAU6no549sNnhMddBMEo8ChbwVPakHtKJc0qFapBk7yiziQj
MIME-Version: 1.0
X-Received: by 2002:a92:d5cf:0:b0:30b:b741:205c with SMTP id
 d15-20020a92d5cf000000b0030bb741205cmr8608838ilq.113.1673834121049; Sun, 15
 Jan 2023 17:55:21 -0800 (PST)
Date:   Sun, 15 Jan 2023 17:55:21 -0800
In-Reply-To: <20230116012417.1876-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000032bfc305f257e049@google.com>
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
KASAN: use-after-free Read in io_req_caches_free

==================================================================
BUG: KASAN: use-after-free in wq_stack_extract io_uring/slist.h:126 [inline]
BUG: KASAN: use-after-free in io_alloc_req io_uring/io_uring.h:356 [inline]
BUG: KASAN: use-after-free in io_req_caches_free+0x199/0x1f2 io_uring/io_uring.c:2750
Read of size 8 at addr ffff88801da98938 by task kworker/u4:3/46

CPU: 1 PID: 46 Comm: kworker/u4:3 Not tainted 6.2.0-rc3-next-20230112-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: events_unbound io_ring_exit_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:306 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:417
 kasan_report+0xc0/0xf0 mm/kasan/report.c:517
 wq_stack_extract io_uring/slist.h:126 [inline]
 io_alloc_req io_uring/io_uring.h:356 [inline]
 io_req_caches_free+0x199/0x1f2 io_uring/io_uring.c:2750
 io_ring_exit_work+0x2e7/0xc80 io_uring/io_uring.c:2982
 process_one_work+0x9bf/0x1750 kernel/workqueue.c:2293
 worker_thread+0x669/0x1090 kernel/workqueue.c:2440
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

Allocated by task 5596:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x7f/0x90 mm/kasan/common.c:325
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:769 [inline]
 kmem_cache_alloc_bulk+0x3aa/0x730 mm/slub.c:4033
 __io_alloc_req_refill+0xcc/0x40b io_uring/io_uring.c:1068
 io_alloc_req_refill io_uring/io_uring.h:348 [inline]
 io_submit_sqes.cold+0x7c/0xc2 io_uring/io_uring.c:2421
 __do_sys_io_uring_enter+0x9e4/0x2c10 io_uring/io_uring.c:3444
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 46:
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
 io_req_caches_free+0x1b5/0x1f2 io_uring/io_uring.c:2752
 io_ring_exit_work+0x2e7/0xc80 io_uring/io_uring.c:2982
 process_one_work+0x9bf/0x1750 kernel/workqueue.c:2293
 worker_thread+0x669/0x1090 kernel/workqueue.c:2440
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

The buggy address belongs to the object at ffff88801da988c0
 which belongs to the cache io_kiocb of size 224
The buggy address is located 120 bytes inside of
 224-byte region [ffff88801da988c0, ffff88801da989a0)

The buggy address belongs to the physical page:
page:ffffea000076a600 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1da98
memcg:ffff88801cfa1401
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffff88801bf2a280 dead000000000122 0000000000000000
raw: 0000000000000000 00000000000c000c 00000001ffffffff ffff88801cfa1401
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 5596, tgid 5595 (syz-executor.0), ts 93592785724, free_ts 93586502326
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
 __io_alloc_req_refill+0xcc/0x40b io_uring/io_uring.c:1068
 io_alloc_req_refill io_uring/io_uring.h:348 [inline]
 io_submit_sqes.cold+0x7c/0xc2 io_uring/io_uring.c:2421
 __do_sys_io_uring_enter+0x9e4/0x2c10 io_uring/io_uring.c:3444
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1451 [inline]
 free_pcp_prepare+0x4d0/0x910 mm/page_alloc.c:1501
 free_unref_page_prepare mm/page_alloc.c:3387 [inline]
 free_unref_page+0x1d/0x490 mm/page_alloc.c:3482
 __unfreeze_partials+0x17c/0x1a0 mm/slub.c:2637
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x192/0x220 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x63/0x90 mm/kasan/common.c:302
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:769 [inline]
 slab_alloc_node mm/slub.c:3452 [inline]
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc_lru+0x20e/0x580 mm/slub.c:3483
 alloc_inode_sb include/linux/fs.h:2692 [inline]
 sock_alloc_inode+0x27/0x1d0 net/socket.c:304
 alloc_inode+0x61/0x230 fs/inode.c:260
 new_inode_pseudo+0x17/0x80 fs/inode.c:1019
 sock_alloc+0x40/0x270 net/socket.c:627
 __sock_create+0xbd/0x810 net/socket.c:1479
 io_uring_get_file io_uring/io_uring.c:3604 [inline]
 io_uring_create io_uring/io_uring.c:3785 [inline]
 io_uring_setup.cold+0x1913/0x1d97 io_uring/io_uring.c:3835
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88801da98800: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
 ffff88801da98880: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
>ffff88801da98900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                        ^
 ffff88801da98980: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88801da98a00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


Tested on:

commit:         0a093b28 Add linux-next specific files for 20230112
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1073daa6480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=835f3591019836d5
dashboard link: https://syzkaller.appspot.com/bug?extid=e29d28728f38190cecfc
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17832c5e480000

