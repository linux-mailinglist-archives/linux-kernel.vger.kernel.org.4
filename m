Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FAA63A596
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 11:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiK1KCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 05:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiK1KCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 05:02:37 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B7730B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 02:02:35 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id a14-20020a921a0e000000b00302a8ffa8e5so8334429ila.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 02:02:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gf4bPdmIKB8ohnUy2fgXAHp/zZUcQ9WjKxhNasqNEb8=;
        b=eqXzL9o0GHa41aIcWJVzsJFtIPxrl3hlgFAvVSwHEzAAudf+GfK5Zu1kdjwsXRdIHD
         MiGLTAMxRC4cggK+b2/huH9u61tIpvNHna6FB4Zo7DkBqCCZTVYRD4Gt4+4ICaHqMtgc
         iLTd8iYGq8m4iZ9gLtBClJLNjWs1yx7Ao64554NMZtHSVUVUDyyHiVU7mb+ndG16dfa1
         TXUoRXjlwhC+Ee6PsjU5wcXOGpvz45tuVXVs2n6oJ7AGrUVmUfEqpFBHG3bLYob01I4D
         jfutYyKC3TRX+8YMNX7EGOnGty6i1Xiu2eiq0LjoHZDJ16XmZAiJe2sUPrIwC0KI3jUY
         KrmA==
X-Gm-Message-State: ANoB5pmXdTCfarNwcGoDRkIcZcm2h0f23doCpUCHNVHiWAxVkYXQPEjb
        v9dEQ5xzUKom1JjSRSR54JCzWyIZHALWYrBNyqcA2hmJPEYL
X-Google-Smtp-Source: AA0mqf4VmdC6HsM9vY/52f6VtCrGaS8ujQGpeZI6oJIo+lIjsCsnwVDd/HOkK3FNlInaoFn1ZAUEAFMRtvpiNXHz5WRmd6zcwS/C
MIME-Version: 1.0
X-Received: by 2002:a02:9666:0:b0:363:b82d:d51e with SMTP id
 c93-20020a029666000000b00363b82dd51emr23485967jai.15.1669629755030; Mon, 28
 Nov 2022 02:02:35 -0800 (PST)
Date:   Mon, 28 Nov 2022 02:02:35 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007482d505ee84f8dc@google.com>
Subject: [syzbot] BUG: unable to handle kernel NULL pointer dereference in dir_search_u
From:   syzbot <syzbot+decdb33311f46369f416@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
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

HEAD commit:    6d464646530f Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=17244a4b880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23eec5c79c22aaf8
dashboard link: https://syzkaller.appspot.com/bug?extid=decdb33311f46369f416
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1430138d880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=108c8fed880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f22d29413625/disk-6d464646.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/389f0a5f1a4a/vmlinux-6d464646.xz
kernel image: https://storage.googleapis.com/syzbot-assets/48ddb02d82da/Image-6d464646.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/3f65b6de0e07/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+decdb33311f46369f416@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 8192
ntfs3: loop0: Different NTFS' sector size (4096) and media sector size (512)
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
Mem abort info:
  ESR = 0x0000000086000006
  EC = 0x21: IABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
user pgtable: 4k pages, 48-bit VAs, pgdp=000000010d1aa000
[0000000000000000] pgd=080000010d1ce003, p4d=080000010d1ce003, pud=080000010d251003, pmd=0000000000000000
Internal error: Oops: 0000000086000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 3109 Comm: syz-executor169 Not tainted 6.1.0-rc6-syzkaller-32662-g6d464646530f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : 0x0
lr : hdr_find_e fs/ntfs3/index.c:708 [inline]
lr : indx_find+0x3b0/0x954 fs/ntfs3/index.c:1068
sp : ffff80000ff6b8c0
x29: ffff80000ff6ba40 x28: 0000000000000000 x27: 0000000000000148
x26: ffff0000c9257000 x25: ffff0000c93d8278 x24: 0000000000000000
x23: 0000000000000000 x22: 0000000000000000 x21: 0000000000000003
x20: 0000000000000138 x19: 0000000000000002 x18: 0000000000000098
x17: ffff80000c0cd83c x16: ffff80000dbe6158 x15: ffff0000ce01cec0
x14: 0000000000000010 x13: 0000000000000000 x12: ffff0000ce01cec0
x11: ff80800008c11e14 x10: 0000000000000000 x9 : ffff800008c11e14
x8 : ffff0000ce01cec0 x7 : 0000000000000000 x6 : 0000000000000000
x5 : 2400490033003000 x4 : ffff0000c9257000 x3 : 0000000000000000
x2 : ffff0000c93d8288 x1 : 0000000000000000 x0 : ffff80000c1f232e
Call trace:
 0x0
 dir_search_u+0xa4/0x1e0 fs/ntfs3/dir.c:254
 ntfs_extend_init+0xe4/0x238 fs/ntfs3/fsntfs.c:214
 ntfs_fill_super+0x143c/0x14a4 fs/ntfs3/super.c:1243
 get_tree_bdev+0x1e8/0x2a0 fs/super.c:1324
 ntfs_fs_get_tree+0x28/0x38 fs/ntfs3/super.c:1358
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
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
Code: bad PC value
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
