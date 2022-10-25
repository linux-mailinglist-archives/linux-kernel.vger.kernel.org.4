Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E481060D2D3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 19:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbiJYRyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 13:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbiJYRyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 13:54:45 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E63193FF
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 10:54:40 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id b7-20020a92c567000000b002fb9207838bso11643066ilj.23
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 10:54:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vwHXjbhutL7a6YaighTokFNLdwjSrZnOy4BnNjzimdM=;
        b=TfSBAcZOgtOYSicT3hfk8MTb3pewY1lvKoKAqaAn9vy78rJLca3J1bWoZIsccXJW18
         YbaI+cPICpr7+wjlK1liryCLe7IEui8evyN76C+T6U3aiaJX42Dz5JJjFK8c72lwYmgv
         EKYqXWgAyZ2/f0KkYUiu5DI66nW7Y2sgN2koz23vEDiMpzCYmslHxQOX2qDFPaCJ3R2H
         FcPyCbhUG1vPjsw8GdBvn04E87y5NcExJPRj2ioBYrlMv97t99nf3p3ty+Whe9IIRKcv
         gJEdRVuvyFQdgwrvIrYqACXlg0lVIdsii+SjhD7hmVcDovbuz1up4BGKEQRAGlz3rYVd
         l1zw==
X-Gm-Message-State: ACrzQf1j+9Bz8i1pVpMPMfa9ZdF8A5Xe6LwmOGvr9ToIl7VBNYiIFdTO
        TGtX2scbY+7bhRwjfE/UklaxgAR216FRH//YI8ovWPiKwNBx
X-Google-Smtp-Source: AMsMyM6FiX21BrF6HEjMggVfjfXSIcSTwrZr+kHfFI/tbRjry3myG4A5pcmSLz8gqZTsPpB5ZcXK0Gd2jG8vaVU+uBbQAfDWTibO
MIME-Version: 1.0
X-Received: by 2002:a5e:9e0a:0:b0:6c0:dbd0:cfac with SMTP id
 i10-20020a5e9e0a000000b006c0dbd0cfacmr1075436ioq.106.1666720479732; Tue, 25
 Oct 2022 10:54:39 -0700 (PDT)
Date:   Tue, 25 Oct 2022 10:54:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000226f6d05ebdf9ab7@google.com>
Subject: [syzbot] UBSAN: shift-out-of-bounds in nilfs_load_super_block
From:   syzbot <syzbot+e91619dd4c11c4960706@syzkaller.appspotmail.com>
To:     konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org,
        linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    337a0a0b63f1 Merge tag 'net-6.1-rc3-1' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1002c326880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d3548a4365ba17d
dashboard link: https://syzkaller.appspot.com/bug?extid=e91619dd4c11c4960706
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1141be22880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=114e6a22880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c011f7e4e764/disk-337a0a0b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d019c4ed2ed2/vmlinux-337a0a0b.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c3f2dcdec39e/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e91619dd4c11c4960706@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 4192
================================================================================
UBSAN: shift-out-of-bounds in fs/nilfs2/the_nilfs.c:449:46
shift exponent 38983 is too large for 64-bit type 'unsigned long long'
CPU: 0 PID: 3611 Comm: syz-executor485 Not tainted 6.1.0-rc2-syzkaller-00061-g337a0a0b63f1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_shift_out_of_bounds+0x33d/0x3b0 lib/ubsan.c:322
 nilfs_sb2_bad_offset fs/nilfs2/the_nilfs.c:449 [inline]
 nilfs_load_super_block+0xdf5/0xe00 fs/nilfs2/the_nilfs.c:523
 init_nilfs+0xb7/0x7d0 fs/nilfs2/the_nilfs.c:577
 nilfs_fill_super+0xb1/0x5d0 fs/nilfs2/super.c:1047
 nilfs_mount+0x613/0x9b0 fs/nilfs2/super.c:1317
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x88/0x270 fs/super.c:1530
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f6d8986065a
Code: 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff429054d8 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f6d8986065a
RDX: 00000000200000c0 RSI: 0000000020000100 RDI: 00007fff429054f0
RBP: 00007fff429054f0 R08: 00007fff42905530 R09: 00005555561872c0
R10: 0000000000010400 R11: 0000000000000286 R12: 0000000000000004
R13: 00007fff42905530 R14: 000000000000003a R15: 0000000020000770
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
