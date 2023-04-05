Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75ECD6D8252
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238986AbjDEPqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238954AbjDEPp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:45:59 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B81A128
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 08:45:53 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5491fa028adso188213197b3.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 08:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680709552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axdH/v0it2b1vC7hIRs84ELa9wzHL+q3ezelXdx3Fg4=;
        b=d0qCLyoA+EzIG+wF1YdUxsxp6Y0PvEolIvfq6JpBsSQk6IjNRrZYoZbbm7yRN23OvW
         pOvmzBUiIB3dAB4PX2B74mMvmsQZQVFQ+CiR8hIlIEv8EQF5ssJjLAeDYeVMSfEB7SaQ
         9kX6PmmnqcGFgtXqjnEMmSu2xt4qTXOUjRNTLoCnfLJGUnyRFdzy38PQFbtsj/cnpfkD
         CVrof/wteVVNlGYE42QcmCGndqHkV6FG+5CJ1qZ3qTXIRzvsrC9513uikh8Qla41YN8r
         Wecdj9wUnQMoEpCpPnRrrZ5K5/vjhFVKEVmxtS6BBa0nv49zeBvKLmDZkysGzWemQFXf
         bjzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680709552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=axdH/v0it2b1vC7hIRs84ELa9wzHL+q3ezelXdx3Fg4=;
        b=fBSzRs2ILdWhn5hEzUKnZcobzXHaLurf5A+u/T0llf7zguSOANQjqjgYBl2wJSRh4p
         gbf7l/w7VCMn7pK195b8NQv3d64SbCQfmpAhEIM1/1BxiLSgOASfvlzFL0zjuzm/P+XX
         Af40aF1NQMt1ff6dXH1ojSAFaFQqky2NpSLTK8BIzX0Sa+3EG7H8ciSNwichlsvOMLCg
         kZ91qqIm6pPxM1qHAqc1OUVAjRL6qEnhylcu4u5PEfADnVsnTNcIlXQF3nmDcyIVShO9
         6oZhIig1SEnRyx7LdsnvScUP7g1lpM0Cdwiu2eboLGd/XDVBjd8XtIfRtZCbuvkkhHvQ
         becA==
X-Gm-Message-State: AAQBX9fHeG2Cw+DOXCnQgfaU/BW+HXRyrfr+cTm4jIZPZ0NQE7sB/kAB
        hJzQRTgR/bG9mRzN0bpW8lx9eA==
X-Google-Smtp-Source: AKy350YRUhaBtgtCRqZb+LQ4a/bxXp55cU7Ia68zv0z7ceg0VMoQ9g9RHaGwsN65KA79qmW8enfXng==
X-Received: by 2002:a0d:ddd4:0:b0:545:385f:f585 with SMTP id g203-20020a0dddd4000000b00545385ff585mr6184227ywe.28.1680709552232;
        Wed, 05 Apr 2023 08:45:52 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id g80-20020a0ddd53000000b00545a08184b0sm3942619ywe.64.2023.04.05.08.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 08:45:51 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        techsupport@winsystems.com, pdemetrotion@winsystems.com,
        quarium@gmail.com, jhentges@accesio.com, jay.dolan@accesio.com
Subject: [PATCH v6 1/3] regmap: Pass irq_drv_data as a parameter for set_type_config()
Date:   Wed,  5 Apr 2023 11:45:42 -0400
Message-Id: <20e15cd3afae80922b7e0577c7741df86b3390c5.1680708357.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1680708357.git.william.gray@linaro.org>
References: <cover.1680708357.git.william.gray@linaro.org>
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
Changes in v6:
 - Wrap lines to 80 characters rather than 100
Changes in v5:
 - Wrap lines to 100 characters rather than 80
Changes in v4: none
Changes in v3:
 - Drop map from set_type_config() parameter list; regmap can be passed
   by irq_drv_data instead
Changes in v2: none

 drivers/base/regmap/regmap-irq.c | 8 +++++---
 include/linux/regmap.h           | 6 ++++--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index ff6b585b9049..362926d155a4 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -328,8 +328,8 @@ static int regmap_irq_set_type(struct irq_data *data, unsigned int type)
 	}
 
 	if (d->chip->set_type_config) {
-		ret = d->chip->set_type_config(d->config_buf, type,
-					       irq_data, reg);
+		ret = d->chip->set_type_config(d->config_buf, type, irq_data,
+					       reg, d->chip->irq_drv_data);
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
+				      const struct regmap_irq *irq_data,
+				      int idx, void *irq_drv_data)
 {
 	const struct regmap_irq_type *t = &irq_data->type;
 
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 8d9d601da782..18311c12c44a 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1651,7 +1651,8 @@ struct regmap_irq_chip {
 	int (*set_type_virt)(unsigned int **buf, unsigned int type,
 			     unsigned long hwirq, int reg);
 	int (*set_type_config)(unsigned int **buf, unsigned int type,
-			       const struct regmap_irq *irq_data, int idx);
+			       const struct regmap_irq *irq_data, int idx,
+			       void *irq_drv_data);
 	unsigned int (*get_irq_reg)(struct regmap_irq_chip_data *data,
 				    unsigned int base, int index);
 	void *irq_drv_data;
@@ -1660,7 +1661,8 @@ struct regmap_irq_chip {
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

