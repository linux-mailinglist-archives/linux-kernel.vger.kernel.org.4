Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6154B65B75C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 22:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbjABVUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 16:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjABVUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 16:20:46 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D619E2BF2
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 13:20:44 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id s22-20020a6bdc16000000b006e2d7c78010so8008260ioc.21
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 13:20:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VKni3axtbNsIaOYSfvcxB01yYn9jHVhRlG8S6Dkom8M=;
        b=dFZEcOU09PvRXS7UA6tfA0vELRCFpy8v6QZ+Pf7WPUISmhZxbn2Qhy6o9KI/JIiYD1
         OmA1pImCp+ug1sKRRGK6xDeK7npi6LuHVQRc8AHQLRfeJcIcoCDtjCx3mVc50nJwehxQ
         GG8N/KJ44RZaLOp8ctRRfbvnE1TBm+1QtZh0Dzde0WPA/PLpV9KQkFCxk9+y9+vhWie5
         7xw0eHej4MbeGUwdXCkJHdNrH7DML5K0Yw4S7ZHNpquWiYaJxAlvkshR4ar8Z1uqQcCX
         wn50z6KUci2vE+kgmd1qdo5JLVYcJ7j7PnP5F4ggJ11d7UEJwVLPdnc+WMqz19zdr1kh
         d8sw==
X-Gm-Message-State: AFqh2koJIy2mRAdf0bvQW+yfKBsbIYyvjXiP5HluwA0M4+E1C28seaj3
        +DdpIm0uoC0G9jjYeAwV3TjSVianW6n45U/M3/zJS+xiuJxL
X-Google-Smtp-Source: AMrXdXsJQmoTrqkC+H/AsL3a183ZPlchS9mHxsCv1cHB0vIhG52se79EkZSU3tefXroDh6OBg5KZo6DBDmAxr5zlMKZLpvNHslP6
MIME-Version: 1.0
X-Received: by 2002:a92:b10:0:b0:302:f72b:202b with SMTP id
 b16-20020a920b10000000b00302f72b202bmr4320239ilf.96.1672694444282; Mon, 02
 Jan 2023 13:20:44 -0800 (PST)
Date:   Mon, 02 Jan 2023 13:20:44 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002b5e2405f14e860f@google.com>
Subject: [syzbot] [gfs2?] KASAN: use-after-free Read in qd_unlock (2)
From:   syzbot <syzbot+3f6a670108ce43356017@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, rpeterso@redhat.com,
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
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1799c250480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=68e0be42c8ee4bb4
dashboard link: https://syzkaller.appspot.com/bug?extid=3f6a670108ce43356017
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14c4ea18480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1359b338480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2d8c5072480f/disk-1b929c02.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/46687f1395db/vmlinux-1b929c02.xz
kernel image: https://storage.googleapis.com/syzbot-assets/26f1afa5ec00/bzImage-1b929c02.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/35edd581b491/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3f6a670108ce43356017@syzkaller.appspotmail.com

R10: 0000000000000000 R11: 0000000000000246 R12: 00007f2c431103d0
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>
==================================================================
BUG: KASAN: use-after-free in instrument_atomic_read include/linux/instrumented.h:72 [inline]
BUG: KASAN: use-after-free in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: use-after-free in qd_unlock+0x30/0x2d0 fs/gfs2/quota.c:490
Read of size 8 at addr ffff888073997090 by task syz-executor221/5069

CPU: 1 PID: 5069 Comm: syz-executor221 Not tainted 6.2.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
 print_address_description+0x74/0x340 mm/kasan/report.c:306
 print_report+0x107/0x1f0 mm/kasan/report.c:417
 kasan_report+0xcd/0x100 mm/kasan/report.c:517
 kasan_check_range+0x2a7/0x2e0 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:72 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 qd_unlock+0x30/0x2d0 fs/gfs2/quota.c:490
 gfs2_quota_sync+0x768/0x8b0 fs/gfs2/quota.c:1325
 gfs2_sync_fs+0x49/0xb0 fs/gfs2/super.c:650
 sync_filesystem+0xe8/0x220 fs/sync.c:56
 generic_shutdown_super+0x6b/0x310 fs/super.c:474
 kill_block_super+0x79/0xd0 fs/super.c:1386
 deactivate_locked_super+0xa7/0xf0 fs/super.c:332
 cleanup_mnt+0x494/0x520 fs/namespace.c:1291
 task_work_run+0x243/0x300 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x644/0x2150 kernel/exit.c:867
 do_group_exit+0x1fd/0x2b0 kernel/exit.c:1012
 __do_sys_exit_group kernel/exit.c:1023 [inline]
 __se_sys_exit_group kernel/exit.c:1021 [inline]
 __x64_sys_exit_group+0x3b/0x40 kernel/exit.c:1021
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f2c4308d0c9
Code: Unable to access opcode bytes at 0x7f2c4308d09f.
RSP: 002b:00007ffcdd2f81f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f2c431103d0 RCX: 00007f2c4308d0c9
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 0000000000000001 R08: ffffffffffffffc0 R09: 0000000000012550
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f2c431103d0
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>

Allocated by task 5069:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x3d/0x60 mm/kasan/common.c:52
 __kasan_slab_alloc+0x65/0x70 mm/kasan/common.c:325
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:761 [inline]
 slab_alloc_node mm/slub.c:3452 [inline]
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc+0x1b3/0x350 mm/slub.c:3476
 kmem_cache_zalloc include/linux/slab.h:710 [inline]
 qd_alloc+0x51/0x250 fs/gfs2/quota.c:216
 gfs2_quota_init+0x7c4/0x10e0 fs/gfs2/quota.c:1415
 gfs2_make_fs_rw+0x48e/0x590 fs/gfs2/super.c:153
 gfs2_fill_super+0x2357/0x2700 fs/gfs2/ops_fstype.c:1274
 get_tree_bdev+0x400/0x620 fs/super.c:1282
 gfs2_get_tree+0x50/0x210 fs/gfs2/ops_fstype.c:1330
 vfs_get_tree+0x88/0x270 fs/super.c:1489
 do_new_mount+0x289/0xad0 fs/namespace.c:3145
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3674
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 0:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x3d/0x60 mm/kasan/common.c:52
 kasan_save_free_info+0x27/0x40 mm/kasan/generic.c:518
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:177 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook+0x12e/0x1a0 mm/slub.c:1807
 slab_free mm/slub.c:3787 [inline]
 kmem_cache_free+0x94/0x1d0 mm/slub.c:3809
 rcu_do_batch kernel/rcu/tree.c:2246 [inline]
 rcu_core+0x9c1/0x1690 kernel/rcu/tree.c:2506
 __do_softirq+0x277/0x738 kernel/softirq.c:571

Last potentially related work creation:
 kasan_save_stack+0x2b/0x50 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xb0/0xc0 mm/kasan/generic.c:488
 __call_rcu_common kernel/rcu/tree.c:2755 [inline]
 call_rcu+0x163/0xa70 kernel/rcu/tree.c:2868
 gfs2_quota_cleanup+0x457/0x6b0 fs/gfs2/quota.c:1479
 gfs2_make_fs_ro+0x517/0x610 fs/gfs2/super.c:560
 signal_our_withdraw fs/gfs2/util.c:166 [inline]
 gfs2_withdraw+0x609/0x1540 fs/gfs2/util.c:351
 gfs2_dinode_in fs/gfs2/glops.c:460 [inline]
 gfs2_inode_refresh+0xb2d/0xf60 fs/gfs2/glops.c:480
 gfs2_instantiate+0x15e/0x220 fs/gfs2/glock.c:456
 gfs2_glock_holder_ready fs/gfs2/glock.c:1299 [inline]
 gfs2_glock_wait+0x1d9/0x2a0 fs/gfs2/glock.c:1319
 gfs2_glock_nq_init fs/gfs2/glock.h:262 [inline]
 do_sync+0x485/0xc80 fs/gfs2/quota.c:916
 gfs2_quota_sync+0x3da/0x8b0 fs/gfs2/quota.c:1318
 gfs2_sync_fs+0x49/0xb0 fs/gfs2/super.c:650
 sync_filesystem+0xe8/0x220 fs/sync.c:56
 generic_shutdown_super+0x6b/0x310 fs/super.c:474
 kill_block_super+0x79/0xd0 fs/super.c:1386
 deactivate_locked_super+0xa7/0xf0 fs/super.c:332
 cleanup_mnt+0x494/0x520 fs/namespace.c:1291
 task_work_run+0x243/0x300 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x644/0x2150 kernel/exit.c:867
 do_group_exit+0x1fd/0x2b0 kernel/exit.c:1012
 __do_sys_exit_group kernel/exit.c:1023 [inline]
 __se_sys_exit_group kernel/exit.c:1021 [inline]
 __x64_sys_exit_group+0x3b/0x40 kernel/exit.c:1021
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888073997000
 which belongs to the cache gfs2_quotad of size 272
The buggy address is located 144 bytes inside of
 272-byte region [ffff888073997000, ffff888073997110)

The buggy address belongs to the physical page:
page:ffffea0001ce65c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x73997
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffff8881461ae500 dead000000000122 0000000000000000
raw: 0000000000000000 00000000800c000c 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Reclaimable, gfp_mask 0x12c50(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_RECLAIMABLE), pid 5069, tgid 5069 (syz-executor221), ts 50927644511, free_ts 12661541703
 prep_new_page mm/page_alloc.c:2531 [inline]
 get_page_from_freelist+0x742/0x7c0 mm/page_alloc.c:4283
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5549
 alloc_slab_page+0xbd/0x190 mm/slub.c:1851
 allocate_slab+0x5e/0x3c0 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0x782/0xe20 mm/slub.c:3193
 __slab_alloc mm/slub.c:3292 [inline]
 __slab_alloc_node mm/slub.c:3345 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc+0x268/0x350 mm/slub.c:3476
 kmem_cache_zalloc include/linux/slab.h:710 [inline]
 qd_alloc+0x51/0x250 fs/gfs2/quota.c:216
 gfs2_quota_init+0x7c4/0x10e0 fs/gfs2/quota.c:1415
 gfs2_make_fs_rw+0x48e/0x590 fs/gfs2/super.c:153
 gfs2_fill_super+0x2357/0x2700 fs/gfs2/ops_fstype.c:1274
 get_tree_bdev+0x400/0x620 fs/super.c:1282
 gfs2_get_tree+0x50/0x210 fs/gfs2/ops_fstype.c:1330
 vfs_get_tree+0x88/0x270 fs/super.c:1489
 do_new_mount+0x289/0xad0 fs/namespace.c:3145
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3674
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1446 [inline]
 free_pcp_prepare+0x751/0x780 mm/page_alloc.c:1496
 free_unref_page_prepare mm/page_alloc.c:3369 [inline]
 free_unref_page+0x19/0x4c0 mm/page_alloc.c:3464
 free_contig_range+0xa3/0x160 mm/page_alloc.c:9485
 destroy_args+0xfe/0x940 mm/debug_vm_pgtable.c:998
 debug_vm_pgtable+0x43d/0x4a0 mm/debug_vm_pgtable.c:1318
 do_one_initcall+0x1d1/0x410 init/main.c:1306
 do_initcall_level+0x168/0x220 init/main.c:1379
 do_initcalls+0x43/0x90 init/main.c:1395
 kernel_init_freeable+0x428/0x5e0 init/main.c:1634
 kernel_init+0x19/0x2b0 init/main.c:1522
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Memory state around the buggy address:
 ffff888073996f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888073997000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888073997080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff888073997100: fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888073997180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
