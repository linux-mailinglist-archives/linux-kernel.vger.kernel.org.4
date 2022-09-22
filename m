Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510375E6FED
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 00:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiIVWqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 18:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiIVWqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 18:46:40 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA70F277F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 15:46:39 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id l18-20020a056e02067200b002f6af976994so1932498ilt.16
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 15:46:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=DstbwuRbU9Zs5mZ8iPhqCuzdcXoC67eAx2pXtIDC/MA=;
        b=h3X5eQFLhdHMcvVfPPpj/tt53urlkcWE25spc1bRM3BKWTZ5jxeRwN1yf/ma5gm5GP
         bIAH28QGTDSW36Qc5riZBPBI3r36zaSEjf9W4n/Su7/8HSfVR5LVkcGq2iIsWUizxIjM
         bpbIrnz26VywL06dN7FttT11X6oLlK1oLV99HhNzUDs5FPNlfv4HdNsMyydlNbTB7Lq7
         CMHpBlBlethCsHK2K97aAeUQWFdJjD3pQc5/fmcksz74gyxD/eJ2fUyshwighhGAFIRh
         fsDTlZI1AGdwIarnYxipjvCqkEyQwgVZQ/ZJfwYlHQLoprBb3qSkJUer+rX8Qs8xJQU/
         8MyA==
X-Gm-Message-State: ACrzQf0Sq/AdsChhgNdbtU/ml5yww8UFqt2o+4sTvbBXYbwXwBvVgwKT
        4zYqu668BdgdRUpLmcCaWuwLl+s3ntVpo5XOH+bT2HHCzHF+
X-Google-Smtp-Source: AMsMyM6WwhA8yqOdf1QF+8Ykr3OdsTH0qoCnUC3BI6S5NcP0cCU0e+9PeV3sqDsWoL5lVospjISWHFRKS+rZUlxoFaLYMp++YNWY
MIME-Version: 1.0
X-Received: by 2002:a02:cd19:0:b0:356:75ad:bdb9 with SMTP id
 g25-20020a02cd19000000b0035675adbdb9mr3209860jaq.161.1663886798438; Thu, 22
 Sep 2022 15:46:38 -0700 (PDT)
Date:   Thu, 22 Sep 2022 15:46:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009145fc05e94bd5c3@google.com>
Subject: [syzbot] KASAN: slab-out-of-bounds Read in run_unpack
From:   syzbot <syzbot+8d6fbb27a6aded64b25b@syzkaller.appspotmail.com>
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

HEAD commit:    38eddeedbbea Merge tag 'io_uring-6.0-2022-09-18' of git://..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=144e5144880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98a30118ec9215e9
dashboard link: https://syzkaller.appspot.com/bug?extid=8d6fbb27a6aded64b25b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13cee66f080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10fa23bf080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8d6fbb27a6aded64b25b@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 4119
ntfs3: loop0: Different NTFS' sector size (2048) and media sector size (512)
==================================================================
BUG: KASAN: slab-out-of-bounds in run_unpack+0x8b7/0x970 fs/ntfs3/run.c:944
Read of size 1 at addr ffff88801bbdff02 by task syz-executor131/3611

CPU: 0 PID: 3611 Comm: syz-executor131 Not tainted 6.0.0-rc5-syzkaller-00097-g38eddeedbbea #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:317 [inline]
 print_report.cold+0x2ba/0x719 mm/kasan/report.c:433
 kasan_report+0xb1/0x1e0 mm/kasan/report.c:495
 run_unpack+0x8b7/0x970 fs/ntfs3/run.c:944
 run_unpack_ex+0xb0/0x7c0 fs/ntfs3/run.c:1057
 ntfs_read_mft fs/ntfs3/inode.c:368 [inline]
 ntfs_iget5+0xc20/0x3280 fs/ntfs3/inode.c:501
 ntfs_loadlog_and_replay+0x124/0x5d0 fs/ntfs3/fsntfs.c:272
 ntfs_fill_super+0x1eff/0x37f0 fs/ntfs3/super.c:1018
 get_tree_bdev+0x440/0x760 fs/super.c:1323
 vfs_get_tree+0x89/0x2f0 fs/super.c:1530
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1326/0x1e20 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f94002c539a
Code: 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff9faa50f8 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fff9faa5150 RCX: 00007f94002c539a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007fff9faa5110
RBP: 00007fff9faa5110 R08: 00007fff9faa5150 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000286 R12: 0000000020000338
R13: 0000000000000003 R14: 0000000000000004 R15: 000000000000000d
 </TASK>

Allocated by task 3184:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:437 [inline]
 ____kasan_kmalloc mm/kasan/common.c:516 [inline]
 ____kasan_kmalloc mm/kasan/common.c:475 [inline]
 __kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:525
 kmalloc include/linux/slab.h:600 [inline]
 rtnl_newlink+0x46/0xa0 net/core/rtnetlink.c:3589
 rtnetlink_rcv_msg+0x43a/0xca0 net/core/rtnetlink.c:6090
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2501
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x543/0x7f0 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x917/0xe10 net/netlink/af_netlink.c:1921
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:734
 ____sys_sendmsg+0x6eb/0x810 net/socket.c:2482
 ___sys_sendmsg+0x110/0x1b0 net/socket.c:2536
 __sys_sendmsg+0xf3/0x1c0 net/socket.c:2565
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88801bbdf000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1794 bytes to the right of
 2048-byte region [ffff88801bbdf000, ffff88801bbdf800)

The buggy address belongs to the physical page:
page:ffffea00006ef600 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1bbd8
head:ffffea00006ef600 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffffea00005da800 dead000000000002 ffff888011842000
raw: 0000000000000000 0000000080080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 5567869789, free_ts 0
 prep_new_page mm/page_alloc.c:2532 [inline]
 get_page_from_freelist+0x109b/0x2ce0 mm/page_alloc.c:4283
 __alloc_pages+0x1c7/0x510 mm/page_alloc.c:5515
 alloc_page_interleave+0x1e/0x200 mm/mempolicy.c:2103
 alloc_pages+0x22f/0x270 mm/mempolicy.c:2265
 alloc_slab_page mm/slub.c:1824 [inline]
 allocate_slab+0x27e/0x3d0 mm/slub.c:1969
 new_slab mm/slub.c:2029 [inline]
 ___slab_alloc+0x7f1/0xe10 mm/slub.c:3031
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3118
 slab_alloc_node mm/slub.c:3209 [inline]
 slab_alloc mm/slub.c:3251 [inline]
 kmem_cache_alloc_trace+0x323/0x3e0 mm/slub.c:3282
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 virtio_pci_probe+0x44/0x410 drivers/virtio/virtio_pci_common.c:524
 local_pci_probe+0xe1/0x1a0 drivers/pci/pci-driver.c:324
 pci_call_probe drivers/pci/pci-driver.c:392 [inline]
 __pci_device_probe drivers/pci/pci-driver.c:417 [inline]
 pci_device_probe+0x298/0x740 drivers/pci/pci-driver.c:460
 call_driver_probe drivers/base/dd.c:560 [inline]
 really_probe+0x249/0xb90 drivers/base/dd.c:639
 __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:778
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:808
 __driver_attach+0x1d0/0x550 drivers/base/dd.c:1190
 bus_for_each_dev+0x147/0x1d0 drivers/base/bus.c:301
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88801bbdfe00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88801bbdfe80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88801bbdff00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                   ^
 ffff88801bbdff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88801bbe0000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
