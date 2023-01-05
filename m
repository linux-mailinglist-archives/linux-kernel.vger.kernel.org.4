Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4337C65F14C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 17:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbjAEQiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 11:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbjAEQiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 11:38:12 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F463055E;
        Thu,  5 Jan 2023 08:38:11 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id bi26-20020a05600c3d9a00b003d3404a89faso2527621wmb.1;
        Thu, 05 Jan 2023 08:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNz1+SNOAH5EOrLuAu8eepOWhBwM/zlVgUZ5d3OEpuk=;
        b=dsQDpACpC9GH32zgLOkL1MJVzlpEDwNyHikYZF+3weiQFK/jusxi+dP60GXRj+2EXa
         sDdJxKGmEHc0eOBimnkVRdrvHVYfis6tMqas0KjOf70b3HIH8iIG75Dhzscl5asbO5l7
         PEc1vJCa2fPpq10xQK3Z1wwZA82SLlT0Gh0licQsjFovSF7g1L4+5/Gr9pL7E2C+iyej
         P82IM+AIc9YMTsGnLOFL4ODLxAW8iZpgTB4yw2Q8fpWfgpKhllr/TKKL8Hgo8/kp+fgg
         9hfbNOxX9nwbtheh4zY0K1ukLBmA785hU5A2hxCy3Z0FLNGWp89deKmgMJXDnZRVU5RG
         z2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wNz1+SNOAH5EOrLuAu8eepOWhBwM/zlVgUZ5d3OEpuk=;
        b=X9dJHtghB8CM/8U9e5gMdFPIzjnpc0N5mFMU697AttcjwaYiZzSkUWP9wrUCdXA0x2
         hR7lO37d5s6/ozM2ICipIAoLTWJFwe0ApS6KTDsQf0OZCF3IAQOUU4YE2huSC2svz606
         7H1+TSQ1TbANjV8nV483io6DUehVv4N24BeuIge7Nzhwj8oC/k0HypotdtLfotXsfInN
         UO3kLbGJF7oU/qTcsXEeZA9ojpq47JFWfNqJ+E/7eV+Bvew868nDFIgwMA7VWBpxOmTf
         tqwOUrgaMpL+Aa8U67ai9JNZKwhxX+CRFBFauMnl/ILRKLQxFxghPbaKzygJJnz93c7j
         ec8Q==
X-Gm-Message-State: AFqh2koTxwbyOsONOA6T9Oa3SbcTCjjYfcyItpCKR2KGc6pjosrYQpIM
        SfB+1xydVDfiA+JN3LOTPMagmZhQl5PSuYxC
X-Google-Smtp-Source: AMrXdXuisRBN6PkDQzbfN81cIVfpZOPmTB7oHmXcaS+Kwmn4OYTLR0IunW9abwJ54+IksW6A79O+NQ==
X-Received: by 2002:a05:600c:1da3:b0:3d0:965f:63ed with SMTP id p35-20020a05600c1da300b003d0965f63edmr36972131wms.23.1672936689527;
        Thu, 05 Jan 2023 08:38:09 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id r2-20020a05600c35c200b003d96bdddd3dsm3343717wmq.15.2023.01.05.08.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 08:38:09 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 2/2] soc: sunxi: Add Allwinner D1 PPU driver
Date:   Thu, 05 Jan 2023 17:38:07 +0100
Message-ID: <7469635.EvYhyI6sBW@jernej-laptop>
In-Reply-To: <20221231160402.16157-3-samuel@sholland.org>
References: <20221231160402.16157-1-samuel@sholland.org>
 <20221231160402.16157-3-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 31. december 2022 ob 17:04:02 CET je Samuel Holland napisal(a):
> The PPU contains a series of identical MMIO register ranges, one for
> each power domain. Each range contains control/status bits for a clock
> gate, reset line, output gates, and a power switch. (The clock and reset
> are separate from, and in addition to, the bits in the CCU.) It also
> contains a hardware power sequence engine to control the other bits.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  drivers/soc/sunxi/Kconfig      |   9 ++
>  drivers/soc/sunxi/Makefile     |   1 +
>  drivers/soc/sunxi/sun20i-ppu.c | 207 +++++++++++++++++++++++++++++++++
>  3 files changed, 217 insertions(+)
>  create mode 100644 drivers/soc/sunxi/sun20i-ppu.c
> 
> diff --git a/drivers/soc/sunxi/Kconfig b/drivers/soc/sunxi/Kconfig
> index 8aecbc9b1976..5e84cf4b8510 100644
> --- a/drivers/soc/sunxi/Kconfig
> +++ b/drivers/soc/sunxi/Kconfig
> @@ -19,3 +19,12 @@ config SUNXI_SRAM
>  	  Say y here to enable the SRAM controller support. This
>  	  device is responsible on mapping the SRAM in the sunXi SoCs
>  	  whether to the CPU/DMA, or to the devices.
> +
> +config SUN20I_PPU
> +	bool "Allwinner D1 PPU power domain driver"
> +	depends on ARCH_SUNXI || COMPILE_TEST
> +	select PM_GENERIC_DOMAINS
> +	help
> +	  Say y to enable the PPU power domain driver. This saves power
> +	  when certain peripherals, such as the video engine, are idle.
> +	  All power domains are on by default, so this is optional.

If this driver will gain support for other SoCs, above statement might not be 
true anymore. One such example is GPU on H616 (if PPU is compatible).

Other than that, driver looks good:
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> diff --git a/drivers/soc/sunxi/Makefile b/drivers/soc/sunxi/Makefile
> index 549159571d4f..90ff2ebe7655 100644
> --- a/drivers/soc/sunxi/Makefile
> +++ b/drivers/soc/sunxi/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_SUNXI_MBUS) +=	sunxi_mbus.o
>  obj-$(CONFIG_SUNXI_SRAM) +=	sunxi_sram.o
> +obj-$(CONFIG_SUN20I_PPU) +=	sun20i-ppu.o
> diff --git a/drivers/soc/sunxi/sun20i-ppu.c b/drivers/soc/sunxi/sun20i-ppu.c
> new file mode 100644
> index 000000000000..98cb41d36560
> --- /dev/null
> +++ b/drivers/soc/sunxi/sun20i-ppu.c
> @@ -0,0 +1,207 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/reset.h>
> +
> +#define PD_STATE_ON			1
> +#define PD_STATE_OFF			2
> +
> +#define PD_RSTN_REG			0x00
> +#define PD_CLK_GATE_REG			0x04
> +#define PD_PWROFF_GATE_REG		0x08
> +#define PD_PSW_ON_REG			0x0c
> +#define PD_PSW_OFF_REG			0x10
> +#define PD_PSW_DELAY_REG		0x14
> +#define PD_OFF_DELAY_REG		0x18
> +#define PD_ON_DELAY_REG			0x1c
> +#define PD_COMMAND_REG			0x20
> +#define PD_STATUS_REG			0x24
> +#define PD_STATUS_COMPLETE			BIT(1)
> +#define PD_STATUS_BUSY				BIT(3)
> +#define PD_STATUS_STATE				
GENMASK(17, 16)
> +#define PD_ACTIVE_CTRL_REG		0x2c
> +#define PD_GATE_STATUS_REG		0x30
> +#define PD_RSTN_STATUS				BIT(0)
> +#define PD_CLK_GATE_STATUS			BIT(1)
> +#define PD_PWROFF_GATE_STATUS			BIT(2)
> +#define PD_PSW_STATUS_REG		0x34
> +
> +#define PD_REGS_SIZE			0x80
> +
> +struct sun20i_ppu_desc {
> +	const char *const		*names;
> +	unsigned int			num_domains;
> +};
> +
> +struct sun20i_ppu_pd {
> +	struct generic_pm_domain	genpd;
> +	void __iomem			*base;
> +};
> +
> +#define to_sun20i_ppu_pd(_genpd) \
> +	container_of(_genpd, struct sun20i_ppu_pd, genpd)
> +
> +static bool sun20i_ppu_pd_is_on(const struct sun20i_ppu_pd *pd)
> +{
> +	u32 status = readl(pd->base + PD_STATUS_REG);
> +
> +	return FIELD_GET(PD_STATUS_STATE, status) == PD_STATE_ON;
> +}
> +
> +static int sun20i_ppu_pd_set_power(const struct sun20i_ppu_pd *pd, bool
> power_on) +{
> +	u32 state, status;
> +	int ret;
> +
> +	if (sun20i_ppu_pd_is_on(pd) == power_on)
> +		return 0;
> +
> +	/* Wait for the power controller to be idle. */
> +	ret = readl_poll_timeout(pd->base + PD_STATUS_REG, status,
> +				 !(status & PD_STATUS_BUSY), 100, 
1000);
> +	if (ret)
> +		return ret;
> +
> +	state = power_on ? PD_STATE_ON : PD_STATE_OFF;
> +	writel(state, pd->base + PD_COMMAND_REG);
> +
> +	/* Wait for the state transition to complete. */
> +	ret = readl_poll_timeout(pd->base + PD_STATUS_REG, status,
> +				 FIELD_GET(PD_STATUS_STATE, 
status) == state &&
> +				 (status & PD_STATUS_COMPLETE), 
100, 1000);
> +	if (ret)
> +		return ret;
> +
> +	/* Clear the completion flag. */
> +	writel(status, pd->base + PD_STATUS_REG);
> +
> +	return 0;
> +}
> +
> +static int sun20i_ppu_pd_power_on(struct generic_pm_domain *genpd)
> +{
> +	const struct sun20i_ppu_pd *pd = to_sun20i_ppu_pd(genpd);
> +
> +	return sun20i_ppu_pd_set_power(pd, true);
> +}
> +
> +static int sun20i_ppu_pd_power_off(struct generic_pm_domain *genpd)
> +{
> +	const struct sun20i_ppu_pd *pd = to_sun20i_ppu_pd(genpd);
> +
> +	return sun20i_ppu_pd_set_power(pd, false);
> +}
> +
> +static int sun20i_ppu_probe(struct platform_device *pdev)
> +{
> +	const struct sun20i_ppu_desc *desc;
> +	struct device *dev = &pdev->dev;
> +	struct genpd_onecell_data *ppu;
> +	struct sun20i_ppu_pd *pds;
> +	struct reset_control *rst;
> +	void __iomem *base;
> +	struct clk *clk;
> +	int ret;
> +
> +	desc = of_device_get_match_data(dev);
> +	if (!desc)
> +		return -EINVAL;
> +
> +	pds = devm_kcalloc(dev, desc->num_domains, sizeof(*pds), 
GFP_KERNEL);
> +	if (!pds)
> +		return -ENOMEM;
> +
> +	ppu = devm_kzalloc(dev, sizeof(*ppu), GFP_KERNEL);
> +	if (!ppu)
> +		return -ENOMEM;
> +
> +	ppu->domains = devm_kcalloc(dev, desc->num_domains,
> +				    sizeof(*ppu->domains), 
GFP_KERNEL);
> +	if (!ppu->domains)
> +		return -ENOMEM;
> +
> +	ppu->num_domains = desc->num_domains;
> +	platform_set_drvdata(pdev, ppu);
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	rst = devm_reset_control_get_exclusive(dev, NULL);
> +	if (IS_ERR(rst))
> +		return PTR_ERR(rst);
> +
> +	ret = reset_control_deassert(rst);
> +	if (ret)
> +		return ret;
> +
> +	for (unsigned int i = 0; i < ppu->num_domains; ++i) {
> +		struct sun20i_ppu_pd *pd = &pds[i];
> +
> +		pd->genpd.name		= desc->names[i];
> +		pd->genpd.power_off	= sun20i_ppu_pd_power_off;
> +		pd->genpd.power_on	= sun20i_ppu_pd_power_on;
> +		pd->base		= base + PD_REGS_SIZE * i;
> +
> +		ret = pm_genpd_init(&pd->genpd, NULL, 
sun20i_ppu_pd_is_on(pd));
> +		if (ret) {
> +			dev_warn(dev, "Failed to add '%s' domain: 
%d\n",
> +				 pd->genpd.name, ret);
> +			continue;
> +		}
> +
> +		ppu->domains[i] = &pd->genpd;
> +	}
> +
> +	ret = of_genpd_add_provider_onecell(dev->of_node, ppu);
> +	if (ret)
> +		dev_warn(dev, "Failed to add provider: %d\n", ret);
> +
> +	return 0;
> +}
> +
> +static const char *const sun20i_d1_ppu_pd_names[] = {
> +	"CPU",
> +	"VE",
> +	"DSP",
> +};
> +
> +static const struct sun20i_ppu_desc sun20i_d1_ppu_desc = {
> +	.names		= sun20i_d1_ppu_pd_names,
> +	.num_domains	= ARRAY_SIZE(sun20i_d1_ppu_pd_names),
> +};
> +
> +static const struct of_device_id sun20i_ppu_of_match[] = {
> +	{
> +		.compatible	= "allwinner,sun20i-d1-ppu",
> +		.data		= &sun20i_d1_ppu_desc,
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, sun20i_ppu_of_match);
> +
> +static struct platform_driver sun20i_ppu_driver = {
> +	.probe	= sun20i_ppu_probe,
> +	.driver	= {
> +		.name			= "sun20i-ppu",
> +		.of_match_table		= 
sun20i_ppu_of_match,
> +		/* Power domains cannot be removed while they are in 
use. */
> +		.suppress_bind_attrs	= true,
> +	},
> +};
> +module_platform_driver(sun20i_ppu_driver);
> +
> +MODULE_AUTHOR("Samuel Holland <samuel@sholland.org>");
> +MODULE_DESCRIPTION("Allwinner D1 PPU power domain driver");
> +MODULE_LICENSE("GPL");




