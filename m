Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3458268B050
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 15:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjBEOjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 09:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBEOjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 09:39:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F231C31B;
        Sun,  5 Feb 2023 06:39:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13ED960BA9;
        Sun,  5 Feb 2023 14:39:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B95C433D2;
        Sun,  5 Feb 2023 14:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675607970;
        bh=IwndUhI0nyBuym7OP5+YwXCaj3c/10tKeMH+GWbtzls=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MiK4Dlvr/flWyxwwfqQzbbbpLRjkywQsin6mEFzuXIx8TCBT1eWSCkSEWx8nRHTeL
         WsRtOrzdIhaioSSfkRnC6YgAcobq6Pr/YmPBYW8jb86GT26fReWReuX4gsqR0/SsGr
         U6LJozYt8uFxkV0mUZMH6lLvfc1o39UdMzu7S82uphQjEp3vl4wqiVromlbFKcz5qf
         8WW0nV9RlzwBnngTp+4eMYKdCmC9OQhaIFulDPSoIbCTqiJbwhwYhywiZbtRYL6lt5
         mC9PCSk/WL7CXVcE3romKqqP4+1+p/OzTp5/zs3+6bDAe1hFSSZ17Iv17P94elHBKe
         zHDrgR6ZY6pOA==
Date:   Sun, 5 Feb 2023 14:53:31 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] iio: pressure: bmp280: Add support for new
 sensor BMP580
Message-ID: <20230205145331.1d67b5e6@jic23-huawei>
In-Reply-To: <97a234ddac057eea1e6790d7fa4a66564abec2ed.1674954271.git.ang.iglesiasg@gmail.com>
References: <cover.1674954271.git.ang.iglesiasg@gmail.com>
        <97a234ddac057eea1e6790d7fa4a66564abec2ed.1674954271.git.ang.iglesiasg@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
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

On Sun, 29 Jan 2023 02:33:07 +0100
Angel Iglesias <ang.iglesiasg@gmail.com> wrote:

> Adds compatibility with the new sensor generation, the BMP580.
> 
> The measurement and initialization codepaths are adapted from
> the device datasheet and the repository from manufacturer at
> https://github.com/boschsensortec/BMP5-Sensor-API.
> 
> Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
> 

Hi Angel,

As you are doing one more version anyway, a few really minor comments inline.

Thanks,

Jonathan

> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 22addaaa5393..c65fb4025ad9 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c

>  /*
>   * These enums are used for indexing into the array of compensation
>   * parameters for BMP280.
> @@ -1216,6 +1252,303 @@ const struct bmp280_chip_info bmp380_chip_info = {
>  };
>  EXPORT_SYMBOL_NS(bmp380_chip_info, IIO_BMP280);
>  
> +/*
> + * BMP5xx soft reset procedure

Wild cards are often a bad idea, even in comments.  Tend to end up covering
some device that works differently.  With that in mind, not sure this comment
adds anything over the function name.

> + */
> +static int bmp580_soft_reset(struct bmp280_data *data)
> +{
> +	unsigned int reg;
> +	int ret;
> +
> +	/* Write reset word to CMD register */
Not that informative as comments go.

> +	ret = regmap_write(data->regmap, BMP580_REG_CMD, BMP580_CMD_SOFT_RESET);
> +	if (ret) {
> +		dev_err(data->dev, "failed to send reset command to device\n");
> +		return ret;
> +	}
> +	/* Wait 2ms for reset completion */
nor is this one - drop them both.
> +	usleep_range(2000, 2500);
> +
> +	/* Dummy read of chip_id */
Now this one is good as not obvious why read is here so keep it!
> +	ret = regmap_read(data->regmap, BMP580_REG_CHIP_ID, &reg);
> +	if (ret) {
> +		dev_err(data->dev, "failed to reestablish comms after reset\n");
> +		return ret;
> +	}
> +
> +	/* Check if POR bit is set on interrupt reg */
Not sure the comment adds anything not obviously from code.  I'd be inclined
to drop it.
> +	ret = regmap_read(data->regmap, BMP580_REG_INT_STATUS, &reg);
> +	if (ret) {
> +		dev_err(data->dev, "error reading interrupt status register\n");
> +		return ret;
> +	}
> +	if (!(reg & BMP580_INT_STATUS_POR_MASK)) {
> +		dev_err(data->dev, "error resetting sensor\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Contrary to previous sensors families, compensation algorithm is builtin.
> + * We are only required to read the register raw data and adapt the ranges
> + * for what is expected on IIO ABI.
> + */
> +
> +static int bmp580_read_temp(struct bmp280_data *data, int *val)
> +{
> +	s32 raw_temp;
> +	int ret;
> +
> +	ret = regmap_bulk_read(data->regmap, BMP580_REG_TEMP_XLSB, data->buf,
> +			       sizeof(data->buf));
> +	if (ret) {
> +		dev_err(data->dev, "failed to read temperature\n");
> +		return ret;
> +	}
> +
> +	raw_temp = get_unaligned_le24(data->buf);
> +	if (raw_temp == BMP580_TEMP_SKIPPED) {
> +		dev_err(data->dev, "reading temperature skipped\n");
> +		return -EIO;
> +	}
> +
> +	/*
> +	 * Temperature is returned in Celsius degrees in fractional
> +	 * form down 2^16. We reescale by x1000 to return milli Celsius
> +	 * to respect IIO ABI.
> +	 */
> +	*val = (raw_temp * 1000) >> 16;

Why not use IIO_VAL_FRACTION_LOG2 and keep the precision?

> +	return IIO_VAL_INT;
> +}


