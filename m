Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D0D693BB4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 02:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjBMBWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 20:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjBMBWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 20:22:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22514E059
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 17:22:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF6E160DFD
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:22:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1813FC4339E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676251337;
        bh=wlM+Ecx2iuslNVdjwg8XLBf+mOAcdUJmrmZhSBMapRg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QPSLrbIYqsxHLJMAdSXZCTc09YpOfAMoiZq7cBEwVVRpYGG139APGI5ka02DBtxlE
         k2aMmI4mTZh1RGfs9l+UgTG7lObep+Zy+1KNAFeKX65yXQqRXNn1bgTYpEHQ7XgY1W
         0acK1gTTA7+uETwee7rss+sX9UmM7QWgSWNIXJlp6Mfs+5qdOkJqv5z3eKSD2dWUbU
         jEqA4ADqEDbODAl3s6BmLy5o+uwoSiEPYuI35XmMoOCGyyaAegd5O/4BluGhUIuIop
         g+bD0TqViVsP8JxSvJuwQcakvv8lm7WKc1hTo1/e4i2SnxAbUojjA4iyIU1BF01DZz
         Tk8A+fm7vROjw==
Received: by mail-ed1-f50.google.com with SMTP id p12so3746771edc.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 17:22:16 -0800 (PST)
X-Gm-Message-State: AO0yUKX7p42uJgglYpXS3qWpWQ34X6UNGg5rXIPiwvdjlS5Hisa0p6YN
        NgCsWKhBNB9UZidKPzuQymCcQYhGJK6TyKGPpuI=
X-Google-Smtp-Source: AK7set9Wnap2DtVffUeW5OU2ClIoBIQPsGGx1U3RdhWtx5jT/9yWwTz7INrdhOyrr63SToh1bowg5JYi5JFRN152pwc=
X-Received: by 2002:a50:955e:0:b0:4ab:4676:f927 with SMTP id
 v30-20020a50955e000000b004ab4676f927mr3100715eda.7.1676251335341; Sun, 12 Feb
 2023 17:22:15 -0800 (PST)
MIME-Version: 1.0
References: <20230212021534.59121-1-samuel@sholland.org> <20230212021534.59121-2-samuel@sholland.org>
In-Reply-To: <20230212021534.59121-2-samuel@sholland.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 13 Feb 2023 09:22:03 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR18Wp=o_NfMYgLp5ncyg=_nmpAybknUZkC1nkou8KYcg@mail.gmail.com>
Message-ID: <CAJF2gTR18Wp=o_NfMYgLp5ncyg=_nmpAybknUZkC1nkou8KYcg@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: Fix early alternative patching
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2023 at 10:15 AM Samuel Holland <samuel@sholland.org> wrote:
>
> Now that the text to patch is located using a relative offset from the
> alternative entry, the text address should be computed without applying
> the kernel mapping offset, both before and after VM setup.
>
> Fixes: 8d23e94a4433 ("riscv: switch to relative alternative entries")
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>
>  arch/riscv/errata/thead/errata.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
> index c0bea5c94128..1dd90a5f86f0 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -102,9 +102,7 @@ void __init_or_module thead_errata_patch_func(struct alt_entry *begin, struct al
>
>                         /* On vm-alternatives, the mmu isn't running yet */
>                         if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
> -                               memcpy((void *)__pa_symbol(oldptr),
> -                                      (void *)__pa_symbol(altptr),
> -                                      alt->alt_len);
> +                               memcpy(oldptr, altptr, alt->alt_len);
>                         else
>                                 patch_text_nosync(oldptr, altptr, alt->alt_len);
>                 }
> --
> 2.37.4
>
Reviewed-by: Guo Ren <guoren@kernel.org>

-- 
Best Regards
 Guo Ren
