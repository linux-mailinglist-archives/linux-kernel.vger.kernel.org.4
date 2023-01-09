Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581EE661E91
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 07:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbjAIGD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 01:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjAIGDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 01:03:46 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4296510FCC
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 22:03:45 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id w18-20020a5d9cd2000000b006e32359d7fcso4280389iow.15
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 22:03:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ed3FZyB6NU/3+xz5RxJ4dvJy7PBnWBlWfS5GFmcwBNU=;
        b=VvVqFabLjYYtGgsQAqDYEK+L8U6arvm0THDRgTR+xfKpEtJCpn7ITloO8lXKWYp6zz
         MInfV7V2b3BmK3fBDJ7eOiKZlXWPMXtAwwDvTcrHk5otB7lFd+McUgC5DHsG4CGsdDBL
         5pbCGKCzwi2DzKuANa+v8h8joBcIQKL5NZDq9wIMh/0cPZfJ6NdwG5uRVsuurOT6l2At
         I+s9e1NSF2C0vh7vaFmEPco4MYhc2wqVdEwImsoRpNOyaDFlCHunxzvnx8tft9Hn2OdD
         J9sX0cxfkCz5q7XfMq0jz2JsgYW3E7pBk/kXBTHod2hyWJ9OUhx/cnxTx5gSvA/PbZRz
         VbIQ==
X-Gm-Message-State: AFqh2ko8LHYQhYfXCxCT3l7x90em8An8zUf808lsGQ/5Ze/IVwIYRDwx
        EbkwnxP81RWEh2S4VayOy6P3+LkbTpY3JGVTyB+Ul/CM4HHN
X-Google-Smtp-Source: AMrXdXuk4gWZRoP2S7HK2oTYB3ek6PhMKldLygTYsqWRMa4Oy/mMx0X3kyFTxLJUQVEQP+LaMAznYxlT8JIt8ZShES1NjqmXDsl2
MIME-Version: 1.0
X-Received: by 2002:a02:7162:0:b0:39e:5eb6:27e2 with SMTP id
 n34-20020a027162000000b0039e5eb627e2mr1199541jaf.315.1673244224484; Sun, 08
 Jan 2023 22:03:44 -0800 (PST)
Date:   Sun, 08 Jan 2023 22:03:44 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009f829805f1ce87b2@google.com>
Subject: [syzbot] memory leak in io_submit_sqes (4)
From:   syzbot <syzbot+6c95df01470a47fc3af4@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,LONGWORDS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    0a71553536d2 Merge tag 'drm-fixes-2023-01-06' of git://ano..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=164951c2480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5ddca4921a53cff2
dashboard link: https://syzkaller.appspot.com/bug?extid=6c95df01470a47fc3af4
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12929d9a480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=105ffae2480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ad52353dc15f/disk-0a715535.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/90927b7e9870/vmlinux-0a715535.xz
kernel image: https://storage.googleapis.com/syzbot-assets/553a64766dcc/bzImage-0a715535.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6c95df01470a47fc3af4@syzkaller.appspotmail.com

executing program
executing program
executing program
executing program
executing program
BUG: memory leak
unreferenced object 0xffff88810de89200 (size 256):
  comm "syz-executor286", pid 5100, jiffies 4294952261 (age 14.130s)
  hex dump (first 32 bytes):
    00 8f 90 0a 81 88 ff ff 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 40 00 00 00 00 00 00  .........@......
  backtrace:
    [<ffffffff84769af3>] __io_alloc_req_refill+0x55/0x193 io_uring/io_uring.c:1040
    [<ffffffff8476b084>] io_alloc_req_refill io_uring/io_uring.h:378 [inline]
    [<ffffffff8476b084>] io_submit_sqes.cold+0x65/0x8a io_uring/io_uring.c:2384
    [<ffffffff823986bd>] __do_sys_io_uring_enter+0x76d/0x1490 io_uring/io_uring.c:3345
    [<ffffffff848ef735>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff848ef735>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84a00087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888109cac600 (size 96):
  comm "syz-executor286", pid 5100, jiffies 4294952261 (age 14.130s)
  hex dump (first 32 bytes):
    00 8f 90 0a 81 88 ff ff 00 00 00 00 00 00 00 00  ................
    7b 20 00 c0 00 00 00 00 00 00 00 00 00 00 00 00  { ..............
  backtrace:
    [<ffffffff814f94a0>] kmalloc_trace+0x20/0x90 mm/slab_common.c:1062
    [<ffffffff823a702c>] kmalloc include/linux/slab.h:580 [inline]
    [<ffffffff823a702c>] io_req_alloc_apoll io_uring/poll.c:650 [inline]
    [<ffffffff823a702c>] io_arm_poll_handler+0x1fc/0x470 io_uring/poll.c:694
    [<ffffffff82395e4d>] io_queue_async+0x8d/0x2e0 io_uring/io_uring.c:2006
    [<ffffffff82397b98>] io_queue_sqe io_uring/io_uring.c:2037 [inline]
    [<ffffffff82397b98>] io_submit_sqe io_uring/io_uring.c:2286 [inline]
    [<ffffffff82397b98>] io_submit_sqes+0x968/0xb70 io_uring/io_uring.c:2397
    [<ffffffff823986bd>] __do_sys_io_uring_enter+0x76d/0x1490 io_uring/io_uring.c:3345
    [<ffffffff848ef735>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff848ef735>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84a00087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff88810a72bb00 (size 256):
  comm "syz-executor286", pid 5100, jiffies 4294952261 (age 14.130s)
  hex dump (first 32 bytes):
    00 8f 90 0a 81 88 ff ff 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 40 00 00 00 00 00 00  .........@......
  backtrace:
    [<ffffffff84769af3>] __io_alloc_req_refill+0x55/0x193 io_uring/io_uring.c:1040
    [<ffffffff8476b084>] io_alloc_req_refill io_uring/io_uring.h:378 [inline]
    [<ffffffff8476b084>] io_submit_sqes.cold+0x65/0x8a io_uring/io_uring.c:2384
    [<ffffffff823986bd>] __do_sys_io_uring_enter+0x76d/0x1490 io_uring/io_uring.c:3345
    [<ffffffff848ef735>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff848ef735>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84a00087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff88810f18f600 (size 96):
  comm "syz-executor286", pid 5100, jiffies 4294952261 (age 14.130s)
  hex dump (first 32 bytes):
    00 8f 90 0a 81 88 ff ff 00 00 00 00 00 00 00 00  ................
    7b 20 00 c0 00 00 00 00 00 00 00 00 00 00 00 00  { ..............
  backtrace:
    [<ffffffff814f94a0>] kmalloc_trace+0x20/0x90 mm/slab_common.c:1062
    [<ffffffff823a702c>] kmalloc include/linux/slab.h:580 [inline]
    [<ffffffff823a702c>] io_req_alloc_apoll io_uring/poll.c:650 [inline]
    [<ffffffff823a702c>] io_arm_poll_handler+0x1fc/0x470 io_uring/poll.c:694
    [<ffffffff82395e4d>] io_queue_async+0x8d/0x2e0 io_uring/io_uring.c:2006
    [<ffffffff82397b98>] io_queue_sqe io_uring/io_uring.c:2037 [inline]
    [<ffffffff82397b98>] io_submit_sqe io_uring/io_uring.c:2286 [inline]
    [<ffffffff82397b98>] io_submit_sqes+0x968/0xb70 io_uring/io_uring.c:2397
    [<ffffffff823986bd>] __do_sys_io_uring_enter+0x76d/0x1490 io_uring/io_uring.c:3345
    [<ffffffff848ef735>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff848ef735>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84a00087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
