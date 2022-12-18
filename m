Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFD9650497
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 21:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbiLRUA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 15:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLRUAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 15:00:54 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BF4E92
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 12:00:51 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id b77-20020a6bb250000000b006e4ec8b2364so3200877iof.20
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 12:00:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xeus3T5epXv9Mt6EHJymunfHd7TSRPvJPIgdBM+soXc=;
        b=fKvpwYzpxKk3BeDwgv449yB436qJS2qR3DLMk5ey6/YNmtaxmUUWdcCs21lgN+Q4TI
         cgS7SC4VgLrx3YM87hr8XQDG4ZSufc2wh3kYDEUZQGbGzP/i4CuLxs/YKcrEzwUCmD7r
         VSzzTJf5hq3I5w4uEM7nf1c1yUhCvScyG2sgLWPokMFrqBvCPz2T/pSwkjaIWo9pqjwk
         +Q7PVAVl4D3DYhWqj456OuxquiUxLn0gY1Ealr8CEwfF9Nw1xUPoCJrlrLq9bm4Osik6
         C0N6zKJVzoSacseUzJ/2bBwniTLhaD5x4bF6T7oSGSUg4AAgQjBx726DemCRyubF4QE6
         UpCQ==
X-Gm-Message-State: ANoB5pkEjgLZKB0gBZg7oZ1+y31z3e2C9zXkge+7BM2uA7FhulWtHIRp
        Nn1gd+mu2j9Ym0UCuDFTjJMbZ1uRthcttBdfoSu4bgtgc9X8
X-Google-Smtp-Source: AA0mqf423iFsZL6kEJMKqSWufteXl5gZZEFwChmqwo2UExHkBz4kJhcSDAZt2NE7hQBKLA95LAPaOxI1UUyulML+18DKWV5cFsk0
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1446:b0:38a:89cc:20bc with SMTP id
 l6-20020a056638144600b0038a89cc20bcmr3519935jad.249.1671393650927; Sun, 18
 Dec 2022 12:00:50 -0800 (PST)
Date:   Sun, 18 Dec 2022 12:00:50 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d7eced05f01fa8d0@google.com>
Subject: [syzbot] KASAN: slab-out-of-bounds Read in mi_find_attr
From:   syzbot <syzbot+8ebb469b64740648f1c3@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
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

HEAD commit:    e2ca6ba6ba01 Merge tag 'mm-stable-2022-12-13' of git://git..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=166d20b3880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a6133b41a9a0f500
dashboard link: https://syzkaller.appspot.com/bug?extid=8ebb469b64740648f1c3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16fb2ad0480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164513e0480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/be256841c209/disk-e2ca6ba6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/76c90a4cdade/vmlinux-e2ca6ba6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a44766da5515/bzImage-e2ca6ba6.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/cee764636128/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8ebb469b64740648f1c3@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 4096
ntfs3: loop0: Different NTFS' sector size (2048) and media sector size (512)
==================================================================
BUG: KASAN: slab-out-of-bounds in memcmp+0x1a4/0x1c0 lib/string.c:776
Read of size 1 at addr ffff888017c71e20 by task syz-executor165/5298

CPU: 1 PID: 5298 Comm: syz-executor165 Not tainted 6.1.0-syzkaller-09941-ge2ca6ba6ba01 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:306 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:417
 kasan_report+0xbf/0x1f0 mm/kasan/report.c:517
 memcmp+0x1a4/0x1c0 lib/string.c:776
 memcmp include/linux/fortify-string.h:549 [inline]
 mi_find_attr+0x153/0x240 fs/ntfs3/record.c:310
 ni_find_attr+0x309/0x630 fs/ntfs3/frecord.c:202
 ntfs_objid_init+0xc3/0x220 fs/ntfs3/fsntfs.c:2281
 ntfs_fill_super+0x31fd/0x3860 fs/ntfs3/super.c:1253
 get_tree_bdev+0x444/0x760 fs/super.c:1282
 vfs_get_tree+0x8d/0x2f0 fs/super.c:1489
 do_new_mount fs/namespace.c:3145 [inline]
 path_mount+0x132a/0x1e20 fs/namespace.c:3475
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount fs/namespace.c:3674 [inline]
 __x64_sys_mount+0x283/0x300 fs/namespace.c:3674
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fbeed785bba
Code: 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcfc3614c8 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fbeed785bba
RDX: 000000002001f340 RSI: 000000002001f380 RDI: 00007ffcfc3614e0
RBP: 00007ffcfc3614e0 R08: 00007ffcfc361520 R09: 000000000001f365
R10: 0000000000000000 R11: 0000000000000286 R12: 0000000000000004
R13: 00005555561362c0 R14: 0000000000000000 R15: 00007ffcfc361520
 </TASK>

Allocated by task 4878:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:371 [inline]
 ____kasan_kmalloc mm/kasan/common.c:330 [inline]
 __kasan_kmalloc+0xa5/0xb0 mm/kasan/common.c:380
 kmalloc include/linux/slab.h:580 [inline]
 rtnl_newlink+0x4a/0xa0 net/core/rtnetlink.c:3633
 rtnetlink_rcv_msg+0x43e/0xca0 net/core/rtnetlink.c:6141
 netlink_rcv_skb+0x165/0x440 net/netlink/af_netlink.c:2564
 netlink_unicast_kernel net/netlink/af_netlink.c:1330 [inline]
 netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1356
 netlink_sendmsg+0x91b/0xe10 net/netlink/af_netlink.c:1932
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg+0xd3/0x120 net/socket.c:734
 ____sys_sendmsg+0x712/0x8c0 net/socket.c:2476
 ___sys_sendmsg+0x110/0x1b0 net/socket.c:2530
 __sys_sendmsg+0xf7/0x1c0 net/socket.c:2559
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888017c71000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1568 bytes to the right of
 2048-byte region [ffff888017c71000, ffff888017c71800)

The buggy address belongs to the physical page:
page:ffffea00005f1c00 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888017c76000 pfn:0x17c70
head:ffffea00005f1c00 order:3 compound_mapcount:0 subpages_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffff888012442000 ffffea00005e9600 dead000000000002
raw: ffff888017c76000 0000000080080004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 2110375920, free_ts 0
 prep_new_page mm/page_alloc.c:2531 [inline]
 get_page_from_freelist+0x119c/0x2ce0 mm/page_alloc.c:4283
 __alloc_pages+0x1cb/0x5b0 mm/page_alloc.c:5549
 alloc_page_interleave+0x1e/0x200 mm/mempolicy.c:2118
 alloc_pages+0x233/0x270 mm/mempolicy.c:2280
 alloc_slab_page mm/slub.c:1851 [inline]
 allocate_slab+0x25f/0x350 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3193
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3292
 __slab_alloc_node mm/slub.c:3345 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 __kmem_cache_alloc_node+0x1a4/0x430 mm/slub.c:3491
 kmalloc_trace+0x26/0x60 mm/slab_common.c:1062
 kmalloc include/linux/slab.h:580 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 acpi_os_allocate_zeroed include/acpi/platform/aclinuxex.h:57 [inline]
 acpi_ds_create_walk_state+0x8c/0x203 drivers/acpi/acpica/dswstate.c:518
 acpi_ps_execute_method+0x1a1/0x620 drivers/acpi/acpica/psxface.c:134
 acpi_ns_evaluate+0x6d4/0x973 drivers/acpi/acpica/nseval.c:205
 acpi_ut_evaluate_object+0xf5/0x3fa drivers/acpi/acpica/uteval.c:60
 acpi_ut_execute_STA+0x86/0x17f drivers/acpi/acpica/uteval.c:223
 acpi_ns_get_device_callback drivers/acpi/acpica/nsxfeval.c:723 [inline]
 acpi_ns_get_device_callback+0x123/0x415 drivers/acpi/acpica/nsxfeval.c:635
 acpi_ns_walk_namespace+0x250/0x432 drivers/acpi/acpica/nswalk.c:240
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888017c71d00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888017c71d80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888017c71e00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                               ^
 ffff888017c71e80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888017c71f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
