Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C01653B82
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 06:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiLVFJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 00:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiLVFJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 00:09:42 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058F21658A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 21:09:40 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id z9-20020a6be009000000b006e0577c3686so368959iog.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 21:09:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xoLTaF7bFz05baIcH7CpiltlzNkXu6Pa2DUroFSRlgg=;
        b=5MrQRcYgoWXhE6/jarMLvR2Ods3ma9Rvlf8o0FPyIIBGarwoZn0blbjwuLHUreg10d
         GU0liAkFy0hY20FIhL5Qz39yotRunK1QTgLQFBUPdlVQGDkQNoL6pOlyYc9QrynHWTOQ
         bCDrV/kcfpt/WZ0G2tswuTCOJj0qlIs9jWwHQM8mbk9YkStD7IEm191LVP4MszqWb7RD
         f+ZqCHTFl7gfKIvyHvuz9+LvvGrT2bTFJaU4bjQSrnh5ZmMaJ7oKLKcpIgBcK3qYkAxZ
         VnusiedgE4jzCCEhUBQlLl/iW7cT9zoWJH8ZkYyVa9dk9gEUWjDOiBWF7satfzjEt7Wd
         KpcQ==
X-Gm-Message-State: AFqh2kprWxHj42ZZkgG/ttlk8OmhJ5xAVnV+QU1ScuUOWq2wsMTJtDtM
        7cZf6ne+PfixCAcl71paO9Hwi8QRTbsWkg0NUkmV+B3qNM2Q
X-Google-Smtp-Source: AMrXdXtaSpr8NtJPEd4STpTcR8xhn4kGEHa8xDExU0fkqH1YZxkrR5JThp2OAQWW5oWnVWDpBxpefH1nL3opwOjD66iNnL1RosyF
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3e0f:b0:38a:b96b:9fd8 with SMTP id
 co15-20020a0566383e0f00b0038ab96b9fd8mr292566jab.193.1671685779289; Wed, 21
 Dec 2022 21:09:39 -0800 (PST)
Date:   Wed, 21 Dec 2022 21:09:39 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000cfc7b05f063adba@google.com>
Subject: [syzbot] [gfs2?] kernel panic: stack is corrupted in gfs2_block_map
From:   syzbot <syzbot+2b5229694171c6846a90@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, broonie@kernel.org, catalin.marinas@arm.com,
        cluster-devel@redhat.com, kaleshsingh@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        madvenka@linux.microsoft.com, mark.rutland@arm.com, maz@kernel.org,
        rpeterso@redhat.com, syzkaller-bugs@googlegroups.com,
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
console output: https://syzkaller.appspot.com/x/log.txt?x=10e77d27880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbd4e584773e9397
dashboard link: https://syzkaller.appspot.com/bug?extid=2b5229694171c6846a90
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b39610480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11a1c6f7880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4b7702208fb9/disk-a5541c08.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ec0153ec051/vmlinux-a5541c08.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6f8725ad290a/Image-a5541c08.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/72be6726ff4f/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2b5229694171c6846a90@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 125323
gfs2: fsid=syz:syz: Trying to join cluster "lock_nolock", "syz:syz"
gfs2: fsid=syz:syz: Now mounting FS (format 1801)...
Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: gfs2_block_map+0x33c/0x408
CPU: 1 PID: 3073 Comm: syz-executor388 Not tainted 6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 panic+0x218/0x508 kernel/panic.c:274
 warn_bogus_irq_restore+0x0/0x40 kernel/panic.c:703
 gfs2_block_map+0x33c/0x408
 0x0
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
