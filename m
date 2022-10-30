Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D92F612949
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 10:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiJ3JRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 05:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJ3JRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 05:17:34 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8460AB48F
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 02:17:33 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id a13so13677690edj.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 02:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uOrrrL9iaGZGXaKvd8Lhm004vUztik9GWjG18KWc30Y=;
        b=b9eWadV7ln2eu8Zx3f85v8faBuxoB5BMznJMI9LhPh4gjnGbuhVfQs+tqp3TqffQoh
         3PPKIDRCj3Tav+jR2VTgB+UZ8zS4VbXgUJtN+TZ33ZBBrfXBE7Al4ZPrHz1JZ21UT9DR
         QGW4ZF2MHTAoGkKKggxWISqaniTkkH7Dq6sptYK2JkC0iSnx1SAJJzpVZeB6rePSBme2
         Mn8dR53wnB39DG0TU7rJqOSOcEI7LgjNulRY0r+ONLecT8AeCtyMPWO3iZz5h6aOn7gU
         kS3tJwk8dSF9IC1sc4odmdb+HWzpgvFbNLbVTrapyboEmQRgkdnksUJ3pcA0aEMXx9xs
         q+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uOrrrL9iaGZGXaKvd8Lhm004vUztik9GWjG18KWc30Y=;
        b=fRS1LXs8xfVG+jMMfEkI0pHkidGXVrWVJ/QtW41fqj6AztY79cicsBb6EB3hukkIc4
         GMveEjeX9hwmXQBNr5fCaCqM5QPe6EEiaVeYg7KgT3VDY6mwaZ9wwuyJY0FFX6iDOv0H
         6fLBvC2kodLq8E2llTzXr+OKEh4OlQYFUGuTrj+QzrPtDgZ5Ra0efNxMg2mL8mJZExoX
         oY7pRCrZfw2BgaDBmNLlxDV3V/hJsR7mXoTFLt9OCVnmdU6NvKGh8get8dS2bT/y0fEK
         rHKIh6xWHxuD6+zV9StYIWy15Q6kpTNekJCa8PKBbpt3K33GyxGdR7cJwPhuDq4Uq13E
         YY9g==
X-Gm-Message-State: ACrzQf2QWWW/hJ2vTwmPxmqYzC8erfmoYp/1/0+qq42kwsh3Svfv6XQd
        8hZL2ONTgY8EL3bc/2PruD2Ln6YPrcoUeDAnMyrRW6dZwLU=
X-Google-Smtp-Source: AMsMyM5wTQwn11rlZ4XbqYAg3irU/LovUE2D+MkXs59wnzXLua4k4dGb0uymA2UD+YnUIUQgAN3EuoA/FvMmJxPLjMg=
X-Received: by 2002:a05:6402:1690:b0:45f:d702:9919 with SMTP id
 a16-20020a056402169000b0045fd7029919mr7931154edv.127.1667121451874; Sun, 30
 Oct 2022 02:17:31 -0700 (PDT)
MIME-Version: 1.0
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Sun, 30 Oct 2022 17:16:55 +0800
Message-ID: <CAO4mrfc5zN_QJ_92+SJTmLYhAyS2qLeYp8Ru7J5Wgf3sp-LSRQ@mail.gmail.com>
Subject: kernel BUG in ntfs_readpage
To:     anton@tuxera.com
Cc:     linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux Developer,

Recently when using our tool to fuzz kernel, the following crash was triggered:

HEAD commit: 64570fbc14f8 Linux 5.15-rc5
git tree: upstream
compiler: gcc 8.0.1
console output:
https://drive.google.com/file/d/1Vgv6uKdZ3XXWzqYUatGc_ca7xD5nHFbz/view?usp=share_link
kernel config: https://drive.google.com/file/d/1uDOeEYgJDcLiSOrx9W8v2bqZ6uOA_55t/view?usp=share_link

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: Wei Chen <harperchen1110@gmail.com>

loop0: detected capacity change from 0 to 67
------------[ cut here ]------------
kernel BUG at fs/ntfs/aops.c:186!
invalid opcode: 0000 [#1] PREEMPT SMP
CPU: 1 PID: 22515 Comm: syz-executor.0 Not tainted 5.15.0-rc5 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
RIP: 0010:ntfs_readpage+0x1468/0x1860
Code: 0e 2c 7d ff 49 8b 9f 30 fd ff ff 31 ff 48 c1 eb 03 83 e3 01 48
89 de e8 16 2d 7d ff 48 85 db 0f 85 61 f5 ff ff e8 e8 2b 7d ff <0f> 0b
e8 e1 2b 7d ff f0 41 80 0c 24 10 e9 d9 f8 ff ff e8 d1 2b 7d
RSP: 0018:ffffc900022bfaf0 EFLAGS: 00010206
RAX: 0000000000009cb0 RBX: 0000000000000000 RCX: 0000000000040000
RDX: ffffc90001311000 RSI: ffff8881095cb700 RDI: 0000000000000002
RBP: 0000000000000020 R08: ffffffff81c04778 R09: 0000000000000000
R10: 0000000000000007 R11: 0000000000000000 R12: 0000000000000000
R13: ffffea00044bf8c0 R14: ffff88810fea4d80 R15: ffff88810fea50a0
FS:  00007fc3f28c3700(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000525b40 CR3: 0000000110e31000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 do_read_cache_page+0x521/0x7a0
 map_mft_record+0xcb/0x600
 ntfs_read_locked_inode+0x69/0x1d20
 ntfs_read_inode_mount+0x517/0xfb0
 ntfs_fill_super+0x8e9/0x1710
 mount_bdev+0x23d/0x280
 legacy_get_tree+0x2e/0x90
 vfs_get_tree+0x29/0x100
 path_mount+0x58e/0x10a0
 do_mount+0x9b/0xb0
 __x64_sys_mount+0x13a/0x150
 do_syscall_64+0x34/0xb0
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x46abda
Code: 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc3f28c2a48 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fc3f28c2af0 RCX: 000000000046abda
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007fc3f28c2ab0
RBP: 0000000020000000 R08: 00007fc3f28c2af0 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000100
R13: 00007fc3f28c2ab0 R14: 0000000000000001 R15: 000000002007dd00
Modules linked in:
---[ end trace 55d1771117b77cd9 ]---
RIP: 0010:ntfs_readpage+0x1468/0x1860
Code: 0e 2c 7d ff 49 8b 9f 30 fd ff ff 31 ff 48 c1 eb 03 83 e3 01 48
89 de e8 16 2d 7d ff 48 85 db 0f 85 61 f5 ff ff e8 e8 2b 7d ff <0f> 0b
e8 e1 2b 7d ff f0 41 80 0c 24 10 e9 d9 f8 ff ff e8 d1 2b 7d
RSP: 0018:ffffc900022bfaf0 EFLAGS: 00010206
RAX: 0000000000009cb0 RBX: 0000000000000000 RCX: 0000000000040000
RDX: ffffc90001311000 RSI: ffff8881095cb700 RDI: 0000000000000002
RBP: 0000000000000020 R08: ffffffff81c04778 R09: 0000000000000000
R10: 0000000000000007 R11: 0000000000000000 R12: 0000000000000000
R13: ffffea00044bf8c0 R14: ffff88810fea4d80 R15: ffff88810fea50a0
FS:  00007fc3f28c3700(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8c8c03e188 CR3: 0000000110e31000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

Best,
Wei
