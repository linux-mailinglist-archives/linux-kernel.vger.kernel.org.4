Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF77C65CDCB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 08:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbjADHpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 02:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjADHpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 02:45:18 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C30193E2
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 23:45:17 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id b24-20020a056602219800b006e2bf9902cbso9283838iob.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 23:45:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rJ4W8/mmVdVrFQNvYsx/DMYr6reSTCisMPcgxKG9a3E=;
        b=Y/OMm8agIJlwjPiovEipFXIguBcDpeEtVBAXxjVHdRD8UaMavPBZ4KhYUlOM+BkX4q
         jA/z7Jf4uYtz1sidMOdHcFmkDhYfqpD/XRNd4PXLvkwAp/5+iQR9/6rRAxhIv/VmC2Uu
         i6SkZfSs0tYYzRcy0//s/SdCm/6pnUjRB1HpaSHvz3yXCBxswWUyWamuNCw/Pf6hf/Us
         MnP1HJvwr0kukBegDw6nl609bAFilt62TC+K0jPPAfcKdWWRGQ8I761A7sZbmW70++p5
         FDsWtyzE5adJmMzPOi3PuPvVFX7lN+JTk+tTtn+xvp7lkvWuODaxEdv5KG40uup6vuPC
         agbg==
X-Gm-Message-State: AFqh2kpnOrFvKSjkmarRVOosbG4JU75RWakoKpqD4os3VCPtuvbgrAL/
        J2qWJd0M/Yy3+r1xQWBLqo6fr8RiN8oqT97X832KmfTaxJ+g
X-Google-Smtp-Source: AMrXdXvwVkZzng5C+4mgIQ68JLoEjHniOdUfoFXDLNJACOLxpO5H5li69Yq+KOnQHWVPVTeiZxT3qGrJ3R5yiNYWg4ya6Xq+pKB+
MIME-Version: 1.0
X-Received: by 2002:a02:9f97:0:b0:39d:7413:1ac1 with SMTP id
 a23-20020a029f97000000b0039d74131ac1mr2985730jam.75.1672818316311; Tue, 03
 Jan 2023 23:45:16 -0800 (PST)
Date:   Tue, 03 Jan 2023 23:45:16 -0800
In-Reply-To: <20230104040132.4103-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000084839c05f16b5d95@google.com>
Subject: Re: [syzbot] [gfs2?] INFO: task hung in freeze_super (3)
From:   syzbot <syzbot+f51cb4b9afbd87ec06f2@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, hdanton@sina.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        longman@redhat.com, penguin-kernel@i-love.sakura.ne.jp,
        rpeterso@redhat.com, syzkaller-bugs@googlegroups.com
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in freeze_super

======================================================
WARNING: possible circular locking dependency detected
6.2.0-rc2-syzkaller-00127-g69b41ac87e4a-dirty #0 Not tainted
------------------------------------------------------
kworker/1:1H/93 is trying to acquire lock:
ffff88802666e0e0 (&type->s_umount_key#50){+.+.}-{3:3}, at: freeze_super+0x45/0x420 fs/super.c:1655

but task is already holding lock:
ffffc90002587d00 ((work_completion)(&(&gl->gl_work)->work)){+.+.}-{0:0}, at: process_one_work+0x831/0xdb0 kernel/workqueue.c:2264

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
       __flush_workqueue+0x17c/0x16d0 kernel/workqueue.c:2809
       gfs2_gl_hash_clear+0xa3/0x300 fs/gfs2/glock.c:2191
       gfs2_put_super+0x862/0x8d0 fs/gfs2/super.c:627
       generic_shutdown_super+0x130/0x310 fs/super.c:492
       kill_block_super+0x79/0xd0 fs/super.c:1386
       deactivate_locked_super+0xa7/0xf0 fs/super.c:332
       cleanup_mnt+0x494/0x520 fs/namespace.c:1291
       task_work_run+0x243/0x300 kernel/task_work.c:179
       resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
       exit_to_user_mode_loop+0x124/0x150 kernel/entry/common.c:171
       exit_to_user_mode_prepare+0xb2/0x140 kernel/entry/common.c:203
       __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
       syscall_exit_to_user_mode+0x26/0x60 kernel/entry/common.c:296
       do_syscall_64+0x49/0xb0 arch/x86/entry/common.c:86
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&type->s_umount_key#50){+.+.}-{3:3}:
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
  &type->s_umount_key#50 --> (wq_completion)glock_workqueue --> (work_completion)(&(&gl->gl_work)->work)

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock((work_completion)(&(&gl->gl_work)->work));
                               lock((wq_completion)glock_workqueue);
                               lock((work_completion)(&(&gl->gl_work)->work));
  lock(&type->s_umount_key#50);

 *** DEADLOCK ***

2 locks held by kworker/1:1H/93:
 #0: ffff888012bf7d38 ((wq_completion)glock_workqueue){+.+.}-{0:0}, at: process_one_work+0x7f2/0xdb0
 #1: ffffc90002587d00 ((work_completion)(&(&gl->gl_work)->work)){+.+.}-{0:0}, at: process_one_work+0x831/0xdb0 kernel/workqueue.c:2264

stack backtrace:
CPU: 1 PID: 93 Comm: kworker/1:1H Not tainted 6.2.0-rc2-syzkaller-00127-g69b41ac87e4a-dirty #0
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


Tested on:

commit:         69b41ac8 Merge tag 'for-6.2-rc2-tag' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=154506dc480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9babfdc3dd4772d0
dashboard link: https://syzkaller.appspot.com/bug?extid=f51cb4b9afbd87ec06f2
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11d59a52480000

