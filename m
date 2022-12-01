Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE0063F0DB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 13:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbiLAMtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 07:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiLAMtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 07:49:42 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C81992A22
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 04:49:41 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id t2-20020a6b6402000000b006dea34ad528so1483092iog.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 04:49:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RZveoZjGkmARbnhpw1myZ/t9BM4s+mPwNKve8eAbSuw=;
        b=tKpnuQV42DBpEjuQ8lbgPkrvsWzNJhLuM+/k87F7Q8pYyx/Br+xDZmpkfLYOMX3pMI
         aPxiR7n0GerGcuQeyft7PyUPnUuWKvYZzwlU0mnpartyvwxGwbA+xMEM+lxXojtx/T4a
         cwzNyw2V4sUHzQE7M0ZUzOMUULR31SuFrnKMP0EjCjKC8Od3d6QMkiIeuPfwUKtQzwzg
         Iu2l7R7yzpMQeELa2vD0VHZUIlb/LwEjgURoWJgaJP5ynbHcX8YFS7cLIQd8aRCEMOdL
         GaPr0MVT1FFds4+5Wel0e+q2Vc8RJk38ck82VMCl4v8SSCg/IV7R+YAbztpDDpHJraUl
         TJEg==
X-Gm-Message-State: ANoB5pn43V2DKImZvbSOp4maWLVbHe/9NS7vrqDUbyaELbBzQKN7s7VN
        BoP/pj67y5u+KiP25JydeHpUvdIHwXhJHL5f1tDCZcXf08WD
X-Google-Smtp-Source: AA0mqf7S/dtBzbfs7KhwNVYNFCW9vEBX60grUHFf0i6Wn7JjDN97HSYbMOZoYv/jIxItTYOEYg/Q65GsS5oSG7ODHBZQEY0Nmncl
MIME-Version: 1.0
X-Received: by 2002:a05:6602:4011:b0:6de:a999:203b with SMTP id
 bk17-20020a056602401100b006dea999203bmr27114113iob.144.1669898980696; Thu, 01
 Dec 2022 04:49:40 -0800 (PST)
Date:   Thu, 01 Dec 2022 04:49:40 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008e23d405eec3a7c4@google.com>
Subject: [syzbot] KASAN: use-after-free Read in sysv_new_block
From:   syzbot <syzbot+eda782c229b243c648e9@syzkaller.appspotmail.com>
To:     hch@infradead.org, linux-kernel@vger.kernel.org,
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

HEAD commit:    01f856ae6d0c Merge tag 'net-6.1-rc8-2' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15fddbc5880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2325e409a9a893e1
dashboard link: https://syzkaller.appspot.com/bug?extid=eda782c229b243c648e9
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=179d6e75880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=124b96a7880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5428d604f56a/disk-01f856ae.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e953d290d254/vmlinux-01f856ae.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3f71610a4904/bzImage-01f856ae.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/e2e13128a6e4/mount_1.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+eda782c229b243c648e9@syzkaller.appspotmail.com

sysv_free_block: flc_count > flc_size
sysv_free_block: flc_count > flc_size
sysv_free_block: flc_count > flc_size
sysv_free_block: flc_count > flc_size
sysv_free_block: flc_count > flc_size
sysv_free_block: flc_count > flc_size
sysv_free_block: flc_count > flc_size
sysv_free_block: flc_count > flc_size
sysv_free_block: flc_count > flc_size
sysv_free_block: flc_count > flc_size
==================================================================
BUG: KASAN: use-after-free in sysv_new_block+0x73f/0x910 fs/sysv/balloc.c:113
Read of size 4 at addr ffff8880712d60c8 by task syz-executor118/3633

CPU: 1 PID: 3633 Comm: syz-executor118 Not tainted 6.1.0-rc7-syzkaller-00101-g01f856ae6d0c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 print_address_description+0x74/0x340 mm/kasan/report.c:284
 print_report+0x107/0x1f0 mm/kasan/report.c:395
 kasan_report+0xcd/0x100 mm/kasan/report.c:495
 sysv_new_block+0x73f/0x910 fs/sysv/balloc.c:113
 alloc_branch fs/sysv/itree.c:134 [inline]
 get_block+0x2b5/0x16d0 fs/sysv/itree.c:251
 __block_write_begin_int+0x54c/0x1a80 fs/buffer.c:1991
 __block_write_begin fs/buffer.c:2041 [inline]
 block_write_begin+0x93/0x1e0 fs/buffer.c:2102
 sysv_write_begin+0x2d/0x60 fs/sysv/itree.c:485
 generic_perform_write+0x2e4/0x5e0 mm/filemap.c:3753
 __generic_file_write_iter+0x176/0x400 mm/filemap.c:3881
 generic_file_write_iter+0xab/0x310 mm/filemap.c:3913
 call_write_iter include/linux/fs.h:2199 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x7dc/0xc50 fs/read_write.c:584
 ksys_write+0x177/0x2a0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f3801c82ee9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 91 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffce2453d28 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f3801c82ee9
RDX: 00000000fffffd5e RSI: 000000002000ad00 RDI: 0000000000000004
RBP: 00007ffce2453e20 R08: 0000000000000031 R09: 0000000000000031
R10: 0000000000009e07 R11: 0000000000000246 R12: 0000000000000048
R13: 00007f3801d0c7e0 R14: 00007ffce2453d82 R15: 00007ffce2453df0
 </TASK>

The buggy address belongs to the physical page:
page:ffffea0001c4b580 refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x712d6
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 ffffea0001c4b5c8 ffffea0001c4b548 0000000000000000
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x8(__GFP_MOVABLE), pid 1, tgid 1 (swapper/0), ts 10227233924, free_ts 11569433830
 split_map_pages+0x25b/0x540 mm/compaction.c:97
 isolate_freepages_range+0x4ac/0x510 mm/compaction.c:735
 alloc_contig_range+0x6a9/0x980 mm/page_alloc.c:9374
 __alloc_contig_pages mm/page_alloc.c:9397 [inline]
 alloc_contig_pages+0x3c8/0x4e0 mm/page_alloc.c:9474
 debug_vm_pgtable_alloc_huge_page+0xcd/0x11e mm/debug_vm_pgtable.c:1098
 init_args+0xa3a/0xdba mm/debug_vm_pgtable.c:1221
 debug_vm_pgtable+0x9a/0x4a6 mm/debug_vm_pgtable.c:1259
 do_one_initcall+0x1c9/0x400 init/main.c:1303
 do_initcall_level+0x168/0x218 init/main.c:1376
 do_initcalls+0x4b/0x8c init/main.c:1392
 kernel_init_freeable+0x428/0x5d5 init/main.c:1631
 kernel_init+0x19/0x2b0 init/main.c:1519
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1459 [inline]
 free_pcp_prepare+0x80c/0x8f0 mm/page_alloc.c:1509
 free_unref_page_prepare mm/page_alloc.c:3387 [inline]
 free_unref_page+0x7d/0x5f0 mm/page_alloc.c:3483
 free_contig_range+0xa3/0x160 mm/page_alloc.c:9496
 destroy_args+0xfe/0x935 mm/debug_vm_pgtable.c:1031
 debug_vm_pgtable+0x44d/0x4a6 mm/debug_vm_pgtable.c:1354
 do_one_initcall+0x1c9/0x400 init/main.c:1303
 do_initcall_level+0x168/0x218 init/main.c:1376
 do_initcalls+0x4b/0x8c init/main.c:1392
 kernel_init_freeable+0x428/0x5d5 init/main.c:1631
 kernel_init+0x19/0x2b0 init/main.c:1519
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

Memory state around the buggy address:
 ffff8880712d5f80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8880712d6000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff8880712d6080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                              ^
 ffff8880712d6100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8880712d6180: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
