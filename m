Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB52E618302
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 16:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbiKCPir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 11:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiKCPin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:38:43 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6287309
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 08:38:41 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id i6-20020a5d88c6000000b006d088a0e518so1245884iol.19
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 08:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H+EcpWeMN+aR5+rnXtEwLak7cM5jmpXRI+mIotK6W9k=;
        b=IXW5Fo/FlZg3NasmkKsWti0tKUZpKmOvjM6N9LjXa7n/p6uYRyDF7gCt0Iac9L8rcQ
         vVrotLf+Z3Q8Z6SOrr6bQhlj0QOj+pdgI0bYO2fzJykGfjzzyBgzXi7Knqe0a+L64wLx
         cNHamoqz2DAU3EeMke/EYVPcK5gA2Yq5x4pBkXN5XRJMuc131Pr5bFNkvAvTI3kC3pfX
         SQlXd7g4s0y5HHK0TbEp72zjCQ3W2teP+RfyNFsIXeqWXm23TjqyxM8oGvs6Agyvilim
         niZHE+NOpRIGe4lHnVq1g9b4mo1EL3cSotnIL60wf0Aaz9fahzDl2FqJDN9HvV8gH6GY
         gYlg==
X-Gm-Message-State: ACrzQf1omYou6gEQhgSPnXgGHwzyoYvDxBTq4DOvFzEWZgHWk/iYwviL
        kzHb+T4MRaqF3ZSNMO4ZBS2FBJmP6kEHiKBCTYUPnDswaE18
X-Google-Smtp-Source: AMsMyM7paEBoNwGBzBMtkjRpysXRO3gjYzq2Eg7JDU1YNnEd9XYqa3CLCQNT4Pcxrb9R6JcU4Pf8A5dtQIEHO9OaYmxv1yWSgIdc
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1845:b0:300:7877:11f5 with SMTP id
 b5-20020a056e02184500b00300787711f5mr18873830ilv.97.1667489921280; Thu, 03
 Nov 2022 08:38:41 -0700 (PDT)
Date:   Thu, 03 Nov 2022 08:38:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006cb4bc05ec92c014@google.com>
Subject: [syzbot] UBSAN: shift-out-of-bounds in dbBackSplit
From:   syzbot <syzbot+3ef8947f8f9b50440df4@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        mudongliangabcd@gmail.com, paskripkin@gmail.com, r33s3n6@gmail.com,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com,
        wuhoipok@gmail.com
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

HEAD commit:    61c3426aca2c Add linux-next specific files for 20221102
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1727cd46880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=acb529cc910d907c
dashboard link: https://syzkaller.appspot.com/bug?extid=3ef8947f8f9b50440df4
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f170a9880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e2fff6880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cc56d88dd6a3/disk-61c3426a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5921b65b080f/vmlinux-61c3426a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/39cbd355fedd/bzImage-61c3426a.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/de5204da8a03/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3ef8947f8f9b50440df4@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
================================================================================
UBSAN: shift-out-of-bounds in fs/jfs/jfs_dmap.c:2621:11
shift exponent 109 is too large for 32-bit type 'int'
CPU: 0 PID: 5234 Comm: syz-executor124 Not tainted 6.1.0-rc3-next-20221102-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 ubsan_epilogue+0xb/0x50 lib/ubsan.c:151
 __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x187 lib/ubsan.c:322
 dbBackSplit.cold-0x5/0xca
 dbAllocBits+0x14f/0x5f0 fs/jfs/jfs_dmap.c:2173
 dbAllocDmap+0x61/0x110 fs/jfs/jfs_dmap.c:2014
 dbAllocNear fs/jfs/jfs_dmap.c:1243 [inline]
 dbAlloc+0x78a/0xa70 fs/jfs/jfs_dmap.c:828
 diNewExt+0x724/0x1a10 fs/jfs/jfs_imap.c:2251
 diAllocExt fs/jfs/jfs_imap.c:1945 [inline]
 diAllocAG+0x15f1/0x2200 fs/jfs/jfs_imap.c:1662
 diAlloc+0x82d/0x1730 fs/jfs/jfs_imap.c:1583
 ialloc+0x89/0xaa0 fs/jfs/jfs_inode.c:56
 jfs_mkdir+0x1f0/0xab0 fs/jfs/namei.c:225
 vfs_mkdir+0x489/0x740 fs/namei.c:4035
 do_mkdirat+0x277/0x2f0 fs/namei.c:4060
 __do_sys_mkdir fs/namei.c:4080 [inline]
 __se_sys_mkdir fs/namei.c:4078 [inline]
 __x64_sys_mkdir+0xf2/0x140 fs/namei.c:4078
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd3da355dc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe6b87ad38 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd3da355dc9
RDX: 00007fd3da3142c3 RSI: 0000000000000000 RDI: 00000000200052c0
RBP: 00007fd3da315590 R08: 000055555709e2c0 R09: 0000000000000000
R10: 00007ffe6b87ac00 R11: 0000000000000246 R12: 00000000f8008000
R13: 0000000000000000 R14: 00080000000000fc R15: 0000000000000000
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
