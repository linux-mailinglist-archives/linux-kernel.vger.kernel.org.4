Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FD46425A5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 10:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbiLEJUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 04:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbiLEJTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 04:19:41 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A2B12764
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 01:19:39 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id o10-20020a056e02102a00b003006328df7bso11785379ilj.17
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 01:19:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p+3UyaPir9nm9ZFzBR9VLd7x63HnrUGtAaSPQspoqLw=;
        b=MI3cc8PwUj0Yu4R/lInEMKd4bN629xhkiHj3PIWgowGk0wOpzhAotBBSL3Y8pk9pss
         6PrhSzc2+OY75RFI9zIqfxNxfZR3wbpMZ7zmhuUnTqRyGhFyEymHbbK+mRXCSbOvSGTP
         +z8S4QCCUUw3Xs7hL/dcf49mJaULItannww7OvYmwfqU9oOivFsrZOREGxaIFNiAsJSc
         +UBu/RyApLOu3amjP4eucb4B0nM3LPhmxkvKWAY9rC2qThcpqfijXjdi0ed1h3X/jgSf
         xT+Paa+XB6bvSFe6srTHjaL5SGCmFJtwyul2E4URuI+lDfOZ4nWdWvudeZ/ZPVzMOJ8z
         King==
X-Gm-Message-State: ANoB5pnzEOUarBJvzaCFm7h50j8Bt9F2Ry2sq+XAiq3U92M2qPX633Ls
        V0gmM/Lz7ftwrzmi0HaXV53hUSv9l9uwngdXeAm2leg5rY77
X-Google-Smtp-Source: AA0mqf5Sr3Q/Xf/U4BK31WWtve8bzpdg+WVVBxZcVFNiGusSu3QrmaAsfCdtDXDpgE9xS6w/U/PrxrR0X9kGNvPedG465NeHBQIZ
MIME-Version: 1.0
X-Received: by 2002:a92:c844:0:b0:302:f785:c9a1 with SMTP id
 b4-20020a92c844000000b00302f785c9a1mr22534702ilq.165.1670231978600; Mon, 05
 Dec 2022 01:19:38 -0800 (PST)
Date:   Mon, 05 Dec 2022 01:19:38 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c6f44205ef112f5a@google.com>
Subject: [syzbot] KASAN: invalid-free in gadgetfs_kill_sb
From:   syzbot <syzbot+73a8d1eac3883b38173b@syzkaller.appspotmail.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org, hbh25y@gmail.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mingo@kernel.org, rdunlap@infradead.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    0966d385830d riscv: Fix auipc+jalr relocation range checks
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=146ed1d5880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6295d67591064921
dashboard link: https://syzkaller.appspot.com/bug?extid=73a8d1eac3883b38173b
compiler:       riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: riscv64

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+73a8d1eac3883b38173b@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: double-free or invalid-free in slab_free mm/slub.c:3509 [inline]
BUG: KASAN: double-free or invalid-free in kfree+0xe0/0x3e4 mm/slub.c:4562

CPU: 0 PID: 3915 Comm: syz-executor.1 Not tainted 5.17.0-rc1-syzkaller-00002-g0966d385830d #0
Hardware name: riscv-virtio,qemu (DT)
Call Trace:
[<ffffffff8000a228>] dump_backtrace+0x2e/0x3c arch/riscv/kernel/stacktrace.c:113
[<ffffffff831668cc>] show_stack+0x34/0x40 arch/riscv/kernel/stacktrace.c:119
[<ffffffff831756ba>] __dump_stack lib/dump_stack.c:88 [inline]
[<ffffffff831756ba>] dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:106
[<ffffffff8047479e>] print_address_description.constprop.0+0x2a/0x330 mm/kasan/report.c:255
[<ffffffff80474b98>] kasan_report_invalid_free+0x62/0x92 mm/kasan/report.c:381
[<ffffffff80473a82>] ____kasan_slab_free+0x170/0x180 mm/kasan/common.c:346
[<ffffffff80473fde>] __kasan_slab_free+0x10/0x18 mm/kasan/common.c:374
[<ffffffff80469750>] kasan_slab_free include/linux/kasan.h:236 [inline]
[<ffffffff80469750>] slab_free_hook mm/slub.c:1728 [inline]
[<ffffffff80469750>] slab_free_freelist_hook+0x8e/0x1cc mm/slub.c:1754
[<ffffffff8046d302>] slab_free mm/slub.c:3509 [inline]
[<ffffffff8046d302>] kfree+0xe0/0x3e4 mm/slub.c:4562
[<ffffffff81df6dae>] gadgetfs_kill_sb+0x56/0x68 drivers/usb/gadget/legacy/inode.c:2088
[<ffffffff804ce138>] deactivate_locked_super+0x9a/0x11a fs/super.c:332
[<ffffffff804cf982>] vfs_get_super fs/super.c:1160 [inline]
[<ffffffff804cf982>] get_tree_single+0x11e/0x12e fs/super.c:1177
[<ffffffff81df60f4>] gadgetfs_get_tree+0x26/0x30 drivers/usb/gadget/legacy/inode.c:2067
[<ffffffff804cc844>] vfs_get_tree+0x4a/0x19c fs/super.c:1497
[<ffffffff80522e36>] do_new_mount fs/namespace.c:2994 [inline]
[<ffffffff80522e36>] path_mount+0xe9c/0x14dc fs/namespace.c:3324
[<ffffffff80524014>] do_mount fs/namespace.c:3337 [inline]
[<ffffffff80524014>] __do_sys_mount fs/namespace.c:3545 [inline]
[<ffffffff80524014>] sys_mount+0x360/0x3ee fs/namespace.c:3522
[<ffffffff80005716>] ret_from_syscall+0x0/0x2

Allocated by task 2066:
 stack_trace_save+0xa6/0xd8 kernel/stacktrace.c:122
 kasan_save_stack+0x2c/0x58 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 ____kasan_kmalloc mm/kasan/common.c:515 [inline]
 ____kasan_kmalloc mm/kasan/common.c:474 [inline]
 __kasan_kmalloc+0x80/0xb2 mm/kasan/common.c:524
 kasan_kmalloc include/linux/kasan.h:270 [inline]
 kmem_cache_alloc_trace+0x178/0x2e0 mm/slub.c:3257
 kmalloc include/linux/slab.h:581 [inline]
 kzalloc include/linux/slab.h:715 [inline]
 apparmor_sk_alloc_security+0x70/0xca security/apparmor/lsm.c:792
 security_sk_alloc+0x48/0x90 security/security.c:2255
 sk_prot_alloc+0xb6/0x20e net/core/sock.c:1926
 sk_alloc+0x34/0x602 net/core/sock.c:1976
 inet_create net/ipv4/af_inet.c:319 [inline]
 inet_create+0x28c/0x964 net/ipv4/af_inet.c:245
 __sock_create+0x322/0x646 net/socket.c:1468
 sock_create net/socket.c:1519 [inline]
 __sys_socket+0xe4/0x1e0 net/socket.c:1561
 __do_sys_socket net/socket.c:1570 [inline]
 sys_socket+0x2c/0x3a net/socket.c:1568
 ret_from_syscall+0x0/0x2

Freed by task 3916:
 stack_trace_save+0xa6/0xd8 kernel/stacktrace.c:122
 kasan_save_stack+0x2c/0x58 mm/kasan/common.c:38
 kasan_set_track+0x1a/0x26 mm/kasan/common.c:45
 kasan_set_free_info+0x1e/0x3a mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free+0x15e/0x180 mm/kasan/common.c:328
 __kasan_slab_free+0x10/0x18 mm/kasan/common.c:374
 kasan_slab_free include/linux/kasan.h:236 [inline]
 slab_free_hook mm/slub.c:1728 [inline]
 slab_free_freelist_hook+0x8e/0x1cc mm/slub.c:1754
 slab_free mm/slub.c:3509 [inline]
 kfree+0xe0/0x3e4 mm/slub.c:4562
 gadgetfs_kill_sb+0x56/0x68 drivers/usb/gadget/legacy/inode.c:2088
 deactivate_locked_super+0x9a/0x11a fs/super.c:332
 deactivate_super fs/super.c:363 [inline]
 deactivate_super+0x80/0x94 fs/super.c:359
 cleanup_mnt+0x220/0x2c0 fs/namespace.c:1143
 __cleanup_mnt+0x1c/0x26 fs/namespace.c:1150
 task_work_run+0xdc/0x154 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 do_notify_resume+0x894/0xa56 arch/riscv/kernel/signal.c:320
 ret_from_exception+0x0/0x10

Last potentially related work creation:
 stack_trace_save+0xa6/0xd8 kernel/stacktrace.c:122
 kasan_save_stack+0x2c/0x58 mm/kasan/common.c:38
 __kasan_record_aux_stack+0xc4/0xdc mm/kasan/generic.c:348
 kasan_record_aux_stack_noalloc+0xe/0x16 mm/kasan/generic.c:358
 kvfree_call_rcu+0x8e/0x440 kernel/rcu/tree.c:3591
 memcg_update_list_lru_node mm/list_lru.c:411 [inline]
 memcg_update_list_lru mm/list_lru.c:467 [inline]
 memcg_update_all_list_lrus+0x2d0/0x5c6 mm/list_lru.c:501
 memcg_alloc_cache_id mm/memcontrol.c:2964 [inline]
 memcg_online_kmem mm/memcontrol.c:3635 [inline]
 mem_cgroup_css_alloc+0xa86/0xc60 mm/memcontrol.c:5225
 css_create kernel/cgroup/cgroup.c:5299 [inline]
 cgroup_apply_control_enable+0x2c0/0x654 kernel/cgroup/cgroup.c:3124
 cgroup_mkdir+0x388/0x9e6 kernel/cgroup/cgroup.c:5517
 kernfs_iop_mkdir+0xc8/0xfa fs/kernfs/dir.c:1169
 vfs_mkdir+0x110/0x202 fs/namei.c:3933
 do_mkdirat+0x22e/0x262 fs/namei.c:3959
 __do_sys_mkdirat fs/namei.c:3974 [inline]
 sys_mkdirat+0x88/0xb2 fs/namei.c:3972
 ret_from_syscall+0x0/0x2

The buggy address belongs to the object at ffffaf80072eb0e0
 which belongs to the cache kmalloc-16 of size 16
The buggy address is located 0 bytes inside of
 16-byte region [ffffaf80072eb0e0, ffffaf80072eb0f0)
The buggy address belongs to the page:
page:ffffaf807a84e218 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x874eb
flags: 0x8000000200(slab|section=16|node=0|zone=0)
raw: 0000008000000200 0000000000000100 0000000000000122 ffffaf80072013c0
raw: 0000000000000000 0000000080800080 00000001ffffffff 0000000000000000
raw: 00000000000007ff
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x0(), pid 1, ts 1244986300, free_ts 0
 stack_trace_save+0xa6/0xd8 kernel/stacktrace.c:122
 create_dummy_stack mm/page_owner.c:59 [inline]
 register_early_stack+0x8a/0xcc mm/page_owner.c:75
 init_page_owner+0x8a/0x5cc mm/page_owner.c:87
 invoke_init_callbacks mm/page_ext.c:112 [inline]
 page_ext_init+0x4e6/0x50c mm/page_ext.c:419
page_owner free stack trace missing

Memory state around the buggy address:
 ffffaf80072eaf80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffffaf80072eb000: 00 00 fc fc 00 00 fc fc 00 00 fc fc 00 01 fc fc
>ffffaf80072eb080: 00 07 fc fc 00 00 fc fc fa fb fc fc fa fb fc fc
                                                       ^
 ffffaf80072eb100: fb fb fc fc fb fb fc fc 00 00 fc fc 00 00 fc fc
 ffffaf80072eb180: 00 04 fc fc 00 01 fc fc fa fb fc fc fb fb fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
