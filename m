Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7869C60A93A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 15:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiJXNRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 09:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235728AbiJXNPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 09:15:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FD7A344D;
        Mon, 24 Oct 2022 05:25:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2430612D6;
        Mon, 24 Oct 2022 12:25:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC87C433C1;
        Mon, 24 Oct 2022 12:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666614319;
        bh=xQsj25frPuzp2UXKNOOdiLHbPoJbQxou33hkO4Gj17k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hq4tdd54P/Ecc2x9mjCdYe73PjRRjy8OuW4POQxqDOr6oXlc8S9d8qNHcApF4vAPJ
         pOE3sYvYu+cgJVMiYUg3+4l9N8hjmCfkM3SWelypt5QYCVk1IJlG+3SNQUGWAeVMwP
         5M/zuDiHAnCCdQbMgL3KbYbWa2aMQa9dgnVbS+L3Df+wAqAIilBZT0FQKnQcppRXdI
         84XkPx1eGLOob4zjw8lZCXbRMqZGDBa8W7XfJLwwsrDZThEHvhzm0mqFriOXS1hs0U
         4w28pdW//HGU52knC5kYuqcS9Kf1fMTFbmwg3EZghWAzn5S85lLq2SQpd6wZVRZ1oZ
         V0IRiqMErG4fQ==
Date:   Mon, 24 Oct 2022 13:25:13 +0100
From:   Lee Jones <lee@kernel.org>
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        UNGLinuxDriver@microchip.com, sergiu.moga@microchip.com
Subject: Re: [PATCH v9 3/3] mfd: atmel-flexcom: Add support for lan966x
 flexcom chip-select configuration
Message-ID: <Y1aEKa1KZU0h/Vz5@google.com>
References: <20220916075744.1879428-1-kavyasree.kotagiri@microchip.com>
 <20220916075744.1879428-4-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220916075744.1879428-4-kavyasree.kotagiri@microchip.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Sep 2022, Kavyasree Kotagiri wrote:

> LAN966x SoC have 5 flexcoms. Each flexcom has 2 chip-selects
> which are optional I/O lines. For each chip select of each
> flexcom there is a configuration register FLEXCOM_SHARED[0-4]:SS_MASK[0-1].
> The width of configuration register is 21 because there are
> 21 shared pins on each of which the chip select can be mapped.
> Each bit of the register represents a different FLEXCOM_SHARED pin.
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
> v8 -> v9:
>  - No changes.
> 
> v7 -> v8:
>  - Changed compatible string to microchip,lan9668-flexcom.
> 
> v6 -> v7:
>  - No changes.
> 
> v5 -> v6:
>  - No changes.
> 
> v4 -> v5:
>  - No changes.
> 
> v3 -> v4:
>  - Add condition for a flexcom whether to configure chip-select lines
>    or not, based on "microchip,flx-shrd-pins" property existence because
>    chip-select lines are optional.
> 
> v2 -> v3:
>  - used goto label for clk_disable in error cases.
> 
> v1 -> v2:
>  - use GENMASK for mask, macros for maximum allowed values.
>  - use u32 values for flexcom chipselects instead of strings.
>  - disable clock in case of errors.
> 
>  drivers/mfd/atmel-flexcom.c | 94 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 93 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/atmel-flexcom.c b/drivers/mfd/atmel-flexcom.c
> index 33caa4fba6af..92ea15d5fd72 100644
> --- a/drivers/mfd/atmel-flexcom.c
> +++ b/drivers/mfd/atmel-flexcom.c
> @@ -28,15 +28,68 @@
>  #define FLEX_MR_OPMODE(opmode)	(((opmode) << FLEX_MR_OPMODE_OFFSET) &	\
>  				 FLEX_MR_OPMODE_MASK)
>  
> +/* LAN966x flexcom shared register offsets */
> +#define FLEX_SHRD_SS_MASK_0	0x0

MASK_0 isn't very forthcoming.  What *is* MASK_0 the mask of?

> +#define FLEX_SHRD_SS_MASK_1	0x4

What is SS?

> +#define FLEX_SHRD_PIN_MAX	20
> +#define FLEX_CS_MAX		1
> +#define FLEX_SHRD_MASK		GENMASK(20, 0)
> +
>  struct atmel_flexcom {
>  	void __iomem *base;
> +	void __iomem *flexcom_shared_base;
>  	u32 opmode;
>  	struct clk *clk;
>  };
>  
> +static int atmel_flexcom_lan966x_cs_config(struct platform_device *pdev)
> +{
> +	struct atmel_flexcom *ddata = dev_get_drvdata(&pdev->dev);
> +	struct device_node *np = pdev->dev.of_node;
> +	u32 flx_shrd_pins[2], flx_cs[2], val;
> +	int err, i, count;
> +
> +	count = of_property_count_u32_elems(np, "microchip,flx-shrd-pins");
> +	if (count <= 0 || count > 2) {
> +		dev_err(&pdev->dev, "Invalid %s property (%d)\n", "flx-shrd-pins",

Sure, but how about telling the user why it's invalid.

> +				count);

Why the '\n' here?  It's not consistent with the rest of the code.

> +		return -EINVAL;
> +	}
> +
> +	err = of_property_read_u32_array(np, "microchip,flx-shrd-pins", flx_shrd_pins, count);
> +	if (err)
> +		return err;
> +
> +	err = of_property_read_u32_array(np, "microchip,flx-cs", flx_cs, count);
> +	if (err)
> +		return err;
> +
> +	for (i = 0; i < count; i++) {
> +		if (flx_shrd_pins[i] > FLEX_SHRD_PIN_MAX)
> +			return -EINVAL;
> +
> +		if (flx_cs[i] > FLEX_CS_MAX)
> +			return -EINVAL;
> +
> +		val = ~(1 << flx_shrd_pins[i]) & FLEX_SHRD_MASK;

BIT()?

> +		if (flx_cs[i] == 0)

Please define the magic '0'.

> +			writel(val, ddata->flexcom_shared_base + FLEX_SHRD_SS_MASK_0);
> +		else
> +			writel(val, ddata->flexcom_shared_base + FLEX_SHRD_SS_MASK_1);
> +	}
> +
> +	return 0;
> +}
> +
>  static int atmel_flexcom_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
> +	const struct atmel_flex_caps *caps;
>  	struct resource *res;
>  	struct atmel_flexcom *ddata;
>  	int err;
> @@ -76,13 +129,52 @@ static int atmel_flexcom_probe(struct platform_device *pdev)
>  	 */
>  	writel(FLEX_MR_OPMODE(ddata->opmode), ddata->base + FLEX_MR);
>  
> +	caps = of_device_get_match_data(&pdev->dev);
> +	if (!caps) {
> +		dev_err(&pdev->dev, "Could not retrieve flexcom caps\n");
> +		err = -EINVAL;
> +		goto clk_disable;
> +	}
> +
> +	if (caps->has_flx_cs && of_property_read_bool(np, "microchip,flx-shrd-pins")) {

Is using an array of ints as a bool valid / good practise?

> +		ddata->flexcom_shared_base = devm_platform_get_and_ioremap_resource(pdev, 1, NULL);

Can the magic '1' be defined?

> +		if (IS_ERR(ddata->flexcom_shared_base)) {
> +			err = dev_err_probe(&pdev->dev,
> +					PTR_ERR(ddata->flexcom_shared_base),
> +					"failed to get flexcom shared base address\n");
> +			goto clk_disable;
> +		}
> +
> +		err = atmel_flexcom_lan966x_cs_config(pdev);
> +		if (err)
> +			goto clk_disable;
> +	}

All of this new code looks like it's related to the CS logic.

If that's the case, why not encapsulate it all into
atmel_flexcom_lan966x_cs_config()?

> +clk_disable:
>  	clk_disable_unprepare(ddata->clk);
> +	if (err)
> +		return err;
>  
>  	return devm_of_platform_populate(&pdev->dev);
>  }


> +struct atmel_flex_caps {
> +	bool has_flx_cs;
> +};
> +
> +static const struct atmel_flex_caps atmel_flexcom_caps = {};
> +
> +static const struct atmel_flex_caps lan966x_flexcom_caps = {
> +	.has_flx_cs = true,
> +};
> +
>  static const struct of_device_id atmel_flexcom_of_match[] = {
> -	{ .compatible = "atmel,sama5d2-flexcom" },
> +	{
> +		.compatible = "atmel,sama5d2-flexcom",
> +		.data = &atmel_flexcom_caps,
> +	},
> +
> +	{
> +		.compatible = "microchip,lan9668-flexcom",
> +		.data = &lan966x_flexcom_caps,
> +	},
> +

This a lot of infrastructure for no clear gain.  Why can't we use the
caps if they are present and ignore them if they're not?  That would
simplify a great deal of this.

>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, atmel_flexcom_of_match);

-- 
Lee Jones [李琼斯]
