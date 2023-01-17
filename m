Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1AD166D485
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235760AbjAQCqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235697AbjAQCqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:46:20 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF5838669
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:40:14 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id g14-20020a6be60e000000b00704cfc5228aso141976ioh.22
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:40:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wtsVQhMMUIL8HgVepShznlsOTVmeDxxaXtRPK292XcQ=;
        b=jR3I34QdUiNzRG7GJScB3WXHg55LMh24AYUHjF15bNAn3vNPm66AtRBb9Iyf215Gsa
         VXms8TS+4SOcoZDWWNCcbcSQyDnR3eKUk/nk3Gd/sHiadDVSEfgJwkwgWLjvpr4aQtZj
         aWi3tFu2kff9BahzRttAzbHePWVwRS4APEVqik4Y+0h9UWoIMSFkl1en5IIeIMSuDQdF
         QkY+EyGuA+j3S3hkfQ6gUpxUKEVc/fmXawRwwuckw/VQqWORzirzh8UMiERvLFmslXEn
         KWELoqUAsTuucOWOYqVOl/VcVG9sOKbTE3kIep+6IfLnoywNdfyqkCPOGvf7L7kn+QbL
         2K2w==
X-Gm-Message-State: AFqh2kp8i01hjZ+gGCEGljYwei+MPx8sBWsovA/tAMN8wpuHTZpZJrpm
        lw3i0U6dSFrRRkFyS3SrbCE92R6+0iCpvfDo+2UdAfF4KD8D
X-Google-Smtp-Source: AMrXdXush5mJlK8tr24jFfsUZlAmtDWqapI7J6hnInis2PfJd599bnaRogk68XvalSUBqelMqXBh2nPrZdBDk28CDM3OqSUhWka6
MIME-Version: 1.0
X-Received: by 2002:a6b:e307:0:b0:704:a7b2:f725 with SMTP id
 u7-20020a6be307000000b00704a7b2f725mr92243ioc.18.1673923161580; Mon, 16 Jan
 2023 18:39:21 -0800 (PST)
Date:   Mon, 16 Jan 2023 18:39:21 -0800
In-Reply-To: <20230117015907.2238-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006d6b3d05f26c9b7b@google.com>
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
BUG: KASAN: use-after-free in io_req_caches_free+0x1a8/0x201 io_uring/io_uring.c:2743
Read of size 8 at addr ffff88802848f938 by task kworker/u4:2/29

CPU: 0 PID: 29 Comm: kworker/u4:2 Not tainted 6.2.0-rc3-next-20230112-syzkaller-dirty #0
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
 io_req_caches_free+0x1a8/0x201 io_uring/io_uring.c:2743
 io_ring_exit_work+0x2e7/0xc80 io_uring/io_uring.c:2975
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
 io_submit_sqes.cold+0x7c/0xc2 io_uring/io_uring.c:2413
 __do_sys_io_uring_enter+0x9e4/0x2c10 io_uring/io_uring.c:3437
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 29:
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
 io_req_caches_free+0x1c4/0x201 io_uring/io_uring.c:2745
 io_ring_exit_work+0x2e7/0xc80 io_uring/io_uring.c:2975
 process_one_work+0x9bf/0x1750 kernel/workqueue.c:2293
 worker_thread+0x669/0x1090 kernel/workqueue.c:2440
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

The buggy address belongs to the object at ffff88802848f8c0
 which belongs to the cache io_kiocb of size 224
The buggy address is located 120 bytes inside of
 224-byte region [ffff88802848f8c0, ffff88802848f9a0)

The buggy address belongs to the physical page:
page:ffffea0000a123c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2848f
memcg:ffff888028e66b81
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffff88801bcba780 dead000000000122 0000000000000000
raw: 0000000000000000 00000000000c000c 00000001ffffffff ffff888028e66b81
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 5603, tgid 5602 (syz-executor.0), ts 86682323238, free_ts 86643623166
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
 io_submit_sqes.cold+0x7c/0xc2 io_uring/io_uring.c:2413
 __do_sys_io_uring_enter+0x9e4/0x2c10 io_uring/io_uring.c:3437
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1451 [inline]
 free_pcp_prepare+0x4d0/0x910 mm/page_alloc.c:1501
 free_unref_page_prepare mm/page_alloc.c:3387 [inline]
 free_unref_page+0x1d/0x490 mm/page_alloc.c:3482
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x192/0x220 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x63/0x90 mm/kasan/common.c:302
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:769 [inline]
 slab_alloc_node mm/slub.c:3452 [inline]
 __kmem_cache_alloc_node+0x17c/0x330 mm/slub.c:3491
 __do_kmalloc_node mm/slab_common.c:966 [inline]
 __kmalloc_node+0x4d/0xd0 mm/slab_common.c:974
 kmalloc_node include/linux/slab.h:610 [inline]
 kvmalloc_node+0xa2/0x1a0 mm/util.c:603
 kvmalloc include/linux/slab.h:737 [inline]
 seq_buf_alloc fs/seq_file.c:38 [inline]
 seq_read_iter+0x7fb/0x1280 fs/seq_file.c:210
 kernfs_fop_read_iter+0x4ce/0x690 fs/kernfs/file.c:279
 call_read_iter include/linux/fs.h:1846 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x681/0x930 fs/read_write.c:470
 ksys_read+0x12b/0x250 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88802848f800: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
 ffff88802848f880: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
>ffff88802848f900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                        ^
 ffff88802848f980: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802848fa00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


Tested on:

commit:         0a093b28 Add linux-next specific files for 20230112
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17950e0e480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=835f3591019836d5
dashboard link: https://syzkaller.appspot.com/bug?extid=e29d28728f38190cecfc
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15cf6919480000

