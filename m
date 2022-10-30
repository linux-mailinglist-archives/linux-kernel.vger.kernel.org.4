Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2B36129B0
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 10:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiJ3Jpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 05:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiJ3JpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 05:45:22 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E88D11D
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 02:44:30 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id y14so22747196ejd.9
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 02:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7QHqaKR9S8SFu2MN4QJt+iMe49ihWePwEuYH9gUu/BU=;
        b=MCeVSjmtpmAJumkINRh+XL45j0kMzRVQxePrtTpFScVye5/BhFnbbImXbc46kMof+k
         6sQ8R0DR40Kb9z10CHjQm3Db4V4DNiXB5oeewzoA3lG1m8Fw0g9teKz00V/6jffuUp5E
         2xcrgKo2qCBSU2904ouKmFVg0J9eAH4klijvj6SSCLZ33ujZUiOJULlVP1aRJ4jQTrQB
         zRdIpnCpAuHUSulQi8ik6j354esr6o9f67wyKe4OBRTlsAEZ4kriUzNBCdUBnqDCifNF
         43BZg4wn0KFhNGBLEMCmKB0FpU4sd3683rNGURjLSkdT5ACEpA3vXDyU5u/KJURid5Ia
         RY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7QHqaKR9S8SFu2MN4QJt+iMe49ihWePwEuYH9gUu/BU=;
        b=j/KCFr1mm5gTuvdpPOLMTmSRLwWWNXknYGacrCvBsxxE1SowBXDKaEN3sZE/MiHxnc
         KQ97aRSJC6p/AAcndwufunthLrDS2olzbfHSYFqywuLJHnwUvcoNwYcbLn3mGaXCwCYj
         ue5X5O3rCCk5lAo1dcMB5JivTq0eXDtKqkVso3ufv6G2S0Ot+/Pql5vNLrXfzqgvCjQj
         kd3oiySxcMllDX75asuhNhqujdZbV6u98iIrAtVRSt0G3UxLt7l6q8Dr5/Alzl+usm2O
         9IDClu8M43rMn1un5khyQ4KYlz8IrEertFFXt2ilFmNxquExO10LRuTpUeTHVemGAjDC
         nv9w==
X-Gm-Message-State: ACrzQf2IktRRIKOGA/OiX5C7zs+BOEI6PZt7hqB+sGYaqptC6rbd5RBg
        BE3BjJpBqZNd0T9Ho9Da49xFS8/0MSTAFmWE268l9x4zsIsrPg==
X-Google-Smtp-Source: AMsMyM5KDmGbu+fjW3ONaiuh1YdF6abP41+7/F9KfUn5X8tztZpaMLGPrumR8byQSoHmlOtGgqIImzQ+Sqj1Yd6pf24=
X-Received: by 2002:a17:907:7f8b:b0:7ad:b45d:4e9a with SMTP id
 qk11-20020a1709077f8b00b007adb45d4e9amr5467977ejc.421.1667123068720; Sun, 30
 Oct 2022 02:44:28 -0700 (PDT)
MIME-Version: 1.0
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Sun, 30 Oct 2022 17:43:52 +0800
Message-ID: <CAO4mrfdcnTXXK0BQYr3bp=KyAH1_BUiRJd42a_bKhASgpO+gLw@mail.gmail.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in wait_consider_task
To:     christian@brauner.io, linux-kernel@vger.kernel.org
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
https://drive.google.com/file/d/1dGe81ZlqkO1khyG9jB9Gr2Wpg47561CV/view?usp=share_link
kernel config: https://drive.google.com/file/d/1uDOeEYgJDcLiSOrx9W8v2bqZ6uOA_55t/view?usp=share_link

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: Wei Chen <harperchen1110@gmail.com>

BUG: kernel NULL pointer dereference, address: 0000000000000850
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 120603067 P4D 120603067 PUD 120604067 PMD 0
Oops: 0000 [#1] PREEMPT SMP
CPU: 1 PID: 6561 Comm: syz-executor.0 Not tainted 5.15.0-rc5 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
RIP: 0010:wait_consider_task+0xc74/0x1750
Code: 00 e8 00 e5 34 01 e9 50 f8 ff ff e8 16 b4 16 00 31 f6 31 ff e8
0d b5 16 00 e9 df fc ff ff e8 03 b4 16 00 48 8b 83 98 05 00 00 <4c> 8b
b8 50 08 00 00 48 8b 83 a0 05 00 00 4c 8b b0 50 08 00 00 31
RSP: 0018:ffffc90000ce7d20 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888018805280 RCX: ffff888109629b80
RDX: 0000000000000000 RSI: ffff888109629b80 RDI: 0000000000000002
RBP: ffffc90000ce7d90 R08: ffffffff8126bf5d R09: 0000000000000000
R10: 0000000000000005 R11: 0000000000000020 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000020 R15: 0000000040000000
FS:  00000000027bc940(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000850 CR3: 0000000120602000 CR4: 00000000003526e0
Call Trace:
 do_wait+0x2ae/0x630
 kernel_wait4+0xff/0x1e0
 __do_sys_wait4+0xd7/0xf0
 do_syscall_64+0x34/0xb0
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4189ea
Code: 41 54 55 41 89 d4 53 48 89 f5 89 fb 48 83 ec 10 e8 6b f6 ff ff
45 31 d2 41 89 c0 44 89 e2 48 89 ee 89 df b8 3d 00 00 00 0f 05 <48> 3d
00 f0 ff ff 77 30 44 89 c7 89 44 24 0c e8 a2 f6 ff ff 8b 44
RSP: 002b:00007ffd6f761890 EFLAGS: 00000246 ORIG_RAX: 000000000000003d
RAX: ffffffffffffffda RBX: 00000000ffffffff RCX: 00000000004189ea
RDX: 0000000040000001 RSI: 00007ffd6f761960 RDI: 00000000ffffffff
RBP: 00007ffd6f761960 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000040000001
R13: 0000000000000001 R14: 0000000000000032 R15: 0000000000000bb8
Modules linked in:
CR2: 0000000000000850
---[ end trace 2e5c6a8b7a712caf ]---
RIP: 0010:wait_consider_task+0xc74/0x1750
Code: 00 e8 00 e5 34 01 e9 50 f8 ff ff e8 16 b4 16 00 31 f6 31 ff e8
0d b5 16 00 e9 df fc ff ff e8 03 b4 16 00 48 8b 83 98 05 00 00 <4c> 8b
b8 50 08 00 00 48 8b 83 a0 05 00 00 4c 8b b0 50 08 00 00 31
RSP: 0018:ffffc90000ce7d20 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888018805280 RCX: ffff888109629b80
RDX: 0000000000000000 RSI: ffff888109629b80 RDI: 0000000000000002
RBP: ffffc90000ce7d90 R08: ffffffff8126bf5d R09: 0000000000000000
R10: 0000000000000005 R11: 0000000000000020 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000020 R15: 0000000040000000
FS:  00000000027bc940(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000850 CR3: 0000000120602000 CR4: 00000000003526e0
----------------
Code disassembly (best guess):
   0: 00 e8                add    %ch,%al
   2: 00 e5                add    %ah,%ch
   4: 34 01                xor    $0x1,%al
   6: e9 50 f8 ff ff        jmpq   0xfffff85b
   b: e8 16 b4 16 00        callq  0x16b426
  10: 31 f6                xor    %esi,%esi
  12: 31 ff                xor    %edi,%edi
  14: e8 0d b5 16 00        callq  0x16b526
  19: e9 df fc ff ff        jmpq   0xfffffcfd
  1e: e8 03 b4 16 00        callq  0x16b426
  23: 48 8b 83 98 05 00 00 mov    0x598(%rbx),%rax
* 2a: 4c 8b b8 50 08 00 00 mov    0x850(%rax),%r15 <-- trapping instruction
  31: 48 8b 83 a0 05 00 00 mov    0x5a0(%rbx),%rax
  38: 4c 8b b0 50 08 00 00 mov    0x850(%rax),%r14
  3f: 31                    .byte 0x31

Best,
Wei
