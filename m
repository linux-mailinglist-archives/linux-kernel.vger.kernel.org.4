Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D379653405
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 17:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbiLUQar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 11:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234585AbiLUQao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 11:30:44 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276D8DD8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 08:30:40 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id o10-20020a056e02102a00b003006328df7bso10328274ilj.17
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 08:30:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=38s+FDuC5HXlHwiOQdoCODf9vsCmm6rGh3dwVv9b0Co=;
        b=VBG2n+G4J55jvYq14Or9F0LYkV1A1iLTAzJGvAB2OZsieozsDD/i29W9pcFhCq15Qm
         hjKCVOJu9s+9toDdViWqScnEg4ZuM32ORHvk0SunGMa3khhldortWbF8yUtnEA94VL+K
         x81eJuWxJG5nNgn9fatbq+2rtKjV6V8J4ZUGbZWMggbYnmvOn8fjj40Ss25+jfV3BH32
         sN+VpECXQ9kgJr+fWAz/wzv4Sx9NQ7qssFY151IBXFKZSOiRhuO4Ek9gCJ3qvxaoHnn1
         Tp+6UhqFrDEsuEMYyyQKxaH7ZWeaBK/3ykTd7qSq7w6QMfeYOCEM0N/ESN505X+n6KRT
         fNvA==
X-Gm-Message-State: AFqh2ko6DlfkDDVQQzlYEQ78FABLZcGxfbm6LFMtT/KaWpvFAFe58+/U
        BYN12Xd7JWqe9FQ9CqhrxTbKi8/YGR5KZsIfb+H6fEiIpTff
X-Google-Smtp-Source: AMrXdXtaDqqxOJL6ehHi+/tRYsYLPY8Qwu3qEAVu0fk7EV7yQiqD00F1uMcVV57q8GSKVyqWEaCL1LwOPCGtY4s2Gg2QNGtyskhG
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2a8:b0:38a:3f3e:68a3 with SMTP id
 d8-20020a05663802a800b0038a3f3e68a3mr185604jaq.170.1671640240337; Wed, 21 Dec
 2022 08:30:40 -0800 (PST)
Date:   Wed, 21 Dec 2022 08:30:40 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b7bd0405f059129a@google.com>
Subject: [syzbot] [ntfs3?] kernel panic: stack is corrupted in return_address
From:   syzbot <syzbot+dbc07204c42818c9d070@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com, broonie@kernel.org,
        catalin.marinas@arm.com, kaleshsingh@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        madvenka@linux.microsoft.com, mark.rutland@arm.com, maz@kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        will@kernel.org
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

HEAD commit:    a5541c0811a0 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=14d4b79d880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbd4e584773e9397
dashboard link: https://syzkaller.appspot.com/bug?extid=dbc07204c42818c9d070
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1130fd00480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1189b3d7880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4b7702208fb9/disk-a5541c08.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ec0153ec051/vmlinux-a5541c08.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6f8725ad290a/Image-a5541c08.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/334dbd02e297/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dbc07204c42818c9d070@syzkaller.appspotmail.com

loop2: detected capacity change from 0 to 15197
ntfs3: loop2: Different NTFS' sector size (1024) and media sector size (512)
Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: return_address+0x94/0x94
CPU: 1 PID: 7954 Comm: syz-executor564 Not tainted 6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 panic+0x218/0x508 kernel/panic.c:274
 warn_bogus_irq_restore+0x0/0x40 kernel/panic.c:703
 save_return_addr+0x0/0x68
SMP: stopping secondary CPUs
Kernel Offset: disabled
CPU features: 0x00000,040e0108,4c017203
Memory Limit: none
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
