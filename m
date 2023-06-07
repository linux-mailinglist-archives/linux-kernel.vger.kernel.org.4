Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86EB72589F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239399AbjFGIun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239797AbjFGIuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:50:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6121FFF;
        Wed,  7 Jun 2023 01:49:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A76963C74;
        Wed,  7 Jun 2023 08:49:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD2DC43443;
        Wed,  7 Jun 2023 08:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686127786;
        bh=RzauY7PSZpPkXiHuZDUOwrDIQtLbNmd9eP5HM3i8tI0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dBIjM1arT92xSFIrDeQ1BGwizxBWdS2O9TBMaZesOanuY0VFDZUd/6ux+bJxn9Te/
         az2QUin01W6lN/F3yQ67lOjA8DPqv31Iry5cUvtNl5tol/ErC/brpF04hmDmaXpJDH
         qjPYM+LMgpCpQg4QAdsG9Ez4a/EkmsbpKgjM2Hh8Bo3mfUclwZdgAu8/ra3lPd5ZiO
         UHvJT0oUpZo8nb2gVtr5fOquBZKS12FWluobadae1K7ZFiAQs964bGuUoQB5X4+vu6
         C+xmGV0vN5QcTtCam1d1BuyPPdHEiIY9hSs5eOtLLDRcGu7bt3uhCElHtnPLcorSCa
         i4yDFYaF9k/4w==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2b1b2ca09b9so60950831fa.1;
        Wed, 07 Jun 2023 01:49:46 -0700 (PDT)
X-Gm-Message-State: AC+VfDxVVfEYLEuVe7EtFeYzY43u9Y94Q8rzZPn2IfD+7IIRL9r4uukB
        Xo6rGyJDXzHmuNzbufg+C7Dp2bhO3nXH/jEVGbs=
X-Google-Smtp-Source: ACHHUZ5xOu66DltGvwYXA5L6j4ufq1mH5NoW3OI5QfdsUEaBwlxJUQB6gPbrubklcXM1v6DQtcwH8V4JF48sgk/B+Bc=
X-Received: by 2002:a2e:9c13:0:b0:2b1:ec1a:88cc with SMTP id
 s19-20020a2e9c13000000b002b1ec1a88ccmr2200491lji.3.1686127784581; Wed, 07 Jun
 2023 01:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230606181936.bw62oyqswo7jomra@google.com>
In-Reply-To: <20230606181936.bw62oyqswo7jomra@google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 7 Jun 2023 10:49:33 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHqXTdm-zdeY7vUxEycQ8zymRSQYZsgOKvi77gC5=nL-A@mail.gmail.com>
Message-ID: <CAMj1kXHqXTdm-zdeY7vUxEycQ8zymRSQYZsgOKvi77gC5=nL-A@mail.gmail.com>
Subject: Re: [PATCH] scripts/mksysmap: Ignore __pi_ local arm64 symbols
To:     =?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jun 2023 at 20:19, Pierre-Cl=C3=A9ment Tosi <ptosi@google.com> wr=
ote:
>
> Similarly to "__kvm_nvhe_", filter out any local symbol that was
> prefixed with "__pi_" (generated when CONFIG_RANDOMIZE_BASE=3Dy) when
> compiling System.map and in kallsyms.
>
> Signed-off-by: Pierre-Cl=C3=A9ment Tosi <ptosi@google.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  scripts/mksysmap | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/scripts/mksysmap b/scripts/mksysmap
> index cb3b1fff3eee..a7de0f637cc7 100755
> --- a/scripts/mksysmap
> +++ b/scripts/mksysmap
> @@ -40,6 +40,10 @@ ${NM} -n ${1} | sed >${2} -e "
>  # arm64 EFI stub namespace
>  / __efistub_/d
>
> +# arm64 local symbols in PIE namespace
> +/ __pi_\\$/d
> +/ __pi_\.L/d
> +
>  # arm64 local symbols in non-VHE KVM namespace
>  / __kvm_nvhe_\$/d
>  / __kvm_nvhe_\.L/d
> --
> 2.41.0.rc0.172.g3f132b7071-goog
>
>
> --
> Pierre
