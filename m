Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5A8735D3F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 20:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjFSSG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 14:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjFSSGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 14:06:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A75E4A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 11:06:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0420A60DFE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 18:06:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B3BC433CA;
        Mon, 19 Jun 2023 18:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1687197979;
        bh=0+xg64z5mhoAzArU0X/hOzhbQqwPGYZ6aYawBLMeXmg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=x/ryl5nhZK5nOa6WODG2l0pMLY/feGt4WYTi1vtutnRnGl5ZTtVlBDfVN0ssYkves
         yZ0fzDItPzCcfPtqlkIS82iwg6B2BGy7w8UQsBClLpZkqxuqCmEd5Okh9sqehc00W7
         cllvMxwe30VAfg+4AL47UykQ0QENvSvVV459ZpDQ=
Date:   Mon, 19 Jun 2023 11:06:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+87c490fd2be656269b6a@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        "T.J. Alumbaugh" <talumbau@google.com>, Yu Zhao <yuzhao@google.com>
Subject: Re: [syzbot] [mm?] inconsistent lock state in lru_gen_rotate_memcg
Message-Id: <20230619110618.6f5e4f8d299ad78f6fc99acb@linux-foundation.org>
In-Reply-To: <0000000000000fa09c05fe7cfea6@google.com>
References: <0000000000000fa09c05fe7cfea6@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2023 08:14:35 -0700 syzbot <syzbot+87c490fd2be656269b6a@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    40f71e7cd3c6 Merge tag 'net-6.4-rc7' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1154eb17280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b55c7ca2258f24ba

CONFIG_LRU_GEN=y
CONFIG_LRU_GEN_ENABLED=y

Maybe caused by TJ's series?

https://lkml.kernel.org/r/20230522112058.2965866-1-talumbau@google.com
https://lkml.kernel.org/r/20230522112058.2965866-2-talumbau@google.com
https://lkml.kernel.org/r/20230522112058.2965866-3-talumbau@google.com
https://lkml.kernel.org/r/20230522112058.2965866-4-talumbau@google.com

> dashboard link: https://syzkaller.appspot.com/bug?extid=87c490fd2be656269b6a
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12acd517280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14276ecf280000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-40f71e7c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/1d6d986d5baf/vmlinux-40f71e7c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/cb0c02dd7f64/bzImage-40f71e7c.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+87c490fd2be656269b6a@syzkaller.appspotmail.com
> 
> ================================
> WARNING: inconsistent lock state
> 6.4.0-rc6-syzkaller-00195-g40f71e7cd3c6 #0 Not tainted
> --------------------------------
> inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
> syz-executor192/6901 [HC0[0]:SC1[1]:HE0:SE0] takes:
> ffff88807ffdc728 (&pgdat->memcg_lru.lock){+.?.}-{2:2}, at: spin_lock include/linux/spinlock.h:350 [inline]
> ffff88807ffdc728 (&pgdat->memcg_lru.lock){+.?.}-{2:2}, at: lru_gen_rotate_memcg+0x64/0xab0 mm/vmscan.c:4749
> {SOFTIRQ-ON-W} state was registered at:
>   lock_acquire kernel/locking/lockdep.c:5705 [inline]
>   lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5670
>   __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
>   _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
>   spin_lock include/linux/spinlock.h:350 [inline]
>   lru_gen_online_memcg+0x16b/0x5a0 mm/vmscan.c:4797
>   mem_cgroup_css_online+0x227/0x3b0 mm/memcontrol.c:5468
>   online_css+0xaf/0x2a0 kernel/cgroup/cgroup.c:5491
>   cgroup_init_subsys+0x46b/0x900 kernel/cgroup/cgroup.c:6022
>   cgroup_init+0xb83/0x1090 kernel/cgroup/cgroup.c:6106
>   start_kernel+0x398/0x490 init/main.c:1077
>   x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:556
>   x86_64_start_kernel+0xb3/0xc0 arch/x86/kernel/head64.c:537
>   secondary_startup_64_no_verify+0xf4/0xfb
> irq event stamp: 1403
> hardirqs last  enabled at (1402): [<ffffffff81dc88cf>] mod_memcg_state include/linux/memcontrol.h:982 [inline]
> hardirqs last  enabled at (1402): [<ffffffff81dc88cf>] memcg_account_kmem+0x4f/0x80 mm/memcontrol.c:3094
> hardirqs last disabled at (1403): [<ffffffff81dcc157>] uncharge_batch+0x1c7/0x560 mm/memcontrol.c:7142
> softirqs last  enabled at (1178): [<ffffffff880eb512>] rcu_read_unlock_bh include/linux/rcupdate.h:839 [inline]
> softirqs last  enabled at (1178): [<ffffffff880eb512>] __dev_queue_xmit+0x1df2/0x3b10 net/core/dev.c:4271
> softirqs last disabled at (1253): [<ffffffff814cefd4>] invoke_softirq kernel/softirq.c:445 [inline]
> softirqs last disabled at (1253): [<ffffffff814cefd4>] __irq_exit_rcu+0x114/0x190 kernel/softirq.c:650
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(&pgdat->memcg_lru.lock);
>   <Interrupt>
>     lock(&pgdat->memcg_lru.lock);
> 
>  *** DEADLOCK ***
> 
> 2 locks held by syz-executor192/6901:
>  #0: ffffffff8e10b9e8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:78 [inline]
>  #0: ffffffff8e10b9e8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x3e8/0xd50 net/core/rtnetlink.c:6414
>  #1: ffffffff8c795fe0 (rcu_callback){....}-{0:0}, at: rcu_do_batch kernel/rcu/tree.c:2104 [inline]
>  #1: ffffffff8c795fe0 (rcu_callback){....}-{0:0}, at: rcu_core+0x791/0x1ad0 kernel/rcu/tree.c:2377
> 
> stack backtrace:
> CPU: 3 PID: 6901 Comm: syz-executor192 Not tainted 6.4.0-rc6-syzkaller-00195-g40f71e7cd3c6 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
>  print_usage_bug kernel/locking/lockdep.c:3949 [inline]
>  valid_state kernel/locking/lockdep.c:3991 [inline]
>  mark_lock_irq kernel/locking/lockdep.c:4194 [inline]
>  mark_lock.part.0+0x1110/0x1970 kernel/locking/lockdep.c:4656
>  mark_lock kernel/locking/lockdep.c:4620 [inline]
>  mark_usage kernel/locking/lockdep.c:4545 [inline]
>  __lock_acquire+0x1227/0x5f30 kernel/locking/lockdep.c:5042
>  lock_acquire kernel/locking/lockdep.c:5705 [inline]
>  lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5670
>  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
>  _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
>  spin_lock include/linux/spinlock.h:350 [inline]
>  lru_gen_rotate_memcg+0x64/0xab0 mm/vmscan.c:4749
>  lru_gen_soft_reclaim+0x62/0x70 mm/vmscan.c:4852
>  uncharge_batch+0x2be/0x560 mm/memcontrol.c:7145
>  __mem_cgroup_uncharge+0x11f/0x290 mm/memcontrol.c:7221
>  mem_cgroup_uncharge include/linux/memcontrol.h:698 [inline]
>  __folio_put_small mm/swap.c:105 [inline]
>  __folio_put+0xb6/0x140 mm/swap.c:129
>  folio_put include/linux/mm.h:1430 [inline]
>  put_page include/linux/mm.h:1499 [inline]
>  free_page_and_swap_cache+0x257/0x2c0 mm/swap_state.c:305
>  __tlb_remove_table arch/x86/include/asm/tlb.h:34 [inline]
>  __tlb_remove_table_free mm/mmu_gather.c:153 [inline]
>  tlb_remove_table_rcu+0x89/0xe0 mm/mmu_gather.c:208
>  rcu_do_batch kernel/rcu/tree.c:2115 [inline]
>  rcu_core+0x806/0x1ad0 kernel/rcu/tree.c:2377
>  __do_softirq+0x1d4/0x905 kernel/softirq.c:571
>  invoke_softirq kernel/softirq.c:445 [inline]
>  __irq_exit_rcu+0x114/0x190 kernel/softirq.c:650
>  irq_exit_rcu+0x9/0x20 kernel/softirq.c:662
>  sysvec_apic_timer_interrupt+0x97/0xc0 arch/x86/kernel/apic/apic.c:1106
>  </IRQ>
>  <TASK>
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
> RIP: 0010:__sanitizer_cov_trace_pc+0x3b/0x70 kernel/kcov.c:207
> Code: 81 e1 00 01 00 00 65 48 8b 14 25 00 bc 03 00 a9 00 01 ff 00 74 0e 85 c9 74 35 8b 82 0c 16 00 00 85 c0 74 2b 8b 82 e8 15 00 00 <83> f8 02 75 20 48 8b 8a f0 15 00 00 8b 92 ec 15 00 00 48 8b 01 48
> RSP: 0018:ffffc9000420ecf8 EFLAGS: 00000246
> RAX: 0000000000000000 RBX: 0000000000000064 RCX: 0000000000000000
> RDX: ffff888044f60380 RSI: ffffffff8a021a9b RDI: 0000000000000001
> RBP: ffff88802b6d6004 R08: 0000000000000001 R09: 000000000000006e
> R10: 0000000000000064 R11: 0000000000094001 R12: ffff888054ea8005
> R13: 00000000ffffffff R14: 00000000ffffffff R15: dffffc0000000000
>  vsscanf+0x34b/0x2600 lib/vsprintf.c:3518
>  sscanf+0xbf/0xf0 lib/vsprintf.c:3716
>  __dev_alloc_name net/core/dev.c:1065 [inline]
>  dev_alloc_name_ns+0x343/0x610 net/core/dev.c:1099
>  dev_get_valid_name+0x69/0x170 net/core/dev.c:1134
>  register_netdevice+0x3ba/0x1640 net/core/dev.c:10006
>  veth_newlink+0x352/0x9d0 drivers/net/veth.c:1897
>  rtnl_newlink_create net/core/rtnetlink.c:3465 [inline]
>  __rtnl_newlink+0x10c2/0x1840 net/core/rtnetlink.c:3682
>  rtnl_newlink+0x68/0xa0 net/core/rtnetlink.c:3695
>  rtnetlink_rcv_msg+0x43d/0xd50 net/core/rtnetlink.c:6417
>  netlink_rcv_skb+0x165/0x440 net/netlink/af_netlink.c:2546
>  netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
>  netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1365
>  netlink_sendmsg+0x925/0xe30 net/netlink/af_netlink.c:1913
>  sock_sendmsg_nosec net/socket.c:724 [inline]
>  sock_sendmsg+0xde/0x190 net/socket.c:747
>  ____sys_sendmsg+0x71c/0x900 net/socket.c:2503
>  ___sys_sendmsg+0x110/0x1b0 net/socket.c:2557
>  __sys_sendmsg+0xf7/0x1c0 net/socket.c:2586
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f0ee7a7d049
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 41 16 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe607e0d88 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f0ee7a7d049
> RDX: 0000000000000000 RSI: 0000000020000040 RDI: 0000000000000003
> RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000003
> R10: 0000000000000003 R11: 0000000000000246 R12: 00007ffe607e0db8
> R13: 00007ffe607e0dd0 R14: 00007ffe607e0e10 R15: 00000000000006cd
>  </TASK>
> ----------------
> Code disassembly (best guess):
>    0:	81 e1 00 01 00 00    	and    $0x100,%ecx
>    6:	65 48 8b 14 25 00 bc 	mov    %gs:0x3bc00,%rdx
>    d:	03 00
>    f:	a9 00 01 ff 00       	test   $0xff0100,%eax
>   14:	74 0e                	je     0x24
>   16:	85 c9                	test   %ecx,%ecx
>   18:	74 35                	je     0x4f
>   1a:	8b 82 0c 16 00 00    	mov    0x160c(%rdx),%eax
>   20:	85 c0                	test   %eax,%eax
>   22:	74 2b                	je     0x4f
>   24:	8b 82 e8 15 00 00    	mov    0x15e8(%rdx),%eax
> * 2a:	83 f8 02             	cmp    $0x2,%eax <-- trapping instruction
>   2d:	75 20                	jne    0x4f
>   2f:	48 8b 8a f0 15 00 00 	mov    0x15f0(%rdx),%rcx
>   36:	8b 92 ec 15 00 00    	mov    0x15ec(%rdx),%edx
>   3c:	48 8b 01             	mov    (%rcx),%rax
>   3f:	48                   	rex.W
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to change bug's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the bug is a duplicate of another bug, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
