Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758C55F9F13
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 15:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiJJNFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 09:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiJJNE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 09:04:57 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B262918B31;
        Mon, 10 Oct 2022 06:04:55 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id l22so15796940edj.5;
        Mon, 10 Oct 2022 06:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o50QyVu8VAyHCqxIQn18V0Uq7O5eBhLw3GUeXgpdKJc=;
        b=f6wdkHeSX5/FAdwUcsbSOithHLIndjQ/1E5YB4+iZW/mobFMkcPtGlSUQL8tD51+wg
         NolyFKZmr4qOb7E6rOBd3wEi0Ibbvt7CjkpPPkEmMtJv+zMkv6GBHTqfXeAM/0usICTG
         NxHHgw0R3XDfHIwBrJPaIBDheSCCcqUbFJdhAZD05pVNFYnOMHCL+DSl8JNWM7Vqo2DO
         6Lvp/7n/h1Cr/Ot9tJiWBph3SAnbh6W9zoU3eS9Dq86TfZ2bArTk5BPunBzLTEKqSWKV
         rqxWUWk44Om7uME28dheyMwXaL2uhglSxJq3SaZZxPLDYxlUfm4Gi6ISk4gMdXlc6fnG
         lk9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o50QyVu8VAyHCqxIQn18V0Uq7O5eBhLw3GUeXgpdKJc=;
        b=G1x7NEgr2vq8h+lvuX81RqxCEVvhQ4v/kVqphbLBOv/lyIFYcYPw91Lz7kNuEu35K5
         OR8GgBonzKi/jAB9jmCsvez385RwV1U/OX7lwGOtWTA+xtDFpkzmcoskuJdESYjEcWdV
         s1wXxEjuwsCqldE/JtyNRWc/lebsU0/t8h4RkRLtdZ28rde7qYhaAqC6QQ4eD2uUWJ0D
         xvx1npR6YfZ/Qrt3yJzGsX6K44+q32N3yECwu7pHz08AwyQPCy9HmhzuWhXphomRMGya
         GWW1ObfmIgFf65K+RC3Ya1mGAAl0zoZfseLqM97G0V2GOE5IdemU3OUMnISU5XcXwAmg
         OA9Q==
X-Gm-Message-State: ACrzQf3dhO9ACEyaLlBZGePgpWHExzsOI5XmQPMh8CEMk9UfLvTURv94
        YiIP+/pKWPq1WRy6uf0TnqN1MmS9f44nKW99ec9760tPaxY=
X-Google-Smtp-Source: AMsMyM6NVXe2NhyS3YjPCg6wGuxDKO/94eHw9JxQKYjhfldBZFW1mQ+cAP9dKb/QY9W6/uIbn4FqByXcUcbdT+p3u0Q=
X-Received: by 2002:a05:6402:5291:b0:45c:3f6a:d4bc with SMTP id
 en17-20020a056402529100b0045c3f6ad4bcmr2069155edb.285.1665407093609; Mon, 10
 Oct 2022 06:04:53 -0700 (PDT)
MIME-Version: 1.0
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Mon, 10 Oct 2022 21:04:19 +0800
Message-ID: <CAO4mrffEL_fAJ3TPr7gM7yPtEZ-w4dNrro5a_E=G3XSGvHEm8w@mail.gmail.com>
Subject: WARNING: refcount bug in del_gendisk
To:     axboe@kernel.dk, linux-block@vger.kernel.org
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

HEAD commit: 64570fbc14f8 Linux 5.15-rc5
git tree: upstream
compiler: clang 12.0.0
console output:
https://drive.google.com/file/d/1rRIA8DQuvuMXcFn2VKCXJaijxHGIVRRm/view?usp=sharing
kernel config: https://drive.google.com/file/d/1lNwvovjLNrcuyFGrg05IoSmgO5jaKBBJ/view?usp=sharing

Unfortunately, I don't have any reproducer for this crash yet.

refcount_t: underflow; use-after-free.
WARNING: CPU: 0 PID: 26667 at lib/refcount.c:28
refcount_warn_saturate+0x186/0x1d0
Modules linked in:
CPU: 0 PID: 26667 Comm: syz-executor Not tainted 5.15.0-rc5+ #14
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:refcount_warn_saturate+0x186/0x1d0
Code: c7 a0 0d 15 8b 31 c0 e8 48 33 21 fd 0f 0b eb 80 e8 4f f9 57 fd
c6 05 23 e7 fb 09 01 48 c7 c7 00 0e 15 8b 31 c0 e8 2a 33 21 fd <0f> 0b
e9 5f ff ff ff e8 2e f9 57 fd c6 05 03 e7 fb 09 01 48 c7 c7
RSP: 0018:ffffc9000c47fd90 EFLAGS: 00010246
RAX: 2c799da371900300 RBX: 0000000000000003 RCX: 0000000000040000
RDX: ffffc90008d39000 RSI: 000000000003ffff RDI: 0000000000040000
RBP: 0000000000000003 R08: ffffffff816a2ede R09: ffffed100c7857a8
R10: ffffed100c7857a8 R11: 0000000000000000 R12: ffff88810504c150
R13: 1ffff11020a09810 R14: ffff888103d93b38 R15: ffff888103d93b00
FS:  00007f74c6c90700(0000) GS:ffff888063c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000556503c79d68 CR3: 00000000460bb000 CR4: 0000000000752ef0
DR0: 0000000020000080 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
PKRU: 55555554
Call Trace:
 kobject_put+0x10d/0x130
 kobject_put+0xce/0x130
 del_gendisk+0x3c9/0x710
 loop_control_ioctl+0x5d7/0x770
 __se_sys_ioctl+0x10a/0x190
 do_syscall_64+0x3d/0xb0
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f74c9727c4d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f74c6c8fc58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f74c984e0a0 RCX: 00007f74c9727c4d
RDX: 0000000000000000 RSI: 0000000000004c81 RDI: 0000000000000006
RBP: 00007f74c97a0d80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f74c984e0a0
R13: 00007fffe21bf5cf R14: 00007fffe21bf770 R15: 00007f74c6c8fdc0

Best,
Wei
