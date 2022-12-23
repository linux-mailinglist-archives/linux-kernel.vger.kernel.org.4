Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54940654F04
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 11:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiLWKP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 05:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiLWKPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 05:15:51 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3B0647D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 02:15:49 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id z19-20020a921a53000000b0030b90211df1so2458969ill.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 02:15:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C2I6O7Fbax8x8keJYdYuVSgEuRrWH/5GJgLyVKDuCNw=;
        b=b04BSMB9HPx7rEbAAU4bPlfLR4w3S8Db4aFhkstYc4pGIoL6/sCKFHoZcn69zh4h+9
         bRAYDkwmgFm4k3ntqValaFSwl6+ScBrwX1R0hQdQnpHd8MOgWVRElOHIB1+ptInnChk3
         XrB5sQcUiwULDuPAmrlGccI/HLJqcJnH5aM9Vp7XGlxvxGM+Om/dWj/imXYe9CmXl3+d
         Zz/YkzEEws4JNyHSI241/VeOlzghpMm1ioR+tpb1YnYA3vtblEO+Har5iVhqtNqU2r9F
         gPV7ICqaoZ/TxDLJkkUDC4GZ58fM5z4dFcmfWpyzwrN/l8nQBxukEYcxF8VCXIZZtmD/
         lEQw==
X-Gm-Message-State: AFqh2krK0hZTJOOiA6wxfDUaIG6aH+FkR8iNtqsKpSRCqcwnGlwCt1iy
        PmmHNhQg2HbozH8xV4PxXfVqjHtcpkmfGOExeH/uUGkf1XPT
X-Google-Smtp-Source: AMrXdXv0d6fzFKX45cQwh6OE6o1qey+JnXceCyN46tP5VM49eeZqwmP4btfYpBNWwpxlW6SfM5EAJrVlHX4Kd5Llj46mXnvxBkqc
MIME-Version: 1.0
X-Received: by 2002:a92:3643:0:b0:30b:e56f:f31d with SMTP id
 d3-20020a923643000000b0030be56ff31dmr375923ilf.81.1671790548561; Fri, 23 Dec
 2022 02:15:48 -0800 (PST)
Date:   Fri, 23 Dec 2022 02:15:48 -0800
In-Reply-To: <0000000000001bebd305ee5cd30e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c937f205f07c1100@google.com>
Subject: Re: [syzbot] [xfs?] WARNING in xfs_bmapi_convert_delalloc
From:   syzbot <syzbot+53b443b5c64221ee8bad@syzkaller.appspotmail.com>
To:     chandan.babu@oracle.com, dchinner@redhat.com, djwong@kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
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

HEAD commit:    a5541c0811a0 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=13463cac480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbd4e584773e9397
dashboard link: https://syzkaller.appspot.com/bug?extid=53b443b5c64221ee8bad
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=169c10dd880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=133e74ff880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4b7702208fb9/disk-a5541c08.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ec0153ec051/vmlinux-a5541c08.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6f8725ad290a/Image-a5541c08.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/409d4f1e085d/mount_1.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+53b443b5c64221ee8bad@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 9 at fs/xfs/libxfs/xfs_bmap.c:4592 xfs_bmapi_convert_delalloc+0x624/0x63c fs/xfs/libxfs/xfs_bmap.c:4592
Modules linked in:
CPU: 1 PID: 9 Comm: kworker/u4:0 Not tainted 6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: writeback wb_workfn (flush-7:0)
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : xfs_bmapi_convert_delalloc+0x624/0x63c fs/xfs/libxfs/xfs_bmap.c:4592
lr : xfs_bmapi_convert_delalloc+0x624/0x63c fs/xfs/libxfs/xfs_bmap.c:4592
sp : ffff80000f2a3450
x29: ffff80000f2a3530 x28: 0000000000000000 x27: 0000000000000000
x26: ffff80000f2a34a0 x25: ffffffffffffffff x24: ffff0000cb842000
x23: ffff0000cadcba40 x22: ffff80000f2a3898 x21: ffff0000c79800e8
x20: 0000000000000000 x19: ffff0000cadcba00 x18: 00000000000003cc
x17: 0000000000000000 x16: ffff80000dbe6158 x15: ffff0000c02c8000
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c02c8000
x11: ff80800008dd39a8 x10: 0000000000000000 x9 : ffff800008dd39a8
x8 : ffff0000c02c8000 x7 : ffff800008dacf34 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff800008db1b34
x2 : 0000000000000009 x1 : ffffffffffffffff x0 : ffffffffffffffff
Call trace:
 xfs_bmapi_convert_delalloc+0x624/0x63c fs/xfs/libxfs/xfs_bmap.c:4592
 xfs_convert_blocks fs/xfs/xfs_aops.c:259 [inline]
 xfs_map_blocks+0x428/0x5b8 fs/xfs/xfs_aops.c:380
 iomap_writepage_map+0x190/0x8cc fs/iomap/buffered-io.c:1360
 iomap_do_writepage+0x1c0/0x560 fs/iomap/buffered-io.c:1523
 write_cache_pages+0x35c/0x8bc mm/page-writeback.c:2360
 iomap_writepages+0x44/0xec fs/iomap/buffered-io.c:1540
 xfs_vm_writepages+0x94/0xd4 fs/xfs/xfs_aops.c:500
 do_writepages+0x144/0x27c mm/page-writeback.c:2469
 __writeback_single_inode+0x64/0x2e4 fs/fs-writeback.c:1587
 writeback_sb_inodes+0x3e4/0x85c fs/fs-writeback.c:1878
 __writeback_inodes_wb+0x78/0x1c0 fs/fs-writeback.c:1949
 wb_writeback+0x1c8/0x328 fs/fs-writeback.c:2054
 wb_check_background_flush fs/fs-writeback.c:2120 [inline]
 wb_do_writeback+0x2cc/0x384 fs/fs-writeback.c:2208
 wb_workfn+0x70/0x15c fs/fs-writeback.c:2235
 process_one_work+0x2d8/0x504 kernel/workqueue.c:2289
 worker_thread+0x340/0x610 kernel/workqueue.c:2436
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:863
irq event stamp: 2056580
hardirqs last  enabled at (2056579): [<ffff80000990e950>] get_random_u32+0x20c/0x294 drivers/char/random.c:510
hardirqs last disabled at (2056580): [<ffff80000c084084>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:405
softirqs last  enabled at (2050472): [<ffff8000080102e4>] _stext+0x2e4/0x37c
softirqs last disabled at (2050435): [<ffff800008017c88>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:80
---[ end trace 0000000000000000 ]---
XFS (loop0): page discard on page 000000006c24b16e, inode 0x50b, pos 13840384.
XFS (loop0): page discard on page 00000000c29caf09, inode 0x50b, pos 13844480.

