Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59158693BB1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 02:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjBMBUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 20:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBMBUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 20:20:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBCCDBF1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 17:20:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9DF1AB80DE9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56431C433A1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676251213;
        bh=tMn82ZFgecAOke6UY7vDBe002Fq1P54OXLQ/Ss8d7MY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CDadx8BK8ujuBS8OdbaYHormLblZTzajxc6ecVyodekjAiSOn9wzAPbhv7W0ftm0E
         Ny+fMgzm6OIEdqiV57zaenus91gh5yo2M9tOYHyB1AiJvxglpJQPnJhrg9tt7DSBwO
         SwqbCHU3r21RwdGiuFxIM9deTa6SVNX1ZVzjdsbfTFRUnfSG8jeverlb1Lhy6oWcXZ
         vu7oVe7j5hO175IEU5ZlPRcG4zT89AMwxT2cHjN9AcYyWZL34mwCQNsTaChLuJRJk1
         MJcRi9udcXGK0YAKjaJUZCWmRlgkY5gIKpoO2/9QHh8ftEIXwAjqamHblf+KtCT8hS
         KFlko8t19bxAA==
Received: by mail-ej1-f51.google.com with SMTP id ml19so28433722ejb.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 17:20:13 -0800 (PST)
X-Gm-Message-State: AO0yUKUdobw+XQTg2HMVkFJej0rAc1JVaXcI0nV11REboRiLJLu7M8Az
        KFYqK11kIBBAC1dz6cpSAMUoYbOtJ3Kxg5r2hes=
X-Google-Smtp-Source: AK7set8qmyH8LWQvKpy+BVdOAVhp0PQFwgzl+tpl/5bU6AF/bFHYEeTvmB/c1xtbDyPVXioudecilbEWcgUeLo4MESc=
X-Received: by 2002:a17:907:9710:b0:8af:3ddd:c43c with SMTP id
 jg16-20020a170907971000b008af3dddc43cmr4554736ejc.1.1676251211491; Sun, 12
 Feb 2023 17:20:11 -0800 (PST)
MIME-Version: 1.0
References: <20230212021534.59121-1-samuel@sholland.org> <20230212021534.59121-3-samuel@sholland.org>
In-Reply-To: <20230212021534.59121-3-samuel@sholland.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 13 Feb 2023 09:19:59 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSMAhweKKaztFz1G3Y_PUJwAvugRSHhKM69pA-VqnCs3g@mail.gmail.com>
Message-ID: <CAJF2gTSMAhweKKaztFz1G3Y_PUJwAvugRSHhKM69pA-VqnCs3g@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: Fix Zbb alternative IDs
To:     Samuel Holland <samuel@sholland.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Andrew Jones <ajones@ventanamicro.com>,
        Christoph Muellner <christoph.muellner@vrull.eu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Guo Ren <guoren@kernel.org>

On Sun, Feb 12, 2023 at 10:15 AM Samuel Holland <samuel@sholland.org> wrote:
>
> Commit 4bf8860760d9 ("riscv: cpufeature: extend
> riscv_cpufeature_patch_func to all ISA extensions") switched ISA
> extension alternatives to use the RISCV_ISA_EXT_* macros instead of
> CPUFEATURE_*. This was mismerged when applied on top of the Zbb series,
> so the Zbb alternatives referenced the wrong errata ID values.
>
> Fixes: 9daca9a5b9ac ("Merge patch series "riscv: improve boot time isa extensions handling"")
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>
>  arch/riscv/include/asm/errata_list.h | 5 -----
>  arch/riscv/lib/strcmp.S              | 2 +-
>  arch/riscv/lib/strlen.S              | 2 +-
>  arch/riscv/lib/strncmp.S             | 2 +-
>  4 files changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> index e158439029ce..274c6f889602 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -23,11 +23,6 @@
>  #define        ERRATA_THEAD_NUMBER 3
>  #endif
>
> -#define        CPUFEATURE_SVPBMT 0
> -#define        CPUFEATURE_ZICBOM 1
> -#define        CPUFEATURE_ZBB 2
> -#define        CPUFEATURE_NUMBER 3
> -
>  #ifdef __ASSEMBLY__
>
>  #define ALT_INSN_FAULT(x)                                              \
> diff --git a/arch/riscv/lib/strcmp.S b/arch/riscv/lib/strcmp.S
> index 8148b6418f61..986ab23fe787 100644
> --- a/arch/riscv/lib/strcmp.S
> +++ b/arch/riscv/lib/strcmp.S
> @@ -9,7 +9,7 @@
>  /* int strcmp(const char *cs, const char *ct) */
>  SYM_FUNC_START(strcmp)
>
> -       ALTERNATIVE("nop", "j strcmp_zbb", 0, CPUFEATURE_ZBB, CONFIG_RISCV_ISA_ZBB)
> +       ALTERNATIVE("nop", "j strcmp_zbb", 0, RISCV_ISA_EXT_ZBB, CONFIG_RISCV_ISA_ZBB)
>
>         /*
>          * Returns
> diff --git a/arch/riscv/lib/strlen.S b/arch/riscv/lib/strlen.S
> index 0f9dbf93301a..8345ceeee3f6 100644
> --- a/arch/riscv/lib/strlen.S
> +++ b/arch/riscv/lib/strlen.S
> @@ -9,7 +9,7 @@
>  /* int strlen(const char *s) */
>  SYM_FUNC_START(strlen)
>
> -       ALTERNATIVE("nop", "j strlen_zbb", 0, CPUFEATURE_ZBB, CONFIG_RISCV_ISA_ZBB)
> +       ALTERNATIVE("nop", "j strlen_zbb", 0, RISCV_ISA_EXT_ZBB, CONFIG_RISCV_ISA_ZBB)
>
>         /*
>          * Returns
> diff --git a/arch/riscv/lib/strncmp.S b/arch/riscv/lib/strncmp.S
> index 7940ddab2d48..ee49595075be 100644
> --- a/arch/riscv/lib/strncmp.S
> +++ b/arch/riscv/lib/strncmp.S
> @@ -9,7 +9,7 @@
>  /* int strncmp(const char *cs, const char *ct, size_t count) */
>  SYM_FUNC_START(strncmp)
>
> -       ALTERNATIVE("nop", "j strncmp_zbb", 0, CPUFEATURE_ZBB, CONFIG_RISCV_ISA_ZBB)
> +       ALTERNATIVE("nop", "j strncmp_zbb", 0, RISCV_ISA_EXT_ZBB, CONFIG_RISCV_ISA_ZBB)
>
>         /*
>          * Returns
> --
> 2.37.4
>


-- 
Best Regards
 Guo Ren
