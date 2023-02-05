Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E59868B055
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 15:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjBEOoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 09:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjBEOoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 09:44:19 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4791F13DD2
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 06:44:18 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id h2-20020a92c262000000b00313b8b647ceso1721581ild.15
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 06:44:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D3DOYQw9aO1p9JZP5FrT+FlvtwxGai9F1qI0Lirdb94=;
        b=S/xSJ0J+69YULWptZdds2ETl/bJwUGn1ltt81OM6nqf2PO/+/pDrLeGIpD5zRuC3jV
         lOcMjjLGX07tSRuZYinYN/U6M3dvvj3WkbISBA1OvE6YtUw4Mb+FBoahtW5irk0Q1t2m
         rw6O8w5CDWqNAemYludfBJE0hfXnhBvzJy+A0cPEACBKWW7p/I0l+nyKtQehTrXWccaN
         aR4eUN7egJI0i3LyTXAgJmJ8hZu7slTCzHOop4mU1PFlf6PZsg9zEIYUYUkBG5JzybVA
         22fgDk2YFCXoM9Wbo8X1NODm4av5D537H8JXrKzKv23JzgG/hCjRbABZ3t/DZs4yKvPN
         k/AA==
X-Gm-Message-State: AO0yUKWbowEaoNwnXOBuxLrALwBao07N1HDH43GIuDK3K7ogz6OW4a1u
        BX++UuZheFEBRpMmMo69QHuoRKewnm0D4eZvCkdtDap1GxH8
X-Google-Smtp-Source: AK7set9MiJTVYMKg3HcBRpyvuls8Ducrk8nmwgOWU3AGCtzOKhe//+b/7albFuebk1dp3fwBAjEi0njmI+FX/AlBjINLHht4EIpB
MIME-Version: 1.0
X-Received: by 2002:a92:7110:0:b0:310:a8b8:13f1 with SMTP id
 m16-20020a927110000000b00310a8b813f1mr3645181ilc.20.1675608257624; Sun, 05
 Feb 2023 06:44:17 -0800 (PST)
Date:   Sun, 05 Feb 2023 06:44:17 -0800
In-Reply-To: <20230205141722.1670-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa83bb05f3f4f2f3@google.com>
Subject: Re: [syzbot] general protection fault in __blk_rq_map_sg
From:   syzbot <syzbot+0bbf896c8341c8e137c2@syzkaller.appspotmail.com>
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
general protection fault in do_exit

general protection fault, probably for non-canonical address 0xdffffc000000000e: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000070-0x0000000000000077]
CPU: 1 PID: 5774 Comm: syz-executor.4 Not tainted 6.2.0-rc6-next-20230203-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
RIP: 0010:find_child_reaper kernel/exit.c:585 [inline]
RIP: 0010:forget_original_parent kernel/exit.c:693 [inline]
RIP: 0010:exit_notify kernel/exit.c:730 [inline]
RIP: 0010:do_exit+0xbd7/0x2b60 kernel/exit.c:889
Code: 85 89 12 00 00 e8 79 fa 36 00 48 89 df e8 21 1c 07 00 48 8d 78 70 48 89 c5 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 62 1b 00 00 48 8b 45 70 48 39 c3 48 89 04 24 0f
RSP: 0018:ffffc90005d9fc00 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: ffff88801901d7c0 RCX: 0000000000000000
RDX: 000000000000000e RSI: ffffffff81548cf9 RDI: 0000000000000070
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000003
R10: fffff52000bb3f72 R11: 0000000000000000 R12: 0000000000000001
R13: ffff88807ef04028 R14: 0000000000000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe617f4e718 CR3: 000000002923b000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1019
 get_signal+0x2321/0x25b0 kernel/signal.c:2859
 arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe61728c0c9
Code: Unable to access opcode bytes at 0x7fe61728c09f.
RSP: 002b:00007fe617f6f218 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: 0000000000000001 RBX: 00007fe6173abf88 RCX: 00007fe61728c0c9
RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00007fe6173abf8c
RBP: 00007fe6173abf80 R08: 00007ffe35fc5080 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fe6173abf8c
R13: 00007ffe35e051ff R14: 00007fe617f6f300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:find_child_reaper kernel/exit.c:585 [inline]
RIP: 0010:forget_original_parent kernel/exit.c:693 [inline]
RIP: 0010:exit_notify kernel/exit.c:730 [inline]
RIP: 0010:do_exit+0xbd7/0x2b60 kernel/exit.c:889
Code: 85 89 12 00 00 e8 79 fa 36 00 48 89 df e8 21 1c 07 00 48 8d 78 70 48 89 c5 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 62 1b 00 00 48 8b 45 70 48 39 c3 48 89 04 24 0f
RSP: 0018:ffffc90005d9fc00 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: ffff88801901d7c0 RCX: 0000000000000000
RDX: 000000000000000e RSI: ffffffff81548cf9 RDI: 0000000000000070
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000003
R10: fffff52000bb3f72 R11: 0000000000000000 R12: 0000000000000001
R13: ffff88807ef04028 R14: 0000000000000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe617f4e718 CR3: 000000002923b000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	85 89 12 00 00 e8    	test   %ecx,-0x17ffffee(%rcx)
   6:	79 fa                	jns    0x2
   8:	36 00 48 89          	add    %cl,%ss:-0x77(%rax)
   c:	df e8                	fucomip %st(0),%st
   e:	21 1c 07             	and    %ebx,(%rdi,%rax,1)
  11:	00 48 8d             	add    %cl,-0x73(%rax)
  14:	78 70                	js     0x86
  16:	48 89 c5             	mov    %rax,%rbp
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 62 1b 00 00    	jne    0x1b96
  34:	48 8b 45 70          	mov    0x70(%rbp),%rax
  38:	48 39 c3             	cmp    %rax,%rbx
  3b:	48 89 04 24          	mov    %rax,(%rsp)
  3f:	0f                   	.byte 0xf


Tested on:

commit:         4fafd969 Add linux-next specific files for 20230203
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12b901bb480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d2fba7d42502ca4
dashboard link: https://syzkaller.appspot.com/bug?extid=0bbf896c8341c8e137c2
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14d1b8f5480000

