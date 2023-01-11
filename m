Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEF4665942
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238469AbjAKKo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238971AbjAKKom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:44:42 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24E6FAD4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 02:44:41 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id l13-20020a056e021c0d00b003034e24b866so10773014ilh.22
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 02:44:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H2Ayw1bsGiFgdFPb1128NomGa1sqMbRpiQx895zpxWM=;
        b=V9/FBhPaOctkKm5yRzH9OwmW39LAfA3wcEDy70szkkVGVg/eQf4ZfUyoRLm1FGumeY
         T0KWRKtdMF/pwB/N5YKpH061jp2g51+/KlbhfzL7WFWBi/lWE+NbUgeyp6iYpkOYZ+vH
         sKf2BKvtE4+daH8rvjbsbP+YipT9MAxCiVpXOW3qDOMu78PxWNbkPwgnoXUCDz+yDKgS
         bzk4lHlXCKb34fVuIF93Wc5P9wmqdl0cVYOl+7997cKhkv507CO1kbEdyOBJbm41j1H2
         kc8efLVYqV4ejrm9HPImCV9MIRPCrl6HzV5yqUJfQNpO2VFketVKqaiPwOqpIYzekk2N
         j9sg==
X-Gm-Message-State: AFqh2krmDuh+7NsP12Shfs2VH+SqmHjq5uG/FQS5BaPOzNKl88YEd7OT
        gdATR0rwlWQevM+nHQPI4qT800v8ZKztvdC8iO82ymSxP2aV
X-Google-Smtp-Source: AMrXdXthjx2BqnHb2iEHdPdBLNx4HN/OV+63PADnz+/g6wr3Fa1wUTAmrMvQ8zpFqyWNdkf1arAUDzENZpjo11AhpX0tQ1YeUBcH
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3d04:b0:38a:5b87:24e2 with SMTP id
 cl4-20020a0566383d0400b0038a5b8724e2mr4086589jab.159.1673433881057; Wed, 11
 Jan 2023 02:44:41 -0800 (PST)
Date:   Wed, 11 Jan 2023 02:44:41 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000091dff05f1fab036@google.com>
Subject: [syzbot] [reiserfs?] memory leak in reiserfs_parse_options (2)
From:   syzbot <syzbot+67d4d8261283b46b21ac@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bvanassche@acm.org, jack@suse.cz,
        linux-kernel@vger.kernel.org, muchun.song@linux.dev,
        reiserfs-devel@vger.kernel.org, roman.gushchin@linux.dev,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu,
        yi.zhang@huawei.com, yijiangshan@kylinos.cn
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

syzbot found the following issue on:

HEAD commit:    a689b938df39 Merge tag 'block-2023-01-06' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14e229c2480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5ddca4921a53cff2
dashboard link: https://syzkaller.appspot.com/bug?extid=67d4d8261283b46b21ac
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15adc3fc480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=150b3bcc480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a368fc04c846/disk-a689b938.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b6771146e261/vmlinux-a689b938.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ac22fc91deb9/bzImage-a689b938.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/15583b49f0c4/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+67d4d8261283b46b21ac@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810f4f5600 (size 32):
  comm "syz-executor300", pid 5077, jiffies 4294958926 (age 8.040s)
  hex dump (first 32 bytes):
    73 79 7a 00 00 00 00 00 00 00 00 00 00 00 00 00  syz.............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814f9c67>] __do_kmalloc_node mm/slab_common.c:967 [inline]
    [<ffffffff814f9c67>] __kmalloc_node_track_caller+0x47/0x120 mm/slab_common.c:988
    [<ffffffff814e9feb>] kstrdup+0x3b/0x70 mm/util.c:61
    [<ffffffff8177b635>] reiserfs_parse_options+0xad5/0x1090 fs/reiserfs/super.c:1279
    [<ffffffff8177f73d>] reiserfs_fill_super+0x17d/0x15d0 fs/reiserfs/super.c:1933
    [<ffffffff8160f503>] mount_bdev+0x223/0x260 fs/super.c:1359
    [<ffffffff81673a1b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
    [<ffffffff8160d088>] vfs_get_tree+0x28/0x100 fs/super.c:1489
    [<ffffffff81650f27>] do_new_mount fs/namespace.c:3145 [inline]
    [<ffffffff81650f27>] path_mount+0xc37/0x10d0 fs/namespace.c:3475
    [<ffffffff81651b5e>] do_mount fs/namespace.c:3488 [inline]
    [<ffffffff81651b5e>] __do_sys_mount fs/namespace.c:3697 [inline]
    [<ffffffff81651b5e>] __se_sys_mount fs/namespace.c:3674 [inline]
    [<ffffffff81651b5e>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3674
    [<ffffffff848ef725>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff848ef725>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84a00087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
