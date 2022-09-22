Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB115E5B2E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 08:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiIVGRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 02:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiIVGRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 02:17:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF29B4EAB
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 23:17:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39FEA633CB
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 06:17:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A437AC43470
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 06:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663827437;
        bh=XWhl/4JUFnfzaLTPlF/Td7CIF2siihubPVF4sfi8AbA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GaxVPVxWGgNM5MJ6ApDZfN8rVlVu09nQ9CD+IAmxh2lixBBr/LhaqPPwdrEUFjVxJ
         eq26IaJsvRhMNT+nuH/Lh0e6Abrh6QupppHko03aKT2Bb6eaVNj4mFxpPRPFCaBcTM
         YnALXEl72pNpbkwPRgXVbiJzZBm4AuUZ2DYkCJp+d+gMsQ5hg6Ur4IYpLvCIQq6oSG
         OBrDnK4PB9wDOdHCyUKp+Bo64yHhBFGK3oTOaPhSrvLyQYq1vhFxH+VfVBryetkEQp
         iq0tl7GrdHhzjnxmlo99ndAcGwElQDn9yhDi6P5SnMl8DoDpOfsKB7uj2TbiQ9EU7l
         3FikNKYKDG/AA==
Received: by mail-ot1-f47.google.com with SMTP id w22-20020a056830061600b006546deda3f9so5552705oti.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 23:17:17 -0700 (PDT)
X-Gm-Message-State: ACrzQf2EfKLEkrmrl5FROnvqNdjFTt0fBrTUcdw5nVaRXkkq4ieqF426
        6BJjO/dYS3L063dlbzT1LhRKzY1ultgSsdjn7FE=
X-Google-Smtp-Source: AMsMyM7Edr5/JGY/hSzcr0jdddpsNP00cLJuEHNXQlerw2TUADw6e6il69Q5xL54U4P+JZ+u+nyFcs0mPhi4Y+xxSuk=
X-Received: by 2002:a05:6830:34a4:b0:65a:b03:54cc with SMTP id
 c36-20020a05683034a400b0065a0b0354ccmr853087otu.140.1663827436725; Wed, 21
 Sep 2022 23:17:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220922054743.30159-1-samuel@sholland.org>
In-Reply-To: <20220922054743.30159-1-samuel@sholland.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 22 Sep 2022 14:17:04 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSW-ixSdV73kqpJ=yYjYnKFQtS3NfzvjBVBVU1D==7YEg@mail.gmail.com>
Message-ID: <CAJF2gTSW-ixSdV73kqpJ=yYjYnKFQtS3NfzvjBVBVU1D==7YEg@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: Fix crash during early errata patching
To:     Samuel Holland <samuel@sholland.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
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

Good catch!

Reviewed-by: Guo Ren <guoren@kernel.org>

On Thu, Sep 22, 2022 at 1:47 PM Samuel Holland <samuel@sholland.org> wrote:
>
> The patch function for the T-Head PBMT errata calls __pa_symbol() before
> relocation. This crashes when CONFIG_DEBUG_VIRTUAL is enabled, because
> __pa_symbol() forwards to __phys_addr_symbol(), and __phys_addr_symbol()
> checks against the absolute kernel start/end address.
>
> Fix this by directly using the underlying kernel_mapping_va_to_pa().
>
> Fixes: a35707c3d850 ("riscv: add memory-type errata for T-Head")
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>
>  arch/riscv/errata/thead/errata.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
> index 202c83f677b2..83174f13783e 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -76,8 +76,9 @@ void __init_or_module thead_errata_patch_func(struct alt_entry *begin, struct al
>                 if (cpu_req_errata & tmp) {
>                         /* On vm-alternatives, the mmu isn't running yet */
>                         if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
> -                               memcpy((void *)__pa_symbol(alt->old_ptr),
> -                                      (void *)__pa_symbol(alt->alt_ptr), alt->alt_len);
> +                               memcpy((void *)kernel_mapping_va_to_pa((unsigned long)alt->old_ptr),
> +                                      (void *)kernel_mapping_va_to_pa((unsigned long)alt->alt_ptr),
> +                                      alt->alt_len);
>                         else
>                                 patch_text_nosync(alt->old_ptr, alt->alt_ptr, alt->alt_len);
>                 }
> --
> 2.35.1
>


-- 
Best Regards
 Guo Ren
