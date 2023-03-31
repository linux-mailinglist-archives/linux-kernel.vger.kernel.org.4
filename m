Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730EC6D160E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 05:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjCaDh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 23:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjCaDh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 23:37:26 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBAE18835
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 20:37:22 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id d204-20020a6bb4d5000000b00758cfdd36c3so12711533iof.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 20:37:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680233841; x=1682825841;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7wRPt33fvQzQbl0Q85E9TKuuYff5U0Hgngn0Gl0Ha+I=;
        b=E8RqpEgR+veKO/TOQF3F7BU7dJhO4eFH+16YrAq+qv1DX5I0zwj55DRY3hEziqqNX6
         lcVWX3AcfpzWMwyZQo1iwDmKpRCKbANtcTzDkSLGFyKsv/xOKrPITHw5EAZWmIR1V9Fu
         UqtGA7J7esY5xqVa2iWuuWejByvkEY6ZDBmv90b36BFzAKDsEWT7t4gqbyvGuBkzP2j/
         FJJnNTGrGt5bdg7rs5wEuGZUWF01JY/1fq0DRcUBRp1/NwhOCNXGEQuPsbIUY7GgRmJP
         p3UGKj50gcsKcM9lcSpMqv4KlpcYmvReP6eodBKC9BePObeiL1eiO2pSyFrYMYOq9C7t
         ohaA==
X-Gm-Message-State: AAQBX9fufXTAlq4LPKwy7b6KuIf78ETNf+8eSHaDDksRMTqJaLi6tXGN
        UQ03whONJK87f2rGXdppb3ete85+sLHlQGZsg2MfPtYNw/HD
X-Google-Smtp-Source: AKy350abvGpivuGi0t0g/feQ1O3pfLJ7M6k5C56o6jxtm+jxchcL6Ku/0FXAuLuBGyrc/h607V9l1Kux7h8sVjg5P1KQX7pFp6u0
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:f46:b0:326:37b4:e190 with SMTP id
 y6-20020a056e020f4600b0032637b4e190mr2716386ilj.3.1680233841504; Thu, 30 Mar
 2023 20:37:21 -0700 (PDT)
Date:   Thu, 30 Mar 2023 20:37:21 -0700
In-Reply-To: <20230331032008.3067-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004337aa05f829ed06@google.com>
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
possible deadlock in rfcomm_sk_state_change

======================================================
WARNING: possible circular locking dependency detected
6.3.0-rc4-next-20230330-syzkaller-dirty #0 Not tainted
------------------------------------------------------
syz-executor.0/5614 is trying to acquire lock:
ffff888028fb5130 (sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1697 [inline]
ffff888028fb5130 (sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}-{0:0}, at: rfcomm_sk_state_change+0x6d/0x3a0 net/bluetooth/rfcomm/sock.c:73

but task is already holding lock:
ffffffff8e357cc8 (rfcomm_mutex){+.+.}-{3:3}, at: rfcomm_dlc_close+0x33/0x240 net/bluetooth/rfcomm/core.c:511

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (rfcomm_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x12f/0x1350 kernel/locking/mutex.c:747
       rfcomm_dlc_exists+0x58/0x190 net/bluetooth/rfcomm/core.c:546
       __rfcomm_create_dev net/bluetooth/rfcomm/tty.c:414 [inline]
       rfcomm_create_dev net/bluetooth/rfcomm/tty.c:485 [inline]
       rfcomm_dev_ioctl+0x966/0x1c00 net/bluetooth/rfcomm/tty.c:587
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

-> #1 (rfcomm_ioctl_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x12f/0x1350 kernel/locking/mutex.c:747
       rfcomm_create_dev net/bluetooth/rfcomm/tty.c:484 [inline]
       rfcomm_dev_ioctl+0x8a2/0x1c00 net/bluetooth/rfcomm/tty.c:587
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
       rfcomm_sk_state_change+0x6d/0x3a0 net/bluetooth/rfcomm/sock.c:73
       __rfcomm_dlc_close+0x1b9/0x890 net/bluetooth/rfcomm/core.c:494
       rfcomm_dlc_close+0x1e9/0x240 net/bluetooth/rfcomm/core.c:524
       __rfcomm_sock_close+0x17a/0x2f0 net/bluetooth/rfcomm/sock.c:220
       rfcomm_sock_shutdown+0xd8/0x230 net/bluetooth/rfcomm/sock.c:912
       rfcomm_sock_release+0x68/0x140 net/bluetooth/rfcomm/sock.c:933
       __sock_release+0xcd/0x290 net/socket.c:653
       sock_close+0x1c/0x20 net/socket.c:1395
       __fput+0x27c/0xa90 fs/file_table.c:321
       task_work_run+0x16f/0x270 kernel/task_work.c:179
       get_signal+0x1c7/0x25b0 kernel/signal.c:2635
       arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:307
       exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
       exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
       __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
       syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
       do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM --> rfcomm_ioctl_mutex --> rfcomm_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(rfcomm_mutex);
                               lock(rfcomm_ioctl_mutex);
                               lock(rfcomm_mutex);
  lock(sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM);

 *** DEADLOCK ***

2 locks held by syz-executor.0/5614:
 #0: ffff888074585c10 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #0: ffff888074585c10 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: __sock_release+0x86/0x290 net/socket.c:652
 #1: ffffffff8e357cc8 (rfcomm_mutex){+.+.}-{3:3}, at: rfcomm_dlc_close+0x33/0x240 net/bluetooth/rfcomm/core.c:511

stack backtrace:
CPU: 1 PID: 5614 Comm: syz-executor.0 Not tainted 6.3.0-rc4-next-20230330-syzkaller-dirty #0
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
 rfcomm_sk_state_change+0x6d/0x3a0 net/bluetooth/rfcomm/sock.c:73
 __rfcomm_dlc_close+0x1b9/0x890 net/bluetooth/rfcomm/core.c:494
 rfcomm_dlc_close+0x1e9/0x240 net/bluetooth/rfcomm/core.c:524
 __rfcomm_sock_close+0x17a/0x2f0 net/bluetooth/rfcomm/sock.c:220
 rfcomm_sock_shutdown+0xd8/0x230 net/bluetooth/rfcomm/sock.c:912
 rfcomm_sock_release+0x68/0x140 net/bluetooth/rfcomm/sock.c:933
 __sock_release+0xcd/0x290 net/socket.c:653
 sock_close+0x1c/0x20 net/socket.c:1395
 __fput+0x27c/0xa90 fs/file_table.c:321
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 get_signal+0x1c7/0x25b0 kernel/signal.c:2635
 arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:307
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe4d528c0f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe4d602c168 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: fffffffffffffffc RBX: 00007fe4d53abf80 RCX: 00007fe4d528c0f9
RDX: 000000000000000a RSI: 0000000020000040 RDI: 0000000000000003
RBP: 00007fe4d52e7b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe4d1bd46f R14: 00007fe4d602c300 R15: 0000000000022000
 </TASK>


Tested on:

commit:         a6d9e303 Add linux-next specific files for 20230330
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15f008c9c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aceb117f7924508e
dashboard link: https://syzkaller.appspot.com/bug?extid=b69a625d06e8ece26415
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1032965dc80000

