Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED050652C26
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 05:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbiLUEqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 23:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiLUEqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 23:46:43 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0466175
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 20:46:42 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id x10-20020a056e021bca00b00302b6c0a683so9617417ilv.23
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 20:46:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QioZXgsgOHKc6H8mnlnH5lizZt9Vqo4TbSBYHXXyix4=;
        b=kkw8qxHsEFWCm+9aUFYW9fD+FVcUjfK8HKs/Z8NxdF2Fr97xYP0CjtFF+dLJW6dA9c
         kcxVkKZs0PGjxiS7PcdZOvqfTn4zRqlzC+mmBYxPJeHmz3FS6YOVuZ+I9hfvAev5xYCo
         y/O6ziyb3UzXdBXQQPK1BPSJPyZqhMpFrNlTMYccZL4NGRQurB3aeyl9vCWRqCcBFyZc
         eaIhOspdg9OL/HxP4+CxLq2gTH0IMXmKMf8y0CoCJJ2CmGXExPtLnbcla9GLBk2iglys
         /ZQRqz/XnyG88dnzzIaY29M3Xu4sSz1rNWHUPRWvH79+dD09RvBIdomaIxIFMs0o8dBa
         HCwQ==
X-Gm-Message-State: AFqh2kproWHfkY34P1jgY/Yrh5ElN/YU46/7TOpiwhIhEslbBwYrJeC6
        XHe694PlqvQarfO5HGzEYACI95MvRCqxmpn1eWYzrqmWkCU8
X-Google-Smtp-Source: AMrXdXsY2Bo3B6QIHJigeUIYqHiuZ+rSKfAQCMpP4UVtdKJzuzus+NY4p++NnLXYNq7pFRz9GwZfV6j/EcGKAdxTNzE5zlEpEMU/
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3465:b0:38a:66d5:f599 with SMTP id
 q37-20020a056638346500b0038a66d5f599mr13915jav.274.1671598001823; Tue, 20 Dec
 2022 20:46:41 -0800 (PST)
Date:   Tue, 20 Dec 2022 20:46:41 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001b2b2e05f04f3ddb@google.com>
Subject: [syzbot] memory leak in prctl
From:   syzbot <syzbot+91edf9178386a07d06a7@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, brauner@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
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
console output: https://syzkaller.appspot.com/x/log.txt?x=17f28cbb880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6b1ea4fdbd78230a
dashboard link: https://syzkaller.appspot.com/bug?extid=91edf9178386a07d06a7
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=153ff26f880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1073a993880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/93698bc86a1d/disk-77856d91.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6190640893ad/vmlinux-77856d91.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ddf790b00ced/bzImage-77856d91.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+91edf9178386a07d06a7@syzkaller.appspotmail.com

Warning: Permanently added '10.128.0.165' (ECDSA) to the list of known hosts.
executing program
BUG: memory leak
unreferenced object 0xffff88810c4c57a0 (size 32):
  comm "syz-executor948", pid 5064, jiffies 4294946184 (age 7.250s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814f8d16>] __do_kmalloc_node mm/slab_common.c:967 [inline]
    [<ffffffff814f8d16>] __kmalloc+0x46/0x120 mm/slab_common.c:981
    [<ffffffff81564fb7>] kmalloc include/linux/slab.h:584 [inline]
    [<ffffffff81564fb7>] anon_vma_name_alloc+0x27/0x60 mm/madvise.c:78
    [<ffffffff8128d4df>] prctl_set_vma kernel/sys.c:2324 [inline]
    [<ffffffff8128d4df>] __do_sys_prctl+0xaff/0xba0 kernel/sys.c:2627
    [<ffffffff848a05d5>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff848a05d5>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84a00087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
