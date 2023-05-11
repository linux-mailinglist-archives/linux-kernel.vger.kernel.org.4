Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5282A6FEC19
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 09:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbjEKHAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 03:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237345AbjEKHAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 03:00:09 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0A46A76
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 23:59:25 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7606e3c6c8aso545374439f.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 23:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683788319; x=1686380319;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FDmGzb0EAcK7O5vcmkwcvazowRZw0i6s484o3OBJttQ=;
        b=Yev3vNlDTCbUH4l41JdMK3LxpZrN/gjdVy5a3E/hYlW0LwMzGIOMJ6DbQofWasiVWE
         LWkBVQWtTYWZzTVb6qVlqpckmLHPNTcdCQ5in2N5NXroyxj65kAZeymmutvRTaZ6D8S6
         CDe74v5GmMb5AOStxs8Yajb5azyVhed7+x+/cXRkbKWDsMRlqRZVqN9yoDhKJly2tBFi
         +uA32Q6PQcbseEfjeAoFS1CyuLucSCNWXFgNhdkb5bPsDi05dujjU8CMgz0p9RaivrZo
         HDo5oVCWaF0onZLIDOVs8GuDXr3YG8o9SMG+mGlLTKYctK2pmzMpXMagRT3UuhcX1p5d
         PTbg==
X-Gm-Message-State: AC+VfDwNeJ1N4uPkuDHpIb3Wnv87jsIbprH8AWhSZ8JF+60s5uTBLmm5
        PzbKzYheo+eHhUNZyxP8VE+9d152GOoK7y0CvEKtPvBHdcu/
X-Google-Smtp-Source: ACHHUZ7hwuBx0DrAwQF3mb7msJLh363FZDYdEVQJZY1eQ7z+xJ4zU18vqCq8f3C6lBGIzI/dywqo1SJ8456Jojs1CbU3IB+xGBEC
MIME-Version: 1.0
X-Received: by 2002:a6b:7104:0:b0:76c:552c:1c64 with SMTP id
 q4-20020a6b7104000000b0076c552c1c64mr4195105iog.4.1683788319325; Wed, 10 May
 2023 23:58:39 -0700 (PDT)
Date:   Wed, 10 May 2023 23:58:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a686ca05fb6584ea@google.com>
Subject: [syzbot] upstream boot error: KMSAN: uninit-value in strlcat
From:   syzbot <syzbot+26836cb949db3d40c992@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=10811e34280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a7a1059074b7bdce
dashboard link: https://syzkaller.appspot.com/bug?extid=26836cb949db3d40c992
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d4c6da24829a/disk-16a88291.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7b2a0fc666c9/vmlinux-16a88291.xz
kernel image: https://storage.googleapis.com/syzbot-assets/710105c78106/bzImage-16a88291.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+26836cb949db3d40c992@syzkaller.appspotmail.com

sd 0:0:1:0: [sda] 4194304 512-byte logical blocks: (2.15 GB/2.00 GiB)
sd 0:0:1:0: [sda] 4096-byte physical blocks
sd 0:0:1:0: [sda] Write Protect is off
sd 0:0:1:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
=====================================================
BUG: KMSAN: uninit-value in strlen lib/string.c:418 [inline]
BUG: KMSAN: uninit-value in strlcat+0x67/0x160 lib/string.c:252
 strlen lib/string.c:418 [inline]
 strlcat+0x67/0x160 lib/string.c:252
 msdos_partition+0x366d/0x46a0 block/partitions/msdos.c:696
 check_partition block/partitions/core.c:138 [inline]
 blk_add_partitions block/partitions/core.c:594 [inline]
 bdev_disk_changed+0xab5/0x2070 block/partitions/core.c:680
 blkdev_get_whole+0x633/0x6c0 block/bdev.c:619
 blkdev_get_by_dev+0x50f/0x1200 block/bdev.c:756
 disk_scan_partitions+0x2d8/0x3d0 block/genhd.c:379
 device_add_disk+0x16d9/0x17b0 block/genhd.c:519
 sd_probe+0x132e/0x1710 drivers/scsi/sd.c:3587
 really_probe+0x506/0xf40 drivers/base/dd.c:658
 __driver_probe_device+0x2a7/0x5d0 drivers/base/dd.c:800
 driver_probe_device+0x72/0x7b0 drivers/base/dd.c:830
 __device_attach_driver+0x55a/0x8f0 drivers/base/dd.c:958
 bus_for_each_drv+0x3ff/0x620 drivers/base/bus.c:457
 __device_attach_async_helper+0x208/0x2b0 drivers/base/dd.c:987
 async_run_entry_fn+0x97/0x420 kernel/async.c:127
 process_one_work+0xb0d/0x1410 kernel/workqueue.c:2405
 worker_thread+0x107e/0x1d60 kernel/workqueue.c:2552
 kthread+0x3e8/0x540 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Uninit was created at:
 __alloc_pages+0x9a4/0xe00 mm/page_alloc.c:4791
 alloc_pages+0xd01/0x1040
 __get_free_pages+0x34/0xc0 mm/page_alloc.c:4818
 check_partition block/partitions/core.c:122 [inline]
 blk_add_partitions block/partitions/core.c:594 [inline]
 bdev_disk_changed+0x63c/0x2070 block/partitions/core.c:680
 blkdev_get_whole+0x633/0x6c0 block/bdev.c:619
 blkdev_get_by_dev+0x50f/0x1200 block/bdev.c:756
 disk_scan_partitions+0x2d8/0x3d0 block/genhd.c:379
 device_add_disk+0x16d9/0x17b0 block/genhd.c:519
 sd_probe+0x132e/0x1710 drivers/scsi/sd.c:3587
 really_probe+0x506/0xf40 drivers/base/dd.c:658
 __driver_probe_device+0x2a7/0x5d0 drivers/base/dd.c:800
 driver_probe_device+0x72/0x7b0 drivers/base/dd.c:830
 __device_attach_driver+0x55a/0x8f0 drivers/base/dd.c:958
 bus_for_each_drv+0x3ff/0x620 drivers/base/bus.c:457
 __device_attach_async_helper+0x208/0x2b0 drivers/base/dd.c:987
 async_run_entry_fn+0x97/0x420 kernel/async.c:127
 process_one_work+0xb0d/0x1410 kernel/workqueue.c:2405
 worker_thread+0x107e/0x1d60 kernel/workqueue.c:2552
 kthread+0x3e8/0x540 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

CPU: 1 PID: 1018 Comm: kworker/u4:5 Not tainted 6.4.0-rc1-syzkaller-00012-g16a8829130ca #0
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
