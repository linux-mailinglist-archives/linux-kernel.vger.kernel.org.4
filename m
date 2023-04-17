Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F446E4B4F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjDQOUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjDQOU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:20:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9AB32188;
        Mon, 17 Apr 2023 07:20:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B0221063;
        Mon, 17 Apr 2023 07:21:08 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30DC93F5A1;
        Mon, 17 Apr 2023 07:20:23 -0700 (PDT)
Date:   Mon, 17 Apr 2023 15:20:20 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Shengyu Qu <wiagn233@outlook.com>
Cc:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lgirdwood@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Botka <martin.botka@somainline.org>
Subject: Re: [PATCH v1 4/4] regulator: axp20x: Set DCDC frequency only when
 property exists
Message-ID: <20230417152020.419bfb9c@donnerap.cambridge.arm.com>
In-Reply-To: <TY3P286MB26111D00F42888C71EF0877698969@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
References: <20230407141813.89-1-wiagn233@outlook.com>
 <TY3P286MB26111D00F42888C71EF0877698969@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  7 Apr 2023 22:18:13 +0800
Shengyu Qu <wiagn233@outlook.com> wrote:

> Current axp20x regulator driver would always set DCDC frequency even if
> there is no x-powers,dcdc-freq in device tree data. Causing meaningless
> warning info output on variants that do not support DCDC frequency
> modification. So only try to set DCDC frequency when there is frequency
> property.

This patch should not be needed. You should disallow the
x-powers,dcdc-freq property in the binding (see [1]), then handle that
like the AXP313a driver does: by explicitly checking that the property
does not exist, then returning, see [2].

In general you might want to rebase your series on top of the AXP313a v10
series, as this most likely goes in before.

Cheers,
Andre

[1]
https://lore.kernel.org/linux-sunxi/20230401001850.4988-2-andre.przywara@arm.com/
[2]
https://lore.kernel.org/linux-sunxi/20230401001850.4988-4-andre.przywara@arm.com/

> Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
> ---
>  drivers/regulator/axp20x-regulator.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
> index ece4af93df7b..12a12923bc7b 100644
> --- a/drivers/regulator/axp20x-regulator.c
> +++ b/drivers/regulator/axp20x-regulator.c
> @@ -1247,10 +1247,10 @@ static int axp20x_regulator_parse_dt(struct platform_device *pdev)
>  	if (!regulators) {
>  		dev_warn(&pdev->dev, "regulators node not found\n");
>  	} else {
> -		of_property_read_u32(regulators, "x-powers,dcdc-freq", &dcdcfreq);
> -		ret = axp20x_set_dcdc_freq(pdev, dcdcfreq);
> -		if (ret < 0) {
> -			dev_err(&pdev->dev, "Error setting dcdc frequency: %d\n", ret);
> +		if (of_property_read_u32(regulators, "x-powers,dcdc-freq", &dcdcfreq) != -EINVAL) {
> +			ret = axp20x_set_dcdc_freq(pdev, dcdcfreq);
> +			if (ret < 0)
> +				dev_err(&pdev->dev, "Error setting dcdc frequency: %d\n", ret);
>  		}
>  		of_node_put(regulators);
>  	}

