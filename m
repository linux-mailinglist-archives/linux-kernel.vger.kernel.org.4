Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F2E6FC471
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbjEILBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbjEILBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:01:12 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925B6A5CD
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 04:01:11 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3063b5f32aaso3660659f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 04:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683630070; x=1686222070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=huc9DKkhPHvwfU7+LIVe3VqAE0fxRgkuMbov6Z1hvqk=;
        b=HFEw6LRVoJyDpf8VAQUEuWVdmvg6e5BIwjdfmVqXu47L+ne1GSFO/XxAsspH6OFXxM
         fFYbM502VoEiRnhzB8k42E2AOTMCl42fqz+CsO5FU72RfVUyWFDoBfw7UmbnP9gpoE1T
         Cqrt8gmx6XF1VKD68f7Uk941oObIENjSnK+3bJY3LzlvAkV7KL6RnvllZUTHjBc7Qxjd
         YcRs8KRixTRHDA3r0EblgEcmC1zhaD2BRPfZQbW/PenKVLdINlYB2l62bX54+S0zsWWs
         LRXhuyG9XV8GdQMt/hbRLvydRneLuJtJ9GFLkqliyoWtP1DpTD7KdGfqbOVfs3yfC+kp
         Iatg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683630070; x=1686222070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=huc9DKkhPHvwfU7+LIVe3VqAE0fxRgkuMbov6Z1hvqk=;
        b=FbOgb9Frtx1kkjuc72J9s1rxMQK+Z0R/Kazat3l/ANI5y+Gbe0hRezuFVzMo5Ii/Wk
         5p0my6M3hOfFJU2oFRvxzfvVBu4lN15BLqBfk4PGk55hCXBuob8HC2xQdZnA/87i6CK+
         OU+AJ8rNjcJFazvOrIiX8+q4HpI0EmV+jSBQbvUCtujLaeQ/U7KrihRr25solbPakpzq
         Lz0ZKcrxjmXMQ2alyyMsp+0fdwCA80cQ+euPE8ywDVETna9VP2ueIB8HN3b0lo2KxcxH
         YkTAcnV3j/SgImRdZfDtr89u1I964vFfOHPFxE+d87Z7wZzaIG9Eayqp4cdtWv+g/uoD
         FI2w==
X-Gm-Message-State: AC+VfDzJEw/Zl27a1LnRRDP0lczFv0yJZIPTFrkGuQoWDOlC5u5FDX1K
        e3W9QjJ06dg5pbDm0flQJFE=
X-Google-Smtp-Source: ACHHUZ6TSzSa2O4Emgij6HMpew+KF0hpkW8j3qO/XHontTLnx1VttdYduFoGT+E5ce7qhksZute9rQ==
X-Received: by 2002:a05:6000:104b:b0:2e4:eebe:aee3 with SMTP id c11-20020a056000104b00b002e4eebeaee3mr8535316wrx.60.1683630069931;
        Tue, 09 May 2023 04:01:09 -0700 (PDT)
Received: from localhost ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id p1-20020a05600c204100b003ed2c0a0f37sm19492960wmg.35.2023.05.09.04.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 04:01:09 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/6] regmap-irq: Minor adjustments to .handle_mask_sync()
Date:   Tue,  9 May 2023 12:00:59 +0100
Message-Id: <20230509110100.3980123-6-aidanmacdonald.0x0@gmail.com>
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

If a .handle_mask_sync() callback is provided it supersedes all
inbuilt handling of mask registers, and judging by the commit
69af4bcaa08d ("regmap-irq: Add handle_mask_sync() callback") it
is intended to completely replace all default IRQ masking logic.

The implementation has two minor inconsistencies, which can be
fixed without breaking compatibility:

(1) mask_base must be set to enable .handle_mask_sync(), even
    though mask_base is otherwise unused. This is easily fixed
    because mask_base is already optional.

(2) Unmask registers aren't accounted for -- they are part of
    the default IRQ masking logic and are just a bit-inverted
    version of mask registers. It would be a bad idea to allow
    them to be used at the same time as .handle_mask_sync(),
    as the result would be confusing and unmaintainable, so
    make sure this can't happen.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/base/regmap/regmap-irq.c | 68 ++++++++++++++++----------------
 1 file changed, 33 insertions(+), 35 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 41568927aa4c..898d1c6c5b75 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -113,24 +113,22 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 	 * suppress pointless writes.
 	 */
 	for (i = 0; i < d->chip->num_regs; i++) {
-		if (d->mask_base) {
-			if (d->chip->handle_mask_sync)
-				d->chip->handle_mask_sync(d->map, i,
-							  d->mask_buf_def[i],
-							  d->mask_buf[i],
-							  d->chip->irq_drv_data);
-			else {
-				reg = d->get_irq_reg(d, d->mask_base, i);
-				ret = regmap_update_bits(d->map, reg,
-						d->mask_buf_def[i],
-						d->mask_buf[i]);
-				if (ret)
-					dev_err(d->map->dev, "Failed to sync masks in %x\n",
-						reg);
-			}
+		if (d->chip->handle_mask_sync)
+			d->chip->handle_mask_sync(d->map, i,
+						  d->mask_buf_def[i],
+						  d->mask_buf[i],
+						  d->chip->irq_drv_data);
+
+		if (d->mask_base && !d->chip->handle_mask_sync) {
+			reg = d->get_irq_reg(d, d->mask_base, i);
+			ret = regmap_update_bits(d->map, reg,
+						 d->mask_buf_def[i],
+						 d->mask_buf[i]);
+			if (ret)
+				dev_err(d->map->dev, "Failed to sync masks in %x\n", reg);
 		}
 
-		if (d->unmask_base) {
+		if (d->unmask_base && !d->chip->handle_mask_sync) {
 			reg = d->get_irq_reg(d, d->unmask_base, i);
 			ret = regmap_update_bits(d->map, reg,
 					d->mask_buf_def[i], ~d->mask_buf[i]);
@@ -786,28 +784,28 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	for (i = 0; i < chip->num_regs; i++) {
 		d->mask_buf[i] = d->mask_buf_def[i];
 
-		if (d->mask_base) {
-			if (chip->handle_mask_sync) {
-				ret = chip->handle_mask_sync(d->map, i,
-							     d->mask_buf_def[i],
-							     d->mask_buf[i],
-							     chip->irq_drv_data);
-				if (ret)
-					goto err_alloc;
-			} else {
-				reg = d->get_irq_reg(d, d->mask_base, i);
-				ret = regmap_update_bits(d->map, reg,
-						d->mask_buf_def[i],
-						d->mask_buf[i]);
-				if (ret) {
-					dev_err(map->dev, "Failed to set masks in 0x%x: %d\n",
-						reg, ret);
-					goto err_alloc;
-				}
+		if (chip->handle_mask_sync) {
+			ret = chip->handle_mask_sync(d->map, i,
+						     d->mask_buf_def[i],
+						     d->mask_buf[i],
+						     chip->irq_drv_data);
+			if (ret)
+				goto err_alloc;
+		}
+
+		if (d->mask_base && !chip->handle_mask_sync) {
+			reg = d->get_irq_reg(d, d->mask_base, i);
+			ret = regmap_update_bits(d->map, reg,
+						 d->mask_buf_def[i],
+						 d->mask_buf[i]);
+			if (ret) {
+				dev_err(map->dev, "Failed to set masks in 0x%x: %d\n",
+					reg, ret);
+				goto err_alloc;
 			}
 		}
 
-		if (d->unmask_base) {
+		if (d->unmask_base && !chip->handle_mask_sync) {
 			reg = d->get_irq_reg(d, d->unmask_base, i);
 			ret = regmap_update_bits(d->map, reg,
 					d->mask_buf_def[i], ~d->mask_buf[i]);
-- 
2.39.2

