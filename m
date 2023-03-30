Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6AE6D03CC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjC3Lsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjC3Lsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:48:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD98C4;
        Thu, 30 Mar 2023 04:48:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A2CDB8280C;
        Thu, 30 Mar 2023 11:48:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4017C433EF;
        Thu, 30 Mar 2023 11:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680176912;
        bh=T9SRL0gGZvp/L/Hoot2vU6OruKaRREo4iLpKVTq8B38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cs7U+6rr0AcaABRoOV/iqzl5qqm8cO+n4gNX8NzrxF0rhkAHfkUtEnxU2thFYTXVi
         z788zLZo+W+1YBlVjm+SH1z7R5D9TREpem73N4czGlLX1d4+HWFJ9jTG/zTs4GTRfZ
         4wtRz65hv+LlHPWcdYqTx890nnfYFpUKOmrHUyydxS2NyYtKLZSIhoso92qRdcFPIJ
         u+1Z7uKMWrf94yD1IToBnoNqXv8dFRg37iRWQxAZWUCzprf1rHSTstI+dMfkV0e76m
         m8kGn4+pyZIgmH+WCB4H0E/Sb10wFt/B9cEKvzAm8KWAiSFdSbhXenrfdG6Rg5yYmW
         josW1xvAT69dg==
Date:   Thu, 30 Mar 2023 12:48:26 +0100
From:   Lee Jones <lee@kernel.org>
To:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Travkin <nikita@trvn.ru>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 2/2] leds: aw2013: Add vdd regulator
Message-ID: <20230330114826.GE434339@google.com>
References: <20230320141638.3378-1-linmengbo0689@protonmail.com>
 <20230320142116.3494-1-linmengbo0689@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230320142116.3494-1-linmengbo0689@protonmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Mar 2023, Lin, Meng-Bo wrote:

> Implement support for a "vdd" that is enabled by the aw2013 driver so that
> the regulator gets enabled when needed.

There seems to be some dispute over the H/W.

Please improve this commit message to cover the following points.

What is currently broken / not working?

How does applying this patch help with that problem?

> Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
> ---
>  drivers/leds/leds-aw2013.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/leds/leds-aw2013.c b/drivers/leds/leds-aw2013.c
> index 0b52fc9097c6..91d720edb857 100644
> --- a/drivers/leds/leds-aw2013.c
> +++ b/drivers/leds/leds-aw2013.c
> @@ -62,7 +62,7 @@ struct aw2013_led {
>
>  struct aw2013 {
>  	struct mutex mutex; /* held when writing to registers */
> -	struct regulator *vcc_regulator;
> +	struct regulator_bulk_data regulators[2];
>  	struct i2c_client *client;
>  	struct aw2013_led leds[AW2013_MAX_LEDS];
>  	struct regmap *regmap;
> @@ -106,7 +106,8 @@ static void aw2013_chip_disable(struct aw2013 *chip)
>
>  	regmap_write(chip->regmap, AW2013_GCR, 0);
>
> -	ret = regulator_disable(chip->vcc_regulator);
> +	ret = regulator_bulk_disable(ARRAY_SIZE(chip->regulators),
> +				     chip->regulators);
>  	if (ret) {
>  		dev_err(&chip->client->dev,
>  			"Failed to disable regulator: %d\n", ret);
> @@ -123,7 +124,8 @@ static int aw2013_chip_enable(struct aw2013 *chip)
>  	if (chip->enabled)
>  		return 0;
>
> -	ret = regulator_enable(chip->vcc_regulator);
> +	ret = regulator_bulk_enable(ARRAY_SIZE(chip->regulators),
> +				    chip->regulators);
>  	if (ret) {
>  		dev_err(&chip->client->dev,
>  			"Failed to enable regulator: %d\n", ret);
> @@ -348,16 +350,20 @@ static int aw2013_probe(struct i2c_client *client)
>  		goto error;
>  	}
>
> -	chip->vcc_regulator = devm_regulator_get(&client->dev, "vcc");
> -	ret = PTR_ERR_OR_ZERO(chip->vcc_regulator);
> -	if (ret) {
> +	chip->regulators[0].supply = "vcc";
> +	chip->regulators[1].supply = "vdd";
> +	ret = devm_regulator_bulk_get(&client->dev,
> +				      ARRAY_SIZE(chip->regulators),
> +				      chip->regulators);
> +	if (ret < 0) {
>  		if (ret != -EPROBE_DEFER)
>  			dev_err(&client->dev,
>  				"Failed to request regulator: %d\n", ret);
>  		goto error;
>  	}
>
> -	ret = regulator_enable(chip->vcc_regulator);
> +	ret = regulator_bulk_enable(ARRAY_SIZE(chip->regulators),
> +				    chip->regulators);
>  	if (ret) {
>  		dev_err(&client->dev,
>  			"Failed to enable regulator: %d\n", ret);
> @@ -382,7 +388,8 @@ static int aw2013_probe(struct i2c_client *client)
>  	if (ret < 0)
>  		goto error_reg;
>
> -	ret = regulator_disable(chip->vcc_regulator);
> +	ret = regulator_bulk_disable(ARRAY_SIZE(chip->regulators),
> +				     chip->regulators);
>  	if (ret) {
>  		dev_err(&client->dev,
>  			"Failed to disable regulator: %d\n", ret);
> @@ -394,7 +401,8 @@ static int aw2013_probe(struct i2c_client *client)
>  	return 0;
>
>  error_reg:
> -	regulator_disable(chip->vcc_regulator);
> +	regulator_bulk_disable(ARRAY_SIZE(chip->regulators),
> +			       chip->regulators);
>
>  error:
>  	mutex_destroy(&chip->mutex);
> --
> 2.30.2
>
>

--
Lee Jones [李琼斯]
