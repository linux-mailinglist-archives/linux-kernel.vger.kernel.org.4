Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A14C627039
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 16:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbiKMPjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 10:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKMPjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 10:39:46 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0B95F76
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 07:39:46 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id h20-20020a056e021d9400b00300581edaa5so7645413ila.12
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 07:39:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N5fQ73RjqVvxTs9vlCsZRDgeFywF6Mr6XM1ky1FHK6s=;
        b=eakc7JR5bky0JEU6Jp4UIgufr7zF9JQ3PAA8NpbUtATBvS0aQ5/g3Q5UO36RDqqtLO
         DQHsYLt14HdKcJd0Z5BCYVbY9V1gd4tzYtTvDyJPpapwRfyrTCURwmG3zIuXelJNzTHL
         VMsHvZXXERAJ1L5JIOqft4vKYKJcZFql+RyBI68s9o4K9XxmiUTd4zb8IO+8j19tU1T8
         OZWXNI5c7u1tEXzlJArK3FWp37i6JoTZVHoz76TnPIEfpfNKK1noukyHTs6bkAiKBmQj
         CC+ArmiFb5MzSNBkMDbOHCcLzmKJLCUy2w6DgMywjRxEEtidOWkLtjRloGVKdHhq4RGY
         Mo/g==
X-Gm-Message-State: ANoB5pkiIBKxI7DRNJc2yYZWmuWSxiauw/1aXmwBbUuUx7zUeLk/+qVB
        3IjkeujHAwl0guvcS/Hfoni26jaPcGeCTNodwiZNa14BIFOZ
X-Google-Smtp-Source: AA0mqf5AzzQMQwu8cmFpfM77BpTnUz+LlZEofm/5x1ufMbCP40DQ3TQRWvztZLTGfGDD+93r+Ql5BDLRp/3sL4ad7xQAlSLQXqiw
MIME-Version: 1.0
X-Received: by 2002:a92:a007:0:b0:300:bb03:28df with SMTP id
 e7-20020a92a007000000b00300bb0328dfmr4486785ili.280.1668353985499; Sun, 13
 Nov 2022 07:39:45 -0800 (PST)
Date:   Sun, 13 Nov 2022 07:39:45 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aa58fb05ed5beed6@google.com>
Subject: [syzbot] UBSAN: shift-out-of-bounds in dbMount
From:   syzbot <syzbot+0835e526215d5dcefaa9@syzkaller.appspotmail.com>
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

HEAD commit:    f8f60f322f06 Add linux-next specific files for 20221111
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1641a035880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85ba52c07cd97289
dashboard link: https://syzkaller.appspot.com/bug?extid=0835e526215d5dcefaa9
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10cab285880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ca88f1880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6008df424195/disk-f8f60f32.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/394340525f66/vmlinux-f8f60f32.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b13604a3343a/bzImage-f8f60f32.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c509c1d4b329/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0835e526215d5dcefaa9@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
================================================================================
UBSAN: shift-out-of-bounds in fs/jfs/jfs_dmap.c:201:29
shift exponent -1368651876 is negative
CPU: 1 PID: 5245 Comm: syz-executor195 Not tainted 6.1.0-rc4-next-20221111-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 ubsan_epilogue+0xb/0x50 lib/ubsan.c:151
 __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x187 lib/ubsan.c:322
 dbMount.cold+0x17/0x38 fs/jfs/jfs_dmap.c:201
 jfs_mount+0x263/0x7b0 fs/jfs/jfs_mount.c:121
 jfs_fill_super+0x5a4/0xc70 fs/jfs/super.c:556
 mount_bdev+0x34d/0x410 fs/super.c:1401
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1531
 do_new_mount fs/namespace.c:3145 [inline]
 path_mount+0x1326/0x1e20 fs/namespace.c:3475
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3696 [inline]
 __se_sys_mount fs/namespace.c:3673 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3673
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fea10c7d1fa
Code: 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff879d2458 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fea10c7d1fa
RDX: 0000000020005380 RSI: 0000000020000100 RDI: 00007fff879d2470
RBP: 00007fff879d2470 R08: 00007fff879d24b0 R09: 0000555556ef52c0
R10: 0000000000000000 R11: 0000000000000282 R12: 0000000000000004
R13: 00007fff879d24b0 R14: 0000000000000358 R15: 0000000020005240
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
