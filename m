Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C2D61206C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 07:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiJ2FQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 01:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiJ2FPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 01:15:44 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C87D197F8B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 22:15:37 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id n8-20020a056e02100800b00300906a2170so862023ilj.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 22:15:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XgpDValt2EdMqd56AAQrMk6n+ymY9l8Unoz5hFr2HRA=;
        b=EY98A/2AnT3uDhNfV8dTVBbJG5jjKMZZssKWbLUKe92rkCW1Ht4W4pKHyQVB0Jx4ym
         J0ie0BrSOPGb/rtVDa+hcrzmmDRi/2GxTnesMRP78ruKYYEoSvOrBbZ4Y2xKvs/Q7Dez
         TL1DMM77RUIVHwOGPQxOHtDPVctq2qdkLnVWTy4OZkxb6nA4emMvjymC40rU7fhljxKf
         NJRdbZrQR50blA46Pl7BIInen9ePo0X8Of5wsaOL6hjX8lFarL4bYIXW8YAM2NuA25tn
         LfSiqjXXqhc7JZ4AK0huo7ihQHooBn2Pgyjwz1lehxG4VSZ3+WKQr+5mExwXT+55oIZE
         i5bw==
X-Gm-Message-State: ACrzQf1hEBtyq7rJpbaK0G0WVSM/2W4LESaOCifS0Zuof4HunlUlcvsY
        J0PEzszzN4XaI7Kc6fTnlFPhLc4H7VxkbBMQNZL/e0FkNsWb
X-Google-Smtp-Source: AMsMyM4kWFRzaUDVvb5yQofYywVNYUCivfrpjpdrYZag+jnb7ptI0Ze2chC7HnF8aOXWjztGQan/lc4G+B0vPOWPdjOrckL9RzE0
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3795:b0:375:cca:7024 with SMTP id
 w21-20020a056638379500b003750cca7024mr1506460jal.103.1667020536739; Fri, 28
 Oct 2022 22:15:36 -0700 (PDT)
Date:   Fri, 28 Oct 2022 22:15:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ed009f05ec257623@google.com>
Subject: [syzbot] WARNING in hugetlb_wp
From:   syzbot <syzbot+f0b97304ef90f0d0b1dc@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, mike.kravetz@oracle.com,
        nathan@kernel.org, ndesaulniers@google.com,
        songmuchun@bytedance.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
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

HEAD commit:    247f34f7b803 Linux 6.1-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14a9efd2880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a66c6c673fb555e8
dashboard link: https://syzkaller.appspot.com/bug?extid=f0b97304ef90f0d0b1dc
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=112217b4880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=105f4616880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/de212436b09b/disk-247f34f7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/63c4feda220f/vmlinux-247f34f7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f0b97304ef90f0d0b1dc@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 3612 at mm/hugetlb.c:5313 hugetlb_wp+0x20a/0x1af0 mm/hugetlb.c:5313
Modules linked in:
CPU: 1 PID: 3612 Comm: syz-executor250 Not tainted 6.1.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
RIP: 0010:hugetlb_wp+0x20a/0x1af0 mm/hugetlb.c:5313
Code: ea 03 80 3c 02 00 0f 85 31 14 00 00 49 8b 5f 20 31 ff 48 89 dd 83 e5 02 48 89 ee e8 70 ab b7 ff 48 85 ed 75 5b e8 76 ae b7 ff <0f> 0b 41 bd 40 00 00 00 e8 69 ae b7 ff 48 b8 00 00 00 00 00 fc ff
RSP: 0018:ffffc90003caf620 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000008640070 RCX: 0000000000000000
RDX: ffff88807b963a80 RSI: ffffffff81c4ed2a RDI: 0000000000000007
RBP: 0000000000000000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 000000000008c07e R12: ffff888023805800
R13: 0000000000000000 R14: ffffffff91217f38 R15: ffff88801d4b0360
FS:  0000555555bba300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff7a47a1b8 CR3: 000000002378d000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 hugetlb_no_page mm/hugetlb.c:5755 [inline]
 hugetlb_fault+0x19cc/0x2060 mm/hugetlb.c:5874
 follow_hugetlb_page+0x3f3/0x1850 mm/hugetlb.c:6301
 __get_user_pages+0x2cb/0xf10 mm/gup.c:1202
 __get_user_pages_locked mm/gup.c:1434 [inline]
 __get_user_pages_remote+0x18f/0x830 mm/gup.c:2187
 get_user_pages_remote+0x84/0xc0 mm/gup.c:2260
 __access_remote_vm+0x287/0x6b0 mm/memory.c:5517
 ptrace_access_vm+0x181/0x1d0 kernel/ptrace.c:61
 generic_ptrace_pokedata kernel/ptrace.c:1323 [inline]
 ptrace_request+0xb46/0x10c0 kernel/ptrace.c:1046
 arch_ptrace+0x36/0x510 arch/x86/kernel/ptrace.c:828
 __do_sys_ptrace kernel/ptrace.c:1296 [inline]
 __se_sys_ptrace kernel/ptrace.c:1269 [inline]
 __x64_sys_ptrace+0x178/0x2a0 kernel/ptrace.c:1269
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f7f4b262d89
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff7a47a1b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000065
RAX: ffffffffffffffda RBX: 000000000000ab32 RCX: 00007f7f4b262d89
RDX: 00000000200000c0 RSI: 0000000000000e1d RDI: 0000000000000005
RBP: 0000000000000000 R08: 00007fff7a47a358 R09: 00007fff7a47a358
R10: 00000000000003ff R11: 0000000000000246 R12: 00007fff7a47a1cc
R13: 431bde82d7b634db R14: 0000000000000000 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
