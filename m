Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A0D6A5F1D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 19:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjB1S7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 13:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjB1S7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 13:59:35 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D86D23C7E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 10:59:34 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id s12so11678194qtq.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 10:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677610773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sX20DEMdu8oJSjxsT7K1yEeUfPB2hQE61Iu5WYRBoz0=;
        b=K9+YB34Uhyz2pGcyEgqOsYT85XtBc5vhvSAz/jlUXM6mglmYvkXWzsUrfTcbXmxTIu
         MFjE+SPphPmE728Vqdj86KIRA5NZ46pW5KJ+rq/LJ9Ag/NXFDNsE4Ile2voRai6YBcqh
         uluR9kTwB72XIyt2GZUAI0U6ZA2T1cR6VcQNAGJKz8AyO0AlSFn1T4wl/cRVK/Vdg9oA
         pYysVNOUYX+mjM/GkUrBlYXR90I1b80ZNOUpSDdFbSua1Hppcy0evSWIervWRh+kaYNq
         pvJ8KI3VheM3K/rCJiPGwRyr/JkV2ezMxqwodkyAfScG/FGDYNEEv2mk2u7e4uQeSMJu
         0IRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677610773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sX20DEMdu8oJSjxsT7K1yEeUfPB2hQE61Iu5WYRBoz0=;
        b=sP2pJtxdH5BvEn3aPvgsf9drWMCiPA1tQW5I0d330DCS8KGi4idxQsPwx8t5ZyC4NF
         3QM9txMLsdxcrmQ0NFWujHlaaZmSV0CoCPcWn/02feXq8E0l46KW0CFE8lXMny6E7Lt2
         EmGg0UqJAgIML0e/Rlgt0vF9owQqWshJ7hMmufUoY6j3pX01DPl9JckDWnCufYUn5bPo
         I5ljUu4dp6JX8R68JrjRRGZAtgvHCxi1DkO/o5WTg1oC9aGCw+VwWxgmjcmknZxyhVtB
         GaOPNt3VaHKOWIcMK/6gnvqdNqaoftJos9HF15mdJqKMdNfzXHDtyexp4xr3ZMrKYTj0
         9ybg==
X-Gm-Message-State: AO0yUKX7qHHoZKl0TRcIIa05pyrMSZzi+Dqkylt23E+6/wk/P/xtS/kj
        ZyEEnUVowqFq2xs3n6Z9o2zhSg==
X-Google-Smtp-Source: AK7set/kM0f7kednRF2IBdvHSHI0MGIzLNfZlhh+8jCQELzQiajQ9FkWbJ4tD1PYJGKa7deLSdhNAg==
X-Received: by 2002:a05:622a:1a92:b0:3bf:ca4f:9c4c with SMTP id s18-20020a05622a1a9200b003bfca4f9c4cmr6966372qtc.56.1677610773584;
        Tue, 28 Feb 2023 10:59:33 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id e22-20020ac84b56000000b003b646123691sm6905181qts.31.2023.02.28.10.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 10:59:33 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     broonie@kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael@walle.cc, quarium@gmail.com,
        jhentges@accesio.com, jay.dolan@accesio.com,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 1/3] regmap: Pass regmap and irq_drv_data as parameters for set_type_config()
Date:   Mon, 27 Feb 2023 20:53:40 -0500
Message-Id: <c94de04b84d66b9686e26cb7653ae360f3075ede.1677547393.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1677547393.git.william.gray@linaro.org>
References: <cover.1677547393.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
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

