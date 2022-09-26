Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BCD5EADFB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 19:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiIZRTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 13:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiIZRSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:18:51 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF85FE05D9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 09:32:44 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id d24-20020a05660225d800b006a466ec7746so3202766iop.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 09:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=CPZvLmvgmmIL31BbqFncbnTIzAtKgNpQNnol62z/2wA=;
        b=0TVsbBg5E7I+MnuJ8Er+CGiUBUG2glcbG9ALh7xSSVsPXOhcApf0pWtW8dNSqxsuUc
         EL7DKMBDPdyemZlJJJzPRZ/M2Z+uc06Vq1cuu+eS4CeCDnpKcQSIgBHwrOgakl+TukkL
         5SAM/o7G8Ic1odjRmdYyWpVACXaUej9C52tlyEW8PFwvP0GOY2R3d+XYcfGdbQqOOaxk
         Q/nP0pJsFF0zA4vXQWJPRq12gv3FkLCtTl+hCNXlrZG6fRqhRx8cYEBpSo7oES2NN9oy
         F5zoyryCl4bJOE+R2usVbLmi3urZGW3d4BX0gNoV1n3FEewlWSIFppCsAvIqE+K9r4Ih
         QaSQ==
X-Gm-Message-State: ACrzQf1QlewBpqqUK2z/Dy0AvupY6pp3RE3eR5uORXr62HO1SOMby9z5
        x0qkHh5gay9bw+9fnJ10YR2p2Z2xEq9d6gzipZyL+SzFZKFS
X-Google-Smtp-Source: AMsMyM7Eq3HeZPdRP094BU2+h8q2AMKJycG3mryWGHmtb3xZMV3sNrkbc+39hteb1IZifHjAH6tu16igGpOpUcptJvMgTY5PwVNH
MIME-Version: 1.0
X-Received: by 2002:a02:711b:0:b0:359:1955:9997 with SMTP id
 n27-20020a02711b000000b0035919559997mr12655042jac.203.1664209956529; Mon, 26
 Sep 2022 09:32:36 -0700 (PDT)
Date:   Mon, 26 Sep 2022 09:32:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a6d9505e99713e0@google.com>
Subject: [syzbot] UBSAN: shift-out-of-bounds in dbAlloc
From:   syzbot <syzbot+a41ec88f6b014e3da07b@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    f76349cf4145 Linux 6.0-rc7
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15f64288880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5
dashboard link: https://syzkaller.appspot.com/bug?extid=a41ec88f6b014e3da07b
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16880b18880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=157311df080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a41ec88f6b014e3da07b@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 264192
================================================================================
UBSAN: shift-out-of-bounds in fs/jfs/jfs_dmap.c:776:12
shift exponent 1834973817 is too large for 64-bit type 'long long'
CPU: 0 PID: 3608 Comm: syz-executor347 Not tainted 6.0.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_shift_out_of_bounds+0x33d/0x3b0 lib/ubsan.c:322
 dbAlloc+0xbdc/0xc90 fs/jfs/jfs_dmap.c:776
 extBalloc fs/jfs/jfs_extent.c:321 [inline]
 extAlloc+0x4b9/0xff0 fs/jfs/jfs_extent.c:122
 jfs_get_block+0x342/0xce0 fs/jfs/inode.c:248
 __block_write_begin_int+0x5f6/0x1ba0 fs/buffer.c:2006
 __block_write_begin fs/buffer.c:2056 [inline]
 block_write_begin+0x93/0x1e0 fs/buffer.c:2117
 jfs_write_begin+0x2d/0x60 fs/jfs/inode.c:304
 generic_perform_write+0x2a8/0x5b0 mm/filemap.c:3738
 __generic_file_write_iter+0x176/0x400 mm/filemap.c:3866
 generic_file_write_iter+0xab/0x310 mm/filemap.c:3898
 do_iter_write+0x6c2/0xc20 fs/read_write.c:855
 vfs_writev fs/read_write.c:928 [inline]
 do_writev+0x23e/0x430 fs/read_write.c:971
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f72b62b4f39
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe31a1b658 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f72b62b4f39
RDX: 0000000000000001 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 00007f72b6274700 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000f8008000
R13: 0000000000000000 R14: 00080000000000f8 R15: 0000000000000000
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
