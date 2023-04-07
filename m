Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF4A6DAF75
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 17:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjDGPO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 11:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjDGPOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 11:14:25 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D109211F
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 08:14:24 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id d11-20020a056e020c0b00b00326156e3a8bso22205211ile.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 08:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680880464; x=1683472464;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ObFSNH7If7Vw0XqjtxfdsSmaeXZz7O8vtPyaRVp7Xw=;
        b=BWd4R5AgsktZ8oIPQn4CNOl7SZ6vZz+ISK2IO/LDwTd/+1gyPRKK1AoCxCQJ4m23/q
         xqYEK9CZ3obCYTY/4wY7iRMN3kmz17bw7wYOv69y6vJokHgcmfffdHtGGpFIYxMigMMF
         s+Scbj+21TGlF5FugJqMqAgME7b9cD3nEnaX+ejXqHcY/r8wNzVoiZpkMnuzYHaS8D2m
         u9EXBD5X5ycSfRZQkWNuy/dVdikuVOaLZDMO1MMwbcZZXQZvlmzC4ykyrwIDPXzTXDZT
         5BZMkJnXqWyThcaPaiUkbWhfL97PGuGJSu1XdqCdld5fvj7GFDiDa0TaObzzwAJq2QHA
         WC9Q==
X-Gm-Message-State: AAQBX9eLmaDFbYrsb8Hwy0xXr3rXASKgPmidDOG3qrPGYnzlX0ucU4cz
        IPuh8Sz4fC9QhFB5wOeVMmX/mKDHXGPMLut5XRa13y4kVnf4
X-Google-Smtp-Source: AKy350bnI5/jIUwuzSbzxkT1z6GZArRlOms7YPRGk20PF98AZEbk8idmjGyhB4vTSBRmnIxJtOukJUjjZW5gI+8nI3Pt4G2hP0BC
MIME-Version: 1.0
X-Received: by 2002:a6b:e216:0:b0:753:cd5:abde with SMTP id
 z22-20020a6be216000000b007530cd5abdemr1293213ioc.4.1680880463929; Fri, 07 Apr
 2023 08:14:23 -0700 (PDT)
Date:   Fri, 07 Apr 2023 08:14:23 -0700
In-Reply-To: <20230407145900.1126-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f6667f05f8c07a83@google.com>
Subject: Re: [syzbot] [net?] WARNING in cleanup_net (2)
From:   syzbot <syzbot+7e1e1bdb852961150198@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in cleanup_net

 __sock_create+0x380/0x850 net/socket.c:1545
 sock_create net/socket.c:1596 [inline]
 __sys_socket_create net/socket.c:1633 [inline]
 __sys_socket_create net/socket.c:1618 [inline]
 __sys_socket+0x133/0x250 net/socket.c:1661
 __do_sys_socket net/socket.c:1674 [inline]
 __se_sys_socket net/socket.c:1672 [inline]
 __x64_sys_socket+0x73/0xb0 net/socket.c:1672
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5801 at lib/ref_tracker.c:39 spin_unlock_irqrestore include/linux/spinlock.h:405 [inline]
WARNING: CPU: 1 PID: 5801 at lib/ref_tracker.c:39 ref_tracker_dir_exit+0x3a2/0x600 lib/ref_tracker.c:38
Modules linked in:
CPU: 1 PID: 5801 Comm: kworker/u4:6 Not tainted 6.3.0-rc3-syzkaller-00148-gf33642224e38-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
Workqueue: netns cleanup_net
RIP: 0010:ref_tracker_dir_exit+0x3a2/0x600 lib/ref_tracker.c:39
Code: 0f 84 c3 fe ff ff e8 2d 3c 44 fd 44 89 ff e8 c5 f9 ff ff e9 b1 fe ff ff e8 1b 3c 44 fd 48 8b 74 24 10 4c 89 ef e8 de a8 c6 05 <0f> 0b e8 07 3c 44 fd 49 8d 6d 44 be 04 00 00 00 48 89 ef e8 e6 4d
RSP: 0018:ffffc900062d7c00 EFLAGS: 00010246
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 0000000000000001 RDI: 0000000000000001
RBP: ffff88807b16bb90 R08: 0000000000000001 R09: ffffffff914dac8f
R10: 0000000000000001 R11: 0000000000000000 R12: ffff88807b16bb90
R13: ffff88807b16bb40 R14: ffff88807b16bb90 R15: ffff88806d492348
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056302b1f4950 CR3: 000000002a8f2000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 net_free net/core/net_namespace.c:447 [inline]
 net_free net/core/net_namespace.c:441 [inline]
 cleanup_net+0x8bb/0xb10 net/core/net_namespace.c:634
 process_one_work+0x991/0x15c0 kernel/workqueue.c:2390
 worker_thread+0x669/0x1090 kernel/workqueue.c:2537
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


Tested on:

commit:         f3364222 ptp_qoriq: fix memory leak in probe()
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1023511dc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea09b0836073ee4
dashboard link: https://syzkaller.appspot.com/bug?extid=7e1e1bdb852961150198
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=168ecf45c80000

