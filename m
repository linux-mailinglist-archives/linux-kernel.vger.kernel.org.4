Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0098F6361A7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238575AbiKWO0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236642AbiKWO0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:26:10 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3A270188
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:25:15 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id c15so11283572qtw.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cthntMJEQCPgBQBzQ9X0QMzb77dxt7cdP+6IqKGFEhE=;
        b=wVC8m7Dvh9WJJOxTjjlPgsjTcADcr9YQAA1YXLdxymiRUdTVrHLA+x32CVZ7Yu1kJ+
         JBjww9S9s6DRD1bKOaORGOBSBuDRIKvY/scrG5rxJxv2eqUVWbRWbmO/ozCeh+oQDc3H
         hs0tIqSpWUntRx47G+V6U5l0GDkauXUBiVOgCdxLXXT+osrOSwa+QTZIhQCYLgqS1+mV
         Vjaw8j/bkUP2/xN3g/gzMySasa0mvQn+fEfPEkYHY/jXyErW9W3pH/4bJ/VfzkHvAVfZ
         K7br9l6vhqRxeMR4ZDfxujNxaMrIctDGzH0d2B7+savTQuHqncqX0LoqFmClgciBB2OH
         cbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cthntMJEQCPgBQBzQ9X0QMzb77dxt7cdP+6IqKGFEhE=;
        b=MQH3Swe9sRcABK2xKrRCJWey0cF3ZmRFvDDyNYYIWXDTs1phaaeXdfI0VkSkGu4vPg
         9OmptsN6Ee8ljBBKXLJ2Y0KBEs1MyGKxhHReiXvmVgurtd6BhLuRYsWNXxKgHFONoO9S
         4YtZFaiKOuAIpZNSHR3pnhf7LBl9CFs3DsbWSmLcX8CgfUPfY68bQo3L3YWQbCPRgnm9
         N6R5oKVw1cyL62rh1CAQ2R+2O5LMwpTtCDpN8ttCX0HzXxERe1xoKjir41hZvTkq0DJB
         hm5g31sgI72BkpcjT9JD/ijHsQDpJ7pdmx+WUf6fF25FEn88OOIVJ52vMAL9RG23fW1h
         V5+Q==
X-Gm-Message-State: ANoB5pmzqyQLhGcr9Tkb8ZFD2cZceobbpbyw74fS2mh+7roolV/RiKhA
        slTaolL93o9nXqOaRjQMmXtqqQ==
X-Google-Smtp-Source: AA0mqf61Ieuh9kiFl0RM0sHS/bA3IsUn57qQroiq4oJVl6aaO/v4ZT3NqReUfgvG0jIY9LeUnVMj4w==
X-Received: by 2002:a05:622a:420b:b0:3a4:fb31:db9c with SMTP id cp11-20020a05622a420b00b003a4fb31db9cmr26218441qtb.637.1669213514399;
        Wed, 23 Nov 2022 06:25:14 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id b28-20020a05620a127c00b006f9c2be0b4bsm11718802qkl.135.2022.11.23.06.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 06:25:13 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael@walle.cc, broonie@kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v3 2/9] regmap-irq: Add handle_mask_sync() callback
Date:   Tue, 22 Nov 2022 02:10:59 -0500
Message-Id: <e083474b3d467a86e6cb53da8072de4515bd6276.1669100542.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1669100542.git.william.gray@linaro.org>
References: <cover.1669100542.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a public callback handle_mask_sync() that drivers can use when
they have more complex IRQ masking logic. The default implementation is
regmap_irq_handle_mask_sync(), used if the chip doesn't provide its own
callback.

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/base/regmap/regmap-irq.c | 44 ++++++++++++++++++++++----------
 include/linux/regmap.h           |  5 ++++
 2 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 4ef9488d05cd..968681fa8d09 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -115,12 +115,20 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 	 */
 	for (i = 0; i < d->chip->num_regs; i++) {
 		if (d->mask_base) {
-			reg = d->get_irq_reg(d, d->mask_base, i);
-			ret = regmap_update_bits(d->map, reg,
-					d->mask_buf_def[i], d->mask_buf[i]);
-			if (ret)
-				dev_err(d->map->dev, "Failed to sync masks in %x\n",
-					reg);
+			if (d->chip->handle_mask_sync)
+				d->chip->handle_mask_sync(d->map, i,
+							  d->mask_buf_def[i],
+							  d->mask_buf[i],
+							  d->chip->irq_drv_data);
+			else {
+				reg = d->get_irq_reg(d, d->mask_base, i);
+				ret = regmap_update_bits(d->map, reg,
+						d->mask_buf_def[i],
+						d->mask_buf[i]);
+				if (ret)
+					dev_err(d->map->dev, "Failed to sync masks in %x\n",
+						reg);
+			}
 		}
 
 		if (d->unmask_base) {
@@ -917,13 +925,23 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 		d->mask_buf[i] = d->mask_buf_def[i];
 
 		if (d->mask_base) {
-			reg = d->get_irq_reg(d, d->mask_base, i);
-			ret = regmap_update_bits(d->map, reg,
-					d->mask_buf_def[i], d->mask_buf[i]);
-			if (ret) {
-				dev_err(map->dev, "Failed to set masks in 0x%x: %d\n",
-					reg, ret);
-				goto err_alloc;
+			if (chip->handle_mask_sync) {
+				ret = chip->handle_mask_sync(d->map, i,
+							     d->mask_buf_def[i],
+							     d->mask_buf[i],
+							     chip->irq_drv_data);
+				if (ret)
+					goto err_alloc;
+			} else {
+				reg = d->get_irq_reg(d, d->mask_base, i);
+				ret = regmap_update_bits(d->map, reg,
+						d->mask_buf_def[i],
+						d->mask_buf[i]);
+				if (ret) {
+					dev_err(map->dev, "Failed to set masks in 0x%x: %d\n",
+						reg, ret);
+					goto err_alloc;
+				}
 			}
 		}
 
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index ca3434dca3a0..cc07645501af 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1542,6 +1542,8 @@ struct regmap_irq_chip_data;
  *		     before regmap_irq_handler process the interrupts.
  * @handle_post_irq: Driver specific callback to handle interrupt from device
  *		     after handling the interrupts in regmap_irq_handler().
+ * @handle_mask_sync: Callback used to handle IRQ mask syncs. The index will be
+ *		      in the range [0, num_regs)
  * @set_type_virt:   Driver specific callback to extend regmap_irq_set_type()
  *		     and configure virt regs. Deprecated, use @set_type_config
  *		     callback and config registers instead.
@@ -1603,6 +1605,9 @@ struct regmap_irq_chip {
 
 	int (*handle_pre_irq)(void *irq_drv_data);
 	int (*handle_post_irq)(void *irq_drv_data);
+	int (*handle_mask_sync)(struct regmap *map, int index,
+				unsigned int mask_buf_def,
+				unsigned int mask_buf, void *irq_drv_data);
 	int (*set_type_virt)(unsigned int **buf, unsigned int type,
 			     unsigned long hwirq, int reg);
 	int (*set_type_config)(unsigned int **buf, unsigned int type,
-- 
2.38.1

