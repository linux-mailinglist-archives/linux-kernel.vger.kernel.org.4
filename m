Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2AC6F5FF6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 22:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjECUR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 16:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjECUR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 16:17:56 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E074B7EED
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 13:17:54 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-766588051b3so362324839f.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 13:17:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683145074; x=1685737074;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UZnrCENxmQD3F7VzOeWvVD7gKeafGra92jvnJZGj0o8=;
        b=FWwYeGlITdN8dSLqqRABkbhRWKkgK39R9D1ePKqI7JDWVafGlp2wYiqXFlOXSZuhXL
         2tIO+YLj34LHkO6oroTlLpU+lHW3Tpoe8kfOgCPJ0AEJGf7O0Y75mH85p2CbMLRxrCMy
         gCafvc5JwqvNKLDuAkEZe7rhF8jz+ijRbSzGNQqBI6eZQKsYNmFEnxo/6LakgFMQJe1A
         Yo0NqV17ADxFDxOs28sDFq/uImZrMozNEXMX+i7rJ91vS1Gp9cN8wB5Xq6PnRmp3z6UW
         2W4pcaf826fwXn/5EQnyGikYdu3KIs5FOznDAeRmWvfEGI9awEuozo8TrPrHUiAafeMG
         JEKw==
X-Gm-Message-State: AC+VfDwTVJky5HhdfpO5FbYsHE+yss+0ENRHN9Z7SZvTotsqmKgj+Yqf
        wFVl9ygjvfSfRxbhDfSuZDXoccQrFAigIX55rtjtJPl+UlbX
X-Google-Smtp-Source: ACHHUZ7rU3sFTw4U2t7ZI4lHDR2rIzyAivr0zscEHRFPrZs6ySLqVCkYOZOjjTzuhZ6cRi85AfNZ9VyK43WkTU/m2EGVtplwBNA7
MIME-Version: 1.0
X-Received: by 2002:a6b:ee17:0:b0:763:ad78:6b46 with SMTP id
 i23-20020a6bee17000000b00763ad786b46mr10997535ioh.3.1683145074248; Wed, 03
 May 2023 13:17:54 -0700 (PDT)
Date:   Wed, 03 May 2023 13:17:54 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000041926a05facfc0c1@google.com>
Subject: [syzbot] [kernel?] KASAN: slab-use-after-free Write in expire_timers
From:   syzbot <syzbot+7403ea5e821ac5a30b92@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    348551ddaf31 Merge tag 'pinctrl-v6.4-1' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=127eb988280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=35e09b26aabb80e5
dashboard link: https://syzkaller.appspot.com/bug?extid=7403ea5e821ac5a30b92
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7403ea5e821ac5a30b92@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __hlist_del include/linux/list.h:901 [inline]
BUG: KASAN: slab-use-after-free in detach_timer kernel/time/timer.c:880 [inline]
BUG: KASAN: slab-use-after-free in expire_timers+0x476/0x4b0 kernel/time/timer.c:1734
Write of size 8 at addr ffff888028d29500 by task syz-executor.3/13686

CPU: 2 PID: 13686 Comm: syz-executor.3 Not tainted 6.3.0-syzkaller-12728-g348551ddaf31 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:351
 print_report mm/kasan/report.c:462 [inline]
 kasan_report+0x11c/0x130 mm/kasan/report.c:572
 __hlist_del include/linux/list.h:901 [inline]
 detach_timer kernel/time/timer.c:880 [inline]
 expire_timers+0x476/0x4b0 kernel/time/timer.c:1734
 __run_timers kernel/time/timer.c:2022 [inline]
 __run_timers kernel/time/timer.c:1995 [inline]
 run_timer_softirq+0x326/0x910 kernel/time/timer.c:2035
 __do_softirq+0x1d4/0x905 kernel/softirq.c:571
 invoke_softirq kernel/softirq.c:445 [inline]
 __irq_exit_rcu+0x114/0x190 kernel/softirq.c:650
 irq_exit_rcu+0x9/0x20 kernel/softirq.c:662
 sysvec_apic_timer_interrupt+0x97/0xc0 arch/x86/kernel/apic/apic.c:1106
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:lock_acquire+0x1f5/0x520 kernel/locking/lockdep.c:5659
Code: 65 9d 7e 83 f8 01 0f 85 b9 02 00 00 9c 58 f6 c4 02 0f 85 a4 02 00 00 48 83 7c 24 08 00 74 01 fb 48 b8 00 00 00 00 00 fc ff df <48> 01 c3 48 c7 03 00 00 00 00 48 c7 43 08 00 00 00 00 48 8b 84 24
RSP: 0000:ffffc90003cbf220 EFLAGS: 00000206
RAX: dffffc0000000000 RBX: 1ffff92000797e46 RCX: ffffffff8164ca56
RDX: 1ffff11004149c18 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000000 R09: ffffffff9151dd17
R10: fffffbfff22a3ba2 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: ffffffff8c90a3e0 R15: 0000000000000000
 fs_reclaim_acquire mm/page_alloc.c:3901 [inline]
 fs_reclaim_acquire+0xda/0x160 mm/page_alloc.c:3892
 might_alloc include/linux/sched/mm.h:303 [inline]
 prepare_alloc_pages+0x159/0x570 mm/page_alloc.c:4530
 __alloc_pages+0x149/0x4a0 mm/page_alloc.c:4748
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2277
 folio_alloc+0x20/0x70 mm/mempolicy.c:2287
 filemap_alloc_folio+0x3c1/0x470 mm/filemap.c:976
 __filemap_get_folio+0x2a6/0x990 mm/filemap.c:1965
 pagecache_get_page+0x2e/0x270 mm/folio-compat.c:99
 find_or_create_page include/linux/pagemap.h:635 [inline]
 grow_dev_page fs/buffer.c:995 [inline]
 grow_buffers fs/buffer.c:1060 [inline]
 __getblk_slow+0x1f2/0x1230 fs/buffer.c:1087
 __getblk_gfp+0x72/0x80 fs/buffer.c:1382
 __getblk include/linux/buffer_head.h:420 [inline]
 reiserfs_breada+0x15f/0x470 fs/reiserfs/journal.c:2338
 journal_read fs/reiserfs/journal.c:2449 [inline]
 journal_init+0x23dd/0x64b0 fs/reiserfs/journal.c:2897
 reiserfs_fill_super+0xc5b/0x2eb0 fs/reiserfs/super.c:2022
 mount_bdev+0x357/0x420 fs/super.c:1380
 legacy_get_tree+0x109/0x220 fs/fs_context.c:610
 vfs_get_tree+0x8d/0x350 fs/super.c:1510
 do_new_mount fs/namespace.c:3039 [inline]
 path_mount+0x134b/0x1e40 fs/namespace.c:3369
 do_mount fs/namespace.c:3382 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x283/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc3ca28d69a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc3c8dfdf88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 000000000000ffb6 RCX: 00007fc3ca28d69a
RDX: 000000002000ffc0 RSI: 0000000020010000 RDI: 00007fc3c8dfdfe0
RBP: 00007fc3c8dfe020 R08: 00007fc3c8dfe020 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 000000002000ffc0
R13: 0000000020010000 R14: 00007fc3c8dfdfe0 R15: 0000000020010040
 </TASK>

Allocated by task 11731:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x7f/0x90 mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:711 [inline]
 slab_alloc_node mm/slab.c:3256 [inline]
 slab_alloc mm/slab.c:3265 [inline]
 __kmem_cache_alloc_lru mm/slab.c:3442 [inline]
 kmem_cache_alloc+0x1bd/0x3f0 mm/slab.c:3451
 getname_flags.part.0+0x50/0x4f0 fs/namei.c:140
 getname_flags include/linux/audit.h:321 [inline]
 getname+0x92/0xd0 fs/namei.c:219
 do_sys_openat2+0xf5/0x4c0 fs/open.c:1350
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __x64_sys_openat+0x143/0x1f0 fs/open.c:1383
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 11731:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:521
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x13b/0x1a0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:162 [inline]
 __cache_free mm/slab.c:3389 [inline]
 __do_kmem_cache_free mm/slab.c:3576 [inline]
 kmem_cache_free mm/slab.c:3601 [inline]
 kmem_cache_free+0x105/0x370 mm/slab.c:3594
 putname fs/namei.c:273 [inline]
 putname+0x102/0x140 fs/namei.c:259
 do_sys_openat2+0x153/0x4c0 fs/open.c:1365
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __x64_sys_openat+0x143/0x1f0 fs/open.c:1383
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888028d28b40
 which belongs to the cache names_cache of size 4096
The buggy address is located 2496 bytes inside of
 freed 4096-byte region [ffff888028d28b40, ffff888028d29b40)

The buggy address belongs to the physical page:
page:ffffea0000a34a00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x28d28
head:ffffea0000a34a00 order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0x1()
raw: 00fff00000010200 ffff888040059f00 ffffea0000a7a590 ffffea0000a24d10
raw: 0000000000000000 ffff888028d28b40 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0x2420c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_COMP|__GFP_THISNODE), pid 11731, tgid 11731 (udevd), ts 458697775213, free_ts 458620276328
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2db/0x350 mm/page_alloc.c:1722
 prep_new_page mm/page_alloc.c:1729 [inline]
 get_page_from_freelist+0xf41/0x2c00 mm/page_alloc.c:3493
 __alloc_pages_slowpath.constprop.0+0x2e7/0x2170 mm/page_alloc.c:4293
 __alloc_pages+0x408/0x4a0 mm/page_alloc.c:4772
 __alloc_pages_node include/linux/gfp.h:237 [inline]
 kmem_getpages mm/slab.c:1360 [inline]
 cache_grow_begin+0x9b/0x3b0 mm/slab.c:2569
 cache_alloc_refill+0x27f/0x380 mm/slab.c:2942
 ____cache_alloc mm/slab.c:3018 [inline]
 ____cache_alloc mm/slab.c:3001 [inline]
 __do_cache_alloc mm/slab.c:3201 [inline]
 slab_alloc_node mm/slab.c:3249 [inline]
 slab_alloc mm/slab.c:3265 [inline]
 __kmem_cache_alloc_lru mm/slab.c:3442 [inline]
 kmem_cache_alloc+0x397/0x3f0 mm/slab.c:3451
 getname_flags.part.0+0x50/0x4f0 fs/namei.c:140
 getname_flags include/linux/audit.h:321 [inline]
 getname+0x92/0xd0 fs/namei.c:219
 do_sys_openat2+0xf5/0x4c0 fs/open.c:1350
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __x64_sys_openat+0x143/0x1f0 fs/open.c:1383
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1302 [inline]
 free_unref_page_prepare+0x62e/0xcb0 mm/page_alloc.c:2555
 free_unref_page+0x33/0x370 mm/page_alloc.c:2650
 slab_destroy mm/slab.c:1612 [inline]
 drain_freelist.isra.0+0xdd/0x130 mm/slab.c:2205
 cache_reap+0x1bd/0x2e0 mm/slab.c:3870
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Memory state around the buggy address:
 ffff888028d29400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888028d29480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888028d29500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888028d29580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888028d29600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
----------------
Code disassembly (best guess):
   0:	65 9d                	gs popfq
   2:	7e 83                	jle    0xffffff87
   4:	f8                   	clc
   5:	01 0f                	add    %ecx,(%rdi)
   7:	85 b9 02 00 00 9c    	test   %edi,-0x63fffffe(%rcx)
   d:	58                   	pop    %rax
   e:	f6 c4 02             	test   $0x2,%ah
  11:	0f 85 a4 02 00 00    	jne    0x2bb
  17:	48 83 7c 24 08 00    	cmpq   $0x0,0x8(%rsp)
  1d:	74 01                	je     0x20
  1f:	fb                   	sti
  20:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  27:	fc ff df
* 2a:	48 01 c3             	add    %rax,%rbx <-- trapping instruction
  2d:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
  34:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
  3b:	00
  3c:	48                   	rex.W
  3d:	8b                   	.byte 0x8b
  3e:	84                   	.byte 0x84
  3f:	24                   	.byte 0x24


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
