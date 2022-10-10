Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9995F99E9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 09:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbiJJHZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 03:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbiJJHY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 03:24:57 -0400
Received: from mail-io1-xd46.google.com (mail-io1-xd46.google.com [IPv6:2607:f8b0:4864:20::d46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B931F2EE
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 00:19:45 -0700 (PDT)
Received: by mail-io1-xd46.google.com with SMTP id z6-20020a6be206000000b006bbebf8f872so2311228ioc.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 00:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=asIjUCPWiCfWANYg6tljFONDkTTb0ft8OpW1fvNJfIY=;
        b=7ZPKQuPFdTy/Xftqbn+f9GKdJOiu4Z7i5WxZJL6bfavceMhVAqs1i9A98fVobpxLSc
         PABoVOMerP48LkSaDDHxiu87ANtjoVowQzmSljgoQR+gGhCUKiPchJZRpIqnrPf1qcjq
         AetcMFg/+mTuQlEgCS9EfxJ401C3zn0iTJEGBXFayAgvk8r3A0SJqaZTFsa+q2KwLWJL
         dbhzBGS4wf1DXZGWHGiTgma6FfGcXRFHM3HvW/WqqkD20ETFu5U+dd8bgOuP5kElc7zW
         mIhZfVijdNoX868e0IaN3kZLOKtB6/HOwiIZiPqcznWAKwBpgEDU3trHirw3VWb0HNZ+
         YDqA==
X-Gm-Message-State: ACrzQf1YI4uTVQ0fVS8lOHVX3TwqvgBKYyEx+50h2wzHBO8A0N5v6w1U
        cH62Ll1FkWopNFR4jQxS4CmRzLD80Tv0ue1xen3l/q5sxeww
X-Google-Smtp-Source: AMsMyM7ffzUFPAW2WDtv3Vc1XkScdslB9Ss6nqiCpahm8iaCy1FAveDXdzM7Wrvt5fNKcSl9IZv4vbbX2J+U4VBIdcnfpCN2aznm
MIME-Version: 1.0
X-Received: by 2002:a05:6638:25c5:b0:35a:69fd:946e with SMTP id
 u5-20020a05663825c500b0035a69fd946emr9345689jat.174.1665386203235; Mon, 10
 Oct 2022 00:16:43 -0700 (PDT)
Date:   Mon, 10 Oct 2022 00:16:43 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000ece5005eaa8f1d1@google.com>
Subject: [syzbot] UBSAN: shift-out-of-bounds in dbAllocBits
From:   syzbot <syzbot+b9ba793adebb63e56dba@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    a6afa4199d3d Merge tag 'mailbox-v6.1' of git://git.linaro...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=178292a4880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
dashboard link: https://syzkaller.appspot.com/bug?extid=b9ba793adebb63e56dba
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1322ae34880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10403c94880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/12e24d042ff9/disk-a6afa419.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4862ae4e2edf/vmlinux-a6afa419.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/307612ff696d/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b9ba793adebb63e56dba@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
================================================================================
UBSAN: shift-out-of-bounds in fs/jfs/jfs_dmap.c:2217:15
shift exponent -1368651876 is negative
CPU: 0 PID: 3606 Comm: syz-executor109 Not tainted 6.0.0-syzkaller-09039-ga6afa4199d3d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_shift_out_of_bounds+0x33d/0x3b0 lib/ubsan.c:322
 dbAllocBits+0x96f/0x9c0 fs/jfs/jfs_dmap.c:2217
 dbAllocDmap fs/jfs/jfs_dmap.c:1999 [inline]
 dbAllocDmapLev+0x240/0x420 fs/jfs/jfs_dmap.c:1953
 dbAllocCtl+0x113/0x970 fs/jfs/jfs_dmap.c:1793
 dbAllocAny fs/jfs/jfs_dmap.c:1507 [inline]
 dbAlloc+0x5ae/0xc90 fs/jfs/jfs_dmap.c:732
 extBalloc fs/jfs/jfs_extent.c:321 [inline]
 extAlloc+0x4b9/0xff0 fs/jfs/jfs_extent.c:122
 jfs_get_block+0x342/0xce0 fs/jfs/inode.c:248
 __block_write_begin_int+0x5f6/0x1ba0 fs/buffer.c:2006
 __block_write_begin fs/buffer.c:2056 [inline]
 block_write_begin+0x93/0x1e0 fs/buffer.c:2117
 jfs_write_begin+0x2d/0x60 fs/jfs/inode.c:304
 generic_perform_write+0x2a8/0x5b0 mm/filemap.c:3745
 __generic_file_write_iter+0x176/0x400 mm/filemap.c:3873
 generic_file_write_iter+0xab/0x310 mm/filemap.c:3905
 do_iter_write+0x6c2/0xc20 fs/read_write.c:861
 vfs_writev fs/read_write.c:934 [inline]
 do_writev+0x23e/0x430 fs/read_write.c:977
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe1ef5c4e39
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff5e480f98 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007fe1ef5c4e39
RDX: 0000000000000001 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 00007fe1ef584600 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000f8008000
R13: 0000000000000000 R14: 00080000000000f4 R15: 0000000000000000
 </TASK>
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
