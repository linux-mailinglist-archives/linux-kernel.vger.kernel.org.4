Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708C36C96D3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 18:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbjCZQ0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 12:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjCZQ0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 12:26:18 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED6F4C24
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 09:26:16 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5416698e889so127846147b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 09:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679847975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWkzvnXS67Y4JJxi2e9OJWi3FXRdHghBz+RafIYZB7I=;
        b=UBCbYmP/kUKDU0l6gdJ0L3rZVzPqj103Ygk9kEC3/hQTYbZwUHL5VXdgOuyx/K87qZ
         HXeU+4imWTuSN9b9GrfGxVNfQ5NH2ZHKkxJE5L5l5FVSNyYvrMC9VxMMGXhBJbgPC/Aj
         BZGtRDf9P0kmcDbbWgJJz9kTP3de4I+zolmx7qI/p3UHF5MWZxSj9j/R2oTWu/7jOAXF
         M/ZQ78ox5Eh/zg4mNvmMNTOzln+JxkI6QITfRiB8diwfVrNc0CLqMpbWrEFZz2wLI0Cu
         dcHiiZd28/YJCi4iZoWj29bxs64odcpfJ1RqMo8UUUx7OG5OWVZFtaKHRUkUlr40/eJD
         tCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679847975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oWkzvnXS67Y4JJxi2e9OJWi3FXRdHghBz+RafIYZB7I=;
        b=5vdDsPBlVNshI7fRDkjKOcxdKVmLqjbq6iJP9AGhnPc7fuq+l+GYs4z6Dge08/bTV1
         nAB8MIgqweMueEFzdC0ZthM6yx7XM3UPk1EX7ywV2AlQw64VEDad1qmLOISh4B9BHWTG
         O81ev9qhgmL/24Ch51pjiqBSQu3+lx+EyUQOiPEfkwwV93JyWgDCqmiuo55ygVjGaT0a
         zzq7YYYE2KdTWox8ekyvazi/srUDa1DbA+0xSu9zvi45jVNzduIfG9I7TYlZdHW1WwC7
         tbZoB9Fp/x+TVuyAqaxLiYJ+8gBG0GmgC7DBg2PKgWQZRffe9/MPwTrq6BL1u3TJfC47
         2lAg==
X-Gm-Message-State: AAQBX9fLMpURtcjtRXyU9xRTQxkLUU7N2DDZiaBL+6Htv6E/iFB7GWxT
        BBIMI/dBRRRJ1Qa/1glROFWGEQ==
X-Google-Smtp-Source: AKy350auNhQIAh/Vrrw0gzOMiRasHup+LM4iVkbspJy5FPWtjFw21Vr+FJsJOtIb7oIpgJ5X3NXKWQ==
X-Received: by 2002:a81:9283:0:b0:541:4586:7e0b with SMTP id j125-20020a819283000000b0054145867e0bmr9315131ywg.10.1679847975503;
        Sun, 26 Mar 2023 09:26:15 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id ci9-20020a05690c0a8900b00545a08184e9sm1543168ywb.121.2023.03.26.09.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 09:26:15 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        techsupport@winsystems.com, pdemetrotion@winsystems.com,
        quarium@gmail.com, jhentges@accesio.com, jay.dolan@accesio.com
Subject: [PATCH v5 1/3] regmap: Pass irq_drv_data as a parameter for set_type_config()
Date:   Sun, 26 Mar 2023 12:25:57 -0400
Message-Id: <5ba9d4c58a4cef138201334ea48e8bc8297a9a1c.1679845842.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679845842.git.william.gray@linaro.org>
References: <cover.1679845842.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the struct regmap_irq_chip set_type_config() callback to access
irq_drv_data by passing it as a parameter.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
Changes in v5:
 - Wrap lines to 100 characters rather than 80
Changes in v4: none
Changes in v3:
 - Drop map from set_type_config() parameter list; regmap can be passed
   by irq_drv_data instead
Changes in v2: none

 drivers/base/regmap/regmap-irq.c | 6 ++++--
 include/linux/regmap.h           | 5 +++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index ff6b585b9049..6994e59c3e30 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -329,7 +329,7 @@ static int regmap_irq_set_type(struct irq_data *data, unsigned int type)
 
 	if (d->chip->set_type_config) {
 		ret = d->chip->set_type_config(d->config_buf, type,
-					       irq_data, reg);
+					       irq_data, reg, d->chip->irq_drv_data);
 		if (ret)
 			return ret;
 	}
@@ -653,13 +653,15 @@ EXPORT_SYMBOL_GPL(regmap_irq_get_irq_reg_linear);
  * @type: The requested IRQ type.
  * @irq_data: The IRQ being configured.
  * @idx: Index of the irq's config registers within each array `buf[i]`
+ * @irq_drv_data: Driver specific IRQ data
  *
  * This is a &struct regmap_irq_chip->set_type_config callback suitable for
  * chips with one config register. Register values are updated according to
  * the &struct regmap_irq_type data associated with an IRQ.
  */
 int regmap_irq_set_type_config_simple(unsigned int **buf, unsigned int type,
-				      const struct regmap_irq *irq_data, int idx)
+				      const struct regmap_irq *irq_data, int idx,
+				      void *irq_drv_data)
 {
 	const struct regmap_irq_type *t = &irq_data->type;
 
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 8d9d601da782..9b456e841bec 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1651,7 +1651,7 @@ struct regmap_irq_chip {
 	int (*set_type_virt)(unsigned int **buf, unsigned int type,
 			     unsigned long hwirq, int reg);
 	int (*set_type_config)(unsigned int **buf, unsigned int type,
-			       const struct regmap_irq *irq_data, int idx);
+			       const struct regmap_irq *irq_data, int idx, void *irq_drv_data);
 	unsigned int (*get_irq_reg)(struct regmap_irq_chip_data *data,
 				    unsigned int base, int index);
 	void *irq_drv_data;
@@ -1660,7 +1660,8 @@ struct regmap_irq_chip {
 unsigned int regmap_irq_get_irq_reg_linear(struct regmap_irq_chip_data *data,
 					   unsigned int base, int index);
 int regmap_irq_set_type_config_simple(unsigned int **buf, unsigned int type,
-				      const struct regmap_irq *irq_data, int idx);
+				      const struct regmap_irq *irq_data, int idx,
+				      void *irq_drv_data);
 
 int regmap_add_irq_chip(struct regmap *map, int irq, int irq_flags,
 			int irq_base, const struct regmap_irq_chip *chip,
-- 
2.39.2

