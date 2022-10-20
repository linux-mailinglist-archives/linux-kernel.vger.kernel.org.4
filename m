Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472DC6066BA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 19:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiJTRHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 13:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiJTRHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 13:07:49 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269711A5B0B;
        Thu, 20 Oct 2022 10:07:48 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MtYs348c5z686KW;
        Fri, 21 Oct 2022 01:05:59 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Thu, 20 Oct 2022 19:07:45 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 18:07:44 +0100
Date:   Thu, 20 Oct 2022 18:07:43 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Cosmin Tanislav <demonsingur@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-iio@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v9 2/2] iio: adc: ad4130: add AD4130 driver
Message-ID: <20221020180743.00000416@huawei.com>
In-Reply-To: <3c4c9d0d-a542-bd54-a8d0-589bb4e6ea49@gmail.com>
References: <20221006140737.12396-1-cosmin.tanislav@analog.com>
        <20221006140737.12396-3-cosmin.tanislav@analog.com>
        <20221009183122.0de740e0@jic23-huawei>
        <3c4c9d0d-a542-bd54-a8d0-589bb4e6ea49@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Oct 2022 10:08:10 +0300
Cosmin Tanislav <demonsingur@gmail.com> wrote:

> On 10/9/22 20:31, Jonathan Cameron wrote:
> > On Thu,  6 Oct 2022 17:07:37 +0300
> > Cosmin Tanislav <demonsingur@gmail.com> wrote:
> >   
> >> AD4130-8 is an ultra-low power, high precision, measurement solution for
> >> low bandwidth battery operated applications.
> >>
> >> The fully integrated AFE (Analog Front-End) includes a multiplexer for up
> >> to 16 single-ended or 8 differential inputs, PGA (Programmable Gain
> >> Amplifier), 24-bit Sigma-Delta ADC, on-chip reference and oscillator,
> >> selectable filter options, smart sequencer, sensor biasing and excitation
> >> options, diagnostics, and a FIFO buffer.
> >>
> >> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> >> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>  
> > Hi Cosmin,
> > 
> > I've cropped down (mostly) to the clock changes.
> > A few minor things in there + this looks like it would suffer from the issue
> > with IIO_CONST_ATTR() not being handled correctly for buffer attributes.
> > 
> > Jonathan
> > 
> > 
> >   
> >> +static IIO_CONST_ATTR(hwfifo_watermark_min, "1");
> >> +static IIO_CONST_ATTR(hwfifo_watermark_max, __stringify(AD4130_FIFO_SIZE));  
> > 
> > These look like they'd suffer from same problem
> > https://lore.kernel.org/all/cover.1664782676.git.mazziesaccount@gmail.com/
> > tackles.  Short term fix is don't use IIO_CONST_ATTR for buffer attributes.
> >   
> 
> Right, this only works downstream.
> 
> Should I switch to IIO_STATIC_CONST_DEVICE_ATTR?

Depends a bit on timing. For now I'd just put a hand coded equivalent here similar
to the patches I've queue in fixes-togreg.  Then we can roll this over
to IIO_STATIC_CONST_DEVICE_ATTR once that code lands.

> 
> >   
> >> +static IIO_DEVICE_ATTR_RO(hwfifo_watermark, 0);
> >> +static IIO_DEVICE_ATTR_RO(hwfifo_enabled, 0);
> >> +
> >> +static const struct attribute *ad4130_fifo_attributes[] = {
> >> +	&iio_const_attr_hwfifo_watermark_min.dev_attr.attr,
> >> +	&iio_const_attr_hwfifo_watermark_max.dev_attr.attr,
> >> +	&iio_dev_attr_hwfifo_watermark.dev_attr.attr,
> >> +	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
> >> +	NULL
> >> +};  
> > 
> >   
> >> +static void ad4130_clk_disable_unprepare(void *clk)
> >> +{
> >> +	clk_disable_unprepare(clk);
> >> +}
> >> +
> >> +static int ad4130_set_mclk_sel(struct ad4130_state *st,
> >> +			       enum ad4130_mclk_sel mclk_sel)
> >> +{
> >> +	return regmap_update_bits(st->regmap, AD4130_ADC_CONTROL_REG,
> >> +				 AD4130_ADC_CONTROL_MCLK_SEL_MASK,
> >> +				 FIELD_PREP(AD4130_ADC_CONTROL_MCLK_SEL_MASK,
> >> +					    mclk_sel));
> >> +}
> >> +
> >> +static unsigned long ad4130_int_clk_recalc_rate(struct clk_hw *hw,
> >> +						unsigned long parent_rate)
> >> +{
> >> +	return AD4130_MCLK_FREQ_76_8KHZ;
> >> +}
> >> +
> >> +static int ad4130_int_clk_is_enabled(struct clk_hw *hw)
> >> +{
> >> +	struct ad4130_state *st = container_of(hw, struct ad4130_state, int_clk_hw);
> >> +
> >> +	return st->mclk_sel == AD4130_MCLK_76_8KHZ_OUT;
> >> +}
> >> +
> >> +static int ad4130_int_clk_prepare(struct clk_hw *hw)
> >> +{
> >> +	struct ad4130_state *st = container_of(hw, struct ad4130_state, int_clk_hw);
> >> +	int ret;
> >> +
> >> +	ret = ad4130_set_mclk_sel(st, AD4130_MCLK_76_8KHZ_OUT);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	st->mclk_sel = AD4130_MCLK_76_8KHZ_OUT;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static void ad4130_int_clk_unprepare(struct clk_hw *hw)
> >> +{
> >> +	struct ad4130_state *st = container_of(hw, struct ad4130_state, int_clk_hw);
> >> +	int ret;
> >> +
> >> +	ret = ad4130_set_mclk_sel(st, AD4130_MCLK_76_8KHZ);
> >> +	if (ret)
> >> +		return;
> >> +
> >> +	st->mclk_sel = AD4130_MCLK_76_8KHZ;
> >> +}
> >> +
> >> +static const struct clk_ops ad4130_int_clk_ops = {
> >> +	.recalc_rate = ad4130_int_clk_recalc_rate,
> >> +	.is_enabled = ad4130_int_clk_is_enabled,
> >> +	.prepare = ad4130_int_clk_prepare,
> >> +	.unprepare = ad4130_int_clk_unprepare,
> >> +};
> >> +
> >> +static int ad4130_setup_int_clk(struct ad4130_state *st)
> >> +{
> >> +	struct device *dev = &st->spi->dev;
> >> +	struct device_node *of_node = dev->of_node;  
> > 
> > Hmm. There goes our careful use of generic firmware properties.
> > I guess there still isn't much we can do about that for clks
> > so at least it's contained to this one function.
> > 
> > Also is this code safe to of_node == NULL?
> >   
> 
> No, I guess it is not. I'll fix it.
> Should I just
> if (!of_node) return 0;
> ?

Good question.  I guess we are fine just not having the output clock
on ACPI platforms.  Maybe this is worth a dev_info message
to say we are carrying on without them?

> 
> >> +	struct clk_init_data init;
> >> +	const char *clk_name;
> >> +	struct clk *clk;
> >> +
> >> +	if (st->int_pin_sel == AD4130_INT_PIN_CLK ||
> >> +	    st->mclk_sel != AD4130_MCLK_76_8KHZ)
> >> +		return 0;
> >> +
> >> +	clk_name = of_node->name;
> >> +	of_property_read_string(of_node, "clock-output-names", &clk_name);  
> > 
> > Probably want to check success of that read before using it.
> > I'd also expect that these to be optional + doesn't he dt binding need
> > updating to add this stuff?
> >   
> 
> It does need updating, sorry.
> of_node->name is the default clk_name, if clock-output-names is present
> then the of_property_read_string() result will be used instead. If not,
> there's no trouble, and we don't care about the return value since we
> have the default clk_name assigned just above.
> I can also switch to device_property_read_string() here to minimize the
> damage from using OF.

Sounds good to me.

Jonathan

> 
> >   
> >> +
> >> +	init.name = clk_name;
> >> +	init.ops = &ad4130_int_clk_ops;
> >> +
> >> +	st->int_clk_hw.init = &init;
> >> +	clk = devm_clk_register(dev, &st->int_clk_hw);
> >> +	if (IS_ERR(clk))
> >> +		return PTR_ERR(clk);
> >> +
> >> +	return of_clk_add_provider(of_node, of_clk_src_simple_get, clk);
> >> +}
> >> +  

