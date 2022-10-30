Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94799612A12
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 11:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiJ3K02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 06:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3K0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 06:26:25 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6BEB1C2;
        Sun, 30 Oct 2022 03:26:24 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id t25so22900076ejb.8;
        Sun, 30 Oct 2022 03:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7c/lGoK+gtbCtySB1gIW7IU67MeJ+XxffhaGzyWdKCg=;
        b=VQ5aeA+JVfO8fEpnZ9ogGy4zkK3hM+4ZX3ikQM6vGz0zL87nCN5+FuPZEOS5ZE2Amo
         BeqKRbMn2omK3PzOt+myGQCVtvJ4E5UB6oDLVjQ53fQsS144gzTv8Ii5NJTckzzjF/ns
         JH70Iw8LJOMW7gpFYUvYwcvJ4fEdNSyI+Piu85Je+1otQKu5HL0E+JjsQ0oM6PN9Ceh1
         BEnu9LaPqYXpRBhh0Msj53c3FNOJP1QMTX0tZSRJU3pt39ab85JcmrYuxJv3+bUsGRxT
         cWz0AweSdHolNHmnKVWcZ4IT0Wll40vqGnnIdo/hJJLmVRm3pA6TPkjumIgOUwsjxl4O
         g31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7c/lGoK+gtbCtySB1gIW7IU67MeJ+XxffhaGzyWdKCg=;
        b=6miFAUaBfymuCwFmtGAlL3lUFG+azlyKO9XiUFGKl1p51cHy/j/u37sUTbbdmI/9J3
         ISOQLM0sK0AH5YKioKNMrsKfjQFT+rk7lu1cc9wImFAkNqWxMUwCeSyA9ThlqTo+QLM4
         UJcX+vwD3Dif9hRKbt1l2320TFN2ljtJefW2FOvzVSaB92ap+rBQHdFApfTzuSh/QGEU
         U8Lgudn9gAmpBZ9p70ksX2Tlht6AvRVBeyNW3S+Oh2ETkeSZibdiJCNIX6GF107UhhVs
         agBDeHcB57JyoQSVFn7V4LCweQe4dzoauOt1vljxSe7Il6qZ2asnez8nT84+JCgPi704
         WwcA==
X-Gm-Message-State: ACrzQf3itPL5AxBc+RzjBohRi2ljXGyQMI59dIAsjnVntLlEDbjdd9WE
        909Dm9W66nM2T2l45J0YrV2evyp/QFDbGzePZa0fcRTpcRF/Bw==
X-Google-Smtp-Source: AMsMyM5PVGpn1Kw/lXVDPsPkgsmZ+J4K8AWUNwWIELRZ6g72bdotqWifH0I0yb00Zzwrb4HUewysnCG3slUwd+uTXxQ=
X-Received: by 2002:a17:907:2d06:b0:78d:50db:130e with SMTP id
 gs6-20020a1709072d0600b0078d50db130emr7447503ejc.371.1667125583014; Sun, 30
 Oct 2022 03:26:23 -0700 (PDT)
MIME-Version: 1.0
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Sun, 30 Oct 2022 18:25:47 +0800
Message-ID: <CAO4mrfdwcZx1LPUduO1ycNs-hz0jGmiG+Lbe7VN-ext=aFzYEQ@mail.gmail.com>
Subject: kernel BUG in reiserfs_update_sd_size
To:     reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org
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
https://drive.google.com/file/d/1laVB52iSmAz7ATjvqKgcZw9Qf3pVh50t/view?usp=share_link
kernel config: https://drive.google.com/file/d/1uDOeEYgJDcLiSOrx9W8v2bqZ6uOA_55t/view?usp=share_link

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: Wei Chen <harperchen1110@gmail.com>

REISERFS (device loop0): Using rupasov hash to sort names
REISERFS panic (device loop0): vs-13065 update_stat_data: key [1 2 0x0
IND], found item *3.6* [1 2 0x0 IND], item_len 44, item_location 4052,
free_space(entry_count) 0
------------[ cut here ]------------
kernel BUG at fs/reiserfs/prints.c:390!
invalid opcode: 0000 [#1] PREEMPT SMP
CPU: 0 PID: 12506 Comm: syz-executor.0 Not tainted 5.15.0-rc5 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
RIP: 0010:__reiserfs_panic.cold.17+0x37/0x8c
Code: d1 85 74 63 e8 e6 f4 9f fc 4c 89 f1 48 89 da 4c 89 ee 49 c7 c0
a0 30 29 89 48 c7 c7 04 8f c0 85 e8 f1 60 fe ff e8 c5 f4 9f fc <0f> 0b
e8 be f4 9f fc 4d 85 ed 49 c7 c4 26 a6 d1 85 74 36 e8 ad f4
RSP: 0018:ffffc900020b7aa0 EFLAGS: 00010216
RAX: 0000000000013eb9 RBX: ffff888016c8a000 RCX: 0000000000040000
RDX: ffffc9000226d000 RSI: ffff888111950000 RDI: 0000000000000002
RBP: ffffc900020b7b10 R08: ffffffff849d7e9b R09: 0000000000000000
R10: 0000000000000005 R11: 0000000080000000 R12: ffffffff85d1a626
R13: ffffffff85c07963 R14: ffffffff85079d30 R15: ffffc900020b7c60
FS:  00007f3386280700(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000525b40 CR3: 0000000011cfd000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 reiserfs_update_sd_size+0x33b/0x450
 reiserfs_mkdir+0x2db/0x3c0
 reiserfs_xattr_init+0x1be/0x330
 reiserfs_fill_super+0x110e/0x1620
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
RSP: 002b:00007f338627fa48 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f338627faf0 RCX: 000000000046abda
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f338627fab0
RBP: 0000000020000000 R08: 00007f338627faf0 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000100
R13: 00007f338627fab0 R14: 0000000000000001 R15: 0000000020011500
Modules linked in:
---[ end trace 15f12b9b91cc8105 ]---
RIP: 0010:__reiserfs_panic.cold.17+0x37/0x8c
Code: d1 85 74 63 e8 e6 f4 9f fc 4c 89 f1 48 89 da 4c 89 ee 49 c7 c0
a0 30 29 89 48 c7 c7 04 8f c0 85 e8 f1 60 fe ff e8 c5 f4 9f fc <0f> 0b
e8 be f4 9f fc 4d 85 ed 49 c7 c4 26 a6 d1 85 74 36 e8 ad f4
RSP: 0018:ffffc900020b7aa0 EFLAGS: 00010216
RAX: 0000000000013eb9 RBX: ffff888016c8a000 RCX: 0000000000040000
RDX: ffffc9000226d000 RSI: ffff888111950000 RDI: 0000000000000002
RBP: ffffc900020b7b10 R08: ffffffff849d7e9b R09: 0000000000000000
R10: 0000000000000005 R11: 0000000080000000 R12: ffffffff85d1a626
R13: ffffffff85c07963 R14: ffffffff85079d30 R15: ffffc900020b7c60
FS:  00007f3386280700(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000525b40 CR3: 0000000011cfd000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

Best,
Wei
