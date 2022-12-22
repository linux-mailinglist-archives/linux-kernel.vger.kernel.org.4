Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F2F653A2B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 01:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbiLVApz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 19:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiLVApy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 19:45:54 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B883F314
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 16:45:52 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id i21-20020a056e021d1500b003041b04e3ebso260283ila.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 16:45:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zYUhkFKvY5IbV4RqNVKD9rJbddGx3SRJptJw8BeSSvY=;
        b=S9M9SrYVigIVbayAAayr/FdM/Kz/hVCrD0L5/ETe4XKfmzEYMuRiD+9YiHKkw7B32v
         eI+7Xe9E7mLFBIprabmkstw2mCBT2KJMZ/vc/ZWLeGKwLEo0FjsbOnX6zypbGReVMZ8W
         jGeqUCU00rSnChpW2lX4d0Z3oMaVmWc1xEYsGgCHGwWE1KP4/Wh53ZmHpHcDsaDIVJNg
         MVwniA0o7zLbGTE1zySHX0WWTms6Mce/IcO5pJQKMWWzEySlvHS7EfpMeSPgNbCXx3Nx
         wA5a30KoJGSzBRoJjYJCuBNghqVI5QRZTVDt6GmAW0I0hicSerIjvuQrbt7umzOMNItX
         x0Vg==
X-Gm-Message-State: AFqh2kr1TXP2x9N/ObxVjKkQY12EsZu8T++5APG0lTann25KXhG2fGjX
        S8qSxOfkHAmzgO0Qx3cLXyOk4+OA0M48uXVRUSDshK+7p8/D
X-Google-Smtp-Source: AMrXdXsxMjUq/nIPr6Kdbmfdbfw8EXz556sp/PvVb3oBo6kHw9mYz8aYi6PUQN3iPIbvpYpSIidIYBKNjK0PiuA/9K1pP2LmxPk+
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d86:b0:304:c71d:8e03 with SMTP id
 h6-20020a056e021d8600b00304c71d8e03mr378450ila.274.1671669952042; Wed, 21 Dec
 2022 16:45:52 -0800 (PST)
Date:   Wed, 21 Dec 2022 16:45:52 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ac5f1705f05ffd3b@google.com>
Subject: [syzbot] [gfs2?] UBSAN: array-index-out-of-bounds in __gfs2_iomap_get
From:   syzbot <syzbot+45d4691b1ed3c48eba05@syzkaller.appspotmail.com>
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

Hello,

syzbot found the following issue on:

HEAD commit:    77856d911a8c Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=155a6663880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f967143badd2fa39
dashboard link: https://syzkaller.appspot.com/bug?extid=45d4691b1ed3c48eba05
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=160f494f880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=123f9577880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4b424d9203f5/disk-77856d91.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/47fd68051834/vmlinux-77856d91.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d3091f087a86/bzImage-77856d91.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/67525acd7f1d/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+45d4691b1ed3c48eba05@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 125323
gfs2: fsid=syz:syz: Trying to join cluster "lock_nolock", "syz:syz"
gfs2: fsid=syz:syz: Now mounting FS (format 1801)...
================================================================================
UBSAN: array-index-out-of-bounds in fs/gfs2/bmap.c:901:46
index 11 is out of range for type 'u64 [11]'
CPU: 0 PID: 5067 Comm: syz-executor164 Not tainted 6.1.0-syzkaller-13031-g77856d911a8c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_out_of_bounds+0xe0/0x110 lib/ubsan.c:282
 __gfs2_iomap_get+0x4a4/0x16e0 fs/gfs2/bmap.c:901
 gfs2_iomap_get fs/gfs2/bmap.c:1399 [inline]
 gfs2_block_map+0x28f/0x7f0 fs/gfs2/bmap.c:1214
 gfs2_write_alloc_required+0x441/0x6e0 fs/gfs2/bmap.c:2322
 gfs2_jdesc_check+0x1b9/0x290 fs/gfs2/super.c:114
 init_journal+0x5a4/0x22c0 fs/gfs2/ops_fstype.c:804
 init_inodes+0xdc/0x340 fs/gfs2/ops_fstype.c:889
 gfs2_fill_super+0x1bb2/0x2700 fs/gfs2/ops_fstype.c:1247
 get_tree_bdev+0x400/0x620 fs/super.c:1282
 gfs2_get_tree+0x50/0x210 fs/gfs2/ops_fstype.c:1330
 vfs_get_tree+0x88/0x270 fs/super.c:1489
 do_new_mount+0x289/0xad0 fs/namespace.c:3145
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3674
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f2c63567aca
Code: 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd0e3a28d8 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f2c63567aca
RDX: 0000000020037f40 RSI: 0000000020037f80 RDI: 00007ffd0e3a28e0
RBP: 00007ffd0e3a28e0 R08: 00007ffd0e3a2920 R09: 0000000000043350
R10: 0000000002000011 R11: 0000000000000282 R12: 0000000000000004
R13: 00005555567192c0 R14: 00007ffd0e3a2920 R15: 0000000000000000
 </TASK>
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
