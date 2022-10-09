Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832DF5F8C85
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 19:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiJIRbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 13:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJIRbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 13:31:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1A326101;
        Sun,  9 Oct 2022 10:31:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1450360C4A;
        Sun,  9 Oct 2022 17:31:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B644C433D6;
        Sun,  9 Oct 2022 17:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665336660;
        bh=lHOq+nhq7Hp77w4T///rC2xW72VGawOL6xd7vtJQlN0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GHvvucP1xSlokkqHZPk3WssWQUgA/SeR///G3fysUjZgPT4zyvM9EEqPZ0b/UsNbO
         ZMgGQ5YdngJXy30x8JLuPJxvQQ7kD44ZVIjCsLRsQgLYEbxwgjADirQDiHAb+8nh8w
         aESvuHAtXNiULImZeUDeoe/3Pa5Yrft7qfTDsz5bdGYVghWOHnEGfdYfiEw9C7u43+
         lq8V7cjT6m507x6EkWrIDcG0beVDywyLXmyD0uXd2AVy6diyhGfRWMix7cYzvDRNnL
         0TtZkhWahGRjuD9IUe7HbwBPmuo/crq5NSbGCQ7qBn8PyblwGNA8uZA58RMqGbBMq8
         WYFPHJYKjKk4A==
Date:   Sun, 9 Oct 2022 18:31:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v9 2/2] iio: adc: ad4130: add AD4130 driver
Message-ID: <20221009183122.0de740e0@jic23-huawei>
In-Reply-To: <20221006140737.12396-3-cosmin.tanislav@analog.com>
References: <20221006140737.12396-1-cosmin.tanislav@analog.com>
        <20221006140737.12396-3-cosmin.tanislav@analog.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  6 Oct 2022 17:07:37 +0300
Cosmin Tanislav <demonsingur@gmail.com> wrote:

> AD4130-8 is an ultra-low power, high precision, measurement solution for
> low bandwidth battery operated applications.
> 
> The fully integrated AFE (Analog Front-End) includes a multiplexer for up
> to 16 single-ended or 8 differential inputs, PGA (Programmable Gain
> Amplifier), 24-bit Sigma-Delta ADC, on-chip reference and oscillator,
> selectable filter options, smart sequencer, sensor biasing and excitation
> options, diagnostics, and a FIFO buffer.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Hi Cosmin,

I've cropped down (mostly) to the clock changes.
A few minor things in there + this looks like it would suffer from the issue
with IIO_CONST_ATTR() not being handled correctly for buffer attributes.

Jonathan



> +static IIO_CONST_ATTR(hwfifo_watermark_min, "1");
> +static IIO_CONST_ATTR(hwfifo_watermark_max, __stringify(AD4130_FIFO_SIZE));

These look like they'd suffer from same problem 
https://lore.kernel.org/all/cover.1664782676.git.mazziesaccount@gmail.com/
tackles.  Short term fix is don't use IIO_CONST_ATTR for buffer attributes.


> +static IIO_DEVICE_ATTR_RO(hwfifo_watermark, 0);
> +static IIO_DEVICE_ATTR_RO(hwfifo_enabled, 0);
> +
> +static const struct attribute *ad4130_fifo_attributes[] = {
> +	&iio_const_attr_hwfifo_watermark_min.dev_attr.attr,
> +	&iio_const_attr_hwfifo_watermark_max.dev_attr.attr,
> +	&iio_dev_attr_hwfifo_watermark.dev_attr.attr,
> +	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
> +	NULL
> +};


> +static void ad4130_clk_disable_unprepare(void *clk)
> +{
> +	clk_disable_unprepare(clk);
> +}
> +
> +static int ad4130_set_mclk_sel(struct ad4130_state *st,
> +			       enum ad4130_mclk_sel mclk_sel)
> +{
> +	return regmap_update_bits(st->regmap, AD4130_ADC_CONTROL_REG,
> +				 AD4130_ADC_CONTROL_MCLK_SEL_MASK,
> +				 FIELD_PREP(AD4130_ADC_CONTROL_MCLK_SEL_MASK,
> +					    mclk_sel));
> +}
> +
> +static unsigned long ad4130_int_clk_recalc_rate(struct clk_hw *hw,
> +						unsigned long parent_rate)
> +{
> +	return AD4130_MCLK_FREQ_76_8KHZ;
> +}
> +
> +static int ad4130_int_clk_is_enabled(struct clk_hw *hw)
> +{
> +	struct ad4130_state *st = container_of(hw, struct ad4130_state, int_clk_hw);
> +
> +	return st->mclk_sel == AD4130_MCLK_76_8KHZ_OUT;
> +}
> +
> +static int ad4130_int_clk_prepare(struct clk_hw *hw)
> +{
> +	struct ad4130_state *st = container_of(hw, struct ad4130_state, int_clk_hw);
> +	int ret;
> +
> +	ret = ad4130_set_mclk_sel(st, AD4130_MCLK_76_8KHZ_OUT);
> +	if (ret)
> +		return ret;
> +
> +	st->mclk_sel = AD4130_MCLK_76_8KHZ_OUT;
> +
> +	return 0;
> +}
> +
> +static void ad4130_int_clk_unprepare(struct clk_hw *hw)
> +{
> +	struct ad4130_state *st = container_of(hw, struct ad4130_state, int_clk_hw);
> +	int ret;
> +
> +	ret = ad4130_set_mclk_sel(st, AD4130_MCLK_76_8KHZ);
> +	if (ret)
> +		return;
> +
> +	st->mclk_sel = AD4130_MCLK_76_8KHZ;
> +}
> +
> +static const struct clk_ops ad4130_int_clk_ops = {
> +	.recalc_rate = ad4130_int_clk_recalc_rate,
> +	.is_enabled = ad4130_int_clk_is_enabled,
> +	.prepare = ad4130_int_clk_prepare,
> +	.unprepare = ad4130_int_clk_unprepare,
> +};
> +
> +static int ad4130_setup_int_clk(struct ad4130_state *st)
> +{
> +	struct device *dev = &st->spi->dev;
> +	struct device_node *of_node = dev->of_node;

Hmm. There goes our careful use of generic firmware properties.
I guess there still isn't much we can do about that for clks
so at least it's contained to this one function.

Also is this code safe to of_node == NULL?

> +	struct clk_init_data init;
> +	const char *clk_name;
> +	struct clk *clk;
> +
> +	if (st->int_pin_sel == AD4130_INT_PIN_CLK ||
> +	    st->mclk_sel != AD4130_MCLK_76_8KHZ)
> +		return 0;
> +
> +	clk_name = of_node->name;
> +	of_property_read_string(of_node, "clock-output-names", &clk_name);

Probably want to check success of that read before using it.
I'd also expect that these to be optional + doesn't he dt binding need
updating to add this stuff?


> +
> +	init.name = clk_name;
> +	init.ops = &ad4130_int_clk_ops;
> +
> +	st->int_clk_hw.init = &init;
> +	clk = devm_clk_register(dev, &st->int_clk_hw);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	return of_clk_add_provider(of_node, of_clk_src_simple_get, clk);
> +}
> +
