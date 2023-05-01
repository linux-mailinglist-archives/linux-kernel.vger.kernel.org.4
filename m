Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459626F33AF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 18:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbjEAQyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 12:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbjEAQx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 12:53:56 -0400
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3391725
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 09:53:46 -0700 (PDT)
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-763da06581dso149789139f.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 09:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960025; x=1685552025;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JVdEp+27NvYehf0RP4PNc4zgNdCMaGTEpLwM8jnJCUo=;
        b=CF3Zy44TTb9mlx8Bb8k8w3OcFzR9qMp5iKqt5dqA7Ni2MQNLunEprkyF5MHBuUR9yb
         9O9UNlI0JijA27tSVBkNHu8W9ctTrIbQNKJVKGKLTpz9/B3ChYl5ueKYXQc1u2WEdwdh
         qt9byssQOT1AaljiZlyd62hgSJ8E+DoU3q4mQynEh09XBtH/ImJ5BzFnqsy+XZD+y0lt
         0Wg+qde7gij2SAe+W7M2+Sbm6ig2SiFn1e4jH7E3pC37mhFFYb/+NWmobiqLSwdwf8Tz
         n6fBVb8j3daUgWC+o7c5XuNxb+DAgh8A2Pe1lPXMLviOlTXeQAGP3VoraQ5rrxo+FthD
         GnoA==
X-Gm-Message-State: AC+VfDxOaLrLbkaSEXSZHocIr4BoDg7qQbCKSjpomslyQRbTW2VGaAvA
        /bnyYxfKhvywtCtFulGVD1Ea8Md7JqHLhYRLNinRDbWnrriq
X-Google-Smtp-Source: ACHHUZ5/slsImHm52o4dmbbXr0M7B30uC8V1H48+kv7bVRFuL2rUujCPJAOPUaj3tGiIU6Hgk0loRUDfG4AXVXd9vBvNdzz91kNM
MIME-Version: 1.0
X-Received: by 2002:a02:8481:0:b0:406:35e8:51e6 with SMTP id
 f1-20020a028481000000b0040635e851e6mr6191699jai.1.1682960025394; Mon, 01 May
 2023 09:53:45 -0700 (PDT)
Date:   Mon, 01 May 2023 09:53:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007c27e105faa4aa99@google.com>
Subject: [syzbot] [usb?] KASAN: slab-use-after-free Write in usb_anchor_suspend_wakeups
From:   syzbot <syzbot+d6b0b0ea0781c14b2ecf@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    89d77f71f493 Merge tag 'riscv-for-linus-6.4-mw1' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=136de410280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d963e7536cbe545e
dashboard link: https://syzkaller.appspot.com/bug?extid=d6b0b0ea0781c14b2ecf
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11471b84280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10b98e2c280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/96d35fa60cb4/disk-89d77f71.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/62065bb9df1b/vmlinux-89d77f71.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e1b7ef90401b/bzImage-89d77f71.xz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=161f68e8280000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=151f68e8280000
console output: https://syzkaller.appspot.com/x/log.txt?x=111f68e8280000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d6b0b0ea0781c14b2ecf@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: slab-use-after-free in atomic_inc include/linux/atomic/atomic-instrumented.h:190 [inline]
BUG: KASAN: slab-use-after-free in usb_anchor_suspend_wakeups drivers/usb/core/urb.c:942 [inline]
BUG: KASAN: slab-use-after-free in usb_anchor_suspend_wakeups+0x28/0x40 drivers/usb/core/urb.c:939
Write of size 4 at addr ffff888079b7a110 by task kworker/0:2/1761

CPU: 0 PID: 1761 Comm: kworker/0:2 Not tainted 6.3.0-syzkaller-11025-g89d77f71f493 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
Workqueue: usb_hub_wq hub_event
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:351
 print_report mm/kasan/report.c:462 [inline]
 kasan_report+0x11c/0x130 mm/kasan/report.c:572
 check_region_inline mm/kasan/generic.c:181 [inline]
 kasan_check_range+0x141/0x190 mm/kasan/generic.c:187
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_inc include/linux/atomic/atomic-instrumented.h:190 [inline]
 usb_anchor_suspend_wakeups drivers/usb/core/urb.c:942 [inline]
 usb_anchor_suspend_wakeups+0x28/0x40 drivers/usb/core/urb.c:939
 __usb_hcd_giveback_urb+0x213/0x5c0 drivers/usb/core/hcd.c:1658
 usb_hcd_giveback_urb+0x384/0x430 drivers/usb/core/hcd.c:1754
 dummy_timer+0x13b6/0x3400 drivers/usb/gadget/udc/dummy_hcd.c:1988
 call_timer_fn+0x1a0/0x580 kernel/time/timer.c:1700
 expire_timers+0x29b/0x4b0 kernel/time/timer.c:1751
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
RIP: 0010:trace_lock_release include/trace/events/lock.h:69 [inline]
RIP: 0010:lock_release+0xad/0x670 kernel/locking/lockdep.c:5702
Code: 07 0f 87 a8 04 00 00 89 db be 08 00 00 00 48 89 d8 48 c1 e8 06 48 8d 3c c5 10 ec 79 8e e8 6b 2c 71 00 48 0f a3 1d 33 fa 13 0d <0f> 82 43 04 00 00 48 c7 c3 30 21 7a 8e 48 b8 00 00 00 00 00 fc ff
RSP: 0018:ffffc90006aaf7d8 EFLAGS: 00000247
RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffffffff8165f1d5
RDX: fffffbfff1cf3d83 RSI: 0000000000000008 RDI: ffffffff8e79ec10
RBP: 1ffff92000d55efd R08: 0000000000000000 R09: ffffffff8e79ec17
R10: fffffbfff1cf3d82 R11: 0000000000000000 R12: ffff88802a253418
R13: ffff88802a539078 R14: ffffffff8517ad30 R15: dffffc0000000000
 __raw_spin_unlock include/linux/spinlock_api_smp.h:141 [inline]
 _raw_spin_unlock+0x16/0x40 kernel/locking/spinlock.c:186
 spin_unlock include/linux/spinlock.h:390 [inline]
 klist_put+0x159/0x1d0 lib/klist.c:219
 device_del+0x1e0/0xa30 drivers/base/core.c:3791
 device_unregister+0x1e/0xc0 drivers/base/core.c:3844
 usb_remove_ep_devs+0x42/0x80 drivers/usb/core/endpoint.c:188
 remove_intf_ep_devs drivers/usb/core/message.c:1268 [inline]
 usb_disable_device+0x30b/0x7b0 drivers/usb/core/message.c:1419
 usb_disconnect+0x2db/0x8a0 drivers/usb/core/hub.c:2238
 hub_port_connect drivers/usb/core/hub.c:5246 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5551 [inline]
 port_event drivers/usb/core/hub.c:5711 [inline]
 hub_event+0x1fbf/0x4e40 drivers/usb/core/hub.c:5793
 process_one_work+0x991/0x15c0 kernel/workqueue.c:2390
 process_scheduled_works kernel/workqueue.c:2453 [inline]
 worker_thread+0x858/0x1090 kernel/workqueue.c:2539
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

Allocated by task 7107:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 ____kasan_kmalloc mm/kasan/common.c:333 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:559 [inline]
 kzalloc include/linux/slab.h:680 [inline]
 usbtmc_open+0xaa/0x9c0 drivers/usb/class/usbtmc.c:175
 usb_open+0x208/0x2e0 drivers/usb/core/file.c:48
 chrdev_open+0x26a/0x770 fs/char_dev.c:414
 do_dentry_open+0x6cc/0x13f0 fs/open.c:920
 do_open fs/namei.c:3560 [inline]
 path_openat+0x1baa/0x2750 fs/namei.c:3715
 do_filp_open+0x1ba/0x410 fs/namei.c:3742
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1356
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __x64_sys_openat+0x143/0x1f0 fs/open.c:1383
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 7107:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2e/0x40 mm/kasan/generic.c:521
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x160/0x1c0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1807
 slab_free mm/slub.c:3786 [inline]
 __kmem_cache_free+0xaf/0x2d0 mm/slub.c:3799
 usbtmc_release+0x289/0x3a0 drivers/usb/class/usbtmc.c:261
 __fput+0x27c/0xa90 fs/file_table.c:321
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x210/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888079b7a000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 272 bytes inside of
 freed 1024-byte region [ffff888079b7a000, ffff888079b7a400)

The buggy address belongs to the physical page:
page:ffffea0001e6de00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x79b78
head:ffffea0001e6de00 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000010200 ffff888012441dc0 0000000000000000 dead000000000001
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 46, tgid 46 (kworker/u4:3), ts 375298445641, free_ts 375098577408
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2db/0x350 mm/page_alloc.c:1722
 prep_new_page mm/page_alloc.c:1729 [inline]
 get_page_from_freelist+0xf41/0x2c00 mm/page_alloc.c:3493
 __alloc_pages+0x1cb/0x4a0 mm/page_alloc.c:4759
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2277
 alloc_slab_page mm/slub.c:1851 [inline]
 allocate_slab+0x25f/0x390 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3192
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3291
 __slab_alloc_node mm/slub.c:3344 [inline]
 slab_alloc_node mm/slub.c:3441 [inline]
 __kmem_cache_alloc_node+0x136/0x320 mm/slub.c:3490
 __do_kmalloc_node mm/slab_common.c:965 [inline]
 __kmalloc+0x4e/0x190 mm/slab_common.c:979
 kmalloc include/linux/slab.h:563 [inline]
 kzalloc include/linux/slab.h:680 [inline]
 ieee802_11_parse_elems_full+0x106/0x1340 net/mac80211/util.c:1609
 ieee802_11_parse_elems_crc net/mac80211/ieee80211_i.h:2305 [inline]
 ieee802_11_parse_elems net/mac80211/ieee80211_i.h:2312 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1605 [inline]
 ieee80211_ibss_rx_queued_mgmt+0xcbc/0x3030 net/mac80211/ibss.c:1638
 ieee80211_iface_process_skb net/mac80211/iface.c:1594 [inline]
 ieee80211_iface_work+0xa4d/0xd70 net/mac80211/iface.c:1648
 process_one_work+0x991/0x15c0 kernel/workqueue.c:2390
 worker_thread+0x669/0x1090 kernel/workqueue.c:2537
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1302 [inline]
 free_unref_page_prepare+0x62e/0xcb0 mm/page_alloc.c:2555
 free_unref_page+0x33/0x370 mm/page_alloc.c:2650
 __unfreeze_partials+0x17c/0x1a0 mm/slub.c:2636
 qlink_free mm/kasan/quarantine.c:166 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:185
 kasan_quarantine_reduce+0x195/0x220 mm/kasan/quarantine.c:292
 __kasan_slab_alloc+0x63/0x90 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:711 [inline]
 slab_alloc_node mm/slub.c:3451 [inline]
 slab_alloc mm/slub.c:3459 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3466 [inline]
 kmem_cache_alloc+0x17c/0x3b0 mm/slub.c:3475
 getname_flags.part.0+0x50/0x4f0 fs/namei.c:140
 getname_flags+0x9e/0xe0 include/linux/audit.h:321
 vfs_fstatat+0x77/0xb0 fs/stat.c:275
 vfs_lstat include/linux/fs.h:2876 [inline]
 __do_sys_newlstat+0x84/0x100 fs/stat.c:432
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff888079b7a000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888079b7a080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888079b7a100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff888079b7a180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888079b7a200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	0f 87 a8 04 00 00    	ja     0x4ae
   6:	89 db                	mov    %ebx,%ebx
   8:	be 08 00 00 00       	mov    $0x8,%esi
   d:	48 89 d8             	mov    %rbx,%rax
  10:	48 c1 e8 06          	shr    $0x6,%rax
  14:	48 8d 3c c5 10 ec 79 	lea    -0x718613f0(,%rax,8),%rdi
  1b:	8e
  1c:	e8 6b 2c 71 00       	callq  0x712c8c
  21:	48 0f a3 1d 33 fa 13 	bt     %rbx,0xd13fa33(%rip)        # 0xd13fa5c
  28:	0d
* 29:	0f 82 43 04 00 00    	jb     0x472 <-- trapping instruction
  2f:	48 c7 c3 30 21 7a 8e 	mov    $0xffffffff8e7a2130,%rbx
  36:	48                   	rex.W
  37:	b8 00 00 00 00       	mov    $0x0,%eax
  3c:	00 fc                	add    %bh,%ah
  3e:	ff                   	.byte 0xff


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
