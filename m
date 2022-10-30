Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68972612945
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 10:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiJ3JKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 05:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJ3JKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 05:10:38 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35815F83
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 02:10:33 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id k2so22715775ejr.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 02:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y72qm/5pIvjeR0f8Y05KldTYpaZCuldykFLF92i5SRY=;
        b=pkpBd05JqBjX2QFvUby5p7CL4jEdxA+mBk1L9Xq/C0Mgwhzl3ST2dv9b/aDzr+ZsHn
         CGT2njgksiJcVkamUkIYJfGy8Tj7Cc+jMsHufoq3FhiqwLCX1fvmt3ncIGcdTRDqCSNC
         g0dPB4AOwv77rQdIamxLOFTVc7pTJISEXHG6WgsI4bkbwtI+13Xdo7ZZFBUdSMku2Vux
         KeqUQ5efXk+v1nz8Fz5EoSMwFXN8fJ7mnkOkL4uIRRBTbKkPEEgAw9rq4FSTkKkvrMHJ
         457mx3f3EO2i7M+P9UG19a8Lb2EOEY86aIWuqzXOczQ05egSEIgiW4cZWjSIDH4OAOvp
         bxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y72qm/5pIvjeR0f8Y05KldTYpaZCuldykFLF92i5SRY=;
        b=nYwyhVSyTXSRNyWO4JZQEtsRCsfIMLCBHpDOOA/N8jRsRvpzid05Z0HThErPP46T1M
         CSvj06m9VFrlEXOeFGfJK3EO7jmBsGo4nKFBPvP6hPGQMaJWpOYq5MY64jhUft1gI0dN
         IFOjDIq4zyXVdniUQFRgdPjoGtx4C2L7oFaZstcVGpu1Z8tVXIXEosqAVovARJndcovx
         n4+9hw/C/7eNkB1lso8mJVe2mmnncM86OZdvJ6VTsXL52GDg5uI7IihHKY1aeMSmbkGl
         pr90AxDZ2h26G+n6m0M5zIg4LUjli1IZVf99E7ty7wl0amBd8ZIWPYl+sQx15ZfmKDSH
         ut4Q==
X-Gm-Message-State: ACrzQf2SgH7AaLeOanDws340RSOKN/+kB/VClciCV08/6kveM5EfgyBr
        qzKpBaqqnIJLNOcI0rmjS9o4nBLMbTqhaVYuNQBWUqnJmG0=
X-Google-Smtp-Source: AMsMyM4lcK0krCAY2oO2Z3jJOJpSq6lP+PMGNXfS88yVZ44WJgmv7F0gsudzRXY82Yggh1dc7ShUbu2XOctUjtMeKDM=
X-Received: by 2002:a17:907:2da6:b0:78d:3cf1:9132 with SMTP id
 gt38-20020a1709072da600b0078d3cf19132mr7406717ejc.299.1667121032196; Sun, 30
 Oct 2022 02:10:32 -0700 (PDT)
MIME-Version: 1.0
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Sun, 30 Oct 2022 17:09:56 +0800
Message-ID: <CAO4mrfd4=HRXMrcdZQUorNaFss3AFfrRxuXWMFT3uh+Dvfwb9g@mail.gmail.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in gfs2_evict_inode
To:     rpeterso@redhat.com, agruenba@redhat.com, cluster-devel@redhat.com
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
compiler: gcc 8.0.1
console output:
https://drive.google.com/file/d/1yppAEEN16x0lR3fd5t-NQ1itCoKLFtfP/view?usp=share_link
kernel config: https://drive.google.com/file/d/1uDOeEYgJDcLiSOrx9W8v2bqZ6uOA_55t/view?usp=share_link

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: Wei Chen <harperchen1110@gmail.com>

RBP: 0000000020000000 R08: 00007f39b7fa3af0 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000100
R13: 00007f39b7fa3ab0 R14: 0000000000000001 R15: 0000000020047a20
gfs2: fsid=syz:syz.0: can't lookup journal index: 0
BUG: kernel NULL pointer dereference, address: 000000000000008c
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD c1e1067 P4D c1e1067 PUD 1a9e8067 PMD 0
Oops: 0000 [#1] PREEMPT SMP
CPU: 0 PID: 11045 Comm: syz-executor.0 Not tainted 5.15.0-rc5 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
RIP: 0010:gfs2_evict_inode+0x47b/0xb00
Code: 3b 14 ff be 01 00 00 00 48 89 df e8 af 6f 44 ff 48 8b bb b8 04
00 00 31 f6 e8 e1 47 fd ff 49 8b 87 00 09 00 00 31 f6 4c 89 ff <8b> 90
8c 00 00 00 e8 ba 4a 00 00 31 ff 41 89 c5 89 c6 e8 ae 3c 14
RSP: 0018:ffffc9000df7fb10 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888016648d10 RCX: 0000000000040000
RDX: ffffc900013d5000 RSI: 0000000000000000 RDI: ffff88801a800000
RBP: ffffc9000df7fbc0 R08: ffffffff8229378f R09: 0000000000000000
R10: 0000000000000005 R11: 0000000000000000 R12: ffff888016648f38
R13: 0000000000000000 R14: ffff88801a800000 R15: ffff88801a800000
FS:  00007f39b7fa4700(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000000008c CR3: 0000000017567000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 evict+0x11c/0x230
 iput+0x2e9/0x500
 dentry_unlink_inode+0x111/0x1a0
 __dentry_kill+0x186/0x280
 dput.part.32+0x60d/0x940
 gfs2_fill_super+0x8c1/0x10f0
 get_tree_bdev+0x243/0x340
 gfs2_get_tree+0x24/0xd0
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
RSP: 002b:00007f39b7fa3a48 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f39b7fa3af0 RCX: 000000000046abda
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f39b7fa3ab0
RBP: 0000000020000000 R08: 00007f39b7fa3af0 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000100
R13: 00007f39b7fa3ab0 R14: 0000000000000001 R15: 0000000020047a20
Modules linked in:
CR2: 000000000000008c
---[ end trace 194497c38992c5b1 ]---
RIP: 0010:gfs2_evict_inode+0x47b/0xb00
Code: 3b 14 ff be 01 00 00 00 48 89 df e8 af 6f 44 ff 48 8b bb b8 04
00 00 31 f6 e8 e1 47 fd ff 49 8b 87 00 09 00 00 31 f6 4c 89 ff <8b> 90
8c 00 00 00 e8 ba 4a 00 00 31 ff 41 89 c5 89 c6 e8 ae 3c 14
RSP: 0018:ffffc9000df7fb10 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888016648d10 RCX: 0000000000040000
RDX: ffffc900013d5000 RSI: 0000000000000000 RDI: ffff88801a800000
RBP: ffffc9000df7fbc0 R08: ffffffff8229378f R09: 0000000000000000
R10: 0000000000000005 R11: 0000000000000000 R12: ffff888016648f38
R13: 0000000000000000 R14: ffff88801a800000 R15: ffff88801a800000
FS:  00007f39b7fa4700(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000000008c CR3: 0000000017567000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0: 3b 14 ff              cmp    (%rdi,%rdi,8),%edx
   3: be 01 00 00 00        mov    $0x1,%esi
   8: 48 89 df              mov    %rbx,%rdi
   b: e8 af 6f 44 ff        callq  0xff446fbf
  10: 48 8b bb b8 04 00 00 mov    0x4b8(%rbx),%rdi
  17: 31 f6                xor    %esi,%esi
  19: e8 e1 47 fd ff        callq  0xfffd47ff
  1e: 49 8b 87 00 09 00 00 mov    0x900(%r15),%rax
  25: 31 f6                xor    %esi,%esi
  27: 4c 89 ff              mov    %r15,%rdi
* 2a: 8b 90 8c 00 00 00    mov    0x8c(%rax),%edx <-- trapping instruction
  30: e8 ba 4a 00 00        callq  0x4aef
  35: 31 ff                xor    %edi,%edi
  37: 41 89 c5              mov    %eax,%r13d
  3a: 89 c6                mov    %eax,%esi
  3c: e8                    .byte 0xe8
  3d: ae                    scas   %es:(%rdi),%al
  3e: 3c 14                cmp    $0x14,%al

Best,
Wei
