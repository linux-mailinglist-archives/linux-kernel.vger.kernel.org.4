Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF43699FAC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 23:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjBPWWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 17:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjBPWWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 17:22:47 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75354DE3D;
        Thu, 16 Feb 2023 14:22:45 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id s13-20020a05600c45cd00b003ddca7a2bcbso2870053wmo.3;
        Thu, 16 Feb 2023 14:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pp58CIBG02KXGk1txeBbKf4zNNPlRPTq+Ixgxzw1mRw=;
        b=jfkRFZt6bRlU1H9VKgxP0Okjuym44rOMXLgWUzzvfrw2yGLTzSZ8eHs93ObsPCO1B8
         RsXiuOt3qOOIi2KMun15zawR5BAUzcyFqLrrN1sY3WsycauEsopKkqGrhXlj5hY7zwzN
         5VwUCFpCqP/oMk1a0be75dedxsxB71eXewNID/48j/cQuQAHSI3tVhvD+5FaDmzWSPZ8
         REaPZHCQSfKRbCJ804fFHwi03EpWUDdOn0x9lcVMMpsh87UhrLKN7Cz8FW49tOE5ieSd
         xjBVEkBS44HC9suY6i0mVOdemi5BNirzJh084aTEhVOFoY5cb3+keFQV/ETHGilblNb4
         8hpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pp58CIBG02KXGk1txeBbKf4zNNPlRPTq+Ixgxzw1mRw=;
        b=EoGjZKEuUh4/hlwDznO7TW9FfBtcfoYatNjpm/kNzR950Yd7sU3Rr+6sUTE5371A8g
         s028b3w2LxwLJGh+adlplWoY85XISx+e0ePBnKZciJSzBsuJlxKFGhHa4cQjUrQgx6it
         rGPRoO//rPzsq5aznC78jNttO4B5IetkVzcwmS3Vfv0pZDGye6VBbRcGmdyenwea0udN
         GMRunqCP7RSBD2z1NsTgAMp/j82zVu/SQf6ZpHNCjGUonfsz5F660piaIGyhzBr4mQto
         HbglHlrCG0X+mJduWtUrDLpAbsd0ycY60E0eWUcnm+hjSh6nh70D900AHuoyVxFSS00E
         Ymjw==
X-Gm-Message-State: AO0yUKU/oj7Hsx68zvwyGWsLnsMvUIrGbhUNpgzG+GWowEaVU2EQdE2H
        9tKSBOC/l/669sryL/vmA1Q=
X-Google-Smtp-Source: AK7set+Qhk6bABAxPel04wKMvkovGmILHYpkyLGIhfIKcf5OkxvtiiY9T0HFyQsttPEStullc85MCA==
X-Received: by 2002:a05:600c:2b0f:b0:3cf:85f7:bbc4 with SMTP id y15-20020a05600c2b0f00b003cf85f7bbc4mr5687718wme.2.1676586164331;
        Thu, 16 Feb 2023 14:22:44 -0800 (PST)
Received: from localhost (94.197.187.145.threembb.co.uk. [94.197.187.145])
        by smtp.gmail.com with ESMTPSA id t15-20020a1c770f000000b003dc3f195abesm2894346wmi.39.2023.02.16.14.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 14:22:44 -0800 (PST)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, lee@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/4] mfd: qcom-pm8008: Use .get_irq_reg() for irq chip
Date:   Thu, 16 Feb 2023 22:22:13 +0000
Message-Id: <20230216222214.138671-4-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20230216222214.138671-1-aidanmacdonald.0x0@gmail.com>
References: <20230216222214.138671-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the deprecated not_fixed_stride flag and the associated
hierarchy of offsets with a .get_irq_reg() callback.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/mfd/qcom-pm8008.c | 56 +++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 31 deletions(-)

diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
index 2b6763605cd7..4bcdf0e50c40 100644
--- a/drivers/mfd/qcom-pm8008.c
+++ b/drivers/mfd/qcom-pm8008.c
@@ -44,28 +44,6 @@ enum {
 #define PM8008_GPIO1_ADDR	PM8008_PERIPH_2_BASE
 #define PM8008_GPIO2_ADDR	PM8008_PERIPH_3_BASE
 
-#define PM8008_STATUS_BASE	(PM8008_PERIPH_0_BASE | INT_LATCHED_STS_OFFSET)
-#define PM8008_MASK_BASE	(PM8008_PERIPH_0_BASE | INT_EN_CLR_OFFSET)
-#define PM8008_UNMASK_BASE	(PM8008_PERIPH_0_BASE | INT_EN_SET_OFFSET)
-#define PM8008_TYPE_BASE	(PM8008_PERIPH_0_BASE | INT_SET_TYPE_OFFSET)
-#define PM8008_ACK_BASE		(PM8008_PERIPH_0_BASE | INT_LATCHED_CLR_OFFSET)
-#define PM8008_POLARITY_HI_BASE	(PM8008_PERIPH_0_BASE | INT_POL_HIGH_OFFSET)
-#define PM8008_POLARITY_LO_BASE	(PM8008_PERIPH_0_BASE | INT_POL_LOW_OFFSET)
-
-#define PM8008_PERIPH_OFFSET(paddr)	(paddr - PM8008_PERIPH_0_BASE)
-
-static unsigned int p0_offs[] = {PM8008_PERIPH_OFFSET(PM8008_PERIPH_0_BASE)};
-static unsigned int p1_offs[] = {PM8008_PERIPH_OFFSET(PM8008_PERIPH_1_BASE)};
-static unsigned int p2_offs[] = {PM8008_PERIPH_OFFSET(PM8008_PERIPH_2_BASE)};
-static unsigned int p3_offs[] = {PM8008_PERIPH_OFFSET(PM8008_PERIPH_3_BASE)};
-
-static struct regmap_irq_sub_irq_map pm8008_sub_reg_offsets[] = {
-	REGMAP_IRQ_MAIN_REG_OFFSET(p0_offs),
-	REGMAP_IRQ_MAIN_REG_OFFSET(p1_offs),
-	REGMAP_IRQ_MAIN_REG_OFFSET(p2_offs),
-	REGMAP_IRQ_MAIN_REG_OFFSET(p3_offs),
-};
-
 enum {
 	SET_TYPE_INDEX,
 	POLARITY_HI_INDEX,
@@ -73,9 +51,9 @@ enum {
 };
 
 static unsigned int pm8008_config_regs[] = {
-	PM8008_TYPE_BASE,
-	PM8008_POLARITY_HI_BASE,
-	PM8008_POLARITY_LO_BASE,
+	INT_SET_TYPE_OFFSET,
+	INT_POL_HIGH_OFFSET,
+	INT_POL_LOW_OFFSET,
 };
 
 static struct regmap_irq pm8008_irqs[] = {
@@ -89,6 +67,23 @@ static struct regmap_irq pm8008_irqs[] = {
 	REGMAP_IRQ_REG(PM8008_IRQ_GPIO2,	PM8008_GPIO2,	BIT(0)),
 };
 
+static const unsigned int pm8008_periph_base[] = {
+	PM8008_PERIPH_0_BASE,
+	PM8008_PERIPH_1_BASE,
+	PM8008_PERIPH_2_BASE,
+	PM8008_PERIPH_3_BASE,
+};
+
+static unsigned int pm8008_get_irq_reg(struct regmap_irq_chip_data *data,
+				       unsigned int base, int index)
+{
+	/* Simple linear addressing for the main status register */
+	if (base == I2C_INTR_STATUS_BASE)
+		return base + index;
+
+	return pm8008_periph_base[index] + base;
+}
+
 static int pm8008_set_type_config(unsigned int **buf, unsigned int type,
 				  const struct regmap_irq *irq_data, int idx)
 {
@@ -129,17 +124,16 @@ static struct regmap_irq_chip pm8008_irq_chip = {
 	.irqs			= pm8008_irqs,
 	.num_irqs		= ARRAY_SIZE(pm8008_irqs),
 	.num_regs		= PM8008_NUM_PERIPHS,
-	.not_fixed_stride	= true,
-	.sub_reg_offsets	= pm8008_sub_reg_offsets,
-	.status_base		= PM8008_STATUS_BASE,
-	.mask_base		= PM8008_MASK_BASE,
-	.unmask_base		= PM8008_UNMASK_BASE,
+	.status_base		= INT_LATCHED_STS_OFFSET,
+	.mask_base		= INT_EN_CLR_OFFSET,
+	.unmask_base		= INT_EN_SET_OFFSET,
 	.mask_unmask_non_inverted = true,
-	.ack_base		= PM8008_ACK_BASE,
+	.ack_base		= INT_LATCHED_CLR_OFFSET,
 	.config_base		= pm8008_config_regs,
 	.num_config_bases	= ARRAY_SIZE(pm8008_config_regs),
 	.num_config_regs	= PM8008_NUM_PERIPHS,
 	.set_type_config	= pm8008_set_type_config,
+	.get_irq_reg		= pm8008_get_irq_reg,
 };
 
 static struct regmap_config qcom_mfd_regmap_cfg = {
-- 
2.39.2

