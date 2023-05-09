Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2BF6FC46C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbjEILBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235136AbjEILBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:01:11 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C715E559A
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 04:01:08 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-307664010fdso5075488f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 04:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683630067; x=1686222067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3P/TGPitP4pa9Y8m+ml3Gl1SxZ9DXENwMXnQAgr1gc=;
        b=Bz1LP0QrV+xILYJSV6rmz9bO6jF56CtpDoaWfxMk4k/De+rmw8rzMBcH3RgkD7P+nX
         YFpPkedG8ha9WVYxwVWepMFTRQ2CfVXB1slj0bI6ArmfYjSovJSLZJs+Uq3QdSasUcby
         0qSgwstY6BGjZ/GbcNx6si4DaL1VJWGVa5Y5P61h2qmks2EDMkPyddtd8aAVYLAKWOw/
         oXWzELil+vCG2cBZIFr1kwE09OG29GJzGIN3dXygk2s/o/i84PnoG8APX9RriZdNJKO1
         EzUHdTZAqMpcaouIC1Cq77Gg7GziVY4JJbVkz6MU/efPSrjBggikAKg8F9E/KFlT6Kx+
         0nQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683630067; x=1686222067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V3P/TGPitP4pa9Y8m+ml3Gl1SxZ9DXENwMXnQAgr1gc=;
        b=Bp7c3Eb/M9r1+SC1ntKUMdKZ/8YyU4WYn0dTLsbia/X+4TFgrTXUnTlmXo3SULfRTs
         NazX5seA5aq5Cfpe7MPYRT6tIa/+qR579NHW9cGYFEz+oI1JmpRuShR/Wvndy6NdX+8n
         9T+D3HmJiJu/QdfsbvX4OgM7gjPWCW9aNeDcMfGOX8HV5Sq57CRz0UoURPKzlzhuUzs3
         sboxOrNAOPsr+o+prCenfV729DtzJxBGVLu6xEiqm1F2rWyUUu5UJ+0LyxGeyPwUnNpp
         llB1TaqlTOmtL+idqHjlBFTQQZVTPTgBbdZP1p0yZxb/IWpU4qMNNibgrNFd9iTenHVO
         yHnQ==
X-Gm-Message-State: AC+VfDzkcg+q5LRcpu3ViKdBaFV6nfYCmcTwLIIXU1ICVSuptDlv0RqE
        JO/dmiB//dHhusMSZ6wD5VI=
X-Google-Smtp-Source: ACHHUZ6116hob5BjFtmzPbyI8fwy24ULZJo9MAsuZ1Bmm6xTBaaPlyqta2B2uwD5eODiIrBow898FQ==
X-Received: by 2002:a5d:6606:0:b0:2ef:b123:46d9 with SMTP id n6-20020a5d6606000000b002efb12346d9mr9627188wru.3.1683630066984;
        Tue, 09 May 2023 04:01:06 -0700 (PDT)
Received: from localhost ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id a24-20020a5d4578000000b003063938bf7bsm14097181wrc.86.2023.05.09.04.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 04:01:06 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/6] regmap-irq: Remove virtual registers
Date:   Tue,  9 May 2023 12:00:56 +0100
Message-Id: <20230509110100.3980123-3-aidanmacdonald.0x0@gmail.com>
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

No remaining users, and it's been replaced by config registers.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/base/regmap/regmap-irq.c | 48 --------------------------------
 include/linux/regmap.h           | 12 --------
 2 files changed, 60 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index b99bb2369fff..615b1ced2a5e 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -41,7 +41,6 @@ struct regmap_irq_chip_data {
 	unsigned int *wake_buf;
 	unsigned int *type_buf;
 	unsigned int *type_buf_def;
-	unsigned int **virt_buf;
 	unsigned int **config_buf;
 
 	unsigned int irq_reg_stride;
@@ -197,20 +196,6 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 		}
 	}
 
-	if (d->chip->num_virt_regs) {
-		for (i = 0; i < d->chip->num_virt_regs; i++) {
-			for (j = 0; j < d->chip->num_regs; j++) {
-				reg = d->get_irq_reg(d, d->chip->virt_reg_base[i],
-						     j);
-				ret = regmap_write(map, reg, d->virt_buf[i][j]);
-				if (ret != 0)
-					dev_err(d->map->dev,
-						"Failed to write virt 0x%x: %d\n",
-						reg, ret);
-			}
-		}
-	}
-
 	for (i = 0; i < d->chip->num_config_bases; i++) {
 		for (j = 0; j < d->chip->num_config_regs; j++) {
 			reg = d->get_irq_reg(d, d->chip->config_base[i], j);
@@ -321,13 +306,6 @@ static int regmap_irq_set_type(struct irq_data *data, unsigned int type)
 		return -EINVAL;
 	}
 
-	if (d->chip->set_type_virt) {
-		ret = d->chip->set_type_virt(d->virt_buf, type, data->hwirq,
-					     reg);
-		if (ret)
-			return ret;
-	}
-
 	if (d->chip->set_type_config) {
 		ret = d->chip->set_type_config(d->config_buf, type, irq_data,
 					       reg, d->chip->irq_drv_data);
@@ -759,9 +737,6 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	if (chip->num_type_reg)
 		dev_warn(map->dev, "type registers are deprecated; use config registers instead");
 
-	if (chip->num_virt_regs || chip->virt_reg_base || chip->set_type_virt)
-		dev_warn(map->dev, "virtual registers are deprecated; use config registers instead");
-
 	if (irq_base) {
 		irq_base = irq_alloc_descs(irq_base, 0, chip->num_irqs, 0);
 		if (irq_base < 0) {
@@ -825,24 +800,6 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 			goto err_alloc;
 	}
 
-	if (chip->num_virt_regs) {
-		/*
-		 * Create virt_buf[chip->num_extra_config_regs][chip->num_regs]
-		 */
-		d->virt_buf = kcalloc(chip->num_virt_regs, sizeof(*d->virt_buf),
-				      GFP_KERNEL);
-		if (!d->virt_buf)
-			goto err_alloc;
-
-		for (i = 0; i < chip->num_virt_regs; i++) {
-			d->virt_buf[i] = kcalloc(chip->num_regs,
-						 sizeof(**d->virt_buf),
-						 GFP_KERNEL);
-			if (!d->virt_buf[i])
-				goto err_alloc;
-		}
-	}
-
 	if (chip->num_config_bases && chip->num_config_regs) {
 		/*
 		 * Create config_buf[num_config_bases][num_config_regs]
@@ -1064,11 +1021,6 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	kfree(d->mask_buf);
 	kfree(d->status_buf);
 	kfree(d->status_reg_buf);
-	if (d->virt_buf) {
-		for (i = 0; i < chip->num_virt_regs; i++)
-			kfree(d->virt_buf[i]);
-		kfree(d->virt_buf);
-	}
 	if (d->config_buf) {
 		for (i = 0; i < chip->num_config_bases; i++)
 			kfree(d->config_buf[i]);
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 45fdb6e93617..ec3c241542c9 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1544,8 +1544,6 @@ struct regmap_irq_chip_data;
  * @wake_base:   Base address for wake enables.  If zero unsupported.
  * @type_base:   Base address for irq type.  If zero unsupported.  Deprecated,
  *		 use @config_base instead.
- * @virt_reg_base:   Base addresses for extra config regs. Deprecated, use
- *		     @config_base instead.
  * @config_base: Base address for IRQ type config regs. If null unsupported.
  * @irq_reg_stride:  Stride to use for chips where registers are not contiguous.
  * @init_ack_masked: Ack all masked interrupts once during initalization.
@@ -1586,9 +1584,6 @@ struct regmap_irq_chip_data;
  *
  * @num_type_reg:    Number of type registers. Deprecated, use config registers
  *		     instead.
- * @num_virt_regs:   Number of non-standard irq configuration registers.
- *		     If zero unsupported. Deprecated, use config registers
- *		     instead.
  * @num_config_bases:	Number of config base registers.
  * @num_config_regs:	Number of config registers for each config base register.
  *
@@ -1598,9 +1593,6 @@ struct regmap_irq_chip_data;
  *		     after handling the interrupts in regmap_irq_handler().
  * @handle_mask_sync: Callback used to handle IRQ mask syncs. The index will be
  *		      in the range [0, num_regs)
- * @set_type_virt:   Driver specific callback to extend regmap_irq_set_type()
- *		     and configure virt regs. Deprecated, use @set_type_config
- *		     callback and config registers instead.
  * @set_type_config: Callback used for configuring irq types.
  * @get_irq_reg: Callback for mapping (base register, index) pairs to register
  *		 addresses. The base register will be one of @status_base,
@@ -1630,7 +1622,6 @@ struct regmap_irq_chip {
 	unsigned int ack_base;
 	unsigned int wake_base;
 	unsigned int type_base;
-	unsigned int *virt_reg_base;
 	const unsigned int *config_base;
 	unsigned int irq_reg_stride;
 	unsigned int init_ack_masked:1;
@@ -1652,7 +1643,6 @@ struct regmap_irq_chip {
 	int num_irqs;
 
 	int num_type_reg;
-	int num_virt_regs;
 	int num_config_bases;
 	int num_config_regs;
 
@@ -1661,8 +1651,6 @@ struct regmap_irq_chip {
 	int (*handle_mask_sync)(struct regmap *map, int index,
 				unsigned int mask_buf_def,
 				unsigned int mask_buf, void *irq_drv_data);
-	int (*set_type_virt)(unsigned int **buf, unsigned int type,
-			     unsigned long hwirq, int reg);
 	int (*set_type_config)(unsigned int **buf, unsigned int type,
 			       const struct regmap_irq *irq_data, int idx,
 			       void *irq_drv_data);
-- 
2.39.2

