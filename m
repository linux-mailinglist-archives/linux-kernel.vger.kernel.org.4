Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D808661E2F4
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 16:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiKFPYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 10:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiKFPYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 10:24:47 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1021F2DCC
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 07:24:46 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id h8-20020a05660224c800b006d8de87e192so1807245ioe.6
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 07:24:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0WExPyMyjMe3IiUa53gV64rIuVSNFwd1b1MIc+Fmyns=;
        b=Ht7p+v+b0KIywkKw0Ia4CkK68bkcO71RW/3pwmH/f92verFJDcI0BrDQ27pj2I2GJe
         6Dmk/dpBYsKK82G4zvdQMsdTr5o8VaUROaoexpgUvE+r68Ui6PBiSKeZUPxocylry3cq
         HtUwVxOFxeoX/Ahiy5rsga66Gg5+MFLS1QwxD5Rsx5uqzwwvIi2SMECwnYxGTb+xIa/o
         NygCGVAothg0rxK7z3bc3I3wmL2sTZoCEvXGU8Ux21ApBWyEqdi1x7IJpJY2MRJ9LqnB
         fUZGVJTwf7jAZCVl3opFZTxWpk/HNxWRkjatcYCgtN0ERuw0QvuJghtHKJFZK4AimuWJ
         nYmA==
X-Gm-Message-State: ACrzQf1w64izIwngN/bfIMp42C/m9YnYmcqWJrDqPa51FLmpWbT1h6jp
        GPhiUFMPHz51PcHQJqtczDOKQW9mhOZ/NuIZRZAe745AOZ6V
X-Google-Smtp-Source: AMsMyM7SU5Q6Ux9kMvgdJ5fXQw6EBoo29bKvjspLB7bbRgs36JoD1SomFNOgbwNr9tEK2HlCLi4dHTwLNdYpO0WQIi2Sght+ONy0
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:ee9:b0:300:ef0e:9381 with SMTP id
 j9-20020a056e020ee900b00300ef0e9381mr6635492ilk.252.1667748285376; Sun, 06
 Nov 2022 07:24:45 -0800 (PST)
Date:   Sun, 06 Nov 2022 07:24:45 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001ff0fa05eccee8e2@google.com>
Subject: [syzbot] general protection fault in blk_mq_update_nr_hw_queues
From:   syzbot <syzbot+746a4eece09f86bc39d7@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    61c3426aca2c Add linux-next specific files for 20221102
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14473561880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=acb529cc910d907c
dashboard link: https://syzkaller.appspot.com/bug?extid=746a4eece09f86bc39d7
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=109e96a6880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15d036de880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cc56d88dd6a3/disk-61c3426a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5921b65b080f/vmlinux-61c3426a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/39cbd355fedd/bzImage-61c3426a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+746a4eece09f86bc39d7@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc000000001d: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x00000000000000e8-0x00000000000000ef]
CPU: 0 PID: 5234 Comm: syz-executor931 Not tainted 6.1.0-rc3-next-20221102-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
RIP: 0010:__elevator_get block/elevator.h:94 [inline]
RIP: 0010:blk_mq_elv_switch_none block/blk-mq.c:4593 [inline]
RIP: 0010:__blk_mq_update_nr_hw_queues block/blk-mq.c:4658 [inline]
RIP: 0010:blk_mq_update_nr_hw_queues+0x304/0xe40 block/blk-mq.c:4709
Code: 8d 47 18 49 89 6f 10 4c 89 c0 48 c1 e8 03 80 3c 18 00 0f 85 f7 09 00 00 49 8b 47 18 48 8d b8 e8 00 00 00 48 89 fa 48 c1 ea 03 <80> 3c 1a 00 0f 85 12 09 00 00 48 8b b8 e8 00 00 00 4c 89 44 24 08
RSP: 0018:ffffc90003cdfc08 EFLAGS: 00010206
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: 000000000000001d RSI: 0000000000000002 RDI: 00000000000000e8
RBP: ffff88801dbd0000 R08: ffff888027c89398 R09: ffffffff8de2e517
R10: fffffbfff1bc5ca2 R11: 0000000000000000 R12: ffffc90003cdfc70
R13: ffff88801dbd0008 R14: ffff88801dbd03f8 R15: ffff888027c89380
FS:  0000555557259300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005d84c8 CR3: 000000007a7cb000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 nbd_start_device+0x153/0xc30 drivers/block/nbd.c:1355
 nbd_start_device_ioctl drivers/block/nbd.c:1405 [inline]
 __nbd_ioctl drivers/block/nbd.c:1481 [inline]
 nbd_ioctl+0x5a1/0xbd0 drivers/block/nbd.c:1521
 blkdev_ioctl+0x36e/0x800 block/ioctl.c:614
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f41f05946b9
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff1b23e808 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f41f05946b9
RDX: 0000000000000000 RSI: 000000000000ab03 RDI: 0000000000000006
RBP: 00007f41f05541c0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f41f0554250
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__elevator_get block/elevator.h:94 [inline]
RIP: 0010:blk_mq_elv_switch_none block/blk-mq.c:4593 [inline]
RIP: 0010:__blk_mq_update_nr_hw_queues block/blk-mq.c:4658 [inline]
RIP: 0010:blk_mq_update_nr_hw_queues+0x304/0xe40 block/blk-mq.c:4709
Code: 8d 47 18 49 89 6f 10 4c 89 c0 48 c1 e8 03 80 3c 18 00 0f 85 f7 09 00 00 49 8b 47 18 48 8d b8 e8 00 00 00 48 89 fa 48 c1 ea 03 <80> 3c 1a 00 0f 85 12 09 00 00 48 8b b8 e8 00 00 00 4c 89 44 24 08
RSP: 0018:ffffc90003cdfc08 EFLAGS: 00010206
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: 000000000000001d RSI: 0000000000000002 RDI: 00000000000000e8
RBP: ffff88801dbd0000 R08: ffff888027c89398 R09: ffffffff8de2e517
R10: fffffbfff1bc5ca2 R11: 0000000000000000 R12: ffffc90003cdfc70
R13: ffff88801dbd0008 R14: ffff88801dbd03f8 R15: ffff888027c89380
FS:  0000555557259300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005d84c8 CR3: 000000007a7cb000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	8d 47 18             	lea    0x18(%rdi),%eax
   3:	49 89 6f 10          	mov    %rbp,0x10(%r15)
   7:	4c 89 c0             	mov    %r8,%rax
   a:	48 c1 e8 03          	shr    $0x3,%rax
   e:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1)
  12:	0f 85 f7 09 00 00    	jne    0xa0f
  18:	49 8b 47 18          	mov    0x18(%r15),%rax
  1c:	48 8d b8 e8 00 00 00 	lea    0xe8(%rax),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 1a 00          	cmpb   $0x0,(%rdx,%rbx,1) <-- trapping instruction
  2e:	0f 85 12 09 00 00    	jne    0x946
  34:	48 8b b8 e8 00 00 00 	mov    0xe8(%rax),%rdi
  3b:	4c 89 44 24 08       	mov    %r8,0x8(%rsp)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
