Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79456646145
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 19:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiLGSrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 13:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiLGSro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 13:47:44 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFAC1836F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 10:47:42 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id k6-20020a92c246000000b003035797fa8cso8583574ilo.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 10:47:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rs71y7QKLfj2uRinZF+lNM9YoVBsWdlmF+pf7glxx8M=;
        b=Hm9UhgcZKJqoNg0+m6sPC0tQsI9FIxaNyggLCcAlTAnWvwWkBYFbYCpBIYloHWTsGN
         lOhplapLhyh4PW7QbRcfhbsQEBrfhjG7jsAA0HMxphA2/u2ENrGiIf+8yHRTGznR+SRu
         tvZn30SFhWZSc7KEuWgwb7g5EnuZXhJRKe583NnO589BL3mzP7Gk5lJY44mM+vQxE7I2
         uEfQPiemvnONnK7ff0hYyFj0muc+gryuahy0k6d7qyNOEi8IeaT3Gd3R3Aw0B5SWTMCX
         XpEsvmC+ScJKuayg/lDRIqnv/aeq/ln/jY2gZ44/ZlROczUIrbpiJZnIG7COgR8VHP7I
         /xuw==
X-Gm-Message-State: ANoB5pmNStrq3a3zlrhAzAb3xo5KouPm9lVghkO/rhuZqXzjZCc/5FB8
        xj2fSVZ8K8dyXDdalL9n/4QgXVbQSWEypcE4hcK61icrUKlq
X-Google-Smtp-Source: AA0mqf7xiGmR9GF+wcN28IhT5wJKt39Ua3ry32LEpi0/eu0G3HVI5DMU133w3SFKp5MLw2fWDNCwI3iCWoUuSTyohVhnQJBMvSDc
MIME-Version: 1.0
X-Received: by 2002:a6b:f015:0:b0:6e2:bed4:c2d5 with SMTP id
 w21-20020a6bf015000000b006e2bed4c2d5mr1409593ioc.177.1670438862091; Wed, 07
 Dec 2022 10:47:42 -0800 (PST)
Date:   Wed, 07 Dec 2022 10:47:42 -0800
In-Reply-To: <000000000000a078ac05ed65eb00@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fe7bd605ef415ab2@google.com>
Subject: Re: [syzbot] UBSAN: array-index-out-of-bounds in xtTruncate
From:   syzbot <syzbot+75c177aa1291e7fe423d@syzkaller.appspotmail.com>
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    8ed710da2873 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13629e23880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d58e7fe7f9cf5e24
dashboard link: https://syzkaller.appspot.com/bug?extid=75c177aa1291e7fe423d
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f7a51d880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/001d14ca1b9a/disk-8ed710da.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/97699f90e9af/vmlinux-8ed710da.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2d0dbab75d43/bzImage-8ed710da.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/ce0ea7b966d5/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+75c177aa1291e7fe423d@syzkaller.appspotmail.com

================================================================================
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_xtree.c:2304:9
index 19 is out of range for type 'xad_t [18]'
CPU: 1 PID: 4024 Comm: syz-executor.2 Not tainted 6.1.0-rc8-syzkaller-00014-g8ed710da2873 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_out_of_bounds+0xdb/0x130 lib/ubsan.c:283
 xtTruncate+0x2778/0x32d0 fs/jfs/jfs_xtree.c:2304
 jfs_truncate_nolock+0x192/0x390 fs/jfs/inode.c:393
 jfs_truncate+0xc6/0x140 fs/jfs/inode.c:417
 jfs_setattr+0x59f/0x7d0 fs/jfs/file.c:119
 notify_change+0xe38/0x10f0 fs/attr.c:420
 do_truncate+0x1fb/0x2e0 fs/open.c:65
 handle_truncate fs/namei.c:3216 [inline]
 do_open fs/namei.c:3561 [inline]
 path_openat+0x2770/0x2df0 fs/namei.c:3714
 do_filp_open+0x264/0x4f0 fs/namei.c:3741
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_open fs/open.c:1334 [inline]
 __se_sys_open fs/open.c:1330 [inline]
 __x64_sys_open+0x221/0x270 fs/open.c:1330
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fad9288c0d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fad93556168 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007fad929ac1f0 RCX: 00007fad9288c0d9
RDX: 0000000000000000 RSI: 000000000014d27e RDI: 0000000020000180
RBP: 00007fad928e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffcbcc0bcff R14: 00007fad93556300 R15: 0000000000022000
 </TASK>
================================================================================

