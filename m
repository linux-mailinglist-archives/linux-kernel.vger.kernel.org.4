Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1066E655C58
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 05:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiLYEPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 23:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLYEPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 23:15:41 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5030E627D
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 20:15:40 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id r6-20020a92cd86000000b00304b2d1c2d7so5026199ilb.11
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 20:15:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jBv6qMn0Q8Dl71cbSpzu2RcbE7SvwqPK+R5Wa2eEOs8=;
        b=rAEgd0Wpqr71HG6ZO5GCONaGuLeIW/VKabw8H3cP8D9r6ySxFZ4bzfNAz9ndMJFG0g
         ciYHMyIvuJnZq2K9o3sL7NaNpnIah58y4W5HSJauCctUBCKl4NihHoCgTC78jISxukIj
         3mhGtxQeQodYlTDj3rDgAnYX3mQWu3O7JeWQg3Wo3SShWA8IeSLp9pA0Y4d+Fkivpg9E
         jxvpBEV3ubtke3h9ttzlg0qXfgk60yCWGLhhzj+Aiwi8hHwvZwbhtSp6McLv9xzXFudU
         4SzPptsgjDD8ovSWs4Wbix1WZCn89Kfp+wcLiwK4GMCUWFIqUGaMFBGEaG3Y+YgFsldb
         aeoQ==
X-Gm-Message-State: AFqh2kqUUUyK/+tAM4NTTK1MKz5QQ7ksMblAXKQ95lvUKTphn01Wl/gQ
        75sGBaUmtJddsCWtuFpMfzJ32yvYhcEUiXjRc+WOPeW3tcmy
X-Google-Smtp-Source: AMrXdXs6LRrSjpilEjLCwyJXt4e6dV3/cn4NfxsY60uxqiKEUYdWN+gkRVOeYeafVCbgiRV/UbT24Xb1GAqcyO+ffcrMP62CdAnk
MIME-Version: 1.0
X-Received: by 2002:a02:c6d3:0:b0:38a:3dbb:1f90 with SMTP id
 r19-20020a02c6d3000000b0038a3dbb1f90mr1358464jan.94.1671941739633; Sat, 24
 Dec 2022 20:15:39 -0800 (PST)
Date:   Sat, 24 Dec 2022 20:15:39 -0800
In-Reply-To: <000000000000459c6205ea318e35@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000079e17b05f09f4571@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in xtSearch
From:   syzbot <syzbot+76a072c2f8a60280bd70@syzkaller.appspotmail.com>
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

HEAD commit:    72a85e2b0a1e Merge tag 'spi-fix-v6.2-rc1' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16d22974480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e2d7bfa2d6d5a76
dashboard link: https://syzkaller.appspot.com/bug?extid=76a072c2f8a60280bd70
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15802088480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/510d16df06c8/disk-72a85e2b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/50ef5477a1d4/vmlinux-72a85e2b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f2acd6f1189a/bzImage-72a85e2b.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/5e378294b8d6/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+76a072c2f8a60280bd70@syzkaller.appspotmail.com

================================================================================
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_xtree.c:360:4
index 19 is out of range for type 'xad_t [18]'
CPU: 1 PID: 5414 Comm: syz-executor.0 Not tainted 6.1.0-syzkaller-14594-g72a85e2b0a1e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_out_of_bounds+0xe0/0x110 lib/ubsan.c:282
 xtSearch+0x709/0x1cb0 fs/jfs/jfs_xtree.c:360
 xtLookup+0x235/0x880 fs/jfs/jfs_xtree.c:152
 extHint+0x204/0x630 fs/jfs/jfs_extent.c:215
 jfs_get_block+0x2e3/0xce0 fs/jfs/inode.c:246
 get_more_blocks fs/direct-io.c:665 [inline]
 do_direct_IO fs/direct-io.c:953 [inline]
 __blockdev_direct_IO+0x1737/0x3bf0 fs/direct-io.c:1266
 blockdev_direct_IO include/linux/fs.h:3213 [inline]
 jfs_direct_IO+0xf6/0x1e0 fs/jfs/inode.c:331
 generic_file_direct_write+0x294/0x610 mm/filemap.c:3696
 __generic_file_write_iter+0x1c4/0x400 mm/filemap.c:3856
 generic_file_write_iter+0xab/0x310 mm/filemap.c:3932
 do_iter_write+0x6c2/0xc20 fs/read_write.c:861
 iter_file_splice_write+0x7fc/0xfc0 fs/splice.c:686
 do_splice_from fs/splice.c:764 [inline]
 direct_splice_actor+0xe6/0x1c0 fs/splice.c:931
 splice_direct_to_actor+0x4e4/0xc00 fs/splice.c:886
 do_splice_direct+0x279/0x3d0 fs/splice.c:974
 do_sendfile+0x5fb/0xf80 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 __se_sys_sendfile64+0x14f/0x1b0 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f9065c8c0a9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f90669ab168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f9065dac050 RCX: 00007f9065c8c0a9
RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000007
RBP: 00007f9065ce7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 000080001d00c0d0 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe07df477f R14: 00007f90669ab300 R15: 0000000000022000
 </TASK>
================================================================================

