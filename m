Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892D3658EB0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 16:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbiL2P6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 10:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbiL2P6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 10:58:43 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090DAA3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 07:58:43 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id a9-20020a921a09000000b0030bda27ddcbso12100212ila.18
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 07:58:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZWhUOqvVJv7oMXAvzTaUDDWk6sU1KCsBpgr8vlboZQ=;
        b=U1w3jIH4a9l+INi7qjpkrCUDC312V17kDd6B7HPcBixvPXRT7mtTk0lElZj7Rbp51l
         IYhbESRRp6S38fnsPUQffynboVvvQ44kK9kk7PNsNOfycSXMRxGAsR4yuJHGJyjJtHEy
         KtRA8zpDYKzQIHrBDuwWWJz0SuNxQqcwsU38noMLvZf8ehQjqJD5OUlPpjvhMX+WB5HY
         y7IZNwzTQYnedq8sX8kO8rxpogQdiN4+i6TZYj5RpzdCbPgWaSM/gzX1qXbDyTd6vp/L
         hJl+8yCX+yqhdBBEDoihQfpiC0RucD2M7HXRUDjnnfpjWxx4mGfYSjsJcvh9+KlVGFY0
         MjEQ==
X-Gm-Message-State: AFqh2kogw398AkmOaX5SmzAYzT363UBQsFMrIZI7AeCCTUkC7V30ttzY
        417AqVRjT2yDf60qoX5BRrsCt/uHXzXJaGcpe880XG18H5+P
X-Google-Smtp-Source: AMrXdXvMb/TP+vKk1RlbLZ0l7Y8aCbuuq8FtUUFt8g6TaiSOB1Uu8DI3S/s43jyO/jfJCGP4iL1OGNeVOwy9eHDLaDNBMZQ21CDR
MIME-Version: 1.0
X-Received: by 2002:a02:6f04:0:b0:38a:8910:44c6 with SMTP id
 x4-20020a026f04000000b0038a891044c6mr2470581jab.251.1672329522374; Thu, 29
 Dec 2022 07:58:42 -0800 (PST)
Date:   Thu, 29 Dec 2022 07:58:42 -0800
In-Reply-To: <000000000000b9753505eaa93b18@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000020f3ac05f0f98f86@google.com>
Subject: Re: [syzbot] [gfs2?] possible deadlock in freeze_super (2)
From:   syzbot <syzbot+be899d4f10b2a9522dce@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, rpeterso@redhat.com,
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    1b929c02afd3 Linux 6.2-rc1
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11447312480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=68e0be42c8ee4bb4
dashboard link: https://syzkaller.appspot.com/bug?extid=be899d4f10b2a9522dce
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b638c0480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b17270480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2d8c5072480f/disk-1b929c02.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/46687f1395db/vmlinux-1b929c02.xz
kernel image: https://storage.googleapis.com/syzbot-assets/26f1afa5ec00/bzImage-1b929c02.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/952580c084c8/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+be899d4f10b2a9522dce@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.2.0-rc1-syzkaller #0 Not tainted
------------------------------------------------------
kworker/0:1H/52 is trying to acquire lock:
ffff8880277440e0 (&type->s_umount_key#44){+.+.}-{3:3}, at: freeze_super+0x45/0x420 fs/super.c:1655

but task is already holding lock:
ffffc90000bd7d00 ((work_completion)(&(&gl->gl_work)->work)){+.+.}-{0:0}, at: process_one_work+0x831/0xdb0 kernel/workqueue.c:2264

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 ((work_completion)(&(&gl->gl_work)->work)){+.+.}-{0:0}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       process_one_work+0x852/0xdb0 kernel/workqueue.c:2265
       worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
       kthread+0x266/0x300 kernel/kthread.c:376
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

-> #1 ((wq_completion)glock_workqueue){+.+.}-{0:0}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       __flush_workqueue+0x178/0x1680 kernel/workqueue.c:2809
       gfs2_gl_hash_clear+0xa3/0x300 fs/gfs2/glock.c:2191
       gfs2_put_super+0x862/0x8d0 fs/gfs2/super.c:627
       generic_shutdown_super+0x130/0x310 fs/super.c:492
       kill_block_super+0x79/0xd0 fs/super.c:1386
       deactivate_locked_super+0xa7/0xf0 fs/super.c:332
       cleanup_mnt+0x494/0x520 fs/namespace.c:1291
       task_work_run+0x243/0x300 kernel/task_work.c:179
       ptrace_notify+0x29a/0x340 kernel/signal.c:2354
       ptrace_report_syscall include/linux/ptrace.h:411 [inline]
       ptrace_report_syscall_exit include/linux/ptrace.h:473 [inline]
       syscall_exit_work+0x8c/0xe0 kernel/entry/common.c:251
       syscall_exit_to_user_mode_prepare+0x63/0xc0 kernel/entry/common.c:278
       __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
       syscall_exit_to_user_mode+0xa/0x60 kernel/entry/common.c:296
       do_syscall_64+0x49/0xb0 arch/x86/entry/common.c:86
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&type->s_umount_key#44){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain+0x1898/0x6ae0 kernel/locking/lockdep.c:3831
       __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       down_write+0x9c/0x270 kernel/locking/rwsem.c:1562
       freeze_super+0x45/0x420 fs/super.c:1655
       freeze_go_sync+0x178/0x340 fs/gfs2/glops.c:577
       do_xmote+0x34d/0x13d0 fs/gfs2/glock.c:708
       glock_work_func+0x2c2/0x450 fs/gfs2/glock.c:1056
       process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
       worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
       kthread+0x266/0x300 kernel/kthread.c:376
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

other info that might help us debug this:

Chain exists of:
  &type->s_umount_key#44 --> (wq_completion)glock_workqueue --> (work_completion)(&(&gl->gl_work)->work)

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock((work_completion)(&(&gl->gl_work)->work));
                               lock((wq_completion)glock_workqueue);
                               lock((work_completion)(&(&gl->gl_work)->work));
  lock(&type->s_umount_key#44);

 *** DEADLOCK ***

2 locks held by kworker/0:1H/52:
 #0: ffff888018293938 ((wq_completion)glock_workqueue){+.+.}-{0:0}, at: process_one_work+0x7f2/0xdb0
 #1: ffffc90000bd7d00 ((work_completion)(&(&gl->gl_work)->work)
){+.+.}-{0:0}
, at: process_one_work+0x831/0xdb0 kernel/workqueue.c:2264

stack backtrace:
CPU: 0 PID: 52 Comm: kworker/0:1H Not tainted 6.2.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: glock_workqueue glock_work_func
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
 check_noncircular+0x2cc/0x390 kernel/locking/lockdep.c:2177
 check_prev_add kernel/locking/lockdep.c:3097 [inline]
 check_prevs_add kernel/locking/lockdep.c:3216 [inline]
 validate_chain+0x1898/0x6ae0 kernel/locking/lockdep.c:3831
 __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
 lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
 down_write+0x9c/0x270 kernel/locking/rwsem.c:1562
 freeze_super+0x45/0x420 fs/super.c:1655
 freeze_go_sync+0x178/0x340 fs/gfs2/glops.c:577
 do_xmote+0x34d/0x13d0 fs/gfs2/glock.c:708
 glock_work_func+0x2c2/0x450 fs/gfs2/glock.c:1056
 process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

