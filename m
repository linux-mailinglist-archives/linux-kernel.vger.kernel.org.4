Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739186E073A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 08:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjDMGyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 02:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjDMGyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 02:54:44 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C071F83FC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 23:54:42 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id q15so10769131ljp.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 23:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681368881; x=1683960881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/K5PLW/4u0dZBSlDOqGinFywRsD9JVJuvLBimsjEjg=;
        b=My0kMspgRIZJRdJJzFMXvzTNRNJBrwxeve7+UCgi65gl/J8xE2/30FW2AUbWWJ9zcX
         /eYABTk0sKN3TBC3RO1Rcos4sQVSOqdDoEMCiBlVJKuq1YRZtgBhgt9fGmBhDYYrLgjQ
         69J7htvq0+rwXbpQ29fWK1Jq66D7X/QU5w687NOqfzQIlydecjnEjnt7G5xf3Nl5maWM
         JyoF17Y6u6Z6buydezp2rg1IaXY4uTzNFON6ST5smeSPzgDMllssgl48wMo1nbVFWrx9
         MSjuKhHsBTEUU4G7/3Vty4CqGIwlCbruT0XfrzMc4ql4Wtwx+xiPtXXi1KMSLob+kG4l
         qj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681368881; x=1683960881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h/K5PLW/4u0dZBSlDOqGinFywRsD9JVJuvLBimsjEjg=;
        b=gOh6pPjR/cT9sOCsIw4VoEordWPcwwKBHafWM8oTG1vDNiE4vD42IXi4JbZ2oknuoE
         xShRS8uWLS4fXOwqWe0txv2PEZVTdUW5qG7pVfRcd8dqMnSG5Mu8CuVBHVysjeQUjd/c
         lGnvXaG8xl+syLlB7v4mdCBqXjnaAgqk899b50P7/4kZsPPw3Zvx2q7v8UPk4ckf8JBP
         CVnEDwkRv2+6QAi9gPJqcoP7krGpSfUWoZbMasHSDzUOUgvwajNlbtyThmolJ9ozR1B5
         J/xWiyqqNFG3Kej6ka2i7QZOrQipZKJJkDI9uAQ0X/4nSrUkhpGZJvi1yGGThwBQsax8
         uOmw==
X-Gm-Message-State: AAQBX9ePP7EPnpyEjYp9ysTUSPP7AyMnH4xqSEwnmqR8auqbqqKmeq/f
        e4ZxHJ+YjuvkQubpkVnV5FUQZ+9KWeoSRZb2FMRLpA==
X-Google-Smtp-Source: AKy350YshFdRBjRjm6z871u45IlNMDzMsYnVVvRbSrOnpSkG0a7VxnbQPBbuUiY3bMAlbF1CvaOUbeiqpq7FSaSvgdU=
X-Received: by 2002:a2e:95c7:0:b0:2a7:a719:5939 with SMTP id
 y7-20020a2e95c7000000b002a7a7195939mr386518ljh.8.1681368880663; Wed, 12 Apr
 2023 23:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAGyP=7cJAUf=LTEPW9QLgd-6bJDMKCuqssPH=yyuKLE5=CKB_w@mail.gmail.com>
In-Reply-To: <CAGyP=7cJAUf=LTEPW9QLgd-6bJDMKCuqssPH=yyuKLE5=CKB_w@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 13 Apr 2023 08:54:28 +0200
Message-ID: <CACT4Y+b0shUc7rm0cxrzQLTCBD8=zwr6mAUFB3aDKOHY6P=s6A@mail.gmail.com>
Subject: Re: KFENCE: invalid read in leaf_paste_entries
To:     Palash Oswal <oswalpalash@gmail.com>
Cc:     reiserfs-devel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Apr 2023 at 06:50, Palash Oswal <oswalpalash@gmail.com> wrote:
>
> Hello,
> I found the following issue using syzkaller with enriched corpus on:
> HEAD commit : 0bcc4025550403ae28d2984bddacafbca0a2f112
> git tree: linux
>
> C Reproducer : https://gist.github.com/oswalpalash/c2589138be95e1c5da52f9=
08ad80c041
> Kernel .config :
> https://gist.github.com/oswalpalash/d9580b0bfce202b37445fa5fd426e41f

Looks similar to:
https://lore.kernel.org/all/000000000000467dff05d30bf75a@google.com/T/
https://syzkaller.appspot.com/bug?id=3D942f20de484a0ecf6b4c2cc9a1f818859543=
3000

> syz-repro :
> syz_mount_image$reiserfs(&(0x7f0000000000),
> &(0x7f0000000100)=3D'./file0\x00', 0x4000000, 0x5,
> &(0x7f0000000200)=3D[{&(0x7f0000010000)=3D"0040000068020000973d0000120000=
0000000000843d00000004000073564d38840300001e000000000000000010cc03020001005=
2654973457233467300000001000000020001000200853d0000000001000000123123121233=
1233123112341341241273797a6b616c6c65720000000000000001001e003bc1655f004eed0=
0",
> 0x80, 0x10000},
> {&(0x7f0000010100)=3D"000000000000000000000000010000000300"/32, 0x20,
> 0x100c0}, {&(0x7f0000011200)=3D"00000000000000000000000012000000000000008=
43d00000004000073564d38840300001e00"/64,
> 0x40, 0x3d96000},
> {&(0x7f0000011300)=3D"010002005c0f000000000000000000000000000000000000010=
0000002000000000000000000000000002c00d40f0100010000000200000001000000f40100=
0002003000a40f00"/96,
> 0x60, 0x3d97000},
> {&(0x7f0000000080)=3D"0000000001000000010e0000020000002800040002000000000=
08cee00000000000004002e2e0000000000002e00000000000000ed41000003000000300000=
00000000005cf90100535f01003bc165f354dffa32ec94ed23bb5568cfa05f3bc1655f3bc16=
55f010000290000000000",
> 0x6f, 0x3d97fa0}], 0x0, &(0x7f00000003c0)=3DANY=3D[@ANYBLOB], 0x0)
>
> Console log :
>
> REISERFS (device loop1): Using tea hash to sort names
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KFENCE: invalid read in memmove+0x4b/0x1b0
>
> Invalid read at 0xffff888135a00000:
>  memmove+0x4b/0x1b0
>  leaf_paste_entries+0x44d/0x910
>  balance_leaf+0x9853/0xddb0
>  do_balance+0x319/0x810
>  reiserfs_paste_into_item+0x74b/0x8d0
>  reiserfs_add_entry+0x8cb/0xcf0
>  reiserfs_mkdir+0x683/0x990
>  reiserfs_xattr_init+0x57e/0xc30
>  reiserfs_fill_super+0x2127/0x2ea0
>  mount_bdev+0x351/0x410
>  legacy_get_tree+0x109/0x220
>  vfs_get_tree+0x8d/0x350
>  path_mount+0x1342/0x1e40
>  __x64_sys_mount+0x283/0x300
>  do_syscall_64+0x39/0xb0
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> CPU: 0 PID: 5167 Comm: syz-executor.1 Not tainted
> 6.3.0-rc6-pasta-00035-g0bcc40255504 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.13.0-1ubuntu1.1 04/01/2014
> RIP: 0010:memmove+0x4b/0x1b0
> Code: 01 01 00 00 0f 1f 44 00 00 48 81 fa a8 02 00 00 72 05 40 38 fe
> 74 48 48 83 ea 20 48 83 ea 20 4c 8b 1e 4c 8b 56 08 4c 8b 4e 10 <4c> 8b
> 46 18 48 8d 76 20 4c 89 1f 4c 89 57 08 4c 89 4f 10 4c 89 47
> RSP: 0018:ffffc9000312efb0 EFLAGS: 00010286
> RAX: ffff888128a45fb4 RBX: 0000000000000002 RCX: 0000000000000000
> RDX: fffffffff3045f60 RSI: ffff8881359fffe4 RDI: ffff8881359ffff4
> RBP: 0000000000000020 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
> R13: 0000000000000000 R14: ffff888128a45fa4 R15: 0000000000000010
> FS:  00007fb847280700(0000) GS:ffff888063a00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff888135a00000 CR3: 000000011e331000 CR4: 00000000000006f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  leaf_paste_entries+0x44d/0x910
>  balance_leaf+0x9853/0xddb0
>  do_balance+0x319/0x810
>  reiserfs_paste_into_item+0x74b/0x8d0
>  reiserfs_add_entry+0x8cb/0xcf0
>  reiserfs_mkdir+0x683/0x990
>  reiserfs_xattr_init+0x57e/0xc30
>  reiserfs_fill_super+0x2127/0x2ea0
>  mount_bdev+0x351/0x410
>  legacy_get_tree+0x109/0x220
>  vfs_get_tree+0x8d/0x350
>  path_mount+0x1342/0x1e40
>  __x64_sys_mount+0x283/0x300
>  do_syscall_64+0x39/0xb0
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fb84649146e
> Code: 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
> 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fb84727fa08 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007fb84649146e
> RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007fb84727fa60
> RBP: 00007fb84727faa0 R08: 00007fb84727faa0 R09: 0000000020000000
> R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000000
> R13: 0000000020000100 R14: 00007fb84727fa60 R15: 00000000200003c0
>  </TASK>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> ----------------
> Code disassembly (best guess):
>    0: 01 01                 add    %eax,(%rcx)
>    2: 00 00                 add    %al,(%rax)
>    4: 0f 1f 44 00 00       nopl   0x0(%rax,%rax,1)
>    9: 48 81 fa a8 02 00 00 cmp    $0x2a8,%rdx
>   10: 72 05                 jb     0x17
>   12: 40 38 fe             cmp    %dil,%sil
>   15: 74 48                 je     0x5f
>   17: 48 83 ea 20           sub    $0x20,%rdx
>   1b: 48 83 ea 20           sub    $0x20,%rdx
>   1f: 4c 8b 1e             mov    (%rsi),%r11
>   22: 4c 8b 56 08           mov    0x8(%rsi),%r10
>   26: 4c 8b 4e 10           mov    0x10(%rsi),%r9
> * 2a: 4c 8b 46 18           mov    0x18(%rsi),%r8 <-- trapping instructio=
n
>   2e: 48 8d 76 20           lea    0x20(%rsi),%rsi
>   32: 4c 89 1f             mov    %r11,(%rdi)
>   35: 4c 89 57 08           mov    %r10,0x8(%rdi)
>   39: 4c 89 4f 10           mov    %r9,0x10(%rdi)
>   3d: 4c                   rex.WR
>   3e: 89                   .byte 0x89
>   3f: 47                   rex.RXB
