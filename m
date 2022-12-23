Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2BD654CA8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 07:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235877AbiLWG5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 01:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiLWG5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 01:57:38 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC6B13F71
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 22:57:34 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id n15-20020a056e021baf00b0030387c2e1d3so2264551ili.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 22:57:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KMSbyUfyO6NDTW70zNN+3BdvFcUTCl3kbP4QW5G+jko=;
        b=oOZfXtDA/A5/8LN7jgoFmnVehoM9QvZQQomlFpYsVAGfu8IQb6TyLjJV9wVzY6JpmV
         TO+y7Rprhap+6chv/lMGMGwt+3mKPq5yR2pdtwOq44aD1gATheuZ2eAIO3auVdEVnmZF
         RmsW1vE6Yhtmp4h81qf5io8LmRet5iofWOWegifJPyHdNSYVAMeCSZUFAfkRDW74NA26
         IWOVkKZxkkcXHINXNBuXoYkTpm3ONJTgX8svF+YGnLQc9yY1nbYwAgAQnzW+r2h1sCK9
         c32ORkjNB1kvQQn69dp3crFcFFmBPIJA+dT6doFE23aWsZmNkbGxLGsgdc6urzhlo/k/
         7L6w==
X-Gm-Message-State: AFqh2krUcTkHI4QSKq610s9wsSrSmJS5QZ578D9L3KaNWAJ9tDq2Xa/K
        nEW0qLwyM7+Evf+w0qfAPmFhOG1PftgyirgUsErSAdI1UagQ
X-Google-Smtp-Source: AMrXdXtP7XurYqc2ojv9IS+bGffVewCZgVpsXvQwms0Gy4bgBL9R8/FI6PCfsO1oCwI+33XStFvuf01LnmjduQE0EIUW73bWY+Us
MIME-Version: 1.0
X-Received: by 2002:a92:c54f:0:b0:303:3119:420e with SMTP id
 a15-20020a92c54f000000b003033119420emr815440ilj.320.1671778653727; Thu, 22
 Dec 2022 22:57:33 -0800 (PST)
Date:   Thu, 22 Dec 2022 22:57:33 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cc732d05f0794cf7@google.com>
Subject: [syzbot] WARNING: refcount bug in gadgetfs_kill_sb
From:   syzbot <syzbot+ac031e7435393ad05df6@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, hbh25y@gmail.com, jomajm@gmail.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mingo@kernel.org, rdunlap@infradead.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1310cd10480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbd4e584773e9397
dashboard link: https://syzkaller.appspot.com/bug?extid=ac031e7435393ad05df6
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=151fd1f0480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=122eacc8480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4b7702208fb9/disk-a5541c08.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ec0153ec051/vmlinux-a5541c08.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6f8725ad290a/Image-a5541c08.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ac031e7435393ad05df6@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 1 PID: 3448 at lib/refcount.c:28 refcount_warn_saturate+0x1a0/0x1c8 lib/refcount.c:28
Modules linked in:
CPU: 1 PID: 3448 Comm: syz-executor242 Not tainted 6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : refcount_warn_saturate+0x1a0/0x1c8 lib/refcount.c:28
lr : refcount_warn_saturate+0x1a0/0x1c8 lib/refcount.c:28
sp : ffff800012ed3c60
x29: ffff800012ed3c60 x28: ffff80000c40fe48 x27: 0000000000000006
x26: ffff0000c70d6508 x25: 0000000000000000 x24: ffff0000c70d6400
x23: 0000000000000000 x22: ffff80000f183000 x21: 0000000000000000
x20: 0000000000000003 x19: ffff80000d95e000 x18: 000000000000030d
x17: ffff80000c0cd83c x16: ffff80000dbe6158 x15: ffff0000cdd34ec0
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000cdd34ec0
x11: ff808000081c4d64 x10: 0000000000000000 x9 : 6a9cd14bd183ed00
x8 : 6a9cd14bd183ed00 x7 : ffff80000816678c x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000006 x1 : 0000000100000000 x0 : 0000000000000026
Call trace:
 refcount_warn_saturate+0x1a0/0x1c8 lib/refcount.c:28
 __refcount_sub_and_test include/linux/refcount.h:283 [inline]
 __refcount_dec_and_test include/linux/refcount.h:315 [inline]
 refcount_dec_and_test include/linux/refcount.h:333 [inline]
 put_dev drivers/usb/gadget/legacy/inode.c:159 [inline]
 gadgetfs_kill_sb+0xd4/0x104 drivers/usb/gadget/legacy/inode.c:2086
 deactivate_locked_super+0x70/0xe8 fs/super.c:332
 vfs_get_super fs/super.c:1190 [inline]
 get_tree_single+0x98/0xe8 fs/super.c:1207
 gadgetfs_get_tree+0x28/0x38 drivers/usb/gadget/legacy/inode.c:2068
 vfs_get_tree+0x40/0x140 fs/super.c:1531
 vfs_fsconfig_locked fs/fsopen.c:232 [inline]
 __do_sys_fsconfig fs/fsopen.c:439 [inline]
 __se_sys_fsconfig fs/fsopen.c:314 [inline]
 __arm64_sys_fsconfig+0x758/0x818 fs/fsopen.c:314
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
irq event stamp: 442
hardirqs last  enabled at (441): [<ffff80000816681c>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1366 [inline]
hardirqs last  enabled at (441): [<ffff80000816681c>] finish_lock_switch+0x94/0xe8 kernel/sched/core.c:4968
hardirqs last disabled at (442): [<ffff80000c084084>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:405
softirqs last  enabled at (360): [<ffff80000801c82c>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (358): [<ffff80000801c7f8>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
