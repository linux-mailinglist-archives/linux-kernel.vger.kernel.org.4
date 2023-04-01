Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A016D2E86
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 08:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbjDAGPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 02:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjDAGPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 02:15:43 -0400
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D177EFBA
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 23:15:41 -0700 (PDT)
Received: by mail-io1-f80.google.com with SMTP id z65-20020a6bc944000000b007584beb0e28so14519080iof.21
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 23:15:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680329740; x=1682921740;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XqNN61HFN9AplPUAzlgJ4Lk0uE9RFppc2dGoBPDTz44=;
        b=EZ/N5v5XUYBE6HZ5D0BTLkKEbD/QMm7D8t6jSebRJSNSxq4L/niE/CHrm/efe5QH5L
         u1RC36JF1+v3/BSWSSjpmtEv+GZDy0v6sTc5NXvlR7vyqDTPWOFIiCnOyYPCfrtZoBOw
         b/A5G/YZi/bBic8F01gbkgCF5fMJ66rt9Cz7y5ec1C2cz81RWoIWKPW5EJhcxjeET9/q
         UQQeTqxJO3U1bkZPmoqj3N0J8YNaZCG8LygaRhG0ElDpgU3oJDKa5tYn4nOD2m5C9UJh
         zzBWTSlSBVhlsFZBfTdnVBlNvsOaNNKGEbryHrttCR7G4x4Nz0SiD6W8HAEpmWeu7NIn
         cw6Q==
X-Gm-Message-State: AAQBX9e0Tls3p7wpZIgKAsB24JGGEqumiYPr+fA4RyLJWMtgUlTk8Zxe
        T7JVXPU70SPXynq/vBRYN3t81IUpGDJHF7JJFF6wJYQauskb
X-Google-Smtp-Source: AKy350bZqtamB1Vq06uzF8HFZMKc15oFP+0u6nylgPGgQGTrdDe4+5VgG+vfYgjUKXjWeBz52pgJbgMD7B/ffkBweaPpCTXc8b10
MIME-Version: 1.0
X-Received: by 2002:a6b:7b49:0:b0:75d:2e78:ee76 with SMTP id
 m9-20020a6b7b49000000b0075d2e78ee76mr1347408iop.4.1680329740600; Fri, 31 Mar
 2023 23:15:40 -0700 (PDT)
Date:   Fri, 31 Mar 2023 23:15:40 -0700
In-Reply-To: <00000000000078275b05b798f7df@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004b4e4805f84041e0@google.com>
Subject: Re: [syzbot] [usb?] INFO: task hung in usbdev_open (2)
From:   syzbot <syzbot+b73659f5bb96fac34820@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jeremy.linton@arm.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.1 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    59caa87f9dfb Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=16dd438ec80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e918bdf4f2f853c4
dashboard link: https://syzkaller.appspot.com/bug?extid=b73659f5bb96fac34820
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15cb0c69c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=160d1e21c80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4d91c587af1a/disk-59caa87f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c2a88c8fab99/vmlinux-59caa87f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0f56d2d1cbfc/Image-59caa87f.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b73659f5bb96fac34820@syzkaller.appspotmail.com

INFO: task syz-executor388:6000 blocked for more than 143 seconds.
      Not tainted 6.3.0-rc4-syzkaller-g59caa87f9dfb #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor388 state:D stack:0     pid:6000  ppid:5984   flags:0x00000001
Call trace:
 __switch_to+0x320/0x754 arch/arm64/kernel/process.c:556
 context_switch kernel/sched/core.c:5307 [inline]
 __schedule+0x1048/0x1e38 kernel/sched/core.c:6625
 schedule+0xc4/0x170 kernel/sched/core.c:6701
 schedule_preempt_disabled+0x18/0x2c kernel/sched/core.c:6760
 __mutex_lock_common+0xbd8/0x21a0 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x38/0x44 kernel/locking/mutex.c:799
 device_lock include/linux/device.h:832 [inline]
 usbdev_open+0x13c/0x6c0 drivers/usb/core/devio.c:1041
 chrdev_open+0x3e8/0x4fc fs/char_dev.c:414
 do_dentry_open+0x724/0xf90 fs/open.c:920
 vfs_open+0x7c/0x90 fs/open.c:1051
 do_open fs/namei.c:3560 [inline]
 path_openat+0x1f2c/0x27f8 fs/namei.c:3715
 do_filp_open+0x1bc/0x3cc fs/namei.c:3742
 do_sys_openat2+0x128/0x3d8 fs/open.c:1348
 do_sys_open fs/open.c:1364 [inline]
 __do_sys_openat fs/open.c:1380 [inline]
 __se_sys_openat fs/open.c:1375 [inline]
 __arm64_sys_openat+0x1f0/0x240 fs/open.c:1375
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
 el0_svc+0x58/0x168 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/12:
 #0: ffff800015d36810 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x44/0xcf4 kernel/rcu/tasks.h:510
1 lock held by rcu_tasks_trace/13:
 #0: ffff800015d37010 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x44/0xcf4 kernel/rcu/tasks.h:510
1 lock held by khungtaskd/28:
 #0: ffff800015d36640 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0xc/0x44 include/linux/rcupdate.h:326
5 locks held by kworker/0:2/1522:
 #0: ffff0000c13f7d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x664/0x12d4 kernel/workqueue.c:2363
 #1: ffff8000225b7c20 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x6a8/0x12d4 kernel/workqueue.c:2365
 #2: ffff0000ceaa4190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:832 [inline]
 #2: ffff0000ceaa4190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c8/0x474c drivers/usb/core/hub.c:5739
 #3: ffff0000d2dd1190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:832 [inline]
 #3: ffff0000d2dd1190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x90/0x434 drivers/base/dd.c:973
 #4: ffff0000cc332118 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:832 [inline]
 #4: ffff0000cc332118 (&dev->mutex){....}-{3:3}, at: __device_attach+0x90/0x434 drivers/base/dd.c:973
2 locks held by getty/5625:
 #0: ffff0000d354c098 (&tty->ldisc_sem){++++}-{0:0}, at: ldsem_down_read+0x3c/0x4c drivers/tty/tty_ldsem.c:340
 #1: ffff80001a8602f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x414/0x1210 drivers/tty/n_tty.c:2177
4 locks held by udevd/5996:
 #0: ffff0000d0fe41c8 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xac/0xc44 fs/seq_file.c:182
 #1: ffff0000cf47a088 (&of->mutex){+.+.}-{3:3}, at: kernfs_seq_start+0x58/0x384 fs/kernfs/file.c:154
 #2: ffff0000d37d0660 (kn->active#14){.+.+}-{0:0}, at: kernfs_seq_start+0x74/0x384 fs/kernfs/file.c:155
 #3: ffff0000d2dd1190 (&dev->mutex){....}-{3:3}, at: device_lock_interruptible include/linux/device.h:837 [inline]
 #3: ffff0000d2dd1190 (&dev->mutex){....}-{3:3}, at: manufacturer_show+0x30/0xac drivers/usb/core/sysfs.c:142
1 lock held by syz-executor388/6000:
 #0: ffff0000ceaa4190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:832 [inline]
 #0: ffff0000ceaa4190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x13c/0x6c0 drivers/usb/core/devio.c:1041

=============================================


