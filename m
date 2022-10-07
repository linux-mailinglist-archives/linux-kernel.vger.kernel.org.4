Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAA45F72BC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 04:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbiJGCYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 22:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbiJGCYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 22:24:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D7AA4871;
        Thu,  6 Oct 2022 19:24:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5AF97B821DC;
        Fri,  7 Oct 2022 02:24:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A12C433C1;
        Fri,  7 Oct 2022 02:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665109449;
        bh=8N7UMpEz3/SSvxJT6QHcIUGcHLWegYsdTBx/dctVBCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BLRIPRQyIIRZokJhkBezersg9mJWrP6qXiuq0iR6ocZ4c1DloE4jlhS6Pp5d0/2Ik
         cSmK+E2weqLP8oqLcA0IVEzIb3/tu4p0caZ8oLWzQWugN080k+/Vk6QtLLpokGZXel
         q7aNRUqsr/WArdGVEltEgVf/qFwVvcpqJIoMw6bGTPRmkYYPS8TYO1xcRncT/YCykA
         rTvunmwJAvpipkwpkhCnPXCnb3e99pWaEoO5zaxmRk5ophcTzjSV7g2qL8/pOuLQvW
         sCILBIMxAzb3Xp+SVHGP2gXg3NVNTBK7V95PnMCOFYtmQ26iO6H8sw6QZoUV/eTDH1
         AylRf95LYkwJg==
Date:   Thu, 6 Oct 2022 21:24:06 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Richard Acayan <mailingradian@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v8 2/3] pinctrl: qcom: do not reinitialize gpio valid mask
Message-ID: <20221007022406.kggtrbh52iamn2dv@builder.lan>
References: <20221006232219.37505-1-mailingradian@gmail.com>
 <20221006232219.37505-3-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006232219.37505-3-mailingradian@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 07:22:18PM -0400, Richard Acayan wrote:
> It may be necessary for some devices to specify reserved gpios in the
> device-specific DTS, in addition to the reserved gpios common to all
> devices with a given SoC. Remove this bitmap_fill() call so that the
> settings applied to the gpio valid mask by DTS are not overridden by
> the driver's reserved gpios.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---
>  drivers/pinctrl/qcom/pinctrl-msm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index a2abfe987ab1..f697e9f64360 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -687,9 +687,8 @@ static int msm_gpio_init_valid_mask(struct gpio_chip *gc,
>  	const int *reserved = pctrl->soc->reserved_gpios;
>  	u16 *tmp;
>  
> -	/* Driver provided reserved list overrides DT and ACPI */
> +	/* Driver provided reserved list overrides other settings here */

IMHO this no longer overrides things, how about changing it to:

	/* Remove driver-provided reserved GPIOs from valid_mask */


The rest of the change looks good and the commit message looks good. So
please consider updating the comment and feel free to add my

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

>  	if (reserved) {
> -		bitmap_fill(valid_mask, ngpios);
>  		for (i = 0; reserved[i] >= 0; i++) {
>  			if (i >= ngpios || reserved[i] >= ngpios) {
>  				dev_err(pctrl->dev, "invalid list of reserved GPIOs\n");
> -- 
> 2.38.0
> 
