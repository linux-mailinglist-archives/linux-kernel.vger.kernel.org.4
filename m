Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63A76D908D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 09:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbjDFHhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 03:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235760AbjDFHg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 03:36:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581357A8D;
        Thu,  6 Apr 2023 00:36:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4D0D64033;
        Thu,  6 Apr 2023 07:36:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0904C433EF;
        Thu,  6 Apr 2023 07:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680766611;
        bh=lWo7xri9BF4OKp+AV7f4ABvghvxMYYhV4uTVy95KO94=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cUaOMYe/Pf64DswuZbgj8xbVxElmyknXnJ/mtcKdTufhVc+QN+bDKGCXFnMOkhbvO
         4HN/Xu0xQpa4/BUVpLR5/hREnlix9KXbyyZeCMGxfTM23rcAWrJ4si1wt8zeeX24uU
         EPIxEyKQBbBKN1oSvBYd7D3kVYOIf+iAHu+n97/erTgHcIaitMPluPa6GLRy5ZclG/
         /NeqxdPVV/KN+s2WhKl8YfzAYQGnlGWAa3J/k/SxOmG7RcZ5ZrCVELPveX+xu3vFbM
         5/PgNloN+A4g766HYjwvfzKhXWEpRgMIJMF4548NeGYzsJBv28V6w6tOQjCBAlAZba
         oR/4CI4Y5ronA==
Date:   Thu, 6 Apr 2023 08:36:46 +0100
From:   Lee Jones <lee@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mark Brown <broonie@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mfd tree
Message-ID: <20230406073646.GW8371@google.com>
References: <20230406120055.11fcfe5b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230406120055.11fcfe5b@canb.auug.org.au>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Apr 2023, Stephen Rothwell wrote:

> Hi all,
>
> After merging the mfd tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
>
> drivers/mfd/qcom-pm8008.c:135:35: error: initialization of 'int (*)(unsigned int **, unsigned int,  const struct regmap_irq *, int,  void *)' from incompatible pointer type 'int (*)(unsigned int **, unsigned int,  const struct regmap_irq *, int)' [-Werror=incompatible-pointer-types]
>   135 |         .set_type_config        = pm8008_set_type_config,
>       |                                   ^~~~~~~~~~~~~~~~~~~~~~
> drivers/mfd/qcom-pm8008.c:135:35: note: (near initialization for 'pm8008_irq_chip.set_type_config')
>
> Caused by commit
>
>   72a8a08b0c62 ("mfd: qcom-pm8008: Convert irq chip to config regs")
>
> interacting with commit
>
>   7697c64b9e49 ("regmap: Pass irq_drv_data as a parameter for set_type_config()")
>
> from the regmap tree.
>
> I have applied the following merge fix patch:
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Thu, 6 Apr 2023 11:37:44 +1000
> Subject: [PATCH] fixup for "mfd: qcom-pm8008: Convert irq chip to config regs"
>
> interacting with "regmap: Pass irq_drv_data as a parameter for set_type_config()"
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/mfd/qcom-pm8008.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
> index a33fbc42ac8e..e60c838a78c1 100644
> --- a/drivers/mfd/qcom-pm8008.c
> +++ b/drivers/mfd/qcom-pm8008.c
> @@ -85,7 +85,8 @@ static unsigned int pm8008_get_irq_reg(struct regmap_irq_chip_data *data,
>  }
>
>  static int pm8008_set_type_config(unsigned int **buf, unsigned int type,
> -				  const struct regmap_irq *irq_data, int idx)
> +				  const struct regmap_irq *irq_data, int idx,
> +				  void *irq_drv_data)
>  {
>  	switch (type) {
>  	case IRQ_TYPE_EDGE_FALLING:

Applied, squashed and credit given, thanks:

Author: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Date:   Thu Feb 16 22:22:12 2023 +0000

    mfd: qcom-pm8008: Convert irq chip to config regs

    Replace type and virtual registers, which are both deprecated,
    with config registers. This also simplifies the driver because
    IRQ types are set in one place, the set_type_config() callback.

    Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
    [Lee: Squashed in fix-up patch from Stephen Rothwell adapting to new .set_type_config() API]
    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
    Signed-off-by: Lee Jones <lee@kernel.org>
    Link: https://lore.kernel.org/r/20230216222214.138671-3-aidanmacdonald.0x0@gmail.com
---
 drivers/mfd/qcom-pm8008.c | 51 ++++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
index 39fd2a792e736..d502ecf055903 100644
--- a/drivers/mfd/qcom-pm8008.c
+++ b/drivers/mfd/qcom-pm8008.c
@@ -66,15 +66,16 @@ static struct regmap_irq_sub_irq_map pm8008_sub_reg_offsets[] = {
 	REGMAP_IRQ_MAIN_REG_OFFSET(p3_offs),
 };

-static unsigned int pm8008_virt_regs[] = {
-	PM8008_POLARITY_HI_BASE,
-	PM8008_POLARITY_LO_BASE,
-};
-
 enum {
+	SET_TYPE_INDEX,
 	POLARITY_HI_INDEX,
 	POLARITY_LO_INDEX,
-	PM8008_NUM_VIRT_REGS,
+};
+
+static unsigned int pm8008_config_regs[] = {
+	PM8008_TYPE_BASE,
+	PM8008_POLARITY_HI_BASE,
+	PM8008_POLARITY_LO_BASE,
 };

 static struct regmap_irq pm8008_irqs[] = {
@@ -88,32 +89,37 @@ static struct regmap_irq pm8008_irqs[] = {
 	REGMAP_IRQ_REG(PM8008_IRQ_GPIO2,	PM8008_GPIO2,	BIT(0)),
 };

-static int pm8008_set_type_virt(unsigned int **virt_buf,
-				     unsigned int type, unsigned long hwirq,
-				     int reg)
+static int pm8008_set_type_config(unsigned int **buf, unsigned int type,
+				 const struct regmap_irq *irq_data, int idx,
+				 void *irq_drv_data)
 {
 	switch (type) {
 	case IRQ_TYPE_EDGE_FALLING:
 	case IRQ_TYPE_LEVEL_LOW:
-		virt_buf[POLARITY_HI_INDEX][reg] &= ~pm8008_irqs[hwirq].mask;
-		virt_buf[POLARITY_LO_INDEX][reg] |= pm8008_irqs[hwirq].mask;
+		buf[POLARITY_HI_INDEX][idx] &= ~irq_data->mask;
+		buf[POLARITY_LO_INDEX][idx] |= irq_data->mask;
 		break;

 	case IRQ_TYPE_EDGE_RISING:
 	case IRQ_TYPE_LEVEL_HIGH:
-		virt_buf[POLARITY_HI_INDEX][reg] |= pm8008_irqs[hwirq].mask;
-		virt_buf[POLARITY_LO_INDEX][reg] &= ~pm8008_irqs[hwirq].mask;
+		buf[POLARITY_HI_INDEX][idx] |= irq_data->mask;
+		buf[POLARITY_LO_INDEX][idx] &= ~irq_data->mask;
 		break;

 	case IRQ_TYPE_EDGE_BOTH:
-		virt_buf[POLARITY_HI_INDEX][reg] |= pm8008_irqs[hwirq].mask;
-		virt_buf[POLARITY_LO_INDEX][reg] |= pm8008_irqs[hwirq].mask;
+		buf[POLARITY_HI_INDEX][idx] |= irq_data->mask;
+		buf[POLARITY_LO_INDEX][idx] |= irq_data->mask;
 		break;

 	default:
 		return -EINVAL;
 	}

+	if (type & IRQ_TYPE_EDGE_BOTH)
+		buf[SET_TYPE_INDEX][idx] |= irq_data->mask;
+	else
+		buf[SET_TYPE_INDEX][idx] &= ~irq_data->mask;
+
 	return 0;
 }

@@ -121,21 +127,20 @@ static struct regmap_irq_chip pm8008_irq_chip = {
 	.name			= "pm8008_irq",
 	.main_status		= I2C_INTR_STATUS_BASE,
 	.num_main_regs		= 1,
-	.num_virt_regs		= PM8008_NUM_VIRT_REGS,
 	.irqs			= pm8008_irqs,
 	.num_irqs		= ARRAY_SIZE(pm8008_irqs),
 	.num_regs		= PM8008_NUM_PERIPHS,
 	.not_fixed_stride	= true,
 	.sub_reg_offsets	= pm8008_sub_reg_offsets,
-	.set_type_virt		= pm8008_set_type_virt,
 	.status_base		= PM8008_STATUS_BASE,
 	.mask_base		= PM8008_MASK_BASE,
 	.unmask_base		= PM8008_UNMASK_BASE,
 	.mask_unmask_non_inverted = true,
-	.type_base		= PM8008_TYPE_BASE,
 	.ack_base		= PM8008_ACK_BASE,
-	.virt_reg_base		= pm8008_virt_regs,
-	.num_type_reg		= PM8008_NUM_PERIPHS,
+	.config_base		= pm8008_config_regs,
+	.num_config_bases	= ARRAY_SIZE(pm8008_config_regs),
+	.num_config_regs	= PM8008_NUM_PERIPHS,
+	.set_type_config	= pm8008_set_type_config,
 };

 static struct regmap_config qcom_mfd_regmap_cfg = {
@@ -185,11 +190,7 @@ static int pm8008_probe_irq_peripherals(struct device *dev,
 	for (i = 0; i < ARRAY_SIZE(pm8008_irqs); i++) {
 		type = &pm8008_irqs[i].type;

-		type->type_reg_offset	 = pm8008_irqs[i].reg_offset;
-		type->type_rising_val	 = pm8008_irqs[i].mask;
-		type->type_falling_val	 = pm8008_irqs[i].mask;
-		type->type_level_high_val = 0;
-		type->type_level_low_val  = 0;
+		type->type_reg_offset = pm8008_irqs[i].reg_offset;

 		if (type->type_reg_offset == PM8008_MISC)
 			type->types_supported = IRQ_TYPE_EDGE_RISING;

--
Lee Jones [李琼斯]
