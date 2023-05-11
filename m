Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8FB6FEE70
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237381AbjEKJOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjEKJOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:14:01 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F195B2126
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:13:59 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f475366514so13403995e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683796438; x=1686388438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vtZdgeg9ddbhPRh6PC9cZ0EnGp++W69JKMYWDuC5ZjM=;
        b=AhK75zZbjGAdW/dYUEU3Goj+tB4VJJrBzSM4Vdb5pqMRkj37o9FXlra9lcfJzDc5Mp
         qXuPVOYPMBVor3UCpiGhOq6iwERosDJUgBqbZrlh+0v/8GuyaS0fdaQPDmoQiqQGeK1e
         YsEIZfLMLe5xTzDFLMZmB4PCC5wBL3W7DfqiV3GSGZYl64Z0uRAV+8c41cdvxiCvL3y5
         McbkBJJmu55RhEkqK2puHTfnpUtkQM/nuBwRXqrz4z/I7lVXt3DPNXafgg0GY9mhhJGQ
         V8H7Cdo2Pn6CncoUF6VHxgo5WjtBgRrSh6fFTiihH2hVRWfmPL0rKy52/nUdOHbHXzrd
         GtKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683796438; x=1686388438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vtZdgeg9ddbhPRh6PC9cZ0EnGp++W69JKMYWDuC5ZjM=;
        b=jA7B+A09QGjoFTSpP4vetR7z33OKcB/Sc6qoMphxvAlY3C/nCWoWmzuPXsR03YKtDp
         qrLcQgZ86T6iCOI7w2OWwbaRMGGyc69qWS3hvtBIjDxgqnSuOEbN8bVP5L9cIBc6WoII
         9od/DUicu6ljZf3yZ6zmYVCL7+t3epq7S/pqK6lvCFvqW2sT+K7aiCG6rMHomlQ7Ma5g
         tN4JjLfwcqcNm82xkIrX5tA4SNbRLeE+mEKn1Kzy9ddqBheq5QV2I3NmDJ232aZZmBEC
         0uA3SD7oDlYF/ii1LeefNYGSRzMoMYNO0UGnOGUOhel+Bqz/4tfa8RIqKc0VGs62NyVj
         jeaQ==
X-Gm-Message-State: AC+VfDxUfRGDNhGXlba/Aev4w4mrwUr2Hdrads7uzhp0Qv9miuYqBW19
        dEr69W9KfWgaohEHV74MzZ8=
X-Google-Smtp-Source: ACHHUZ6kJY7Xpu7b8kztQLzlN9l9ybqrPkb/6aNx8jQBNgkl9YAO7tlNHBfK+JhHEECjvd/Xb52I0g==
X-Received: by 2002:a05:600c:24ce:b0:3f2:5641:3d4 with SMTP id 14-20020a05600c24ce00b003f2564103d4mr14102169wmu.33.1683796438339;
        Thu, 11 May 2023 02:13:58 -0700 (PDT)
Received: from localhost ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id e1-20020adfdbc1000000b0030795249ffasm12304958wrj.92.2023.05.11.02.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 02:13:57 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] regmap-irq: Drop backward compatibility for inverted mask/unmask
Date:   Thu, 11 May 2023 10:13:42 +0100
Message-Id: <20230511091342.26604-5-aidanmacdonald.0x0@gmail.com>
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

All users must now specify .mask_unmask_non_inverted = true to
ensure they are using the expected semantics: 1s disable IRQs
in the mask registers, and enable IRQs in the unmask registers.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/base/regmap/regmap-irq.c | 44 ++++++++------------------------
 1 file changed, 11 insertions(+), 33 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 95bf457204bf..330da5d6c8c3 100644
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
@@ -118,8 +115,8 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 						  d->mask_buf[i],
 						  d->chip->irq_drv_data);
 
-		if (d->mask_base && !d->chip->handle_mask_sync) {
-			reg = d->get_irq_reg(d, d->mask_base, i);
+		if (d->chip->mask_base && !d->chip->handle_mask_sync) {
+			reg = d->get_irq_reg(d, d->chip->mask_base, i);
 			ret = regmap_update_bits(d->map, reg,
 						 d->mask_buf_def[i],
 						 d->mask_buf[i]);
@@ -127,8 +124,8 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 				dev_err(d->map->dev, "Failed to sync masks in %x\n", reg);
 		}
 
-		if (d->unmask_base && !d->chip->handle_mask_sync) {
-			reg = d->get_irq_reg(d, d->unmask_base, i);
+		if (d->chip->unmask_base && !d->chip->handle_mask_sync) {
+			reg = d->get_irq_reg(d, d->chip->unmask_base, i);
 			ret = regmap_update_bits(d->map, reg,
 					d->mask_buf_def[i], ~d->mask_buf[i]);
 			if (ret)
@@ -645,6 +642,9 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	if (chip->clear_on_unmask && (chip->ack_base || chip->use_ack))
 		return -EINVAL;
 
+	if (chip->mask_base && chip->unmask_base && !chip->mask_unmask_non_inverted)
+		return -EINVAL;
+
 	for (i = 0; i < chip->num_irqs; i++) {
 		if (chip->irqs[i].reg_offset % map->reg_stride)
 			return -EINVAL;
@@ -733,28 +733,6 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
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
@@ -791,8 +769,8 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 				goto err_alloc;
 		}
 
-		if (d->mask_base && !chip->handle_mask_sync) {
-			reg = d->get_irq_reg(d, d->mask_base, i);
+		if (chip->mask_base && !chip->handle_mask_sync) {
+			reg = d->get_irq_reg(d, chip->mask_base, i);
 			ret = regmap_update_bits(d->map, reg,
 						 d->mask_buf_def[i],
 						 d->mask_buf[i]);
@@ -803,8 +781,8 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
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

