Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E4B5BBF87
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 21:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiIRTnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 15:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiIRTnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 15:43:45 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CCE15837
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 12:43:44 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id w2-20020a056e021c8200b002f5c95226e0so482568ill.9
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 12:43:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=cGJCK6Dzer0SdaF7xtYjogiFgfKn7njpsVEj/Vbi5jg=;
        b=sibqRlJpb0q8wnMNGugijIbf/0iWIIB7m6UxcHWTdbsfmlQ4J/UQSP0hiPhSV4tWA3
         K84vpTogM1wlFuO8qwYUOwB3gJZh3icwzfzB7t4rymf4RDgXx7Kkp7c7P9ywRSCcXnnP
         wc/aG4oEtKNmMazMvyZsVeHgu7F8KfojEIDHSm+ecX4PFj7FvrscZI8nV+zh9wD5yL1T
         HBaAnIffCZH9qI2zm1isos8t4WclTOSHSVGjAD2lXxXWN3oXi45aNH20y65/o8nBY/1N
         lz5Rzo29olF6uZTvPh3FWb/nl3bQplrhmP3bOHdWWBzOpOd675kJAemSRyLDspbktLwh
         RoXQ==
X-Gm-Message-State: ACrzQf2yM3xzEiV2LpqJW4GYNkRP//1WsOll0RiqkqtgZplvbdil1MuL
        gADgfOhmXoj91W/S6ssCPdSiFALnSjtX6uRqCAUJAkcHRByj
X-Google-Smtp-Source: AMsMyM70t4ZQNP3PCwAmQrFX0RoOepqv6XDOXmSTmxtdslrgu9tfvPmbpS9/MZ6jT63pfLDxg2ujKhgvLBuxY9Zz/ZlrgFjQOdzW
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:508:b0:2eb:543:bd66 with SMTP id
 d8-20020a056e02050800b002eb0543bd66mr6032750ils.207.1663530223936; Sun, 18
 Sep 2022 12:43:43 -0700 (PDT)
Date:   Sun, 18 Sep 2022 12:43:43 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000122cfc05e8f8d09b@google.com>
Subject: [syzbot] inconsistent lock state in padata_do_serial (2)
From:   syzbot <syzbot+bc05445bc14148d51915@syzkaller.appspotmail.com>
To:     daniel.m.jordan@oracle.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, steffen.klassert@secunet.com,
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

HEAD commit:    3245cb65fd91 Merge tag 'devicetree-fixes-for-6.0-2' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16310dbf080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98a30118ec9215e9
dashboard link: https://syzkaller.appspot.com/bug?extid=bc05445bc14148d51915
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bc05445bc14148d51915@syzkaller.appspotmail.com

================================
WARNING: inconsistent lock state
6.0.0-rc5-syzkaller-00025-g3245cb65fd91 #0 Not tainted
--------------------------------
inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
syz-executor.2/27685 [HC0[0]:SC1[1]:HE1:SE0] takes:
ffffe8ffffc7d280 (&pd_list->lock){+.?.}-{2:2}, at: spin_lock include/linux/spinlock.h:349 [inline]
ffffe8ffffc7d280 (&pd_list->lock){+.?.}-{2:2}, at: padata_do_serial+0x21e/0x4b0 kernel/padata.c:392
{SOFTIRQ-ON-W} state was registered at:
  lock_acquire kernel/locking/lockdep.c:5666 [inline]
  lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
  _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
  spin_lock include/linux/spinlock.h:349 [inline]
  padata_do_serial+0x21e/0x4b0 kernel/padata.c:392
  pcrypt_aead_enc+0x57/0x70 crypto/pcrypt.c:89
  padata_do_parallel+0x87b/0xa10 kernel/padata.c:217
  pcrypt_aead_encrypt+0x39f/0x4d0 crypto/pcrypt.c:117
  crypto_aead_encrypt+0xaa/0xf0 crypto/aead.c:94
  tls_do_encryption net/tls/tls_sw.c:529 [inline]
  tls_push_record+0x13e8/0x3260 net/tls/tls_sw.c:762
  bpf_exec_tx_verdict+0xd82/0x11a0 net/tls/tls_sw.c:802
  tls_sw_sendmsg+0xa62/0x1820 net/tls/tls_sw.c:1014
  inet6_sendmsg+0x99/0xe0 net/ipv6/af_inet6.c:653
  sock_sendmsg_nosec net/socket.c:714 [inline]
  sock_sendmsg+0xcf/0x120 net/socket.c:734
  sock_write_iter+0x291/0x3d0 net/socket.c:1108
  call_write_iter include/linux/fs.h:2187 [inline]
  new_sync_write fs/read_write.c:491 [inline]
  vfs_write+0x9e9/0xdd0 fs/read_write.c:578
  ksys_write+0x1e8/0x250 fs/read_write.c:631
  do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
  __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
  do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
  entry_SYSENTER_compat_after_hwframe+0x70/0x82
irq event stamp: 740
hardirqs last  enabled at (740): [<ffffffff814919a0>] __local_bh_enable_ip+0xa0/0x120 kernel/softirq.c:401
hardirqs last disabled at (739): [<ffffffff814919c3>] __local_bh_enable_ip+0xc3/0x120 kernel/softirq.c:378
softirqs last  enabled at (0): [<ffffffff8146f02e>] copy_process+0x213e/0x7090 kernel/fork.c:2202
softirqs last disabled at (717): [<ffffffff81491843>] invoke_softirq kernel/softirq.c:445 [inline]
softirqs last disabled at (717): [<ffffffff81491843>] __irq_exit_rcu+0x123/0x180 kernel/softirq.c:650

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&pd_list->lock);
  <Interrupt>
    lock(&pd_list->lock);

 *** DEADLOCK ***

4 locks held by syz-executor.2/27685:
 #0: ffff8880445f0460 (sb_writers#3){.+.+}-{0:0}, at: open_last_lookups fs/namei.c:3470 [inline]
 #0: ffff8880445f0460 (sb_writers#3){.+.+}-{0:0}, at: path_openat+0x2613/0x28f0 fs/namei.c:3688
 #1: ffff8880465111a0 (&sb->s_type->i_mutex_key#9){++++}-{3:3}, at: inode_lock_shared include/linux/fs.h:766 [inline]
 #1: ffff8880465111a0 (&sb->s_type->i_mutex_key#9){++++}-{3:3}, at: open_last_lookups fs/namei.c:3480 [inline]
 #1: ffff8880465111a0 (&sb->s_type->i_mutex_key#9){++++}-{3:3}, at: path_openat+0x1514/0x28f0 fs/namei.c:3688
 #2: ffffc900001e0d70 ((&d->timer)){+.-.}-{0:0}, at: lockdep_copy_map include/linux/lockdep.h:31 [inline]
 #2: ffffc900001e0d70 ((&d->timer)){+.-.}-{0:0}, at: call_timer_fn+0xd5/0x6b0 kernel/time/timer.c:1464
 #3: ffffffff8bf89400 (rcu_read_lock){....}-{1:2}, at: buf_msg net/tipc/msg.h:202 [inline]
 #3: ffffffff8bf89400 (rcu_read_lock){....}-{1:2}, at: tipc_bearer_xmit_skb+0x8c/0x410 net/tipc/bearer.c:550

stack backtrace:
CPU: 1 PID: 27685 Comm: syz-executor.2 Not tainted 6.0.0-rc5-syzkaller-00025-g3245cb65fd91 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_usage_bug kernel/locking/lockdep.c:3961 [inline]
 valid_state kernel/locking/lockdep.c:3973 [inline]
 mark_lock_irq kernel/locking/lockdep.c:4176 [inline]
 mark_lock.part.0.cold+0x18/0xd8 kernel/locking/lockdep.c:4632
 mark_lock kernel/locking/lockdep.c:4596 [inline]
 mark_usage kernel/locking/lockdep.c:4527 [inline]
 __lock_acquire+0x11d9/0x56d0 kernel/locking/lockdep.c:5007
 lock_acquire kernel/locking/lockdep.c:5666 [inline]
 lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:349 [inline]
 padata_do_serial+0x21e/0x4b0 kernel/padata.c:392
 pcrypt_aead_enc+0x57/0x70 crypto/pcrypt.c:89
 padata_do_parallel+0x87b/0xa10 kernel/padata.c:217
 pcrypt_aead_encrypt+0x39f/0x4d0 crypto/pcrypt.c:117
 crypto_aead_encrypt+0xaa/0xf0 crypto/aead.c:94
 tipc_aead_encrypt net/tipc/crypto.c:821 [inline]
 tipc_crypto_xmit+0xf7a/0x2af0 net/tipc/crypto.c:1756
 tipc_bearer_xmit_skb+0x1ed/0x410 net/tipc/bearer.c:557
 tipc_disc_timeout+0x75e/0xcb0 net/tipc/discover.c:335
 call_timer_fn+0x1a0/0x6b0 kernel/time/timer.c:1474
 expire_timers kernel/time/timer.c:1519 [inline]
 __run_timers.part.0+0x674/0xa80 kernel/time/timer.c:1790
 __run_timers kernel/time/timer.c:1768 [inline]
 run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1803
 __do_softirq+0x1d3/0x9c6 kernel/softirq.c:571
 invoke_softirq kernel/softirq.c:445 [inline]
 __irq_exit_rcu+0x123/0x180 kernel/softirq.c:650
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:662
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1106
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x16/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x38/0x70 kernel/locking/spinlock.c:194
Code: 74 24 10 e8 6a 2e dc f7 48 89 ef e8 f2 af dc f7 81 e3 00 02 00 00 75 25 9c 58 f6 c4 02 75 2d 48 85 db 74 01 fb bf 01 00 00 00 <e8> a3 71 cf f7 65 8b 05 5c 27 7f 76 85 c0 74 0a 5b 5d c3 e8 60 38
RSP: 0018:ffffc90015e5f520 EFLAGS: 00000206
RAX: 0000000000000002 RBX: 0000000000000200 RCX: 1ffffffff21242a6
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000001
RBP: ffff8880119db3c0 R08: 0000000000000001 R09: ffffffff908e49e7
R10: 0000000000000001 R11: 0000000000000000 R12: ffff888140007640
R13: ffff8880119db3c0 R14: ffffea0001194380 R15: ffff88804650ea48
 spin_unlock_irqrestore include/linux/spinlock.h:404 [inline]
 get_partial_node.part.0+0x1ad/0x220 mm/slub.c:2207
 get_partial_node mm/slub.c:2175 [inline]
 get_partial mm/slub.c:2287 [inline]
 ___slab_alloc+0x918/0xe10 mm/slub.c:3026
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3118
 slab_alloc_node mm/slub.c:3209 [inline]
 slab_alloc mm/slub.c:3251 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3258 [inline]
 kmem_cache_alloc_lru+0x528/0x720 mm/slub.c:3275
 __d_alloc+0x32/0x960 fs/dcache.c:1769
 d_alloc+0x4a/0x230 fs/dcache.c:1849
 d_alloc_parallel+0xe4/0x1400 fs/dcache.c:2647
 lookup_open.isra.0+0x928/0x12a0 fs/namei.c:3338
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x996/0x28f0 fs/namei.c:3688
 do_filp_open+0x1b6/0x400 fs/namei.c:3718
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1311
 do_sys_open fs/open.c:1327 [inline]
 __do_compat_sys_openat fs/open.c:1387 [inline]
 __se_compat_sys_openat fs/open.c:1385 [inline]
 __ia32_compat_sys_openat+0x13f/0x1f0 fs/open.c:1385
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82
RIP: 0023:0xf7fc6549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f748f8e0 EFLAGS: 00000286 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 00000000ffffff9c RCX: 00000000f6ea12ec
RDX: 0000000000080001 RSI: 0000000000000000 RDI: 00000000f6f37000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000286 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess):
   0:	74 24                	je     0x26
   2:	10 e8                	adc    %ch,%al
   4:	6a 2e                	pushq  $0x2e
   6:	dc f7                	fdiv   %st,%st(7)
   8:	48 89 ef             	mov    %rbp,%rdi
   b:	e8 f2 af dc f7       	callq  0xf7dcb002
  10:	81 e3 00 02 00 00    	and    $0x200,%ebx
  16:	75 25                	jne    0x3d
  18:	9c                   	pushfq
  19:	58                   	pop    %rax
  1a:	f6 c4 02             	test   $0x2,%ah
  1d:	75 2d                	jne    0x4c
  1f:	48 85 db             	test   %rbx,%rbx
  22:	74 01                	je     0x25
  24:	fb                   	sti
  25:	bf 01 00 00 00       	mov    $0x1,%edi
* 2a:	e8 a3 71 cf f7       	callq  0xf7cf71d2 <-- trapping instruction
  2f:	65 8b 05 5c 27 7f 76 	mov    %gs:0x767f275c(%rip),%eax        # 0x767f2792
  36:	85 c0                	test   %eax,%eax
  38:	74 0a                	je     0x44
  3a:	5b                   	pop    %rbx
  3b:	5d                   	pop    %rbp
  3c:	c3                   	retq
  3d:	e8                   	.byte 0xe8
  3e:	60                   	(bad)
  3f:	38                   	.byte 0x38


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
