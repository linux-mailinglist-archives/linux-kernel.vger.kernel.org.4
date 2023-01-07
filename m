Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4334E660C20
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 04:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjAGDNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 22:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjAGDNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 22:13:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2C482F50
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 19:13:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8465B81EBA
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 03:13:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BBC5C433EF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 03:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673061214;
        bh=kHYtHRHGn7twJkIe2cynHtKyyDevJdUo628b3VfPG1s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cPmrnN9wGzbPkN/CM+lMFG7sPDzhiqyKzxMruys0bSUzFKBJvVtE5oFiOBatjp4Dl
         1UeBBKuIo9qH4RzKHPrJBcfpo+rHTv+yojN2/968kn0V6bMocH68yIs6mrfmAMeZuv
         G91k139rNbglkfx6LMAbFUS38pTM1lvl0TX59a9Ts1Lp+H6p0eGIkNaZLvHAHgwWRl
         uHp2K1fCE4qdA8LtmrZi3kQ9kAYv4V/EM9tzuei2z0jGpWEeRfn9VE+AfUAyluK9dw
         QRVaDS3mou75SSCV5Z7P0YuYfGI5BT3nt+kiLLoxSIahAHbTKFyoVnXfuYAwPnDCBL
         ml2W4O75n6gEg==
Received: by mail-ed1-f46.google.com with SMTP id x10so1834307edd.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 19:13:34 -0800 (PST)
X-Gm-Message-State: AFqh2koDjYdek7tbV23TnhSjnom5W6FxC4IzH34y22PHA2ObLTKbVHJ2
        0IwbVsKaLJEwokh01bYaA1Ybe0VQxyhou2qRLeY=
X-Google-Smtp-Source: AMrXdXtTiVczT8IADpqw8kgoiJmJBEiH9C7QTwy2SBSC8cHolHS29dg6CbH0/ykUXzVuTBb1ZIwVbtyslDTt4QC7QP4=
X-Received: by 2002:aa7:dc05:0:b0:47f:b4f3:6dc3 with SMTP id
 b5-20020aa7dc05000000b0047fb4f36dc3mr5147537edu.340.1673061212566; Fri, 06
 Jan 2023 19:13:32 -0800 (PST)
MIME-Version: 1.0
References: <20230106161213.2374093-1-masahiroy@kernel.org>
In-Reply-To: <20230106161213.2374093-1-masahiroy@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 7 Jan 2023 11:13:21 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRor=2FwY2ZesZribpSQkneh8OYMph7unP6_toa2k=S2g@mail.gmail.com>
Message-ID: <CAJF2gTRor=2FwY2ZesZribpSQkneh8OYMph7unP6_toa2k=S2g@mail.gmail.com>
Subject: Re: [PATCH] riscv: fix -Wundef warning for CONFIG_RISCV_BOOT_SPINWAIT
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Myrtle Shah <gatecat@ds0.me>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 7, 2023 at 12:12 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Since commit 80b6093b55e3 ("kbuild: add -Wundef to KBUILD_CPPFLAGS
> for W=1 builds"), building with W=1 detects misuse of #if.
>
>   $ make W=1 ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- arch/riscv/kernel/
>     [snip]
>     AS      arch/riscv/kernel/head.o
>   arch/riscv/kernel/head.S:329:5: warning: "CONFIG_RISCV_BOOT_SPINWAIT" is not defined, evaluates to 0 [-Wundef]
>     329 | #if CONFIG_RISCV_BOOT_SPINWAIT
>         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
>
> CONFIG_RISCV_BOOT_SPINWAIT is a bool option. #ifdef should be used.
Fixes: 2ffc48fc7071 ("RISC-V: Move spinwait booting method to its own config")

Right?

>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/riscv/kernel/head.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index b865046e4dbb..4bf6c449d78b 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -326,7 +326,7 @@ clear_bss_done:
>         call soc_early_init
>         tail start_kernel
>
> -#if CONFIG_RISCV_BOOT_SPINWAIT
> +#ifdef CONFIG_RISCV_BOOT_SPINWAIT
>  .Lsecondary_start:
>         /* Set trap vector to spin forever to help debug */
>         la a3, .Lsecondary_park
> --
> 2.34.1
>


-- 
Best Regards
 Guo Ren
