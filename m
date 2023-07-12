Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8105074FEE5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 07:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbjGLFzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 01:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjGLFy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 01:54:58 -0400
Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD111734
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 22:54:57 -0700 (PDT)
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-39085e131dfso724188b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 22:54:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689141296; x=1691733296;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uOVKFzs9KIWmQMyZ0PHhgdwB2c2fu32hI4Diu1DLd8g=;
        b=avjXiDvRkvN+JaSkN829AcSso6woeLS/rJUIsjS0ZdQj60j7osD3ZzcJCrIdCcijsn
         +lDB4Jxw8B7pLq9YC8nxio+ohgYA1oJZpqSuYKhH2c0fv0UZeeVK12Q+447D2VL3sLOx
         sx32dr8Jp9e3CeMJavBFfhjxcgqAecEaZ2JCl+K4yhWRxdRhUfs71vOxGfN4LWzRhqsC
         xfVoA7+8xNfkFt14Km6HDsyHsed8at9WXxpnWUFUMJrkuSo+sp4JIP+WnoX5SGghugIT
         mQKg+XAF6XAi/DqX5BQA60FS2wiAyR2hP8zi40A9rDIs28E5lNIFtlSX5R4D7z9FuSVV
         rEIQ==
X-Gm-Message-State: ABy/qLYSE2ZyyZ4MOi5N2iSX3ENgPGbN6/NKLdpB5DxOfCxQOWt3CzyV
        IB8286KA/I5neWb0SMJRNn3KH73bjEmS864bfLeOy+UfMXRH
X-Google-Smtp-Source: APBJJlGdmN/HuSAX1E5vLHgsmHpMHTxprXKdiLnBMvOf74/u1vRYOx8HVqrle/4ui6EGq2kinyhM5J6ylIqoOT3lYZxXJQxZ+AoH
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1152:b0:3a3:c492:9be6 with SMTP id
 u18-20020a056808115200b003a3c4929be6mr1585895oiu.2.1689141296509; Tue, 11 Jul
 2023 22:54:56 -0700 (PDT)
Date:   Tue, 11 Jul 2023 22:54:56 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f43987060043da7b@google.com>
Subject: [syzbot] [nfc?] memory leak in virtual_ncidev_write (2)
From:   syzbot <syzbot+6b7c68d9c21e4ee4251b@syzkaller.appspotmail.com>
To:     bongsu.jeon@samsung.com, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4f6b6c2b2f86 Merge tag 'riscv-for-linus-6.5-mw2' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1565b4e2a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=832b404e095b70c0
dashboard link: https://syzkaller.appspot.com/bug?extid=6b7c68d9c21e4ee4251b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1296aa88a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e31cbca80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/894096f65e3a/disk-4f6b6c2b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fb7cd620415e/vmlinux-4f6b6c2b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5b6554eae0e7/bzImage-4f6b6c2b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6b7c68d9c21e4ee4251b@syzkaller.appspotmail.com

executing program
BUG: memory leak
unreferenced object 0xffff88810ac1a700 (size 240):
  comm "syz-executor366", pid 5017, jiffies 4294944625 (age 12.970s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff83e1b1cd>] __alloc_skb+0x1fd/0x230 net/core/skbuff.c:634
    [<ffffffff82c344e4>] alloc_skb include/linux/skbuff.h:1289 [inline]
    [<ffffffff82c344e4>] virtual_ncidev_write+0x34/0xf0 drivers/nfc/virtual_ncidev.c:115
    [<ffffffff8165e315>] vfs_write+0x175/0x570 fs/read_write.c:582
    [<ffffffff8165e951>] ksys_write+0xa1/0x160 fs/read_write.c:637
    [<ffffffff84a76ff9>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84a76ff9>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888109c4b400 (size 640):
  comm "syz-executor366", pid 5017, jiffies 4294944625 (age 12.970s)
  hex dump (first 32 bytes):
    10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff83e17a86>] kmalloc_reserve+0xe6/0x180 net/core/skbuff.c:559
    [<ffffffff83e1b0a5>] __alloc_skb+0xd5/0x230 net/core/skbuff.c:644
    [<ffffffff82c344e4>] alloc_skb include/linux/skbuff.h:1289 [inline]
    [<ffffffff82c344e4>] virtual_ncidev_write+0x34/0xf0 drivers/nfc/virtual_ncidev.c:115
    [<ffffffff8165e315>] vfs_write+0x175/0x570 fs/read_write.c:582
    [<ffffffff8165e951>] ksys_write+0xa1/0x160 fs/read_write.c:637
    [<ffffffff84a76ff9>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84a76ff9>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
