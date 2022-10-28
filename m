Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D2C61195C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJ1RhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ1RhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:37:14 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2661DDC3A
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:37:13 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id b5so5424817pgb.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a+li78DrGSK0ewlYCLMLzeJKRgoZ+y8QKRuoLOq5e3o=;
        b=QysiwnWPktOjRDNYFCZrj3cImo4AMval0axg9pzM7XyrwblR6l+Wpy6l1l8suk8mIs
         xoIWb0F+iI5w55+XMaw7UYFkz0ZhTSHTc6OQLfP4IU6x2gz6sF4QU17FB+qUHGnONzt6
         HDMBEBZbcmGPECgqzj/y4yStUfYcxCjr0CVYRO7RUaj3Oo/LVGWt0sPKpj5/KrcNbTQd
         kulzxQrO5ed8H71KgdjLUnt/mW2WrkoKIzj7pvcZwnDbaogSFxY7/XlaEEwdXeAHlfkW
         vm4uHA6NVGuSBI0LYkvgKQ7PU8EZ2yA8kYIPHFsQtJkmuHZfQkY+AHwrFLCTk4o0oFdK
         yGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a+li78DrGSK0ewlYCLMLzeJKRgoZ+y8QKRuoLOq5e3o=;
        b=P94eUmx8b6+E32/u5af6t2HroUXEi6LzAT4M8JMIJ/Uz3RIYBrDtUrDzhueT1sP4Xi
         KjxbrRwNCqExVH3Fe/7t2f02VqloerG42rdcvp+97MYT9tSfzqFmtGXuQ+fXMZG6g3Sv
         y1WRBc/2k3BILtmLFr5i9MhlKM1PlXhGwq5geqY9VnhgzfXxyeQF13hgdJzztymHR18q
         tGNe/v0gpxxD521q+iXSTsuEyn0x9QMSsP0K6QDRJhFKAejRac4WHZlOLgS2Y14iCXGa
         niVKqMzJ9HyJfNSWLlW7AvZrTV+qJIR1RDK3fLtI4711eUiAWQ3q3XqVgjUD6IAHNeEr
         4FsA==
X-Gm-Message-State: ACrzQf37WN29pIijFRg4nLYZfgTFwZ24kKCdKJijGZteIreGu8FzsWsv
        vpMiamZFRGlCh2JLDeFMrP+N6EYk3qgfJvTqaR0=
X-Google-Smtp-Source: AMsMyM6tLFwM6elSlrP53OFo/LB8RZaL5I7T3eWcw4ZZj8N6FFbvAeGsd8vrHkuEv6SxC1SdNx5TLmB46Ea+xEM+QFg=
X-Received: by 2002:a63:6d8a:0:b0:46f:57e9:f933 with SMTP id
 i132-20020a636d8a000000b0046f57e9f933mr535366pgc.195.1666978633024; Fri, 28
 Oct 2022 10:37:13 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000553fc805ec1380e0@google.com>
In-Reply-To: <000000000000553fc805ec1380e0@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 28 Oct 2022 10:37:00 -0700
Message-ID: <CAHbLzkox2F1f52BADJ86wHGnQCOMySxjynNUEx+wYZSMMn456A@mail.gmail.com>
Subject: Re: [syzbot] WARNING in alloc_charge_hpage
To:     syzbot <syzbot+0044b22d177870ee974f@syzkaller.appspotmail.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
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

On Fri, Oct 28, 2022 at 12:49 AM syzbot
<syzbot+0044b22d177870ee974f@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    a70385240892 Merge tag 'perf_urgent_for_v6.1_rc2' of git:/..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=13f4726a880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ea03ca45176080bc
> dashboard link: https://syzkaller.appspot.com/bug?extid=0044b22d177870ee974f
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13726f72880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b57436880000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/5e17f1e83cf3/disk-a7038524.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/f8ef729877f7/vmlinux-a7038524.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+0044b22d177870ee974f@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 3646 at include/linux/gfp.h:221 __alloc_pages_node include/linux/gfp.h:221 [inline]
> WARNING: CPU: 1 PID: 3646 at include/linux/gfp.h:221 hpage_collapse_alloc_page mm/khugepaged.c:807 [inline]
> WARNING: CPU: 1 PID: 3646 at include/linux/gfp.h:221 alloc_charge_hpage+0x802/0xaa0 mm/khugepaged.c:963

It looks like the node requested by the allocation is offlined, and
the allocation is using __GFP_THISNODE. It doesn't sound like
khugepaged specific problem IIUC, I don't see other callsites do
anything to prevent the node from being offlined.

Shall we remove that warn? The page allocation call will return NULL
anyway. Or we could just ignore the warn?

> Modules linked in:
> CPU: 1 PID: 3646 Comm: syz-executor210 Not tainted 6.1.0-rc1-syzkaller-00454-ga70385240892 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
> RIP: 0010:__alloc_pages_node include/linux/gfp.h:221 [inline]
> RIP: 0010:hpage_collapse_alloc_page mm/khugepaged.c:807 [inline]
> RIP: 0010:alloc_charge_hpage+0x802/0xaa0 mm/khugepaged.c:963
> Code: e5 01 4c 89 ee e8 6e f9 ae ff 4d 85 ed 0f 84 28 fc ff ff e8 70 fc ae ff 48 8d 6b ff 4c 8d 63 07 e9 16 fc ff ff e8 5e fc ae ff <0f> 0b e9 96 fa ff ff 41 bc 1a 00 00 00 e9 86 fd ff ff e8 47 fc ae
> RSP: 0018:ffffc90003fdf7d8 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: ffff888077f457c0 RSI: ffffffff81cd8f42 RDI: 0000000000000001
> RBP: ffff888079388c0c R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000000
> FS:  00007f6b48ccf700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f6b48a819f0 CR3: 00000000171e7000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  collapse_file+0x1ca/0x5780 mm/khugepaged.c:1715
>  hpage_collapse_scan_file+0xd6c/0x17a0 mm/khugepaged.c:2156
>  madvise_collapse+0x53a/0xb40 mm/khugepaged.c:2611
>  madvise_vma_behavior+0xd0a/0x1cc0 mm/madvise.c:1066
>  madvise_walk_vmas+0x1c7/0x2b0 mm/madvise.c:1240
>  do_madvise.part.0+0x24a/0x340 mm/madvise.c:1419
>  do_madvise mm/madvise.c:1432 [inline]
>  __do_sys_madvise mm/madvise.c:1432 [inline]
>  __se_sys_madvise mm/madvise.c:1430 [inline]
>  __x64_sys_madvise+0x113/0x150 mm/madvise.c:1430
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f6b48a4eef9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f6b48ccf318 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
> RAX: ffffffffffffffda RBX: 00007f6b48af0048 RCX: 00007f6b48a4eef9
> RDX: 0000000000000019 RSI: 0000000000600003 RDI: 0000000020000000
> RBP: 00007f6b48af0040 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6b48aa53a4
> R13: 00007f6b48bffcbf R14: 00007f6b48ccf400 R15: 0000000000022000
>  </TASK>
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
>
