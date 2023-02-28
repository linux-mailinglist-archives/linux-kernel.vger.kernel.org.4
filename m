Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3E06A5AB4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 15:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjB1OTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 09:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjB1OTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 09:19:49 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F54241EC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 06:19:47 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id q7-20020a92d407000000b00316e14800eeso5931820ilm.20
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 06:19:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J6I9nx2s7RTfWTlnagZt92XwoQkoLlEorV5GfVg0HLE=;
        b=EIrvDei+g7wNgKkv2TPNseZI0+o25Bw6K+SvQtExCD38iGT9mq3gtHIfjCZvjOkq7r
         34gbZaHsZAWiCXRp8UlqqVmyema1QFjyCRM9a1DxOUM7ihUzu6FqEQtKGxKPfjfX3wHi
         qj18/JwGM/MRMNu7ZLvoYXpUHedqz4nsQtT1RDkfrZ7qPqNXR3SuWnSmbe1ppOnKaRfX
         BZD7So23fRdkPN9o81nq1lfyASx6A/0Mpjsi1p6aDpqoXCOPclEcVVt+VQzqIBURVerm
         fQYlV5gy/drMEpYJbVslIKVO6uryrNgua6ouj8Nd/PPjYvtlpMyTy3Zwl/zTLQdy4HaT
         3vEg==
X-Gm-Message-State: AO0yUKVmLYClBqAyDG8dNGis/QX+RhcC0ZVjeDUauFQnHB7OJu8tna5h
        7by8ZHFPgfflg7Ah2oS03gJK0yHOwWWifwbu/xIBhmq2Fxf0
X-Google-Smtp-Source: AK7set80BgvGPfY0VZVc50EMjNfjx1r+lpseH5pu22IzNmUTBUhber0fCBuJJHCdpw2t1xFRIPl0wI8XeLnKny7oPSOmITR6cbg3
MIME-Version: 1.0
X-Received: by 2002:a02:6244:0:b0:3ad:65e:e489 with SMTP id
 d65-20020a026244000000b003ad065ee489mr1374385jac.1.1677593986353; Tue, 28 Feb
 2023 06:19:46 -0800 (PST)
Date:   Tue, 28 Feb 2023 06:19:46 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a24e7405f5c34912@google.com>
Subject: [syzbot] [ntfs3?] UBSAN: shift-out-of-bounds in ntfs_fill_super (2)
From:   syzbot <syzbot+478c1bf0e6bf4a8f3a04@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
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

HEAD commit:    2ebd1fbb946d Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=17f0d518c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3519974f3f27816d
dashboard link: https://syzkaller.appspot.com/bug?extid=478c1bf0e6bf4a8f3a04
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=165b7474c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c9de8cc80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/16985cc7a274/disk-2ebd1fbb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fd3452567115/vmlinux-2ebd1fbb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c75510922212/Image-2ebd1fbb.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/deffedf88bc5/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+478c1bf0e6bf4a8f3a04@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 4096
================================================================================
UBSAN: shift-out-of-bounds in fs/ntfs3/super.c:777:25
shift exponent 128 is too large for 32-bit type 'unsigned int'
CPU: 0 PID: 5928 Comm: syz-executor258 Not tainted 6.2.0-syzkaller-18300-g2ebd1fbb946d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
Call trace:
 dump_backtrace+0x1c8/0x1f4 arch/arm64/kernel/stacktrace.c:158
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:165
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 dump_stack+0x1c/0x28 lib/dump_stack.c:113
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_shift_out_of_bounds+0x2f4/0x36c lib/ubsan.c:321
 ntfs_init_from_boot fs/ntfs3/super.c:777 [inline]
 ntfs_fill_super+0x2544/0x3b9c fs/ntfs3/super.c:970
 get_tree_bdev+0x360/0x54c fs/super.c:1282
 ntfs_fs_get_tree+0x28/0x38 fs/ntfs3/super.c:1408
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


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
