Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1169F660CE6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 09:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjAGIEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 03:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjAGIEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 03:04:49 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F32848E1
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 00:04:47 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id y5-20020a056e021be500b0030bc4f23f0aso2483605ilv.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 00:04:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ORK3h6FSW+2B+RhDOw+LxFiKc6vxzMBG6vWzfQ9cyq0=;
        b=qlaXgn45SscOFcogdA5rBnZDGNBmcmZmIeRwwqi/OtJvxs+qX3lIWbOI9D6KV27T9V
         jJyuGMqa1S1nQtxmGCTJsj2n3/+HWlqYn/FICXPpHYkz+QxmBPElpiIu2iaC9yjvibmv
         B5B9MUwhs8O0STO0kXJFHvkBwCqSGOhgA10KXst6uucIVRyPi8eaHu92ba+y69lpMotX
         FnnwtvOfi/KA2l0Vh5N9/jQeaOC4SxmsVATmjJpG2IQMX2ILmfhq8bKGg3xk3J6s1x0W
         uxtLSp/BePc5in1RY6YBkclEsTfchhdkwDRpNt+TeM2JGs1TTuUJyCoFXYHSx21lM+cz
         Dutw==
X-Gm-Message-State: AFqh2kqDySuU+039nyatQ6W+H556OXEjEl4fhNlzuWwLAcVdCzg5O37Q
        vhl9QnX18sW2Q3zfAbBZQ3sR+7CvcukQhi+/xW9LQZqhYMUK
X-Google-Smtp-Source: AMrXdXuhpT4sEifvTQf63Kq6VsZHZhzDxGON4d1gA2aXKigyepDf7s1mx2zlNq3FRZpFeXMlcNLZZLBCDi5ul0st00ACCx5Xnj9U
MIME-Version: 1.0
X-Received: by 2002:a05:6638:41a3:b0:38a:7676:20ce with SMTP id
 az35-20020a05663841a300b0038a767620cemr5993354jab.34.1673078685691; Sat, 07
 Jan 2023 00:04:45 -0800 (PST)
Date:   Sat, 07 Jan 2023 00:04:45 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bdf37505f1a7fc09@google.com>
Subject: [syzbot] [ntfs3?] kernel panic: stack is corrupted in run_unpack_ex
From:   syzbot <syzbot+ba698041fcdf4d0214bb@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
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

HEAD commit:    41c03ba9beea Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10ff69e6480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8cdb1e7bec4b955a
dashboard link: https://syzkaller.appspot.com/bug?extid=ba698041fcdf4d0214bb
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11e43f56480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13fbabea480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0785c850df02/disk-41c03ba9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/39c091ba7dd7/vmlinux-41c03ba9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7f0500283e44/bzImage-41c03ba9.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/3c177fdde72f/mount_0.gz

The issue was bisected to:

commit ad26a9c84510af7252e582e811de970433a9758f
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Fri Oct 7 17:08:06 2022 +0000

    fs/ntfs3: Fixing wrong logic in attr_set_size and ntfs_fallocate

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1631559a480000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1531559a480000
console output: https://syzkaller.appspot.com/x/log.txt?x=1131559a480000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ba698041fcdf4d0214bb@syzkaller.appspotmail.com
Fixes: ad26a9c84510 ("fs/ntfs3: Fixing wrong logic in attr_set_size and ntfs_fallocate")

ntfs3: loop0: Different NTFS' sector size (4096) and media sector size (512)
Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: run_unpack_ex+0x803/0x810
CPU: 1 PID: 5145 Comm: syz-executor322 Not tainted 6.2.0-rc2-syzkaller-00057-g41c03ba9beea #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e3/0x2d0 lib/dump_stack.c:106
 panic+0x316/0x770 kernel/panic.c:318
 __stack_chk_fail+0x12/0x20 kernel/panic.c:746
 run_unpack_ex+0x803/0x810
 attr_load_runs fs/ntfs3/attrib.c:81 [inline]
 attr_set_size+0x1022/0x4110 fs/ntfs3/attrib.c:500
 ntfs_set_size+0x17d/0x210 fs/ntfs3/inode.c:823
 ntfs_extend+0x169/0x4b0 fs/ntfs3/file.c:337
 ntfs_file_write_iter+0x301/0x6c0 fs/ntfs3/file.c:1064
 do_iter_write+0x6f0/0xc50 fs/read_write.c:861
 iter_file_splice_write+0x830/0xff0 fs/splice.c:686
 do_splice_from fs/splice.c:764 [inline]
 direct_splice_actor+0xe6/0x1c0 fs/splice.c:931
 splice_direct_to_actor+0x4e4/0xc00 fs/splice.c:886
 do_splice_direct+0x2a0/0x3f0 fs/splice.c:974
 do_sendfile+0x641/0xfd0 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 __se_sys_sendfile64+0x178/0x1e0 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f2d28b0b249
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 01 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff179130d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 000000000001a41e RCX: 00007f2d28b0b249
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000004
RBP: 0000000000000000 R08: 00007fff17913140 R09: 00007fff17913140
R10: 00008400fffffffa R11: 0000000000000246 R12: 00007fff1791310c
R13: 00007fff17913140 R14: 00007fff17913120 R15: 000000000000004e
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
