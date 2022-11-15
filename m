Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F10E629363
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 09:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbiKOIkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 03:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiKOIk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 03:40:29 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F95B5582
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 00:40:27 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id o15-20020a6bf80f000000b006de313e5cfeso1463426ioh.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 00:40:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lwZfx/3jg+Ow49vxwezXj+5XiccGEFeFExEcWnLmTE8=;
        b=JyR18aAXPKBFzjrIKyz+wIjgT7mPrYg6KHOMVsD628hu9nzUXnKjPspvHpqgDWwVQE
         NDIJqy7m2scyL3VXbNoz8xo4BJecNQaWKjjByRlhjWz7qBeKW2kiuafjkN2Bg98ekESx
         K2zPYa80E1VOpR/s44P26/uoknLRRaC90G+MI0LPZvbIratgbA9dKBq1dX9GXc8RFBxi
         HcMB3IzhdRtESfFJRt0yjKuEW+TWygBaMl4jg6A/YjGLYzYwJcXk03370wPepuCDCZn+
         +vb7SQEh/GWZ/AYXhMQuo1QSIGQsLLAaqB2wlc0TbmiDaFIUfWUPW6t2p8U+gilQhyPZ
         Ut/A==
X-Gm-Message-State: ANoB5pknr/7Onw0tMzJrPg23KE4oerORE7qKMMV5qUn9lYkAGGUDuj54
        aN4VbaxjjqbfnnApP8axnmUr/Q9cHYwSDBgPiFkxKRVgaGuZ
X-Google-Smtp-Source: AA0mqf6xsS6ZqzqAEUGvLrrKAIBniuOyk0FavhAAN3jySKYfAeYVmkhmlUqo/ZOs9n0SUy5anXXgN4KTsh+1fDpkruIii44L5pOG
MIME-Version: 1.0
X-Received: by 2002:a02:cb46:0:b0:376:2566:6bdd with SMTP id
 k6-20020a02cb46000000b0037625666bddmr469678jap.234.1668501626371; Tue, 15 Nov
 2022 00:40:26 -0800 (PST)
Date:   Tue, 15 Nov 2022 00:40:26 -0800
In-Reply-To: <20221115031714.2242-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bf457405ed7e4e87@google.com>
Subject: Re: [syzbot] possible deadlock in nci_set_local_general_bytes
From:   syzbot <syzbot+8768e9ec924b08e63f82@syzkaller.appspotmail.com>
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
possible deadlock in virtual_nci_close

nci: __nci_request: wait_for_completion_interruptible_timeout failed -512
======================================================
WARNING: possible circular locking dependency detected
6.1.0-rc4-syzkaller-00039-g1621b6eaebf7-dirty #0 Not tainted
------------------------------------------------------
syz-executor.0/4106 is trying to acquire lock:
ffff80000d5eaae0 (nci_mutex){+.+.}-{3:3}, at: virtual_nci_close+0x28/0x58 drivers/nfc/virtual_ncidev.c:44

but task is already holding lock:
ffff0000cb1f4350 (&ndev->req_lock){+.+.}-{3:3}, at: nci_close_device+0x74/0x2b4 net/nfc/nci/core.c:562

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&ndev->req_lock){+.+.}-{3:3}:
       __mutex_lock_common+0xd4/0xca8 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x38/0x44 kernel/locking/mutex.c:799
       nci_request net/nfc/nci/core.c:148 [inline]
       nci_set_local_general_bytes+0xbc/0x480 net/nfc/nci/core.c:776
       nci_start_poll+0x1e8/0x474 net/nfc/nci/core.c:840
       nfc_start_poll+0xfc/0x170 net/nfc/core.c:225
       nfc_genl_start_poll+0xd4/0x174 net/nfc/netlink.c:828
       genl_family_rcv_msg_doit net/netlink/genetlink.c:756 [inline]
       genl_family_rcv_msg net/netlink/genetlink.c:833 [inline]
       genl_rcv_msg+0x458/0x4f4 net/netlink/genetlink.c:850
       netlink_rcv_skb+0xe8/0x1d4 net/netlink/af_netlink.c:2540
       genl_rcv+0x38/0x50 net/netlink/genetlink.c:861
       netlink_unicast_kernel+0xfc/0x1dc net/netlink/af_netlink.c:1319
       netlink_unicast+0x164/0x248 net/netlink/af_netlink.c:1345
       netlink_sendmsg+0x484/0x584 net/netlink/af_netlink.c:1921
       sock_sendmsg_nosec net/socket.c:714 [inline]
       sock_sendmsg net/socket.c:734 [inline]
       ____sys_sendmsg+0x2f8/0x440 net/socket.c:2482
       ___sys_sendmsg net/socket.c:2536 [inline]
       __sys_sendmsg+0x1ac/0x228 net/socket.c:2565
       __do_sys_sendmsg net/socket.c:2574 [inline]
       __se_sys_sendmsg net/socket.c:2572 [inline]
       __arm64_sys_sendmsg+0x2c/0x3c net/socket.c:2572
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

-> #2 (&genl_data->genl_data_mutex){+.+.}-{3:3}:
       __mutex_lock_common+0xd4/0xca8 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x38/0x44 kernel/locking/mutex.c:799
       nfc_urelease_event_work+0x88/0x16c net/nfc/netlink.c:1811
       process_one_work+0x2d8/0x504 kernel/workqueue.c:2289
       worker_thread+0x340/0x610 kernel/workqueue.c:2436
       kthread+0x12c/0x158 kernel/kthread.c:376
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:863

-> #1 (nfc_devlist_mutex){+.+.}-{3:3}:
       __mutex_lock_common+0xd4/0xca8 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x38/0x44 kernel/locking/mutex.c:799
       nfc_register_device+0x34/0x208 net/nfc/core.c:1116
       nci_register_device+0x338/0x3b0 net/nfc/nci/core.c:1258
       virtual_ncidev_open+0x6c/0xd8 drivers/nfc/virtual_ncidev.c:146
       misc_open+0x1b8/0x200 drivers/char/misc.c:143
       chrdev_open+0x2b4/0x2e8 fs/char_dev.c:414
       do_dentry_open+0x364/0x748 fs/open.c:882
       vfs_open+0x38/0x48 fs/open.c:1013
       do_open fs/namei.c:3557 [inline]
       path_openat+0xe34/0x11c4 fs/namei.c:3713
       do_filp_open+0xdc/0x1b8 fs/namei.c:3740
       do_sys_openat2+0xb8/0x22c fs/open.c:1310
       do_sys_open fs/open.c:1326 [inline]
       __do_sys_openat fs/open.c:1342 [inline]
       __se_sys_openat fs/open.c:1337 [inline]
       __arm64_sys_openat+0xb0/0xe0 fs/open.c:1337
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

-> #0 (nci_mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain kernel/locking/lockdep.c:3831 [inline]
       __lock_acquire+0x1530/0x3084 kernel/locking/lockdep.c:5055
       lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5668
       __mutex_lock_common+0xd4/0xca8 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x38/0x44 kernel/locking/mutex.c:799
       virtual_nci_close+0x28/0x58 drivers/nfc/virtual_ncidev.c:44
       nci_close_device+0x188/0x2b4 net/nfc/nci/core.c:594
       nci_unregister_device+0x3c/0x100 net/nfc/nci/core.c:1293
       virtual_ncidev_close+0x70/0xb0 drivers/nfc/virtual_ncidev.c:166
       __fput+0x198/0x3e4 fs/file_table.c:320
       ____fput+0x20/0x30 fs/file_table.c:348
       task_work_run+0x100/0x148 kernel/task_work.c:179
       resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
       do_notify_resume+0x174/0x1f0 arch/arm64/kernel/signal.c:1127
       prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
       exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
       el0_svc+0x9c/0x150 arch/arm64/kernel/entry-common.c:638
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

other info that might help us debug this:

Chain exists of:
  nci_mutex --> &genl_data->genl_data_mutex --> &ndev->req_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ndev->req_lock);
                               lock(&genl_data->genl_data_mutex);
                               lock(&ndev->req_lock);
  lock(nci_mutex);

 *** DEADLOCK ***

1 lock held by syz-executor.0/4106:
 #0: ffff0000cb1f4350 (&ndev->req_lock){+.+.}-{3:3}, at: nci_close_device+0x74/0x2b4 net/nfc/nci/core.c:562

stack backtrace:
CPU: 1 PID: 4106 Comm: syz-executor.0 Not tainted 6.1.0-rc4-syzkaller-00039-g1621b6eaebf7-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x54 arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 print_circular_bug+0x2c4/0x2c8 kernel/locking/lockdep.c:2055
 check_noncircular+0x14c/0x154 kernel/locking/lockdep.c:2177
 check_prev_add kernel/locking/lockdep.c:3097 [inline]
 check_prevs_add kernel/locking/lockdep.c:3216 [inline]
 validate_chain kernel/locking/lockdep.c:3831 [inline]
 __lock_acquire+0x1530/0x3084 kernel/locking/lockdep.c:5055
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5668
 __mutex_lock_common+0xd4/0xca8 kernel/locking/mutex.c:603
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x38/0x44 kernel/locking/mutex.c:799
 virtual_nci_close+0x28/0x58 drivers/nfc/virtual_ncidev.c:44
 nci_close_device+0x188/0x2b4 net/nfc/nci/core.c:594
 nci_unregister_device+0x3c/0x100 net/nfc/nci/core.c:1293
 virtual_ncidev_close+0x70/0xb0 drivers/nfc/virtual_ncidev.c:166
 __fput+0x198/0x3e4 fs/file_table.c:320
 ____fput+0x20/0x30 fs/file_table.c:348
 task_work_run+0x100/0x148 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x174/0x1f0 arch/arm64/kernel/signal.c:1127
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0x9c/0x150 arch/arm64/kernel/entry-common.c:638
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584


Tested on:

commit:         1621b6ea Merge branch 'for-next/fixes' into for-kernelci
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=163ba9c1880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=699b4d125fc2883
dashboard link: https://syzkaller.appspot.com/bug?extid=8768e9ec924b08e63f82
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11f33185880000

