Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CA7626D45
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 02:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbiKMBJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 20:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbiKMBJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 20:09:48 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23FA13F26
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 17:09:46 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id jr19so5032263qtb.7
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 17:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGoGlg9PvY2E8Ynkgg/9d00Wg7JTF+kYvlV8sa6lfGc=;
        b=u2g3PubVHJwCPJno4Iyyr4YIRiDzJp32ZRILY32qbklBibNGwxd5SmTktC06/28jKE
         KFb94skj8xcv7b/1m/orF0238XBdOkv6eir0/czpxR2E3RYroBu6d4HcaOm+Ea6GQAwr
         MS4cFhq02sceqBO/+cH8oNRNfkPLjdO9idRYNNBqZOlpB1odN/j2MEYxpdQ5BvhMlGPm
         KR7EN+loYFRamHbEJ82vwrCWw5b4fDIuITxaFYL/ty8h2Vl/b/SvY7gYd4mglQLoe3Vc
         sBaapRTgT2pvdOCLiSwtLtvGe1XbugIu52HIY9HfaTzlcRvFJ0tDPodJGnoGMiDbDZ6C
         3ogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aGoGlg9PvY2E8Ynkgg/9d00Wg7JTF+kYvlV8sa6lfGc=;
        b=DtNtJkfxrQE1pkZIVE91WxL5lSAz0n0oG1Oj7a1MswI7wfLR2vtD48oy6PTpeuBhd4
         JKM/QbNfv0QQLkU65eAgTlmnQshzPezW0AUUpnmrTGlnQI6thnUcilGe+g2cR7rBzD7G
         kwKjTfc2DIgnxy0SQY+Wbbkjr2317B4ympptFtz4KtA6bl20Tb7DZzDqgWRozOLUs6S5
         93xPShEDdG7qSTbOv9sDd4WLX+wW4r+aQo4gVfgesSBB4Jo8UOopUSnNjs/SGt1EtkcR
         dtwp5QXAHL5L5hYDIs10F7F+XhLhDtk9Jbolt27718F7PNJz40MTN+sHQMeR7Fns0gYr
         e01Q==
X-Gm-Message-State: ANoB5plvaWYMi7/xY0WIskb65wz9A3j5K+IcENU9ksLmtaPx0Wl8Th5c
        e00dVAJF1iOh63Y5EwrsQIXAtQ==
X-Google-Smtp-Source: AA0mqf6CJswmr3tcKdIe33d8L4jDiIZjSKufY4MPq52zCFU3bZki7KEDVNusf5ryl+AXu75GORs3UQ==
X-Received: by 2002:ac8:4d9a:0:b0:39c:d479:b1d9 with SMTP id a26-20020ac84d9a000000b0039cd479b1d9mr7058653qtw.612.1668301786034;
        Sat, 12 Nov 2022 17:09:46 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id t6-20020a05622a180600b00343057845f7sm3552498qtc.20.2022.11.12.17.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 17:09:45 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael@walle.cc, broonie@kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v2 2/4] regmap-irq: Add handle_mask_sync() callback
Date:   Thu, 10 Nov 2022 20:55:51 -0500
Message-Id: <53e9e89cc9d7e9c20cbdfc13b360dcb43d07f832.1668129763.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1668129763.git.william.gray@linaro.org>
References: <cover.1668129763.git.william.gray@linaro.org>
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
index ca3434dca3a0..62ede456af99 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1542,6 +1542,8 @@ struct regmap_irq_chip_data;
  *		     before regmap_irq_handler process the interrupts.
  * @handle_post_irq: Driver specific callback to handle interrupt from device
  *		     after handling the interrupts in regmap_irq_handler().
+ * @handle_mask_sync: Callback used to handle IRQ mask syncs. The index will be
+ *		      in the range [0, num_regs[
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

