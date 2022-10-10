Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9B25F99F9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 09:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbiJJHaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 03:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbiJJH3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 03:29:53 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65AF6BD6C
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 00:24:30 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id a9-20020a056e0208a900b002f6b21181f5so8226830ilt.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 00:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tgKPEUKaB5Yd0tF2nzOIbFn9+qqlIyMN+LCs2fTjji4=;
        b=BED4TS+mFYwpRDG2oxAe680ectDQle+HuuZYMTAXveJscyzLgSuuYWGo8Z2RKL2Gwz
         t600udYH8B8Rff91cz4g9HalnRHjw48klqrySrVyviB6FNCwm9lGKjEbCaNZGDEIDeTt
         /4cHl8PbZTbpRWd8ddkO5XqPPiKLDf3P4vxNaIzNx9Y2nEHMf9iHxnc2gxRQaDKsRZBQ
         Z6XijNH7kVMODFox+wSLAXeKCampt5X1JGHbISpL9vay1Dj/vOEqzFwnoa2cxWY7LNQk
         /xVjwS6o+zMcN91o6EW3jWi+BClKCZ3WvGHxQtowPMJDAkBlor2ZiCUAkfwh+ZdB9gAu
         CvJA==
X-Gm-Message-State: ACrzQf1NT1t4bh0eZ21LkhK1VPhpwlSbmHx2bIrwEiuAbr6uew8bzSKC
        rtv6ysh5x1qfhOkmJFeZuSPkCaBGitnqLCt0UU1fWqGX91BV
X-Google-Smtp-Source: AMsMyM79QvQFJF2B5KZzSylDt+s+tMs7NEAKV3/eBLmjP45tqqCO2EPuHeJboIXp/6z+MPHKYU5dcWdb+YjD36V1CUxocoV6WoKt
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d09:b0:2f9:c2e3:173d with SMTP id
 i9-20020a056e021d0900b002f9c2e3173dmr8511822ila.49.1665386145629; Mon, 10 Oct
 2022 00:15:45 -0700 (PDT)
Date:   Mon, 10 Oct 2022 00:15:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009fcec905eaa8ed63@google.com>
Subject: [syzbot] KASAN: slab-out-of-bounds Write in udf_find_entry
From:   syzbot <syzbot+69c9fdccc6dd08961d34@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-kernel@vger.kernel.org,
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

syzbot found the following issue on:

HEAD commit:    a6afa4199d3d Merge tag 'mailbox-v6.1' of git://git.linaro...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1725efbc880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
dashboard link: https://syzkaller.appspot.com/bug?extid=69c9fdccc6dd08961d34
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16f5d358880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ccc11c880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/12e24d042ff9/disk-a6afa419.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4862ae4e2edf/vmlinux-a6afa419.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/575958c7b620/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/9e49c32cc0ea/mount_7.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+69c9fdccc6dd08961d34@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in udf_find_entry+0x8a5/0x14f0 fs/udf/namei.c:253
Write of size 165 at addr ffff888028a7925a by task syz-executor237/3608

CPU: 1 PID: 3608 Comm: syz-executor237 Not tainted 6.0.0-syzkaller-09039-ga6afa4199d3d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 print_address_description+0x65/0x4b0 mm/kasan/report.c:317
 print_report+0x108/0x1f0 mm/kasan/report.c:433
 kasan_report+0xc3/0xf0 mm/kasan/report.c:495
 kasan_check_range+0x2a7/0x2e0 mm/kasan/generic.c:189
 memcpy+0x3c/0x60 mm/kasan/shadow.c:66
 udf_find_entry+0x8a5/0x14f0 fs/udf/namei.c:253
 udf_lookup+0xef/0x340 fs/udf/namei.c:309
 __lookup_hash+0x115/0x240 fs/namei.c:1601
 do_unlinkat+0x26b/0x940 fs/namei.c:4281
 do_coredump+0x20fb/0x2970 fs/coredump.c:667
 get_signal+0x1417/0x1770 kernel/signal.c:2843
 arch_do_signal_or_restart+0x7b/0x730 arch/x86/kernel/signal.c:869
 exit_to_user_mode_loop+0x74/0x150 kernel/entry/common.c:166
 exit_to_user_mode_prepare+0xb2/0x140 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x26/0x60 kernel/entry/common.c:294
 do_syscall_64+0x49/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f30538fb8d6
Code: b8 ff ff ff ff eb b9 e8 68 3b 04 00 0f 1f 84 00 00 00 00 00 49 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 11 b8 12 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 90 48 83 ec 28 48 89 54 24 10 48 89 74
RSP: 002b:00007ffc4fc1dd88 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
RAX: ffffffffffffffe5 RBX: 0000000000000006 RCX: 00007f30538fb8d6
RDX: 0000000000000027 RSI: 0000020006000001 RDI: 0000000000000006
RBP: 00007ffc4fc1dda0 R08: 00007ffc4fc1dc20 R09: 0000555555693380
R10: 6608000000000014 R11: 0000000000000246 R12: 0000000000000028
R13: 0000000000000006 R14: 000000000000001c R15: 00000000200004a0
 </TASK>

Allocated by task 3608:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:437 [inline]
 ____kasan_kmalloc+0xcd/0x100 mm/kasan/common.c:516
 kasan_kmalloc include/linux/kasan.h:234 [inline]
 kmem_cache_alloc_trace+0x97/0x310 mm/slub.c:3289
 kmalloc include/linux/slab.h:600 [inline]
 udf_find_entry+0x7b6/0x14f0 fs/udf/namei.c:243
 udf_lookup+0xef/0x340 fs/udf/namei.c:309
 __lookup_hash+0x115/0x240 fs/namei.c:1601
 do_unlinkat+0x26b/0x940 fs/namei.c:4281
 do_coredump+0x20fb/0x2970 fs/coredump.c:667
 get_signal+0x1417/0x1770 kernel/signal.c:2843
 arch_do_signal_or_restart+0x7b/0x730 arch/x86/kernel/signal.c:869
 exit_to_user_mode_loop+0x74/0x150 kernel/entry/common.c:166
 exit_to_user_mode_prepare+0xb2/0x140 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x26/0x60 kernel/entry/common.c:294
 do_syscall_64+0x49/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888028a79200
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 90 bytes inside of
 256-byte region [ffff888028a79200, ffff888028a79300)

The buggy address belongs to the physical page:
page:ffffea0000a29e00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x28a78
head:ffffea0000a29e00 order:1 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffffea0000a29d80 dead000000000002 ffff888012041b40
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 2, tgid 2 (kthreadd), ts 11303152503, free_ts 0
 prep_new_page mm/page_alloc.c:2532 [inline]
 get_page_from_freelist+0x742/0x7c0 mm/page_alloc.c:4283
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5549
 alloc_slab_page+0x70/0xf0 mm/slub.c:1829
 allocate_slab+0x5e/0x520 mm/slub.c:1974
 new_slab mm/slub.c:2034 [inline]
 ___slab_alloc+0x3ee/0xc40 mm/slub.c:3036
 __slab_alloc mm/slub.c:3123 [inline]
 slab_alloc_node mm/slub.c:3214 [inline]
 slab_alloc mm/slub.c:3256 [inline]
 kmem_cache_alloc_trace+0x25f/0x310 mm/slub.c:3287
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 set_kthread_struct+0xb1/0x1f0 kernel/kthread.c:117
 copy_process+0x134d/0x3fa0 kernel/fork.c:2181
 kernel_clone+0x21f/0x790 kernel/fork.c:2671
 kernel_thread+0x150/0x1d0 kernel/fork.c:2724
 create_kthread kernel/kthread.c:399 [inline]
 kthreadd+0x57c/0x750 kernel/kthread.c:745
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888028a79180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888028a79200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888028a79280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06
                                                                ^
 ffff888028a79300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888028a79380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
