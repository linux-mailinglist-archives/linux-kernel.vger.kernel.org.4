Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7079D6FC472
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbjEILBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbjEILBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:01:13 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6E84EDF
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 04:01:12 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3064099f9b6so3592384f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 04:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683630071; x=1686222071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWtpHNVGRxUuy5j/lWXuSPQK5dAiQdK/8BxIYoaxpIo=;
        b=JhHEO9CoNBV87uvNGuvCx7wV0e0ZgRNMfk5uwNaDztdufMtbUMO/4KbPoY5ySSMPAv
         MeFD49Kvb56QStAKqRaqzmgYMXYSiTgYxcu9W4m7vSn+XT2DsX+FOTs9aKiQxXe5iYl0
         I0NkjXd4U9hUAPUEo9reRqRhTRvZ697GfUEGU0pD8jkmzAFyHpf0GD7exJvr2pT3Dlyt
         1V+d7V4lHrxQppN0D7bhZveqq2Sk34Vac2XFeLjYN+q32g6YHyqFFT20gi4dKHg1ezdg
         wXJCQz3My0CpSj9tRfEzvTuQC4y20Mc8ALlzKI7ftnn9VIHIdFq8i/HlnE/kappk8h2s
         7PZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683630071; x=1686222071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uWtpHNVGRxUuy5j/lWXuSPQK5dAiQdK/8BxIYoaxpIo=;
        b=OCKJbo4Qjcrrxt+6DOQ7vP3wR3ZqixwWyWAKpeW2qwrqGQjpttWsqwmekA7Od1zoOE
         TA98knc1q8HYr3BcOXrDYzOxqZ9JZZNW4J6H9b/PZ8reU0UWUQ4ncoJ4a9aY57siVeXH
         Z1QWbKveIAKIOKHlLovZLDVFuSDxeMj7aladlhDOc8KcvYJwGywv2d8ynDhwHP+KlMly
         wZZNBL3byfkXTBwgWCcoUIQCGUTlDRWSuamfw2G6eqC9Tx9eAQgxxhTouwQtsSNmE3e8
         FGgHLFhwBi7CP/RQ6CE4ME3SXS9XOtwV4L+dJvn14I7X4nPkqrkjl1XJgcYnp8jBgcXF
         YB/A==
X-Gm-Message-State: AC+VfDz+bekWSYAOJVyVu8Yrp9oMH17mVk7azRZij6/V31iWme2lnRTy
        3Y7bEI3Ne4Pb4CI7rtHIcKuKWXJ8UDU=
X-Google-Smtp-Source: ACHHUZ5irkUMTnNH950e0FgRWj1JMKYsT+v9l/SCpweMhm456qBDcwJI3l1iQ1LGZMP+MEPTkhBHHw==
X-Received: by 2002:a5d:68c1:0:b0:306:28fa:16a7 with SMTP id p1-20020a5d68c1000000b0030628fa16a7mr9481321wrw.43.1683630070842;
        Tue, 09 May 2023 04:01:10 -0700 (PDT)
Received: from localhost ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id c15-20020adfed8f000000b003047f7a7ad1sm14093760wro.71.2023.05.09.04.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 04:01:10 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 6/6] regmap-irq: Drop backward compatibility for inverted mask/unmask
Date:   Tue,  9 May 2023 12:01:00 +0100
Message-Id: <20230509110100.3980123-7-aidanmacdonald.0x0@gmail.com>
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

All users must now specify .mask_unmask_non_inverted = true to
ensure they are using the expected semantics: 1s disable IRQs
in the mask registers, and enable IRQs in the unmask registers.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/base/regmap/regmap-irq.c | 44 ++++++++------------------------
 1 file changed, 11 insertions(+), 33 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 898d1c6c5b75..87dfcec9da5a 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -30,9 +30,6 @@ struct regmap_irq_chip_data {
 	int irq;
 	int wake_count;
 
-	unsigned int mask_base;
-	unsigned int unmask_base;
-
 	void *status_reg_buf;
 	unsigned int *main_status_buf;
 	unsigned int *status_buf;
@@ -119,8 +116,8 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 						  d->mask_buf[i],
 						  d->chip->irq_drv_data);
 
-		if (d->mask_base && !d->chip->handle_mask_sync) {
-			reg = d->get_irq_reg(d, d->mask_base, i);
+		if (d->chip->mask_base && !d->chip->handle_mask_sync) {
+			reg = d->get_irq_reg(d, d->chip->mask_base, i);
 			ret = regmap_update_bits(d->map, reg,
 						 d->mask_buf_def[i],
 						 d->mask_buf[i]);
@@ -128,8 +125,8 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 				dev_err(d->map->dev, "Failed to sync masks in %x\n", reg);
 		}
 
-		if (d->unmask_base && !d->chip->handle_mask_sync) {
-			reg = d->get_irq_reg(d, d->unmask_base, i);
+		if (d->chip->unmask_base && !d->chip->handle_mask_sync) {
+			reg = d->get_irq_reg(d, d->chip->unmask_base, i);
 			ret = regmap_update_bits(d->map, reg,
 					d->mask_buf_def[i], ~d->mask_buf[i]);
 			if (ret)
@@ -646,6 +643,9 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	if (chip->clear_on_unmask && (chip->ack_base || chip->use_ack))
 		return -EINVAL;
 
+	if (chip->mask_base && chip->unmask_base && !chip->mask_unmask_non_inverted)
+		return -EINVAL;
+
 	for (i = 0; i < chip->num_irqs; i++) {
 		if (chip->irqs[i].reg_offset % map->reg_stride)
 			return -EINVAL;
@@ -734,28 +734,6 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	d->chip = chip;
 	d->irq_base = irq_base;
 
-	if (chip->mask_base && chip->unmask_base &&
-	    !chip->mask_unmask_non_inverted) {
-		/*
-		 * Chips that specify both mask_base and unmask_base used to
-		 * get inverted mask behavior by default, with no way to ask
-		 * for the normal, non-inverted behavior. This "inverted by
-		 * default" behavior is deprecated, but we have to support it
-		 * until existing drivers have been fixed.
-		 *
-		 * Existing drivers should be updated by swapping mask_base
-		 * and unmask_base and setting mask_unmask_non_inverted=true.
-		 * New drivers should always set the flag.
-		 */
-		dev_warn(map->dev, "mask_base and unmask_base are inverted, please fix it");
-
-		d->mask_base = chip->unmask_base;
-		d->unmask_base = chip->mask_base;
-	} else {
-		d->mask_base = chip->mask_base;
-		d->unmask_base = chip->unmask_base;
-	}
-
 	if (chip->irq_reg_stride)
 		d->irq_reg_stride = chip->irq_reg_stride;
 	else
@@ -793,8 +771,8 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 				goto err_alloc;
 		}
 
-		if (d->mask_base && !chip->handle_mask_sync) {
-			reg = d->get_irq_reg(d, d->mask_base, i);
+		if (chip->mask_base && !chip->handle_mask_sync) {
+			reg = d->get_irq_reg(d, chip->mask_base, i);
 			ret = regmap_update_bits(d->map, reg,
 						 d->mask_buf_def[i],
 						 d->mask_buf[i]);
@@ -805,8 +783,8 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 			}
 		}
 
-		if (d->unmask_base && !chip->handle_mask_sync) {
-			reg = d->get_irq_reg(d, d->unmask_base, i);
+		if (chip->unmask_base && !chip->handle_mask_sync) {
+			reg = d->get_irq_reg(d, chip->unmask_base, i);
 			ret = regmap_update_bits(d->map, reg,
 					d->mask_buf_def[i], ~d->mask_buf[i]);
 			if (ret) {
-- 
2.39.2

