Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0973D5BBF21
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 19:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiIRR1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 13:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiIRR1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 13:27:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0308186C8;
        Sun, 18 Sep 2022 10:27:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83191B81167;
        Sun, 18 Sep 2022 17:27:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B894C433C1;
        Sun, 18 Sep 2022 17:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663522048;
        bh=mvFFQURIQTXvo9x/EMwDroyhj4af3+KhJCyIs5JP4Ro=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oSxsGSh6S7VSsJ3M1h1OA+vixJgsMBDUPFA2kHP4AgDWeL2cwz80xwYrL0wEu37gY
         tcGRtQ2bcxLsqGw63PtyOE2ZPsQVV53pJ0zX1XeW6AMW4JUzTqvgG8sm/DPKmN5I+1
         hUPZ/BGnxFEEgOiZdLJnUJE6gL42cO2Hw7xmTZxnXuw0FvXNkKLcP75nEv2EKPWwU7
         p6UEuk6VK/50LgihyOyCZIjI8gj7H6l0YGNyF3v++3n9W00YLGICY6ZzsT1uqBBwo5
         cbSEk3G3fM9qDRG/6fm28MphLyxipKv805HnDzjzezn7UlCRTo1t9GokGlfYpgeKYW
         23x7KOrCLLtQw==
Date:   Sun, 18 Sep 2022 18:27:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     <andrea.merello@iit.it>
Cc:     <mchehab+huawei@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <lars@metafoo.de>, <robh+dt@kernel.org>,
        <andy.shevchenko@gmail.com>, <matt.ranostay@konsulko.com>,
        <ardeleanalex@gmail.com>, <jacopo@jmondi.org>,
        <andrea.merello@gmail.com>, <bagasdotme@gmail.com>
Subject: Re: [v7 08/14] iio: imu: add Bosch Sensortec BNO055 core driver
Message-ID: <20220918182731.26de1a02@jic23-huawei>
In-Reply-To: <20220907132205.28021-9-andrea.merello@iit.it>
References: <20220907132205.28021-1-andrea.merello@iit.it>
        <20220907132205.28021-9-andrea.merello@iit.it>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Wed, 7 Sep 2022 15:21:59 +0200
<andrea.merello@iit.it> wrote:

> From: Andrea Merello <andrea.merello@iit.it>
> 
> Add the core driver for the BNO055 IMU from Bosch. This IMU can be
> connected via both serial and I2C busses; separate patches will add support
> for them.
> 
> The driver supports "AMG" (Accelerometer, Magnetometer, Gyroscope) mode,
> that provides raw data from the said internal sensors, and a couple of
> "fusion" modes (i.e. the IMU also does calculations in order to provide
> euler angles, quaternions, linear acceleration and gravity measurements).
> 
> In fusion modes the AMG data is still available (with some calibration
> refinements done by the IMU), but certain settings such as low pass filters
> cut-off frequency and sensors' ranges are fixed, while in AMG mode they can
> be customized; this is why AMG mode can still be interesting.
> 
> Signed-off-by: Andrea Merello <andrea.merello@iit.it>

Hi Andrea,

I think this is looking to be in a good state now.
There is some devm handling for clks now available that should avoid
the need to open code that here.

I've made that change whilst applying. Please take a look to make sure
I didn't mess it up!

Jonathan

> +
> +static void bno055_clk_disable(void *arg)
> +{
> +	clk_disable_unprepare(arg);
> +}
> +
> +int bno055_probe(struct device *dev, struct regmap *regmap,
> +		 int xfer_burst_break_thr, bool sw_reset)
> +{

...

> +	priv->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(priv->reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(priv->reset_gpio), "Failed to get reset GPIO\n");
> +
> +	priv->clk = devm_clk_get_optional(dev, "clk");
> +	if (IS_ERR(priv->clk))
> +		return dev_err_probe(dev, PTR_ERR(priv->clk), "Failed to get CLK\n");
> +
> +	ret = clk_prepare_enable(priv->clk);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(dev, bno055_clk_disable, priv->clk);
> +	if (ret)
> +		return ret;#

devm_clk_get_optional_enabled() is now available and should work here I think?

> +
> +	if (priv->reset_gpio) {
> +		usleep_range(5000, 10000);
> +		gpiod_set_value_cansleep(priv->reset_gpio, 1);
> +		usleep_range(650000, 750000);
> +	} else if (!sw_reset) {
> +		dev_warn(dev, "No usable reset method; IMU may be unreliable\n");
> +	}
