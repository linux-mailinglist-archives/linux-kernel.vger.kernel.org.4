Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EB260573C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 08:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiJTGQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 02:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiJTGQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 02:16:51 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCA2184994
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 23:16:49 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id q12-20020a5d834c000000b006bc2cb1994aso15845982ior.15
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 23:16:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1MfdereceE/3V87nTfYGeF1utu/rzFdYI+GBtd+NMds=;
        b=Ax2B4amlRfdWxqOpqkuyxhD4UsR6nLE3s+9XZhyVIzax/G82uwkLaB0kbbplXfNfkt
         17T3jT4NQsabbaD7kUCmnj7DC0qY9blcwkGIoX/vfWXUj9hxq9B5b9uEowlQCdLXZKBM
         RXiPHdbwVRpvDiK1JKs5m5RScIt47On4Kvehf3pPGYIhgqaTU1ec5zvlG0Ipa4E+UMHE
         aap2M4OaFc1xrYiiWz5eKyWyC1IPbJGx2rysAkdW0xc2ciQSPS7QnfOoihSadqdu8Ut6
         OVVzjgyp8yjBIiCD3mDXCjVyk8cdxvEGsv1sQxPq0px8CFmdq2+tkMWJJyCjq/raz3Qc
         0kzQ==
X-Gm-Message-State: ACrzQf2+skqY1YJH6rwqDAh2WojWlBXnYHSNjxWfV/hpAA4sIEUQjuSS
        oYTH/LZIRyPt/t3H83eqoCPfOukKWlBuCU0kG2+vsNjpV/hM
X-Google-Smtp-Source: AMsMyM7p/Bay7M4z3EDkhLxZAvg7exxdu+H7Q8p2Qxy2t8IkCX7DCRqe1BCdP1QMash7awkL/RG4OIGLFuGbnYSkx0XlQ24Tcm1X
MIME-Version: 1.0
X-Received: by 2002:a02:cc9c:0:b0:363:e0e6:ec1b with SMTP id
 s28-20020a02cc9c000000b00363e0e6ec1bmr9284183jap.89.1666246608618; Wed, 19
 Oct 2022 23:16:48 -0700 (PDT)
Date:   Wed, 19 Oct 2022 23:16:48 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000370ac005eb71453c@google.com>
Subject: [syzbot] UBSAN: shift-out-of-bounds in extHint
From:   syzbot <syzbot+4685943e4e2bf4a61bed@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a72b55bc981b Add linux-next specific files for 20221019
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12478bd6880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=200524babbc01b2a
dashboard link: https://syzkaller.appspot.com/bug?extid=4685943e4e2bf4a61bed
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15c7d70c880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=141adad2880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fa24fb5893fd/disk-a72b55bc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cf1b7e7b579c/vmlinux-a72b55bc.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2505d71f3ea8/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4685943e4e2bf4a61bed@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
================================================================================
UBSAN: shift-out-of-bounds in fs/jfs/jfs_extent.c:314:16
shift exponent -1 is negative
CPU: 1 PID: 3615 Comm: syz-executor427 Not tainted 6.1.0-rc1-next-20221019-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 ubsan_epilogue+0xb/0x50 lib/ubsan.c:151
 __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x187 lib/ubsan.c:322
 extHint.cold-0x5/0x1f
 jfs_get_block+0x661/0xa90 fs/jfs/inode.c:248
 __block_write_begin_int+0x3b9/0x14b0 fs/buffer.c:1991
 __block_write_begin fs/buffer.c:2041 [inline]
 block_write_begin+0xb5/0x440 fs/buffer.c:2102
 jfs_write_begin+0x2d/0xd0 fs/jfs/inode.c:304
 generic_perform_write+0x252/0x570 mm/filemap.c:3771
 __generic_file_write_iter+0x2aa/0x4d0 mm/filemap.c:3899
 generic_file_write_iter+0xdf/0x350 mm/filemap.c:3931
 call_write_iter include/linux/fs.h:2191 [inline]
 do_iter_readv_writev+0x20b/0x3b0 fs/read_write.c:735
 do_iter_write+0x182/0x700 fs/read_write.c:861
 vfs_writev+0x1aa/0x630 fs/read_write.c:934
 do_pwritev+0x1b6/0x270 fs/read_write.c:1031
 __do_sys_pwritev2 fs/read_write.c:1090 [inline]
 __se_sys_pwritev2 fs/read_write.c:1081 [inline]
 __x64_sys_pwritev2+0xeb/0x150 fs/read_write.c:1081
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f54a91b6e89
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffda0797a78 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f54a91b6e89
RDX: 0000000000000002 RSI: 0000000020003380 RDI: 0000000000000003
RBP: 00007f54a9176650 R08: 0000000000000000 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000f8008000
R13: 0000000000000000 R14: 00083878000000fc R15: 0000000000000000
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
