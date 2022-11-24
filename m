Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC75637EC0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 19:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiKXSBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 13:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiKXSBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 13:01:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC2C69AAE;
        Thu, 24 Nov 2022 10:01:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BBB5B8289C;
        Thu, 24 Nov 2022 18:01:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ADD2C433C1;
        Thu, 24 Nov 2022 18:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669312901;
        bh=EMUIqcekXDxF2T2UEtKI6E/U2025QdZldptvyR0lc9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LDqjmKZ3M8EjXF4DNv7xMGPX/s9Xlr7aYiLbcKTmzYZzMeOJroo2CVJcEaux5D+wJ
         X4wfb8kw4OD47huJWVd4loTgpe8n4eoY2v/o/ELaDGlMugORfU2g+Kmmg2BzWv3Nxm
         sElfd/NF6F++S+xB8kHrj2z3pk2RDlPBYGMNjUe2aDu50EPLYgNPBW1D1nFpWe+B1F
         cWV5VnwEqdhP8B+7mMvImIurr8AFmZaSrJC/AA31WVOucCtGDMrE/yT4U6yShNuZ48
         9ML+cZXte3x4xbRpIzQ8CJzSFhceeQIANwkqDeGodH6H6N3jn7WJmLX7YUYPK0FCbv
         w5AavteMpI2PQ==
Date:   Thu, 24 Nov 2022 23:31:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH 09/10] phy: qualcomm: Add QCOM SNPS eUSB2 driver
Message-ID: <Y3+xgXZMMqWbLdS8@matsya>
References: <20221116120157.2706810-1-abel.vesa@linaro.org>
 <20221116120157.2706810-10-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116120157.2706810-10-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-11-22, 14:01, Abel Vesa wrote:
> The SM8550 SoC uses Synopsis eUSB2 PHY for USB 2.0.
> Add a new driver for it.
> 
> The driver is based on a downstream implementation.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/phy/qualcomm/Kconfig               |   9 +
>  drivers/phy/qualcomm/Makefile              |   1 +
>  drivers/phy/qualcomm/phy-qcom-snps-eusb2.c | 428 +++++++++++++++++++++
>  3 files changed, 438 insertions(+)
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-snps-eusb2.c
> 
> diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
> index eb9ddc685b38..27b5a2a3637d 100644
> --- a/drivers/phy/qualcomm/Kconfig
> +++ b/drivers/phy/qualcomm/Kconfig
> @@ -70,6 +70,15 @@ config PHY_QCOM_QUSB2
>  	  PHY which is usually paired with either the ChipIdea or Synopsys DWC3
>  	  USB IPs on MSM SOCs.
>  
> +config PHY_QCOM_SNPS_EUSB2
> +	tristate "Qualcomm SNPS eUSB2 PHY Driver"
> +	depends on OF && (ARCH_QCOM || COMPILE_TEST)
> +	select GENERIC_PHY
> +	help
> +	  Enable support for the USB high-speed SNPS eUSB2 phy on Qualcomm
> +	  chipsets. The PHY is paired with a Synopsys DWC3 USB controller
> +	  on Qualcomm SOCs.
> +
>  config PHY_QCOM_USB_HS
>  	tristate "Qualcomm USB HS PHY module"
>  	depends on USB_ULPI_BUS
> diff --git a/drivers/phy/qualcomm/Makefile b/drivers/phy/qualcomm/Makefile
> index 65f6c30a3e93..3ee118f4dfc7 100644
> --- a/drivers/phy/qualcomm/Makefile
> +++ b/drivers/phy/qualcomm/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_PHY_QCOM_QMP)		+= \
>  	phy-qcom-qmp-usb.o
>  
>  obj-$(CONFIG_PHY_QCOM_QUSB2)		+= phy-qcom-qusb2.o
> +obj-$(CONFIG_PHY_QCOM_SNPS_EUSB2)	+= phy-qcom-snps-eusb2.o
>  obj-$(CONFIG_PHY_QCOM_USB_HS) 		+= phy-qcom-usb-hs.o
>  obj-$(CONFIG_PHY_QCOM_USB_HSIC) 	+= phy-qcom-usb-hsic.o
>  obj-$(CONFIG_PHY_QCOM_USB_HS_28NM)	+= phy-qcom-usb-hs-28nm.o
> diff --git a/drivers/phy/qualcomm/phy-qcom-snps-eusb2.c b/drivers/phy/qualcomm/phy-qcom-snps-eusb2.c
> new file mode 100644
> index 000000000000..1bb42ec14703
> --- /dev/null
> +++ b/drivers/phy/qualcomm/phy-qcom-snps-eusb2.c
> @@ -0,0 +1,428 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2022, Linaro Limited
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/reset.h>
> +#include <linux/slab.h>

do you really need all of these?

> +
> +#define USB_PHY_UTMI_CTRL0		(0x3c)
> +#define SLEEPM				BIT(0)
> +#define OPMODE_MASK			GENMASK(4, 3)
> +#define OPMODE_NONDRIVING		BIT(3)
> +
> +#define USB_PHY_UTMI_CTRL5		(0x50)
> +#define POR				BIT(1)
> +
> +#define USB_PHY_HS_PHY_CTRL_COMMON0	(0x54)
> +#define PHY_ENABLE			BIT(0)
> +#define SIDDQ_SEL			BIT(1)
> +#define SIDDQ				BIT(2)
> +#define RETENABLEN			BIT(3)
> +#define FSEL_MASK			GENMASK(6, 4)
> +#define FSEL_19_2_MHZ_VAL		(0x0)
> +#define FSEL_38_4_MHZ_VAL		(0x4)
> +
> +#define USB_PHY_CFG_CTRL_1		(0x58)
> +#define PHY_CFG_PLL_CPBIAS_CNTRL_MASK	GENMASK(7, 1)
> +
> +#define USB_PHY_CFG_CTRL_2		(0x5c)
> +#define PHY_CFG_PLL_FB_DIV_7_0_MASK	GENMASK(7, 0)
> +#define DIV_7_0_19_2_MHZ_VAL		(0x90)
> +#define DIV_7_0_38_4_MHZ_VAL		(0xc8)
> +
> +#define USB_PHY_CFG_CTRL_3		(0x60)
> +#define PHY_CFG_PLL_FB_DIV_11_8_MASK	GENMASK(3, 0)
> +#define DIV_11_8_19_2_MHZ_VAL		(0x1)
> +#define DIV_11_8_38_4_MHZ_VAL		(0x0)
> +
> +#define PHY_CFG_PLL_REF_DIV		GENMASK(7, 4)
> +#define PLL_REF_DIV_VAL			(0x0)
> +
> +#define USB_PHY_HS_PHY_CTRL2		(0x64)
> +#define VBUSVLDEXT0			BIT(0)
> +#define USB2_SUSPEND_N			BIT(2)
> +#define USB2_SUSPEND_N_SEL		BIT(3)
> +#define VBUS_DET_EXT_SEL		BIT(4)
> +
> +#define USB_PHY_CFG_CTRL_4		(0x68)
> +#define PHY_CFG_PLL_GMP_CNTRL_MASK	GENMASK(1, 0)
> +#define PHY_CFG_PLL_INT_CNTRL_MASK	GENMASK(7, 2)
> +
> +#define USB_PHY_CFG_CTRL_5		(0x6c)
> +#define PHY_CFG_PLL_PROP_CNTRL_MASK	GENMASK(4, 0)
> +#define PHY_CFG_PLL_VREF_TUNE_MASK	GENMASK(7, 6)
> +
> +#define USB_PHY_CFG_CTRL_6		(0x70)
> +#define PHY_CFG_PLL_VCO_CNTRL_MASK	GENMASK(2, 0)
> +
> +#define USB_PHY_CFG_CTRL_7		(0x74)
> +
> +#define USB_PHY_CFG_CTRL_8		(0x78)
> +#define PHY_CFG_TX_FSLS_VREF_TUNE_MASK	GENMASK(1, 0)
> +#define PHY_CFG_TX_FSLS_VREG_BYPASS	BIT(2)
> +#define PHY_CFG_TX_HS_VREF_TUNE_MASK	GENMASK(5, 3)
> +#define PHY_CFG_TX_HS_XV_TUNE_MASK	GENMASK(7, 6)
> +
> +#define USB_PHY_CFG_CTRL_9		(0x7c)
> +#define PHY_CFG_TX_PREEMP_TUNE_MASK	GENMASK(2, 0)
> +#define PHY_CFG_TX_RES_TUNE_MASK	GENMASK(4, 3)
> +#define PHY_CFG_TX_RISE_TUNE_MASK	GENMASK(6, 5)
> +#define PHY_CFG_RCAL_BYPASS		BIT(7)
> +
> +#define USB_PHY_CFG_CTRL_10		(0x80)
> +
> +#define USB_PHY_CFG0			(0x94)
> +#define DATAPATH_CTRL_OVERRIDE_EN	BIT(0)
> +#define CMN_CTRL_OVERRIDE_EN		BIT(1)
> +
> +#define UTMI_PHY_CMN_CTRL0		(0x98)
> +#define TESTBURNIN			BIT(6)
> +
> +#define USB_PHY_FSEL_SEL		(0xb8)
> +#define FSEL_SEL			BIT(0)
> +
> +#define USB_PHY_APB_ACCESS_CMD		(0x130)
> +#define RW_ACCESS			BIT(0)
> +#define APB_START_CMD			BIT(1)
> +#define APB_LOGIC_RESET			BIT(2)
> +
> +#define USB_PHY_APB_ACCESS_STATUS	(0x134)
> +#define ACCESS_DONE			BIT(0)
> +#define TIMED_OUT			BIT(1)
> +#define ACCESS_ERROR			BIT(2)
> +#define ACCESS_IN_PROGRESS		BIT(3)
> +
> +#define USB_PHY_APB_ADDRESS		(0x138)
> +#define APB_REG_ADDR_MASK		GENMASK(7, 0)
> +
> +#define USB_PHY_APB_WRDATA_LSB		(0x13c)
> +#define APB_REG_WRDATA_7_0_MASK		GENMASK(3, 0)
> +
> +#define USB_PHY_APB_WRDATA_MSB		(0x140)
> +#define APB_REG_WRDATA_15_8_MASK	GENMASK(7, 4)
> +
> +#define USB_PHY_APB_RDDATA_LSB		(0x144)
> +#define APB_REG_RDDATA_7_0_MASK		GENMASK(3, 0)
> +
> +#define USB_PHY_APB_RDDATA_MSB		(0x148)
> +#define APB_REG_RDDATA_15_8_MASK	GENMASK(7, 4)
> +
> +static const char * const qcom_snps_eusb2_hsphy_vreg_names[] = {
> +	"vdd", "vdda12",
> +};
> +
> +#define EUSB2_NUM_VREGS		ARRAY_SIZE(qcom_snps_eusb2_hsphy_vreg_names)

that_is_a_very_long_name, maybe eusb2_vreg_names ?

local structs needs not have qcom_snps_eusb2_foo eusb2_foo may suffice

> +
> +struct qcom_snps_eusb2_hsphy {
> +	struct phy *phy;
> +	void __iomem *base;
> +
> +	struct clk *ref_clk;
> +	struct reset_control *phy_reset;
> +
> +	struct regulator_bulk_data vregs[EUSB2_NUM_VREGS];
> +
> +	enum phy_mode mode;
> +};
> +
> +static int qcom_snps_eusb2_hsphy_set_mode(struct phy *p, enum phy_mode mode, int submode)
> +{
> +	struct qcom_snps_eusb2_hsphy *phy = phy_get_drvdata(p);
> +
> +	phy->mode = mode;
> +
> +	return 0;
> +}
> +
> +static void qcom_snps_eusb2_hsphy_write_mask(void __iomem *base, u32 offset,
> +					     u32 mask, u32 val)

align with preceding open please

> +{
> +	u32 reg;
> +
> +	reg = readl_relaxed(base + offset);
> +	reg &= ~mask;
> +	reg |= val & mask;
> +	writel_relaxed(reg, base + offset);
> +
> +	/* Ensure above write is completed */
> +	readl_relaxed(base + offset);
> +}
> +
> +static void qcom_eusb2_default_parameters(struct qcom_snps_eusb2_hsphy *phy)
> +{
> +	/* default parameters: tx pre-emphasis */
> +	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_CFG_CTRL_9,
> +					 PHY_CFG_TX_PREEMP_TUNE_MASK,
> +					 FIELD_PREP(PHY_CFG_TX_PREEMP_TUNE_MASK, 0));
> +
> +	/* tx rise/fall time */
> +	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_CFG_CTRL_9,
> +					 PHY_CFG_TX_RISE_TUNE_MASK,
> +					 FIELD_PREP(PHY_CFG_TX_RISE_TUNE_MASK, 0x2));
> +
> +	/* source impedance adjustment */
> +	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_CFG_CTRL_9,
> +					 PHY_CFG_TX_RES_TUNE_MASK,
> +					 FIELD_PREP(PHY_CFG_TX_RES_TUNE_MASK, 0x1));
> +
> +	/* dc voltage level adjustement */
> +	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_CFG_CTRL_8,
> +					 PHY_CFG_TX_HS_VREF_TUNE_MASK,
> +					 FIELD_PREP(PHY_CFG_TX_HS_VREF_TUNE_MASK, 0x3));
> +
> +	/* transmitter HS crossover adjustement */
> +	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_CFG_CTRL_8,
> +					 PHY_CFG_TX_HS_XV_TUNE_MASK,
> +					 FIELD_PREP(PHY_CFG_TX_HS_XV_TUNE_MASK, 0x0));
> +}
> +
> +static int qcom_eusb2_ref_clk_init(struct qcom_snps_eusb2_hsphy *phy)
> +{
> +	unsigned long ref_clk_freq = clk_get_rate(clk_get_parent(phy->ref_clk));
> +
> +	switch (ref_clk_freq) {
> +	case 19200000:
> +		qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_HS_PHY_CTRL_COMMON0,
> +						 FSEL_MASK,
> +						 FIELD_PREP(FSEL_MASK, FSEL_19_2_MHZ_VAL));
> +
> +		qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_CFG_CTRL_2,
> +						 PHY_CFG_PLL_FB_DIV_7_0_MASK,
> +						 DIV_7_0_19_2_MHZ_VAL);
> +
> +		qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_CFG_CTRL_3,
> +						 PHY_CFG_PLL_FB_DIV_11_8_MASK,
> +						 DIV_11_8_19_2_MHZ_VAL);
> +		break;

empty line here

> +	case 38400000:
> +		qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_HS_PHY_CTRL_COMMON0,
> +						 FSEL_MASK,
> +						 FIELD_PREP(FSEL_MASK, FSEL_38_4_MHZ_VAL));
> +
> +		qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_CFG_CTRL_2,
> +						 PHY_CFG_PLL_FB_DIV_7_0_MASK,
> +						 DIV_7_0_38_4_MHZ_VAL);
> +
> +		qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_CFG_CTRL_3,
> +						 PHY_CFG_PLL_FB_DIV_11_8_MASK,
> +						 DIV_11_8_38_4_MHZ_VAL);
> +		break;
> +	default:
> +		dev_err(&phy->phy->dev, "unsupported ref_clk_freq:%lu\n",
> +						ref_clk_freq);
> +		return -EINVAL;
> +	}
> +
> +	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_CFG_CTRL_3,
> +					 PHY_CFG_PLL_REF_DIV, PLL_REF_DIV_VAL);
> +
> +	return 0;
> +}
> +
> +static int qcom_snps_eusb2_hsphy_init(struct phy *p)
> +{
> +	struct qcom_snps_eusb2_hsphy *phy = phy_get_drvdata(p);
> +	int ret;
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(phy->vregs), phy->vregs);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_prepare_enable(phy->ref_clk);
> +	if (ret) {
> +		dev_err(&p->dev, "failed to enable ref clock, %d\n", ret);
> +		goto disable_vreg;
> +	}
> +
> +	ret = reset_control_assert(phy->phy_reset);
> +	if (ret) {
> +		dev_err(&p->dev, "failed to assert phy_reset, %d\n", ret);
> +		goto disable_ref_clk;
> +	}
> +
> +	usleep_range(100, 150);
> +
> +	ret = reset_control_deassert(phy->phy_reset);
> +	if (ret) {
> +		dev_err(&p->dev, "failed to de-assert phy_reset, %d\n", ret);
> +		goto disable_ref_clk;
> +	}
> +
> +	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_CFG0,
> +					 CMN_CTRL_OVERRIDE_EN, CMN_CTRL_OVERRIDE_EN);
> +
> +	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_UTMI_CTRL5, POR, POR);
> +
> +	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_HS_PHY_CTRL_COMMON0,
> +					 PHY_ENABLE | RETENABLEN, PHY_ENABLE | RETENABLEN);
> +
> +	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_APB_ACCESS_CMD,
> +					 APB_LOGIC_RESET, APB_LOGIC_RESET);
> +
> +	qcom_snps_eusb2_hsphy_write_mask(phy->base, UTMI_PHY_CMN_CTRL0, TESTBURNIN, 0);
> +
> +	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_FSEL_SEL,
> +					 FSEL_SEL, FSEL_SEL);
> +
> +	/* update ref_clk related registers */
> +	ret = qcom_eusb2_ref_clk_init(phy);
> +	if (ret)
> +		goto disable_ref_clk;
> +
> +	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_CFG_CTRL_1,
> +					 PHY_CFG_PLL_CPBIAS_CNTRL_MASK,
> +					 FIELD_PREP(PHY_CFG_PLL_CPBIAS_CNTRL_MASK, 0x1));
> +
> +	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_CFG_CTRL_4,
> +					 PHY_CFG_PLL_INT_CNTRL_MASK,
> +					 FIELD_PREP(PHY_CFG_PLL_INT_CNTRL_MASK, 0x8));
> +
> +	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_CFG_CTRL_4,
> +					 PHY_CFG_PLL_GMP_CNTRL_MASK,
> +					 FIELD_PREP(PHY_CFG_PLL_GMP_CNTRL_MASK, 0x1));
> +
> +	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_CFG_CTRL_5,
> +					 PHY_CFG_PLL_PROP_CNTRL_MASK,
> +					 FIELD_PREP(PHY_CFG_PLL_PROP_CNTRL_MASK, 0x10));
> +
> +	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_CFG_CTRL_6,
> +					 PHY_CFG_PLL_VCO_CNTRL_MASK,
> +					 FIELD_PREP(PHY_CFG_PLL_VCO_CNTRL_MASK, 0x0));
> +
> +	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_CFG_CTRL_5,
> +					 PHY_CFG_PLL_VREF_TUNE_MASK,
> +					 FIELD_PREP(PHY_CFG_PLL_VREF_TUNE_MASK, 0x1));
> +
> +	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_HS_PHY_CTRL2,
> +					 VBUS_DET_EXT_SEL, VBUS_DET_EXT_SEL);
> +
> +	/* set default parameters */
> +	qcom_eusb2_default_parameters(phy);
> +
> +	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_HS_PHY_CTRL2,
> +					 USB2_SUSPEND_N_SEL | USB2_SUSPEND_N,
> +					 USB2_SUSPEND_N_SEL | USB2_SUSPEND_N);
> +
> +	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_UTMI_CTRL0, SLEEPM, SLEEPM);
> +
> +	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_HS_PHY_CTRL_COMMON0,
> +					 SIDDQ_SEL, SIDDQ_SEL);
> +
> +	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_HS_PHY_CTRL_COMMON0,
> +					 SIDDQ, 0);
> +
> +	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_UTMI_CTRL5, POR, 0);
> +
> +	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_HS_PHY_CTRL2,
> +					 USB2_SUSPEND_N_SEL, 0);
> +
> +	return 0;
> +
> +disable_ref_clk:
> +	clk_disable_unprepare(phy->ref_clk);
> +
> +disable_vreg:
> +	regulator_bulk_disable(ARRAY_SIZE(phy->vregs), phy->vregs);
> +
> +	return ret;
> +}
> +
> +static int qcom_snps_eusb2_hsphy_exit(struct phy *p)
> +{
> +	struct qcom_snps_eusb2_hsphy *phy = phy_get_drvdata(p);
> +
> +	clk_disable_unprepare(phy->ref_clk);
> +
> +	regulator_bulk_disable(ARRAY_SIZE(phy->vregs), phy->vregs);
> +
> +	return 0;
> +}
> +
> +static const struct phy_ops qcom_snps_eusb2_hsphy_ops = {
> +	.init		= qcom_snps_eusb2_hsphy_init,
> +	.exit		= qcom_snps_eusb2_hsphy_exit,
> +	.set_mode	= qcom_snps_eusb2_hsphy_set_mode,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static int qcom_snps_eusb2_hsphy_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct qcom_snps_eusb2_hsphy *phy;
> +	struct phy_provider *phy_provider;
> +	struct phy *generic_phy;
> +	int ret, i;
> +	int num;
> +
> +	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
> +	if (!phy)
> +		return -ENOMEM;
> +
> +	phy->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(phy->base))
> +		return PTR_ERR(phy->base);
> +
> +	phy->phy_reset = devm_reset_control_get_exclusive(dev, NULL);
> +	if (IS_ERR(phy->phy_reset))
> +		return PTR_ERR(phy->phy_reset);
> +
> +	phy->ref_clk = devm_clk_get(dev, "ref");
> +	if (IS_ERR(phy->ref_clk))
> +		return dev_err_probe(dev, PTR_ERR(phy->ref_clk),
> +				     "failed to get ref clk\n");
> +
> +	num = ARRAY_SIZE(phy->vregs);
> +	for (i = 0; i < num; i++)
> +		phy->vregs[i].supply = qcom_snps_eusb2_hsphy_vreg_names[i];
> +
> +	ret = devm_regulator_bulk_get(dev, num, phy->vregs);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to get regulator supplies\n");
> +	generic_phy = devm_phy_create(dev, NULL, &qcom_snps_eusb2_hsphy_ops);
> +	if (IS_ERR(generic_phy)) {
> +		dev_err(dev, "failed to create phy %d\n", ret);
> +		return PTR_ERR(generic_phy);
> +	}
> +
> +	dev_set_drvdata(dev, phy);
> +	phy_set_drvdata(generic_phy, phy);
> +
> +	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +	if (IS_ERR(phy_provider))
> +		return PTR_ERR(phy_provider);
> +
> +	dev_info(dev, "Registered Qcom-eUSB2 phy\n");
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id qcom_snps_eusb2_hsphy_of_match_table[] = {
> +	{ .compatible = "qcom,sm8550-snps-eusb2-phy", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, qcom_snps_eusb2_hsphy_of_match_table);
> +
> +static struct platform_driver qcom_snps_eusb2_hsphy_driver = {
> +	.probe		= qcom_snps_eusb2_hsphy_probe,
> +	.driver = {
> +		.name	= "qcom-snps-eusb2-hsphy",
> +		.of_match_table = qcom_snps_eusb2_hsphy_of_match_table,
> +	},
> +};
> +
> +module_platform_driver(qcom_snps_eusb2_hsphy_driver);
> +MODULE_DESCRIPTION("Qualcomm SNPS eUSB2 HS PHY driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.34.1

-- 
~Vinod
