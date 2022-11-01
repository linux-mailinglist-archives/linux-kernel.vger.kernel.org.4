Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52F8614F7F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 17:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiKAQg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 12:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiKAQgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 12:36:03 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD811EAEE
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 09:32:47 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id o13-20020a056e0214cd00b00300a27f9424so7231359ilk.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 09:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s9+A1ZjPI8JCoqYFEJU/fc9xB01d2XOFCR6s6RM/nQw=;
        b=d732sdpVr9ywFmD4/nOxzek8bAHMdH5iJ9C+68BNx/GxSv27OsjNmys09c37ZFLPZt
         sD85yY+VpYNG2MWc7rJKbZS0bOfTdjUxpXmvkOOFxcHC6iK1COT6N5qNrwbkybQiYvAD
         Kh7+Isw4WBjUyoRyo+IZTfvOnlkxTyXV9nsartqJbqQTD+AqNpTM38rxP34HecsPzQTQ
         UkDdKIQ5eeDBBD+KNCiibMuOFAAtKgKcCPyBUKAHB0BHKTFQ4YE6RTlLyPqRsQoKsJei
         iW+Dokb3weI80wlrwcg49kUCSM1LvC6q7652rbLlv0NM3tr+QXxJpCKO0mEHLjRGmjR/
         hcfg==
X-Gm-Message-State: ACrzQf0lMUp/f8N9N15xyv2ZRRltRLLQDp9gtuguaGpQBTv0dT7SfXr5
        9EzpKws9X3/XnN/oLLOqBcWWKJdVfOf6iLVSJASJyet0SMfa
X-Google-Smtp-Source: AMsMyM7hUOz9Jd8wdvexGqdYx29NPMjY1vBYn3EPSbGaFCoVVhwTtKYuWKpTAPIyz4q/SuJ7oBgdYdQgfUt7/eU92zp8D/lDPZP0
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:787:b0:300:c853:a24e with SMTP id
 q7-20020a056e02078700b00300c853a24emr1001610ils.59.1667320366644; Tue, 01 Nov
 2022 09:32:46 -0700 (PDT)
Date:   Tue, 01 Nov 2022 09:32:46 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002e45a805ec6b46a7@google.com>
Subject: [syzbot] UBSAN: shift-out-of-bounds in blkstol2
From:   syzbot <syzbot+0be96567042453c0c820@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        mudongliangabcd@gmail.com, paskripkin@gmail.com, r33s3n6@gmail.com,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com,
        wuhoipok@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4d48f589d294 Add linux-next specific files for 20221021
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12fd817a880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c4b7d600a5739a6
dashboard link: https://syzkaller.appspot.com/bug?extid=0be96567042453c0c820
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12f70161880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=101ed1ce880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0c86bd0b39a0/disk-4d48f589.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/074059d37f1f/vmlinux-4d48f589.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b95b380256a7/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0be96567042453c0c820@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
================================================================================
UBSAN: shift-out-of-bounds in fs/jfs/jfs_dmap.c:2227:15
shift exponent -744642816 is negative
CPU: 0 PID: 3602 Comm: syz-executor202 Not tainted 6.1.0-rc1-next-20221021-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 ubsan_epilogue+0xb/0x50 lib/ubsan.c:151
 __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x187 lib/ubsan.c:322
 blkstol2.cold-0x5/0x26
 dbAllocDmap+0x61/0x110 fs/jfs/jfs_dmap.c:2009
 dbAllocDmapLev+0x158/0x2c0 fs/jfs/jfs_dmap.c:1963
 dbAllocCtl+0x131/0x780 fs/jfs/jfs_dmap.c:1803
 dbAllocAny+0x10e/0x1a0 fs/jfs/jfs_dmap.c:1517
 dbAlloc+0x46d/0xa70 fs/jfs/jfs_dmap.c:869
 ea_write+0x4ed/0xc90 fs/jfs/xattr.c:232
 ea_put fs/jfs/xattr.c:610 [inline]
 __jfs_setxattr+0xea9/0xfc0 fs/jfs/xattr.c:783
 __jfs_xattr_set+0xc9/0x150 fs/jfs/xattr.c:917
 __vfs_setxattr+0x115/0x180 fs/xattr.c:182
 __vfs_setxattr_noperm+0x125/0x5f0 fs/xattr.c:216
 __vfs_setxattr_locked+0x1cf/0x260 fs/xattr.c:277
 vfs_setxattr+0x13f/0x330 fs/xattr.c:309
 setxattr+0x146/0x160 fs/xattr.c:617
 path_setxattr+0x197/0x1c0 fs/xattr.c:636
 __do_sys_setxattr fs/xattr.c:652 [inline]
 __se_sys_setxattr fs/xattr.c:648 [inline]
 __x64_sys_setxattr+0xc0/0x160 fs/xattr.c:648
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa3cc94ee69
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc339e1fe8 EFLAGS: 00000246 ORIG_RAX: 00000000000000bc
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007fa3cc94ee69
RDX: 00000000200079c0 RSI: 0000000020004ec0 RDI: 0000000020004d40
RBP: 00007fa3cc90e630 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000fffe R11: 0000000000000246 R12: 0000001200030083
R13: 0000000000000000 R14: 00083878000000f0 R15: 0000000000000000
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
