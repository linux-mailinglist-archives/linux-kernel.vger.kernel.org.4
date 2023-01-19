Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84F367310F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 06:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjASFQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 00:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjASFQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 00:16:55 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAFDBC
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 21:16:53 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id k1-20020a6b3c01000000b006f744aee560so568637iob.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 21:16:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I1aU/PL6tMgM5C6OSxI3zVtDB4cScYrJPqlQCL27Nfk=;
        b=Pt30wQbvrEClukh3D4gdTxfvDKti++4B7Gmig1YDpHmGMuaZ8QvftOoa45bA9OuLkK
         69xkTMT25JdIGGwwS/sjOEPBY2VF1Va6MH+Ac+a+7KGFsUm/zaQOx7P7MnDXOLTdAmQD
         GP+d1syXz6L0/uA5qtZytgAixqrzaQIX32Jmapwh3/AcZZISVbAdYIBKrcbttJjz6O27
         L79Dt3mvnZHUvzZb/bcmIx29+Z65n8YQXqVGdwRC07Pw0817VoFR/0Y+kRgKZDLk6CUd
         DDqMR6Ch9MMPB7TqCTn9j0ZVsOo9KDJ9RenqFT8ydayCs2dcNWJadkrK5vxAnZk69mqd
         XCbw==
X-Gm-Message-State: AFqh2kplrLnQD0J3PyuA7ZDHZdw5I/PMG7XnI6N5Ymhs1Qp9oYeQIw+O
        v/1Dty11gYx7PMqBBc4c+hRzadXnWQrIb+CKmCiPEpTvGTwi
X-Google-Smtp-Source: AMrXdXsalJ7tUBzAKiJ8+jhNoYGnkgZ+haQ55kzASOWynPY1qLjZRDasj9IZ87sJHX0TToddN6uyKrAP7Xsl5vY5NIJRTPiyDcyq
MIME-Version: 1.0
X-Received: by 2002:a02:c001:0:b0:39d:72ab:a7c5 with SMTP id
 y1-20020a02c001000000b0039d72aba7c5mr930742jai.247.1674098297625; Wed, 18 Jan
 2023 19:18:17 -0800 (PST)
Date:   Wed, 18 Jan 2023 19:18:17 -0800
In-Reply-To: <20230119030102.3388-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000059dbb505f295624e@google.com>
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
BUG: KASAN: use-after-free in io_alloc_req io_uring/io_uring.h:357 [inline]
BUG: KASAN: use-after-free in io_req_caches_free+0x1a2/0x254 io_uring/io_uring.c:2748
Read of size 8 at addr ffff88801c8dc938 by task kworker/u4:2/41

CPU: 1 PID: 41 Comm: kworker/u4:2 Not tainted 6.2.0-rc3-next-20230112-syzkaller-dirty #0
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
 io_alloc_req io_uring/io_uring.h:357 [inline]
 io_req_caches_free+0x1a2/0x254 io_uring/io_uring.c:2748
 io_ring_exit_work+0x2e7/0xc80 io_uring/io_uring.c:2980
 process_one_work+0x9bf/0x1750 kernel/workqueue.c:2293
 worker_thread+0x669/0x1090 kernel/workqueue.c:2440
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

Allocated by task 5602:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x7f/0x90 mm/kasan/common.c:325
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:769 [inline]
 kmem_cache_alloc_bulk+0x3aa/0x730 mm/slub.c:4033
 __io_alloc_req_refill+0xcc/0x434 io_uring/io_uring.c:1066
 io_alloc_req_refill io_uring/io_uring.h:348 [inline]
 io_submit_sqes.cold+0xd/0xc2 io_uring/io_uring.c:2419
 __do_sys_io_uring_enter+0x9e4/0x2c10 io_uring/io_uring.c:3442
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 41:
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
 io_req_caches_free+0x20f/0x254 io_uring/io_uring.c:2750
 io_ring_exit_work+0x2e7/0xc80 io_uring/io_uring.c:2980
 process_one_work+0x9bf/0x1750 kernel/workqueue.c:2293
 worker_thread+0x669/0x1090 kernel/workqueue.c:2440
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

The buggy address belongs to the object at ffff88801c8dc8c0
 which belongs to the cache io_kiocb of size 232
The buggy address is located 120 bytes inside of
 232-byte region [ffff88801c8dc8c0, ffff88801c8dc9a8)

The buggy address belongs to the physical page:
page:ffffea0000723700 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1c8dc
memcg:ffff888021840981
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffff88801bf2ba00 dead000000000122 0000000000000000
raw: 0000000000000000 00000000000c000c 00000001ffffffff ffff888021840981
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 5602, tgid 5601 (syz-executor.0), ts 88366341970, free_ts 87676511455
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
 __io_alloc_req_refill+0xcc/0x434 io_uring/io_uring.c:1066
 io_alloc_req_refill io_uring/io_uring.h:348 [inline]
 io_submit_sqes.cold+0xd/0xc2 io_uring/io_uring.c:2419
 __do_sys_io_uring_enter+0x9e4/0x2c10 io_uring/io_uring.c:3442
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1451 [inline]
 free_pcp_prepare+0x4d0/0x910 mm/page_alloc.c:1501
 free_unref_page_prepare mm/page_alloc.c:3387 [inline]
 free_unref_page_list+0x176/0xcd0 mm/page_alloc.c:3528
 release_pages+0xcb1/0x1330 mm/swap.c:1072
 tlb_batch_pages_flush+0xa8/0x1a0 mm/mmu_gather.c:97
 tlb_flush_mmu_free mm/mmu_gather.c:292 [inline]
 tlb_flush_mmu mm/mmu_gather.c:299 [inline]
 tlb_finish_mmu+0x14b/0x7e0 mm/mmu_gather.c:391
 exit_mmap+0x202/0x7c0 mm/mmap.c:3100
 __mmput+0x128/0x4c0 kernel/fork.c:1212
 mmput+0x60/0x70 kernel/fork.c:1234
 exec_mmap fs/exec.c:1034 [inline]
 begin_new_exec+0x1027/0x2f80 fs/exec.c:1293
 load_elf_binary+0x801/0x4ff0 fs/binfmt_elf.c:1001
 search_binary_handler fs/exec.c:1736 [inline]
 exec_binprm fs/exec.c:1778 [inline]
 bprm_execve fs/exec.c:1853 [inline]
 bprm_execve+0x7fd/0x1ae0 fs/exec.c:1809
 do_execveat_common+0x72c/0x880 fs/exec.c:1960
 do_execve fs/exec.c:2034 [inline]
 __do_sys_execve fs/exec.c:2110 [inline]
 __se_sys_execve fs/exec.c:2105 [inline]
 __x64_sys_execve+0x93/0xc0 fs/exec.c:2105
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88801c8dc800: 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc
 ffff88801c8dc880: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
>ffff88801c8dc900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                        ^
 ffff88801c8dc980: fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc
 ffff88801c8dca00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


Tested on:

commit:         0a093b28 Add linux-next specific files for 20230112
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=110560fa480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=835f3591019836d5
dashboard link: https://syzkaller.appspot.com/bug?extid=e29d28728f38190cecfc
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1259a9b1480000

