Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BB5612A21
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 11:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiJ3Kct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 06:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiJ3Kcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 06:32:47 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E34C35
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 03:32:46 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id l11so12566040edb.4
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 03:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G5RScUteu20GvcnE65OXTNl6SrxBr8fKR/TbseFaB9A=;
        b=gNnKJnqnBdz5h22eAQh6Q8HcQMcKZ8/JScv1dUIoM9c5yXAk63xtdFkMl7kK6MGB0p
         22TPFXPLXq7RaGXK0+7KljBZfbtdwQ03LAVarXrFXoyaDnvv/4dA8gqtNjmhiZ/stmrq
         lcnf1KTFsQvw40HJVptBB5WGESHED4oHp/E6X188+azNaMw+AEpDmjqLtzEancYWXVfA
         WcnqaEkCl7M6Yv2dHo8nrrnDEc08Q7xbbU2E9TRxyuOuNw1TuzQ0X0g19on4vImO2V0b
         XSXNj54DBrm+fNHuBdpsgf+YYnpQfJoRFjkwFBGuIn1Ds+9NIusq/9Ex6ZgEVpSRRT7d
         iydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G5RScUteu20GvcnE65OXTNl6SrxBr8fKR/TbseFaB9A=;
        b=0kFOQJtHzrL5xey9cQ7Dky59jdboBdzP5GEKkwAd9WB/nQByTNATGM47fOqx7KTzvZ
         LMvtAsovDK0UOuqwTqejRvRCEcBvFfWjUSNxGRBcJQ6+VY5ke8JFph1q0sCaP5ZU6z8T
         1d1+Nr1x02xYjmTp+UWeT8icVd+a99eFtEllXQg8fGQjVdiEFuOE82g/NJw7xDrPDAl0
         8vlGZtc+dddj+R8lbXapzPfJjXmI5jCFhuWlMrGjcc0OtgJxBpiN97FrrlBMYeeEJYBt
         EPuFjr+UZtLH2jlC2KwheM/mDr2v6hMBG8nl6HCgbkAyc91g3KajW6w7T07iaZAOfa1/
         F6eA==
X-Gm-Message-State: ACrzQf1kRI9p+5exNmzGBYZF46zDygZ2g3M+/RK+1kftyAKwa2yrmQR/
        G7VdES8/xH+CCl1QQWBPz5BSuaBrNTWLliPK/A/K9uclAR4qmw==
X-Google-Smtp-Source: AMsMyM7wl/EPwJRnDJ8gxfzNlLMhSS+JV1He+rGRREObOmSnaLYy2VK0WqU0UhcxByQK3whIe0YsJ5ACks5Ej3eQLG4=
X-Received: by 2002:a05:6402:10c2:b0:45c:3c87:721f with SMTP id
 p2-20020a05640210c200b0045c3c87721fmr8454420edu.251.1667125964826; Sun, 30
 Oct 2022 03:32:44 -0700 (PDT)
MIME-Version: 1.0
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Sun, 30 Oct 2022 18:32:08 +0800
Message-ID: <CAO4mrfeYuKpeskCfNMG=0YuHMTGh7LbyfK0pXH+zc40MKkSh+g@mail.gmail.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in fscache_free_cookie
To:     dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org
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
https://drive.google.com/file/d/1XbBDSFuHIAMsOAmvF0ITxNg8CEr443UB/view?usp=share_link
kernel config: https://drive.google.com/file/d/1uDOeEYgJDcLiSOrx9W8v2bqZ6uOA_55t/view?usp=share_link

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: Wei Chen <harperchen1110@gmail.com>

RBP: 000000000000004a R08: 00000000200007c0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000119bfac
R13: 0000000000000000 R14: 000000000119bfa0 R15: 00007fffa5a71650
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 14091067 P4D 14091067 PUD 14092067 PMD 0
Oops: 0000 [#1] PREEMPT SMP
CPU: 1 PID: 13456 Comm: syz-executor.0 Not tainted 5.15.0-rc5 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
RIP: 0010:__list_del_entry_valid+0x2d/0x50
Code: 01 00 00 00 00 ad de 48 8b 07 48 8b 57 08 48 39 c8 0f 84 cd cb
46 02 48 b9 22 01 00 00 00 00 ad de 48 39 ca 0f 84 f0 cb 46 02 <48> 8b
32 48 39 fe 0f 85 d0 cb 46 02 48 8b 50 08 48 39 f2 0f 85 b5
RSP: 0018:ffffc9000cf63c28 EFLAGS: 00010217
RAX: 0000000000000000 RBX: ffff88800f2113d8 RCX: dead000000000122
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff88800f211490
RBP: 0000000000000079 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff86485018 R11: 0000000000000000 R12: 000000000000001f
R13: 0000000000000000 R14: ffffffff8518ba40 R15: 0000000000000000
FS:  00007f0e4932c700(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000014090000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 fscache_free_cookie+0x45/0x120
 fscache_alloc_cookie+0x331/0x350
 __fscache_acquire_cookie+0x132/0x620
 v9fs_cache_session_get_cookie+0x7d/0x140
 v9fs_session_init+0x798/0xac0
 v9fs_mount+0x53/0x480
 legacy_get_tree+0x2e/0x90
 vfs_get_tree+0x29/0x100
 path_mount+0x58e/0x10a0
 do_mount+0x9b/0xb0
 __x64_sys_mount+0x13a/0x150
 do_syscall_64+0x34/0xb0
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4692c9
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0e4932bc38 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f0e4932bc80 RCX: 00000000004692c9
RDX: 00000000200002c0 RSI: 0000000020000100 RDI: 0000000000000000
RBP: 000000000000004a R08: 00000000200007c0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000119bfac
R13: 0000000000000000 R14: 000000000119bfa0 R15: 00007fffa5a71650
Modules linked in:
CR2: 0000000000000000
---[ end trace 15cdfd4d79de03b8 ]---
RIP: 0010:__list_del_entry_valid+0x2d/0x50
Code: 01 00 00 00 00 ad de 48 8b 07 48 8b 57 08 48 39 c8 0f 84 cd cb
46 02 48 b9 22 01 00 00 00 00 ad de 48 39 ca 0f 84 f0 cb 46 02 <48> 8b
32 48 39 fe 0f 85 d0 cb 46 02 48 8b 50 08 48 39 f2 0f 85 b5
RSP: 0018:ffffc9000cf63c28 EFLAGS: 00010217
RAX: 0000000000000000 RBX: ffff88800f2113d8 RCX: dead000000000122
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff88800f211490
RBP: 0000000000000079 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff86485018 R11: 0000000000000000 R12: 000000000000001f
R13: 0000000000000000 R14: ffffffff8518ba40 R15: 0000000000000000
FS:  00007f0e4932c700(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000014090000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0: 01 00                add    %eax,(%rax)
   2: 00 00                add    %al,(%rax)
   4: 00 ad de 48 8b 07    add    %ch,0x78b48de(%rbp)
   a: 48 8b 57 08          mov    0x8(%rdi),%rdx
   e: 48 39 c8              cmp    %rcx,%rax
  11: 0f 84 cd cb 46 02    je     0x246cbe4
  17: 48 b9 22 01 00 00 00 movabs $0xdead000000000122,%rcx
  1e: 00 ad de
  21: 48 39 ca              cmp    %rcx,%rdx
  24: 0f 84 f0 cb 46 02    je     0x246cc1a
* 2a: 48 8b 32              mov    (%rdx),%rsi <-- trapping instruction
  2d: 48 39 fe              cmp    %rdi,%rsi
  30: 0f 85 d0 cb 46 02    jne    0x246cc06
  36: 48 8b 50 08          mov    0x8(%rax),%rdx
  3a: 48 39 f2              cmp    %rsi,%rdx
  3d: 0f                    .byte 0xf
  3e: 85                    .byte 0x85
  3f: b5                    .byte 0xb5

Best,
Wei
