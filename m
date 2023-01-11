Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02E1665965
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbjAKKwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235452AbjAKKvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:51:48 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83501014
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 02:51:47 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id t15-20020a5d81cf000000b006f95aa9ba6eso8863100iol.16
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 02:51:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PuBRYIvom7mS4Ac9wn0/HMLBW0OGLlFTy8/iEDjPDeE=;
        b=cCqDj1Kxoa3D6nSik6a3k7yTVa8Vj/CQYIdQcv5O88qcPh+HQB8HH7bLLsmuZLI30f
         LF6mfoZNyhzNSEEO/f2npy/K81DJgCMyug1vXckLARURezqwgXLgyoBs90cJro4R1qFB
         yERPbbna/l9ZvTP6yUZ9TBM9d1wD5nu3e+7TtZzQM0bFFHjJ8h9KdI4YpVdhpAFmRM6+
         znEBIvbmheFMLc78tlR8Ee++hTmnKy8fq5TXwaRwUbeLaYRGhimaQg/I0UNuYVdRpbij
         qUd3K0FIyH7VGS1HvynIfgXz8kGngd+iw2gXv10EA9Y4rIv3iVrTQHpVzBs9D21IaEEx
         wPGw==
X-Gm-Message-State: AFqh2koqLmcZGwdhFzGWvY9qAIi1n+drZiZdkCHK8qZzKLvmX4IOIovS
        HoOryqIcjDsb/7TTxqnqxlFwQd5sZwh855SmGw+lm7VDYA5v
X-Google-Smtp-Source: AMrXdXtzKG31e4C/I4hJQPawIibiSyzlyVPf32wktwSRxl+wNwgv040Z/cjlhxn49YUEs6IEGiotbx+pAQSM1BEGFeGJQQIVzVmb
MIME-Version: 1.0
X-Received: by 2002:a05:6638:292:b0:38a:3cc1:130a with SMTP id
 c18-20020a056638029200b0038a3cc1130amr5773380jaq.314.1673434307093; Wed, 11
 Jan 2023 02:51:47 -0800 (PST)
Date:   Wed, 11 Jan 2023 02:51:47 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006deae405f1fac97a@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in __set_extent_bit
From:   syzbot <syzbot+89700d262ed1fb9f9351@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
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

HEAD commit:    358a161a6a9e Merge branch 'for-next/fixes' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=12115e1c480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2573056c6a11f00d
dashboard link: https://syzkaller.appspot.com/bug?extid=89700d262ed1fb9f9351
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13abc0a6480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1153e53c480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/99d14e0f4c19/disk-358a161a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/23275b612976/vmlinux-358a161a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ed79195fac61/Image-358a161a.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/fdb7b054a0c8/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+89700d262ed1fb9f9351@syzkaller.appspotmail.com

 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
------------[ cut here ]------------
kernel BUG at fs/btrfs/extent-io-tree.c:379!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 4396 Comm: syz-executor224 Not tainted 6.2.0-rc3-syzkaller-16369-g358a161a6a9e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : set_state_bits fs/btrfs/extent-io-tree.c:379 [inline]
pc : __set_extent_bit+0x10c0/0x1174 fs/btrfs/extent-io-tree.c:1042
lr : set_state_bits fs/btrfs/extent-io-tree.c:379 [inline]
lr : __set_extent_bit+0x10c0/0x1174 fs/btrfs/extent-io-tree.c:1042
sp : ffff80000feab890
x29: ffff80000feab910 x28: ffff0000cafd9330 x27: ffff0000c9e6e300
x26: 0000000000000800 x25: 0000000000000000 x24: 000000000000ffff
x23: 000000000000ffff x22: ffff0000cafd9310 x21: 00000000fffffff4
x20: ffff0000cafd9310 x19: ffff0000c9e6e180 x18: 00000000000000c0
x17: 6e69676e45206574 x16: ffff80000dd86118 x15: ffff0000c4c30000
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c4c30000
x11: ff80800009263dec x10: 0000000000000000 x9 : ffff800009263dec
x8 : ffff0000c4c30000 x7 : ffff80000c11ee8c x6 : 0000000000000000
x5 : 00000000ffffffff x4 : 0000000000000a20 x3 : 0000000000000080
x2 : 0000000000000038 x1 : 00000000fffffff4 x0 : 0000000000000000
Call trace:
 set_state_bits fs/btrfs/extent-io-tree.c:379 [inline]
 __set_extent_bit+0x10c0/0x1174 fs/btrfs/extent-io-tree.c:1042
 set_record_extent_bits+0x74/0xb0 fs/btrfs/extent-io-tree.c:1690
 qgroup_reserve_data+0x134/0x374 fs/btrfs/qgroup.c:3758
 btrfs_qgroup_reserve_data+0x40/0xd0 fs/btrfs/qgroup.c:3801
 btrfs_zero_range+0x638/0x8c0 fs/btrfs/file.c:2997
 btrfs_fallocate+0x584/0xdd0 fs/btrfs/file.c:3114
 vfs_fallocate+0x328/0x38c fs/open.c:323
 ioctl_preallocate+0x16c/0x1bc fs/ioctl.c:290
 do_vfs_ioctl+0x123c/0x16a4 fs/ioctl.c:849
 __do_sys_ioctl fs/ioctl.c:868 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __arm64_sys_ioctl+0x98/0x140 fs/ioctl.c:856
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
Code: d4210000 97c12b8e d4210000 97c12b8c (d4210000) 
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
