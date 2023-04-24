Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1995D6EC7BE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 10:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjDXIRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 04:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjDXIRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 04:17:41 -0400
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D91110
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 01:17:40 -0700 (PDT)
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-763c3442563so62058639f.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 01:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682324260; x=1684916260;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tJ6Cu4igdI/nmIrxohYpGuE1NNYUq7Nw0Hy6ZHEHguc=;
        b=P/2EtaX1tKy++WGan7XiUCz+n/pZmra3Uo6y4kKJus4sOLZJLs3M//x73DkbkqfHK0
         mIF2p+cW97iAv0qgYDRKurO7G8PRoCm93k739nmpc19WJv8ooU+rYRpTKy1D9TzdABTV
         PXnI/4+9XlvkORHo54tXqJYbqEve9+dA2Nyu3unhdf3wfLFYXdGu4gQs02o+9DNsHXac
         JPDtKg/p89QD8c8X+Ghao/QMXu2ZLtDQiko/HhqFjRBMpT2UroZn2gXpfDdWa3GGRNtK
         sm90IVtJ2ufx7KcSPAnm2gojDUMeTO/oiO+TwG25UyZZhYfPxsETWsjCI3SX5cZvoNWe
         Ajkw==
X-Gm-Message-State: AAQBX9dIB9/9bb9kS3xCciylTU6L3I8pT10R4CZIidktgp8ohgKWXsoJ
        h5R0gCya4uJFpsBhs+Y11ip6HzT6GjnPD2XuVo9dx7b3Tngf
X-Google-Smtp-Source: AKy350aFzHMV6VFIzD2FSXRqIbFUZLma0gVQ8G9LxOuITHlZvqMWGarEKa80XNdr3DLueyye9FgXQpw6ZKRr1gQItXCIHgxAcEYm
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2210:b0:760:e9b6:e6de with SMTP id
 n16-20020a056602221000b00760e9b6e6demr3854730ion.0.1682324259846; Mon, 24 Apr
 2023 01:17:39 -0700 (PDT)
Date:   Mon, 24 Apr 2023 01:17:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e7c6d205fa10a3cd@google.com>
Subject: [syzbot] [afs?] [net?] KCSAN: data-race in rxrpc_send_data / rxrpc_set_call_completion
From:   syzbot <syzbot+ebc945fdb4acd72cba78@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dhowells@redhat.com, edumazet@google.com,
        kuba@kernel.org, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        marc.dionne@auristor.com, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    148341f0a2f5 Merge tag 'vfs.misc.fixes.v6.3-rc6' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14a62269c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=54d63ee086ae78d0
dashboard link: https://syzkaller.appspot.com/bug?extid=ebc945fdb4acd72cba78
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1c557f92a6e1/disk-148341f0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f2c85210e1ce/vmlinux-148341f0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b019d0447709/bzImage-148341f0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ebc945fdb4acd72cba78@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in rxrpc_send_data / rxrpc_set_call_completion

write to 0xffff888159cf3c50 of 4 bytes by task 25673 on cpu 1:
 rxrpc_set_call_completion+0x71/0x1c0 net/rxrpc/call_state.c:22
 rxrpc_send_data_packet+0xba9/0x1650 net/rxrpc/output.c:479
 rxrpc_transmit_one+0x1e/0x130 net/rxrpc/output.c:714
 rxrpc_decant_prepared_tx net/rxrpc/call_event.c:326 [inline]
 rxrpc_transmit_some_data+0x496/0x600 net/rxrpc/call_event.c:350
 rxrpc_input_call_event+0x564/0x1220 net/rxrpc/call_event.c:464
 rxrpc_io_thread+0x307/0x1d80 net/rxrpc/io_thread.c:461
 kthread+0x1ac/0x1e0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

read to 0xffff888159cf3c50 of 4 bytes by task 25672 on cpu 0:
 rxrpc_send_data+0x29e/0x1950 net/rxrpc/sendmsg.c:296
 rxrpc_do_sendmsg+0xb7a/0xc20 net/rxrpc/sendmsg.c:726
 rxrpc_sendmsg+0x413/0x520 net/rxrpc/af_rxrpc.c:565
 sock_sendmsg_nosec net/socket.c:724 [inline]
 sock_sendmsg net/socket.c:747 [inline]
 ____sys_sendmsg+0x375/0x4c0 net/socket.c:2501
 ___sys_sendmsg net/socket.c:2555 [inline]
 __sys_sendmmsg+0x263/0x500 net/socket.c:2641
 __do_sys_sendmmsg net/socket.c:2670 [inline]
 __se_sys_sendmmsg net/socket.c:2667 [inline]
 __x64_sys_sendmmsg+0x57/0x60 net/socket.c:2667
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0x00000000 -> 0xffffffea

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 25672 Comm: syz-executor.5 Not tainted 6.3.0-rc5-syzkaller-00005-g148341f0a2f5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
