Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518AB6394EA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 10:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiKZJXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 04:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKZJXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 04:23:44 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EC2275C8
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 01:23:44 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id j20-20020a056e02219400b00300a22a7fe0so4450770ila.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 01:23:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=loPan65hC9LffYNEIOROZKXrTfmHiDsnKPAsVgMfppQ=;
        b=sdE0m8v8FXt/76amiCzdzC0Tb0Sbh4aQ+ba7NheILWvACYneJZLYLAFxYKOtMMT5D1
         P+lZNUMpaPHGdOWVvaZu5K1tuMe9VWKPmV5dK+Y0R6BKxcr27xvFMq8xpfIAWZt0afHu
         akp1Nx6GMD02XEvh/nFDfZ87NgOS9E0C6r4/hiGxvDwx8AaVl9e/X/UmU3GkShmiS8XP
         sp660z1juw8nZ/iceS898U1B2ZAJ68ZbgHg2SmBN/FJjwjn1F90YCCA85DAhn/r0nFRj
         YDv1e9byfUu9wb0DeqSF9Pwa3B6hh8B16mE7tuw7F/szDEcXXXS0fMBt0gO6QH9O55MJ
         woNg==
X-Gm-Message-State: ANoB5pnO0+E9h6+J/Pn3zxJL3s5qCRtR21gRpx5e6FVMafnKP+eOgb/N
        vMBdUWIvkpBOMnoBqvgKDe0hTYZHKca0MZUJ63Mp3eHdxmVd
X-Google-Smtp-Source: AA0mqf5VoOWoeIXq6A6dHmdGVAjNlJCaqmbXRrbyE2T84QShFK7/cqFTt3LfyPd9LLOuOSEsZxqpkdWeRddxvjhoH1JLDfhbF1jP
MIME-Version: 1.0
X-Received: by 2002:a02:cbab:0:b0:375:280e:59c8 with SMTP id
 v11-20020a02cbab000000b00375280e59c8mr12808268jap.91.1669454623384; Sat, 26
 Nov 2022 01:23:43 -0800 (PST)
Date:   Sat, 26 Nov 2022 01:23:43 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cbade405ee5c318c@google.com>
Subject: [syzbot] BUG: unable to handle kernel paging request in __detach_mounts
From:   syzbot <syzbot+7bddaf6b35765f4a1bd3@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
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
console output: https://syzkaller.appspot.com/x/log.txt?x=13016e75880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23eec5c79c22aaf8
dashboard link: https://syzkaller.appspot.com/bug?extid=7bddaf6b35765f4a1bd3
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=123594e3880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164dd7e5880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f22d29413625/disk-6d464646.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/389f0a5f1a4a/vmlinux-6d464646.xz
kernel image: https://storage.googleapis.com/syzbot-assets/48ddb02d82da/Image-6d464646.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/ff775172773d/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7bddaf6b35765f4a1bd3@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address 000fbcb9763f43bd
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004
  CM = 0, WnR = 0
[000fbcb9763f43bd] address between user and kernel address ranges
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 3084 Comm: syz-executor274 Not tainted 6.1.0-rc6-syzkaller-32662-g6d464646530f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : lookup_mountpoint fs/namespace.c:768 [inline]
pc : __detach_mounts+0xcc/0x3c4 fs/namespace.c:1741
lr : lookup_mountpoint fs/namespace.c:767 [inline]
lr : __detach_mounts+0xe4/0x3c4 fs/namespace.c:1741
sp : ffff80000ffbbcc0
x29: ffff80000ffbbcc0 x28: ffff0000c63e8000 x27: 0000000000000000
x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000001
x23: ffff80000c0f4540 x22: ffff0000c0555618 x21: 4a0fbcb9763f43ad
x20: ffff8000085d7f60 x19: ffff80000d300700 x18: 00000000000000c0
x17: ffff80000dda8198 x16: ffff80000dbe6158 x15: ffff0000c63e8000
x14: ffff80000dda8198 x13: ffff80000dbe6158 x12: ffff0000c63e8000
x11: ff80800008607f5c x10: 0000000000000000 x9 : ffff800008607f5c
x8 : ffff0000c63e8000 x7 : ffff8000085d7f60 x6 : 0000000000000000
x5 : 0000000000000020 x4 : ffff80000ffbbaa0 x3 : 0000000000000000
x2 : ffff8000081a6214 x1 : ffff80000cbaab30 x0 : 0000000000000000
Call trace:
 lookup_mountpoint fs/namespace.c:767 [inline]
 __detach_mounts+0xcc/0x3c4 fs/namespace.c:1741
 detach_mounts fs/mount.h:116 [inline]
 vfs_rmdir+0x25c/0x264 fs/namei.c:4127
 do_rmdir+0x164/0x2a4 fs/namei.c:4181
 __do_sys_unlinkat fs/namei.c:4361 [inline]
 __se_sys_unlinkat fs/namei.c:4355 [inline]
 __arm64_sys_unlinkat+0x90/0xa8 fs/namei.c:4355
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
Code: 0b080128 8a0b0108 f8687955 b4000115 (f9400aa8) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	0b080128 	add	w8, w9, w8
   4:	8a0b0108 	and	x8, x8, x11
   8:	f8687955 	ldr	x21, [x10, x8, lsl #3]
   c:	b4000115 	cbz	x21, 0x2c
* 10:	f9400aa8 	ldr	x8, [x21, #16] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
