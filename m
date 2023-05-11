Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0F96FEC1A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 09:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236941AbjEKHAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 03:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237350AbjEKHAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 03:00:09 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469F265A0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 23:59:25 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-763c3442563so544874439f.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 23:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683788319; x=1686380319;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WN5PFATTZHA54ISSQ7zes2bFpUInfaZ2kfXXd5367QU=;
        b=avRKxOfMXk2giIwgSoMKblVOdAdDFBEAxvRiLkQcCAzZY0X3uBYRsJbFDtlReCeLDX
         l4p+Fxd8HwOa2Ik0p0SV1hohLY9tVOD1EEcIeq+lOVOzcc0WHQ/ULkxzt+1WwFtwdo4Y
         FRK3mlFeM7wD44VebofF4WGw/GB4tzgtMQurb3DunS6cMq7pBbjyVvkJv9oo6qCwCmqb
         IQEY+7IxDSIWRvzQsKIbxshe+rHCT7+Y3miniVpDrvxvNsE2RgATOeLdunQZ+e+hgpTT
         jfNZzcp5hXlX/Elr8+CD+6OaGSH3WL2W6sux23/ar+yjGrH3eefvHl61hzufbhl02Mhp
         SByA==
X-Gm-Message-State: AC+VfDyDMYrfatF1OS5jnI4D5GdnufSIPgzaeugrQ8z/gnXw22hrR9IU
        Dcpd8MJu+mqOo0FJjY70LQch4LBVtHzSyUF6Y0a2VbUN/qw2
X-Google-Smtp-Source: ACHHUZ6lzdostnls62kWkjlkXdEHUHVPKvj6frxV8VTQ60D23Kq79Oi5JtFBHXeZQtn/EodnGiFzM8l+WxHke0QP8a+8Mk+3MGS/
MIME-Version: 1.0
X-Received: by 2002:a02:94cd:0:b0:40f:80e3:6585 with SMTP id
 x71-20020a0294cd000000b0040f80e36585mr4250372jah.1.1683788319068; Wed, 10 May
 2023 23:58:39 -0700 (PDT)
Date:   Wed, 10 May 2023 23:58:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a294db05fb6584a4@google.com>
Subject: [syzbot] upstream boot error: KMSAN: uninit-value in unregister_blkdev
From:   syzbot <syzbot+a66467b3864e82f8559f@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    16a8829130ca nfs: fix another case of NULL/IS_ERR confusio..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17c0674c280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a7a1059074b7bdce
dashboard link: https://syzkaller.appspot.com/bug?extid=a66467b3864e82f8559f
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d4c6da24829a/disk-16a88291.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7b2a0fc666c9/vmlinux-16a88291.xz
kernel image: https://storage.googleapis.com/syzbot-assets/710105c78106/bzImage-16a88291.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a66467b3864e82f8559f@syzkaller.appspotmail.com

floppy0: no floppy controllers found
work still pending
=====================================================
BUG: KMSAN: uninit-value in strcmp+0xcf/0x120 lib/string.c:283
 strcmp+0xcf/0x120 lib/string.c:283
 unregister_blkdev+0x142/0x270 block/genhd.c:293
 do_floppy_init+0x4d3/0x15f0 drivers/block/floppy.c:4751
 floppy_async_init+0x17/0x20 drivers/block/floppy.c:4767
 async_run_entry_fn+0x97/0x420 kernel/async.c:127
 process_one_work+0xb0d/0x1410 kernel/workqueue.c:2405
 worker_thread+0x107e/0x1d60 kernel/workqueue.c:2552
 kthread+0x3e8/0x540 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Uninit was created at:
 slab_post_alloc_hook+0x12d/0xb60 mm/slab.h:716
 slab_alloc_node mm/slub.c:3451 [inline]
 __kmem_cache_alloc_node+0x4ff/0x8b0 mm/slub.c:3490
 kmalloc_trace+0x51/0x200 mm/slab_common.c:1057
 kmalloc include/linux/slab.h:559 [inline]
 __register_blkdev+0x1a9/0x650 block/genhd.c:246
 do_floppy_init+0x420/0x15f0 drivers/block/floppy.c:4604
 floppy_async_init+0x17/0x20 drivers/block/floppy.c:4767
 async_run_entry_fn+0x97/0x420 kernel/async.c:127
 process_one_work+0xb0d/0x1410 kernel/workqueue.c:2405
 worker_thread+0x107e/0x1d60 kernel/workqueue.c:2552
 kthread+0x3e8/0x540 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

CPU: 1 PID: 39 Comm: kworker/u4:3 Not tainted 6.4.0-rc1-syzkaller-00012-g16a8829130ca #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
Workqueue: events_unbound async_run_entry_fn

=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
