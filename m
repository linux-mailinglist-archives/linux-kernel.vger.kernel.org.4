Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC756AB17D
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 18:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjCERBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 12:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjCERBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 12:01:51 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002EE18A8A
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 09:01:49 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id r16so6666014qtx.9
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 09:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678035709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pbu2j/hdvYLwDjljXyiaLTFTGZ3XlGrjXT3kMpZ8fyw=;
        b=FX5yZysCT8hvFjgBDVlkU54RvcoxYqvX9SNTTlE5cX6MxoQ/mMcBcd0l1i8VCe02kL
         +yevdCxsxKRE8cyMJu/xWdkLU7yg4cbKNz3ZD0Irvd389MsW58xUD3InRzQNF8a/tu/I
         lOJJtrWq+BJ7DJYBr0iIUvYpXPYvMaUfuR7B0qigGdzIennH7HGV/nRJjrTUGs9SirnS
         XD8T9FnJCoditW7sNweko0mw/E5aSwBBgJzjh/4rIoGa1PD8eQ7WgnCvLWPuaGCVU0bh
         kWBWmEmiT1tS+2fOhkMOFqR+xAhFSkwo74lY3Vt2ZN9gurkB05IZOPUYGaFn6r3wJur7
         x/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678035709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pbu2j/hdvYLwDjljXyiaLTFTGZ3XlGrjXT3kMpZ8fyw=;
        b=FVGQXieWdB5mKyERsmpc6NCOAYtt3k8EY93UFuCCDx6QRxHRZvpKn/fmjB9DkXKn8Q
         A8oI2h8kN1OfEI8IwgyhtYK4AJ7j2QmBmihX1EM0BlXmHiMsx7QCiJVzHH+3/ieoOZbL
         a8Whg0u9A3ljjiwLIL5/cnAWB7VwacZx33hICg3/3V8NHD6BH1tfVBE2m6vHOcAAFtLe
         knlwsJh+jR7d+HWNMm+e4/63a4XcMgVylnFqEytj/hNl3jzSRpkEPqDID5hwMIYCEGT7
         +T6fZwlvME9tsUMnRVhPEKLUH/aBWm6csqEQHgOdhE1Wi/IwypfHvdcysk8RwmA+ykqz
         8hJg==
X-Gm-Message-State: AO0yUKWN3ShGPRxD9fqQ63Evvs29RCA89L3yL4imHtJmH7QPuHt9qM5F
        67ibHIqbm9ma2QoI4sojXwKtIA==
X-Google-Smtp-Source: AK7set+Lpxf0++4T6EQrQjElDgnVY4c4IM7oaf0J3IHPxJ4+K5d0AnEniezCJIv3PT/OGmlY5ZBV7w==
X-Received: by 2002:ac8:4e4b:0:b0:3bf:c3e8:c19b with SMTP id e11-20020ac84e4b000000b003bfc3e8c19bmr13793222qtw.22.1678035709084;
        Sun, 05 Mar 2023 09:01:49 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id c6-20020ac81e86000000b003b9bb59543fsm5810423qtm.61.2023.03.05.09.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 09:01:48 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org,
        William Breathitt Gray <william.gray@linaro.org>,
        techsupport@winsystems.com, pdemetrotion@winsystems.com,
        quarium@gmail.com, jhentges@accesio.com, jay.dolan@accesio.com
Subject: [PATCH v3 1/3] regmap: Pass irq_drv_data as a parameter for set_type_config()
Date:   Sun,  5 Mar 2023 12:01:32 -0500
Message-Id: <8c87ef9acd8a0f8b388eeec69704fd74518ed328.1678034378.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1678034378.git.william.gray@linaro.org>
References: <cover.1678034378.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the struct regmap_irq_chip set_type_config() callback to access
irq_drv_data by passing it as a parameter.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
Changes in v3:
 - Drop map from set_type_config() parameter list; regmap can be passed
   by irq_drv_data instead
Changes in v2: none

 drivers/base/regmap/regmap-irq.c | 8 +++++---
 include/linux/regmap.h           | 6 ++++--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index a8f185430a07..9cfcb0b2db5e 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -333,8 +333,8 @@ static int regmap_irq_set_type(struct irq_data *data, unsigned int type)
 	}
 
 	if (d->chip->set_type_config) {
-		ret = d->chip->set_type_config(d->config_buf, type,
-					       irq_data, reg);
+		ret = d->chip->set_type_config(d->config_buf, type, irq_data,
+					       reg, d->chip->irq_drv_data);
 		if (ret)
 			return ret;
 	}
@@ -655,13 +655,15 @@ EXPORT_SYMBOL_GPL(regmap_irq_get_irq_reg_linear);
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
+				      const struct regmap_irq *irq_data,
+				      int idx, void *irq_drv_data)
 {
 	const struct regmap_irq_type *t = &irq_data->type;
 
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index a3bc695bcca0..80497dcc5c45 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1649,7 +1649,8 @@ struct regmap_irq_chip {
 	int (*set_type_virt)(unsigned int **buf, unsigned int type,
 			     unsigned long hwirq, int reg);
 	int (*set_type_config)(unsigned int **buf, unsigned int type,
-			       const struct regmap_irq *irq_data, int idx);
+			       const struct regmap_irq *irq_data, int idx,
+			       void *irq_drv_data);
 	unsigned int (*get_irq_reg)(struct regmap_irq_chip_data *data,
 				    unsigned int base, int index);
 	void *irq_drv_data;
@@ -1658,7 +1659,8 @@ struct regmap_irq_chip {
 unsigned int regmap_irq_get_irq_reg_linear(struct regmap_irq_chip_data *data,
 					   unsigned int base, int index);
 int regmap_irq_set_type_config_simple(unsigned int **buf, unsigned int type,
-				      const struct regmap_irq *irq_data, int idx);
+				      const struct regmap_irq *irq_data,
+				      int idx, void *irq_drv_data);
 
 int regmap_add_irq_chip(struct regmap *map, int irq, int irq_flags,
 			int irq_base, const struct regmap_irq_chip *chip,
-- 
2.39.2

