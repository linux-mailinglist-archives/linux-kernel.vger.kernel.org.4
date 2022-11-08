Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E47620489
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 01:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbiKHAPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 19:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbiKHAPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 19:15:54 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75852240BD
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 16:15:53 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id h20-20020a056e021d9400b00300581edaa5so9986279ila.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 16:15:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kVNNuLLGgelV/9xzO4pFlRh5Pn9rCXjBZ2XsV4Ryk3I=;
        b=GPZlQf+SG9G/Vm6Tq5y81LGwVN2dC4IXz8T3A7TTZmafbMjStxihSngB6bPsWJD4SK
         OnlaFszVYCy57BTxHeJdvlFJm6ooEivkojcE623zTukKVnZ+VDfqmHVXR1q/G+xMoJGL
         vHHU4Z3IWp9QzUflBvzbE/wDUTQXCp627sk943r9KAVwE15m44PyjSwPG/RXxDY4ftfP
         JSuTRsz+DZssSntDp8AfXfETTU6S3XbxtOZpvgjTee0U8EEfz2mIDHXyjRRsAw5ZqQ8n
         EJSNNpVdyu1wfBaF6eOrrFzyQZX8uL/13uvwbgRYC0qreuVDvVYrRZ4Io6FWRCl3U8Pj
         mElw==
X-Gm-Message-State: ACrzQf0Cr8+xdeVVmkyfXKHCrsg/H4nFfH2e4yhZcA9kcNfr/oaSoxJa
        Uxk4K9a05Ht0/qXJmxJaBk/KqbOQ5FcFa0A+aSUl4JBdF7Tl
X-Google-Smtp-Source: AMsMyM6OKtM8oYKG9ke6xzQflEt4ODd1XHnCWjZXS34r+2HSVycQZAadI+H46F6ygEMqHaE7poT1gp/8+bppizoJYOLw6oPTneNV
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1bc4:b0:300:61e9:69af with SMTP id
 x4-20020a056e021bc400b0030061e969afmr30785458ilv.191.1667866552859; Mon, 07
 Nov 2022 16:15:52 -0800 (PST)
Date:   Mon, 07 Nov 2022 16:15:52 -0800
In-Reply-To: <0000000000007edb6605ecbb6442@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006a83e705ecea7171@google.com>
Subject: Re: [syzbot] INFO: trying to register non-static key in f2fs_handle_error
From:   syzbot <syzbot+40642be9b7e0bb28e0df@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        terrelln@fb.com
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

HEAD commit:    f0c4d9fc9cc9 Linux 6.1-rc4
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=15e494fe880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff27f0c8b406726e
dashboard link: https://syzkaller.appspot.com/bug?extid=40642be9b7e0bb28e0df
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10822271880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f4cd51880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/92c7e839ac32/disk-f0c4d9fc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b7bedbc08fb4/vmlinux-f0c4d9fc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3fe25e2dfdb7/Image-f0c4d9fc.gz.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/1f9d740f89a9/mount_1.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/6c6db4f39192/mount_2.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+40642be9b7e0bb28e0df@syzkaller.appspotmail.com

F2FS-fs (loop0): Invalid log_blocksize (16), supports only 12
F2FS-fs (loop0): Can't find valid F2FS filesystem in 1th superblock
F2FS-fs (loop0): inaccessible inode: 2, run fsck to repair
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 1 PID: 3141 Comm: syz-executor147 Not tainted 6.1.0-rc4-syzkaller-31833-gf0c4d9fc9cc9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x54 arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 assign_lock_key+0x134/0x140 kernel/locking/lockdep.c:981
 register_lock_class+0xc4/0x2f8 kernel/locking/lockdep.c:1294
 __lock_acquire+0xa8/0x3084 kernel/locking/lockdep.c:4934
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5668
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x54/0x6c kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:350 [inline]
 f2fs_save_errors fs/f2fs/super.c:3868 [inline]
 f2fs_handle_error+0x38/0x17c fs/f2fs/super.c:3896
 f2fs_iget+0x138/0x538 fs/f2fs/inode.c:516
 f2fs_fill_super+0x10fc/0x1e90 fs/f2fs/super.c:4222
 mount_bdev+0x1b8/0x210 fs/super.c:1401
 f2fs_mount+0x44/0x58 fs/f2fs/super.c:4580
 legacy_get_tree+0x30/0x74 fs/fs_context.c:610
 vfs_get_tree+0x40/0x140 fs/super.c:1531
 do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
 path_mount+0x358/0x890 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __arm64_sys_mount+0x2c4/0x3c4 fs/namespace.c:3568
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
F2FS-fs (loop0): Failed to read F2FS meta data inode
loop0: detected capacity change from 0 to 8192
REISERFS warning:  read_super_block: reiserfs filesystem is deprecated and scheduled to be removed from the kernel in 2025
REISERFS (device loop0): found reiserfs format "3.6" with non-standard journal
REISERFS (device loop0): using ordered data mode
reiserfs: using flush barriers
REISERFS (device loop0): journal params: device loop0, size 512, journal first block 18, max trans len 256, max batch 225, max commit age 30, max trans age 30
REISERFS (device loop0): checking transaction log (loop0)
REISERFS (device loop0): Using rupasov hash to sort names
REISERFS warning (device loop0): jdm-20006 create_privroot: xattrs/ACLs enabled and couldn't find/create .reiserfs_priv. Failing mount.

