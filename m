Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297A66FEE6E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237334AbjEKJOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237288AbjEKJOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:14:00 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182F526A2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:13:58 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-30789a4c537so3855990f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683796436; x=1686388436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEHyHwezs0VBg1/gOR5LcksWON8haOfKNBrPIcoTjRs=;
        b=MVwkqN5rTvWEnYOqX6VAcY6Sc+22mTmiMXYS6O05/T2rlI9T1hmz8chDxZYoKZwU30
         uZEDFORU4tBo89Qvrihy0lILEWp8ShF7aeKQP+vP2VGWug89krsNh34Kznj/iW1r5j6Q
         gCBGFdNDxdgvlvVxSKkBwmmTZD0sD0an1qtAL98ANKERNciGDiqwHwOPvFBsdp1WrZIx
         nTcjicmrO8VxaEsZso42lVZA9OAC/Tecr0mEZ2gWb5Q+okDyEavUvH3M3aybO/8vnWHA
         DtOf+Q4T/JKbTb6Br1/1o/kRnWaJMPFM8ddE87Ygebdc6U5gxIwIw/JwsJs2EUz+94Mf
         vzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683796436; x=1686388436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WEHyHwezs0VBg1/gOR5LcksWON8haOfKNBrPIcoTjRs=;
        b=Wq8sO6kwBpCx5E6wg3qQDbaUHh0pNlQNxvY2A4NGaeQCl2h02k7rnVruJGBmCKj10H
         hoYU9KM0kkzNaBcgnGyPZRRMO3zcS52kzz4OeKv2d73HUSXw18Y8uln1zZ9r74Br/3ge
         S36EwrrG5bd5Y5XbV+IxELrfTauUzdNH/iQ0Q05t1YUwu0i07rm4wLib+GeM936oPwsQ
         IrEUm/Hb2OtXb+2uneaMx0bQtnjOhRi2e8FbKLG7u98WDBN+UdaUXQQCDEkGIMoIidyA
         Z/xrQs5otfdbpLvQjYDEDQxXtMEWBzWncTapND6T/YHFKlTUhYM1ZsBxkASPZL75UR7L
         p1tg==
X-Gm-Message-State: AC+VfDzHBSPz0uT705bycpQdYmB0V6S3eNRqeptsjDJYeUA31NZ6cd6h
        pwxWaSKsmJQ9i+TMFS8uiY4=
X-Google-Smtp-Source: ACHHUZ42GuEdASwxrkmPP2jT2zrPJemUiYmVoDgLqv7g4ht8IdkqsRQqXfnPG8VHK6QQDtYRZJ1fyQ==
X-Received: by 2002:a5d:5221:0:b0:2fb:703d:1915 with SMTP id i1-20020a5d5221000000b002fb703d1915mr13463224wra.43.1683796436440;
        Thu, 11 May 2023 02:13:56 -0700 (PDT)
Received: from localhost ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id o1-20020a5d58c1000000b00306c5900c10sm19627786wrf.9.2023.05.11.02.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 02:13:56 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] regmap-irq: Remove support for not_fixed_stride
Date:   Thu, 11 May 2023 10:13:40 +0100
Message-Id: <20230511091342.26604-3-aidanmacdonald.0x0@gmail.com>
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

No remaining users, use a custom .get_irq_reg() callback instead.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/base/regmap/regmap-irq.c | 43 +++-----------------------------
 include/linux/regmap.h           |  9 -------
 2 files changed, 3 insertions(+), 49 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index c11295e3fe5e..7cb457af2332 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -328,15 +328,8 @@ static inline int read_sub_irq_data(struct regmap_irq_chip_data *data,
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
@@ -391,17 +384,7 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
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
@@ -567,20 +550,8 @@ static const struct irq_domain_ops regmap_domain_ops = {
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
@@ -684,14 +655,6 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
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
index 0b4b9eca480d..8fc0b3ebce44 100644
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

