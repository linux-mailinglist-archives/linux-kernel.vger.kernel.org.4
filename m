Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1646964945B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 14:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiLKNHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 08:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiLKNGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 08:06:37 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B58B11C33
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 05:06:15 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id n8-20020a6b4108000000b006de520dc5c9so4757224ioa.19
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 05:06:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A86R2N1OYcPhZwZAIWHsYSHtJTUfjcd2JPnO812dhN0=;
        b=RsNIz3CWmxAlW3y++W5E8tGwi31RPXKo106Nlk4J48DFwsGiy6WiKi64K34rvwTtaL
         uJV2PMtBXO4JqkZHIBL6iIO5Z9W123amDIH6aNWb2YZWP6nPV7DzZfcrtkwYjZK080op
         0I8VsdKhGv3x5yV0grLWpIKht+aGab/jXlNpRWIsRl49Sn5ISGkvHS7K3+WS77mxvtVl
         MTgtkxdJ0Gkclc62KvWYt0kbfvicfhvhKm2T0PdWJbZWGvPxnz3JWubTQ56Wb8M2eq/p
         esAY3JZbhMLOtVpF2VPlE8tUoprNVaiQg9j+v5G1uIi+Ny2t49eFKQqIgW/B0Gb1TWCD
         jwnA==
X-Gm-Message-State: ANoB5pl51Z38bA0I1xa4daMWP+oPGoMKmGORKedUx8yBPMvt1Jmfrfzi
        tjIjM2uaaK12/HzgLTiLhSZvCXlerGDw+zZoOObr+vsKIM0X
X-Google-Smtp-Source: AA0mqf6e/G3pSrdIlNEqFe49efKRXvQTPWjPS3NC+zBgmo003uCfQK/MWpN/KPnvQ6QCTKhFl7VI2+Zj+Yr17YAF+4rzZ8mvgLzA
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1243:b0:38a:a3f2:f2b7 with SMTP id
 o3-20020a056638124300b0038aa3f2f2b7mr162288jas.106.1670763974825; Sun, 11 Dec
 2022 05:06:14 -0800 (PST)
Date:   Sun, 11 Dec 2022 05:06:14 -0800
In-Reply-To: <20221211124724.2716-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000391e7e05ef8d0d0a@google.com>
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

x8 : 0000000000040577 x7 : ffff80000b22f58c x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000002 x1 : ffff0000d0773eb8 x0 : ffff0000d0773480
Kernel panic - not syncing: kernel stack overflow
CPU: 0 PID: 3688 Comm: syz-executor.0 Not tainted 6.1.0-rc7-syzkaller-00151-ge3cb714fb489-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x54 arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 panic+0x218/0x508 kernel/panic.c:274
 nmi_panic+0xbc/0xf0 kernel/panic.c:169
 panic_bad_stack+0x134/0x154 arch/arm64/kernel/traps.c:886
 handle_bad_stack+0x34/0x48 arch/arm64/kernel/entry-common.c:849
 __bad_stack+0x78/0x7c arch/arm64/kernel/entry.S:552
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
 __arm64_sys_exit_group+0x0/0x18 kernel/exit.c:950
 __do_sys_exit_group kernel/exit.c:961 [inline]
 __se_sys_exit_group kernel/exit.c:959 [inline]
 __wake_up_parent+0x0/0x40 kernel/exit.c:959
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
SMP: stopping secondary CPUs
Kernel Offset: disabled
CPU features: 0x00000,040e0108,4c017203
Memory Limit: none


Tested on:

commit:         e3cb714f Merge branch 'for-next/core' into for-kernelci
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1684ffdf880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ec7118319bfb771e
dashboard link: https://syzkaller.appspot.com/bug?extid=09329bd987ebca21bced
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=171536b7880000

