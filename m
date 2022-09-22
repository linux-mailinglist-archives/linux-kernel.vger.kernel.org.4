Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085E95E5B2B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 08:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiIVGQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 02:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiIVGQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 02:16:16 -0400
X-Greylist: delayed 343 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 21 Sep 2022 23:16:14 PDT
Received: from mp-relay-02.fibernetics.ca (mp-relay-02.fibernetics.ca [208.85.217.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854CDB4EAB;
        Wed, 21 Sep 2022 23:16:14 -0700 (PDT)
Received: from mailpool-fe-02.fibernetics.ca (mailpool-fe-02.fibernetics.ca [208.85.217.145])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mp-relay-02.fibernetics.ca (Postfix) with ESMTPS id 9C50C70C38;
        Thu, 22 Sep 2022 06:10:29 +0000 (UTC)
Received: from localhost (mailpool-mx-01.fibernetics.ca [208.85.217.140])
        by mailpool-fe-02.fibernetics.ca (Postfix) with ESMTP id 8595F60907;
        Thu, 22 Sep 2022 06:10:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at 
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from mailpool-fe-02.fibernetics.ca ([208.85.217.145])
        by localhost (mail-mx-01.fibernetics.ca [208.85.217.140]) (amavisd-new, port 10024)
        with ESMTP id wCUOaCp7elQp; Thu, 22 Sep 2022 06:10:28 +0000 (UTC)
Received: from [192.168.48.17] (host-45-78-203-98.dyn.295.ca [45.78.203.98])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail.ca.inter.net (Postfix) with ESMTPSA id 65A826026F;
        Thu, 22 Sep 2022 06:10:28 +0000 (UTC)
Message-ID: <5a875163-097b-1ba6-3b06-dac4682d4464@interlog.com>
Date:   Thu, 22 Sep 2022 02:10:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Reply-To: dgilbert@interlog.com
Subject: Re: KASAN: use-after-free Read in sg_release
Content-Language: en-CA
To:     Rondreis <linhaoguo86@gmail.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CAB7eexK_jr1LWOO9RWrBF9as7gAS9kpHjrZFRuRrRJF=1H4W6A@mail.gmail.com>
From:   Douglas Gilbert <dgilbert@interlog.com>
In-Reply-To: <CAB7eexK_jr1LWOO9RWrBF9as7gAS9kpHjrZFRuRrRJF=1H4W6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-20 10:46, Rondreis wrote:
> Hello,
> 
> When fuzzing the Linux kernel driver v6.0-rc6, the following crash was
> triggered.
> 
> HEAD commit: 521a547ced6477c54b4b0cc206000406c221b4d6
> git tree: upstream
> 
> kernel config: https://pastebin.com/raw/hekxU61F
> console output: https://pastebin.com/raw/73a8RzBY
> 
> Sorry for failing to extract the reproducer. But on other versions of
> Linux, I also triggered this crash.
> 
> I would appreciate it if you have any idea how to solve this bug.

Maybe, but not without the reproducer :-)

Then check if it happens on lk 5.18.0 .

Doug Gilbert

> The crash report is as follows:
> ==================================================================
> BUG: KASAN: use-after-free in instrument_atomic_read
> include/linux/instrumented.h:71 [inline]
> BUG: KASAN: use-after-free in atomic_long_read
> include/linux/atomic/atomic-instrumented.h:1265 [inline]
> BUG: KASAN: use-after-free in __mutex_unlock_slowpath+0xac/0x610
> kernel/locking/mutex.c:916
> Read of size 8 at addr ffff888061b92c58 by task syz-executor.6/18641
> 
> CPU: 1 PID: 18641 Comm: syz-executor.6 Not tainted 6.0.0-rc4+ #20
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.13.0-1ubuntu1.1 04/01/2014
> Call Trace:
> <TASK>
> __dump_stack lib/dump_stack.c:88 [inline]
> dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> print_address_description mm/kasan/report.c:317 [inline]
> print_report.cold+0xe5/0x66d mm/kasan/report.c:433
> kasan_report+0x8a/0x1b0 mm/kasan/report.c:495
> check_region_inline mm/kasan/generic.c:183 [inline]
> kasan_check_range+0x13b/0x190 mm/kasan/generic.c:189
> instrument_atomic_read include/linux/instrumented.h:71 [inline]
> atomic_long_read include/linux/atomic/atomic-instrumented.h:1265 [inline]
> __mutex_unlock_slowpath+0xac/0x610 kernel/locking/mutex.c:916
> sg_release+0x204/0x320 drivers/scsi/sg.c:404
> __fput+0x277/0x9d0 fs/file_table.c:320
> task_work_run+0xe0/0x1a0 kernel/task_work.c:177
> resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
> exit_to_user_mode_loop kernel/entry/common.c:169 [inline]
> exit_to_user_mode_prepare+0x25d/0x270 kernel/entry/common.c:201
> __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
> syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294
> do_syscall_64+0x42/0x80 arch/x86/entry/common.c:86
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f492c03f60b
> Code: 03 00 00 00 0f 05 48 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c
> 24 0c e8 63 fc ff ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d
> 00 f0 ff ff 77 2f 44 89 c7 89 44 24 0c e8 a1 fc ff ff 8b 44
> RSP: 002b:00007fffb71b9f80 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
> RAX: 0000000000000000 RBX: 0000000000000005 RCX: 00007f492c03f60b
> RDX: ffffffffffffffb8 RSI: 0000001b2e8289d0 RDI: 0000000000000004
> RBP: 00007f492c19dd4c R08: 0000000000000000 R09: 000000003acb2633
> R10: 0000000000000000 R11: 0000000000000293 R12: 00000000000b5109
> R13: 00007fffb71ba0c0 R14: 00007f492c19c41c R15: 00000000000b4e47
> </TASK>
> 
> Allocated by task 26:
> kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
> kasan_set_track mm/kasan/common.c:45 [inline]
> set_alloc_info mm/kasan/common.c:437 [inline]
> ____kasan_kmalloc mm/kasan/common.c:516 [inline]
> ____kasan_kmalloc mm/kasan/common.c:475 [inline]
> __kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:525
> kasan_kmalloc include/linux/kasan.h:234 [inline]
> kmem_cache_alloc_trace+0x19b/0x380 mm/slub.c:3284
> kmalloc include/linux/slab.h:600 [inline]
> kzalloc include/linux/slab.h:733 [inline]
> sg_alloc drivers/scsi/sg.c:1438 [inline]
> sg_add_device+0x110/0xb10 drivers/scsi/sg.c:1507
> device_add+0xf27/0x1da0 drivers/base/core.c:3541
> scsi_sysfs_add_sdev+0x1ff/0x500 drivers/scsi/scsi_sysfs.c:1395
> scsi_sysfs_add_devices drivers/scsi/scsi_scan.c:1812 [inline]
> scsi_finish_async_scan drivers/scsi/scsi_scan.c:1897 [inline]
> do_scan_async+0x20f/0x4f0 drivers/scsi/scsi_scan.c:1940
> async_run_entry_fn+0x98/0x540 kernel/async.c:127
> process_one_work+0x9c7/0x1650 kernel/workqueue.c:2289
> worker_thread+0x623/0x1070 kernel/workqueue.c:2436
> kthread+0x2e9/0x3a0 kernel/kthread.c:376
> ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
> 
> Freed by task 2956:
> kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
> kasan_set_track+0x21/0x30 mm/kasan/common.c:45
> kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
> ____kasan_slab_free mm/kasan/common.c:367 [inline]
> ____kasan_slab_free mm/kasan/common.c:329 [inline]
> __kasan_slab_free+0x11d/0x1b0 mm/kasan/common.c:375
> kasan_slab_free include/linux/kasan.h:200 [inline]
> slab_free_hook mm/slub.c:1754 [inline]
> slab_free_freelist_hook mm/slub.c:1780 [inline]
> slab_free mm/slub.c:3534 [inline]
> kfree+0xe9/0x650 mm/slub.c:4562
> kref_put include/linux/kref.h:65 [inline]
> sg_remove_sfp_usercontext+0x39f/0x5a0 drivers/scsi/sg.c:2243
> process_one_work+0x9c7/0x1650 kernel/workqueue.c:2289
> worker_thread+0x623/0x1070 kernel/workqueue.c:2436
> kthread+0x2e9/0x3a0 kernel/kthread.c:376
> ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
> 
> Last potentially related work creation:
> kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
> __kasan_record_aux_stack+0xbe/0xd0 mm/kasan/generic.c:348
> insert_work+0x4a/0x390 kernel/workqueue.c:1358
> __queue_work+0x4d4/0x1200 kernel/workqueue.c:1517
> call_timer_fn+0x1a0/0x6b0 kernel/time/timer.c:1474
> expire_timers kernel/time/timer.c:1514 [inline]
> __run_timers.part.0+0x49e/0xad0 kernel/time/timer.c:1790
> __run_timers kernel/time/timer.c:1768 [inline]
> run_timer_softirq+0xb6/0x1d0 kernel/time/timer.c:1803
> __do_softirq+0x1d0/0x908 kernel/softirq.c:571
> 
> Second to last potentially related work creation:
> kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
> __kasan_record_aux_stack+0xbe/0xd0 mm/kasan/generic.c:348
> call_rcu kernel/rcu/tree.c:2793 [inline]
> call_rcu+0x99/0x740 kernel/rcu/tree.c:2768
> fib6_info_release include/net/ip6_fib.h:340 [inline]
> fib6_info_release include/net/ip6_fib.h:337 [inline]
> fixup_permanent_addr net/ipv6/addrconf.c:3472 [inline]
> addrconf_permanent_addr net/ipv6/addrconf.c:3500 [inline]
> addrconf_notify+0x1661/0x1ba0 net/ipv6/addrconf.c:3568
> notifier_call_chain+0xb5/0x200 kernel/notifier.c:87
> call_netdevice_notifiers_info net/core/dev.c:1945 [inline]
> call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:1930
> call_netdevice_notifiers_extack net/core/dev.c:1983 [inline]
> call_netdevice_notifiers net/core/dev.c:1997 [inline]
> __dev_notify_flags+0x121/0x2c0 net/core/dev.c:8594
> dev_change_flags+0x112/0x170 net/core/dev.c:8632
> do_setlink+0xacc/0x3ca0 net/core/rtnetlink.c:2780
> __rtnl_newlink+0xad1/0x16f0 net/core/rtnetlink.c:3546
> rtnl_newlink+0x64/0xa0 net/core/rtnetlink.c:3593
> rtnetlink_rcv_msg+0x43a/0xca0 net/core/rtnetlink.c:6090
> netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2501
> netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
> netlink_unicast+0x543/0x760 net/netlink/af_netlink.c:1345
> netlink_sendmsg+0x917/0xe10 net/netlink/af_netlink.c:1921
> sock_sendmsg_nosec net/socket.c:714 [inline]
> sock_sendmsg net/socket.c:734 [inline]
> sock_sendmsg+0xc3/0x120 net/socket.c:729
> __sys_sendto+0x236/0x340 net/socket.c:2117
> __do_sys_sendto net/socket.c:2129 [inline]
> __se_sys_sendto net/socket.c:2125 [inline]
> __x64_sys_sendto+0xdd/0x1b0 net/socket.c:2125
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> The buggy address belongs to the object at ffff888061b92c00
> which belongs to the cache kmalloc-512 of size 512
> The buggy address is located 88 bytes inside of
> 512-byte region [ffff888061b92c00, ffff888061b92e00)
> 
> The buggy address belongs to the physical page:
> page:ffffea000186e400 refcount:1 mapcount:0 mapping:0000000000000000
> index:0xffff888061b92400 pfn:0x61b90
> head:ffffea000186e400 order:2 compound_mapcount:0 compound_pincount:0
> flags: 0x4fff00000010200(slab|head|node=1|zone=1|lastcpupid=0x7ff)
> raw: 04fff00000010200 ffffea0001628408 ffffea00018a2708 ffff888011c41c80
> raw: ffff888061b92400 000000000010000b 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 2, migratetype Unmovable, gfp_mask
> 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL),
> pid 2956, tgid 2956 (kworker/1:4), ts 243564663662, free_ts 0
> set_page_owner include/linux/page_owner.h:31 [inline]
> post_alloc_hook mm/page_alloc.c:2525 [inline]
> prep_new_page+0x2c6/0x350 mm/page_alloc.c:2532
> get_page_from_freelist+0xae9/0x3a80 mm/page_alloc.c:4283
> __alloc_pages+0x321/0x710 mm/page_alloc.c:5515
> alloc_pages+0x117/0x2f0 mm/mempolicy.c:2270
> alloc_slab_page mm/slub.c:1824 [inline]
> allocate_slab mm/slub.c:1969 [inline]
> new_slab+0x246/0x3a0 mm/slub.c:2029
> ___slab_alloc+0xa50/0x1060 mm/slub.c:3031
> __slab_alloc.isra.0+0x4d/0xa0 mm/slub.c:3118
> slab_alloc_node mm/slub.c:3209 [inline]
> slab_alloc mm/slub.c:3251 [inline]
> kmem_cache_alloc_trace+0x35b/0x380 mm/slub.c:3282
> kmalloc include/linux/slab.h:600 [inline]
> kzalloc include/linux/slab.h:733 [inline]
> fib6_info_alloc+0xc3/0x210 net/ipv6/ip6_fib.c:156
> ip6_route_info_create+0x33e/0x1ab0 net/ipv6/route.c:3749
> addrconf_f6i_alloc+0x377/0x610 net/ipv6/route.c:4571
> ipv6_add_addr+0x3a2/0x1e00 net/ipv6/addrconf.c:1105
> addrconf_add_linklocal+0x1cf/0x3e0 net/ipv6/addrconf.c:3215
> addrconf_addr_gen+0x396/0x3e0 net/ipv6/addrconf.c:3346
> addrconf_dev_config+0x255/0x410 net/ipv6/addrconf.c:3391
> addrconf_notify+0xddb/0x1ba0 net/ipv6/addrconf.c:3631
> page_owner free stack trace missing
> 
> Memory state around the buggy address:
> ffff888061b92b00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff888061b92b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>> ffff888061b92c00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ^
> ffff888061b92c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff888061b92d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================

