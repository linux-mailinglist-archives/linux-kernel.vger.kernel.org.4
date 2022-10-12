Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3C55FC334
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 11:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiJLJld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 05:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiJLJla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 05:41:30 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3217A8782
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 02:41:25 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id j7so19415648ybb.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 02:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QO5UAtsbTOA2QtV51cL1r5mzkqKAD5U2QTqmHsarUI4=;
        b=MfZbYK3iHyCKKWuayMmcfb0qHNyba5LF4B5+66v9+iP4VN+eS1Cx94qouCzQH4x5fN
         B10gmdNgerz27I2ZQ6CcoN+6mK9JLJ2IfMkkGQGBGxSFnDTc2yagQ1/SjBYPpKI61uCy
         WVSWpnkMe4h+4d0VzB/28xJ6kZA2Iz0WGEAVMqtwk9PAD2BWOLNmPybg4TUCXWKBYXTj
         d1hJREGBY2LVdPH1LqZKbkJvL529GXshPxv6MEv6J7YWU0+9wcy7egS1v/HTz634ZLnt
         cwS6bZZvdm/hE3oAmQnvlQUEyxsZwX0rVKX6Hm1joB9ChVaD5BX7Xz6Jc+CjB0ETSJbE
         fd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QO5UAtsbTOA2QtV51cL1r5mzkqKAD5U2QTqmHsarUI4=;
        b=lanBNKKxt7p9GWFL5lhs+usmm0sqyPkUdkBBoRjmyeP4tIrrOhb6nbOz0L0K6zvCFh
         OmOXMj3vJep6iIyepT/+ymqFaEzbyGQUP8qk/f0MumuLO/EXlCBpJOXqUVkG0yfM9Fgp
         zs5lXQBKKIQbdBebXzGeAN3kXxzFMDDkqQKD+cNyu50zD2COrnEfheR1wMcebtBFXmpF
         LXVdSocOxpqH1ddnNcO04PKKCUeI8b6Si7O9RSgdq1oEypwjDXSvT0ReSEcAXuRot6mj
         vuOEktiq31G+CR+GN4Pj4WfigoC03d1Uc92SjMa4x4DtDC8TbGg4CdMnbH/YmiRDgxVB
         RE2A==
X-Gm-Message-State: ACrzQf17rfmPY3Saqbt85Un+FAr1OvR74P5hWJFyJ2hAySenNnM3ls1j
        XKonmtKIf2WZ7QsoviS7LH5qtbeYeWrIjM5GBcEpqyYG2vQ=
X-Google-Smtp-Source: AMsMyM4zzhrpbPSbHUdsO+t9d+lTwYMUO9IV3rHROF7KFdsTtEIQDhlEpD3PTbKR/c8IiciPKdofHwUcXneCwSwnILg=
X-Received: by 2002:a25:2415:0:b0:6be:5349:91c2 with SMTP id
 k21-20020a252415000000b006be534991c2mr28368390ybk.318.1665567684634; Wed, 12
 Oct 2022 02:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <20221011203621.1446507-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221011203621.1446507-1-Liam.Howlett@oracle.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 12 Oct 2022 11:41:13 +0200
Message-ID: <CAKXUXMzVb_gMUOEZJbrysphVqAGD0yN=3A5+N348adrs8q1asQ@mail.gmail.com>
Subject: Re: [PATCH] mmap: Fix copy_vma() failure path
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URI_DOTEDU autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 10:36 PM Liam Howlett <liam.howlett@oracle.com> wrote:
>
> The anon vma was not unlinked and the file was not closed in the failure
> path when the machine runs out of memory during the maple tree
> modification.  This caused a memory leak of the anon vma chain and vma
> since neither would be freed.
>
> Reported-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Fixes: 524e00b36e8c (mm: remove rb tree.)
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---

Here my detailed test report:

First, I ran the reproducer
https://elisa-builder-00.iol.unh.edu/syzkaller-next/report?id=3113810b9abd3dfeb581759df93d3171d1a90f18
on the latest commit from Linus' tree, i.e., commit 49da07006239.
This resulted in the following kernel crash report on x86_64 defconfig
+ syzkaller-recommended debug features:

[  632.446911] kmemleak: 2 new suspected memory leaks (see
/sys/kernel/debug/kmemleak)
[  642.194797] kmemleak: 2 new suspected memory leaks (see
/sys/kernel/debug/kmemleak)

BUG: memory leak
unreferenced object 0xffff88800eab3220 (size 208):
  comm "a.out", pid 411, jiffies 4295289355 (age 20.054s)
  hex dump (first 32 bytes):
    20 32 ab 0e 80 88 ff ff 00 00 00 00 00 00 00 00   2..............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000006344da94>] __anon_vma_prepare+0x288/0x520
    [<0000000079cb6e3d>] __handle_mm_fault+0x1672/0x1a90
    [<000000003165d13e>] handle_mm_fault+0x177/0x520
    [<00000000d502ed60>] __get_user_pages+0x696/0x13b0
    [<000000000c44f161>] populate_vma_page_range+0x242/0x320
    [<00000000429a417a>] __mm_populate+0x1c6/0x3b0
    [<00000000988f9924>] do_mlock+0x3ad/0x6f0
    [<0000000099ba0e21>] __x64_sys_mlock2+0xba/0x100
    [<00000000a302ea0e>] do_syscall_64+0x3a/0x90
    [<0000000069487f88>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff88800ef27ba0 (size 64):
  comm "a.out", pid 411, jiffies 4295289357 (age 20.053s)
  hex dump (first 32 bytes):
    30 3c 94 09 80 88 ff ff 20 32 ab 0e 80 88 ff ff  0<...... 2......
    78 3c 94 09 80 88 ff ff 78 3c 94 09 80 88 ff ff  x<......x<......
  backtrace:
    [<00000000ecf2fb6f>] anon_vma_clone+0xd3/0x590
    [<00000000e1cdd897>] copy_vma+0x3ea/0x7f0
    [<00000000ef59b15d>] move_vma.isra.48+0x8e6/0xf40
    [<00000000cf84e8ba>] mremap_to.isra.49+0x4d0/0x6c0
    [<00000000cf08a1f8>] __x64_sys_mremap+0x9cc/0xf20
    [<00000000a302ea0e>] do_syscall_64+0x3a/0x90
    [<0000000069487f88>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff88800df86330 (size 208):
  comm "a.out", pid 412, jiffies 4295296993 (age 12.417s)
  hex dump (first 32 bytes):
    30 63 f8 0d 80 88 ff ff 00 00 00 00 00 00 00 00  0c..............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000006344da94>] __anon_vma_prepare+0x288/0x520
    [<0000000079cb6e3d>] __handle_mm_fault+0x1672/0x1a90
    [<000000003165d13e>] handle_mm_fault+0x177/0x520
    [<00000000d502ed60>] __get_user_pages+0x696/0x13b0
    [<000000000c44f161>] populate_vma_page_range+0x242/0x320
    [<00000000429a417a>] __mm_populate+0x1c6/0x3b0
    [<00000000988f9924>] do_mlock+0x3ad/0x6f0
    [<0000000099ba0e21>] __x64_sys_mlock2+0xba/0x100
    [<00000000a302ea0e>] do_syscall_64+0x3a/0x90
    [<0000000069487f88>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888015235180 (size 64):
  comm "a.out", pid 412, jiffies 4295296995 (age 12.415s)
  hex dump (first 32 bytes):
    00 fd 57 0d 80 88 ff ff 30 63 f8 0d 80 88 ff ff  ..W.....0c......
    48 fd 57 0d 80 88 ff ff 48 fd 57 0d 80 88 ff ff  H.W.....H.W.....
  backtrace:
    [<00000000ecf2fb6f>] anon_vma_clone+0xd3/0x590
    [<00000000e1cdd897>] copy_vma+0x3ea/0x7f0
    [<00000000ef59b15d>] move_vma.isra.48+0x8e6/0xf40
    [<00000000cf84e8ba>] mremap_to.isra.49+0x4d0/0x6c0
    [<00000000cf08a1f8>] __x64_sys_mremap+0x9cc/0xf20
    [<00000000a302ea0e>] do_syscall_64+0x3a/0x90
    [<0000000069487f88>] entry_SYSCALL_64_after_hwframe+0x63/0xcd


This is just as expected and as I reported it to Liam.

Then, I applied this patch here, rebuilt the kernel and re-ran the
reproducer. After roughly running the reproducer for 15 minutes, it
did not show any kernel crash report. So, the patch seems to have
solved the reported issue.

Tested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Thanks, Liam.

Lukas
