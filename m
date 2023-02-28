Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC1D6A6CA7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 13:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjCAM6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 07:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjCAM6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 07:58:49 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D301A647
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 04:58:48 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id q11-20020a056830440b00b00693c1a62101so7493460otv.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 04:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677675527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OyK1NRjw/4c0nP3WiY5DJv3QaTW6QxlnmL7lL+zTtyk=;
        b=bDQWML8wSwB8+GUWJ/35tvSFmVYqnPkC/OFQvZIdEh32mMSq0HNtBFMxDZ7RnPqofX
         H1ECS406rlQGoCL+5FDOwjO7JYec/+r+KUF1lfwW2Z6yh4q5lZDcCSkd13dLyatmAjoX
         92+0l4f7TnUpLtpdVLsChIsWC/Aa4lke3jeIFRoxVkS7Ofqi9WfrXqpBAqUUjF72YRpF
         J7NfohRIiscqEMjhEoOsQLWhEjWwurkWxWAxy1Xnc2J9Ds90yvCqwz/tPKg+cqBjPxxN
         aDJMW+parsmOUvvmg+gu8KuBmJ2iFdS9KKe4m8IZ1GPU1uOtVw+ScjATIVX4NTqFha14
         2Mkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677675527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OyK1NRjw/4c0nP3WiY5DJv3QaTW6QxlnmL7lL+zTtyk=;
        b=IcLlBbwECLuR9WUfysb9H+57EKZwWaSIaFNuZUMcC2V6cKGRZu9P12xSmc8bTVe6Xn
         lgjlFK/Dg0ordx0lIm7ksjc9uwmbiavzb2EOPMb9F3Cfu3ldSZ+aWYBzxoQ1Z+vzcoT0
         HfPKrxBfAQY7A0jQj1yZzzSW8NxrUJ7I/712R/Tux8JrjVtaMUlvqpTDFDsazzXSx9jT
         x846fYMyMNAdj398uGMsdXc2GfgOslf8/PRg+HSwD1NwB7URgAXM6Zk85zNHbM62wuCG
         UcI/3M2FHhfYoNDtOkKYhDLe9E3EpoH+y+Lq+VaLC2q8T/6YDGgR+ju/BsthxYXbNwBt
         gVXw==
X-Gm-Message-State: AO0yUKU41gzcVDzE6Gl/4WGY5Hxr5Xxg7jvKypb8b9/QqOilJvP4+IaT
        4UQnVLt9mLgrT5DZZA6Ph5J9xw==
X-Google-Smtp-Source: AK7set/dVBq5ekwOQCiM49scymI8WZzuOpGkFc5nXsYLFQ8q2ASWJRNLwosukPEax+QDm9VD2Sma2Q==
X-Received: by 2002:a9d:71db:0:b0:68b:ba4d:1c94 with SMTP id z27-20020a9d71db000000b0068bba4d1c94mr1984390otj.4.1677675527667;
        Wed, 01 Mar 2023 04:58:47 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id g21-20020a056830309500b0068bc48c61a5sm4865064ots.19.2023.03.01.04.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 04:58:47 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     broonie@kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, quarium@gmail.com,
        jhentges@accesio.com, jay.dolan@accesio.com,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v2 1/2] regmap: Pass regmap and irq_drv_data as parameters for set_type_config()
Date:   Mon, 27 Feb 2023 22:56:27 -0500
Message-Id: <c94de04b84d66b9686e26cb7653ae360f3075ede.1677555956.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1677555956.git.william.gray@linaro.org>
References: <cover.1677555956.git.william.gray@linaro.org>
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

Allow struct regmap_irq_chip set_type_config() callbacks to access the
device regmap and irq_drv_data by passing them as parameters.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
Changes in v2: none

 drivers/base/regmap/regmap-irq.c | 13 +++++++++----
 include/linux/regmap.h           | 12 ++++++++----
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index a8f185430a07..eac55a3af6d9 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -333,8 +333,9 @@ static int regmap_irq_set_type(struct irq_data *data, unsigned int type)
 	}
 
 	if (d->chip->set_type_config) {
-		ret = d->chip->set_type_config(d->config_buf, type,
-					       irq_data, reg);
+		ret = d->chip->set_type_config(map, d->config_buf, type,
+					       irq_data, reg,
+					       d->chip->irq_drv_data);
 		if (ret)
 			return ret;
 	}
@@ -650,18 +651,22 @@ EXPORT_SYMBOL_GPL(regmap_irq_get_irq_reg_linear);
 
 /**
  * regmap_irq_set_type_config_simple() - Simple IRQ type configuration callback.
+ * @map: The regmap for the device.
  * @buf: Buffer containing configuration register values, this is a 2D array of
  *       `num_config_bases` rows, each of `num_config_regs` elements.
  * @type: The requested IRQ type.
  * @irq_data: The IRQ being configured.
  * @idx: Index of the irq's config registers within each array `buf[i]`
+ * @irq_drv_data: Driver specific IRQ data
  *
  * This is a &struct regmap_irq_chip->set_type_config callback suitable for
  * chips with one config register. Register values are updated according to
  * the &struct regmap_irq_type data associated with an IRQ.
  */
-int regmap_irq_set_type_config_simple(unsigned int **buf, unsigned int type,
-				      const struct regmap_irq *irq_data, int idx)
+int regmap_irq_set_type_config_simple(struct regmap *map, unsigned int **buf,
+				      unsigned int type,
+				      const struct regmap_irq *irq_data,
+				      int idx, void *irq_drv_data)
 {
 	const struct regmap_irq_type *t = &irq_data->type;
 
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index a3bc695bcca0..49073f5ae87a 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1648,8 +1648,10 @@ struct regmap_irq_chip {
 				unsigned int mask_buf, void *irq_drv_data);
 	int (*set_type_virt)(unsigned int **buf, unsigned int type,
 			     unsigned long hwirq, int reg);
-	int (*set_type_config)(unsigned int **buf, unsigned int type,
-			       const struct regmap_irq *irq_data, int idx);
+	int (*set_type_config)(struct regmap *map, unsigned int **buf,
+			       unsigned int type,
+			       const struct regmap_irq *irq_data, int idx,
+			       void *irq_drv_data);
 	unsigned int (*get_irq_reg)(struct regmap_irq_chip_data *data,
 				    unsigned int base, int index);
 	void *irq_drv_data;
@@ -1657,8 +1659,10 @@ struct regmap_irq_chip {
 
 unsigned int regmap_irq_get_irq_reg_linear(struct regmap_irq_chip_data *data,
 					   unsigned int base, int index);
-int regmap_irq_set_type_config_simple(unsigned int **buf, unsigned int type,
-				      const struct regmap_irq *irq_data, int idx);
+int regmap_irq_set_type_config_simple(struct regmap *map, unsigned int **buf,
+				      unsigned int type,
+				      const struct regmap_irq *irq_data,
+				      int idx, void *irq_drv_data);
 
 int regmap_add_irq_chip(struct regmap *map, int irq, int irq_flags,
 			int irq_base, const struct regmap_irq_chip *chip,
-- 
2.39.2

