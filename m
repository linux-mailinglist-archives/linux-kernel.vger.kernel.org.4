Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A42C5F1622
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 00:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbiI3W2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 18:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbiI3W1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 18:27:47 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280CFE5137
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 15:27:45 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id i13-20020a056e02152d00b002f58aea654fso4485644ilu.20
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 15:27:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=iM68O+nrezsM8T9jjDicidZ/blgRr6uFHhEtL5Spu3M=;
        b=y6HYe72zW/rKavZAK5Q5LrnR77VXKS5wGCwyxhsHkcTHVi/rRKWqJppYprCVHWvs8j
         kpHx5OmeF+BBKiJ0dxpRQQ2qmU+gX5V1cUk3yvNCBJ1BatS1oiGmVsMUFvNe9PxMAP8u
         DNiQ+jQXGRBWHTH/iHUbv6UPBE11GTHJfo+wmoteXwnNlaU1q68KvXb4kOTOyNjP13GZ
         gq4N1RnZzW8ZPfhV0Q798IhNaxUyuC4lMiyRgkggs2jikj6VJeHoZpWgNeKuYnlA//Fe
         TvQfrTfsULGJVNAAITDR8XxJhsfDXrj4DODa1ILchKCRI24REWiywUW0oHpT/XExD/on
         WcmQ==
X-Gm-Message-State: ACrzQf3vA64Mfxm9B61j2i0GBdjkmOUTlbFx0qiBfIhB0sL1YjBehyNZ
        dB3Y3wPP+v7FdqDsw8TeSp1iGCUsl+foNfdKAr8/3kCJ0TQ4
X-Google-Smtp-Source: AMsMyM59fGFjFSm+JImi+1B6GKoGkgcB5hs2xKBj3Ubq5bFQPFbmdL+ajPZ/3nnnxieEbxZ3DJZJq0dSrhzGZ8G94SeQeSz1njIy
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12cf:b0:2f5:ddd9:b3d3 with SMTP id
 i15-20020a056e0212cf00b002f5ddd9b3d3mr5196081ilm.122.1664576864305; Fri, 30
 Sep 2022 15:27:44 -0700 (PDT)
Date:   Fri, 30 Sep 2022 15:27:44 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b2c9fb05e9ec8058@google.com>
Subject: [syzbot] general protection fault in nilfs_bmap_lookup_at_level
From:   syzbot <syzbot+76f0ebea6c1e032bbe49@syzkaller.appspotmail.com>
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

HEAD commit:    aaa11ce2ffc8 Add linux-next specific files for 20220923
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12904574880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=186d1ff305f10294
dashboard link: https://syzkaller.appspot.com/bug?extid=76f0ebea6c1e032bbe49
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1181a5c4880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12bdc2e0880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/95c7bf83c07e/disk-aaa11ce2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b161cd56a7a3/vmlinux-aaa11ce2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+76f0ebea6c1e032bbe49@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 2048
general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 3609 Comm: syz-executor421 Not tainted 6.0.0-rc6-next-20220923-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:nilfs_bmap_lookup_at_level+0xb5/0x3e0 fs/nilfs2/bmap.c:69
Code: df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 95 02 00 00 48 8b 83 d8 00 00 00 48 ba 00 00 00 00 00 fc ff df 48 89 c1 48 c1 e9 03 <80> 3c 11 00 0f 85 7d 02 00 00 4c 89 e6 48 89 e9 44 89 fa 48 89 df
RSP: 0018:ffffc90003caf6d8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8880738da688 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: 0000000000000008 RDI: ffff8880738da760
RBP: ffffc90003caf7b8 R08: 0000000000000001 R09: ffff8880738da6cf
R10: ffffed100e71b4d9 R11: 000000000008c07e R12: 0000000000000002
R13: 1ffff92000795edc R14: ffff8880738da6c0 R15: 0000000000000001
FS:  0000555555ac8300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005d84c8 CR3: 000000005942f000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 nilfs_bmap_lookup fs/nilfs2/bmap.h:170 [inline]
 nilfs_mdt_submit_block+0x1a1/0xb40 fs/nilfs2/mdt.c:142
 nilfs_mdt_read_block+0x92/0x3c0 fs/nilfs2/mdt.c:176
 nilfs_mdt_get_block+0xe3/0xe00 fs/nilfs2/mdt.c:251
 nilfs_palloc_get_block+0xc4/0x2b0 fs/nilfs2/alloc.c:216
 nilfs_palloc_get_entry_block+0x167/0x1d0 fs/nilfs2/alloc.c:318
 nilfs_ifile_get_inode_block+0xbf/0x190 fs/nilfs2/ifile.c:143
 __nilfs_read_inode fs/nilfs2/inode.c:477 [inline]
 nilfs_iget+0x208/0x870 fs/nilfs2/inode.c:603
 nilfs_get_root_dentry+0x26/0x240 fs/nilfs2/super.c:904
 nilfs_fill_super fs/nilfs2/super.c:1078 [inline]
 nilfs_mount+0xbb2/0xfb0 fs/nilfs2/super.c:1317
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
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
RIP: 0033:0x7fd84078b60a
Code: 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc2a043bd8 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fd84078b60a
RDX: 0000000020000000 RSI: 0000000020000080 RDI: 00007ffc2a043bf0
RBP: 00007ffc2a043bf0 R08: 00007ffc2a043c30 R09: 0000555555ac82c0
R10: 0000000000000000 R11: 0000000000000286 R12: 0000000000000004
R13: 00007ffc2a043c30 R14: 000000000000003a R15: 0000000020000770
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:nilfs_bmap_lookup_at_level+0xb5/0x3e0 fs/nilfs2/bmap.c:69
Code: df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 95 02 00 00 48 8b 83 d8 00 00 00 48 ba 00 00 00 00 00 fc ff df 48 89 c1 48 c1 e9 03 <80> 3c 11 00 0f 85 7d 02 00 00 4c 89 e6 48 89 e9 44 89 fa 48 89 df
RSP: 0018:ffffc90003caf6d8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8880738da688 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: 0000000000000008 RDI: ffff8880738da760
RBP: ffffc90003caf7b8 R08: 0000000000000001 R09: ffff8880738da6cf
R10: ffffed100e71b4d9 R11: 000000000008c07e R12: 0000000000000002
R13: 1ffff92000795edc R14: ffff8880738da6c0 R15: 0000000000000001
FS:  0000555555ac8300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005d84c8 CR3: 000000005942f000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	df 48 89             	fisttps -0x77(%rax)
   3:	fa                   	cli
   4:	48 c1 ea 03          	shr    $0x3,%rdx
   8:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   c:	0f 85 95 02 00 00    	jne    0x2a7
  12:	48 8b 83 d8 00 00 00 	mov    0xd8(%rbx),%rax
  19:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
  20:	fc ff df
  23:	48 89 c1             	mov    %rax,%rcx
  26:	48 c1 e9 03          	shr    $0x3,%rcx
* 2a:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1) <-- trapping instruction
  2e:	0f 85 7d 02 00 00    	jne    0x2b1
  34:	4c 89 e6             	mov    %r12,%rsi
  37:	48 89 e9             	mov    %rbp,%rcx
  3a:	44 89 fa             	mov    %r15d,%edx
  3d:	48 89 df             	mov    %rbx,%rdi


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
