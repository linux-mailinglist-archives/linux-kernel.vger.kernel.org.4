Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D1E5EAE59
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 19:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiIZRlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 13:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiIZRkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:40:36 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2263433E22
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:06:37 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id g1-20020a92cda1000000b002f612391d5bso5537462ild.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:06:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=RXZoyMLrw91eDBbUfEfSdQlOyXaEU9f2n9v5+RhyspQ=;
        b=Xf1M++v8bNa6PrLy5x0ae7qKQ/IptqstA1eu0woKDvs0IhKCaojfhEgbyfDql/LuRa
         iSE/IflksXZaSQ8HujM8Il2WzeNJwNitNVh/hJDP0F5fFdGjtZ+EfU9qfZ/nhMmuLAQK
         kkH4V+dE6vql0PixSvjiu8IKRcSOPIwJ/yoJfX2kfe1N0kRyIM7tpQNVS8Fez7shzl8i
         pGrBF6FO6gmkxRppOhiCrhgN/o8TmLmqvDDWhk+VDXZAF6P4tSihklAeqFu0FYQ89kCw
         DxRmVovYj33ybWMX7a80PgM4NXLNDLUfOattPYpn6O1va0HP5AKHGzjCm3QRfEbZL+Ei
         epfw==
X-Gm-Message-State: ACrzQf1PB+o6w0yej42fBogzaooeEatRzIWH/E+0vw4wWHt/8sD4SzNp
        FM9m7oECbMXAaEIvcv3PzQk59usc8+WnP2GT8ycSf/AKqbaG
X-Google-Smtp-Source: AMsMyM7kepRbJsY/yXdJvuXPzPDIjFvrRcUc6p4/5u4mDLorGoCEPEp+x2HdZtM5pYxsLYQ+XGrY0ZSQGlaHGP6CKWSykiqt8yZ0
MIME-Version: 1.0
X-Received: by 2002:a92:ccd0:0:b0:2f6:274c:f564 with SMTP id
 u16-20020a92ccd0000000b002f6274cf564mr11177700ilq.116.1664211996329; Mon, 26
 Sep 2022 10:06:36 -0700 (PDT)
Date:   Mon, 26 Sep 2022 10:06:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000df57ee05e9978cce@google.com>
Subject: [syzbot] UBSAN: shift-out-of-bounds in jfs_open
From:   syzbot <syzbot+027aa1f5f8487ba60a97@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=17928d60880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5
dashboard link: https://syzkaller.appspot.com/bug?extid=027aa1f5f8487ba60a97
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+027aa1f5f8487ba60a97@syzkaller.appspotmail.com

================================================================================
UBSAN: shift-out-of-bounds in fs/jfs/file.c:65:20
shift exponent 8205 is too large for 64-bit type '__u64' (aka 'unsigned long long')
CPU: 0 PID: 9735 Comm: syz-executor.4 Not tainted 6.0.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_shift_out_of_bounds+0x33d/0x3b0 lib/ubsan.c:322
 jfs_open+0x3a2/0x3d0 fs/jfs/file.c:65
 do_dentry_open+0x777/0x1180 fs/open.c:880
 do_open fs/namei.c:3557 [inline]
 path_openat+0x25fc/0x2df0 fs/namei.c:3691
 do_filp_open+0x264/0x4f0 fs/namei.c:3718
 do_sys_openat2+0x124/0x4e0 fs/open.c:1313
 do_sys_open fs/open.c:1329 [inline]
 __do_sys_open fs/open.c:1337 [inline]
 __se_sys_open fs/open.c:1333 [inline]
 __x64_sys_open+0x221/0x270 fs/open.c:1333
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5cbf28a669
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5cc0365168 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007f5cbf3ac120 RCX: 00007f5cbf28a669
RDX: 00000000000003ec RSI: 0000000000004042 RDI: 00000000200058c0
RBP: 00007f5cbf2e5560 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc1545e9af R14: 00007f5cc0365300 R15: 0000000000022000
 </TASK>
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
