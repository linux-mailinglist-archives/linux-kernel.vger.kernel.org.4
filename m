Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71EA77132A4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 07:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjE0Fc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 01:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjE0Fcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 01:32:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34E6114
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 22:32:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 848A560EF4
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 05:32:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB407C4339C
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 05:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685165571;
        bh=NgYtuftywdY9FLSkoRc9as8wdNmR5QpobqvD812H/ew=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YZDzXUSAnP53o2yCWlLTATQDPY7oM6ePS4PJmOyH8A+2SdyjiUqRlA7ATj+trPwub
         7UQFANjyzAhvoumjdwbWUhMQZhA97YH7y583/2BqaI7SnpRANDlHPPv7094TT/V4+a
         h2EtDMTl1/Cu9BBAJqC93X+jYVHSHwLfdrwpT1iQz6lBpsNS0Rle7L+IY/3VzQdcKx
         WfQ8/Tg4lC5JggZ1RB5MIPnWlsh1DbuqaQSqS6DIl7nwh9SglumQtZUqgGPWq0R6z4
         xpMIdz0e4qSaWN1x/x5AhMq6Tt/Lshsbbz6Wiyc9g5YViOjEPZymmspQOBLh/6in6J
         q+703Tgr9Wt4w==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-96f7377c86aso258646766b.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 22:32:51 -0700 (PDT)
X-Gm-Message-State: AC+VfDx/FnL1pIt9Aj00wSwAoidq9b+Z7h3GBHz9Z/V34FLmmpm0BOWy
        Bl3lJtaAdFmdZCOQLw+kR8uk0CdK/1gC0K3+Mos=
X-Google-Smtp-Source: ACHHUZ5pS9iHDzXG6sv+ImhknySwnRojiU77ciwfhaWLXqIPZqUdu6433Ha3MYtb1cxY+363JNB0n7ngXTWfsjXM2Hs=
X-Received: by 2002:a17:907:94cf:b0:973:93d6:189f with SMTP id
 dn15-20020a17090794cf00b0097393d6189fmr4286386ejc.61.1685165570124; Fri, 26
 May 2023 22:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230524074132.10916-1-zhanghongchen@loongson.cn>
In-Reply-To: <20230524074132.10916-1-zhanghongchen@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 27 May 2023 13:32:42 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4CC0S7ciLCqdb_AoQ+3-24uo6TZb9Pz7H1yu+mvspFDw@mail.gmail.com>
Message-ID: <CAAhV-H4CC0S7ciLCqdb_AoQ+3-24uo6TZb9Pz7H1yu+mvspFDw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: let pmd_present return true when splitting pmd
To:     Hongchen Zhang <zhanghongchen@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Anshuman,

Excuse me, but could you please tell me something that why commit
b65399f6111b ("arm64/mm: Change THP helpers to comply with generic MM
semantics") needn't be backported to 5.4LTS and 4.19LTS series. The
discussion link you referred is as early as in 2018, before 4.19
released. I think this information is important for us because we want
to know how to handle our 4.19-loongarch codebase.

Huacai

On Wed, May 24, 2023 at 3:42=E2=80=AFPM Hongchen Zhang
<zhanghongchen@loongson.cn> wrote:
>
> when we split a pmd into ptes, pmd_present() and pmd_trans_huge() should
> return true,otherwise it would be treated as a swap pmd.
> As arm64 does in
> commit b65399f6111b ("arm64/mm: Change THP helpers to comply with generic=
 MM semantics")
> we add a _PAGE_PRESENT_INVALID bit for LoongArch.
>
> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
> ---
>  arch/loongarch/include/asm/pgtable-bits.h | 2 ++
>  arch/loongarch/include/asm/pgtable.h      | 3 ++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/include/asm/pgtable-bits.h b/arch/loongarch/i=
nclude/asm/pgtable-bits.h
> index 8b98d22a145b..a7469d28d9d0 100644
> --- a/arch/loongarch/include/asm/pgtable-bits.h
> +++ b/arch/loongarch/include/asm/pgtable-bits.h
> @@ -22,12 +22,14 @@
>  #define        _PAGE_PFN_SHIFT         12
>  #define        _PAGE_SWP_EXCLUSIVE_SHIFT 23
>  #define        _PAGE_PFN_END_SHIFT     48
> +#define _PAGE_PRESENT_INVALID_SHIFT 60
>  #define        _PAGE_NO_READ_SHIFT     61
>  #define        _PAGE_NO_EXEC_SHIFT     62
>  #define        _PAGE_RPLV_SHIFT        63
>
>  /* Used by software */
>  #define _PAGE_PRESENT          (_ULCAST_(1) << _PAGE_PRESENT_SHIFT)
> +#define _PAGE_PRESENT_INVALID  (_ULCAST_(1) << _PAGE_PRESENT_INVALID_SHI=
FT)
>  #define _PAGE_WRITE            (_ULCAST_(1) << _PAGE_WRITE_SHIFT)
>  #define _PAGE_ACCESSED         (_ULCAST_(1) << _PAGE_ACCESSED_SHIFT)
>  #define _PAGE_MODIFIED         (_ULCAST_(1) << _PAGE_MODIFIED_SHIFT)
> diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/includ=
e/asm/pgtable.h
> index d28fb9dbec59..9a9f9ff9b709 100644
> --- a/arch/loongarch/include/asm/pgtable.h
> +++ b/arch/loongarch/include/asm/pgtable.h
> @@ -213,7 +213,7 @@ static inline int pmd_bad(pmd_t pmd)
>  static inline int pmd_present(pmd_t pmd)
>  {
>         if (unlikely(pmd_val(pmd) & _PAGE_HUGE))
> -               return !!(pmd_val(pmd) & (_PAGE_PRESENT | _PAGE_PROTNONE)=
);
> +               return !!(pmd_val(pmd) & (_PAGE_PRESENT | _PAGE_PROTNONE =
| _PAGE_PRESENT_INVALID));
>
>         return pmd_val(pmd) !=3D (unsigned long)invalid_pte_table;
>  }
> @@ -558,6 +558,7 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t ne=
wprot)
>
>  static inline pmd_t pmd_mkinvalid(pmd_t pmd)
>  {
> +       pmd_val(pmd) |=3D _PAGE_PRESENT_INVALID;
>         pmd_val(pmd) &=3D ~(_PAGE_PRESENT | _PAGE_VALID | _PAGE_DIRTY | _=
PAGE_PROTNONE);
>
>         return pmd;
>
> base-commit: f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
> --
> 2.31.1
>
>
