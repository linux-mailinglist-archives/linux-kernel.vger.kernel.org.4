Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46376649436
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 13:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiLKMfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 07:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiLKMf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 07:35:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC1C11153;
        Sun, 11 Dec 2022 04:35:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C10D7B80ACE;
        Sun, 11 Dec 2022 12:35:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F50C433D2;
        Sun, 11 Dec 2022 12:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670762125;
        bh=rGDsH1LcYLgClznS/DD5dyNhbVZXJJd+xXXfJMafRdo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nSBYBrnFFnHx0GRNMxQvsc6cMeOZkg3XeueVucUuWs7oOVCuVQ+vYwl4zdQ908B2h
         g+qLsbGzbuzydDma8h0Dr7T2ghgBfh6uiCkV7TlOTyjDfflXtjoVar5mO/cHCAbeSr
         urGJZNDHB5KQ/132MmD9PcyCDpN95zzY3++kU8REfAyJWYj7V9L/xg6buRljWoE8Fi
         4/Qf1juAqJj4kDw2pgFyQrvSqAFDrfFqJtYcK7NJngk47omkLVg4RJfa+3ZvbzaiMS
         WwSUURRDrDHzUHOzqfRpZ/VUEmYwklUsatqTcblXpNLNC6YN/2B7PP9+UAXJWBp2gf
         iSsVJN/RpLYgg==
Date:   Sun, 11 Dec 2022 12:48:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     <outreachy@lists.linux.dev>, Lee Jones <lee@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Manish Narani <manish.narani@xilinx.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 3/5] staging: drivers: regulator: Add MAX77541 Regulator
 Support
Message-ID: <20221211124817.5bd07ef8@jic23-huawei>
In-Reply-To: <20221207090906.5896-4-okan.sahin@analog.com>
References: <20221207090906.5896-1-okan.sahin@analog.com>
        <20221207090906.5896-4-okan.sahin@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Dec 2022 12:08:42 +0300
Okan Sahin <okan.sahin@analog.com> wrote:

> This patch adds regulator driver for both MAX77541 and MAX77540.
> The MAX77541 is a high-efficiency step-down converter
> with two 3A switching phases for single-cell Li+ battery and 5VDC systems.
> 
> The MAX77540 is a high-efficiency step-down converter
> with two 3A switching phases.
> 
> Signed-off-by: Okan Sahin <okan.sahin@analog.com>

...

> +static int max77541_regulator_probe(struct platform_device *pdev)
> +{
> +	struct max77541_dev *max77541 = dev_get_drvdata(pdev->dev.parent);
> +	struct max77541_regulator_dev *regulator;
> +	struct regulator_config config = {};
> +	struct regulator_dev *rdev;
> +	int i;
> +
> +	regulator = devm_kzalloc(&pdev->dev, sizeof(*regulator), GFP_KERNEL);
> +	if (!regulator)
> +		return -ENOMEM;
> +
> +	regulator->dev = &pdev->dev;
> +	regulator->max77541 = max77541;
> +
> +	config.dev = pdev->dev.parent;
> +	config.driver_data = regulator;
> +	config.regmap = regulator->max77541->regmap;
> +
> +	for (i = 0; i < MAX77541_MAX_REGULATORS; i++) {
> +		switch (regulator->max77541->type) {
> +		case MAX77540:

As in mfd driver, better to move this from code to constant data
by using a chip_info type structure.  You could just use the
*_regulator_desc array, but probably better to wrap that in a structure
to reduce difficulty of adding other stuff in future.


> +			rdev = devm_regulator_register(&pdev->dev,
> +						       &max77540_regulators_desc[i], &config);
> +			if (IS_ERR(rdev))
> +				return dev_err_probe(&pdev->dev, PTR_ERR(rdev),
> +							"Failed to register regulator\n");
> +			break;
> +		case MAX77541:
> +			rdev = devm_regulator_register(&pdev->dev,
> +						       &max77541_regulators_desc[i], &config);
> +			if (IS_ERR(rdev))
> +				return dev_err_probe(&pdev->dev, PTR_ERR(rdev),
> +						"Failed to register regulator\n");
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
