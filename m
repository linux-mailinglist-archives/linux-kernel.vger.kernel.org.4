Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FF7631DA4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiKUKDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiKUKDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:03:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E458E2BE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:03:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7AC560FA7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 10:03:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23413C433C1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 10:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669025022;
        bh=voyOtzVSQJWTMBmIautuhoF+w0ydSWMPpFHG1TdIRoc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dLE4FSTo5gfWwj745MsZJb/i9i8NSHZuiX27Yho/BTMbQpONvq3HhVlNxtlKAW2Fc
         s0RNrRZX5e0CAK2BcbnNd4D0Cw1l1K74rF5Fb+GwS/B713VmN3w/Qbg1X97M4f10vJ
         toAjqdIm0htYhDvRh5/Fz6o0PF7RIyj553rtsQ2Px7UzXqKUd87Q2tx0INUhwKdasg
         H/1QbVzJfnalmtVNYIwyebeEMtsVeNQHUGNIqnoJlDwf9EyhjszRhe2knmQPM4Vc+P
         Tgv4cvm9FSgaSvhZTa0FCsMyizqaxr7xfQYWH/NHKd5siXhPZR3Khd3da9aKj0nq6Z
         a9Zc4k0u4vW+A==
Received: by mail-ed1-f43.google.com with SMTP id e13so15494647edj.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:03:42 -0800 (PST)
X-Gm-Message-State: ANoB5pnGA+HHWwmy6QZY98lOsxYPh4Vb24WN9E6v02vLbwr4rFm3Ldr+
        196GBp4i1lZh1WFSObQaBhqSDvdjiirUlpFOltQ=
X-Google-Smtp-Source: AA0mqf79yrSmnttgU/v91zhk/XWnSN+yH2+oxfA92MwbFwMMv40y4zrateqifULHcO2A1QB3Lr2MyxA+VjEb9MAPYAs=
X-Received: by 2002:aa7:cc04:0:b0:463:1a0c:4dd1 with SMTP id
 q4-20020aa7cc04000000b004631a0c4dd1mr6287783edt.137.1669025020334; Mon, 21
 Nov 2022 02:03:40 -0800 (PST)
MIME-Version: 1.0
References: <20221121064826.2115193-1-chenhuacai@loongson.cn>
In-Reply-To: <20221121064826.2115193-1-chenhuacai@loongson.cn>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 21 Nov 2022 18:03:28 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQpWqL_5n=5dScxrXaquUd6hpp_a9=9DQnR2wdjAJOM6A@mail.gmail.com>
Message-ID: <CAJF2gTQpWqL_5n=5dScxrXaquUd6hpp_a9=9DQnR2wdjAJOM6A@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Set _PAGE_DIRTY only if _PAGE_MODIFIED is set
 in {pmd,pte}_mkwrite()
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 2:51 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> Set _PAGE_DIRTY only if _PAGE_MODIFIED is set in {pmd,pte}_mkwrite().
> Otherwise, _PAGE_DIRTY silences the TLB modify exception and make us
> have no chance to mark a pmd/pte dirty (_PAGE_MODIFIED) for software.
Yes, the "VALID/DIRTY"  is a bad hardware pgtable-bit design. It
caused the software to waste more bits in PTE.  We need hardware
P/R/W/A/D definitions. It seems from MIPS in history, C-SKY also
follows that :P.

Reviewed-by: Guo Ren <guoren@kernel.org>

>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  arch/loongarch/include/asm/pgtable.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
> index debbe116f105..aa0e0e0d4ee5 100644
> --- a/arch/loongarch/include/asm/pgtable.h
> +++ b/arch/loongarch/include/asm/pgtable.h
> @@ -357,7 +357,9 @@ static inline pte_t pte_mkdirty(pte_t pte)
>
>  static inline pte_t pte_mkwrite(pte_t pte)
>  {
> -       pte_val(pte) |= (_PAGE_WRITE | _PAGE_DIRTY);
> +       pte_val(pte) |= _PAGE_WRITE;
> +       if (pte_val(pte) & _PAGE_MODIFIED)
> +               pte_val(pte) |= _PAGE_DIRTY;
>         return pte;
>  }
>
> @@ -457,7 +459,9 @@ static inline int pmd_write(pmd_t pmd)
>
>  static inline pmd_t pmd_mkwrite(pmd_t pmd)
>  {
> -       pmd_val(pmd) |= (_PAGE_WRITE | _PAGE_DIRTY);
> +       pmd_val(pmd) |= _PAGE_WRITE;
> +       if (pmd_val(pmd) & _PAGE_MODIFIED)
> +               pmd_val(pmd) |= _PAGE_DIRTY;
>         return pmd;
>  }
>
> --
> 2.31.1
>


--
Best Regards
 Guo Ren
