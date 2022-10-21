Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2D3606F09
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 06:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJUEpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 00:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiJUEpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 00:45:46 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F43B155D9E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 21:45:41 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id y13-20020a056e021bed00b002faba3c4afbso2197235ilv.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 21:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/9d8AJo9dk8KoWADjV9xino9cLGZcNKf+nSwONud7nQ=;
        b=OoqLbq5zyay6YGUPFtSEDs0wbZPv5EkrC7kXeabdbdhDUQ93jo1S3hZI/XUlc8KFty
         e3ExN9H3bm5Ikk28IMIdOtNIYstDWJV0MkZALgc3TC3gRFLiWVrr0iy1GSnQyEfY0zJI
         sQdfSZaeF7Q51iI0UZDilZCLYjox5vcscQtVj1f20ffmFKLLXFJ5srsaJdabQQYI33Mw
         hjnZDcBrGybkveCXmocUPcdZQe5wUJY7BfXJgq/hdaWHROKcTPhPtJ+qg9roX5TUHzG3
         vGZa4Dem8p+tGpGDexX1qazzotMKV+1YLjxTTICAdri5fO1sXGGC62ApjqRVcGpD/+17
         77+w==
X-Gm-Message-State: ACrzQf0IM0nG6ZHN4u8FQoMkGFR+4FitsQv+dig04pDsIgoIhji5KRrX
        +HNDhgMBXI+yYxWMtxwPSZv0bECM6UptcTas0HnuN65bhtFB
X-Google-Smtp-Source: AMsMyM6RTIKDl5ipvDk+jhMlBJpQ+u3izbIT/78a0zJczSl0jvOJNv9HVtFoteNMrdRyuKvi3dYOT3Z7woHugcHYxeFGs3aN7tkA
MIME-Version: 1.0
X-Received: by 2002:a5e:c004:0:b0:6bc:9a7f:ebc7 with SMTP id
 u4-20020a5ec004000000b006bc9a7febc7mr12051606iol.163.1666327540896; Thu, 20
 Oct 2022 21:45:40 -0700 (PDT)
Date:   Thu, 20 Oct 2022 21:45:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000027993305eb841df8@google.com>
Subject: [syzbot] UBSAN: array-index-out-of-bounds in diWrite
From:   syzbot <syzbot+c1056fdfe414463fdb33@syzkaller.appspotmail.com>
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

HEAD commit:    493ffd6605b2 Merge tag 'ucount-rlimits-cleanups-for-v5.19'..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1512cd9a880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
dashboard link: https://syzkaller.appspot.com/bug?extid=c1056fdfe414463fdb33
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12f431d2880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1208894a880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f1ff6481e26f/disk-493ffd66.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/101bd3c7ae47/vmlinux-493ffd66.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/720c16671db9/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c1056fdfe414463fdb33@syzkaller.appspotmail.com

================================================================================
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_imap.c:749:4
index 255 is out of range for type 'struct dtslot [128]'
CPU: 1 PID: 3606 Comm: syz-executor322 Not tainted 6.0.0-syzkaller-09423-g493ffd6605b2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_out_of_bounds+0xdb/0x130 lib/ubsan.c:283
 diWrite+0x1311/0x1f80 fs/jfs/jfs_imap.c:749
 txCommit+0xa2e/0x6d40 fs/jfs/jfs_txnmgr.c:1250
 jfs_mkdir+0x911/0xb00 fs/jfs/namei.c:290
 vfs_mkdir+0x3b3/0x590 fs/namei.c:4013
 do_mkdirat+0x279/0x550 fs/namei.c:4038
 __do_sys_mkdirat fs/namei.c:4053 [inline]
 __se_sys_mkdirat fs/namei.c:4051 [inline]
 __x64_sys_mkdirat+0x85/0x90 fs/namei.c:4051
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f1a977dfe49
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd8f230c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1a977dfe49
RDX: 00000000000001ff RSI: 00000000200000c0 RDI: ffffffffffffff9c
RBP: 00007f1a9779f610 R08: 0000000000000000 R09: 0000000000000000
R10: 00005555566302c0 R11: 0000000000000246 R12: 00000000f8008000
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
