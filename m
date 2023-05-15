Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036D770293A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 11:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240765AbjEOJmn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 15 May 2023 05:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240702AbjEOJmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 05:42:19 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921E930E7;
        Mon, 15 May 2023 02:39:10 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-ba74affaf35so3445475276.0;
        Mon, 15 May 2023 02:39:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684143532; x=1686735532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvFU0BstB/n7JNs68o15ZW/f4y85+yMBEC8vi+Lmbbw=;
        b=OiYy7J8HN2J4Z6i29TRZkJlYt/LWsuouIe1Q9JUw0n8QpCCkSatSt5JOvgnIq3T6du
         ErqKGGSiMN5y0RJnb4F3sgNR0rzyxzDyS8cjasMDNKAEhZzwolnUUukZJeKw3Z9hmsN6
         B7QQMCoa7FkdPx0cqpz5YBo4Qyn+gppZ4qSaOw7Q5Qoj4VCbHzj/GEZA4IlRNt81+SN1
         yxy7SQPZ0gAc8wA5m/JueOPA9RkcsuxXi8WMmst9FJBKd5BCPZJ2rLWZ2eqEwoDkmO5V
         ZuAGADOU7skWDIdNomG+fzxe4qRa0YFA1VKM6rMH2dPLrrIuTZPul/B2IiQ/h9/+rVu8
         qlwg==
X-Gm-Message-State: AC+VfDxKuJO7iL1grVtfqnDUxv1+MUK5Z0gxuPxlc46ZV+oapx2Hmxb7
        l0QhRHVkMGRC37XLnTkZzNUVHQyv0ebq1Q==
X-Google-Smtp-Source: ACHHUZ6lhqjcYjNIATy/tvDNpwz4uR/ymTWyw7tp2tSbIY5bcbdwr/kdylx3u4aMwtSxFKNOfVZLgg==
X-Received: by 2002:a81:48c6:0:b0:55a:3ce9:dc3d with SMTP id v189-20020a8148c6000000b0055a3ce9dc3dmr31655264ywa.13.1684143532183;
        Mon, 15 May 2023 02:38:52 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id h188-20020a0dc5c5000000b00545c373f7c0sm7687862ywd.139.2023.05.15.02.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 02:38:51 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-55a44a2637bso181490147b3.2;
        Mon, 15 May 2023 02:38:51 -0700 (PDT)
X-Received: by 2002:a0d:e209:0:b0:555:cbdc:c6 with SMTP id l9-20020a0de209000000b00555cbdc00c6mr30150231ywe.9.1684143531314;
 Mon, 15 May 2023 02:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <d4e2a586e793cc8d9442595684ab8a077c0fe726.1678783919.git.fthain@linux-m68k.org>
In-Reply-To: <d4e2a586e793cc8d9442595684ab8a077c0fe726.1678783919.git.fthain@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 15 May 2023 11:38:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXqgzh-_zwirAB+FXSZbuJ6WpML_kMdTRUD_=-Rpx0T5w@mail.gmail.com>
Message-ID: <CAMuHMdXqgzh-_zwirAB+FXSZbuJ6WpML_kMdTRUD_=-Rpx0T5w@mail.gmail.com>
Subject: Re: [PATCH] nubus: Partially revert proc_create_single_data() conversion
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Christoph Hellwig <hch@lst.de>, stable@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 9:53 AM Finn Thain <fthain@linux-m68k.org> wrote:
> The conversion to proc_create_single_data() introduced a regression
> whereby reading a file in /proc/bus/nubus results in a seg fault:
>
>  # grep -r . /proc/bus/nubus/e/
> Data read fault at 0x00000020 in Super Data (pc=0x1074c2)
> BAD KERNEL BUSERR
> Oops: 00000000
> Modules linked in:
> PC: [<001074c2>] PDE_DATA+0xc/0x16
> SR: 2010  SP: 38284958  a2: 01152370
> d0: 00000001    d1: 01013000    d2: 01002790    d3: 00000000
> d4: 00000001    d5: 0008ce2e    a0: 00000000    a1: 00222a40
> Process grep (pid: 45, task=142f8727)
> Frame format=B ssw=074d isc=2008 isb=4e5e daddr=00000020 dobuf=01199e70
> baddr=001074c8 dibuf=ffffffff ver=f
> Stack from 01199e48:
>         01199e70 00222a58 01002790 00000000 011a3000 01199eb0 015000c0 00000000
>         00000000 01199ec0 01199ec0 000d551a 011a3000 00000001 00000000 00018000
>         d003f000 00000003 00000001 0002800d 01052840 01199fa8 c01f8000 00000000
>         00000029 0b532b80 00000000 00000000 00000029 0b532b80 01199ee4 00103640
>         011198c0 d003f000 00018000 01199fa8 00000000 011198c0 00000000 01199f4c
>         000b3344 011198c0 d003f000 00018000 01199fa8 00000000 00018000 011198c0
> Call Trace: [<00222a58>] nubus_proc_rsrc_show+0x18/0xa0
>  [<000d551a>] seq_read+0xc4/0x510
>  [<00018000>] fp_fcos+0x2/0x82
>  [<0002800d>] __sys_setreuid+0x115/0x1c6
>  [<00103640>] proc_reg_read+0x5c/0xb0
>  [<00018000>] fp_fcos+0x2/0x82
>  [<000b3344>] __vfs_read+0x2c/0x13c
>  [<00018000>] fp_fcos+0x2/0x82
>  [<00018000>] fp_fcos+0x2/0x82
>  [<000b8aa2>] sys_statx+0x60/0x7e
>  [<000b34b6>] vfs_read+0x62/0x12a
>  [<00018000>] fp_fcos+0x2/0x82
>  [<00018000>] fp_fcos+0x2/0x82
>  [<000b39c2>] ksys_read+0x48/0xbe
>  [<00018000>] fp_fcos+0x2/0x82
>  [<000b3a4e>] sys_read+0x16/0x1a
>  [<00018000>] fp_fcos+0x2/0x82
>  [<00002b84>] syscall+0x8/0xc
>  [<00018000>] fp_fcos+0x2/0x82
>  [<0000c016>] not_ext+0xa/0x18
> Code: 4e5e 4e75 4e56 0000 206e 0008 2068 ffe8 <2068> 0020 2008 4e5e 4e75 4e56 0000 2f0b 206e 0008 2068 0004 2668 0020 206b ffe8
> Disabling lock debugging due to kernel taint
>
> Segmentation fault
>
> The proc_create_single_data() conversion does not work because
> single_open(file, nubus_proc_rsrc_show, PDE_DATA(inode)) is not
> equivalent to the original code.
>
> Fixes: 3f3942aca6da ("proc: introduce proc_create_single{,_data}")
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: stable@vger.kernel.org # 5.6+
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v6.5 branch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
