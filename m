Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1906FC46E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbjEILBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235041AbjEILBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:01:12 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5327EC0
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 04:01:10 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f315735514so202732765e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 04:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683630069; x=1686222069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0uAbWvf3AACRByzmoLUz2F9nlX4u08pmdHNU4kTBo9k=;
        b=mV94IM84UJPqR07NWUvB5lDmtfqqJ9tApO0Qbqvqxcaz0/dg9j25zoXj9893Yjw/Rp
         06PmIolFFhX31yleBr0Tfpv0lvMsbQ1kO2F16urVD5TR+3mTEPX0GFpFJAcX2Jsn9/KE
         b2roiofq7Yn3V6S6AekAKWtjQQiGchKBxEnZybfqRTAjTZtKbH9s4Y5iWMPC6VzAgcSd
         4D3EvZXBLSZAzfBgZd5vkTQnRMpU+7zC2r94PIX/3K4yDcf70O8aGga5leYfTPwgBI1N
         dWcmNhgljmEXhqgIyqAeSdj5u2gLHoDfMuiayaYdM1A5VwkKm82axGIC/B9lDXtr0vAs
         z+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683630069; x=1686222069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0uAbWvf3AACRByzmoLUz2F9nlX4u08pmdHNU4kTBo9k=;
        b=WuefYg6FTy5TtEkTJyhwlzQLEBWVSnYdca+2kh8YemI2UcOspCdaJP+wa8k7MoIbae
         BorI2kuO6VVnI+viIrDJPEapvwmlqb2H0hP9enMXYaCBuWXBsO6O/LWZz1cOayGv9Qt9
         q3zulnW5alzq7lFEzyvRytP3WrG3tWrLkwsDV6fBTpw8dJpToVJV72lrX/7IKeWJ4iOU
         PTlQFGF+zuZAtTeii0qbgqgYuNX3XiHUXeIeaYLVMEu0QhQJhZRfZzruoZwtciNZf6DM
         jij7IslZnAQHQnx393paxIN3RHzSnyva02RZILLH+rPPFiO4/K9mLa76E36XULSeL2az
         aRIg==
X-Gm-Message-State: AC+VfDwyfr4QvEORIrdOi28xK/7iUVhuj9MVB0GLphkqe4mTT4Sn8VO7
        WD9mJBdUV/lj0AfoVn7NrPOL5a0c+Iw=
X-Google-Smtp-Source: ACHHUZ6BT+ix0QQFOmFWo3aXYaZAAZexWg/VLJhffoTaUGOg6pcE+2DohN0x2V1P4FCFRrgVzYm+PQ==
X-Received: by 2002:a5d:4052:0:b0:2f7:cfe2:6507 with SMTP id w18-20020a5d4052000000b002f7cfe26507mr12104073wrp.20.1683630068922;
        Tue, 09 May 2023 04:01:08 -0700 (PDT)
Received: from localhost ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id y10-20020a7bcd8a000000b003f16fc33fbesm19322979wmj.17.2023.05.09.04.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 04:01:08 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/6] regmap-irq: Remove support for not_fixed_stride
Date:   Tue,  9 May 2023 12:00:58 +0100
Message-Id: <20230509110100.3980123-5-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20230509110100.3980123-1-aidanmacdonald.0x0@gmail.com>
References: <20230509110100.3980123-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No remaining users, use a custom .get_irq_reg() callback instead.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/base/regmap/regmap-irq.c | 43 +++-----------------------------
 include/linux/regmap.h           |  9 -------
 2 files changed, 3 insertions(+), 49 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index b27db5d0b8a7..41568927aa4c 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -329,15 +329,8 @@ static inline int read_sub_irq_data(struct regmap_irq_chip_data *data,
 			unsigned int offset = subreg->offset[i];
 			unsigned int index = offset / map->reg_stride;
 
-			if (chip->not_fixed_stride)
-				ret = regmap_read(map,
-						chip->status_base + offset,
-						&data->status_buf[b]);
-			else
-				ret = regmap_read(map,
-						chip->status_base + offset,
-						&data->status_buf[index]);
-
+			ret = regmap_read(map, chip->status_base + offset,
+					  &data->status_buf[index]);
 			if (ret)
 				break;
 		}
@@ -392,17 +385,7 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 		 * sake of simplicity. and add bulk reads only if needed
 		 */
 		for (i = 0; i < chip->num_main_regs; i++) {
-			/*
-			 * For not_fixed_stride, don't use ->get_irq_reg().
-			 * It would produce an incorrect result.
-			 */
-			if (data->chip->not_fixed_stride)
-				reg = chip->main_status +
-					i * map->reg_stride * data->irq_reg_stride;
-			else
-				reg = data->get_irq_reg(data,
-							chip->main_status, i);
-
+			reg = data->get_irq_reg(data, chip->main_status, i);
 			ret = regmap_read(map, reg, &data->main_status_buf[i]);
 			if (ret) {
 				dev_err(map->dev,
@@ -568,20 +551,8 @@ static const struct irq_domain_ops regmap_domain_ops = {
 unsigned int regmap_irq_get_irq_reg_linear(struct regmap_irq_chip_data *data,
 					   unsigned int base, int index)
 {
-	const struct regmap_irq_chip *chip = data->chip;
 	struct regmap *map = data->map;
 
-	/*
-	 * FIXME: This is for backward compatibility and should be removed
-	 * when not_fixed_stride is dropped (it's only used by qcom-pm8008).
-	 */
-	if (chip->not_fixed_stride && chip->sub_reg_offsets) {
-		struct regmap_irq_sub_irq_map *subreg;
-
-		subreg = &chip->sub_reg_offsets[0];
-		return base + subreg->offset[0];
-	}
-
 	return base + index * map->reg_stride * data->irq_reg_stride;
 }
 EXPORT_SYMBOL_GPL(regmap_irq_get_irq_reg_linear);
@@ -685,14 +656,6 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 			return -EINVAL;
 	}
 
-	if (chip->not_fixed_stride) {
-		dev_warn(map->dev, "not_fixed_stride is deprecated; use ->get_irq_reg() instead");
-
-		for (i = 0; i < chip->num_regs; i++)
-			if (chip->sub_reg_offsets[i].num_regs != 1)
-				return -EINVAL;
-	}
-
 	if (irq_base) {
 		irq_base = irq_alloc_descs(irq_base, 0, chip->num_irqs, 0);
 		if (irq_base < 0) {
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index af93b369a19f..cd98df7abb6f 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1528,9 +1528,6 @@ struct regmap_irq_chip_data;
  *		     status_base. Should contain num_regs arrays.
  *		     Can be provided for chips with more complex mapping than
  *		     1.st bit to 1.st sub-reg, 2.nd bit to 2.nd sub-reg, ...
- *		     When used with not_fixed_stride, each one-element array
- *		     member contains offset calculated as address from each
- *		     peripheral to first peripheral.
  * @num_main_regs: Number of 'main status' irq registers for chips which have
  *		   main_status set.
  *
@@ -1567,11 +1564,6 @@ struct regmap_irq_chip_data;
  *                   registers before unmasking interrupts to clear any bits
  *                   set when they were masked.
  * @runtime_pm:  Hold a runtime PM lock on the device when accessing it.
- * @not_fixed_stride: Used when chip peripherals are not laid out with fixed
- *		      stride. Must be used with sub_reg_offsets containing the
- *		      offsets to each peripheral. Deprecated; the same thing
- *		      can be accomplished with a @get_irq_reg callback, without
- *		      the need for a @sub_reg_offsets table.
  * @no_status: No status register: all interrupts assumed generated by device.
  *
  * @num_regs:    Number of registers in each control bank.
@@ -1628,7 +1620,6 @@ struct regmap_irq_chip {
 	unsigned int type_in_mask:1;
 	unsigned int clear_on_unmask:1;
 	unsigned int runtime_pm:1;
-	unsigned int not_fixed_stride:1;
 	unsigned int no_status:1;
 
 	int num_regs;
-- 
2.39.2

