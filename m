Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2A45EAE55
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 19:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiIZRkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 13:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbiIZRkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:40:11 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BEA8A7C0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:05:46 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id r12-20020a92cd8c000000b002f32d0d9fceso5652594ilb.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:05:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=zP2Ks3+peJR4d+FzWakp72trx11nZT8Tmm3I3GDmu/A=;
        b=zKoxN2GyQyCJCSElQp4EF8t0twrH5ZMki8wKWG900+BLTb+5HfXuqhpaBqDyZAVJsz
         hm4NfvvmlDXggqVJTwBiE+hsYMWntQsbkAZ9qeInvEfyF9Or5VgYxKtNqcXSpp3vu5aQ
         /PdovLgUQUTXi6cO0QVTVIXgKs6hAvVYutgKjGsI6hL1r99whK+FDpaTYSvDrgrIoAk7
         EQsafQu6jO4MRf1QBdWZfBYl7DoZ5I1ebfJfSbIFtUQO5TW1PEcq2c3y2MZqqeu3K8YK
         B4f4WwZ03TSEl+BQ/XMy2uDfr+K8tk4o/2zBEQ7CWJOQXOcQ2nibVX+taeYREE9agMrO
         yAhg==
X-Gm-Message-State: ACrzQf1FeHpX1uJLNQnNvX/c/eoqurj1pQ9DifgvlpWaNfZwwpJtEy/N
        ZrrUepCAmOcfLO1blhXpGsnyBM1PpMZwIGNzrKXa+21R3vY3
X-Google-Smtp-Source: AMsMyM6f6LJH4VuMNn/mHWq5BaFs4dxaeKRmmQ8VcUlH6vuwZ7Ea59IFErU6MNVKxRl/VyzUZfMhDVfeWujt3vH7OunQ8j4rHrue
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1683:b0:35a:4772:edc2 with SMTP id
 f3-20020a056638168300b0035a4772edc2mr12077302jat.128.1664211945824; Mon, 26
 Sep 2022 10:05:45 -0700 (PDT)
Date:   Mon, 26 Sep 2022 10:05:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dca7e505e9978943@google.com>
Subject: [syzbot] KASAN: null-ptr-deref Write in udf_write_fi
From:   syzbot <syzbot+8a5a459f324d510ea15a@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    1a61b828566f Merge tag 'char-misc-6.0-rc7' of git://git.ke..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=153836e4880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=122d7bd4fc8e0ecb
dashboard link: https://syzkaller.appspot.com/bug?extid=8a5a459f324d510ea15a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e7fb54880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14864288880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/367e34e7ff83/disk-1a61b828.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/91a2819fe451/vmlinux-1a61b828.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8a5a459f324d510ea15a@syzkaller.appspotmail.com

UDF-fs: INFO Mounting volume 'LinuxUDF', timestamp 2022/09/12 12:00 (1000)
==================================================================
BUG: KASAN: null-ptr-deref in udf_write_fi+0x380/0xff0 fs/udf/namei.c:91
Write of size 18446744073709551572 at addr 0000000000000020 by task syz-executor377/3607

CPU: 0 PID: 3607 Comm: syz-executor377 Not tainted 6.0.0-rc6-syzkaller-00309-g1a61b828566f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 kasan_report+0xb1/0x1e0 mm/kasan/report.c:495
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
 memset+0x20/0x40 mm/kasan/shadow.c:44
 udf_write_fi+0x380/0xff0 fs/udf/namei.c:91
 udf_rename+0x45e/0x1250 fs/udf/namei.c:1173
 vfs_rename+0x115e/0x1a90 fs/namei.c:4756
 do_renameat2+0xb5e/0xc80 fs/namei.c:4907
 __do_sys_rename fs/namei.c:4953 [inline]
 __se_sys_rename fs/namei.c:4951 [inline]
 __x64_sys_rename+0x7d/0xa0 fs/namei.c:4951
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f7e9cef1b69
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe69a64f88 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f7e9cef1b69
RDX: 0000000000000f90 RSI: 0000000020000880 RDI: 00000000200007c0
RBP: 00007ffe69a64f90 R08: 0000000000000002 R09: 0000000000003731
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: 00007ffe69a64ff8 R14: 00007ffe69a65030 R15: 0000000000000003
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
