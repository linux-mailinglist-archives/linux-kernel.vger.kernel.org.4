Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961C46386AC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 10:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiKYJtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 04:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiKYJsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:48:14 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935672D764
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 01:46:34 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id h20-20020a056e021d9400b00300581edaa5so2594517ila.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 01:46:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O4DGcGV2JrRZXaUOixoskVdfBL3gOdPW1qweVO1zLOI=;
        b=Iz0j0t4AjgLV77vy7aWT42VNA/m29YUlZYwAPgjTp5aGpW0XtAzD0Qo9oMoFYfxnzP
         rVYFB6CpQ41O51bQNeABkfLiTKwwgoACyLYNaaPRBLyUdgcVjXAXvWKhAFRM7mDnhkfE
         zRcMTiG/c93mpf/3sqeIKMz5XQtcDuiNsIaNK/X+FXa1ssBF+QQCZ5Pp4TZuSqutsDmz
         jka6755n3gBehIWd6Q+dWb39hwzONRW8EPFXVPS/s4TWtYvwroc6umjskivUAQwEK2I7
         g5WKJrX3JDLmn0v7anHl00BMtB64B3G42uBgEd1g0Jonp24fLhBNEUETPhHyIoKWu8dP
         nQLA==
X-Gm-Message-State: ANoB5pkvdlvVbOCK40aFvRplmYAVk1AY3jcCJh0GJY3CaMYrse3FUAlc
        Dct2hvMdXlazhx9RF8C4hgdurYmhvM3/HWWTf1SxFbCcMvyD
X-Google-Smtp-Source: AA0mqf7808ABF7EIhF6nXmCUmPVEc5WHZs0bQ9RSwxD1mSx4dwq+7GUluNRc+oQA/XXuwAnN7okq06jL2PQIaHmOgXpbGR9/xLb9
MIME-Version: 1.0
X-Received: by 2002:a02:c48a:0:b0:375:9796:17c1 with SMTP id
 t10-20020a02c48a000000b00375979617c1mr15850021jam.18.1669369593982; Fri, 25
 Nov 2022 01:46:33 -0800 (PST)
Date:   Fri, 25 Nov 2022 01:46:33 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a5f23f05ee4865cf@google.com>
Subject: [syzbot] KASAN: use-after-free Read in set_de_name_and_namelen
From:   syzbot <syzbot+3969ffae9388a369bab8@syzkaller.appspotmail.com>
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

HEAD commit:    c3eb11fbb826 Merge tag 'pci-v6.1-fixes-3' of git://git.ker..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15a7e1c9880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd
dashboard link: https://syzkaller.appspot.com/bug?extid=3969ffae9388a369bab8
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1615d7e5880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15f20981880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d81ac029767f/disk-c3eb11fb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b68346b5b73c/vmlinux-c3eb11fb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/410a61724587/bzImage-c3eb11fb.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/0b4c696f5585/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3969ffae9388a369bab8@syzkaller.appspotmail.com

REISERFS (device loop0): Using r5 hash to sort names
REISERFS (device loop0): Created .reiserfs_priv - reserved for xattr storage.
==================================================================
BUG: KASAN: use-after-free in strlen+0x56/0x60 lib/string.c:495
Read of size 1 at addr ffff8880700f09cc by task syz-executor399/3632

CPU: 0 PID: 3632 Comm: syz-executor399 Not tainted 6.1.0-rc6-syzkaller-00015-gc3eb11fbb826 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 print_address_description+0x74/0x340 mm/kasan/report.c:284
 print_report+0x107/0x1f0 mm/kasan/report.c:395
 kasan_report+0xcd/0x100 mm/kasan/report.c:495
 strlen+0x56/0x60 lib/string.c:495
 _Z16__fortify_strlenPKcU17pass_object_size1 include/linux/fortify-string.h:196 [inline]
 set_de_name_and_namelen+0x378/0x5c0 fs/reiserfs/namei.c:82
 search_by_entry_key+0x6ca/0xd20 fs/reiserfs/namei.c:172
 reiserfs_readdir_inode+0x235/0x1410 fs/reiserfs/dir.c:98
 iterate_dir+0x257/0x5f0
 __do_sys_getdents64 fs/readdir.c:369 [inline]
 __se_sys_getdents64+0x1db/0x4c0 fs/readdir.c:354
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fb4f3debec9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffed0b87788 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007fb4f3e5bed0 RCX: 00007fb4f3debec9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007ffed0b87798 R08: 0000000000000001 R09: 0000000000000001
R10: 00000000000010e3 R11: 0000000000000246 R12: 00007ffed0b877c0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

The buggy address belongs to the physical page:
page:ffffea0001c03c00 refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x700f0
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 ffffea0001c03c48 ffffea0001c03bc8 0000000000000000
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x8(__GFP_MOVABLE), pid 1, tgid 1 (swapper/0), ts 10266546633, free_ts 11631552401
 split_map_pages+0x25b/0x540 mm/compaction.c:97
 isolate_freepages_range+0x4ac/0x510 mm/compaction.c:735
 alloc_contig_range+0x6a9/0x980 mm/page_alloc.c:9371
 __alloc_contig_pages mm/page_alloc.c:9394 [inline]
 alloc_contig_pages+0x3c8/0x4e0 mm/page_alloc.c:9471
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
 free_contig_range+0xa3/0x160 mm/page_alloc.c:9493
 destroy_args+0xfe/0x935 mm/debug_vm_pgtable.c:1031
 debug_vm_pgtable+0x44d/0x4a6 mm/debug_vm_pgtable.c:1354
 do_one_initcall+0x1c9/0x400 init/main.c:1303
 do_initcall_level+0x168/0x218 init/main.c:1376
 do_initcalls+0x4b/0x8c init/main.c:1392
 kernel_init_freeable+0x428/0x5d5 init/main.c:1631
 kernel_init+0x19/0x2b0 init/main.c:1519
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

Memory state around the buggy address:
 ffff8880700f0880: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8880700f0900: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff8880700f0980: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                              ^
 ffff8880700f0a00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8880700f0a80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
