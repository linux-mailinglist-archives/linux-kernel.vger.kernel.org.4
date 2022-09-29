Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2773E5EFEC3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 22:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiI2Ukp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 16:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiI2Ukl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 16:40:41 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B959F391D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 13:40:40 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id n16-20020a6b5910000000b006a3570db9a5so1466664iob.23
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 13:40:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=EbZyKX+RCbtqQflUC9TIo65PRRHY5b9rWp8zxe/S5tw=;
        b=y1f3BcagGeUKgpP8SAAVo892iKWKip1icgY5ncB0R0zk/CMq6sj6+EZsF6jioASS4x
         fjRK6jj1CqPx5J0nphr84cUFxZVj1V3AsCmRCzlDZlC0+gj9PTcZ9Fc/1s3BANiG+DlF
         5xG/pJzAwF8riteFVnV5rAM81YY3VKl2m9VA9YBpipbHgNOfbU41pXmXrG2qrtkl1hZu
         NNqIIqPpqFZ9JnoRrI7CkRBu0SsC2cZ6xXLXKzLaw/m9zxXbBFAkClCl4FpwQcceMJuG
         Nzki8PAd+7gk5NTw/HHaVuh+h1mKFwtAh2kRDpe9a6i1kSJNAPZCz46ZwmGiGDBI0nrQ
         stKg==
X-Gm-Message-State: ACrzQf1rAsJEnEe2Zqn9bwSZN0MzxWnEIrVfLoZfUwU2nnbgoNfZ72xj
        6e+N4xFmd5BDPSrCDY4po4sZ7GLUTC7Cc6fsLhwGJwO1bAud
X-Google-Smtp-Source: AMsMyM6wbo3wz7PxEtq4rxRispog9iQwEN6YVNatXa2Koau/1cSswX+d9NFKNGJJyO0YDh/VOEvpfafokMV7RUM9cTDQTXHDVPHy
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148d:b0:2f9:36c5:f3e4 with SMTP id
 n13-20020a056e02148d00b002f936c5f3e4mr1849435ilk.218.1664484039656; Thu, 29
 Sep 2022 13:40:39 -0700 (PDT)
Date:   Thu, 29 Sep 2022 13:40:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eb0ba805e9d6e30e@google.com>
Subject: [syzbot] INFO: trying to register non-static key in nilfs_bmap_lookup_at_level
From:   syzbot <syzbot+2b32eb36c1a825b7a74c@syzkaller.appspotmail.com>
To:     konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org,
        linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    3800a713b607 Merge tag 'mm-hotfixes-stable-2022-09-26' of ..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12704b40880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5
dashboard link: https://syzkaller.appspot.com/bug?extid=2b32eb36c1a825b7a74c
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e930c0880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=157ce604880000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2b32eb36c1a825b7a74c@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 264192
NILFS (loop0): broken superblock, retrying with spare superblock (blocksize = 1024)
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 PID: 3614 Comm: syz-executor231 Not tainted 6.0.0-rc7-syzkaller-00029-g3800a713b607 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 assign_lock_key+0x212/0x220 kernel/locking/lockdep.c:979
 register_lock_class+0x18d/0x930 kernel/locking/lockdep.c:1292
 __lock_acquire+0xe4/0x1f60 kernel/locking/lockdep.c:4932
 lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5666
 down_read+0x39/0x50 kernel/locking/rwsem.c:1499
 nilfs_bmap_lookup_at_level+0x88/0x350 fs/nilfs2/bmap.c:68
 nilfs_bmap_lookup fs/nilfs2/bmap.h:170 [inline]
 nilfs_mdt_submit_block+0x23d/0x520 fs/nilfs2/mdt.c:142
 nilfs_mdt_read_block+0xa3/0x460 fs/nilfs2/mdt.c:176
 nilfs_mdt_get_block+0x104/0x820 fs/nilfs2/mdt.c:251
 nilfs_palloc_get_block+0x142/0x240 fs/nilfs2/alloc.c:216
 nilfs_palloc_get_entry_block+0x1e8/0x2e0 fs/nilfs2/alloc.c:318
 nilfs_ifile_get_inode_block+0xf0/0x1a0 fs/nilfs2/ifile.c:143
 __nilfs_read_inode fs/nilfs2/inode.c:477 [inline]
 nilfs_iget+0x253/0x8b0 fs/nilfs2/inode.c:603
 nilfs_get_root_dentry+0x28/0x230 fs/nilfs2/super.c:904
 nilfs_fill_super+0x3dd/0x5d0 fs/nilfs2/super.c:1078
 nilfs_mount+0x613/0x9b0 fs/nilfs2/super.c:1317
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x88/0x270 fs/super.c:1530
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7efd97e9462a
Code: 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc213b3aa8 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffc213b3b00 RCX: 00007efd97e9462a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffc213b3ac0
RBP: 00007ffc213b3ac0 R08: 00007ffc213b3b00 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000286 R12: 0000000020000788
R13: 0000000000000003 R14: 0000000000000004 R15: 000000000000003b
 </TASK>
general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 PID: 3614 Comm: syz-executor231 Not tainted 6.0.0-rc7-syzkaller-00029-g3800a713b607 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
RIP: 0010:nilfs_bmap_lookup_at_level+0xb9/0x350 fs/nilfs2/bmap.c:69
Code: 48 89 d8 48 c1 e8 03 42 80 3c 30 00 74 08 48 89 df e8 4b 9b 94 fe 4c 8b 33 4c 89 f0 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 4c 89 f7 e8 29 9b 94 fe 4c 89 ff 4c 89 ee 44 89
RSP: 0018:ffffc9000385f440 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888074ff2760 RCX: dffffc0000000000
RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffff888074ff26c8
RBP: ffffc9000385f4f0 R08: dffffc0000000000 R09: ffffed100e9fe4da
R10: ffffed100e9fe4da R11: 1ffff1100e9fe4d9 R12: 0000000000000001
R13: 0000000000000002 R14: 0000000000000000 R15: ffff888074ff2688
FS:  0000555555be2300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc213b4000 CR3: 00000000725e8000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 nilfs_bmap_lookup fs/nilfs2/bmap.h:170 [inline]
 nilfs_mdt_submit_block+0x23d/0x520 fs/nilfs2/mdt.c:142
 nilfs_mdt_read_block+0xa3/0x460 fs/nilfs2/mdt.c:176
 nilfs_mdt_get_block+0x104/0x820 fs/nilfs2/mdt.c:251
 nilfs_palloc_get_block+0x142/0x240 fs/nilfs2/alloc.c:216
 nilfs_palloc_get_entry_block+0x1e8/0x2e0 fs/nilfs2/alloc.c:318
 nilfs_ifile_get_inode_block+0xf0/0x1a0 fs/nilfs2/ifile.c:143
 __nilfs_read_inode fs/nilfs2/inode.c:477 [inline]
 nilfs_iget+0x253/0x8b0 fs/nilfs2/inode.c:603
 nilfs_get_root_dentry+0x28/0x230 fs/nilfs2/super.c:904
 nilfs_fill_super+0x3dd/0x5d0 fs/nilfs2/super.c:1078
 nilfs_mount+0x613/0x9b0 fs/nilfs2/super.c:1317
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x88/0x270 fs/super.c:1530
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7efd97e9462a
Code: 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc213b3aa8 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffc213b3b00 RCX: 00007efd97e9462a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffc213b3ac0
RBP: 00007ffc213b3ac0 R08: 00007ffc213b3b00 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000286 R12: 0000000020000788
R13: 0000000000000003 R14: 0000000000000004 R15: 000000000000003b
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:nilfs_bmap_lookup_at_level+0xb9/0x350 fs/nilfs2/bmap.c:69
Code: 48 89 d8 48 c1 e8 03 42 80 3c 30 00 74 08 48 89 df e8 4b 9b 94 fe 4c 8b 33 4c 89 f0 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 4c 89 f7 e8 29 9b 94 fe 4c 89 ff 4c 89 ee 44 89
RSP: 0018:ffffc9000385f440 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888074ff2760 RCX: dffffc0000000000
RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffff888074ff26c8
RBP: ffffc9000385f4f0 R08: dffffc0000000000 R09: ffffed100e9fe4da
R10: ffffed100e9fe4da R11: 1ffff1100e9fe4d9 R12: 0000000000000001
R13: 0000000000000002 R14: 0000000000000000 R15: ffff888074ff2688
FS:  0000555555be2300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000560cba9be408 CR3: 00000000725e8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 89 d8             	mov    %rbx,%rax
   3:	48 c1 e8 03          	shr    $0x3,%rax
   7:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1)
   c:	74 08                	je     0x16
   e:	48 89 df             	mov    %rbx,%rdi
  11:	e8 4b 9b 94 fe       	callq  0xfe949b61
  16:	4c 8b 33             	mov    (%rbx),%r14
  19:	4c 89 f0             	mov    %r14,%rax
  1c:	48 c1 e8 03          	shr    $0x3,%rax
  20:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  27:	fc ff df
* 2a:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	4c 89 f7             	mov    %r14,%rdi
  33:	e8 29 9b 94 fe       	callq  0xfe949b61
  38:	4c 89 ff             	mov    %r15,%rdi
  3b:	4c 89 ee             	mov    %r13,%rsi
  3e:	44                   	rex.R
  3f:	89                   	.byte 0x89


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
