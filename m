Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5C1626DB9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 05:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbiKMElh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 23:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiKMEld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 23:41:33 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229352AC4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 20:41:31 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id bf14-20020a056602368e00b006ce86e80414so4942428iob.7
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 20:41:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JCmmCOdzlmfwzQylD4rljRorlQqON5Ffe1mymoH25K0=;
        b=cUrzqCNyqEK5iXPu2hhcRgQqWwQikaW+fs7XugMC3ixQ5hw9uiBRxjAvdRwBKUBe3Z
         wkJ6/5yDuFktecd9xfBqO88YLqC5aBawOvyhlhMy2mb3SIaECcF//fdhvZ5oLDdUX1T9
         RaMBlNvRuyr82qEquwNiV1NgabdqiGqHqAf7bqrXjJZAE0tagAXY12bQej2L0YnroGV2
         +R6/45Z2Zpp07blVsxKGq07OqYl/DMDT+G9xqErqjMRhR7U3H8a0mcKG5U3W20PUTllj
         +FAPKdbciZrUHKmlk6s0lK4/0IszIKvj4DHXGUYTyarRmm8RJXU/8a6wbMUoVga8+F0w
         /V6A==
X-Gm-Message-State: ANoB5plgsBMSvHsWSeg0o1xl5viXCjnXA+H+onfjbS8pXKlVfx+NLbuE
        ywEMYj5cPHNR5eFm3VQnS8Dy9LiuzWMFHgxyxQDmdLNT5vpu
X-Google-Smtp-Source: AA0mqf4JMUBUpLWarmw02WB5HQRb1bN2Im7C3kzfV6BSWVBN5A4+bhOMBW3aIC1pZwr/agqy5EirbBRJHO0rbFLN/9TIB7v9w630
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1b07:b0:372:f7ed:9f78 with SMTP id
 cb7-20020a0566381b0700b00372f7ed9f78mr3624603jab.245.1668314490457; Sat, 12
 Nov 2022 20:41:30 -0800 (PST)
Date:   Sat, 12 Nov 2022 20:41:30 -0800
In-Reply-To: <20221113031619.1536-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000093d5d005ed52bc0c@google.com>
Subject: Re: [syzbot] WARNING: locking bug in hugetlb_no_page
From:   syzbot <syzbot+d07c65298d2c15eafcb0@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: unable to handle kernel paging request in hugetlb_no_page

Unable to handle kernel paging request at virtual address 1fff800003441a18
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
[1fff800003441a18] address between user and kernel address ranges
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 4269 Comm: syz-executor.2 Not tainted 6.1.0-rc4-syzkaller-00039-g1621b6eaebf7-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : generic_test_bit include/asm-generic/bitops/generic-non-atomic.h:128 [inline]
pc : __lock_acquire+0x654/0x3084 kernel/locking/lockdep.c:5025
lr : mark_usage kernel/locking/lockdep.c:4555 [inline]
lr : __lock_acquire+0x630/0x3084 kernel/locking/lockdep.c:5009
sp : ffff8000131033d0
x29: ffff8000131034b0 x28: 0000000000000001 x27: ffff0000d2c89a68
x26: ffff0000d2c8a450 x25: ffff0000d2c8a470 x24: ffff0000d2c8a470
x23: 00000000000000c0 x22: 0000000000000001 x21: 0000000000000000
x20: ffff0000d2c89a40 x19: 555554aaabb2c422 x18: 00000000000000c0
x17: ffff80000dcdc198 x16: ffff80000db1a158 x15: ffff0000d2c89a40
x14: 0000000000000018 x13: ffff80000819fba0 x12: 00000000c73c5909
x11: ff808000095f17a4 x10: ffff80000dcdc198 x9 : 1ffffffff5765880
x8 : 0000000000000000 x7 : 0000000000000000 x6 : ffff80000801154c
x5 : 4c1501080080ffff x4 : ffff80000801154c x3 : 4c1501080080ffff
x2 : fffffffffffffff8 x1 : ffff80000cc75907 x0 : 0000000000000001
Call trace:
 generic_test_bit include/asm-generic/bitops/generic-non-atomic.h:128 [inline]
 __lock_acquire+0x654/0x3084 kernel/locking/lockdep.c:5025
 reacquire_held_locks+0x120/0x1c0 kernel/locking/lockdep.c:5193
 __lock_release kernel/locking/lockdep.c:5382 [inline]
 lock_release+0x148/0x2b4 kernel/locking/lockdep.c:5688
 __mutex_unlock_slowpath+0x44/0x1cc kernel/locking/mutex.c:907
 mutex_unlock+0x24/0x30 kernel/locking/mutex.c:543
 hugetlb_no_page+0x298/0xe38 mm/hugetlb.c:5772
 hugetlb_fault+0x3d0/0xe30 mm/hugetlb.c:5877
 handle_mm_fault+0x904/0xa48 mm/memory.c:5216
 __do_page_fault arch/arm64/mm/fault.c:506 [inline]
 do_page_fault+0x428/0x79c arch/arm64/mm/fault.c:606
 do_translation_fault+0x78/0x194 arch/arm64/mm/fault.c:689
 do_mem_abort+0x54/0x130 arch/arm64/mm/fault.c:825
 el1_abort+0x3c/0x5c arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0x60/0xac arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:579
 __arch_copy_from_user+0x1bc/0x1f4 arch/arm64/lib/copy_from_user.S:214
 __import_iovec+0x60/0x248 lib/iov_iter.c:1773
 import_iovec+0x6c/0x88 lib/iov_iter.c:1838
 vfs_writev fs/read_write.c:931 [inline]
 do_writev+0xf8/0x234 fs/read_write.c:977
 __do_sys_writev fs/read_write.c:1050 [inline]
 __se_sys_writev fs/read_write.c:1047 [inline]
 __arm64_sys_writev+0x28/0x38 fs/read_write.c:1047
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
Code: 350000e8 93407e69 d343fd29 927de529 (f8696949) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	350000e8 	cbnz	w8, 0x1c
   4:	93407e69 	sxtw	x9, w19
   8:	d343fd29 	lsr	x9, x9, #3
   c:	927de529 	and	x9, x9, #0x1ffffffffffffff8
* 10:	f8696949 	ldr	x9, [x10, x9] <-- trapping instruction


Tested on:

commit:         1621b6ea Merge branch 'for-next/fixes' into for-kernelci
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12018ac1880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=606e57fd25c5c6cc
dashboard link: https://syzkaller.appspot.com/bug?extid=d07c65298d2c15eafcb0
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12eb8b71880000

