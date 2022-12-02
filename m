Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B5C640AB1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbiLBQ1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbiLBQ1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:27:25 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E52D11B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 08:27:24 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id cg5so5820733qtb.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 08:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KoWGIAjBhBK2abs/14cO4LLdz54XLj1GMrifUXlELoM=;
        b=k5wr7gsqxn626Vjan8gsweRHiUDe47XdXpDt/HSf5/uMNpca+G5vcDB7m4TXLhmZoN
         3vD0vJcVkfaXhjl60L+kdnnDbNHJQBZjqvy91gr8lcLrIArd7n86286nqnXcje6xRiK0
         yFacApcTCW0/Q7o0qCVxweIBMDmOglBHg2/fQb9St6M5Zsa0/XamgNTnftEbsMgxjf/f
         snmqOUtfkCxNOyd3qIUx/iiA6CGGgj8eEGNuWsNjgPP+i9JrYtjsKxUl6aBG05nZtJ4q
         nsEyNQ9zv1EUsA9cIJlQl5z+GqF9Ufgf9iU8fFyHw1kqYCIx3rt/5NrHYLHFI6zcH15E
         Iafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KoWGIAjBhBK2abs/14cO4LLdz54XLj1GMrifUXlELoM=;
        b=dxd5TLdTPR4AkrpC6uzHIkWq1wMYQyQUkYnNvJylxaqcnKUvbXpW81Iv6ot5iN+9ft
         sY3BwyFumrRsEL+44P5CxMKbHXS4u3QMfhnN3tbqTu+ghoE+K4L/gWqoLNVcDBWgMpIa
         1uMHDLyJXNDRDeyn9MHNFPqJVa+qX2+f36GR40Z8yTHJO6EN02LxI584F/F006ztzGzL
         YUC9geUbJAN0bKAtIfka9MpFDknOBYAJ/85nJzp41oGuHlv/ZmvP1ItD0OMDb3YAYWC7
         pzbExoFGj1dn/XS6T5JNxbeaorRxIz9rxi2XTax9S1252JH3rX7mmI1hulknKdu6aRJd
         3fOg==
X-Gm-Message-State: ANoB5pkmwglHhwcOrmDnJCXdX3FkdomTkIe5fXVhe+1yaDDazs7VruZ1
        hxD0mHLvI8IgQMQpgAj/MnRseg==
X-Google-Smtp-Source: AA0mqf5MffTw9tu2sOga5fyCyXD/Qyyo6deNh0mKD4gq5ZR8aRjce4vJdPhXsOOHM2SbMX2jM0WNcg==
X-Received: by 2002:a05:620a:201c:b0:6ce:51a0:a80e with SMTP id c28-20020a05620a201c00b006ce51a0a80emr62516530qka.591.1669998444018;
        Fri, 02 Dec 2022 08:27:24 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id fp38-20020a05622a50a600b00343057845f7sm4391887qtb.20.2022.12.02.08.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 08:27:23 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael@walle.cc, broonie@kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v4 2/9] regmap-irq: Add handle_mask_sync() callback
Date:   Fri,  2 Dec 2022 11:27:08 -0500
Message-Id: <0dcd938f410bdbb0a011bec51c4b5b26882ca10a.1669996867.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1669996866.git.william.gray@linaro.org>
References: <cover.1669996866.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

