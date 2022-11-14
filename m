Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D982C6274E4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 04:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbiKNDWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 22:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233930AbiKNDWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 22:22:41 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595AC12D34
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 19:22:40 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id c23-20020a6b4e17000000b006db1063fc9aso5266502iob.14
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 19:22:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Ypykk4Ob4ZHbeObYvlloVCtbmMGAxhXnkE7CLVWWHk=;
        b=uOdmw0Ege//ZdSu8NN9N+CVuY1YyCZShshGGR9mY6DBSahO7QVezqb3NGZAFCu6FrI
         Nsvqp3PhjByi7NMu1RXXfzWUFkv1JTFIKu+5R4Sm1kBvJUIJ/jHNe2O2rql9JeYW9MHo
         nrpWIjgIPKwrkaO6FAmh4jRh4EGEAJNvNuyy00fEIljPYD0UMcqOSTo5tFt9wGsHXoyC
         vlGaAuhzNRB4Nj70xzON4U4jtzRGeSFOKdxS+1jteWjjChxTR+CifQV2PKcVQ6Z+J0lQ
         7WUjoEHOsIW6eEcV7CjgqPnifHXwa4ho4qRxjsjCAy4OBvjqDJ2tINK5LYLVDwRNFqJg
         0kXA==
X-Gm-Message-State: ANoB5pnMrMBf0qgX8YBKlbueutQH4qikBhGvRnsTeVtkpHXbnnhCcROU
        w662B6N8AzjkA8XDFjOqLF1xGLeFKl5ZPpaMTOoCs1iXrzJR
X-Google-Smtp-Source: AA0mqf4hO3hAxn053jS+ngGKTEQICU2l9vveYNGgxcdCJgHiwafhsyD0q30cBwBkpn4SwetdNsJaZVrn10nKwRVlfTJO8Xg5jL5r
MIME-Version: 1.0
X-Received: by 2002:a05:6638:448a:b0:375:2b75:93d with SMTP id
 bv10-20020a056638448a00b003752b75093dmr4689121jab.235.1668396159688; Sun, 13
 Nov 2022 19:22:39 -0800 (PST)
Date:   Sun, 13 Nov 2022 19:22:39 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000071662d05ed65c02d@google.com>
Subject: [syzbot] BUG: unable to handle kernel paging request in bdi_register_va
From:   syzbot <syzbot+2f84b49020438f7a1e54@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    1621b6eaebf7 Merge branch 'for-next/fixes' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=147932c1880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=606e57fd25c5c6cc
dashboard link: https://syzkaller.appspot.com/bug?extid=2f84b49020438f7a1e54
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13834435880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1668d811880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/82aa7741098d/disk-1621b6ea.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f6be08c4e4c2/vmlinux-1621b6ea.xz
kernel image: https://storage.googleapis.com/syzbot-assets/296b6946258a/Image-1621b6ea.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/6366d3f12df1/mount_2.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2f84b49020438f7a1e54@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address 000000d219eb1dcf
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=000000010ebbd000
[000000d219eb1dcf] pgd=0000000000000000, p4d=0000000000000000
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 3197 Comm: syz-executor428 Not tainted 6.1.0-rc4-syzkaller-31872-g1621b6eaebf7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : bdi_lookup_rb_node mm/backing-dev.c:824 [inline]
pc : bdi_register_va+0x1d4/0x328 mm/backing-dev.c:883
lr : bdi_lookup_rb_node mm/backing-dev.c:820 [inline]
lr : bdi_register_va+0x228/0x328 mm/backing-dev.c:883
sp : ffff80001335ba90
x29: ffff80001335bac0 x28: ffff0000ce994ec0 x27: 0000000000000000
x26: 0000000000008000 x25: 0000000000000000 x24: 0000000000000000
x23: ffff0000cea2f018 x22: 000000d219eb1dd7 x21: 000000d219eb1dd7
x20: 0000000000000040 x19: ffff0000cea29000 x18: 0000000000000322
x17: 4e51455300696462 x16: ffff80000db1a158 x15: ffff0000ce994ec0
x14: 0000000000000050 x13: 00000000ffffffff x12: ffff0000ce994ec0
x11: ff808000084395bc x10: 0000000000000000 x9 : ffff8000084395bc
x8 : ffff0000ce994ec0 x7 : ffff8000084394f8 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000001 x1 : 0000000000000040 x0 : 0000000100000010
Call trace:
 bdi_register_va+0x1d4/0x328 mm/backing-dev.c:883
 super_setup_bdi_name+0x84/0x120 fs/super.c:1590
 super_setup_bdi+0x50/0x8c fs/super.c:1612
 v9fs_fill_super fs/9p/vfs_super.c:76 [inline]
 v9fs_mount+0x1a4/0x568 fs/9p/vfs_super.c:137
 legacy_get_tree+0x30/0x74 fs/fs_context.c:610
 vfs_get_tree+0x40/0x140 fs/super.c:1531
 do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
 path_mount+0x358/0x890 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __arm64_sys_mount+0x2c4/0x3c4 fs/namespace.c:3568
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
Code: f9416116 b4000396 90035097 910b02f7 (f85f82d5) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	f9416116 	ldr	x22, [x8, #704]
   4:	b4000396 	cbz	x22, 0x74
   8:	90035097 	adrp	x23, 0x6a10000
   c:	910b02f7 	add	x23, x23, #0x2c0
* 10:	f85f82d5 	ldur	x21, [x22, #-8] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
