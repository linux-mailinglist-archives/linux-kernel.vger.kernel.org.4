Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7451654F26
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 11:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235843AbiLWKXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 05:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiLWKXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 05:23:37 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB42C6149
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 02:23:36 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id z19-20020a921a53000000b0030b90211df1so2466598ill.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 02:23:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kSw1HwKF/eWcNkkUwxqcpEhUNy2Y9H9WRREHpIRhyjw=;
        b=SYfKf6aq8oPV6bdwhMHxD1hNSXRmHmhBOBBbtVR0WJ3UkhrUhBsepJA0AVm70ve5kq
         Ec/zrxPlldn7Uu/LWi5KFumTU8DgS1u87GeBY9q4FZ78uKaoejPlXSXHVcI4yYVCByOx
         qsILA6g8ppilOGvf+Pr+Bx5QROsJlgqUOjGjzQPjXwWdqmjVrAaot7eZ5onNRMbJTkZb
         IQsIKJc8QEFcxaWwV4HnZSrzcSxlf0tKZI5KNx375eTvay1IykxUIp+2FhmKNlsdEHTm
         z9oIKomyt223NaRn+7mGN/5/Kcyr6tgf9Hw2/RSysmIc0SIMsQLK+B8LSuCiuJGVoLYa
         IbOw==
X-Gm-Message-State: AFqh2koVDT3wwZLw9tcwARmMTEZN8CmhAcA/IhYwwaiFhXY7wrORtzsP
        hD4eE1TNw+TBAWwbZu+Y3LT4SRK2+yPKeiHZoZgYrLlEobml
X-Google-Smtp-Source: AMrXdXsq+eWgR/9KTn/obApYMnY7hOwtxY+UDnCsagU9f+UQ9yURO2H/YZnW57qEkyaAv8MDpd8ZMr+VnJJKY2lbi3kQDRBhOQoF
MIME-Version: 1.0
X-Received: by 2002:a5d:9587:0:b0:6e2:cbf3:9c9c with SMTP id
 a7-20020a5d9587000000b006e2cbf39c9cmr639610ioo.34.1671791016259; Fri, 23 Dec
 2022 02:23:36 -0800 (PST)
Date:   Fri, 23 Dec 2022 02:23:36 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a9b84f05f07c2d1f@google.com>
Subject: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in dbAllocDmapLev
From:   syzbot <syzbot+853a6f4dfa3cf37d3aea@syzkaller.appspotmail.com>
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

HEAD commit:    0a924817d2ed Merge tag '6.2-rc-smb3-client-fixes-part2' of..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=161140ff880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e2d7bfa2d6d5a76
dashboard link: https://syzkaller.appspot.com/bug?extid=853a6f4dfa3cf37d3aea
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14eedba0480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13760874480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b0959a409a79/disk-0a924817.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/388daa76797b/vmlinux-0a924817.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b9d2d406c075/bzImage-0a924817.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c5bcb129d7ea/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+853a6f4dfa3cf37d3aea@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
================================================================================
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_dmap.c:1964:6
index -84 is out of range for type 's8 [341]'
CPU: 1 PID: 5074 Comm: syz-executor352 Not tainted 6.1.0-syzkaller-14321-g0a924817d2ed #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_out_of_bounds+0xe0/0x110 lib/ubsan.c:282
 dbAllocDmapLev+0x3c6/0x420 fs/jfs/jfs_dmap.c:1964
 dbAllocCtl+0x113/0x970 fs/jfs/jfs_dmap.c:1808
 dbAllocAG+0x28b/0x1100 fs/jfs/jfs_dmap.c:1349
 dbAlloc+0x661/0xc90 fs/jfs/jfs_dmap.c:873
 dtSplitUp fs/jfs/jfs_dtree.c:974 [inline]
 dtInsert+0xc0e/0x6b80 fs/jfs/jfs_dtree.c:863
 jfs_create+0x736/0xb10 fs/jfs/namei.c:137
 lookup_open fs/namei.c:3413 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x12ac/0x2dd0 fs/namei.c:3711
 do_filp_open+0x264/0x4f0 fs/namei.c:3741
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __x64_sys_openat+0x243/0x290 fs/open.c:1337
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe62a3507c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe095987c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe62a3507c9
RDX: 000000000000275a RSI: 0000000020000040 RDI: 00000000ffffff9c
RBP: 00007fe62a310060 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fe62a3100f0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
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
