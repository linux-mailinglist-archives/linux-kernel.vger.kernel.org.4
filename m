Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F15671210
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 04:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjARDlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 22:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjARDlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 22:41:40 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0233653983
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 19:41:39 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id t3-20020a6bc303000000b006f7844c6298so20796047iof.23
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 19:41:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=74X7kAcEj4fU0m5Re0lmRYJTEgxMAcwvfPdyS/kczFQ=;
        b=qPFH3b54LqlLjumODv5rOpM1SZs8MOjy3ZGAppvfitNCJ2+F4zNeiRNOnRwmqo/Nq7
         BGFEZxEVDp/gBZEIcmsBmi3qycyqgAW/7qqg97kAhvviuKcIc1XlXmUsaVZameYw9mnN
         +uZrWlVKKaEyuiw0HCsUI7PEFrb8qPq1y7tF0Ya2Tjf/m4iMupv7gVakc/a3wqXPq7z8
         tYM/ecVSxphL+b1wrswW2JwMW0SXBObNxUh5+CtVk49ANCCvoz1zEhGRoJALd/7YHU9S
         eMck8+mr2HtDkLt0CKdfkYTstO+oySXu2s9r0UolCTCEjCcLd3Yk8UqYor9b/1g5Ib2b
         Mwaw==
X-Gm-Message-State: AFqh2kpQRsMrToreSHKW37WVgJF7YwjcnIcZo5w8R+wA09kCTAeEFRCs
        gL/ClAdw8DjE1oTr3h/3R5CrEMiIeC+pCUjiK7+M6r2gYnhP
X-Google-Smtp-Source: AMrXdXucyuTnzhjQ57Y1trDIyz3uY02HOBd5CqFkkNCb76J+vaqIkQzHmgHPmZ1lhguKRGmPq256CFday39JBnw2liZq1QeNjQXj
MIME-Version: 1.0
X-Received: by 2002:a02:c001:0:b0:39d:72ab:a7c5 with SMTP id
 y1-20020a02c001000000b0039d72aba7c5mr529641jai.247.1674013298341; Tue, 17 Jan
 2023 19:41:38 -0800 (PST)
Date:   Tue, 17 Jan 2023 19:41:38 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ff3e7a05f28197c4@google.com>
Subject: [syzbot] memory leak in j1939_session_new
From:   syzbot <syzbot+e11e4ccbf72be52c556b@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, kernel@pengutronix.de,
        kuba@kernel.org, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@rempel-privat.de,
        mkl@pengutronix.de, netdev@vger.kernel.org, pabeni@redhat.com,
        robin@protonic.nl, socketcan@hartkopp.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d9fc1511728c Merge tag 'net-6.2-rc4' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10ef774a480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=277a06a151173742
dashboard link: https://syzkaller.appspot.com/bug?extid=e11e4ccbf72be52c556b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11390e7e480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c69b02bb465e/disk-d9fc1511.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7cbf6be156ee/vmlinux-d9fc1511.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2d087daee200/bzImage-d9fc1511.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e11e4ccbf72be52c556b@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810b04c600 (size 512):
  comm "syz-executor.3", pid 5457, jiffies 4294949672 (age 11.860s)
  hex dump (first 32 bytes):
    00 80 16 17 81 88 ff ff 08 c6 04 0b 81 88 ff ff  ................
    08 c6 04 0b 81 88 ff ff 18 c6 04 0b 81 88 ff ff  ................
  backtrace:
    [<ffffffff814f94f0>] kmalloc_trace+0x20/0x90 mm/slab_common.c:1062
    [<ffffffff8413311b>] kmalloc include/linux/slab.h:580 [inline]
    [<ffffffff8413311b>] kzalloc include/linux/slab.h:720 [inline]
    [<ffffffff8413311b>] j1939_session_new+0x5b/0x160 net/can/j1939/transport.c:1491
    [<ffffffff84138410>] j1939_tp_send+0x150/0x350 net/can/j1939/transport.c:2001
    [<ffffffff84131d24>] j1939_sk_send_loop net/can/j1939/socket.c:1133 [inline]
    [<ffffffff84131d24>] j1939_sk_sendmsg+0x4a4/0x810 net/can/j1939/socket.c:1256
    [<ffffffff83af8fa6>] sock_sendmsg_nosec net/socket.c:714 [inline]
    [<ffffffff83af8fa6>] sock_sendmsg+0x56/0x80 net/socket.c:734
    [<ffffffff83affebf>] sock_no_sendpage+0x8f/0xc0 net/core/sock.c:3241
    [<ffffffff83af9b2d>] kernel_sendpage net/socket.c:3555 [inline]
    [<ffffffff83af9b2d>] kernel_sendpage+0xcd/0x2b0 net/socket.c:3549
    [<ffffffff83af9d50>] sock_sendpage+0x40/0x50 net/socket.c:1054
    [<ffffffff81669be2>] pipe_to_sendpage+0xa2/0x110 fs/splice.c:361
    [<ffffffff8166affd>] splice_from_pipe_feed fs/splice.c:415 [inline]
    [<ffffffff8166affd>] __splice_from_pipe+0x1ed/0x330 fs/splice.c:559
    [<ffffffff8166b8ef>] splice_from_pipe fs/splice.c:594 [inline]
    [<ffffffff8166b8ef>] generic_splice_sendpage+0x6f/0xa0 fs/splice.c:743
    [<ffffffff81669c9b>] do_splice_from fs/splice.c:764 [inline]
    [<ffffffff81669c9b>] direct_splice_actor+0x4b/0x70 fs/splice.c:931
    [<ffffffff8166a439>] splice_direct_to_actor+0x149/0x350 fs/splice.c:886
    [<ffffffff8166a728>] do_splice_direct+0xe8/0x150 fs/splice.c:974
    [<ffffffff816069df>] do_sendfile+0x57f/0x7e0 fs/read_write.c:1255
    [<ffffffff8160a7d2>] __do_sys_sendfile64 fs/read_write.c:1323 [inline]
    [<ffffffff8160a7d2>] __se_sys_sendfile64 fs/read_write.c:1309 [inline]
    [<ffffffff8160a7d2>] __x64_sys_sendfile64+0xe2/0x100 fs/read_write.c:1309

BUG: memory leak
unreferenced object 0xffff8881198de300 (size 240):
  comm "syz-executor.3", pid 5457, jiffies 4294949672 (age 11.860s)
  hex dump (first 32 bytes):
    00 e8 8d 19 81 88 ff ff 68 c6 04 0b 81 88 ff ff  ........h.......
    00 80 d3 13 81 88 ff ff 00 d4 f0 18 81 88 ff ff  ................
  backtrace:
    [<ffffffff83b0d902>] __alloc_skb+0x202/0x270 net/core/skbuff.c:552
    [<ffffffff83b11f6a>] alloc_skb include/linux/skbuff.h:1270 [inline]
    [<ffffffff83b11f6a>] alloc_skb_with_frags+0x6a/0x340 net/core/skbuff.c:6195
    [<ffffffff83b0431f>] sock_alloc_send_pskb+0x39f/0x3d0 net/core/sock.c:2741
    [<ffffffff84131b52>] sock_alloc_send_skb include/net/sock.h:1888 [inline]
    [<ffffffff84131b52>] j1939_sk_alloc_skb net/can/j1939/socket.c:864 [inline]
    [<ffffffff84131b52>] j1939_sk_send_loop net/can/j1939/socket.c:1121 [inline]
    [<ffffffff84131b52>] j1939_sk_sendmsg+0x2d2/0x810 net/can/j1939/socket.c:1256
    [<ffffffff83af8fa6>] sock_sendmsg_nosec net/socket.c:714 [inline]
    [<ffffffff83af8fa6>] sock_sendmsg+0x56/0x80 net/socket.c:734
    [<ffffffff83affebf>] sock_no_sendpage+0x8f/0xc0 net/core/sock.c:3241
    [<ffffffff83af9b2d>] kernel_sendpage net/socket.c:3555 [inline]
    [<ffffffff83af9b2d>] kernel_sendpage+0xcd/0x2b0 net/socket.c:3549
    [<ffffffff83af9d50>] sock_sendpage+0x40/0x50 net/socket.c:1054
    [<ffffffff81669be2>] pipe_to_sendpage+0xa2/0x110 fs/splice.c:361
    [<ffffffff8166affd>] splice_from_pipe_feed fs/splice.c:415 [inline]
    [<ffffffff8166affd>] __splice_from_pipe+0x1ed/0x330 fs/splice.c:559
    [<ffffffff8166b8ef>] splice_from_pipe fs/splice.c:594 [inline]
    [<ffffffff8166b8ef>] generic_splice_sendpage+0x6f/0xa0 fs/splice.c:743
    [<ffffffff81669c9b>] do_splice_from fs/splice.c:764 [inline]
    [<ffffffff81669c9b>] direct_splice_actor+0x4b/0x70 fs/splice.c:931
    [<ffffffff8166a439>] splice_direct_to_actor+0x149/0x350 fs/splice.c:886
    [<ffffffff8166a728>] do_splice_direct+0xe8/0x150 fs/splice.c:974
    [<ffffffff816069df>] do_sendfile+0x57f/0x7e0 fs/read_write.c:1255
    [<ffffffff8160a7d2>] __do_sys_sendfile64 fs/read_write.c:1323 [inline]
    [<ffffffff8160a7d2>] __se_sys_sendfile64 fs/read_write.c:1309 [inline]
    [<ffffffff8160a7d2>] __x64_sys_sendfile64+0xe2/0x100 fs/read_write.c:1309

BUG: memory leak
unreferenced object 0xffff8881198de800 (size 240):
  comm "syz-executor.3", pid 5457, jiffies 4294949672 (age 11.860s)
  hex dump (first 32 bytes):
    68 c6 04 0b 81 88 ff ff 00 e3 8d 19 81 88 ff ff  h...............
    00 80 d3 13 81 88 ff ff 00 d4 f0 18 81 88 ff ff  ................
  backtrace:
    [<ffffffff83b0d902>] __alloc_skb+0x202/0x270 net/core/skbuff.c:552
    [<ffffffff83b11f6a>] alloc_skb include/linux/skbuff.h:1270 [inline]
    [<ffffffff83b11f6a>] alloc_skb_with_frags+0x6a/0x340 net/core/skbuff.c:6195
    [<ffffffff83b0431f>] sock_alloc_send_pskb+0x39f/0x3d0 net/core/sock.c:2741
    [<ffffffff84131b52>] sock_alloc_send_skb include/net/sock.h:1888 [inline]
    [<ffffffff84131b52>] j1939_sk_alloc_skb net/can/j1939/socket.c:864 [inline]
    [<ffffffff84131b52>] j1939_sk_send_loop net/can/j1939/socket.c:1121 [inline]
    [<ffffffff84131b52>] j1939_sk_sendmsg+0x2d2/0x810 net/can/j1939/socket.c:1256
    [<ffffffff83af8fa6>] sock_sendmsg_nosec net/socket.c:714 [inline]
    [<ffffffff83af8fa6>] sock_sendmsg+0x56/0x80 net/socket.c:734
    [<ffffffff83affebf>] sock_no_sendpage+0x8f/0xc0 net/core/sock.c:3241
    [<ffffffff83af9b2d>] kernel_sendpage net/socket.c:3555 [inline]
    [<ffffffff83af9b2d>] kernel_sendpage+0xcd/0x2b0 net/socket.c:3549
    [<ffffffff83af9d50>] sock_sendpage+0x40/0x50 net/socket.c:1054
    [<ffffffff81669be2>] pipe_to_sendpage+0xa2/0x110 fs/splice.c:361
    [<ffffffff8166affd>] splice_from_pipe_feed fs/splice.c:415 [inline]
    [<ffffffff8166affd>] __splice_from_pipe+0x1ed/0x330 fs/splice.c:559
    [<ffffffff8166b8ef>] splice_from_pipe fs/splice.c:594 [inline]
    [<ffffffff8166b8ef>] generic_splice_sendpage+0x6f/0xa0 fs/splice.c:743
    [<ffffffff81669c9b>] do_splice_from fs/splice.c:764 [inline]
    [<ffffffff81669c9b>] direct_splice_actor+0x4b/0x70 fs/splice.c:931
    [<ffffffff8166a439>] splice_direct_to_actor+0x149/0x350 fs/splice.c:886
    [<ffffffff8166a728>] do_splice_direct+0xe8/0x150 fs/splice.c:974
    [<ffffffff816069df>] do_sendfile+0x57f/0x7e0 fs/read_write.c:1255
    [<ffffffff8160a7d2>] __do_sys_sendfile64 fs/read_write.c:1323 [inline]
    [<ffffffff8160a7d2>] __se_sys_sendfile64 fs/read_write.c:1309 [inline]
    [<ffffffff8160a7d2>] __x64_sys_sendfile64+0xe2/0x100 fs/read_write.c:1309



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
