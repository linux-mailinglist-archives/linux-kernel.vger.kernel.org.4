Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8E16EEF85
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 09:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239965AbjDZHn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 03:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239944AbjDZHn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 03:43:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EAF3C0F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:43:47 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <pza@pengutronix.de>)
        id 1prZoO-0001la-DI; Wed, 26 Apr 2023 09:43:36 +0200
Received: from pza by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <pza@pengutronix.de>)
        id 1prZoM-0001fM-I9; Wed, 26 Apr 2023 09:43:34 +0200
Date:   Wed, 26 Apr 2023 09:43:34 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-clk@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v7 2/2] clk: wpcm450: Add Nuvoton WPCM450 clock/reset
 controller driver
Message-ID: <20230426074334.GC4724@pengutronix.de>
References: <20230422220240.322572-1-j.neuschaefer@gmx.net>
 <20230422220240.322572-3-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230422220240.322572-3-j.neuschaefer@gmx.net>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: pza@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Sun, Apr 23, 2023 at 12:02:40AM +0200, Jonathan Neuschäfer wrote:
> This driver implements the following features w.r.t. the clock and reset
> controller in the WPCM450 SoC:
> 
> - It calculates the rates for all clocks managed by the clock controller
> - It leaves the clock tree mostly unchanged, except that it enables/
>   disables clock gates based on usage.
> - It exposes the reset lines managed by the controller using the
>   Generic Reset Controller subsystem
> 
> NOTE: If the driver and the corresponding devicetree node are present,
>       the driver will disable "unused" clocks. This is problem until
>       the clock relations are properly declared in the devicetree (in a
>       later patch). Until then, the clk_ignore_unused kernel parameter
>       can be used as a workaround.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
[...]
> diff --git a/drivers/clk/clk-wpcm450.c b/drivers/clk/clk-wpcm450.c
> new file mode 100644
> index 0000000000000..6f6d8a1ea3484
> --- /dev/null
> +++ b/drivers/clk/clk-wpcm450.c
> @@ -0,0 +1,374 @@
[...]
> +static void __init wpcm450_clk_init(struct device_node *clk_np)
> +{
> +	struct clk_hw_onecell_data *clk_data;
> +	static struct clk_hw **hws;
> +	static struct clk_hw *hw;
> +	void __iomem *clk_base;
> +	int i, ret;
> +	struct reset_simple_data *reset;
[...]
> +	// Reset controller
> +	reset = kzalloc(sizeof(*reset), GFP_KERNEL);
> +	if (!reset)
> +		return;
> +	reset->rcdev.owner = THIS_MODULE;
> +	reset->rcdev.nr_resets = WPCM450_NUM_RESETS;
> +	reset->rcdev.ops = &reset_simple_ops;
> +	reset->rcdev.of_node = clk_np;
> +	reset->membase = clk_base + REG_IPSRST;
> +	ret = reset_controller_register(&reset->rcdev);
> +	if (ret)
> +		pr_err("Failed to register reset controller: %d\n", ret);

You could use %pe for consistency.

regards
Philipp
