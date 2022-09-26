Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0456B5E9E29
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbiIZJqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbiIZJpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:45:22 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42622640D
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:44:45 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id u9-20020a5edd49000000b006a0f03934e9so3533995iop.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:44:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=OVmYGThiIbVFpu7Nh3FHoj779XXZev1QQuPFm5XI3do=;
        b=3yaBdXImytYcgIP757I36nAh+3vsGIOz0FHXVS/fKC+NEUjMAAgewi9mmiu7gRAZ9Y
         qMKIiTZEZTE9u+6iEg8nxtxK1Of8ZiRYanDEfwrNBm4yOpYF1vwZ9eX+OYmEv4fC6Hey
         JkmH6i+mjkq3mjrpBaMTFzdazdFgM+SEf7PvRUe4oE8iOzv04hG6szZmXl5xdrQf9Kbb
         Ydmr+x8VKauMgEE8jjkrUOEuXSJkfWbbWgbY4Vq/B++JcFKn3lKGpzYCxToyfO1PbbCY
         CFSnqq53HuMSamT1NaU+V89EJlexLFVUO0NnJCVMsaAef9ShgbNSJWrwyb338gssqBcs
         GofA==
X-Gm-Message-State: ACrzQf1eKWQVHgEh+WfhCWxBhyzusgnDDKXLjthy2UnINZSKW211R1nh
        ksKG4dEcBdF8lLgGPNHr6LXEo3JdZwSEl2rSmAOXm/ZpU+KO
X-Google-Smtp-Source: AMsMyM5h9FonT8qcmfDa/rlhcFdoztwBORF9ht1QN1RhErfaf3lWCtwHJpjNbvF/Xa4tWM7FHmrXF2zLYD9vX9FI6rkaFOfXS3tQ
MIME-Version: 1.0
X-Received: by 2002:a92:ad11:0:b0:2f6:47ac:4dcc with SMTP id
 w17-20020a92ad11000000b002f647ac4dccmr9577522ilh.250.1664185484592; Mon, 26
 Sep 2022 02:44:44 -0700 (PDT)
Date:   Mon, 26 Sep 2022 02:44:44 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a6505105e9916037@google.com>
Subject: [syzbot] UBSAN: shift-out-of-bounds in extAlloc
From:   syzbot <syzbot+5f088f29593e6b4c8db8@syzkaller.appspotmail.com>
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

HEAD commit:    105a36f3694e Merge tag 'kbuild-fixes-v6.0-3' of git://git...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14b56188880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=122d7bd4fc8e0ecb
dashboard link: https://syzkaller.appspot.com/bug?extid=5f088f29593e6b4c8db8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14735cdf080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15dfcdc4880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d3172aeebe38/disk-105a36f3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/75046f57bda3/vmlinux-105a36f3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5f088f29593e6b4c8db8@syzkaller.appspotmail.com

================================================================================
UBSAN: shift-out-of-bounds in fs/jfs/jfs_extent.c:314:16
shift exponent -1 is negative
CPU: 0 PID: 3605 Comm: syz-executor226 Not tainted 6.0.0-rc6-syzkaller-00321-g105a36f3694e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 ubsan_epilogue+0xb/0x50 lib/ubsan.c:151
 __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x187 lib/ubsan.c:322
 extBalloc fs/jfs/jfs_extent.c:314 [inline]
 extAlloc.cold+0x8d/0x92 fs/jfs/jfs_extent.c:122
 jfs_get_block+0x661/0xa90 fs/jfs/inode.c:248
 __block_write_begin_int+0x3ca/0x1520 fs/buffer.c:2006
 __block_write_begin fs/buffer.c:2056 [inline]
 block_write_begin+0xb5/0x4d0 fs/buffer.c:2117
 jfs_write_begin+0x2d/0xd0 fs/jfs/inode.c:304
 generic_perform_write+0x246/0x560 mm/filemap.c:3738
 __generic_file_write_iter+0x2aa/0x4d0 mm/filemap.c:3866
 generic_file_write_iter+0xdf/0x350 mm/filemap.c:3898
 call_write_iter include/linux/fs.h:2187 [inline]
 do_iter_readv_writev+0x20b/0x3b0 fs/read_write.c:729
 do_iter_write+0x182/0x700 fs/read_write.c:855
 vfs_writev+0x1aa/0x630 fs/read_write.c:928
 do_writev+0x133/0x2f0 fs/read_write.c:971
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f61f4034f29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd1287f7a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 0000000000000016 RCX: 00007f61f4034f29
RDX: 0000000000000001 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 00007f61f3ff46f0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000f8008000
R13: 0000000000000000 R14: 00080000000000f8 R15: 0000000000000000
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
