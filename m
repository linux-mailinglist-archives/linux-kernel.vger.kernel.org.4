Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D81601A58
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 22:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbiJQUdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 16:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbiJQUdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:33:12 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450001055A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 13:30:29 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id n23-20020a056602341700b00689fc6dbfd6so7848630ioz.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 13:30:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0aRZnWQx663K6Lo9Hk3wjtJ6AUi7MWNBqWSPYXZThJY=;
        b=U7aqhrxT+7Fiv3/gfaUCZVTyaUCMrPYF5fkKPpHiASYqcj99JH7zy2ZbnMvuyqSj3K
         FQz9p6W32hxQ7xKUneVArv7PP58xVGvXKPnlMHUGKICiWfZuPG2yceqoXlm9FkERold/
         AWwKwcguyZ738zi7u+tuzfI6ZHpmsMmxh8tXV9jjJcuR6uTTuq8w/WCzsu7yJ6ysbnCi
         3sGz27df8AGfkdDnbVMaqlF1qYZa8DQcjon11eLd/tntWWW/fvoelHDSUOVanvW7G3J2
         d4/UxZAaWXsUf9M/2jSC8c/EHYBGDefg9pE3yjfLj9itYGZs6Ko7DL6Z28yiUqRGr37s
         lpQA==
X-Gm-Message-State: ACrzQf1PnzY4/oZu4WPkEph1sTBsUMlJ81pJ14025n8RKKphNAxwnQjr
        ZJEllLwxUmm/1IA3808PVGkkFnFBynXyYl+AxvE/jR31qxNc
X-Google-Smtp-Source: AMsMyM7suOejM/UnywEOzK3mlpTRO/zaG6ncTErVpkreA1OkSeNca/dFhzmpMkiQb13ZnzUIjR6TVRma8mc8jqvilVgV3uuSu5Ls
MIME-Version: 1.0
X-Received: by 2002:a5e:a602:0:b0:6bb:ed93:5b63 with SMTP id
 q2-20020a5ea602000000b006bbed935b63mr5301638ioi.88.1666038469987; Mon, 17 Oct
 2022 13:27:49 -0700 (PDT)
Date:   Mon, 17 Oct 2022 13:27:49 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002f9ede05eb40cfbd@google.com>
Subject: [syzbot] general protection fault in end_page_writeback
From:   syzbot <syzbot+c9db9ae0bd780a3094e1@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    55be6084c8e0 Merge tag 'timers-core-2022-10-05' of git://g..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=176e95e6880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df75278aabf0681a
dashboard link: https://syzkaller.appspot.com/bug?extid=c9db9ae0bd780a3094e1
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ad8cc2880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=106b5906880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6c791937c012/disk-55be6084.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cb21a2879b4c/vmlinux-55be6084.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2fd8e3559f6d/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c9db9ae0bd780a3094e1@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000009: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000048-0x000000000000004f]
CPU: 1 PID: 3607 Comm: segctord Not tainted 6.0.0-syzkaller-09589-g55be6084c8e0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:_compound_head include/linux/page-flags.h:253 [inline]
RIP: 0010:end_page_writeback+0x21/0x130 mm/folio-compat.c:26
Code: 00 eb b9 66 0f 1f 44 00 00 41 54 55 48 89 fd 53 e8 94 71 d3 ff 48 8d 7d 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 e4 00 00 00 4c 8b 65 08 31 ff 4c 89 e3 83 e3 01
RSP: 0018:ffffc90003f9fb20 EFLAGS: 00010216
RAX: dffffc0000000000 RBX: ffff888071099570 RCX: 0000000000000000
RDX: 0000000000000009 RSI: ffffffff81a7d8ac RDI: 0000000000000048
RBP: 0000000000000040 R08: 0000000000000001 R09: ffff888071099577
R10: ffffed100e2132ae R11: 0000000000000001 R12: ffff8880754f21f8
R13: dffffc0000000000 R14: 0000000000000040 R15: ffffea0002d63e00
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000079554000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 nilfs_segctor_complete_write fs/nilfs2/segment.c:1836 [inline]
 nilfs_segctor_wait fs/nilfs2/segment.c:1923 [inline]
 nilfs_segctor_do_construct+0x491a/0x6970 fs/nilfs2/segment.c:2086
 nilfs_segctor_construct+0x8e3/0xb30 fs/nilfs2/segment.c:2375
 nilfs_segctor_thread_construct fs/nilfs2/segment.c:2483 [inline]
 nilfs_segctor_thread+0x3c3/0xf30 fs/nilfs2/segment.c:2566
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:_compound_head include/linux/page-flags.h:253 [inline]
RIP: 0010:end_page_writeback+0x21/0x130 mm/folio-compat.c:26
Code: 00 eb b9 66 0f 1f 44 00 00 41 54 55 48 89 fd 53 e8 94 71 d3 ff 48 8d 7d 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 e4 00 00 00 4c 8b 65 08 31 ff 4c 89 e3 83 e3 01
RSP: 0018:ffffc90003f9fb20 EFLAGS: 00010216
RAX: dffffc0000000000 RBX: ffff888071099570 RCX: 0000000000000000
RDX: 0000000000000009 RSI: ffffffff81a7d8ac RDI: 0000000000000048
RBP: 0000000000000040 R08: 0000000000000001 R09: ffff888071099577
R10: ffffed100e2132ae R11: 0000000000000001 R12: ffff8880754f21f8
R13: dffffc0000000000 R14: 0000000000000040 R15: ffffea0002d63e00
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f966c269290 CR3: 000000007ec55000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	00 eb                	add    %ch,%bl
   2:	b9 66 0f 1f 44       	mov    $0x441f0f66,%ecx
   7:	00 00                	add    %al,(%rax)
   9:	41 54                	push   %r12
   b:	55                   	push   %rbp
   c:	48 89 fd             	mov    %rdi,%rbp
   f:	53                   	push   %rbx
  10:	e8 94 71 d3 ff       	callq  0xffd371a9
  15:	48 8d 7d 08          	lea    0x8(%rbp),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 e4 00 00 00    	jne    0x118
  34:	4c 8b 65 08          	mov    0x8(%rbp),%r12
  38:	31 ff                	xor    %edi,%edi
  3a:	4c 89 e3             	mov    %r12,%rbx
  3d:	83 e3 01             	and    $0x1,%ebx


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
