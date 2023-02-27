Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA066A4754
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 17:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjB0Qy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 11:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjB0QyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 11:54:25 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5924AE060
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 08:54:24 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id nv15so4845650qvb.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 08:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzM1FyAgchik+Dup/9deHHYpfXbDm5/FZoytx5b+K08=;
        b=P3B1CjO7qxyvgQxciO8LtZPx0qQ7K7ufxl/u3qOJDYVbZUKF/qBizuKzBZUJDtsVNH
         O4p120fia7Hq8Y5zVkTXDvJKdIsszlX6C2ddx+pg1PdIblSgCuvi/w37L11SG0g1Mjpn
         I18BQIC67zKRlGj9n/gBk+kdqj3l8heqLwbzIEVP85poUcGT3sKBBtdzCecVXT18vGD7
         ZW6kVzSpoSHhxdrB6uO3hTTE10JHop/JsxtRHGWd85/3tRjkOuegWw3GSNdF5ExoI0Lj
         s7QbsV1RpPxFN5nydD8Ni+mp6jsL3+lTMTVOtJNF3p4HO+uTSdj5S1y7ao8tI9eLdvXv
         jBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzM1FyAgchik+Dup/9deHHYpfXbDm5/FZoytx5b+K08=;
        b=jXuKI5GSAaLHOy0fkXVi1hkDESY6Sv5KjS0hFJHhpfncOVjmKBaKtaFq73HMsezdg4
         3EEywIvkj2FTFXqemOk+IzyoQ1ABGFeebAmCvm2rvyJBqJ4yRhC1fSuYI6QqPnhCXQ7W
         dotKZeEdiJC+v2S4H+WtKX0zOAIu5IW/xH+JqsHYqWI58Z5OflzhCzhH+Qp1FV3lH14s
         lGIOBOib4B8Dcz2b8HgcKrnWZTIiQYMThlJNuiJQUpZ7R2vz6HJ4aVSz+Vt9JfMmVK8H
         +X5Dspyo4ZdP3q4x29ngnni7BLl8VFychnrBgpCV6jOHH+zZw5CZY7auFi/mgawywXV4
         NSzw==
X-Gm-Message-State: AO0yUKVBsXRVWsgW8g/RaYObAx0oyQHe4Sis9nzFGgdUjjJdUxDiq7jn
        +ML9IBk7klmGZUYlFY1dFwaUjg==
X-Google-Smtp-Source: AK7set+wTzIvkGOdefHpA+JETrYPiVIYbUJHm8fXQx13Fj4p8cwr3eY0I0JtnJOs9XM4PR3wZIMDZA==
X-Received: by 2002:a05:6214:f09:b0:570:bf43:48e with SMTP id gw9-20020a0562140f0900b00570bf43048emr182116qvb.30.1677516863465;
        Mon, 27 Feb 2023 08:54:23 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id x15-20020a05620a098f00b0073b929d0371sm5238714qkx.4.2023.02.27.08.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 08:54:23 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     broonie@kernel.org, andriy.shevchenko@linux.intel.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v2 1/6] regmap-irq: Add no_status support
Date:   Mon, 27 Feb 2023 11:45:22 -0500
Message-Id: <bd501b4b5ff88da24d467f75e8c71b4e0e6f21e2.1677515341.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1677515341.git.william.gray@linaro.org>
References: <cover.1677515341.git.william.gray@linaro.org>
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

Some devices lack status registers, yet expect to handle interrupts.
Introduce a no_status flag to indicate such a configuration, where
rather than read a status register to verify, all interrupts received
are assumed to be active.

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
Changes in v2:
 - Utilize memset32() to set status_buf for no_status case
 - Utilize GENMASK() to generate status_buf mask
 - Move no_status kernel doc line under runtime_pm line

 drivers/base/regmap/regmap-irq.c | 22 +++++++++++++++-------
 include/linux/regmap.h           |  2 ++
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index a8f185430a07..290e26664a21 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -437,7 +437,10 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 	 * possible in order to reduce the I/O overheads.
 	 */
 
-	if (chip->num_main_regs) {
+	if (chip->no_status) {
+		/* no status register so default to all active */
+		memset32(data->status_buf, GENMASK(31, 0), chip->num_regs);
+	} else if (chip->num_main_regs) {
 		unsigned int max_main_bits;
 		unsigned long size;
 
@@ -967,12 +970,17 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 			continue;
 
 		/* Ack masked but set interrupts */
-		reg = d->get_irq_reg(d, d->chip->status_base, i);
-		ret = regmap_read(map, reg, &d->status_buf[i]);
-		if (ret != 0) {
-			dev_err(map->dev, "Failed to read IRQ status: %d\n",
-				ret);
-			goto err_alloc;
+		if (d->chip->no_status) {
+			/* no status register so default to all active */
+			d->status_buf[i] = GENMASK(31, 0);
+		} else {
+			reg = d->get_irq_reg(d, d->chip->status_base, i);
+			ret = regmap_read(map, reg, &d->status_buf[i]);
+			if (ret != 0) {
+				dev_err(map->dev, "Failed to read IRQ status: %d\n",
+					ret);
+				goto err_alloc;
+			}
 		}
 
 		if (chip->status_invert)
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index a3bc695bcca0..c6d80d4e73de 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1564,6 +1564,7 @@ struct regmap_irq_chip_data;
  *		      the need for a @sub_reg_offsets table.
  * @status_invert: Inverted status register: cleared bits are active interrupts.
  * @runtime_pm:  Hold a runtime PM lock on the device when accessing it.
+ * @no_status: No status register: all interrupts assumed generated by device.
  *
  * @num_regs:    Number of registers in each control bank.
  * @irqs:        Descriptors for individual IRQs.  Interrupt numbers are
@@ -1630,6 +1631,7 @@ struct regmap_irq_chip {
 	unsigned int clear_on_unmask:1;
 	unsigned int not_fixed_stride:1;
 	unsigned int status_invert:1;
+	unsigned int no_status:1;
 
 	int num_regs;
 
-- 
2.39.2

