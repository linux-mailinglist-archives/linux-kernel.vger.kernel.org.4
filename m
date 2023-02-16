Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179D5699FAA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 23:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjBPWWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 17:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjBPWWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 17:22:46 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7264D609;
        Thu, 16 Feb 2023 14:22:44 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id r2so3254229wrv.7;
        Thu, 16 Feb 2023 14:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GB5CWEtRRQ/o56HacmvmZRAx5GJevROntZ+kKSL5iO8=;
        b=qqpYGGbA3EK1W5Gn54tb5U1zMHyUnfj31FQuJHudxn4854XyLZriOeJ1t97uCJHcP+
         L8xpEUipLf4aBaZVgV23BKnZbRab0PQpwBFfAoQun0I08i27RUDWgT2oOBj9FE6kuOl3
         F6pJA/FeI3vorwgxysyKO57pgmDIrauAORmoF6dToTufJK2RCTZPYOr+iXlzT6QIVrP8
         JZ/H4YLrAqSldVW0Ohf/F6CrcZ9xPzMltAszQdAJStD7Xw71/RzXAPXaxf2kZQnEPK4e
         aEs7EloXSLlQnESijedLzjrpiiUxLHs1UOJEGwCd98zaaAm00FdTzSzeW7hhIukifYtK
         6GaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GB5CWEtRRQ/o56HacmvmZRAx5GJevROntZ+kKSL5iO8=;
        b=gqD7vbmMD6QABouhdqiGzcHLdBFGqbfYhq8jYYaT1x2friU2R9t6D0u4EfwTBIr9Vz
         68iVVtEZO8uIeYB9zloExk4XA5/bmLX1xFKsOTswKunugPvGNHY7jDJTYjiZCkfp5KSM
         6zQKBDW41N1VgzIVlfvRyuRIbxxCXBxZRdjXrRfzp0IkTNgXZNUiYjlvql8AF8rrIqJ5
         lnCVGcbGnfUpzyRWxZKMVbUZX3sE2iEDe5vq9CiUko6BIYoMYaAmh3vr8Kng/KeNQz5F
         yNqLO5EkWWdY07kYY2X3nsAKDhuhpI4Ni1xh5r4Pl9WUtvw4yfErsU8tZ6RJv1e/BidO
         SR5Q==
X-Gm-Message-State: AO0yUKX6zButRkT2LkIAMsmM8+5PWbhmjRHhT0gpzzcycYKL7QPgCrs/
        5fO8Uj4XMSZ0koBa9DJUSy0=
X-Google-Smtp-Source: AK7set+7cVcdAirTc/5V4kqJRyZ7voG6Az/Vfp2AlmRKd++HwB6Y88P3QPkCxy51b3BLsEi58oqmdA==
X-Received: by 2002:a5d:574a:0:b0:2c5:582b:bad1 with SMTP id q10-20020a5d574a000000b002c5582bbad1mr6336974wrw.30.1676586163058;
        Thu, 16 Feb 2023 14:22:43 -0800 (PST)
Received: from localhost (94.197.187.145.threembb.co.uk. [94.197.187.145])
        by smtp.gmail.com with ESMTPSA id g9-20020adff3c9000000b002c54d8b89efsm2696211wrp.26.2023.02.16.14.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 14:22:42 -0800 (PST)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, lee@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/4] mfd: qcom-pm8008: Convert irq chip to config regs
Date:   Thu, 16 Feb 2023 22:22:12 +0000
Message-Id: <20230216222214.138671-3-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20230216222214.138671-1-aidanmacdonald.0x0@gmail.com>
References: <20230216222214.138671-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace type and virtual registers, which are both deprecated,
with config registers. This also simplifies the driver because
IRQ types are set in one place, the set_type_config() callback.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/mfd/qcom-pm8008.c | 50 +++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
index 39fd2a792e73..2b6763605cd7 100644
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
@@ -88,32 +89,36 @@ static struct regmap_irq pm8008_irqs[] = {
 	REGMAP_IRQ_REG(PM8008_IRQ_GPIO2,	PM8008_GPIO2,	BIT(0)),
 };
 
-static int pm8008_set_type_virt(unsigned int **virt_buf,
-				      unsigned int type, unsigned long hwirq,
-				      int reg)
+static int pm8008_set_type_config(unsigned int **buf, unsigned int type,
+				  const struct regmap_irq *irq_data, int idx)
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
 
@@ -121,21 +126,20 @@ static struct regmap_irq_chip pm8008_irq_chip = {
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
@@ -185,11 +189,7 @@ static int pm8008_probe_irq_peripherals(struct device *dev,
 	for (i = 0; i < ARRAY_SIZE(pm8008_irqs); i++) {
 		type = &pm8008_irqs[i].type;
 
-		type->type_reg_offset	  = pm8008_irqs[i].reg_offset;
-		type->type_rising_val	  = pm8008_irqs[i].mask;
-		type->type_falling_val	  = pm8008_irqs[i].mask;
-		type->type_level_high_val = 0;
-		type->type_level_low_val  = 0;
+		type->type_reg_offset = pm8008_irqs[i].reg_offset;
 
 		if (type->type_reg_offset == PM8008_MISC)
 			type->types_supported = IRQ_TYPE_EDGE_RISING;
-- 
2.39.2

