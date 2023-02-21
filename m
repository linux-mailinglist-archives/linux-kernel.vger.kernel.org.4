Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F2C69E4B6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 17:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbjBUQdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 11:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbjBUQdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 11:33:51 -0500
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9F413D4A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 08:33:49 -0800 (PST)
Received: by mail-io1-f77.google.com with SMTP id z14-20020a05660200ce00b0073deb4b4272so2775131ioe.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 08:33:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oOhjUoQnskTkMpqfJaB/JbTGXYNinWurKj0BmzQc7Lg=;
        b=KiZa5yPBWWT4f/UyuEhz47PIisXJcqNq5TLFtyiCfHD7ysTE4zMoimGUPDOEJv+iHe
         n83MUIeqZABHBXIxEQGicF/wXCcijCDTDNoe/o+Q8VYBZ9XXIr9TxQdjOYFmp0szVK4f
         mX39XbUOuIIlL+AppS4rXd8xLzkAru0C446jO93nYp9d6cS6sgl14ZTHzONmKK1wkiik
         D4X2VvibXQnkFIKt133NZldfb7woLpvGgk+K2oJWMl7Mm4cBOQQbeD1JSCQjsXd9bRWp
         QD1fnvieZ+liVDCvcXYtlak3wdhTf3CaiHTNyVotDOl6md9HetNDayf2qFyxO3ZnGPju
         wpFQ==
X-Gm-Message-State: AO0yUKWRQ4XOk2qvK49pYVVAS18hOUjwrETmN2Is/i+8tP/15MmpNQjJ
        7ISsEIMak4ZWKQwD90kQM1DzQgfdXx+vudTGLNs0lI/8yWBX
X-Google-Smtp-Source: AK7set/PmndAY7N0ZzuZ+dYr5XjX7uymv3DMFsjWh1nTxgmR9l+EOwIp3PofBP7+WrQES5vr8ou/d7+MyZak1XoQdZlz4NHe81ac
MIME-Version: 1.0
X-Received: by 2002:a6b:7e48:0:b0:73e:13d6:2552 with SMTP id
 k8-20020a6b7e48000000b0073e13d62552mr3432769ioq.70.1676997228951; Tue, 21 Feb
 2023 08:33:48 -0800 (PST)
Date:   Tue, 21 Feb 2023 08:33:48 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001efd4205f53858e1@google.com>
Subject: [syzbot] [hardening?] [mm?] BUG: bad usercopy in io_openat2_prep (3)
From:   syzbot <syzbot+e443ef743ffab8e8bda9@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    2d3827b3f393 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=14eb5abf480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=606ed7eeab569393
dashboard link: https://syzkaller.appspot.com/bug?extid=e443ef743ffab8e8bda9
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13088227480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1367b358c80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fd94d68ff17d/disk-2d3827b3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f304fbef0773/vmlinux-2d3827b3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/74eb318f51b0/Image-2d3827b3.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e443ef743ffab8e8bda9@syzkaller.appspotmail.com

usercopy: Kernel memory overwrite attempt detected to SLUB object 'pid' (offset 24, size 24)!
------------[ cut here ]------------
kernel BUG at mm/usercopy.c:102!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 4410 Comm: syz-executor832 Not tainted 6.2.0-rc7-syzkaller-17907-g2d3827b3f393 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : usercopy_abort+0x90/0x94 mm/usercopy.c:90
lr : usercopy_abort+0x90/0x94 mm/usercopy.c:90
sp : ffff800012ee3b90
x29: ffff800012ee3ba0 x28: 000000000000001c x27: ffff0000c72f8000
x26: 0000000020000000 x25: ffff80000cf52000 x24: fffffc0000000000
x23: 05ffc00000000200 x22: fffffc00030cbe40 x21: ffff0000c32f9f18
x20: 0000000000000000 x19: 0000000000000018 x18: 0000000000002bce
x17: 63656a626f204255 x16: ffff0000c72f89f8 x15: ffff80000dbd2118
x14: ffff0000c72f8000 x13: 00000000ffffffff x12: ffff0000c72f8000
x11: ff808000081bbb4c x10: 0000000000000000 x9 : adc5950f6e29d600
x8 : adc5950f6e29d600 x7 : ffff80000bf650d4 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff0001fefbff08 x1 : 0000000100000000 x0 : 000000000000005d
Call trace:
 usercopy_abort+0x90/0x94 mm/usercopy.c:90
 __check_heap_object+0xa8/0x100 mm/slub.c:4761
 check_heap_object mm/usercopy.c:196 [inline]
 __check_object_size+0x208/0x6b8 mm/usercopy.c:251
 check_object_size include/linux/thread_info.h:199 [inline]
 check_copy_size include/linux/thread_info.h:235 [inline]
 copy_from_user include/linux/uaccess.h:160 [inline]
 copy_struct_from_user include/linux/uaccess.h:341 [inline]
 io_openat2_prep+0xcc/0x2b8 io_uring/openclose.c:89
 io_init_req io_uring/io_uring.c:2194 [inline]
 io_submit_sqe io_uring/io_uring.c:2241 [inline]
 io_submit_sqes+0x338/0xbb8 io_uring/io_uring.c:2395
 __do_sys_io_uring_enter io_uring/io_uring.c:3343 [inline]
 __se_sys_io_uring_enter io_uring/io_uring.c:3275 [inline]
 __arm64_sys_io_uring_enter+0x168/0x1308 io_uring/io_uring.c:3275
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x64/0x178 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0xbc/0x180 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x110 arch/arm64/kernel/syscall.c:193
 el0_svc+0x58/0x14c arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
Code: 91388800 aa0903e1 f90003e8 94e6d752 (d4210000) 
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
