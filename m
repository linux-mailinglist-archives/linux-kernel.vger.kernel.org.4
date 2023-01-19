Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9256C672E93
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 03:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjASCB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 21:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjASCBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 21:01:20 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C1A3A5B4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 18:01:19 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id 9-20020a056e0220c900b0030f1b0dfa9dso655116ilq.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 18:01:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rZBOaQUcL771J98/jIqGt4mUYPRSwV+UtHOXkUkKC9M=;
        b=z4VbwQdti0WVA2eKRlPbdJcR2qO7MD0W9SVJL4k014ZUXbja4mF+G3ab9XzmuqM9E6
         5wYDstt9zj73l5N6Me8WYgCSiFRSyL4n4XpyqlHfRMvqH2tUds2GCZIfoizEtJ2sVyGu
         z+eCt8jMvcEUUKqZWorrHcGDlR9Ah6+MxJsnfWC561ZtEl04xiyXIV08n/nKFIY52ZGM
         UrZKa5aSC6vOocLCbYqnGrnKdC4zCvg5fzfX5Kxq/1kkM7M8kCy8GH4chsWLRE5kqsKE
         P46VReYCs1TunhFDAAVk+1Jg74lwJ8ktVaTY8ndMCx0x+JG7cdA9bZD9bhWN5yKPPKPj
         zE0w==
X-Gm-Message-State: AFqh2kqVWyXQH2vCNr+jmmfHrLHWeKO15eXZfI2rnMypk5XBGY6qB8Xe
        LJ80wwWMg0P6lqvtFBB9MRUox7OtHpWOggZdWdTyedtTRdna
X-Google-Smtp-Source: AMrXdXtsuyOSKVngNb/ofDe+bVTyAol71LZMkNpci91xwSjYF1Q9Cujyf4YC2RqLItN/DFawxrRuQuLTdAKTfSmz6CQd1I71D28c
MIME-Version: 1.0
X-Received: by 2002:a92:dd85:0:b0:30d:ab64:fe05 with SMTP id
 g5-20020a92dd85000000b0030dab64fe05mr1008621iln.307.1674093678811; Wed, 18
 Jan 2023 18:01:18 -0800 (PST)
Date:   Wed, 18 Jan 2023 18:01:18 -0800
In-Reply-To: <20230119012145.3304-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000be20f05f2944f6f@google.com>
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
BUG: KASAN: use-after-free in io_req_caches_free+0x199/0x1f2 io_uring/io_uring.c:2744
Read of size 8 at addr ffff88802990f938 by task kworker/u4:0/9

CPU: 0 PID: 9 Comm: kworker/u4:0 Not tainted 6.2.0-rc3-next-20230112-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
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
 io_req_caches_free+0x199/0x1f2 io_uring/io_uring.c:2744
 io_ring_exit_work+0x2e7/0xc80 io_uring/io_uring.c:2976
 process_one_work+0x9bf/0x1750 kernel/workqueue.c:2293
 worker_thread+0x669/0x1090 kernel/workqueue.c:2440
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

Allocated by task 5595:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x7f/0x90 mm/kasan/common.c:325
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:769 [inline]
 kmem_cache_alloc_bulk+0x3aa/0x730 mm/slub.c:4033
 __io_alloc_req_refill+0xcc/0x40b io_uring/io_uring.c:1063
 io_alloc_req_refill io_uring/io_uring.h:348 [inline]
 io_submit_sqes.cold+0x7c/0xc2 io_uring/io_uring.c:2415
 __do_sys_io_uring_enter+0x9e4/0x2c10 io_uring/io_uring.c:3438
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
 io_req_caches_free+0x1b5/0x1f2 io_uring/io_uring.c:2746
 io_ring_exit_work+0x2e7/0xc80 io_uring/io_uring.c:2976
 process_one_work+0x9bf/0x1750 kernel/workqueue.c:2293
 worker_thread+0x669/0x1090 kernel/workqueue.c:2440
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

The buggy address belongs to the object at ffff88802990f8c0
 which belongs to the cache io_kiocb of size 224
The buggy address is located 120 bytes inside of
 224-byte region [ffff88802990f8c0, ffff88802990f9a0)

The buggy address belongs to the physical page:
page:ffffea0000a643c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2990f
memcg:ffff888021c15d01
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffff88801c3adc80 dead000000000122 0000000000000000
raw: 0000000000000000 00000000800c000c 00000001ffffffff ffff888021c15d01
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 5595, tgid 5594 (syz-executor.0), ts 89945650593, free_ts 79190938979
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
 io_submit_sqes.cold+0x7c/0xc2 io_uring/io_uring.c:2415
 __do_sys_io_uring_enter+0x9e4/0x2c10 io_uring/io_uring.c:3438
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1451 [inline]
 free_pcp_prepare+0x4d0/0x910 mm/page_alloc.c:1501
 free_unref_page_prepare mm/page_alloc.c:3387 [inline]
 free_unref_page+0x1d/0x490 mm/page_alloc.c:3482
 __folio_put_small mm/swap.c:106 [inline]
 __folio_put+0xc5/0x140 mm/swap.c:129
 folio_put include/linux/mm.h:1203 [inline]
 put_page include/linux/mm.h:1272 [inline]
 anon_pipe_buf_release+0x3fb/0x4c0 fs/pipe.c:138
 pipe_buf_release include/linux/pipe_fs_i.h:183 [inline]
 pipe_read+0x614/0x1110 fs/pipe.c:324
 call_read_iter include/linux/fs.h:1846 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x7fa/0x930 fs/read_write.c:470
 ksys_read+0x1ec/0x250 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88802990f800: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
 ffff88802990f880: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
>ffff88802990f900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                        ^
 ffff88802990f980: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802990fa00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         0a093b28 Add linux-next specific files for 20230112
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11ac82b6480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=835f3591019836d5
dashboard link: https://syzkaller.appspot.com/bug?extid=e29d28728f38190cecfc
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=136278a9480000

