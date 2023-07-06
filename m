Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20450749BB5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjGFMaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjGFMaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:30:00 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A405619A0;
        Thu,  6 Jul 2023 05:29:59 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="353426705"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="353426705"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 05:29:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="669736063"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="669736063"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 06 Jul 2023 05:29:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1qHO7M-000WDf-2I;
        Thu, 06 Jul 2023 15:29:52 +0300
Date:   Thu, 6 Jul 2023 15:29:52 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Huqiang Qin <huqiang.qin@amlogic.com>
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pinctrl: Add driver support for Amlogic C3 SoCs
Message-ID: <ZKazwMpmsNzBuWA7@smile.fi.intel.com>
References: <20230706114522.2490655-1-huqiang.qin@amlogic.com>
 <20230706114522.2490655-3-huqiang.qin@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706114522.2490655-3-huqiang.qin@amlogic.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 07:45:22PM +0800, Huqiang Qin wrote:
> Add new pinctrl driver for Amlogic C3 SoCs which share the

a new

> same register layout as the previous Amloigc S4

Missing period at the end.

...

> +config PINCTRL_AMLOGIC_C3
> +	tristate "Amlogic C3 SoC pinctrl driver"
> +	depends on ARM64
> +	select PINCTRL_MESON_AXG_PMX
> +	default y

This default seems a bad cargo cult. Why ARM64 kernel should have all them be
opt-out, instead of opt-in? Shouldn't this be a distro problem?

...

> +	MESON_PIN(GPIO_TEST_N)

Is it real one?

> +};

...

> +	/* Bank A func6 */
> +	GROUP(spi_a_mosi_a,		6),
> +	GROUP(gen_clk_a4,		6),
> +	GROUP(clk12_24_a,		6)

Leave trailing comma here as it's not a terminator.

...

> +static const char * const i2c2_groups[] = {
> +	"i2c2_sda", "i2c2_scl"

Ditto.

> +};
> +
> +static const char * const i2c3_groups[] = {
> +	"i2c3_sda_c", "i2c3_scl_c",
> +	"i2c3_sda_x", "i2c3_scl_x",
> +	"i2c3_sda_d", "i2c3_scl_d"

Ditto.

> +};

...

> +#ifdef CONFIG_OF

Drop this ugly ifdeffery.

> +static const struct of_device_id c3_pinctrl_dt_match[] = {
> +	{
> +		.compatible = "amlogic,c3-periphs-pinctrl",
> +		.data = &c3_periphs_pinctrl_data,
> +	},
> +	{ },

No comma for the terminator.

> +};
> +MODULE_DEVICE_TABLE(of, c3_pinctrl_dt_match);
> +#endif /* CONFIG_OF */
> +
> +static struct platform_driver c3_pinctrl_driver = {
> +	.probe  = meson_pinctrl_probe,
> +	.driver = {
> +		.name = "amlogic-c3-pinctrl",

> +		.of_match_table = of_match_ptr(c3_pinctrl_dt_match),

Drop the rather problematic of_match_ptr().

> +	},
> +};

-- 
With Best Regards,
Andy Shevchenko


