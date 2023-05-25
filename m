Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE0E710A42
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 12:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239997AbjEYKpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 06:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239153AbjEYKo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 06:44:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C549183;
        Thu, 25 May 2023 03:44:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0179644B2;
        Thu, 25 May 2023 10:44:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4D4C433D2;
        Thu, 25 May 2023 10:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685011481;
        bh=LlS1F8cwh1r/nZiCshl6b+JZeAs8nmuL9cV307kzXww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MO8FB7vfc05pIYExWqD7vMW6zg5Rwh5T6b/1gY+8jYIunXNwLkaApVwQYFHdP5fH6
         9g5R0iheLY813H6WHASWDufKBUbxN9bxcgLTxvPnoHvMGntq3pF7AIpOWQbRBcDuCW
         NPIkzFVsSk0nDPCxYiFNZ7xcdLdVHkEUKYPrOYlVF3puGSA3LiyBXArFOZEL683nmP
         mf4HoBE5d3DGEkIufLVdItfgJQ48goXQTb9t7W9BHL5TBLpHQQuzq8euOcL8d44j1+
         l6YeJm5I0/7W9Opga61x1nGvqs4MuNd2UshOXOyhcQMRz6jF6CCxj8+DcsDE8NxbUf
         8KzTrkL1GBzYQ==
Date:   Thu, 25 May 2023 11:44:34 +0100
From:   Lee Jones <lee@kernel.org>
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Henrik Grimler <henrik@grimler.se>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v6 04/10 RESEND] mfd: rt5033: Apply preparatory changes
 before adding rt5033-charger driver
Message-ID: <20230525104434.GD9691@google.com>
References: <cover.1684182964.git.jahau@rocketmail.com>
 <31c750ae13a1c1896b51d8f0a0d9869f8b85624f.1684182964.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31c750ae13a1c1896b51d8f0a0d9869f8b85624f.1684182964.git.jahau@rocketmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2023, Jakob Hauser wrote:

> Order the register blocks to have the masks in descending manner.
> 
> Add new defines for constant voltage shift (RT5033_CHGCTRL2_CV_SHIFT),
> MIVR mask (RT5033_CHGCTRL4_MIVR_MASK), pre-charge current shift
> (RT5033_CHGCTRL4_IPREC_SHIFT), internal timer disable
> (RT5033_INT_TIMER_DISABLE), termination disable (RT5033_TE_DISABLE),
> CFO disable (RT5033_CFO_DISABLE), UUG disable (RT5033_CHARGER_UUG_DISABLE).
> 
> The fast charge timer type needs to be written on mask 0x38
> (RT5033_CHGCTRL3_TIMER_MASK). To avoid a bit shift on application, change the
> values of the timer types to fit the mask. Added the timout duration as a
> comment. And the timer between TIMER8 and TIMER12 is most likely TIMER10, see
> e.g. RT5036 [1] page 28 bottom.
> 
> Add value options for MIVR (Minimum Input Voltage Regulation).
> 
> Move RT5033_TE_ENABLE_MASK to the block "RT5033 CHGCTRL1 register", in order
> to have the masks of the register collected there. To fit the naming scheme,
> rename it to RT5033_CHGCTRL1_TE_EN_MASK.
> 
> Move RT5033_CHG_MAX_CURRENT to the block "RT5033 charger fast-charge current".
> 
> Add new defines RT5033_CV_MAX_VOLTAGE and RT5033_CHG_MAX_PRE_CURRENT to the
> blocks "RT5033 charger constant charge voltage" and "RT5033 charger pre-charge
> current limits".
> 
> In include/linux/mfd/rt5033.h, turn power_supply "psy" into a pointer in order
> to use it in devm_power_supply_register().
> 
> [1] https://media.digikey.com/pdf/Data%20Sheets/Richtek%20PDF/RT5036%20%20Preliminary.pdf
> 
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> ---
>  include/linux/mfd/rt5033-private.h | 53 ++++++++++++++++++++----------
>  include/linux/mfd/rt5033.h         |  2 +-
>  2 files changed, 36 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/mfd/rt5033-private.h b/include/linux/mfd/rt5033-private.h
> index b6773ebf4e6b..0221f806d139 100644
> --- a/include/linux/mfd/rt5033-private.h
> +++ b/include/linux/mfd/rt5033-private.h
> @@ -55,22 +55,24 @@ enum rt5033_reg {
>  };
>  
>  /* RT5033 Charger state register */
> +#define RT5033_CHG_STAT_TYPE_MASK	0x60
> +#define RT5033_CHG_STAT_TYPE_PRE	0x20
> +#define RT5033_CHG_STAT_TYPE_FAST	0x60
>  #define RT5033_CHG_STAT_MASK		0x30
>  #define RT5033_CHG_STAT_DISCHARGING	0x00
>  #define RT5033_CHG_STAT_FULL		0x10
>  #define RT5033_CHG_STAT_CHARGING	0x20
>  #define RT5033_CHG_STAT_NOT_CHARGING	0x30
> -#define RT5033_CHG_STAT_TYPE_MASK	0x60
> -#define RT5033_CHG_STAT_TYPE_PRE	0x20
> -#define RT5033_CHG_STAT_TYPE_FAST	0x60
>  
>  /* RT5033 CHGCTRL1 register */
>  #define RT5033_CHGCTRL1_IAICR_MASK	0xe0
> -#define RT5033_CHGCTRL1_MODE_MASK	0x01
> +#define RT5033_CHGCTRL1_TE_EN_MASK	0x08
>  #define RT5033_CHGCTRL1_HZ_MASK		0x02
> +#define RT5033_CHGCTRL1_MODE_MASK	0x01
>  
>  /* RT5033 CHGCTRL2 register */
>  #define RT5033_CHGCTRL2_CV_MASK		0xfc
> +#define RT5033_CHGCTRL2_CV_SHIFT	0x02
>  
>  /* RT5033 DEVICE_ID register */
>  #define RT5033_VENDOR_ID_MASK		0xf0
> @@ -82,14 +84,15 @@ enum rt5033_reg {
>  #define RT5033_CHGCTRL3_TIMER_EN_MASK	0x01
>  
>  /* RT5033 CHGCTRL4 register */
> -#define RT5033_CHGCTRL4_EOC_MASK	0x07
> +#define RT5033_CHGCTRL4_MIVR_MASK	0xe0
>  #define RT5033_CHGCTRL4_IPREC_MASK	0x18
> +#define RT5033_CHGCTRL4_IPREC_SHIFT	0x03
> +#define RT5033_CHGCTRL4_EOC_MASK	0x07
>  
>  /* RT5033 CHGCTRL5 register */
> -#define RT5033_CHGCTRL5_VPREC_MASK	0x0f
>  #define RT5033_CHGCTRL5_ICHG_MASK	0xf0
>  #define RT5033_CHGCTRL5_ICHG_SHIFT	0x04
> -#define RT5033_CHG_MAX_CURRENT		0x0d
> +#define RT5033_CHGCTRL5_VPREC_MASK	0x0f
>  
>  /* RT5033 RT CTRL1 register */
>  #define RT5033_RT_CTRL1_UUG_MASK	0x02
> @@ -128,20 +131,28 @@ enum rt5033_reg {
>  #define RT5033_AICR_1500_MODE			0xc0
>  #define RT5033_AICR_2000_MODE			0xe0
>  
> -/* RT5033 use internal timer need to set time */
> -#define RT5033_FAST_CHARGE_TIMER4		0x00
> -#define RT5033_FAST_CHARGE_TIMER6		0x01
> -#define RT5033_FAST_CHARGE_TIMER8		0x02
> -#define RT5033_FAST_CHARGE_TIMER9		0x03
> -#define RT5033_FAST_CHARGE_TIMER12		0x04
> -#define RT5033_FAST_CHARGE_TIMER14		0x05
> -#define RT5033_FAST_CHARGE_TIMER16		0x06
> +/* RT5033 charger minimum input voltage regulation */
> +#define RT5033_CHARGER_MIVR_DISABLE		0x00
> +#define RT5033_CHARGER_MIVR_4200MV		0x20
> +#define RT5033_CHARGER_MIVR_4300MV		0x40
> +#define RT5033_CHARGER_MIVR_4400MV		0x60
> +#define RT5033_CHARGER_MIVR_4500MV		0x80
> +#define RT5033_CHARGER_MIVR_4600MV		0xa0
> +#define RT5033_CHARGER_MIVR_4700MV		0xc0
> +#define RT5033_CHARGER_MIVR_4800MV		0xe0
>  
> +/* RT5033 use internal timer need to set time */
> +#define RT5033_FAST_CHARGE_TIMER4		0x00 /*  4 hrs */
> +#define RT5033_FAST_CHARGE_TIMER6		0x08 /*  6 hrs */
> +#define RT5033_FAST_CHARGE_TIMER8		0x10 /*  8 hrs */
> +#define RT5033_FAST_CHARGE_TIMER10		0x18 /* 10 hrs */
> +#define RT5033_FAST_CHARGE_TIMER12		0x20 /* 12 hrs */
> +#define RT5033_FAST_CHARGE_TIMER14		0x28 /* 14 hrs */
> +#define RT5033_FAST_CHARGE_TIMER16		0x30 /* 16 hrs */
> +
> +#define RT5033_INT_TIMER_DISABLE		0x00
>  #define RT5033_INT_TIMER_ENABLE			0x01
>  
> -/* RT5033 charger termination enable mask */
> -#define RT5033_TE_ENABLE_MASK			0x08
> -
>  /*
>   * RT5033 charger opa mode. RT5033 has two opa modes for OTG: charger mode
>   * and boost mode.
> @@ -150,25 +161,30 @@ enum rt5033_reg {
>  #define RT5033_BOOST_MODE			0x01
>  
>  /* RT5033 charger termination enable */
> +#define RT5033_TE_DISABLE			0x00
>  #define RT5033_TE_ENABLE			0x08
>  
>  /* RT5033 charger CFO enable */
> +#define RT5033_CFO_DISABLE			0x00
>  #define RT5033_CFO_ENABLE			0x40
>  
>  /* RT5033 charger constant charge voltage (as in CHGCTRL2 register), uV */
>  #define RT5033_CHARGER_CONST_VOLTAGE_LIMIT_MIN	3650000U
>  #define RT5033_CHARGER_CONST_VOLTAGE_STEP_NUM   25000U
>  #define RT5033_CHARGER_CONST_VOLTAGE_LIMIT_MAX	4400000U
> +#define RT5033_CV_MAX_VOLTAGE			0x1e
>  
>  /* RT5033 charger pre-charge current limits (as in CHGCTRL4 register), uA */
>  #define RT5033_CHARGER_PRE_CURRENT_LIMIT_MIN	350000U
>  #define RT5033_CHARGER_PRE_CURRENT_STEP_NUM	100000U
>  #define RT5033_CHARGER_PRE_CURRENT_LIMIT_MAX	650000U
> +#define RT5033_CHG_MAX_PRE_CURRENT		0x03
>  
>  /* RT5033 charger fast-charge current (as in CHGCTRL5 register), uA */
>  #define RT5033_CHARGER_FAST_CURRENT_MIN		700000U
>  #define RT5033_CHARGER_FAST_CURRENT_STEP_NUM	100000U
>  #define RT5033_CHARGER_FAST_CURRENT_MAX		2000000U
> +#define RT5033_CHG_MAX_CURRENT			0x0d
>  
>  /*
>   * RT5033 charger const-charge end of charger current (
> @@ -192,6 +208,7 @@ enum rt5033_reg {
>   * RT5033 charger UUG. It enables MOS auto control by H/W charger
>   * circuit.
>   */
> +#define RT5033_CHARGER_UUG_DISABLE		0x00
>  #define RT5033_CHARGER_UUG_ENABLE		0x02
>  
>  /* RT5033 charger high impedance mode */
> diff --git a/include/linux/mfd/rt5033.h b/include/linux/mfd/rt5033.h
> index 8f306ac15a27..e99e2ab0c1c1 100644
> --- a/include/linux/mfd/rt5033.h
> +++ b/include/linux/mfd/rt5033.h
> @@ -51,7 +51,7 @@ struct rt5033_charger_data {
>  struct rt5033_charger {
>  	struct device			*dev;
>  	struct rt5033_dev		*rt5033;
> -	struct power_supply		psy;
> +	struct power_supply		*psy;

Is this current unused?

>  	struct rt5033_charger_data	*chg;
>  };
>  
> -- 
> 2.39.2
> 

-- 
Lee Jones [李琼斯]
