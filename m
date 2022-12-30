Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F089E6595B3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 08:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiL3HZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 02:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbiL3HZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 02:25:52 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF53062E8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 23:25:50 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id a9-20020a921a09000000b0030bda27ddcbso13082053ila.18
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 23:25:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IqHQ49bJlcJZ34yH2C9/X56h5IFAyRd9bfrXVatSMJI=;
        b=KnTbHZCDz2kB/8utMrn/Ed89Bg4DgYo4N7CKhLuUTGaBQwWzkFihMITwYEt8xRGBtZ
         nD8EnwPPSKLI4H6Oerud9/vH6kPP9rqB3/YtalxFi8Y6wy4i1TAAu6xqaRbpZ8AnlUa8
         gjm7XEgt1vKe43i49Ma0upim9KRCWl1vu94ouC7xyvZw2MagOS3z5dWgjSTTY6XvI1Y4
         rcLqlunO6wg+K7EPPloYKYpKcf+3ywPX7P9q3TBcoofozl+LRO8sUflnUlBkfxofpI2v
         h4YGBMF+TQyEcOD1tiAwqFbIco9J0qQCfXwD0g2znowM/Q+s0Ot5D0vd9X5+TPJHkVYb
         FGAw==
X-Gm-Message-State: AFqh2krD5ySUBA8XQWWeLj2UvUjH/6g0JWGWLfvGhA1/fEhAfzBVKRyS
        H8S9RZUyRSVU60wHxMcOAWbNuec2hYT+RhvctYRMrTHIMilX
X-Google-Smtp-Source: AMrXdXsifBtLLZNphenMdzsXVPUxDdUf9gq+IYkn5oIV7rvz0dlJSVW00RZ9E8XGzQaYP7ETwIjgkzHP0QRb3X4JSWzL+nxscrSk
MIME-Version: 1.0
X-Received: by 2002:a92:7409:0:b0:303:f9f:74cb with SMTP id
 p9-20020a927409000000b003030f9f74cbmr2210967ilc.167.1672385150065; Thu, 29
 Dec 2022 23:25:50 -0800 (PST)
Date:   Thu, 29 Dec 2022 23:25:50 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cc261105f10682eb@google.com>
Subject: [syzbot] [ntfs?] KASAN: use-after-free Read in ntfs_lookup_inode_by_name
From:   syzbot <syzbot+3625b78845a725e80f61@syzkaller.appspotmail.com>
To:     anton@tuxera.com, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net,
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

HEAD commit:    1b929c02afd3 Linux 6.2-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10a7ab50480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=68e0be42c8ee4bb4
dashboard link: https://syzkaller.appspot.com/bug?extid=3625b78845a725e80f61
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=173ffc54480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=178be1f8480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2d8c5072480f/disk-1b929c02.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/46687f1395db/vmlinux-1b929c02.xz
kernel image: https://storage.googleapis.com/syzbot-assets/26f1afa5ec00/bzImage-1b929c02.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/7e72c731b93c/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3625b78845a725e80f61@syzkaller.appspotmail.com

ntfs: (device loop0): check_mft_mirror(): $MFT and $MFTMirr (record 0) do not match.  Run ntfsfix or chkdsk.
ntfs: (device loop0): load_system_files(): $MFTMirr does not match $MFT.  Mounting read-only.  Run ntfsfix and/or chkdsk.
ntfs: volume version 3.1.
==================================================================
BUG: KASAN: use-after-free in sle64_to_cpup fs/ntfs/endian.h:46 [inline]
BUG: KASAN: use-after-free in ntfs_lookup_inode_by_name+0xe90/0x2ce0 fs/ntfs/dir.c:292
Read of size 8 at addr ffff88807fcb4b80 by task syz-executor169/5064

CPU: 1 PID: 5064 Comm: syz-executor169 Not tainted 6.2.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
 print_address_description+0x74/0x340 mm/kasan/report.c:306
 print_report+0x107/0x1f0 mm/kasan/report.c:417
 kasan_report+0xcd/0x100 mm/kasan/report.c:517
 sle64_to_cpup fs/ntfs/endian.h:46 [inline]
 ntfs_lookup_inode_by_name+0xe90/0x2ce0 fs/ntfs/dir.c:292
 check_windows_hibernation_status+0xec/0x4d0 fs/ntfs/super.c:1274
 load_system_files+0x34e0/0x4870 fs/ntfs/super.c:1989
 ntfs_fill_super+0x19a9/0x2bf0 fs/ntfs/super.c:2892
 mount_bdev+0x26c/0x3a0 fs/super.c:1359
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x88/0x270 fs/super.c:1489
 do_new_mount+0x289/0xad0 fs/namespace.c:3145
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3674
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc7b7d9644a
Code: 48 c7 c2 c0 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 08 01 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc447f93f8 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fc7b7d9644a
RDX: 0000000020000000 RSI: 000000002001ee80 RDI: 00007ffc447f9410
RBP: 00007ffc447f9410 R08: 00007ffc447f9450 R09: 000000000001ee3c
R10: 0000000000004010 R11: 0000000000000286 R12: 0000000000000004
R13: 00005555560972c0 R14: 0000000000004010 R15: 00007ffc447f9450
 </TASK>

The buggy address belongs to the physical page:
page:ffffea0001ff2d00 refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x7fcb4
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 ffffea0001cb9c08 ffffea0001ff64c8 0000000000000000
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x140cca(GFP_HIGHUSER_MOVABLE|__GFP_COMP), pid 4861, tgid 4861 (scp), ts 42437088117, free_ts 42604079701
 prep_new_page mm/page_alloc.c:2531 [inline]
 get_page_from_freelist+0x742/0x7c0 mm/page_alloc.c:4283
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5549
 __folio_alloc+0xf/0x30 mm/page_alloc.c:5581
 vma_alloc_folio+0x660/0xb60 mm/mempolicy.c:2247
 alloc_page_vma include/linux/gfp.h:284 [inline]
 do_cow_fault+0xa3/0x5d0 mm/memory.c:4533
 do_fault mm/memory.c:4645 [inline]
 handle_pte_fault mm/memory.c:4931 [inline]
 __handle_mm_fault mm/memory.c:5073 [inline]
 handle_mm_fault+0x189d/0x26b0 mm/memory.c:5219
 do_user_addr_fault+0x69b/0xcb0 arch/x86/mm/fault.c:1428
 handle_page_fault arch/x86/mm/fault.c:1519 [inline]
 exc_page_fault+0x7a/0x110 arch/x86/mm/fault.c:1575
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1446 [inline]
 free_pcp_prepare+0x751/0x780 mm/page_alloc.c:1496
 free_unref_page_prepare mm/page_alloc.c:3369 [inline]
 free_unref_page_list+0xb2/0x830 mm/page_alloc.c:3510
 release_pages+0x233e/0x25e0 mm/swap.c:1076
 tlb_batch_pages_flush mm/mmu_gather.c:97 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:292 [inline]
 tlb_flush_mmu+0x860/0xa80 mm/mmu_gather.c:299
 tlb_finish_mmu+0xcd/0x200 mm/mmu_gather.c:391
 exit_mmap+0x275/0x630 mm/mmap.c:3096
 __mmput+0x114/0x3b0 kernel/fork.c:1207
 exit_mm+0x1ec/0x2c0 kernel/exit.c:563
 do_exit+0x5c7/0x2150 kernel/exit.c:854
 do_group_exit+0x1fd/0x2b0 kernel/exit.c:1012
 __do_sys_exit_group kernel/exit.c:1023 [inline]
 __se_sys_exit_group kernel/exit.c:1021 [inline]
 __x64_sys_exit_group+0x3b/0x40 kernel/exit.c:1021
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88807fcb4a80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88807fcb4b00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff88807fcb4b80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff88807fcb4c00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88807fcb4c80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
