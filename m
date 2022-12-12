Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C8A649920
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 08:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbiLLHCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 02:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiLLHB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 02:01:57 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068DABF47
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 23:01:56 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id s1-20020a056e021a0100b003026adad6a9so4618464ild.18
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 23:01:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iJobm6A9HB39E5YwY9AR8u4OqB6O5B/ZShprtKCSEJE=;
        b=t3qeyI4BWQrBEaxGJj2v4SW2FaXjQLu3C+NxAMJYvzTjz9NR2uoY+Bqq5BycvtVy0x
         99ATe+HW1cyectBT8s4fcYjKi2RGohpqZ4QC4hxVaKk+Tut0BuKJ80vsRoG8zJZb9Qt+
         ZqUwviL6m5iX2U2KdM7hTn6jBvv6Xs9COl9V6TChJmqftrHMUUd0wGXifK4vw+YkJS78
         M0GJayGMLc1gwsIKVV0vOpM7CvWUlwtL3+zDG+Hr5FI2rBVL+yCGRev6ZP8TGXJaMxkW
         daQrfU1E9OtZpRoNMUSypRSOzOcYm++Tju/zKwPY0evsS8YKpxdviBTMtpTSBQtYuxNy
         /1Jw==
X-Gm-Message-State: ANoB5pk98VWaHx/lL5/2k076HHftyg1Vl1r5ucGWI/2T0ZOm/GXgo25w
        8uJmlum7lMUXas7jAVNPkYgxr21Zsi6yY27LC0sGDQpT9pfA
X-Google-Smtp-Source: AA0mqf6Kisa8uab80mIczxrSWkzAMrMxQ8kVuWS1Vn0KUgNR4XdeVcmZ7rhZPBrJXsMJZ+Fy9wxzeIpibQPASbQ2pqktRSonOFPz
MIME-Version: 1.0
X-Received: by 2002:a92:d590:0:b0:303:4c6:dd96 with SMTP id
 a16-20020a92d590000000b0030304c6dd96mr26194532iln.246.1670828515385; Sun, 11
 Dec 2022 23:01:55 -0800 (PST)
Date:   Sun, 11 Dec 2022 23:01:55 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000023e98b05ef9c14c5@google.com>
Subject: [syzbot] BUG: unable to handle kernel paging request in current_time
From:   syzbot <syzbot+6f1094dbac66f87b75e5@syzkaller.appspotmail.com>
To:     damien.lemoal@opensource.wdc.com, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
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

HEAD commit:    a5541c0811a0 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=13f3872f880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbd4e584773e9397
dashboard link: https://syzkaller.appspot.com/bug?extid=6f1094dbac66f87b75e5
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13918e67880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10870133880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4b7702208fb9/disk-a5541c08.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ec0153ec051/vmlinux-a5541c08.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6f8725ad290a/Image-a5541c08.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/31a0c6469932/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6f1094dbac66f87b75e5@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 64
Unable to handle kernel paging request at virtual address 003f1d3fea3fdfc7
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004
  CM = 0, WnR = 0
[003f1d3fea3fdfc7] address between user and kernel address ranges
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 3072 Comm: syz-executor332 Not tainted 6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : timestamp_truncate fs/inode.c:2448 [inline]
pc : current_time+0x48/0x18c fs/inode.c:2486
lr : current_time+0x3c/0x18c fs/inode.c:2479
sp : ffff80000ff7ba40
x29: ffff80000ff7ba60 x28: 0000000000000040 x27: ffff0000c6c47618
x26: ffff0000ca57ec30 x25: 0000000000000000 x24: ffff0000cb410d58
x23: d93f1d3fea3fd93f x22: ffff0000cb410d58 x21: 0000000000008000
x20: 000000000000002b x19: 0000000007270e00 x18: 0000000000000000
x17: 0000000000000000 x16: ffff80000dbe6158 x15: ffff0000c61e3480
x14: 0000000000000008 x13: 0000000000000000 x12: ffff0000c61e3480
x11: ff808000082263ec x10: 0000000000000000 x9 : ffff8000082263ec
x8 : ffff0000c61e3480 x7 : ffff8000085febdc x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000006 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 current_time+0x48/0x18c fs/inode.c:2486
 hfs_new_inode+0xdc/0x304 fs/hfs/inode.c:203
 hfs_create+0x38/0xc8 fs/hfs/dir.c:198
 lookup_open fs/namei.c:3413 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x804/0x11c4 fs/namei.c:3711
 do_filp_open+0xdc/0x1b8 fs/namei.c:3741
 do_sys_openat2+0xb8/0x22c fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __arm64_sys_openat+0xb0/0xe0 fs/open.c:1337
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
Code: 97f09d9d f9401677 b4000917 a940cff4 (f94346f6) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	97f09d9d 	bl	0xffffffffffc27674
   4:	f9401677 	ldr	x23, [x19, #40]
   8:	b4000917 	cbz	x23, 0x128
   c:	a940cff4 	ldp	x20, x19, [sp, #8]
* 10:	f94346f6 	ldr	x22, [x23, #1672] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
