Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEEB6EE768
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbjDYSME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbjDYSMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:12:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F2C1619B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 11:12:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8E2063096
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 18:11:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D582C433EF
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 18:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682446319;
        bh=N+TkF4wFJENAi4Cao1R32vJxLp5g879aMMIGM10e1rg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jLxtQ//Uod89J+IdAFbm1dcEiO/+J1veQ4aKLXFD78X1frAuooyz48WgarEpmjx8A
         VWvaqvv6+kqZSSb+aeMNusRaToiqPM7t70nN8eL6ERrYjJi7ObKi+AutSSJyu3fvXa
         A/aGtXTBUgYEPVIjDnzcXJwwGro6idtRRnnWjG7eCyCw9yzB1yQY0O4dRlihbg/A9v
         ZV+7K9i0q55KDKDXSXKfu4j1ir+LVyiIvziFvvTA2m7Z1HbYVCfXRGws6hPSp34lxj
         NoHfU685YELvCRpeZdUFR6KEBCu+0yjRSbp5tPLFP8dauWCWCEDvcIyT4XvZrrgcB2
         n9gHYLtI7bgBQ==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2a8bbea12d7so60278851fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 11:11:59 -0700 (PDT)
X-Gm-Message-State: AAQBX9fjE7hlYCjsbd4+ivPbQJJAUs6BTvx4EGw7WSUBeg7G40qj/LTa
        e5jmouN22gLfGk2CW04BqjGssLDp/gKfajfEeoE=
X-Google-Smtp-Source: AKy350YK/lYskGvXl1zqG6QQLPT8rQzmdVVkAUy35FgP8Myo6GMD96VmSMm0z1HYKF4iNnv3ICUNmI1o7U1q+dpsWp0=
X-Received: by 2002:a2e:9145:0:b0:2a8:cedd:f371 with SMTP id
 q5-20020a2e9145000000b002a8ceddf371mr4316082ljg.15.1682446317017; Tue, 25 Apr
 2023 11:11:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230425095700.22005-1-quic_neeraju@quicinc.com>
In-Reply-To: <20230425095700.22005-1-quic_neeraju@quicinc.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 25 Apr 2023 19:11:46 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHzHhuiFDSULNQShKhiV3BVxkRhUrK1x7vM0vNnMPKO=w@mail.gmail.com>
Message-ID: <CAMj1kXHzHhuiFDSULNQShKhiV3BVxkRhUrK1x7vM0vNnMPKO=w@mail.gmail.com>
Subject: Re: [PATCH] arm64: Fix label placement in record_mmu_state()
To:     Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc:     catalin.marinas@arm.com, mark.rutland@arm.com,
        kristina.martsenko@arm.com, maz@kernel.org, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Apr 2023 at 10:57, Neeraj Upadhyay <quic_neeraju@quicinc.com> wrote:
>
> Fix label so that pre_disable_mmu_workaround() is called
> before clearing sctlr_el1.M.
>
> Fixes: 2ced0f30a426 ("arm64: head: Switch endianness before populating the ID map")
> Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/arm64/kernel/head.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index b98970907226..e92caebff46a 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -150,8 +150,8 @@ CPU_BE( tbz x19, #SCTLR_ELx_EE_SHIFT, 1f    )
>         pre_disable_mmu_workaround
>         msr     sctlr_el2, x19
>         b       3f
> -       pre_disable_mmu_workaround
> -2:     msr     sctlr_el1, x19
> +2:     pre_disable_mmu_workaround
> +       msr     sctlr_el1, x19
>  3:     isb
>         mov     x19, xzr
>         ret
> --
> 2.17.1
>
