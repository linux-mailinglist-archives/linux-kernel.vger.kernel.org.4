Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF0365F422
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbjAETNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjAETM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:12:57 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF05360CCE
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:12:56 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id n15-20020a056e021baf00b0030387c2e1d3so23197868ili.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 11:12:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=piCnIGXhXOnYV1hmjsRPMyKFWfqmILLLm5+CjusFvYg=;
        b=lkdSeh5pfkbQKixjyuj/CBlkcX+GR0Ka2gOapwk+2aVMXmZ1FuL2lfly4qrhXkRnN5
         1uEDAOoSQnVauZjpltj4HBgoA616AncnzSFK6iyG4gIzgg5q7GbeLFMuF32rBkMEUbOI
         NFSd11iu1E1MglZfT9PdB+x8c3Vz6lqhxC0tulf7HShpvlTLfqnA7zED4Taec4nsh5ox
         3jkt4/I/AVqtn16T4C9c5yF8qEQWiRas5WpBInnD+P/KSVa5pJERWZS3+HMhqprvWTpN
         wqvtkJClwcFeX1Wv/DfIoXN1KDlQYNNQn/EZ4xZxpsMrChHXmRyxiO2PwQY9rhUUp9/l
         QLxg==
X-Gm-Message-State: AFqh2kpIHjz20D6iAoe5gyGAG4ETs8lkJbDn+TThZhbar7KZYdfnX1bj
        IBqtzUZrCXdBfVgrPmjntvlFGEce5+vqx+Tbqvx1LzT1Ghem
X-Google-Smtp-Source: AMrXdXtYjImq2UDlySiZ+1mq7rYAR8WXEtlmn2w932wLCzvukrwRtb+QpcE3YxGOG1UJBFvedvoSlEae34BEBwbWl8hjCyZSlKk8
MIME-Version: 1.0
X-Received: by 2002:a02:b608:0:b0:39e:536f:e5db with SMTP id
 h8-20020a02b608000000b0039e536fe5dbmr192883jam.50.1672945976178; Thu, 05 Jan
 2023 11:12:56 -0800 (PST)
Date:   Thu, 05 Jan 2023 11:12:56 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a3818b05f18916e0@google.com>
Subject: [syzbot] [reiserfs?] [jfs?] BUG: unable to handle kernel paging
 request in reiserfs_readdir_inode
From:   syzbot <syzbot+3f6ef04b7cf85153b528@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, shaggy@kernel.org,
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

HEAD commit:    247f34f7b803 Linux 6.1-rc2
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=15de909a480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa9bed8d6a8992a0
dashboard link: https://syzkaller.appspot.com/bug?extid=3f6ef04b7cf85153b528
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=100896ec480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/05f9a7fca332/disk-247f34f7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ec50c3ad7d48/vmlinux-247f34f7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1446f94b11ed/Image-247f34f7.gz.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/b331beed692c/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/980b2ce32188/mount_1.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3f6ef04b7cf85153b528@syzkaller.appspotmail.com

REISERFS (device loop0): Using rupasov hash to sort names
REISERFS warning (device loop0): jdm-20006 create_privroot: xattrs/ACLs enabled and couldn't find/create .reiserfs_priv. Failing mount.
loop0: detected capacity change from 0 to 32768
Unable to handle kernel paging request at virtual address ffff00001a06e183
Mem abort info:
  ESR = 0x0000000096000021
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x21: alignment fault
Data abort info:
  ISV = 0, ISS = 0x00000021
  CM = 0, WnR = 0
swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000001c54db000
[ffff00001a06e183] pgd=180000023fff8003, p4d=180000023fff8003, pud=180000023fff7003, pmd=180000023ff26003, pte=006800005a06e707
Internal error: Oops: 0000000096000021 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 3121 Comm: syz-executor.0 Not tainted 6.1.0-rc2-syzkaller-154433-g247f34f7b803 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __lse__cmpxchg_case_mb_64 arch/arm64/include/asm/atomic_lse.h:287 [inline]
pc : __cmpxchg_case_mb_64 arch/arm64/include/asm/cmpxchg.h:130 [inline]
pc : __cmpxchg_mb arch/arm64/include/asm/cmpxchg.h:175 [inline]
pc : osq_lock+0x110/0x1f8 kernel/locking/osq_lock.c:162
lr : osq_lock+0x38/0x1f8 kernel/locking/osq_lock.c:94
sp : ffff80001305b980
x29: ffff80001305b980 x28: ffff80000eec9000 x27: ffff80000cbb6d47
x26: 0000000000000000 x25: ffff800008774160 x24: ffff0000cbd3ce90
x23: ffff80000879e1b8 x22: ffff80000d2e2c40 x21: ffff00001a06e183
x20: ffff0001fefd0c40 x19: ffff0000cbd3ce70 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000000 x10: ffff0001fefd0c50 x9 : 0000000000000002
x8 : ffff0001fefd0c40 x7 : 0000000000000000 x6 : ffff80000879e1b8
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : ffff0001fefd0c40 x0 : ffff00001a06e183
Call trace:
 __lse__cmpxchg_case_mb_64 arch/arm64/include/asm/atomic_lse.h:287 [inline]
 __cmpxchg_case_mb_64 arch/arm64/include/asm/cmpxchg.h:130 [inline]
 __cmpxchg_mb arch/arm64/include/asm/cmpxchg.h:175 [inline]
 osq_lock+0x110/0x1f8 kernel/locking/osq_lock.c:162
 mutex_optimistic_spin+0x1dc/0x254 kernel/locking/mutex.c:460
 __mutex_lock_common+0x1b4/0xca8 kernel/locking/mutex.c:607
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x38/0x44 kernel/locking/mutex.c:799
 reiserfs_write_lock+0x3c/0x64 fs/reiserfs/lock.c:27
 reiserfs_readdir_inode+0x9c/0x684 fs/reiserfs/dir.c:79
 reiserfs_readdir+0x28/0x38 fs/reiserfs/dir.c:274
 iterate_dir+0x114/0x28c
 __do_sys_getdents64 fs/readdir.c:369 [inline]
 __se_sys_getdents64 fs/readdir.c:354 [inline]
 __arm64_sys_getdents64+0x80/0x204 fs/readdir.c:354
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
Code: aa1503e0 aa1403e1 aa1f03e2 aa0103e8 (c8e8fea2) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	aa1503e0 	mov	x0, x21
   4:	aa1403e1 	mov	x1, x20
   8:	aa1f03e2 	mov	x2, xzr
   c:	aa0103e8 	mov	x8, x1
* 10:	c8e8fea2 	casal	x8, x2, [x21] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
