Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63BE6494BF
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 15:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiLKO5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 09:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLKO5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 09:57:16 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F87FAF6
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 06:57:15 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id x9-20020a056e021ca900b003037ca1af0cso3528377ill.16
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 06:57:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xvkpXpfVfgnMfnO3Z4yvKzaCN0mlfAZYTG7pI/XqAng=;
        b=Brfph2aNj7i73YADM4ZgE/nJNjbEgWZAt27gNkiwl4o0R0bv5HXm4Jsyx3LwpO8yEW
         qJvE3+P3BXnhuYm6n9TqNKlv4ROrIjGYCrYsJSXPhwmDXBDlKnISNmyFU7x4VrJ2PSn1
         TaX5LmUzOFMPpw6ds+DqmLDqfkgcZMPq1JHg7lG8i0axC4rGesRO9wYocozHcBkK2jGD
         SwoqpPbXPeqe7UN/cxNcdaOKeHED3/bA24TDiYYyR5pgRuRcSwZyW/34jQOF89JfBR2T
         eWK3ZYAoge7FAeVVSoY6ns+h3unGQ7GsYTFd7hIY5YLfUt+ZZ03cg8IkTHcJPuKKiaAa
         WPNw==
X-Gm-Message-State: ANoB5plpahTs0WZvIBboAnHNDcRVTo5VvGc6rP1j6P/h8PvhhTCIVbFG
        WRcrOU+5s2jeGjXATYKLw7JfuaXmQRhV26ingCeiZJUjE3oH
X-Google-Smtp-Source: AA0mqf6/3mDg8S/TFsp/57L1zuORe65vjJ4pLwbMlvXAByRSAMbHaRcvfEla0rByPZ6ImJXkHgQNu9diVVyesEqmK98o+BzZZvC8
MIME-Version: 1.0
X-Received: by 2002:a92:d2c9:0:b0:303:4c12:437b with SMTP id
 w9-20020a92d2c9000000b003034c12437bmr10614096ilg.80.1670770634788; Sun, 11
 Dec 2022 06:57:14 -0800 (PST)
Date:   Sun, 11 Dec 2022 06:57:14 -0800
In-Reply-To: <20221211142633.2817-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000030264d05ef8e9abf@google.com>
Subject: Re: [syzbot] kernel stack overflow in sock_close
From:   syzbot <syzbot+09329bd987ebca21bced@syzkaller.appspotmail.com>
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
kernel stack overflow in sock_close

x8 : 000000000004057a x7 : ffff80000b229b58 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000002 x1 : ffff0000d0b42478 x0 : ffff0000d0b41a40
Kernel panic - not syncing: kernel stack overflow
CPU: 0 PID: 3653 Comm: syz-executor.0 Not tainted 6.1.0-rc8-syzkaller-00164-g4cee37b3a4e6-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x54 arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x5c lib/dump_stack.c:113
 panic+0x218/0x508 kernel/panic.c:274
 nmi_panic+0xbc/0xf0 kernel/panic.c:169
 panic_bad_stack+0x134/0x154 arch/arm64/kernel/traps.c:907
 handle_bad_stack+0x34/0x48 arch/arm64/kernel/entry-common.c:849
 __bad_stack+0x78/0x7c arch/arm64/kernel/entry.S:549
 mark_lock+0x4/0x1b4 kernel/locking/lockdep.c:4595
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5668
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
 _raw_spin_lock_bh+0x54/0x6c kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:355 [inline]
 lock_sock_nested+0x88/0xd8 net/core/sock.c:3450
 lock_sock include/net/sock.h:1721 [inline]
 sock_map_close+0x30/0x4bc net/core/sock_map.c:1610
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 sock_map_close+0x400/0x4bc
 inet_release+0xc8/0xe4 net/ipv4/af_inet.c:428
 inet6_release+0x3c/0x58 net/ipv6/af_inet6.c:488
 __sock_release net/socket.c:650 [inline]
 sock_close+0x50/0xf0 net/socket.c:1365
 __fput+0x198/0x3e4 fs/file_table.c:320
 ____fput+0x20/0x30 fs/file_table.c:348
 task_work_run+0x100/0x148 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x2dc/0xcac kernel/exit.c:820
 do_group_exit+0x98/0xcc kernel/exit.c:950
 get_signal+0xabc/0xb2c kernel/signal.c:2858
 do_signal+0x128/0x438 arch/arm64/kernel/signal.c:1071
 do_notify_resume+0xc0/0x1f0 arch/arm64/kernel/signal.c:1124
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0x9c/0x150 arch/arm64/kernel/entry-common.c:638
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
SMP: stopping secondary CPUs
Kernel Offset: disabled
CPU features: 0x00000,02070084,26017203
Memory Limit: none


Tested on:

commit:         4cee37b3 Merge tag 'mm-hotfixes-stable-2022-12-10-1' o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=10391967880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f24df90d6ec552dc
dashboard link: https://syzkaller.appspot.com/bug?extid=09329bd987ebca21bced
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12366eb7880000

