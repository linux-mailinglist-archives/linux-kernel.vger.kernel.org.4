Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA37B6FC46F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbjEILBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbjEILBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:01:12 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A615044AE
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 04:01:09 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3078a3f3b5fso3054708f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 04:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683630068; x=1686222068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OS9BlFIA6nwN/45cHgdcwR3RSaSSk87cDI6gOIh0qTY=;
        b=C7FLNpAtVqp//4bRfZPuVsiHPvu73FhzYJCJfRO8PrHlQCq+WG2dgIhQKHLv19WCMr
         UUX3CAsYJ5q8zWcFMTyBsdiWbrGR1P6qQToteeuFKbjRGI4bNYCHJKtNj/1pjDjz5pBc
         VYYOfZ2gxN5eBoixBK5d9LmDrE8PY8Rgc+aTHqS89RJZiAPMBtTdhsnsZEkMP2cH9Zw1
         nGc8W5qajAEUWIUvzDZHLoJP6lyDaam1CvYebb6IsNiswM1OkP7WcdwdLXU1VOKlVLyz
         /2yCWhdbyFD0N7M6GBDK/WTW/KbL7ejSHafZ6uB5I3iTXJqdAvo17ri99OEyvVXTbAkK
         JGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683630068; x=1686222068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OS9BlFIA6nwN/45cHgdcwR3RSaSSk87cDI6gOIh0qTY=;
        b=DlZfSHnSsk1sDlzWCH+6gLPqYMmENleQYPUaCGE62anfvhAToKTx4P4yjUTgn2hWKc
         TJOOfJKoXIK5APz7PsThxG/qAgGK/D05M1JkF/5opn/YIFHNZMhs2V7Wtxcwi01Ej6Pz
         creJISUh1G1xaDuDZPOjOc2HRCA4O6BxrHx7TdEj0uRhx6Dvs8DzaJQf9w1E6RM+mkqY
         0EXcO8pjastaSzOOs7ig/W0cYCTHtOuVb86jQIDJCgiy8aTvMlQ5crF6d9bDUTEWleCb
         Yaf3RDkUnlBFaa5BHhz+RXPCEwub1zspUMJq4FO1b8JValnEkekrgtpJ6gDlJJ2HhoCx
         S+WQ==
X-Gm-Message-State: AC+VfDwxjK6I+UL2f/CVNw7QrO5tNbq/FktlLgmOl6JbZvkiFp7LWgq4
        jwF5tjjvP3TqNUMzjLSWvOc=
X-Google-Smtp-Source: ACHHUZ5vCLFm9WNFefNSMi/mFLlARKxb/GCuGNgnuiBW1VO6YJKFvf3HxjkFLs2ljxJzfS9IFiPBGA==
X-Received: by 2002:a5d:63c8:0:b0:306:2b56:d268 with SMTP id c8-20020a5d63c8000000b003062b56d268mr8812124wrw.15.1683630068011;
        Tue, 09 May 2023 04:01:08 -0700 (PDT)
Received: from localhost ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id a6-20020a056000050600b003079c402762sm4548990wrf.19.2023.05.09.04.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 04:01:07 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/6] regmap-irq: Remove type registers
Date:   Tue,  9 May 2023 12:00:57 +0100
Message-Id: <20230509110100.3980123-4-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20230509110100.3980123-1-aidanmacdonald.0x0@gmail.com>
References: <20230509110100.3980123-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No remaining users, these have been replaced by config registers.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/base/regmap/regmap-irq.c | 82 ++++----------------------------
 include/linux/regmap.h           |  7 ---
 2 files changed, 8 insertions(+), 81 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 615b1ced2a5e..b27db5d0b8a7 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -182,20 +182,6 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 		}
 	}
 
-	/* Don't update the type bits if we're using mask bits for irq type. */
-	if (!d->chip->type_in_mask) {
-		for (i = 0; i < d->chip->num_type_reg; i++) {
-			if (!d->type_buf_def[i])
-				continue;
-			reg = d->get_irq_reg(d, d->chip->type_base, i);
-			ret = regmap_update_bits(d->map, reg,
-						 d->type_buf_def[i], d->type_buf[i]);
-			if (ret != 0)
-				dev_err(d->map->dev, "Failed to sync type in %x\n",
-					reg);
-		}
-	}
-
 	for (i = 0; i < d->chip->num_config_bases; i++) {
 		for (j = 0; j < d->chip->num_config_regs; j++) {
 			reg = d->get_irq_reg(d, d->chip->config_base[i], j);
@@ -274,36 +260,11 @@ static int regmap_irq_set_type(struct irq_data *data, unsigned int type)
 
 	reg = t->type_reg_offset / map->reg_stride;
 
-	if (t->type_reg_mask)
-		d->type_buf[reg] &= ~t->type_reg_mask;
-	else
-		d->type_buf[reg] &= ~(t->type_falling_val |
-				      t->type_rising_val |
-				      t->type_level_low_val |
-				      t->type_level_high_val);
-	switch (type) {
-	case IRQ_TYPE_EDGE_FALLING:
-		d->type_buf[reg] |= t->type_falling_val;
-		break;
-
-	case IRQ_TYPE_EDGE_RISING:
-		d->type_buf[reg] |= t->type_rising_val;
-		break;
-
-	case IRQ_TYPE_EDGE_BOTH:
-		d->type_buf[reg] |= (t->type_falling_val |
-					t->type_rising_val);
-		break;
-
-	case IRQ_TYPE_LEVEL_HIGH:
-		d->type_buf[reg] |= t->type_level_high_val;
-		break;
-
-	case IRQ_TYPE_LEVEL_LOW:
-		d->type_buf[reg] |= t->type_level_low_val;
-		break;
-	default:
-		return -EINVAL;
+	if (d->chip->type_in_mask) {
+		ret = regmap_irq_set_type_config_simple(&d->type_buf, type,
+							irq_data, reg, d->chip->irq_drv_data);
+		if (ret)
+			return ret;
 	}
 
 	if (d->chip->set_type_config) {
@@ -708,8 +669,6 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	struct regmap_irq_chip_data *d;
 	int i;
 	int ret = -ENOMEM;
-	int num_type_reg;
-	int num_regs;
 	u32 reg;
 
 	if (chip->num_regs <= 0)
@@ -734,9 +693,6 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 				return -EINVAL;
 	}
 
-	if (chip->num_type_reg)
-		dev_warn(map->dev, "type registers are deprecated; use config registers instead");
-
 	if (irq_base) {
 		irq_base = irq_alloc_descs(irq_base, 0, chip->num_irqs, 0);
 		if (irq_base < 0) {
@@ -781,21 +737,13 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 			goto err_alloc;
 	}
 
-	/*
-	 * Use num_config_regs if defined, otherwise fall back to num_type_reg
-	 * to maintain backward compatibility.
-	 */
-	num_type_reg = chip->num_config_regs ? chip->num_config_regs
-			: chip->num_type_reg;
-	num_regs = chip->type_in_mask ? chip->num_regs : num_type_reg;
-	if (num_regs) {
-		d->type_buf_def = kcalloc(num_regs,
+	if (chip->type_in_mask) {
+		d->type_buf_def = kcalloc(chip->num_regs,
 					  sizeof(*d->type_buf_def), GFP_KERNEL);
 		if (!d->type_buf_def)
 			goto err_alloc;
 
-		d->type_buf = kcalloc(num_regs, sizeof(*d->type_buf),
-				      GFP_KERNEL);
+		d->type_buf = kcalloc(chip->num_regs, sizeof(*d->type_buf), GFP_KERNEL);
 		if (!d->type_buf)
 			goto err_alloc;
 	}
@@ -971,20 +919,6 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 		}
 	}
 
-	if (chip->num_type_reg && !chip->type_in_mask) {
-		for (i = 0; i < chip->num_type_reg; ++i) {
-			reg = d->get_irq_reg(d, d->chip->type_base, i);
-
-			ret = regmap_read(map, reg, &d->type_buf_def[i]);
-
-			if (ret) {
-				dev_err(map->dev, "Failed to get type defaults at 0x%x: %d\n",
-					reg, ret);
-				goto err_alloc;
-			}
-		}
-	}
-
 	if (irq_base)
 		d->domain = irq_domain_create_legacy(fwnode, chip->num_irqs,
 						     irq_base, 0,
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index ec3c241542c9..af93b369a19f 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1542,8 +1542,6 @@ struct regmap_irq_chip_data;
  * @ack_base:    Base ack address. If zero then the chip is clear on read.
  *               Using zero value is possible with @use_ack bit.
  * @wake_base:   Base address for wake enables.  If zero unsupported.
- * @type_base:   Base address for irq type.  If zero unsupported.  Deprecated,
- *		 use @config_base instead.
  * @config_base: Base address for IRQ type config regs. If null unsupported.
  * @irq_reg_stride:  Stride to use for chips where registers are not contiguous.
  * @init_ack_masked: Ack all masked interrupts once during initalization.
@@ -1581,9 +1579,6 @@ struct regmap_irq_chip_data;
  * @irqs:        Descriptors for individual IRQs.  Interrupt numbers are
  *               assigned based on the index in the array of the interrupt.
  * @num_irqs:    Number of descriptors.
- *
- * @num_type_reg:    Number of type registers. Deprecated, use config registers
- *		     instead.
  * @num_config_bases:	Number of config base registers.
  * @num_config_regs:	Number of config registers for each config base register.
  *
@@ -1621,7 +1616,6 @@ struct regmap_irq_chip {
 	unsigned int unmask_base;
 	unsigned int ack_base;
 	unsigned int wake_base;
-	unsigned int type_base;
 	const unsigned int *config_base;
 	unsigned int irq_reg_stride;
 	unsigned int init_ack_masked:1;
@@ -1642,7 +1636,6 @@ struct regmap_irq_chip {
 	const struct regmap_irq *irqs;
 	int num_irqs;
 
-	int num_type_reg;
 	int num_config_bases;
 	int num_config_regs;
 
-- 
2.39.2

