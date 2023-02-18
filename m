Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862F369BBB6
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 20:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjBRT7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 14:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjBRT7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 14:59:46 -0500
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C6312845
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 11:59:45 -0800 (PST)
Received: by mail-io1-f79.google.com with SMTP id w18-20020a5d8a12000000b007297c4996c7so791852iod.13
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 11:59:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pXywPTF4TFW1xlap95rMnZUmiADyD3ZS4ocYSqPDLgo=;
        b=4O9IUvDEhUo0KxLjockskUrTigsdQ7X0Ahf3pEzn0VwPRYIEkqKg+E1B1X/s1rCNDY
         m5iT+Fmgw7JBFyj1mYmaWkFzm1D4kl4LWcWjptyAMQvbb6Xm/hnocAosn2t/WkJRo/Hm
         Nji5Ow5kedPsPtzM5eECPWmi5zAUOlhCPcJF1F2MjUmBnRW/FfFxKFNCzv5GKcg+RcIY
         /IcZG1YgfzyQ6Iy//RKbTHn2HKdebqPQRoAzsTMZqHmQS+O4JcJbQjflVvdrrut/aoqD
         +X4kQBCRbeALQ/RzKhVwQmF5f57Ascz+Uts6HmDWo5x0JQ4E2ffJyhzwFvlfp2hamGAF
         oKoQ==
X-Gm-Message-State: AO0yUKVSPCo9BbInf4uC85GRaNkZvu9U8EnwHAQ+HqvhqZvZzbKaUe2O
        NIwDbiSdFKm0WlhAD1kUzjR/k3QAPLzCcwBZcnIok2SLD5vx
X-Google-Smtp-Source: AK7set8q/Ao2UbhKr6G89mfVyUf9BSu4q128HL/jf53SxGxcEWKRVQlOF1/2bbtfXNsD9l6OQPs2yoYa2vtYmTDA1YYvPxtjdT45
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1121:b0:3c5:139d:6097 with SMTP id
 f1-20020a056638112100b003c5139d6097mr2505027jar.5.1676750385042; Sat, 18 Feb
 2023 11:59:45 -0800 (PST)
Date:   Sat, 18 Feb 2023 11:59:45 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000013dee605f4fedf8b@google.com>
Subject: [syzbot] [jfs?] KASAN: null-ptr-deref Read in txBegin
From:   syzbot <syzbot+f1faa20eec55e0c8644c@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
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

HEAD commit:    82eac0c830b7 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=108c3220c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=42ba4da8e1e6af9f
dashboard link: https://syzkaller.appspot.com/bug?extid=f1faa20eec55e0c8644c
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12dea55f480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/da7d342f68c6/disk-82eac0c8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bc04dc7d5c40/vmlinux-82eac0c8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9cbbc3b0e69a/bzImage-82eac0c8.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/40deef8f8496/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f1faa20eec55e0c8644c@syzkaller.appspotmail.com

read_mapping_page failed!
ERROR: (device loop0): txCommit: 
==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:72 [inline]
BUG: KASAN: null-ptr-deref in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: null-ptr-deref in txBegin+0x131/0x6c0 fs/jfs/jfs_txnmgr.c:366
Read of size 8 at addr 0000000000000040 by task syz-executor.0/5172

CPU: 0 PID: 5172 Comm: syz-executor.0 Not tainted 6.2.0-rc8-syzkaller-00019-g82eac0c830b7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_report+0xe6/0x4f0 mm/kasan/report.c:420
 kasan_report+0x13a/0x170 mm/kasan/report.c:517
 kasan_check_range+0x283/0x290 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:72 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 txBegin+0x131/0x6c0 fs/jfs/jfs_txnmgr.c:366
 jfs_link+0x1ac/0x5e0 fs/jfs/namei.c:802
 vfs_link+0x662/0x810 fs/namei.c:4529
 do_linkat+0x5b4/0x9d0 fs/namei.c:4600
 __do_sys_linkat fs/namei.c:4628 [inline]
 __se_sys_linkat fs/namei.c:4625 [inline]
 __x64_sys_linkat+0xdd/0xf0 fs/namei.c:4625
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff38288c0f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff383575168 EFLAGS: 00000246 ORIG_RAX: 0000000000000109
RAX: ffffffffffffffda RBX: 00007ff3829abf80 RCX: 00007ff38288c0f9
RDX: 0000000000000004 RSI: 0000000020000040 RDI: 0000000000000004
RBP: 00007ff3828e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000020000080 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe4ad3d6bf R14: 00007ff383575300 R15: 0000000000022000
 </TASK>
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
