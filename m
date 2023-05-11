Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79B66FEE6D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237286AbjEKJOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237273AbjEKJN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:13:58 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E757D84
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:13:57 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3078aa0b152so3867202f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683796435; x=1686388435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xn6oPNO0+H8urawE2tn6HpuoupILu8RQiDcmPsO/63U=;
        b=XL8QGnZaZhkXvBwsKRHtFtHThuYQXI7kuR/G7+tqJxyxJu5rpSa11g5fLpSU8AfGYz
         dXkwox43sU3k3upv5P4Ku1Di+8Z4DflbV89K6FOumV6eNV5c76/YwKJgC8utZ/uGQy3Y
         z7cFM4QastKWeFaw6XxX+kWFzXkqanvOkwdfhO/DGqjDvu8IvPNPCgK50AteygSntUKy
         Bzjs7CeXGHrwm2U01RKIQvx/hEzfNfKLq8dBxhMw7/7ScrGZimuiEA+wJsT82nEKQjmp
         IUjp48NakuUTZJCPke+hFZwHZ01+1joETklMA5eROvoPA3pKSCAIMS05lN1sOBvgMJdQ
         ezjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683796435; x=1686388435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xn6oPNO0+H8urawE2tn6HpuoupILu8RQiDcmPsO/63U=;
        b=K92heaxs0OS60/IsQo/fRfxvul7J6cI/7/mU3CGJW21roP5fK6St2D4FAxQnxIXPme
         BwLUIcEn0OJFNQwGCmvUsIF2OB9PlZ+BcgrFFNrGCQ4kUQH6WKXu7qIBTr0v5dK6fo95
         OuNnGqyG+9Bs6wF3Xjr7QdBCE8oBtAGLUYu0UicgLwaZ6cmCTh+GzqrY6GYdiEO6P+1+
         jG2XfHey1wkbWXmk2wuhkmf3skgC+GQPD+s5YjTbQU5qCO4znXdZM60q1C+wAhfeY/cT
         TXTJ9BUS7pvdwuoVkW8tAFRaw1LSuiaCz8cZVj24k6FULuWOCNmHGWLWtB5Z2teQI47H
         czsQ==
X-Gm-Message-State: AC+VfDza0eXluAMLUlTt9tfA3G+jyDPm6QUpn9AeXBgVpXiLnUEHgtjJ
        CvvQvh7mYJ+i8n1n+0fb70A=
X-Google-Smtp-Source: ACHHUZ4EOk0a4u49zmpjNwb/I309pMzgaDK0i3f+vGhBYN1lV+Qp4A2er8DW7/6i4U/vkgF9wJSvPA==
X-Received: by 2002:adf:fac1:0:b0:2d8:47c7:7b52 with SMTP id a1-20020adffac1000000b002d847c77b52mr14441353wrs.9.1683796435402;
        Thu, 11 May 2023 02:13:55 -0700 (PDT)
Received: from localhost ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id p6-20020adfe606000000b002e5f6f8fc4fsm19882730wrm.100.2023.05.11.02.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 02:13:55 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] regmap-irq: Remove type registers
Date:   Thu, 11 May 2023 10:13:39 +0100
Message-Id: <20230511091342.26604-2-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20230511091342.26604-1-aidanmacdonald.0x0@gmail.com>
References: <20230511091342.26604-1-aidanmacdonald.0x0@gmail.com>
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
index 48bff842cc31..c11295e3fe5e 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -181,20 +181,6 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
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
@@ -273,36 +259,11 @@ static int regmap_irq_set_type(struct irq_data *data, unsigned int type)
 
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
@@ -707,8 +668,6 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	struct regmap_irq_chip_data *d;
 	int i;
 	int ret = -ENOMEM;
-	int num_type_reg;
-	int num_regs;
 	u32 reg;
 
 	if (chip->num_regs <= 0)
@@ -733,9 +692,6 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 				return -EINVAL;
 	}
 
-	if (chip->num_type_reg)
-		dev_warn(map->dev, "type registers are deprecated; use config registers instead");
-
 	if (irq_base) {
 		irq_base = irq_alloc_descs(irq_base, 0, chip->num_irqs, 0);
 		if (irq_base < 0) {
@@ -780,21 +736,13 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
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
@@ -970,20 +918,6 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
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
index 2ad0e3d77b95..0b4b9eca480d 100644
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

