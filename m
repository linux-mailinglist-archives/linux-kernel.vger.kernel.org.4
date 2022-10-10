Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737BE5FA23B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 18:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiJJQyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 12:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiJJQys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 12:54:48 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BA715FC5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 09:54:42 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id h2-20020a056602154200b006bb5f8574afso7626197iow.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 09:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O2e9MiFWlpjZJNBNBD1D7a1XUDsCDqlecCvcjAMW4v0=;
        b=ImEndrAaqAJle7pgXH6b4is+bp7n5YrS8knyDaUZ+VXCn7BBV2K9exwyZtTufTXcBB
         O2EFl0U424ih271X6VBclI4uVcPr1xtMvSm96KtMuG6ctX4m8EE/Ce5wdAl2yfy6RAUr
         fFwyoK3Rv9AW7tpXp/osywez12HnRtsEPk+ZO3Gtvqazu4oyhjhPpjdNTZu5DR01KuI7
         TOsGdmsd1RhUtIeXP7TAqX2T0II9attK7vQwurQiXywjVKVeMMI1EqmVveq/jhYhDnaX
         WgJ1jOo9oN7ia+h2uBv6cCMhhpYnRLVcf4IZHrqCOOjkcYuMocX+XQidEmvGgL7ON+xj
         EFGA==
X-Gm-Message-State: ACrzQf3bhrcs5XsEM1ONC+fI8l2hinnatyf4o5wEoSupQhCCATWULKxh
        NDx99fyQWbF8c+1GDIZs/qFp3l1bvxcza7E+95+0K08/grC4
X-Google-Smtp-Source: AMsMyM5bPqBKZgw8NPzpc/S1gv4pnM4TsaLN+RQVhdizufKCw972MYqzDNrFO/5rE3Q70gzAl7Y9bphyhDcG40n8k0YgmaVeQHG3
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1314:b0:363:b321:8721 with SMTP id
 r20-20020a056638131400b00363b3218721mr4244854jad.271.1665420882129; Mon, 10
 Oct 2022 09:54:42 -0700 (PDT)
Date:   Mon, 10 Oct 2022 09:54:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000014be6205eab104c3@google.com>
Subject: [syzbot] BUG: unable to handle kernel NULL pointer dereference in device_find_child
From:   syzbot <syzbot+6a462bc8fbe652f7d3fd@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=17a90b58880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
dashboard link: https://syzkaller.appspot.com/bug?extid=6a462bc8fbe652f7d3fd
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=166df61c880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=160c288a880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6a462bc8fbe652f7d3fd@syzkaller.appspotmail.com

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000058
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=000000010b53c000
[0000000000000058] pgd=080000010b5e4003, p4d=080000010b5e4003, pud=0800000109b02003, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 3038 Comm: syz-executor292 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : klist_next+0x28/0x18c lib/klist.c:377
lr : klist_next+0x24/0x18c lib/klist.c:376
sp : ffff80001282ba10
x29: ffff80001282ba10 x28: ffff0000c10a3500 x27: 0001000000000000
x26: 0000000000000000 x25: 0000000000000000 x24: ffff0000c3f47000
x23: ffff80000d832b20 x22: ffff0000ca8a0000 x21: ffff0000c3f43538
x20: 0000000000000000 x19: ffff80001282ba68 x18: 00000000000000c0
x17: ffff80000dd0b198 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000002 x12: ffff80000d833180
x11: ff808000096ae804 x10: 0000000000000000 x9 : ffff8000096ae804
x8 : ffff0000c10a3500 x7 : ffff8000095d2cfc x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff80000b97020c x1 : ffff80001282ba68 x0 : 0000000000000000
Call trace:
 klist_next+0x28/0x18c lib/klist.c:377
 next_device drivers/base/core.c:3756 [inline]
 device_find_child+0x50/0x114 drivers/base/core.c:3899
 hci_conn_del_sysfs+0x54/0xfc net/bluetooth/hci_sysfs.c:71
 hci_conn_cleanup+0x2d4/0x380 net/bluetooth/hci_conn.c:147
 hci_conn_del+0x144/0x2a8 net/bluetooth/hci_conn.c:1022
 hci_conn_hash_flush+0xe8/0x148 net/bluetooth/hci_conn.c:2367
 hci_dev_close_sync+0x48c/0x9e0 net/bluetooth/hci_sync.c:4476
 hci_dev_do_close net/bluetooth/hci_core.c:554 [inline]
 hci_rfkill_set_block+0x98/0x198 net/bluetooth/hci_core.c:947
 rfkill_set_block+0xb4/0x1f8 net/rfkill/core.c:345
 rfkill_fop_write+0x358/0x3f8 net/rfkill/core.c:1286
 vfs_write+0x1a4/0x46c fs/read_write.c:576
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
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
Code: 910003fd aa0003f3 97afc505 a9405260 (f9402c18) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	910003fd 	mov	x29, sp
   4:	aa0003f3 	mov	x19, x0
   8:	97afc505 	bl	0xfffffffffebf141c
   c:	a9405260 	ldp	x0, x20, [x19]
* 10:	f9402c18 	ldr	x24, [x0, #88] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
