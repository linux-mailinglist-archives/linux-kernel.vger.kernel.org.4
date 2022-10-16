Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAED95FFCB4
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 02:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiJPAQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 20:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiJPAPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 20:15:55 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E3F42E61
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 17:15:52 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id y13-20020a056e021bed00b002faba3c4afbso6498316ilv.13
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 17:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dpAfyEYsZbcL+uowmnRdhgQHPugqz5Dq4Y1UUKcqVco=;
        b=plQ4PFhU7RG8DViBDrMFCBLtMkgLjm8NQxxcFBoPxv58ycPDoPlXVGS3BbRnSgBn+A
         m/Fyf0OxVbbkF09pIaMZji5pK185MjRcETIJ9J+dE8OQGIAIpf/fQRx/tAak12EuWrml
         AeerWcqrsEfSNB0U4bGfa/XWvnOwVZK4g2Utjjr3jL0EM7SX+PwP8TR0QJr9Z/8espuA
         dOsSgp3S2nts+KFfim26n8zW+vDCNPkejcbsXDpNfHoAL4WohSI7qlv6UhWAGnfjgtge
         tEmqzQy7oXlhsLEu31xQ3A5e7UJ4v/wp2Qy/G0OlVed4E0qlJH9UFGY7Wsb/CdBPdbAP
         CbBg==
X-Gm-Message-State: ACrzQf1nC044cV2d82bl3cQbE34F6Y8WH1jnLWcNR8p65INMHveULC2a
        Eo1ky64DLA8wYmEHwBHAzkL9wrzmpd63d9uDuyZpN+Nn3Jgh
X-Google-Smtp-Source: AMsMyM7HClx1J7tIG8YMCKCqPR13pqpaslX5dc+zFAGS0LO++kbIulr3Vd7IND2TFD96sRE1rs2eG338S/CJXdmul+SfEtHBmPPR
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d03:b0:363:efb2:41de with SMTP id
 q3-20020a0566380d0300b00363efb241demr2359099jaj.36.1665879351830; Sat, 15 Oct
 2022 17:15:51 -0700 (PDT)
Date:   Sat, 15 Oct 2022 17:15:51 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000001336205eb1bc371@google.com>
Subject: [syzbot] BUG: corrupted list in hci_conn_del_sysfs
From:   syzbot <syzbot+1c67b5b16a787760811b@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=118a79aa880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
dashboard link: https://syzkaller.appspot.com/bug?extid=1c67b5b16a787760811b
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13721f62880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=127b44c2880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1c67b5b16a787760811b@syzkaller.appspotmail.com

Bluetooth: hci0: failed to register connection device
list_del corruption. prev->next should be ffff0000c7b86540, but was ffff0000c923f540. (prev=ffff0000c923f540)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:61!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 3033 Comm: kworker/u5:2 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
Workqueue: hci0 hci_rx_work
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __list_del_entry_valid+0xbc/0xd0 lib/list_debug.c:59
lr : __list_del_entry_valid+0xbc/0xd0 lib/list_debug.c:59
sp : ffff80001273baa0
x29: ffff80001273baa0 x28: ffff80000c5286b0 x27: ffff0000c903c100
x26: ffff0000c7b86648 x25: ffff0000c7b86658 x24: 0000000000000000
x23: ffff0000c37c3500 x22: 0000000004208060 x21: 000000000000000c
x20: ffff0000c7b86540 x19: ffff0000c7b86538 x18: 00000000000000c0
x17: 20747562202c3034 x16: ffff80000db49158 x15: ffff0000c37c3500
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c37c3500
x11: ff808000081c0d5c x10: 0000000000000000 x9 : 0333914f3ceeb000
x8 : 0333914f3ceeb000 x7 : ffff80000819545c x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff0001fefbecd0 x1 : 0000000100000001 x0 : 000000000000006d
Call trace:
 __list_del_entry_valid+0xbc/0xd0 lib/list_debug.c:59
 __list_del_entry include/linux/list.h:134 [inline]
 list_del_init include/linux/list.h:206 [inline]
 kobj_kset_leave lib/kobject.c:175 [inline]
 __kobject_del+0xa8/0x1f8 lib/kobject.c:592
 kobject_del+0x28/0x110 lib/kobject.c:611
 device_del+0x46c/0x5bc drivers/base/core.c:3715
 hci_conn_del_sysfs+0xb0/0xfc net/bluetooth/hci_sysfs.c:78
 hci_conn_cleanup+0x2d4/0x380 net/bluetooth/hci_conn.c:147
 hci_conn_del+0x144/0x2a8 net/bluetooth/hci_conn.c:1022
 hci_le_cis_estabilished_evt+0x1c4/0x21c net/bluetooth/hci_event.c:6805
 hci_le_meta_evt+0x1e4/0x230 net/bluetooth/hci_event.c:7110
 hci_event_func net/bluetooth/hci_event.c:7440 [inline]
 hci_event_packet+0x4e0/0x60c net/bluetooth/hci_event.c:7495
 hci_rx_work+0x1a4/0x2f4 net/bluetooth/hci_core.c:4007
 process_one_work+0x2d8/0x504 kernel/workqueue.c:2289
 worker_thread+0x340/0x610 kernel/workqueue.c:2436
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
Code: d001b460 91346000 aa0803e3 94a76157 (d4210000) 
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
