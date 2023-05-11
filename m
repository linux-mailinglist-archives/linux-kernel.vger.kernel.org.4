Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752046FEE6F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237366AbjEKJOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237296AbjEKJOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:14:00 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6CAAF
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:13:58 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f42c86543bso20532515e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683796437; x=1686388437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58FKT6mBLi9/p/z/H4le9F9arcqBmz3tNrQ4oPYMtxs=;
        b=RMfwftQ4O9nVrknSfSxB5Y6EQfvzZDAFihS192nR/sT2BqRlJC/sVyDzKx38lNiXrN
         IDOrH4j4oCyH6j8Jn/2QFB3uetyQueGmz0aymEHqU43+AicQk7p0L1CwcrvpvhhcwBlg
         /mYiM01PpSe//t8i3ptdhGFlc5adL50UUObpn7ypufRIOnfX2z6iY2q+aCvyDc1qYvuf
         pgjjZWvMEaqc8mNGI4Pio71bFsfSWjEKzTtgkNnHTjSkvFC6ZEe9eWdgt4LurRU/G3aS
         57HVJMcgLAF+wfCMU6na0yi0J4Hmg24VZa0rhbM6UISYLRNrYr97u7j10nn7eKLOhUaJ
         MyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683796437; x=1686388437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58FKT6mBLi9/p/z/H4le9F9arcqBmz3tNrQ4oPYMtxs=;
        b=fJrLVDRymAfXZuGO0wNB+2Z1rT1pu9RPZvpph2wl91rHmXH7DxmJ1l9l7T/nraZuFS
         V4xCy+yHTymAbEDeSVvlqaseDFeBy00qM+SQX+fN8lFFHGa4nCsoczVia16ik77X8J9+
         8IfQ/KHpjiJ6X+TO414YzRUOyckPmmzhGFPAFErpgZXVc6th1bQkP0aLU/9Qk+sr1rIU
         p3+PlR9Lir//NO5wF4q0XXRGdYH4So1bwzrXcfR5Jn/njsa6C7VOCkNEH4h1z46kVnU5
         X3H6NhTJJqLe7AIQFw0rD2K5vSOxRIKMuyoq6HvR3sQKzdXVIEHVkfGTUqYY/x13F/Sw
         PchQ==
X-Gm-Message-State: AC+VfDx5UhmGlGHnmLuG/ivFBPG6q3ZfnuV+lOgHwgrTybMZSTF3sAjO
        L61086fgDMls55BsmoaED5xoCpirh88=
X-Google-Smtp-Source: ACHHUZ4KWq+zh/pqy3xya11mBbGf/1573yTu42zLyTummPtqNR9ujpX3wIFRiCi3NN1wnXtZ4OTQqA==
X-Received: by 2002:a1c:f615:0:b0:3f1:952c:3c70 with SMTP id w21-20020a1cf615000000b003f1952c3c70mr12815163wmc.40.1683796437347;
        Thu, 11 May 2023 02:13:57 -0700 (PDT)
Received: from localhost ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id x18-20020a5d6b52000000b002ff2c39d072sm19889177wrw.104.2023.05.11.02.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 02:13:57 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] regmap-irq: Minor adjustments to .handle_mask_sync()
Date:   Thu, 11 May 2023 10:13:41 +0100
Message-Id: <20230511091342.26604-4-aidanmacdonald.0x0@gmail.com>
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
 drivers/base/regmap/regmap-irq.c | 65 +++++++++++++++-----------------
 1 file changed, 31 insertions(+), 34 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 7cb457af2332..95bf457204bf 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -113,23 +113,21 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 	 * suppress pointless writes.
 	 */
 	for (i = 0; i < d->chip->num_regs; i++) {
-		if (d->mask_base) {
-			if (d->chip->handle_mask_sync)
-				d->chip->handle_mask_sync(i, d->mask_buf_def[i],
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
+			d->chip->handle_mask_sync(i, d->mask_buf_def[i],
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
@@ -785,28 +783,27 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	for (i = 0; i < chip->num_regs; i++) {
 		d->mask_buf[i] = d->mask_buf_def[i];
 
-		if (d->mask_base) {
-			if (chip->handle_mask_sync) {
-				ret = chip->handle_mask_sync(i,
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
+			ret = chip->handle_mask_sync(i, d->mask_buf_def[i],
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

