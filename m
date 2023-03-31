Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90B36D1996
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 10:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjCaIQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 04:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjCaIQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 04:16:35 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0134EE0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 01:16:25 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id a19-20020a056e0208b300b003260dffae47so9210838ilt.17
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 01:16:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680250584; x=1682842584;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=770k2WaOAJnuWzf93GYtm1LliPDVFFoGdWOwPR0VoqE=;
        b=BHVSq+W4g4ZjwFLwEeTzu6U02i2IiCpzuKqCP4zOu2bREnwEl2nnfxDNO3lHbzUf75
         ktq9ADDt3n7Wk2hXqOGrdBV19AmQmlw5RrXqjuOckZt0bqNCRB/1pzx0W4de/l1dbtZC
         kRUZTb4XadEPU5AHqGDnzZAZwArDCz97b6wNyKoSW0EXv+iEVJsIUXtvAhBR8PbvznPH
         UTx6Ujp/cyl19ehRy+wh+0VXOln6eDurWb5dedmcsPMWmXr47j7E4OV8UndUfRKPuRAv
         6ffG5dCULIJqrpyF8qAPeSwXFGKJu5AqDXbemcSfLt2rRr6EAYNFSqz8BEvbSoNnS8nc
         O2Ug==
X-Gm-Message-State: AAQBX9elqJcadq13J8jiuYWQfOVb6WqOzMG09nEZYUl/fiZ8pesVzFHQ
        8AnsJ3hfjIbLC90mYlXr0bJHwfuM0RJw2cVEqqDNm/1x/fxK
X-Google-Smtp-Source: AKy350YySo7RfqugXMh8BfKcRG3AcpIj9+VSMF0ukCt1skIYC04M4F4k5FKrB/LR7AxFyeTCcddqmwu2YKTsxPvFgPZsBR7s+yHV
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:cc1:b0:325:a8e7:126c with SMTP id
 c1-20020a056e020cc100b00325a8e7126cmr12722836ilj.0.1680250584561; Fri, 31 Mar
 2023 01:16:24 -0700 (PDT)
Date:   Fri, 31 Mar 2023 01:16:24 -0700
In-Reply-To: <20230331080108.3156-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000039ff8905f82dd30d@google.com>
Subject: Re: [syzbot] [bluetooth?] possible deadlock in rfcomm_dlc_exists
From:   syzbot <syzbot+b69a625d06e8ece26415@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in rfcomm_dev_ioctl

======================================================
WARNING: possible circular locking dependency detected
6.3.0-rc4-next-20230330-syzkaller-dirty #0 Not tainted
------------------------------------------------------
syz-executor.0/5603 is trying to acquire lock:
ffff88801e179130 (sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1697 [inline]
ffff88801e179130 (sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}-{0:0}, at: __rfcomm_create_dev net/bluetooth/rfcomm/tty.c:417 [inline]
ffff88801e179130 (sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}-{0:0}, at: rfcomm_create_dev net/bluetooth/rfcomm/tty.c:488 [inline]
ffff88801e179130 (sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}-{0:0}, at: rfcomm_dev_ioctl+0x9ca/0x1cb0 net/bluetooth/rfcomm/tty.c:590

but task is already holding lock:
ffffffff8e35cc88 (rfcomm_ioctl_mutex){+.+.}-{3:3}, at: rfcomm_create_dev net/bluetooth/rfcomm/tty.c:487 [inline]
ffffffff8e35cc88 (rfcomm_ioctl_mutex){+.+.}-{3:3}, at: rfcomm_dev_ioctl+0x8a2/0x1cb0 net/bluetooth/rfcomm/tty.c:590

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (rfcomm_ioctl_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x12f/0x1350 kernel/locking/mutex.c:747
       rfcomm_create_dev net/bluetooth/rfcomm/tty.c:487 [inline]
       rfcomm_dev_ioctl+0x8a2/0x1cb0 net/bluetooth/rfcomm/tty.c:590
       rfcomm_sock_ioctl+0xb7/0xe0 net/bluetooth/rfcomm/sock.c:880
       sock_do_ioctl+0xcc/0x230 net/socket.c:1199
       sock_ioctl+0x1f8/0x680 net/socket.c:1316
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl fs/ioctl.c:856 [inline]
       __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3108 [inline]
       check_prevs_add kernel/locking/lockdep.c:3227 [inline]
       validate_chain kernel/locking/lockdep.c:3842 [inline]
       __lock_acquire+0x2f21/0x5df0 kernel/locking/lockdep.c:5074
       lock_acquire.part.0+0x11c/0x370 kernel/locking/lockdep.c:5691
       lock_sock_nested+0x3a/0xf0 net/core/sock.c:3474
       lock_sock include/net/sock.h:1697 [inline]
       __rfcomm_create_dev net/bluetooth/rfcomm/tty.c:417 [inline]
       rfcomm_create_dev net/bluetooth/rfcomm/tty.c:488 [inline]
       rfcomm_dev_ioctl+0x9ca/0x1cb0 net/bluetooth/rfcomm/tty.c:590
       rfcomm_sock_ioctl+0xb7/0xe0 net/bluetooth/rfcomm/sock.c:880
       sock_do_ioctl+0xcc/0x230 net/socket.c:1199
       sock_ioctl+0x1f8/0x680 net/socket.c:1316
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl fs/ioctl.c:856 [inline]
       __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(rfcomm_ioctl_mutex);
                               lock(sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM);
                               lock(rfcomm_ioctl_mutex);
  lock(sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM);

 *** DEADLOCK ***

1 lock held by syz-executor.0/5603:
 #0: ffffffff8e35cc88 (rfcomm_ioctl_mutex){+.+.}-{3:3}, at: rfcomm_create_dev net/bluetooth/rfcomm/tty.c:487 [inline]
 #0: ffffffff8e35cc88 (rfcomm_ioctl_mutex){+.+.}-{3:3}, at: rfcomm_dev_ioctl+0x8a2/0x1cb0 net/bluetooth/rfcomm/tty.c:590

stack backtrace:
CPU: 0 PID: 5603 Comm: syz-executor.0 Not tainted 6.3.0-rc4-next-20230330-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2188
 check_prev_add kernel/locking/lockdep.c:3108 [inline]
 check_prevs_add kernel/locking/lockdep.c:3227 [inline]
 validate_chain kernel/locking/lockdep.c:3842 [inline]
 __lock_acquire+0x2f21/0x5df0 kernel/locking/lockdep.c:5074
 lock_acquire.part.0+0x11c/0x370 kernel/locking/lockdep.c:5691
 lock_sock_nested+0x3a/0xf0 net/core/sock.c:3474
 lock_sock include/net/sock.h:1697 [inline]
 __rfcomm_create_dev net/bluetooth/rfcomm/tty.c:417 [inline]
 rfcomm_create_dev net/bluetooth/rfcomm/tty.c:488 [inline]
 rfcomm_dev_ioctl+0x9ca/0x1cb0 net/bluetooth/rfcomm/tty.c:590
 rfcomm_sock_ioctl+0xb7/0xe0 net/bluetooth/rfcomm/sock.c:880
 sock_do_ioctl+0xcc/0x230 net/socket.c:1199
 sock_ioctl+0x1f8/0x680 net/socket.c:1316
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f94d848c0f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f94d911c168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f94d85ac050 RCX: 00007f94d848c0f9
RDX: 0000000020000100 RSI: 00000000400452c8 RDI: 0000000000000006
RBP: 00007f94d84e7b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffef88f28bf R14: 00007f94d911c300 R15: 0000000000022000
 </TASK>


Tested on:

commit:         a6d9e303 Add linux-next specific files for 20230330
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14b657d5c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aceb117f7924508e
dashboard link: https://syzkaller.appspot.com/bug?extid=b69a625d06e8ece26415
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1741d1cdc80000

