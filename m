Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782DB63BDD4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 11:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiK2KWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 05:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiK2KWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 05:22:38 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6624D2607
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 02:22:36 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id s4-20020a056e02216400b003021b648144so11760950ilv.19
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 02:22:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GA6l39pwMHvbesuG/VFZ+s4bAsg0EvTAmkvrA7cGi4U=;
        b=qp0s0zi9oxjIagTjOhz6a/pXHHTfnxS/CSA8/qSyhgpC7ohSxUW28S+4CN9fVto2+5
         G3gwnNI/qWTTIYYaGX6BjDqyh8HjY2ve2ejJoGuwiVL3PNXD94156p7cBNmGHVo2x7l3
         TntmnF3rwJJW8yLENvsjGkif02y+73Yog8YZMReujzWkPg+kRfq8QvfosdTMfxF+5qr6
         C+Nza9F6UM8TZSl93dFTgYo7qQ71zQ6L+AqMoK666j5+Csl/CA7NtC+OUw6ZmvwQACcO
         343VSqK2T9YlKNFmz/1S7vDAd2p02YLns7w6dUVddXgu1vud4NzmQx7kJCcnb5iYco3S
         nAKg==
X-Gm-Message-State: ANoB5pnJhvKzeHNLHQSO6K7pLq1EjbfdaA7pzgxf8BXkoq3dTpO4yvmB
        qvYn2fWX4d4ByYxFsqwEkWURCK/WylDFu6ZpqTJFdZTUt/XQ
X-Google-Smtp-Source: AA0mqf42HBCuckU/9ePEYCoH3zxpDowXlKlOqjhJ8vAYo25WgA5/fbV1oMq7fzDt/cPJmm548/0CmYnXaN3xE1LyaDCGNvDxyPoF
MIME-Version: 1.0
X-Received: by 2002:a5d:980d:0:b0:6a0:ee21:53fb with SMTP id
 a13-20020a5d980d000000b006a0ee2153fbmr17098479iol.190.1669717355768; Tue, 29
 Nov 2022 02:22:35 -0800 (PST)
Date:   Tue, 29 Nov 2022 02:22:35 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ddb17905ee995d32@google.com>
Subject: [syzbot] KASAN: use-after-free Read in reiserfs_release_objectid
From:   syzbot <syzbot+909a2191a4352fd77d25@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
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

HEAD commit:    ca57f02295f1 afs: Fix fileserver probe RTT handling
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=166cc703880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2325e409a9a893e1
dashboard link: https://syzkaller.appspot.com/bug?extid=909a2191a4352fd77d25
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1563673d880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=134d9425880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/af66f1d3a389/disk-ca57f022.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c0c7ec393108/vmlinux-ca57f022.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ea8871940eaa/bzImage-ca57f022.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a53b54c6bf3b/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+909a2191a4352fd77d25@syzkaller.appspotmail.com

REISERFS (device loop0): checking transaction log (loop0)
REISERFS (device loop0): Using r5 hash to sort names
REISERFS (device loop0): Created .reiserfs_priv - reserved for xattr storage.
==================================================================
BUG: KASAN: use-after-free in reiserfs_release_objectid+0x528/0x7c0 fs/reiserfs/objectid.c:165
Read of size 14568 at addr ffff8880737890d0 by task syz-executor198/3632

CPU: 1 PID: 3632 Comm: syz-executor198 Not tainted 6.1.0-rc7-syzkaller-00012-gca57f02295f1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 print_address_description+0x74/0x340 mm/kasan/report.c:284
 print_report+0x107/0x1f0 mm/kasan/report.c:395
 kasan_report+0xcd/0x100 mm/kasan/report.c:495
 kasan_check_range+0x2a7/0x2e0 mm/kasan/generic.c:189
 memmove+0x25/0x60 mm/kasan/shadow.c:54
 reiserfs_release_objectid+0x528/0x7c0 fs/reiserfs/objectid.c:165
 remove_save_link+0x2f6/0x4a0 fs/reiserfs/super.c:542
 reiserfs_evict_inode+0x35a/0x460 fs/reiserfs/inode.c:91
 evict+0x2a4/0x620 fs/inode.c:664
 __dentry_kill+0x3b1/0x5b0 fs/dcache.c:607
 dentry_kill+0xbb/0x290
 dput+0x1f3/0x410 fs/dcache.c:913
 do_renameat2+0xb60/0x1370 fs/namei.c:4932
 __do_sys_rename fs/namei.c:4976 [inline]
 __se_sys_rename fs/namei.c:4974 [inline]
 __x64_sys_rename+0x82/0x90 fs/namei.c:4974
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4da5b02e99
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdba5119c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007ffdba511ba8 RCX: 00007f4da5b02e99
RDX: 00007f4da5b02e99 RSI: 0000000020000200 RDI: 0000000020000140
RBP: 0000000000000000 R08: 00007ffdba511a30 R09: 00007ffdba511a30
R10: 00007ffdba511a30 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffdba511a30 R14: 00007ffdba511a10 R15: 0000000000000000
 </TASK>

The buggy address belongs to the physical page:
page:ffffea0001cde240 refcount:2 mapcount:0 mapping:ffff888012c275f8 index:0x10 pfn:0x73789
memcg:ffff888140150000
aops:def_blk_aops ino:700000
flags: 0xfff00000022036(referenced|uptodate|lru|active|private|mappedtodisk|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000022036 ffffea0001ccdf88 ffffea0001cd8cc8 ffff888012c275f8
raw: 0000000000000010 ffff888072933cb0 00000002ffffffff ffff888140150000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Movable, gfp_mask 0x148c48(GFP_NOFS|__GFP_NOFAIL|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE), pid 3632, tgid 3632 (syz-executor198), ts 54744108099, free_ts 54728652923
 prep_new_page mm/page_alloc.c:2539 [inline]
 get_page_from_freelist+0x742/0x7c0 mm/page_alloc.c:4291
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5558
 folio_alloc+0x1a/0x50 mm/mempolicy.c:2295
 filemap_alloc_folio+0x7e/0x1c0 mm/filemap.c:971
 __filemap_get_folio+0x898/0x1260 mm/filemap.c:1965
 pagecache_get_page+0x28/0x260 mm/folio-compat.c:110
 find_or_create_page include/linux/pagemap.h:613 [inline]
 grow_dev_page+0xba/0x920 fs/buffer.c:946
 grow_buffers fs/buffer.c:1011 [inline]
 __getblk_slow fs/buffer.c:1038 [inline]
 __getblk_gfp+0x16c/0x290 fs/buffer.c:1333
 __bread_gfp+0x28/0x320 fs/buffer.c:1367
 sb_bread include/linux/buffer_head.h:338 [inline]
 read_super_block+0x93/0x820 fs/reiserfs/super.c:1604
 reiserfs_fill_super+0x7ff/0x24a0 fs/reiserfs/super.c:1966
 mount_bdev+0x26c/0x3a0 fs/super.c:1401
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x88/0x270 fs/super.c:1531
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1459 [inline]
 free_pcp_prepare+0x80c/0x8f0 mm/page_alloc.c:1509
 free_unref_page_prepare mm/page_alloc.c:3387 [inline]
 free_unref_page_list+0xb4/0x7b0 mm/page_alloc.c:3529
 release_pages+0x232a/0x25c0 mm/swap.c:1055
 tlb_batch_pages_flush mm/mmu_gather.c:59 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:256 [inline]
 tlb_flush_mmu+0x850/0xa70 mm/mmu_gather.c:263
 tlb_finish_mmu+0xcb/0x200 mm/mmu_gather.c:363
 unmap_region+0x2af/0x300 mm/mmap.c:2191
 do_mas_align_munmap+0xd18/0x14e0 mm/mmap.c:2444
 do_mas_munmap+0x245/0x2b0 mm/mmap.c:2502
 __vm_munmap+0x23c/0x340 mm/mmap.c:2779
 __do_sys_munmap mm/mmap.c:2804 [inline]
 __se_sys_munmap mm/mmap.c:2801 [inline]
 __x64_sys_munmap+0x5c/0x70 mm/mmap.c:2801
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88807378af00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88807378af80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88807378b000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff88807378b080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88807378b100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
