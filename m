Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D89649F70
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbiLLNIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbiLLNIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:08:19 -0500
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573F411151;
        Mon, 12 Dec 2022 05:08:16 -0800 (PST)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 2BCD807b015352;
        Mon, 12 Dec 2022 22:08:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 2BCD807b015352
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1670850481;
        bh=60Bgpu0atlDkoRoUv+KHKiAoEPhzrlitVEuwVEjISH8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S1R8EygUdT0sePVuwyu0xVcBa/332qFMxveWrw988yuTPqcdlCYpH0J01FRF9GqRq
         6NAYUO6z6X8AWUmIj4fKF2AsETdOJnH2x89E7eB80ZHY5t1lXgDObzGiQByt6BSatZ
         KNnqsSHvAJMiTDsx9J6TKEOCW6VDImfE83tpC8QPwfSU3zxx3ls3Azb9z7nQAI4HJu
         1rTFJ1wbdy5xctyM2sikSwR28raiGgVdZzX9mmr1GfpspGtDprHH9OzkyWMmA/J+8+
         ZCYMyEdTf8XWhY9XkhnpVMOWF4S7nHPg5O8U9EDN7y99Xp+jWcY2fepFinQBSYL/Ak
         NEpGscyytV1lQ==
X-Nifty-SrcIP: [209.85.160.43]
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-14455716674so8249231fac.7;
        Mon, 12 Dec 2022 05:08:01 -0800 (PST)
X-Gm-Message-State: ANoB5pnGXeV3M2meTJvl04Bxv3Kh2TJXXPyFfuO3ReGGaNz3bf/BMlrx
        /nOIPnDc6owATRfwbo/diMK2GhuU9PMeKSUXrm8=
X-Google-Smtp-Source: AA0mqf7M4QfjT3R/GEAqDtO/Cby83qpELei3PVXnETZgJx/Q5WFbXGO/tMYP5+mZ+gL2OQ5qEKbSaAk/zOFU3ItDe8k=
X-Received: by 2002:a05:6870:c7b4:b0:144:d060:72e with SMTP id
 dy52-20020a056870c7b400b00144d060072emr5970097oab.287.1670850480174; Mon, 12
 Dec 2022 05:08:00 -0800 (PST)
MIME-Version: 1.0
References: <20221207191657.2852229-1-nathan@kernel.org> <20221207191657.2852229-2-nathan@kernel.org>
In-Reply-To: <20221207191657.2852229-2-nathan@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 12 Dec 2022 22:07:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNARoxqSzjpM0twcssMkf9X_PppzqtUo_opq=CX+zixma8g@mail.gmail.com>
Message-ID: <CAK7LNARoxqSzjpM0twcssMkf9X_PppzqtUo_opq=CX+zixma8g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] padata: Mark padata_work_init() as __ref
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Nicolas Schier <nicolas@fjasle.eu>,
        Sami Tolvanen <samitolvanen@google.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 8, 2022 at 4:17 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> When building arm64 allmodconfig + ThinLTO with clang and a proposed
> modpost update to account for -ffuncton-sections, the following warning
> appears:
>
>   WARNING: modpost: vmlinux.o: section mismatch in reference: padata_work_init (section: .text.padata_work_init) -> padata_mt_helper (section: .init.text)
>   WARNING: modpost: vmlinux.o: section mismatch in reference: padata_work_init (section: .text.padata_work_init) -> padata_mt_helper (section: .init.text)
>
> LLVM has optimized padata_work_init() to include the address of
> padata_mt_helper() directly, which causes modpost to complain since
> padata_work_init() is not __init, whereas padata_mt_helper() is. In
> reality, padata_work_init() is only called with padata_mt_helper() as
> the work_fn argument in code that is __init, so this warning will not
> result in any problems. Silence it with __ref, which makes it clear to
> modpost that padata_work_init() can only use padata_mt_helper() in
> __init code.
>
> Suggested-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> Cc: Steffen Klassert <steffen.klassert@secunet.com>
> Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
> Cc: linux-crypto@vger.kernel.org
> ---
>  kernel/padata.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/padata.c b/kernel/padata.c
> index e5819bb8bd1d..4c3137fe8449 100644
> --- a/kernel/padata.c
> +++ b/kernel/padata.c
> @@ -83,8 +83,8 @@ static struct padata_work *padata_work_alloc(void)
>         return pw;
>  }
>
> -static void padata_work_init(struct padata_work *pw, work_func_t work_fn,
> -                            void *data, int flags)
> +static __ref void padata_work_init(struct padata_work *pw, work_func_t work_fn,
> +                                  void *data, int flags)
>  {
>         if (flags & PADATA_WORK_ONSTACK)
>                 INIT_WORK_ONSTACK(&pw->pw_work, work_fn);
>
> base-commit: 76dcd734eca23168cb008912c0f69ff408905235
> --
> 2.38.1
>

It took me a while to understand why LTO can embed
padata_mt_helper's address into padata_work_init().


There are 3 call-sites to padata_work_init().

(1)  __init padata_work_alloc_mt()
         -->  padata_work_init(..., padata_mt_helper, ...)

(2) padata_do_parallel()
         -->  padata_work_init(..., padata_parallel_worker, ...)

(3) __init padata_do_multithreaded()
        --> padata_work_init(..., padata_mt_helper, ...)


The function call (2) is squashed away.


With only (1) and (3) remaining, the 2nd parameter to
padata_work_init() is always padata_mt_helper,
therefore LLVM embeds padata_mt_hlper's address
directly into padata_work_init().

I am not sure if the compiler should do this level of optimization
because kernel/padata.c does not seem to be a special case.
Perhaps, we might be hit with more cases that need __ref annotation,
which is only required by LTO.

One note is that, we could discard padata_work_init()
because (1) and (3) are both annotated as __init.
So, another way of fixing is
   static __always_inline void padata_work_init(...)
because the compiler would determine padata_work_init()
would be small enough if the caller and callee belonged to
the same section.

I do not have a strong opinion.
Honestly, I do not know what the best approach would be to fix this.


If we go with the __ref annotation, I can pick this, but
at least can you add some comments?


include/linux/init.h says:
"optimally document why the __ref is needed and why it's OK"


I think this is the case that needs some comments
because LTO optimization looks too tricky to me.







-- 
Best Regards
Masahiro Yamada
