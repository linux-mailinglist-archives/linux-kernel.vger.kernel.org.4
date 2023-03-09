Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1B76B3207
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 00:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjCIXUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 18:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjCIXUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 18:20:18 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F142BF4D84
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 15:20:16 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id l18so4001146qtp.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 15:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678404016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aBHwsJnMX9DfsOKpSMcW/aw+nI15IPSIsttp1LlPPZM=;
        b=yCntCUurVPIiseJiy8rX+PhlTcvOGf9eiht/GJltQEqVCASz+A7NuF4cyiMffIMAJ9
         p1O+OanISm+azY548eAq6jZhiJWP9heb6hjZzrSPpXy98hx0yHO8tl0llaqCgfrxN0Nd
         aIS5F6Z+CH8ps7Rliam2xZMs7IUpiRB0UUrxoqnfBvRpEgJ4p5xiDUO12d5+h/YjzmHh
         SwPism6W6Wyje6DvDit4Q4jkrtC3LXX4JPgdWbCvs8mOy14h3mpmJ4TBEj+MN2W2rEn9
         YZeq/9x7L/X39H7Mff7oiSqhiF/8M+qv5UpW5TB2EKlNGulDfc731vArIfg325THgkyB
         Mg8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678404016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aBHwsJnMX9DfsOKpSMcW/aw+nI15IPSIsttp1LlPPZM=;
        b=T2S1AKMR2m+78EStRewquVKcR+4gxdlSXN8PAYEjzQCQn89h6fY/oIRiEaid7yIBTp
         9G7y6UgRhuJxRFv5WGFBjFleSmUqizAqg2xPL8OiBqL6ZM6TwnMTN3CneQZpus+/QpLw
         FOtQUVLQQWLPJe/+x8xhDPoUyZs+GCXw6thvYGfXtsTMNHXFbpUDXGIlRJx9nHB5thUS
         IwJuFqiVIKBFGuUkFIOaj6rcv8iqHXUKqDAiYClD5p5nDXwnpVIpY2CBMP1AEPGknjmq
         wCnYc1JO4s3fxBhloHPprB1jekSCAToYwZJKMvUkVznsgKWy//r8lRHq+iewLDy9vapP
         GMgA==
X-Gm-Message-State: AO0yUKWYUbVt0AssCQ6E+WjHAnLkUUZ3hPNa3v/4mvysuP5yGncMtPqu
        4wwBKW9EBMk09OzftYz9YmxICQ==
X-Google-Smtp-Source: AK7set/Vxrb8t3bBGwkCLFgGGlD5FjG4dKd0pmJwhKOoKGvmXf2dR/9/N0i3vkZppfuUhwtYxy9jaA==
X-Received: by 2002:a05:622a:40f:b0:3b3:7d5:a752 with SMTP id n15-20020a05622a040f00b003b307d5a752mr40710756qtx.50.1678404016071;
        Thu, 09 Mar 2023 15:20:16 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id 8-20020ac84e88000000b003bfd8e2ab40sm289755qtp.16.2023.03.09.15.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 15:20:15 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     broonie@kernel.org
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH] regmap-irq: Drop map from handle_mask_sync() parameters
Date:   Thu,  9 Mar 2023 18:20:09 -0500
Message-Id: <20230309232009.2938-1-william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
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

Remove the map parameter from the struct regmap_irq_chip callback
handle_mask_sync() because it can be passed via the irq_drv_data
parameter instead. The gpio-104-dio-48e driver is the only consumer of
this callback and is thus updated accordingly.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/base/regmap/regmap-irq.c |  5 ++---
 drivers/gpio/gpio-104-dio-48e.c  | 32 +++++++++++++++++++++++---------
 include/linux/regmap.h           |  3 +--
 3 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index f4d544ee7..ff6b585b9 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -116,8 +116,7 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 	for (i = 0; i < d->chip->num_regs; i++) {
 		if (d->mask_base) {
 			if (d->chip->handle_mask_sync)
-				d->chip->handle_mask_sync(d->map, i,
-							  d->mask_buf_def[i],
+				d->chip->handle_mask_sync(i, d->mask_buf_def[i],
 							  d->mask_buf[i],
 							  d->chip->irq_drv_data);
 			else {
@@ -918,7 +917,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 
 		if (d->mask_base) {
 			if (chip->handle_mask_sync) {
-				ret = chip->handle_mask_sync(d->map, i,
+				ret = chip->handle_mask_sync(i,
 							     d->mask_buf_def[i],
 							     d->mask_buf[i],
 							     chip->irq_drv_data);
diff --git a/drivers/gpio/gpio-104-dio-48e.c b/drivers/gpio/gpio-104-dio-48e.c
index a3846faf3..1de551677 100644
--- a/drivers/gpio/gpio-104-dio-48e.c
+++ b/drivers/gpio/gpio-104-dio-48e.c
@@ -99,14 +99,25 @@ static const struct regmap_irq dio48e_regmap_irqs[] = {
 	DIO48E_REGMAP_IRQ(0), DIO48E_REGMAP_IRQ(1),
 };
 
-static int dio48e_handle_mask_sync(struct regmap *const map, const int index,
+/**
+ * struct dio48e_gpio - GPIO device private data structure
+ * @map:	Regmap for the device
+ * @irq_mask:	Current IRQ mask state on the device
+ */
+struct dio48e_gpio {
+	struct regmap *map;
+	unsigned int irq_mask;
+};
+
+static int dio48e_handle_mask_sync(const int index,
 				   const unsigned int mask_buf_def,
 				   const unsigned int mask_buf,
 				   void *const irq_drv_data)
 {
-	unsigned int *const irq_mask = irq_drv_data;
-	const unsigned int prev_mask = *irq_mask;
+	struct dio48e_gpio *const dio48egpio = irq_drv_data;
+	const unsigned int prev_mask = dio48egpio->irq_mask;
 	const unsigned int all_masked = GENMASK(1, 0);
+	struct regmap *const map = dio48egpio->map;
 	int err;
 	unsigned int val;
 
@@ -115,7 +126,7 @@ static int dio48e_handle_mask_sync(struct regmap *const map, const int index,
 		return 0;
 
 	/* remember the current mask for the next mask sync */
-	*irq_mask = mask_buf;
+	dio48egpio->irq_mask = mask_buf;
 
 	/* if all previously masked, enable interrupts when unmasking */
 	if (prev_mask == all_masked) {
@@ -168,7 +179,7 @@ static int dio48e_probe(struct device *dev, unsigned int id)
 	struct regmap *map;
 	int err;
 	struct regmap_irq_chip *chip;
-	unsigned int irq_mask;
+	struct dio48e_gpio *dio48egpio;
 	struct regmap_irq_chip_data *chip_data;
 
 	if (!devm_request_region(dev, base[id], DIO48E_EXTENT, name)) {
@@ -186,12 +197,14 @@ static int dio48e_probe(struct device *dev, unsigned int id)
 		return dev_err_probe(dev, PTR_ERR(map),
 				     "Unable to initialize register map\n");
 
-	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
-	if (!chip)
+	dio48egpio = devm_kzalloc(dev, sizeof(*dio48egpio), GFP_KERNEL);
+	if (!dio48egpio)
 		return -ENOMEM;
 
-	chip->irq_drv_data = devm_kzalloc(dev, sizeof(irq_mask), GFP_KERNEL);
-	if (!chip->irq_drv_data)
+	dio48egpio->map = map;
+
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
 		return -ENOMEM;
 
 	chip->name = name;
@@ -206,6 +219,7 @@ static int dio48e_probe(struct device *dev, unsigned int id)
 	chip->irqs = dio48e_regmap_irqs;
 	chip->num_irqs = ARRAY_SIZE(dio48e_regmap_irqs);
 	chip->handle_mask_sync = dio48e_handle_mask_sync;
+	chip->irq_drv_data = dio48egpio;
 
 	/* Initialize to prevent spurious interrupts before we're ready */
 	err = dio48e_irq_init_hw(map);
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 19d54f019..6516f975c 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1649,8 +1649,7 @@ struct regmap_irq_chip {
 
 	int (*handle_pre_irq)(void *irq_drv_data);
 	int (*handle_post_irq)(void *irq_drv_data);
-	int (*handle_mask_sync)(struct regmap *map, int index,
-				unsigned int mask_buf_def,
+	int (*handle_mask_sync)(int index, unsigned int mask_buf_def,
 				unsigned int mask_buf, void *irq_drv_data);
 	int (*set_type_virt)(unsigned int **buf, unsigned int type,
 			     unsigned long hwirq, int reg);

base-commit: 054a0da568b94f6b69ccf34b80f7c41a6623eb11
-- 
2.39.2

