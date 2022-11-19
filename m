Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F7C630DE2
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 10:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbiKSJng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 04:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbiKSJne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 04:43:34 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBC4F4E
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 01:43:30 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id g13-20020a056602072d00b006c60d59110fso3741321iox.12
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 01:43:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XI3wblOIikBBhk+JvF9l6JZOFmxIPmeneB8Xf75Q/Vg=;
        b=gvsNEWWSlTiF89Wje61JKJXRP8zxbnuV5W3IPPz4GILRmBkPhYi+foGo+xmlXRH8KT
         qFbrj21w8HcaGqBDFJJevdrnsLew/p9mfa1H+fYb13QkKi7islOEHmcRYRKLkYKlohwb
         aavP7GkId8w8x2bsJB6ltRzHynTDLu+5hDzN9Od9MtSSpuEgx+mmccFRyvkmq4huuzm4
         4wn/LjZABbGAEpolGHPAN8Zoi6Zl/P7DC9Wn41pAwFpl9HKGdRParUuUj4ZT3Qk+RW5R
         RqGqLuH2MCllJi5Q4lo7oYEOVPXh5aBAp7aBhUan/orixH1w+uY9DcT1Be2c+oSsgJJc
         FErQ==
X-Gm-Message-State: ANoB5pkPKPA/BPXBeoCjNIZP10tWRbJlhtJQFap1QF0sD6Qgn4Z1vrhk
        Kcfi18T6VjvLe1bNc+JUBZV3WJ1xz4yf9SW/dr1rMTT826x3
X-Google-Smtp-Source: AA0mqf4CZRH5iDMGO1Pk+8maX7xJAGOw5TlOcUYibVdvBA+QMz270Bcib2BYv81ZkmCNhxOcfVpZh/vlEsvPAlmTiNfejzoDMMDU
MIME-Version: 1.0
X-Received: by 2002:a5d:9684:0:b0:6de:18b2:1025 with SMTP id
 m4-20020a5d9684000000b006de18b21025mr5031837ion.102.1668851009858; Sat, 19
 Nov 2022 01:43:29 -0800 (PST)
Date:   Sat, 19 Nov 2022 01:43:29 -0800
In-Reply-To: <20221119081011.4372-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a0347605edcfa7b8@google.com>
Subject: Re: [syzbot] inconsistent lock state in sync_info_debugfs_show
From:   syzbot <syzbot+007bfe0f3330f6e1e7d1@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
inconsistent lock state in sync_info_debugfs_show

================================
WARNING: inconsistent lock state
6.1.0-rc5-syzkaller-00144-g84368d882b96-dirty #0 Not tainted
--------------------------------
inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
syz-executor.4/4365 [HC0[0]:SC0[0]:HE0:SE1] takes:
ffffffff8d295c38 (sync_timeline_list_lock){?...}-{2:2}, at: sync_info_debugfs_show+0x35/0x210 drivers/dma-buf/sync_debug.c:148
{IN-HARDIRQ-W} state was registered at:
  lock_acquire kernel/locking/lockdep.c:5668 [inline]
  lock_acquire+0x1e3/0x630 kernel/locking/lockdep.c:5633
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:162
  sync_timeline_debug_remove+0x29/0x1a0 drivers/dma-buf/sync_debug.c:31
  sync_timeline_free drivers/dma-buf/sw_sync.c:104 [inline]
  kref_put include/linux/kref.h:65 [inline]
  sync_timeline_put drivers/dma-buf/sw_sync.c:116 [inline]
  timeline_fence_release+0x267/0x340 drivers/dma-buf/sw_sync.c:144
  dma_fence_release+0x14b/0x690 drivers/dma-buf/dma-fence.c:559
  kref_put include/linux/kref.h:65 [inline]
  dma_fence_put include/linux/dma-fence.h:276 [inline]
  dma_fence_array_release+0x1fa/0x2d0 drivers/dma-buf/dma-fence-array.c:120
  dma_fence_release+0x14b/0x690 drivers/dma-buf/dma-fence.c:559
  kref_put include/linux/kref.h:65 [inline]
  dma_fence_put include/linux/dma-fence.h:276 [inline]
  irq_dma_fence_array_work+0xa9/0xd0 drivers/dma-buf/dma-fence-array.c:52
  irq_work_single+0x124/0x260 kernel/irq_work.c:211
  irq_work_run_list kernel/irq_work.c:242 [inline]
  irq_work_run_list+0x91/0xc0 kernel/irq_work.c:225
  irq_work_run+0x58/0xd0 kernel/irq_work.c:251
  __sysvec_irq_work+0xce/0x4e0 arch/x86/kernel/irq_work.c:22
  sysvec_irq_work+0x92/0xc0 arch/x86/kernel/irq_work.c:17
  asm_sysvec_irq_work+0x1a/0x20 arch/x86/include/asm/idtentry.h:675
  __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:160 [inline]
  _raw_spin_unlock_irq+0x29/0x50 kernel/locking/spinlock.c:202
  spin_unlock_irq include/linux/spinlock.h:400 [inline]
  sw_sync_debugfs_release+0x162/0x240 drivers/dma-buf/sw_sync.c:321
  __fput+0x27c/0xa90 fs/file_table.c:320
  task_work_run+0x16f/0x270 kernel/task_work.c:179
  resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
  exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
  exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:203
  __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
  syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:296
  do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
  entry_SYSCALL_64_after_hwframe+0x63/0xcd
irq event stamp: 94
hardirqs last  enabled at (93): [<ffffffff81d48585>] mod_objcg_state+0x595/0xa50 mm/memcontrol.c:3213
hardirqs last disabled at (94): [<ffffffff89f47ef2>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
hardirqs last disabled at (94): [<ffffffff89f47ef2>] _raw_spin_lock_irqsave+0x52/0x60 kernel/locking/spinlock.c:162
softirqs last  enabled at (0): [<ffffffff8149e759>] copy_process+0x2129/0x7190 kernel/fork.c:2198
softirqs last disabled at (0): [<0000000000000000>] 0x0

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(sync_timeline_list_lock);
  <Interrupt>
    lock(sync_timeline_list_lock);

 *** DEADLOCK ***

3 locks held by syz-executor.4/4365:
 #0: ffff888078122fe8 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe7/0x100 fs/file.c:1037
 #1: ffff888074a74540 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xe3/0x1280 fs/seq_file.c:182
 #2: ffffffff8d295c38 (sync_timeline_list_lock){?...}-{2:2}, at: sync_info_debugfs_show+0x35/0x210 drivers/dma-buf/sync_debug.c:148

stack backtrace:
CPU: 0 PID: 4365 Comm: syz-executor.4 Not tainted 6.1.0-rc5-syzkaller-00144-g84368d882b96-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_usage_bug kernel/locking/lockdep.c:3963 [inline]
 valid_state kernel/locking/lockdep.c:3975 [inline]
 mark_lock_irq kernel/locking/lockdep.c:4178 [inline]
 mark_lock.part.0.cold+0x18/0xd8 kernel/locking/lockdep.c:4634
 mark_lock kernel/locking/lockdep.c:4598 [inline]
 mark_held_locks+0x9f/0xe0 kernel/locking/lockdep.c:4236
 __trace_hardirqs_on_caller kernel/locking/lockdep.c:4254 [inline]
 lockdep_hardirqs_on_prepare kernel/locking/lockdep.c:4321 [inline]
 lockdep_hardirqs_on_prepare+0x139/0x410 kernel/locking/lockdep.c:4273
 trace_hardirqs_on+0x31/0x160 kernel/trace/trace_preemptirq.c:49
 __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
 _raw_spin_unlock_irq+0x23/0x50 kernel/locking/spinlock.c:202
 spin_unlock_irq include/linux/spinlock.h:400 [inline]
 sync_print_obj drivers/dma-buf/sync_debug.c:118 [inline]
 sync_info_debugfs_show+0xf4/0x210 drivers/dma-buf/sync_debug.c:154
 seq_read_iter+0x4f9/0x1280 fs/seq_file.c:230
 seq_read+0x171/0x210 fs/seq_file.c:162
 vfs_read+0x25b/0x930 fs/read_write.c:468
 ksys_read+0x12b/0x250 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f54a7e8b639
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f54a8b9c168 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f54a7fabf80 RCX: 00007f54a7e8b639
RDX: 0000000000002020 RSI: 0000000020002200 RDI: 0000000000000003
RBP: 00007f54a7ee6ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffcd4b693af R14: 00007f54a8b9c300 R15: 0000000000022000
 </TASK>
------------[ cut here ]------------
raw_local_irq_restore() called with IRQs enabled
WARNING: CPU: 0 PID: 4365 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x21/0x30 kernel/locking/irqflag-debug.c:10
Modules linked in:
CPU: 0 PID: 4365 Comm: syz-executor.4 Not tainted 6.1.0-rc5-syzkaller-00144-g84368d882b96-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:warn_bogus_irq_restore+0x21/0x30 kernel/locking/irqflag-debug.c:10
Code: b9 ff 0f 1f 80 00 00 00 00 f3 0f 1e fa 80 3d f3 d7 4c 04 00 74 01 c3 48 c7 c7 20 3c 4c 8a c6 05 e2 d7 4c 04 01 e8 5c bb b9 ff <0f> 0b c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa 44 8b 05
RSP: 0018:ffffc900056bfb30 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000000
RDX: ffff888028990000 RSI: ffffffff816574fc RDI: fffff52000ad7f58
RBP: ffffffff8d295c20 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 61636f6c5f776172 R12: ffff88807a69c740
R13: ffffffff8d295c80 R14: ffff88807a69c750 R15: ffff88807a69c740
FS:  00007f54a8b9c700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff7e6f85498 CR3: 000000007c48e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
 _raw_spin_unlock_irqrestore+0x63/0x70 kernel/locking/spinlock.c:194
 spin_unlock_irqrestore include/linux/spinlock.h:405 [inline]
 sync_info_debugfs_show+0x138/0x210 drivers/dma-buf/sync_debug.c:157
 seq_read_iter+0x4f9/0x1280 fs/seq_file.c:230
 seq_read+0x171/0x210 fs/seq_file.c:162
 vfs_read+0x25b/0x930 fs/read_write.c:468
 ksys_read+0x12b/0x250 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f54a7e8b639
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f54a8b9c168 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f54a7fabf80 RCX: 00007f54a7e8b639
RDX: 0000000000002020 RSI: 0000000020002200 RDI: 0000000000000003
RBP: 00007f54a7ee6ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffcd4b693af R14: 00007f54a8b9c300 R15: 0000000000022000
 </TASK>


Tested on:

commit:         84368d88 Merge tag 'soc-fixes-6.1-3' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16ad20fd880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6f4e5e9899396248
dashboard link: https://syzkaller.appspot.com/bug?extid=007bfe0f3330f6e1e7d1
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16ecc301880000

