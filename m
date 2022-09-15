Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11D65BA057
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 19:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiIORXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 13:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiIORXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 13:23:36 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54ADB6DFAD
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 10:23:35 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id d18-20020a056e020c1200b002eaea8e6081so12790987ile.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 10:23:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=2ScjKn1UPsGX0RYUZ6qQqj8Ws3VidBH6PvKw4bFa9ms=;
        b=YIS0zYbHJ2UTN87P48F18eB+1AGy65PPsT0GXaTH1SRsT/o22nylhuhADbO2hdyv10
         dqtZlw8LzX9o4T+zI8AFnDnTsoc0GmGMBhLpg1VZmllXeDG2JC2V8Eq6jcF4vjN3RFWV
         VusnrRqZG2X9lgK/GEttKdVvOJtRLgBUBbBam4/k5LLkJqtAEl1Ix9CSBIeA2pXlrGwh
         XMLEe/XgI9EdmM0p8qvL+J9ReEa5vP5nANNNOWZkChWIweKXRCPcyhQJlq06d70fJgAR
         aV80Z6usk86SMbYzz5uZwd75ShLNpZz3GHfbtl2EQ4uDnBwZTUvmBXYcE2wxXJIWvidz
         FIkA==
X-Gm-Message-State: ACrzQf2OALzq2wnigUzNixVI1gXGWIwVHa3DmBDT3J4RXxYZ+gamMgHt
        5ifH0uraiMzWHF43yMr+MM/Triyx3K/uQR1IolFPxSjfsFX4
X-Google-Smtp-Source: AMsMyM5Jstrob7UAk0un2uq12t2aRueCtQIQq85zP4Puf4ExPKlB9whrGH/BXzRo3AXMJfvc/Nd6rG8DXSi4FkEGGo/8i6eX6IuV
MIME-Version: 1.0
X-Received: by 2002:a6b:5f16:0:b0:69e:2e4e:b25c with SMTP id
 t22-20020a6b5f16000000b0069e2e4eb25cmr325645iob.12.1663262614590; Thu, 15 Sep
 2022 10:23:34 -0700 (PDT)
Date:   Thu, 15 Sep 2022 10:23:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004f9ca105e8ba8157@google.com>
Subject: [syzbot] BUG: corrupted list in kobj_kset_join
From:   syzbot <syzbot+5a2d2b4a8ca80ad216a9@syzkaller.appspotmail.com>
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

HEAD commit:    a6b443748715 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=13644830880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e79d82586727c5df
dashboard link: https://syzkaller.appspot.com/bug?extid=5a2d2b4a8ca80ad216a9
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=179f4c37080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a180d5080000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1436897f0dc0/disk-a6b44374.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/68c4de151fbb/vmlinux-a6b44374.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5a2d2b4a8ca80ad216a9@syzkaller.appspotmail.com

list_add double add: new=ffff0000caf13540, prev=ffff0000caf13540, next=ffff0000c0368000.
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:35!
Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 44 Comm: kworker/u5:0 Not tainted 6.0.0-rc4-syzkaller-17255-ga6b443748715 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Workqueue: hci0 hci_rx_work
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __list_add_valid+0x68/0xb8 lib/list_debug.c:33
lr : __list_add_valid+0x68/0xb8 lib/list_debug.c:33
sp : ffff80000f683a70
x29: ffff80000f683a70 x28: ffff80000c537f58 x27: ffff0000c91b9300
x26: ffff80000b95b3bc x25: 000000000000001c x24: 000000000000001c
x23: ffff0000caf13558 x22: ffff0000c0368000 x21: ffff0000caf13540
x20: ffff0000caf13540 x19: ffff0000caf13538 x18: 00000000000000c0
x17: 3034353331666163 x16: ffff80000db78658 x15: ffff0000c0d93500
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c0d93500
x11: ff808000081c1fa0 x10: 0000000000000000 x9 : 67eb532626346d00
x8 : 67eb532626346d00 x7 : ffff8000081965e0 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff0001fefddcd0 x1 : 0000000000000001 x0 : 0000000000000058
Call trace:
 __list_add_valid+0x68/0xb8 lib/list_debug.c:33
 __list_add include/linux/list.h:69 [inline]
 list_add_tail include/linux/list.h:102 [inline]
 kobj_kset_join+0xd0/0x14c lib/kobject.c:164
 kobject_add_internal+0x1b8/0x530 lib/kobject.c:214
 kobject_add_varg lib/kobject.c:358 [inline]
 kobject_add+0xb8/0x130 lib/kobject.c:410
 device_add+0x248/0x958 drivers/base/core.c:3452
 hci_conn_add_sysfs+0x4c/0xf4 net/bluetooth/hci_sysfs.c:53
 hci_le_cis_estabilished_evt+0x180/0x21c net/bluetooth/hci_event.c:6799
 hci_le_meta_evt+0x1e4/0x230 net/bluetooth/hci_event.c:7110
 hci_event_func net/bluetooth/hci_event.c:7440 [inline]
 hci_event_packet+0x4e0/0x60c net/bluetooth/hci_event.c:7495
 hci_rx_work+0x1a4/0x2f4 net/bluetooth/hci_core.c:4007
 process_one_work+0x2d8/0x504 kernel/workqueue.c:2289
 worker_thread+0x340/0x610 kernel/workqueue.c:2436
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20
Code: 9001b4c0 911b6c00 aa0803e2 94a795bf (d4210000) 
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
