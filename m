Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D21763C622
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 18:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235817AbiK2RIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 12:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbiK2RIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 12:08:37 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A4C2A26B
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 09:08:34 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id a14-20020a6b660e000000b006bd37975cdfso9104155ioc.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 09:08:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n/iYeqRRs+ycgocNCXTBS7DFXD4I++u9Vwhwd2n4M8o=;
        b=dcSHZobWEzi10x/WJd8cDTNApeLsVw8NAnnFOcU4wgDlcfVVxKjZljIUXo0Cvm0mUW
         SELV/46XbsbpMCkjYzejPFsqVCvijwhnyxuWgtodeshLG6THiAwndgvPZXgEXRQbhfce
         V6KMwCOEPl8YmXMECvJSyQzeRd9o27xa5qDhGoASlr563LPGmOgsKLfELRbPSOcBzEak
         lgnaVjI8lfbE0GOFBhGcr8KX0nFSeDhe8eeYZKcJCiS70pKVUQf1hPbt2AgryB9FQrog
         6Qh2nf0In0Wv00K2jak7Vx/wYkhHQpvIQNTR38VY69hVJ7fCGlrYWhn0qB4K5lWIj3ZH
         Bblg==
X-Gm-Message-State: ANoB5pmsIvwwQQatIGVI1wvJOpJa7HuuRaMZI0sKacwgUAazRlqA8kDp
        pDCCep4duEzYdQy2FWnNWlIpLmx3dcR8o/9tQ2qSRLfNAiGU
X-Google-Smtp-Source: AA0mqf7tUKMaDt1DXlCD09+X4V9AquPETONt4m4QkzSslayygQ5oLbLI6kr/9gT+hRwvtBCMS4NVqZJ+xGHtfS8tyQyJT5JAROpC
MIME-Version: 1.0
X-Received: by 2002:a92:c5c1:0:b0:300:df8b:cfed with SMTP id
 s1-20020a92c5c1000000b00300df8bcfedmr19643956ilt.272.1669741713475; Tue, 29
 Nov 2022 09:08:33 -0800 (PST)
Date:   Tue, 29 Nov 2022 09:08:33 -0800
In-Reply-To: <000000000000ec75b005ee97fbaa@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b2d21905ee9f0944@google.com>
Subject: Re: [syzbot] WARNING in rmqueue
From:   syzbot <syzbot+aafb3f37cfeb6534c4ac@syzkaller.appspotmail.com>
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
BUG: unable to handle kernel paging request in z_erofs_decompress_queue

BUG: unable to handle page fault for address: fffff5210193fffa
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 23ffed067 P4D 23ffed067 PUD 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 48 Comm: kworker/u5:0 Not tainted 6.1.0-rc7-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: erofs_unzipd z_erofs_decompressqueue_work
RIP: 0010:z_erofs_do_decompressed_bvec fs/erofs/zdata.c:896 [inline]
RIP: 0010:z_erofs_parse_out_bvecs fs/erofs/zdata.c:969 [inline]
RIP: 0010:z_erofs_decompress_pcluster fs/erofs/zdata.c:1056 [inline]
RIP: 0010:z_erofs_decompress_queue+0xad1/0x2c30 fs/erofs/zdata.c:1155
Code: a8 00 00 00 42 80 3c 20 00 74 0a 48 8b 7c 24 70 e8 d4 1c f6 fd 89 db 48 c1 e3 03 48 03 9c 24 40 03 00 00 49 89 de 49 c1 ee 03 <43> 80 3c 26 00 74 08 48 89 df e8 b0 1c f6 fd 48 83 3b 00 0f 84 bd
RSP: 0018:ffffc90000b97780 EFLAGS: 00010a06
RAX: 1ffff92000172f58 RBX: ffffc9080c9fffd0 RCX: 0000000000000000
RDX: ffff888018b2d7c0 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90000b97b90 R08: ffffffff83e894a8 R09: fffff52001940000
R10: fffffbfff23bc68d R11: 1ffffffff23bc68c R12: dffffc0000000000
R13: 00000000ffff9f00 R14: 1ffff9210193fffa R15: ffff8880717b71f0
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffff5210193fffa CR3: 00000000277fc000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 z_erofs_decompressqueue_work+0x95/0xe0 fs/erofs/zdata.c:1167
 process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Modules linked in:
CR2: fffff5210193fffa
---[ end trace 0000000000000000 ]---
RIP: 0010:z_erofs_do_decompressed_bvec fs/erofs/zdata.c:896 [inline]
RIP: 0010:z_erofs_parse_out_bvecs fs/erofs/zdata.c:969 [inline]
RIP: 0010:z_erofs_decompress_pcluster fs/erofs/zdata.c:1056 [inline]
RIP: 0010:z_erofs_decompress_queue+0xad1/0x2c30 fs/erofs/zdata.c:1155
Code: a8 00 00 00 42 80 3c 20 00 74 0a 48 8b 7c 24 70 e8 d4 1c f6 fd 89 db 48 c1 e3 03 48 03 9c 24 40 03 00 00 49 89 de 49 c1 ee 03 <43> 80 3c 26 00 74 08 48 89 df e8 b0 1c f6 fd 48 83 3b 00 0f 84 bd
RSP: 0018:ffffc90000b97780 EFLAGS: 00010a06
RAX: 1ffff92000172f58 RBX: ffffc9080c9fffd0 RCX: 0000000000000000
RDX: ffff888018b2d7c0 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90000b97b90 R08: ffffffff83e894a8 R09: fffff52001940000
R10: fffffbfff23bc68d R11: 1ffffffff23bc68c R12: dffffc0000000000
R13: 00000000ffff9f00 R14: 1ffff9210193fffa R15: ffff8880717b71f0
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffff5210193fffa CR3: 00000000277fc000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	a8 00                	test   $0x0,%al
   2:	00 00                	add    %al,(%rax)
   4:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1)
   9:	74 0a                	je     0x15
   b:	48 8b 7c 24 70       	mov    0x70(%rsp),%rdi
  10:	e8 d4 1c f6 fd       	callq  0xfdf61ce9
  15:	89 db                	mov    %ebx,%ebx
  17:	48 c1 e3 03          	shl    $0x3,%rbx
  1b:	48 03 9c 24 40 03 00 	add    0x340(%rsp),%rbx
  22:	00
  23:	49 89 de             	mov    %rbx,%r14
  26:	49 c1 ee 03          	shr    $0x3,%r14
* 2a:	43 80 3c 26 00       	cmpb   $0x0,(%r14,%r12,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 b0 1c f6 fd       	callq  0xfdf61ce9
  39:	48 83 3b 00          	cmpq   $0x0,(%rbx)
  3d:	0f                   	.byte 0xf
  3e:	84                   	.byte 0x84
  3f:	bd                   	.byte 0xbd


Tested on:

commit:         b7b275e6 Linux 6.1-rc7
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15bd42a7880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2325e409a9a893e1
dashboard link: https://syzkaller.appspot.com/bug?extid=aafb3f37cfeb6534c4ac
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11028fed880000

