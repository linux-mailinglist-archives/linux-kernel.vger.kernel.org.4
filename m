Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF64607013
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 08:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJUG2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 02:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiJUG2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 02:28:43 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1777223AB49;
        Thu, 20 Oct 2022 23:28:36 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id sc25so4673999ejc.12;
        Thu, 20 Oct 2022 23:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2GsHopWGfWuC5P8WBYg+N0Uiy24Ig3Qbisq2NRPkyyc=;
        b=kIYPRnvNLWgbv2TkPi7OquYCUHfU81BNG3E7d31vs6vKFnksrAp1+mcDQzV06zBnY5
         dg6XTImOuFV1oQKGR1/gVR1a9SjclF/bF4+LMhEHjqc7vXiD2d6qKeP1c+pl1qjbcKB/
         Y25anjq4Y1OlPTXkqKLYj4Fn3nW2BDd9CFr73gpXm4rbgjmz9YOFakObcbb6v6lIHj/Z
         vFBW4SFAHuqKgkhPGmhMV7I6vSujOpOXKXsweVeiDySHDRQlFpAdDD6jRtpQ8Y5ruF4t
         eCvm2lWGRMa+swhubqptGlWn7sUnRVhpdUbV/SQM54nVDIqYR8lHDXMHuWINNsITxn85
         V2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2GsHopWGfWuC5P8WBYg+N0Uiy24Ig3Qbisq2NRPkyyc=;
        b=mNiACqmqf2cuKnOGqvOzm2e+WjAtQ5hn+Lrdoydzyy2eIFwGHWK1CQQLPwIZr4gPwA
         kwPR2IAI2zCXj045F2XSwv62XrCcxcYGI8kzuFz5jAz6VP1KWmnEHDFwzmpjeiuSiUtS
         hVSudrpBKkbKhYzLLBrgXSuVwXXtcwd7Qf/ejQW1ZN1IuHdquhRoSuhCu1/4sg+4MA5f
         PR16rvjgAfQoprOWx9lUwql1pU7ziqWFvohKCnfcyRsaXvTXH6ssfnABOun8w46/FWbs
         /Bl3KQrdNpXW7PbHGSS2I0qVO/BdHto4bz9n5klP736bn2aM9td/VbqAJ7bIOrQBO9Yk
         oKtQ==
X-Gm-Message-State: ACrzQf3Eqa5z6tLxvbjsP7SqZHfLZBLBdyLakC2lVGd50iFoZxjditwK
        J3sGGAtz6/LYCmOQiOOdRFqzGBaYwEqutZr91fA=
X-Google-Smtp-Source: AMsMyM7SA8VBiukxvCVCvJaI+yiDQ/uEEUZ5LA8DSu7dS+lK2Qyl0LhEuBpnyJcIEEDeD/c7NLvDSkA4FQisaUoLYsE=
X-Received: by 2002:a17:907:2d06:b0:78d:50db:130e with SMTP id
 gs6-20020a1709072d0600b0078d50db130emr14129462ejc.371.1666333715063; Thu, 20
 Oct 2022 23:28:35 -0700 (PDT)
MIME-Version: 1.0
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Fri, 21 Oct 2022 14:28:02 +0800
Message-ID: <CAO4mrfd-1iFwLCM=FGB=GUPs5_3NjAVtem-t3dRTZUyjTU6FDA@mail.gmail.com>
Subject: WARNING in fd_ioctl
To:     efremov@linux.com, axboe@kernel.dk, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
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

HEAD commit: 4fe89d07 Linux v6.0
git tree: upstream
compiler: clang 12.0.0
console output:
https://drive.google.com/file/d/1DcfdIOQBRJq3Z3H02xPLef7t8dkcUVKA/view?usp=sharing
Syzlang reproducer:
https://drive.google.com/file/d/1j4HO4sHdM_-nYDX1_PTNgeL_LQd0ReGV/view?usp=sharing
C reproducer: https://drive.google.com/file/d/1xu7ljT0bxJZNwsjw2WjmE4FmzHG796An/view?usp=sharing
kernel config: https://drive.google.com/file/d/1ZHRxVTXHL9mENdAPmQYS1DtgbflZ9XsD/view?usp=sharing

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: Wei Chen <harperchen1110@gmail.com>

WARNING: CPU: 0 PID: 6439 at drivers/block/floppy.c:999
process_fd_request drivers/block/floppy.c:2847 [inline]
WARNING: CPU: 0 PID: 6439 at drivers/block/floppy.c:999 do_format
drivers/block/floppy.c:2239 [inline]
WARNING: CPU: 0 PID: 6439 at drivers/block/floppy.c:999
fd_locked_ioctl drivers/block/floppy.c:3501 [inline]
WARNING: CPU: 0 PID: 6439 at drivers/block/floppy.c:999
fd_ioctl+0x1f31/0x26f0 drivers/block/floppy.c:3574
Modules linked in:
CPU: 0 PID: 6439 Comm: syz-executor.0 Not tainted 6.0.0 #35
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:schedule_bh drivers/block/floppy.c:999 [inline]
RIP: 0010:process_fd_request drivers/block/floppy.c:2847 [inline]
RIP: 0010:do_format drivers/block/floppy.c:2239 [inline]
RIP: 0010:fd_locked_ioctl drivers/block/floppy.c:3501 [inline]
RIP: 0010:fd_ioctl+0x1f31/0x26f0 drivers/block/floppy.c:3574
Code: ff e8 d3 88 9e fc 0f 0b e9 75 fd ff ff e8 c7 88 9e fc 0f 0b e9
ef f3 ff ff e8 bb 88 9e fc 0f 0b e9 8e f4 ff ff e8 af 88 9e fc <0f> 0b
e9 51 fd ff ff e8 a3 88 9e fc 0f 0b e9 9b f9 ff ff 89 d9 80
RSP: 0018:ffffc9000d897ca0 EFLAGS: 00010287
RAX: ffffffff84e89071 RBX: 0000000000000001 RCX: 0000000000040000
RDX: ffffc90005519000 RSI: 0000000000000ccb RDI: 0000000000000ccc
RBP: ffffc9000d897e30 R08: ffffffff84e88dbb R09: fffffbfff1adcf55
R10: fffffbfff1adcf55 R11: 0000000000000000 R12: 1ffff92001b12fa4
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f557132d700(0000) GS:ffff88802cc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f55703a5864 CR3: 000000006384c000 CR4: 0000000000750ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 blkdev_ioctl+0x3a6/0x770 block/ioctl.c:614
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0x90 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f557028bded
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f557132cc58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f55703abf80 RCX: 00007f557028bded
RDX: 0000000020000280 RSI: 00000000400c0248 RDI: 0000000000000003
RBP: 00007f55702f8ce0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f55703abf80
R13: 00007ffd41709f0f R14: 00007ffd4170a0b0 R15: 00007f557132cdc0
 </TASK>

Best,
Wei
