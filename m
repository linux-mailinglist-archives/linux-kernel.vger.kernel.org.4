Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F2D6A2282
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 20:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjBXTs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 14:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBXTst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 14:48:49 -0500
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E2E6C1A2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 11:48:42 -0800 (PST)
Received: by mail-il1-f205.google.com with SMTP id 2-20020a056e020ca200b003033a763270so331559ilg.19
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 11:48:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tj+YS6uDs/mw0VPIHBjLq++zoYCo86wH+DUsbWOpxBc=;
        b=dPl69OHE3a0SbBN0jpBKPHBrqB/BshNNCkUClLU1A+ZX2xS39nBq8mVJxeLACQN4cp
         yQxg3DIiYn04KpCs0TL4khGy/1mdNxtL+q12VjOJ8HqMY4LIOeFMItEIcUo1M4FETmLv
         msefw8qCMf6isf03+LeAV/hG4shpJIKxQbl3xs2G8suBK+9Wl3SY8u7b1sEydZ+CUogR
         nNaklGHsYb03LfhhDWJT3ZDpN6WIyuclsXT8et7PftTCHbtZ0fmW9UT2FFCaGz9LvLwI
         suKwzcohOlO9qoKauXSWqKb/tQIQYHX1Bx0l+ZcniAmygQz7N6AEmvvvF57gKeSMj+43
         y0Mg==
X-Gm-Message-State: AO0yUKVzYdcvVVWweTvvf4yg7GWvkCDFrdnp0GlA/NpXzMYdiytBbqWG
        eGfP9X+ZpvF4DzDrjtpeanG6QB8KDAgquliu+oOHx456POOb
X-Google-Smtp-Source: AK7set/lpdFhGHQw+cB9TUuzNn6N5waM1hr7VkUEtxTEE0QTJPim2M8myplppztA1iU387qG7HTmvXxzDqkXjrCs8qG48TKcd7Xc
MIME-Version: 1.0
X-Received: by 2002:a02:a1c7:0:b0:3e5:a7d9:27db with SMTP id
 o7-20020a02a1c7000000b003e5a7d927dbmr3101248jah.6.1677268122191; Fri, 24 Feb
 2023 11:48:42 -0800 (PST)
Date:   Fri, 24 Feb 2023 11:48:42 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009dcd7705f5776af6@google.com>
Subject: [syzbot] [ext4?] UBSAN: shift-out-of-bounds in ext2_fill_super
From:   syzbot <syzbot+4fec412f59eba8c01b77@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
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

HEAD commit:    a9b06ec42c0f Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1646c5e8c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8ad40c5d31656db1
dashboard link: https://syzkaller.appspot.com/bug?extid=4fec412f59eba8c01b77
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172f9f58c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13607dcf480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3fd9d14dbef6/disk-a9b06ec4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d4fd6fe60f78/vmlinux-a9b06ec4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/908925a4e5fc/Image-a9b06ec4.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/322d1cd45d78/mount_1.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4fec412f59eba8c01b77@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 512
================================================================================
UBSAN: shift-out-of-bounds in fs/ext2/super.c:948:25
shift exponent 32 is too large for 32-bit type 'int'
CPU: 1 PID: 5922 Comm: syz-executor396 Not tainted 6.2.0-syzkaller-18295-ga9b06ec42c0f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
Call trace:
 dump_backtrace+0x1c8/0x1f4 arch/arm64/kernel/stacktrace.c:158
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:165
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 dump_stack+0x1c/0x28 lib/dump_stack.c:113
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_shift_out_of_bounds+0x2f4/0x36c lib/ubsan.c:321
 ext2_fill_super+0x2074/0x23fc fs/ext2/super.c:948
 mount_bdev+0x26c/0x368 fs/super.c:1359
 ext2_mount+0x44/0x58 fs/ext2/super.c:1484
 legacy_get_tree+0xd4/0x16c fs/fs_context.c:610
 vfs_get_tree+0x90/0x274 fs/super.c:1489
 do_new_mount+0x25c/0x8c8 fs/namespace.c:3145
 path_mount+0x590/0xe58 fs/namespace.c:3475
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount fs/namespace.c:3674 [inline]
 __arm64_sys_mount+0x45c/0x594 fs/namespace.c:3674
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
 el0_svc+0x58/0x168 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
================================================================================
EXT2-fs (loop0): error: fragsize 4096 != blocksize 1024(not supported yet)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
