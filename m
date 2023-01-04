Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7036465CEBF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 09:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbjADIvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 03:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238976AbjADIvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 03:51:01 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B6418E04
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 00:48:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AE7FBCE16E6
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 08:48:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76B1C43396
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 08:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672822119;
        bh=x+pZHCEf+gCp8ljkUtapLHlz3SrGepACquhwLvCQrwM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ct5OOGgVF7oZbygyWdBF0mCA6m0X8EGwV1yzkl4ttxcHSmohW8ZCz+s30CxC5lNPz
         uTAViqApOSwR9nyd2iPQtA/exdh6s//FAvaR9MKnGGxMiIZaYtqTZO/s2Jqn4Zl8Fj
         6CAkJLaImV0xxUJe0Vj/899X/TMO73rViHUUZJamPGZI5psmX44GDrRC7FaOXCFa5T
         HXpnLWgTZA+qbxVzEdvyC1n4MIYhLFuEbLLXdcgjlAs0J84OwzS7IIaEbTCbaYJbKv
         IOr/f4PQ+qlixJyHur4O3ztApmPW3+Fh4pBCQtdEC3zvMCol04gguEG+sEu0b0vwgz
         OgZv5rY2CQTyg==
Received: by mail-ej1-f50.google.com with SMTP id ud5so81031016ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 00:48:39 -0800 (PST)
X-Gm-Message-State: AFqh2kpCyxM1J1H0ISkRDJjawV3pdEN4vG+H8dJLVGG2r7n7xBZV/0M1
        eGfLRJHSAgf45bXyMV8kYYfkLTgprulY0mTFnCA=
X-Google-Smtp-Source: AMrXdXvxQagdXyWyFLKDic95BL/Fg668DmvP+3KepetHctDyaL+FsaSKkrQVJ+86bkwalde7/J5f4RxpIxHTDH7N/EU=
X-Received: by 2002:a17:906:33d4:b0:7c0:f7af:7c5e with SMTP id
 w20-20020a17090633d400b007c0f7af7c5emr3146027eja.406.1672822117921; Wed, 04
 Jan 2023 00:48:37 -0800 (PST)
MIME-Version: 1.0
References: <20230104074146.578485-1-uwu@icenowy.me> <20230104074146.578485-2-uwu@icenowy.me>
In-Reply-To: <20230104074146.578485-2-uwu@icenowy.me>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 4 Jan 2023 16:48:24 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQp1bOp9kfoOkbvNnSXQhzrCpG3rn8C+LPPoJtMCCDOdA@mail.gmail.com>
Message-ID: <CAJF2gTQp1bOp9kfoOkbvNnSXQhzrCpG3rn8C+LPPoJtMCCDOdA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] riscv: errata: cmo: add CMO macro variant with
 both VA and PA
To:     Icenowy Zheng <uwu@icenowy.me>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>,
        Samuel Holland <samuel@sholland.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx for the patch! It's nice.

Reviewed-by: Guo Ren <guoren@kernel.org>

On Wed, Jan 4, 2023 at 3:42 PM Icenowy Zheng <uwu@icenowy.me> wrote:
>
> The standardized Zicbom extension supports only VA, however there's some
> vendor extensions (e.g. XtheadCmo) that can handle cache management
> operations on PA directly, bypassing the TLB lookup.
>
> Add a CMO alternatives macro variant that come with both VA and PA
> supplied, and the code can be patched to use either the VA or the PA at
> runtime. In this case the codepath is now patched to use VA for Zicbom
> and PA for XtheadCmo.
>
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---
>  arch/riscv/include/asm/errata_list.h | 30 ++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> index 46adc1c9428f..bf80dd58145e 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -118,6 +118,9 @@ asm volatile(ALTERNATIVE(                                           \
>  #define THEAD_clean_A0 ".long 0x0255000b"
>  #define THEAD_flush_A0 ".long 0x0275000b"
>  #define THEAD_SYNC_S   ".long 0x0190000b"
> +#define THEAD_inval_PA_A0      ".long 0x02a5000b"
> +#define THEAD_clean_PA_A0      ".long 0x0295000b"
> +#define THEAD_flush_PA_A0      ".long 0x02b5000b"
>
>  #define ALT_CMO_OP(_op, _start, _size, _cachesize)                     \
>  asm volatile(ALTERNATIVE_2(                                            \
> @@ -144,6 +147,33 @@ asm volatile(ALTERNATIVE_2(                                                \
>             "r"((unsigned long)(_start) + (_size))                      \
>         : "a0")
>
> +#define ALT_CMO_OP_VPA(_op, _vaddr, _paddr, _size, _cachesize)         \
> +asm volatile(ALTERNATIVE_2(                                            \
> +       __nops(6),                                                      \
> +       "mv a0, %1\n\t"                                                 \
> +       "j 2f\n\t"                                                      \
> +       "3:\n\t"                                                        \
> +       "cbo." __stringify(_op) " (a0)\n\t"                             \
> +       "add a0, a0, %0\n\t"                                            \
> +       "2:\n\t"                                                        \
> +       "bltu a0, %2, 3b\n\t"                                           \
> +       "nop", 0, CPUFEATURE_ZICBOM, CONFIG_RISCV_ISA_ZICBOM,           \
> +       "mv a0, %3\n\t"                                                 \
> +       "j 2f\n\t"                                                      \
> +       "3:\n\t"                                                        \
> +       THEAD_##_op##_PA_A0 "\n\t"                                      \
> +       "add a0, a0, %0\n\t"                                            \
> +       "2:\n\t"                                                        \
> +       "bltu a0, %4, 3b\n\t"                                           \
> +       THEAD_SYNC_S, THEAD_VENDOR_ID,                                  \
> +                       ERRATA_THEAD_CMO, CONFIG_ERRATA_THEAD_CMO)      \
> +       : : "r"(_cachesize),                                            \
> +           "r"((unsigned long)(_vaddr) & ~((_cachesize) - 1UL)),       \
> +           "r"((unsigned long)(_vaddr) + (_size)),                     \
> +           "r"((unsigned long)(_paddr) & ~((_cachesize) - 1UL)),       \
> +           "r"((unsigned long)(_paddr) + (_size))                      \
> +       : "a0")
> +
>  #define THEAD_C9XX_RV_IRQ_PMU                  17
>  #define THEAD_C9XX_CSR_SCOUNTEROF              0x5c5
>
> --
> 2.38.1
>


-- 
Best Regards
 Guo Ren
