Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E9366B703
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 06:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjAPF4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 00:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbjAPFzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 00:55:55 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA2E8A60
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 21:55:50 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id t3-20020a6bc303000000b006f7844c6298so17507820iof.23
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 21:55:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Neb0M9m1wuS/EiJZKNK8tyTuZyiCOJ+/j+azaSqhRls=;
        b=SzifcgbUR1cdMFxOQSvbEIhjNz9d+5KU1IbFPMQKnMsfqkK5RWBHKaAX4Nkf9eyyS3
         8defBfFbAsDrZMrWlcxFhbR/RuatKpWhcpvaQjuZ17M+Y8AGblAsI6rh2C8BpB6TgofK
         n0DRhcHrxQese3CFeMUohmuGd8cn2umPmRIIMDTZVYsShqVkiGdQVKcrEomb0zw93b3j
         6PIDKZ3RSWrffRTi/P7zHSkTpQ626JfOPA8ckmEela94AtHufMcnUHcB5RE++CJGejGR
         yY+yKug0OAelpIoNmae4q+ZOHJFB8co3nmDM7nznINrG9L5hv8josgTm5Kjqz8GoGmnD
         aAlQ==
X-Gm-Message-State: AFqh2kotnI7uOyfDJSydwVwnGhkX/Nh4B9LjDdvGEikewP0ufHBvuZwz
        adHGRMXiPW4Dj9ey6D3TyJZkZpIEMdqNyESY5v1X5CDns9i7
X-Google-Smtp-Source: AMrXdXuY6j0pIfj/op015EDT3XMTEE1KPDhSOnmOINBlGwf8rd77Zae3Fd9SY0PUzKGdBWgDB/Lqv8CnhQ6l1esLbjvFWhn1GYkH
MIME-Version: 1.0
X-Received: by 2002:a92:1a0b:0:b0:30d:8f68:cd9 with SMTP id
 a11-20020a921a0b000000b0030d8f680cd9mr4810898ila.274.1673848550134; Sun, 15
 Jan 2023 21:55:50 -0800 (PST)
Date:   Sun, 15 Jan 2023 21:55:50 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003d19f805f25b3c71@google.com>
Subject: [syzbot] [f2fs?] kernel BUG in __destroy_extent_tree
From:   syzbot <syzbot+15d87e3695975269de2c@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
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

HEAD commit:    5a41237ad1d4 gcc: disable -Warray-bounds for gcc-11 too
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11ffa85a480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2b6ecad960fc703e
dashboard link: https://syzkaller.appspot.com/bug?extid=15d87e3695975269de2c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+15d87e3695975269de2c@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/f2fs/extent_cache.c:1191!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 3 PID: 7706 Comm: syz-executor.3 Not tainted 6.2.0-rc3-syzkaller-00009-g5a41237ad1d4 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:__destroy_extent_tree+0x64a/0x7f0 fs/f2fs/extent_cache.c:1191
Code: 04 00 00 00 49 8d 9c 07 e8 0c 00 00 48 89 df e8 fc 00 22 fe f0 ff 03 48 8b 3c 24 e8 20 1c 5b 06 e9 93 fc ff ff e8 a6 fa d3 fd <0f> 0b e8 9f fa d3 fd e8 6a 1f 59 06 31 ff 89 c3 89 c6 e8 3f f7 d3
RSP: 0018:ffffc90027ee79c0 EFLAGS: 00010246
RAX: 0000000000040000 RBX: 0000000000000000 RCX: ffffc90007712000
RDX: 0000000000040000 RSI: ffffffff83ad57ba RDI: 0000000000000005
RBP: ffff8880754b0000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: ffff888044fd2000 R14: 0000000000000001 R15: ffff8880700e4000
FS:  0000000000000000(0000) GS:ffff88802c900000(0063) knlGS:00000000f7fa4b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00007f2dd53c836b CR3: 000000006d4f3000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 f2fs_destroy_extent_tree+0x17/0x30 fs/f2fs/extent_cache.c:1204
 f2fs_evict_inode+0x38b/0x1df0 fs/f2fs/inode.c:789
 evict+0x2ed/0x6b0 fs/inode.c:664
 iput_final fs/inode.c:1747 [inline]
 iput.part.0+0x59b/0x880 fs/inode.c:1773
 iput+0x5c/0x80 fs/inode.c:1763
 f2fs_abort_atomic_write+0xea/0x4f0 fs/f2fs/segment.c:196
 f2fs_release_file+0xc8/0xf0 fs/f2fs/file.c:1869
 __fput+0x27c/0xa90 fs/file_table.c:320
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 get_signal+0x1c7/0x2450 kernel/signal.c:2635
 arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:296
 __do_fast_syscall_32+0x72/0xf0 arch/x86/entry/common.c:181
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82
RIP: 0023:0xf7fa9549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f7fa45cc EFLAGS: 00000296 ORIG_RAX: 00000000000000bb
RAX: 00000000002dc7fb RBX: 0000000000000004 RCX: 0000000000000005
RDX: 0000000000000000 RSI: 0000000001000fc4 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__destroy_extent_tree+0x64a/0x7f0 fs/f2fs/extent_cache.c:1191
Code: 04 00 00 00 49 8d 9c 07 e8 0c 00 00 48 89 df e8 fc 00 22 fe f0 ff 03 48 8b 3c 24 e8 20 1c 5b 06 e9 93 fc ff ff e8 a6 fa d3 fd <0f> 0b e8 9f fa d3 fd e8 6a 1f 59 06 31 ff 89 c3 89 c6 e8 3f f7 d3
RSP: 0018:ffffc90027ee79c0 EFLAGS: 00010246
RAX: 0000000000040000 RBX: 0000000000000000 RCX: ffffc90007712000
RDX: 0000000000040000 RSI: ffffffff83ad57ba RDI: 0000000000000005
RBP: ffff8880754b0000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: ffff888044fd2000 R14: 0000000000000001 R15: ffff8880700e4000
FS:  0000000000000000(0000) GS:ffff88802c900000(0063) knlGS:00000000f7fa4b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00007f2dd53c836b CR3: 000000006d4f3000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	03 74 c0 01          	add    0x1(%rax,%rax,8),%esi
   4:	10 05 03 74 b8 01    	adc    %al,0x1b87403(%rip)        # 0x1b8740d
   a:	10 06                	adc    %al,(%rsi)
   c:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
  10:	10 07                	adc    %al,(%rdi)
  12:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
  16:	10 08                	adc    %cl,(%rax)
  18:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1c:	00 00                	add    %al,(%rax)
  1e:	00 00                	add    %al,(%rax)
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:	55                   	push   %rbp
  24:	89 e5                	mov    %esp,%ebp
  26:	0f 34                	sysenter
  28:	cd 80                	int    $0x80
* 2a:	5d                   	pop    %rbp <-- trapping instruction
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	retq
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  39:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
