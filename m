Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023D05EAE58
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 19:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbiIZRkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 13:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiIZRkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:40:11 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83D58A7C6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:05:46 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id j20-20020a6b3114000000b006a3211a0ff0so4177257ioa.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:05:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=FgsGKmgnAiNMm0Kfl6ghAURyWLdkaZIxUE7N6+di98I=;
        b=1MQNTRvFJw60DKikKg39xcUNhCq7Y5lGTjf2GcthevQ/oMnrragWvWHKzNJ5P6bur+
         glVxOrrq2sdnL3wojPCoKE0u4aqWOrvENi3k8DjNRPMs/xX9EXT5meez2QmcvycE/k9w
         OhySkz2JA76Tl41muLJ3hGWH2Q7JDJMyp/ahUoG5inOieNds2G6dsLFYbl8pj5Y8+LTP
         RNDnTp9ZfaI5BQDmZhC+Uh/+Qb8GJFHXylk6G2IIm1A3VQPlarI9k/NJyTrembn3JQvV
         BicZW+Rf2fywE26b9DHyzjeSjttPcS4LWVTsI0B0hNwk4dAY39wC7ycz/i/0Ift/DqL1
         TqEw==
X-Gm-Message-State: ACrzQf2YaFDz99f6huAR+PG8lWsfWB//r4HovizXxGLnmCajqIAOYpUq
        +m5lpwMdG1cIp78lUjvIJsZyMmhCljcxPsk2gzAvGBVFLZX9
X-Google-Smtp-Source: AMsMyM79ssbhgnRU1umH1MBFsMRKsVYHsHbcSz6KzN63rR7iErYQAlzZFSw84cJl/Yul5nyPLKpALak9XaLMay9duUPc9gbYffKk
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2726:b0:35b:18bc:b6dc with SMTP id
 m38-20020a056638272600b0035b18bcb6dcmr11726609jav.284.1664211946066; Mon, 26
 Sep 2022 10:05:46 -0700 (PDT)
Date:   Mon, 26 Sep 2022 10:05:46 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e05bc805e99789e1@google.com>
Subject: [syzbot] kernel BUG in __ntfs_grab_cache_pages
From:   syzbot <syzbot+01b3ade7c86f7dd584d7@syzkaller.appspotmail.com>
To:     anton@tuxera.com, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net,
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

HEAD commit:    c194837ebb57 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=138cb7f8880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=15a770deac0c935a
dashboard link: https://syzkaller.appspot.com/bug?extid=01b3ade7c86f7dd584d7
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d1d188880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1472a6ef080000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8d8ae425e7fa/disk-c194837e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c540d501ebe7/vmlinux-c194837e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+01b3ade7c86f7dd584d7@syzkaller.appspotmail.com

 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190
------------[ cut here ]------------
kernel BUG at fs/ntfs/file.c:493!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 3045 Comm: syz-executor202 Not tainted 6.0.0-rc6-syzkaller-17742-gc194837ebb57 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __ntfs_grab_cache_pages+0x30c/0x328 fs/ntfs/file.c:493
lr : __ntfs_grab_cache_pages+0x30c/0x328 fs/ntfs/file.c:493
sp : ffff80000fb5baa0
x29: ffff80000fb5baa0 x28: ffff0000caa2ec80 x27: ffff80000fb5bb70
x26: 00000000ffffffff x25: ffff0000caa2f1c8 x24: 0000000000000000
x23: 0000000000000000 x22: ffff80000fb5bb68 x21: ffff0000caa2ec80
x20: 0000000000000000 x19: ffff80000fb5bb70 x18: 00000000000000c0
x17: ffff80000dd0b198 x16: ffff80000db49158 x15: ffff0000c47b1a80
x14: 0000000000000030 x13: 00000000ffffffff x12: ffff0000c47b1a80
x11: ff80800008b9dcb0 x10: 0000000000000000 x9 : ffff800008b9dcb0
x8 : ffff0000c47b1a80 x7 : ffff80000846b9dc x6 : 0000000000000000
x5 : 0000000000000000 x4 : ffff80000fb5bb68 x3 : ffff80000fb5bb70
x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 __ntfs_grab_cache_pages+0x30c/0x328 fs/ntfs/file.c:493
 ntfs_perform_write+0x224/0xa98 fs/ntfs/file.c:1833
 ntfs_file_write_iter+0x2c4/0x4f0 fs/ntfs/file.c:1917
 call_write_iter include/linux/fs.h:2187 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x2dc/0x46c fs/read_write.c:578
 ksys_write+0xb4/0x160 fs/read_write.c:631
 __do_sys_write fs/read_write.c:643 [inline]
 __se_sys_write fs/read_write.c:640 [inline]
 __arm64_sys_write+0x24/0x34 fs/read_write.c:640
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190
Code: 17ffff88 97dc0a06 17ffff86 97dc0a04 (d4210000) 
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
