Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD41F660A57
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 00:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjAFXkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 18:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjAFXkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 18:40:40 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6458CD25
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 15:40:39 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id r6-20020a92cd86000000b00304b2d1c2d7so1962993ilb.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 15:40:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QrrYWzcWoltzpv0siwXuUV/EY9s60gSFWDSPmIMm7r8=;
        b=52qtZipi1ZjEg+BIUOlPfF6OK7JKwCOhHcOL/0AZ3JFDdO6Z6XhiVTLyi5iWwIRAXJ
         AgjWIMmN+fsBu0OGevTBjySVpqIcUSJ6nceVaIeBTfap7J0UHhXKM54eGOjs2ZLHCisJ
         3x8Ogu2buHyDFFnVl3DmiSeHzTVJUJkkdHyAUAK6dJhsyQEKbW4YyudIVFKG75hKyZ7Q
         O/05HQ6p/GQDaqcLFIclAD+OaFROCo24ZyON6+/y4VRd647cv86tdp0dYUGPMiDJJFYo
         F/A/0iFEU47tHNLFq+lpf4cIVyBZ3s62DpC5BAWacL848BLqzOLpOB0Y1i03LkpNAptH
         eNvA==
X-Gm-Message-State: AFqh2kqo/rlbvcjHaeZUC6KlG4bGhFwKZj5HcXcqhhXu8XlGrj0vZlbX
        mwJquJQ85oBJxR18TJQ/s+oAr+iJ0ejxGbIR1unJnk6sxOGN
X-Google-Smtp-Source: AMrXdXutS8RDfLnzD3lIa3YX///H31+KBmn5njnZA5tmdvZEtFuY1CqehiT8fSHJvtsW+W1Z2/6ynHPSzJvzVVgzkLWh1UmCp2vm
MIME-Version: 1.0
X-Received: by 2002:a02:9f16:0:b0:38a:1a5d:45c2 with SMTP id
 z22-20020a029f16000000b0038a1a5d45c2mr5673954jal.97.1673048437374; Fri, 06
 Jan 2023 15:40:37 -0800 (PST)
Date:   Fri, 06 Jan 2023 15:40:37 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cd44f005f1a0f17f@google.com>
Subject: [syzbot] [squashfs?] general protection fault in cache_first_page
From:   syzbot <syzbot+082fa4af80a5bb1a9843@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, phillip@squashfs.org.uk,
        squashfs-devel@lists.sourceforge.net,
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

HEAD commit:    88603b6dc419 Linux 6.2-rc2
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16e730c6480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=46221e8203c7aca6
dashboard link: https://syzkaller.appspot.com/bug?extid=082fa4af80a5bb1a9843
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d010aa480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16e758ec480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b9db5f495357/disk-88603b6d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ebd0d1ab4d5f/vmlinux-88603b6d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3231ab35ff51/bzImage-88603b6d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/7af690061ab1/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+082fa4af80a5bb1a9843@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 8
general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 0 PID: 5061 Comm: syz-executor165 Not tainted 6.2.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:cache_first_page+0x60/0x90 fs/squashfs/page_actor.c:27
Code: 00 00 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 75 30 48 b8 00 00 00 00 00 fc ff df 48 8b 1b 48 89 da 48 c1 ea 03 <80> 3c 02 00 75 0c 48 8b 03 5b c3 e8 80 47 92 ff eb bc 48 89 df e8
RSP: 0018:ffffc90003cbfac0 EFLAGS: 00010212
RAX: dffffc0000000000 RBX: 0000000000000010 RCX: 0000000000000000
RDX: 0000000000000002 RSI: ffffffff823d0d6d RDI: ffff88801e25da40
RBP: ffff88807c718000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 000000000000035c R15: 0000000000000000
FS:  000055555707d300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc5ca52000 CR3: 0000000026419000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 squashfs_first_page fs/squashfs/page_actor.h:43 [inline]
 copy_bio_to_actor fs/squashfs/block.c:44 [inline]
 squashfs_read_data+0x7de/0xf50 fs/squashfs/block.c:221
 squashfs_read_table+0x15c/0x1f0 fs/squashfs/cache.c:432
 squashfs_read_xattr_id_table+0x20c/0x440 fs/squashfs/xattr_id.c:95
 squashfs_fill_super+0xf08/0x2700 fs/squashfs/super.c:348
 get_tree_bdev+0x444/0x760 fs/super.c:1282
 vfs_get_tree+0x8d/0x2f0 fs/super.c:1489
 do_new_mount fs/namespace.c:3145 [inline]
 path_mount+0x132a/0x1e20 fs/namespace.c:3475
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount fs/namespace.c:3674 [inline]
 __x64_sys_mount+0x283/0x300 fs/namespace.c:3674
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc524a6fafa
Code: 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc5ca51ad8 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fc524a6fafa
RDX: 0000000020000200 RSI: 0000000020000240 RDI: 00007ffc5ca51af0
RBP: 00007ffc5ca51af0 R08: 00007ffc5ca51b30 R09: 00000000000001f1
R10: 0000000000000000 R11: 0000000000000282 R12: 0000000000000004
R13: 000055555707d2c0 R14: 0000000000000000 R15: 00007ffc5ca51b30
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:cache_first_page+0x60/0x90 fs/squashfs/page_actor.c:27
Code: 00 00 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 75 30 48 b8 00 00 00 00 00 fc ff df 48 8b 1b 48 89 da 48 c1 ea 03 <80> 3c 02 00 75 0c 48 8b 03 5b c3 e8 80 47 92 ff eb bc 48 89 df e8
RSP: 0018:ffffc90003cbfac0 EFLAGS: 00010212
RAX: dffffc0000000000 RBX: 0000000000000010 RCX: 0000000000000000
RDX: 0000000000000002 RSI: ffffffff823d0d6d RDI: ffff88801e25da40
RBP: ffff88807c718000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 000000000000035c R15: 0000000000000000
FS:  000055555707d300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc5ca52000 CR3: 0000000026419000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
   9:	fc ff df
   c:	48 c1 ea 03          	shr    $0x3,%rdx
  10:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
  14:	75 30                	jne    0x46
  16:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1d:	fc ff df
  20:	48 8b 1b             	mov    (%rbx),%rbx
  23:	48 89 da             	mov    %rbx,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	75 0c                	jne    0x3c
  30:	48 8b 03             	mov    (%rbx),%rax
  33:	5b                   	pop    %rbx
  34:	c3                   	retq
  35:	e8 80 47 92 ff       	callq  0xff9247ba
  3a:	eb bc                	jmp    0xfffffff8
  3c:	48 89 df             	mov    %rbx,%rdi
  3f:	e8                   	.byte 0xe8


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
