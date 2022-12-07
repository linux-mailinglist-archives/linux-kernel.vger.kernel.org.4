Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5766459F5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 13:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiLGMir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 07:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiLGMi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 07:38:26 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF7245A14
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 04:38:09 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d82so8551121pfd.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 04:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mYM23FTNqIfOQt2Wc+NWK66hmV39Pj1uNxknfmVEQho=;
        b=BKMiYekt6U/P6SgrYYV4QHdXXhw9KFWVOmx2NYYPcRbmH3XGi2wY4BoeHTLex3/PVn
         wac86bmaxiIZ2ZePogEVA/T81wrfnffe0mc2g2/oIoK0nI3n+y8giKalg7fBcMFyRKGB
         /H/0jsH1HG6qN8FTdCqq0dTXJrRGMrFr8TAmnbtXrLX9pQ2ipN5OCoejmBghlYT/Brz4
         jN6qqSXSfgvtJqp22vWy68TBUBw4k1HVMwtNfxP3LG33+DXF/QfjNysl3FrLezDqTtN6
         b/SFUi7Yyqoc5dhj29aJKQyoT3NnNvaqspYBSNV+vJa+kY3obq0VRk8ivtaNC770/NIQ
         X3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mYM23FTNqIfOQt2Wc+NWK66hmV39Pj1uNxknfmVEQho=;
        b=SohWRZ3XEe81IuV16g/2Qr0YltW8+369uZLbktH/6oEuOi359cm3dMAOpcj5foZnRx
         Sa3WbZXzV6bgVITaobd8k5/u6faXGcju3Tdd8fPsDE0wJq+CdXTQ0NId+Md40zdc6ehx
         rue9KFzT+elu/JMPxPKfHKQ4PyWCAf7H4ir0DHiWpMQQfvjhuqEgjg67aWDRYrStq29n
         eU/Gg3VPr77Bb9f1xHlk1AdD/eCH1Ondh7WBuLJ/FAeV1guNdW3gal+DCBKYfmdOmnOb
         a1hy9zuwGsRBNQ1d8bRSK8bm9yRejlqKoRhtXezxhTnK/VvCkE9a8gzfGu/yD0Z+vm6K
         FKvA==
X-Gm-Message-State: ANoB5pn9UnY0Ho8+b2I2vRhAReAO/ZNjDiMvalDVg1xS2Gq+Mx0eLX+l
        /Jy1v4NrD4kwngrd2eNX76ycrcAmKgwoeSIrcCcZ2g==
X-Google-Smtp-Source: AA0mqf7/76Ca5jC5TY5aBWLKt9s1l+HvKdSlwIVOrCMaztVBuwoSqK/61JSvpjt9aLpKDNO+KPS2zS0lRrbgxrPkb4I=
X-Received: by 2002:a65:4688:0:b0:477:7aee:a464 with SMTP id
 h8-20020a654688000000b004777aeea464mr69847980pgr.595.1670416688784; Wed, 07
 Dec 2022 04:38:08 -0800 (PST)
MIME-Version: 1.0
References: <20221202075905.25363-1-andy.tang@nxp.com>
In-Reply-To: <20221202075905.25363-1-andy.tang@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 7 Dec 2022 13:37:32 +0100
Message-ID: <CAPDyKForCE1VODVt5KAdcZPK0n0Gxw575aow6nDo62yYFX_qUQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: limit the SDHC clock frequency
To:     andy.tang@nxp.com
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Dec 2022 at 08:44, <andy.tang@nxp.com> wrote:
>
> From: Andy Tang <andy.tang@nxp.com>
>
> The highest clock frequency for eMMC HS200 mode on ls1043a
> is 116.7Mhz according to its specification.
> So add the limit to gate the frequency.
>
> Signed-off-by: Andy Tang <andy.tang@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v2: change the author to andy tang
>
>  drivers/mmc/host/sdhci-of-esdhc.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 00542dd74c07..1fd4ae10862d 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -43,6 +43,12 @@ static const struct esdhc_clk_fixup ls1021a_esdhc_clk = {
>         .max_clk[MMC_TIMING_SD_HS] = 46500000,
>  };
>
> +static const struct esdhc_clk_fixup ls1043a_esdhc_clk = {
> +       .sd_dflt_max_clk = 25000000,
> +       .max_clk[MMC_TIMING_UHS_SDR104] = 116700000,
> +       .max_clk[MMC_TIMING_MMC_HS200] = 116700000,
> +};
> +
>  static const struct esdhc_clk_fixup ls1046a_esdhc_clk = {
>         .sd_dflt_max_clk = 25000000,
>         .max_clk[MMC_TIMING_UHS_SDR104] = 167000000,
> @@ -64,6 +70,7 @@ static const struct esdhc_clk_fixup p1010_esdhc_clk = {
>
>  static const struct of_device_id sdhci_esdhc_of_match[] = {
>         { .compatible = "fsl,ls1021a-esdhc", .data = &ls1021a_esdhc_clk},
> +       { .compatible = "fsl,ls1043a-esdhc", .data = &ls1043a_esdhc_clk},
>         { .compatible = "fsl,ls1046a-esdhc", .data = &ls1046a_esdhc_clk},
>         { .compatible = "fsl,ls1012a-esdhc", .data = &ls1012a_esdhc_clk},
>         { .compatible = "fsl,p1010-esdhc",   .data = &p1010_esdhc_clk},
> --
> 2.25.1
>
