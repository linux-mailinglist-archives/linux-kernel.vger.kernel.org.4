Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9EA6CA113
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 12:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbjC0KT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 06:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbjC0KTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:19:25 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352D946B5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:19:23 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id i5-20020a05600c354500b003edd24054e0so6984937wmq.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1679912361;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=Q193+qQbGmL9z6G4FxC+zWcxN9diay8DaaL43/+W/u8=;
        b=XcTpQMkfVUrA+Pi1esztDk96t1qs73ePIdcTmUSlkhjfToIrSRJNQYHHYGLWY0TqzM
         nVFuyk05pZlv5lPbwO9zK0WzgVFl7KjKn4DGov6+qMOoWvnmNGbbQsaObhU/FwaRm5pB
         JUQhAiGECwtW5fg6sswxeiXoanseG4chLs0e1pI6JdCNTTY0jeEeEWSFKg1SREcwH5JD
         22kxoYKdL91ApJtxNcGrw6yzZ2ZOLpbzr6tztM0RVaQhs62iApGGVTRJIusyoo+MDwo1
         gTKHmJye7be5sgiYM+zcPPM9QLdWeXHxJeVJmFMZqJlVRPHV9ENSiwraTZxfLrqsPAA8
         bx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679912361;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q193+qQbGmL9z6G4FxC+zWcxN9diay8DaaL43/+W/u8=;
        b=MlijixRLkR7CvVFjJXTs+R3H9rIATdq0NONCM2TmiZoWRgJdNMtehvgqy2gRvzkKhV
         BEP6BsMCpIYusLjbaz7qzhQfkFCTI0+2HY6y7rPqybtUAGZC9IKzEEgPEc1iDcDf9kzV
         VHXUiTNsh4deYUGKd94XMFPU6/TtxTYJbhQOnF98JnjOjjoAF6bP1AmiBOD8OeEoHbwr
         r5brVTPedJqSczDLd1HkI+xkbg6feFeMRXVcn3XgunB0TBNxVY7enllEDcdKa/NvV/fl
         /LImno22AQrh4C3t63ATFHdLYPf4vAO87+ucCaf0rLJLh84sCpa5mtLdY1AmyJ0TlUaB
         WhgA==
X-Gm-Message-State: AO0yUKXhSzSOYFANWxeTYCnjXOGQtHeWGs1JLPZ9BDW1X4r+hjmj6F8L
        Pz5axxxDBCWseOV++DkxRSN07A==
X-Google-Smtp-Source: AK7set8FsG4tKWlAe1g+Z9lv7YuWI5lmdwWsaz4HZxhpVMHIcDwHlEbjUtUIaWotZWfhaYxhl3r5eQ==
X-Received: by 2002:a1c:4b02:0:b0:3ee:4481:5415 with SMTP id y2-20020a1c4b02000000b003ee44815415mr9184360wma.26.1679912361658;
        Mon, 27 Mar 2023 03:19:21 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id p5-20020a5d4e05000000b002d75909c76esm17848785wrt.73.2023.03.27.03.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 03:19:21 -0700 (PDT)
References: <20230321193014.26349-1-ddrokosov@sberdevices.ru>
 <20230321193014.26349-6-ddrokosov@sberdevices.ru>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        neil.armstrong@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     jian.hu@amlogic.com, kernel@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v11 5/5] clk: meson: a1: add Amlogic A1 Peripherals
 clock controller driver
Date:   Mon, 27 Mar 2023 11:58:30 +0200
In-reply-to: <20230321193014.26349-6-ddrokosov@sberdevices.ru>
Message-ID: <1jtty6o5so.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 21 Mar 2023 at 22:30, Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:

> Introduce Peripherals clock controller for Amlogic A1 SoC family.
>
> A1 SoC has four clock controllers on the board: PLL, Peripherals, CPU,
> and Audio.
> This patchset adds support for Amlogic A1 Peripherals clock driver and
> allows to generate clocks for all A1 SoC peripheral IPs.
>
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>  drivers/clk/meson/Kconfig  |   10 +
>  drivers/clk/meson/Makefile |    1 +
>  drivers/clk/meson/a1.c     | 2344 ++++++++++++++++++++++++++++++++++++
>  drivers/clk/meson/a1.h     |   49 +
>  4 files changed, 2404 insertions(+)
>  create mode 100644 drivers/clk/meson/a1.c
>  create mode 100644 drivers/clk/meson/a1.h
>

[...]

> +static struct clk_regmap dspa_b_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = DSPA_CLK_CTRL0,
> +		.mask = 0x7,
> +		.shift = 26,
> +		.table = mux_table_dsp_ab,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "dspa_b_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = dsp_ab_parent_data,
> +		.num_parents = ARRAY_SIZE(dsp_ab_parent_data),
> +		/*
> +		 * DSPA_B clk can be inherited from more accurate RTC clock,
> +		 * so in some situations we may want to freeze its parent.
> +		 * Therefore force dsp parent setup on device tree side
> +		 */

This gets copy-pasted A LOT.
Please comment this once and for all ... then reference the comment if
you need to.

> +		.flags = CLK_SET_RATE_NO_REPARENT,
> +	},
> +};

[...]

> +static struct clk_regmap cecb_32k_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CECB_CLK_CTRL1,
> +		.mask = 0x1,
> +		.shift = 31,
> +		.flags = CLK_MUX_ROUND_CLOSEST,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "cecb_32k_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&cecb_32k_sel_pre.hw,
> +			&rtc.hw,
> +		},
> +		.num_parents = 2,
> +		/*
> +		 * CECB_32K clk can be inherited from more accurate RTC clock,
> +		 * so in some situations we may want to freeze its parent.
> +		 * Therefore force cecb_32k parent setup on device tree side
> +		 */

How do you plan on doing that ?

You've made the parent "private" and it is not even available to be
referenced in DT.

This whole concept of public and private to seems broken to me.
I would much prefer you keep the existing model, with one big table and
possibly some IDs not exposed in the bindings.

This gives an hint about the clocks we think consummers should use while
allowing us to change things if we got it wrong, and keep the IDs stable
for DT. This has been working so far. I don't see the benefit of
changing that right now.

> +		.flags = CLK_SET_RATE_NO_REPARENT,
> +	},
> +};
> +

[...]

> +
> +static int meson_a1_periphs_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	void __iomem *base;
> +	struct regmap *map;
> +	int i, err;
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return dev_err_probe(dev, PTR_ERR(base),
> +				     "can't ioremap resource\n");
> +
> +	map = devm_regmap_init_mmio(dev, base, &a1_periphs_regmap_cfg);
> +	if (IS_ERR(map))
> +		return dev_err_probe(dev, PTR_ERR(map),
> +				     "can't init regmap mmio region\n");
> +
> +	/* Populate regmap for the regmap backed clocks */
> +	for (i = 0; i < ARRAY_SIZE(a1_periphs_regmaps); i++)
> +		a1_periphs_regmaps[i]->map = map;
> +
> +	/* DT clocks registration */
> +	err = meson_a1_periphs_clks_register(dev, &a1_periphs_public_clks);
> +	if (err)
> +		return dev_err_probe(dev, err,
> +				     "public clks registration failed\n");
> +
> +	/* Internal clocks registration */
> +	err = meson_a1_periphs_clks_register(dev, &a1_periphs_private_clks);
> +	if (err)
> +		return dev_err_probe(dev, err,
> +				     "private clks registration failed\n");

I defenitely don't like this public/private concept.
Please remove it

> +
> +	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> +					   &a1_periphs_public_clks);
> +}
> +
