Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992655F3A77
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 02:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiJDAR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 20:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJDARz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 20:17:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE121220F2;
        Mon,  3 Oct 2022 17:17:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7DB29B80DC3;
        Tue,  4 Oct 2022 00:17:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BBEC433D6;
        Tue,  4 Oct 2022 00:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664842672;
        bh=80gWaFsWxv8SguHxn8zwq46GBRgDWiuW3/G/+s/w3oI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V86rspBW8/ffsisVJmmtQ1Rwg0YTcQzu/2Lx3pscss0dH3MUaHI2V7+hsGSaIB1b+
         YWGZAwtWbggrYeebkzUo0/bRDiHSmJrRkNNZQqKDQVclDCcMFurVWpLL1l6pea+mkQ
         +5Y3keP1j6oLQyO4qEItf3mMJbcrumOKmm+ADWqUa7eBpKTEbPd+IIBi4RHapYRzvb
         FwSbCnrNkel/SrTC3wDpxYsZ+i6ByKlTNgpwWyXeFbAS+mgKgpQ/kuWFVhjj0fuAKD
         uvxbb7/OrXmYzhTfrkRxoIlxU8D1Y4mHTLOqFs65DCZnkAMnKeMIcSWBBWzjyhv3Rn
         xUpPBhGFs7qRA==
Date:   Mon, 3 Oct 2022 19:17:48 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Richard Acayan <mailingradian@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v6 2/3] pinctrl: qcom: add support for complementary
 reserved gpios
Message-ID: <20221004001748.qohdzdkmdofo35wc@baldur>
References: <20221001210725.60967-1-mailingradian@gmail.com>
 <20221001210725.60967-3-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221001210725.60967-3-mailingradian@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 01, 2022 at 05:07:24PM -0400, Richard Acayan wrote:
> The driver-provided list of reserved gpios normally overrides any valid
> ranges provided by the firmware (device tree and ACPI). When the driver
> defines dummy pingroups by itself, it should mark these as invalid but
> should not prevent the firmware from specifying more reserved gpios. Let
> pinctrl drivers indicate that the reserved gpios list complements instead
> of overrides other lists from firmware.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---
>  drivers/pinctrl/qcom/pinctrl-msm.c | 5 +++--
>  drivers/pinctrl/qcom/pinctrl-msm.h | 4 ++++
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index a2abfe987ab1..cea1d2af8c88 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -687,9 +687,10 @@ static int msm_gpio_init_valid_mask(struct gpio_chip *gc,
>  	const int *reserved = pctrl->soc->reserved_gpios;
>  	u16 *tmp;
>  
> -	/* Driver provided reserved list overrides DT and ACPI */
> +	/* Driver provided reserved list overrides DT and ACPI by default */
>  	if (reserved) {
> -		bitmap_fill(valid_mask, ngpios);
> +		if (!pctrl->soc->complement_fw_gpio_ranges)

reserved_gpios is only defined for ACPI drivers and afaict there's
nothing in the ACPI path that would modify the valid_mask after the
bitmap is being filled in gpiochip_allocate_mask().

If that's the case it seems reasonable that we can just drop the
bitmap_fill() here. But perhaps I'm missing something?

Regards,
Bjorn

> +			bitmap_fill(valid_mask, ngpios);
>  		for (i = 0; reserved[i] >= 0; i++) {
>  			if (i >= ngpios || reserved[i] >= ngpios) {
>  				dev_err(pctrl->dev, "invalid list of reserved GPIOs\n");
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.h b/drivers/pinctrl/qcom/pinctrl-msm.h
> index dd0d949f7a9e..734fe7b2a472 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.h
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.h
> @@ -128,6 +128,9 @@ struct msm_gpio_wakeirq_map {
>   *              function number for eGPIO and any time we see that function
>   *              number used we'll treat it as a request to mux away from
>   *              our TLMM towards another owner.
> + * @complement_fw_gpio_ranges: If true, the reserved gpios list from the
> + *                             driver will not override the reserved gpios
> + *                             list from the firmware.
>   */
>  struct msm_pinctrl_soc_data {
>  	const struct pinctrl_pin_desc *pins;
> @@ -146,6 +149,7 @@ struct msm_pinctrl_soc_data {
>  	bool wakeirq_dual_edge_errata;
>  	unsigned int gpio_func;
>  	unsigned int egpio_func;
> +	bool complement_fw_gpio_ranges;
>  };
>  
>  extern const struct dev_pm_ops msm_pinctrl_dev_pm_ops;
> -- 
> 2.37.3
> 
