Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0474626A1C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 16:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbiKLPTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 10:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234864AbiKLPTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 10:19:42 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979F410040
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 07:19:40 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id a11-20020a05600c2d4b00b003cf6f5fd9f1so4884723wmg.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 07:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nD6PwOw6vjJScTTxUIfc/0eVLXeaWOT/pR+rswb6rJg=;
        b=Me8hdm6wyighrirkPUbw9VrQ6dfBl+1O/hpilRSfGYOHE72AVQF1TKd3bTlJ2uYUCB
         A3jEIRs9nskuxmEjbTdCZ4IXAS8k91jE+IJvKk8m7O2j8kPqCioC0v52kotBvRP/05FK
         4MJHdWMZu+rJEwjGoER64r+1nbEQjA5NjwFzYXR4op07cj6uxqGMOmTgss32WdA2zDav
         VE9oVv8zRZt0pIq9jYYJraH1vTTkHWzdZc82mxm9De0lOZwNo5ZKmpq23gHRokZk5Od5
         ccF1HaZbBLE+SYig33M2zUqa12pa4prerFA2OFXO63J2iYzV6gvOUyP1BF3Yem200QkB
         HtKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nD6PwOw6vjJScTTxUIfc/0eVLXeaWOT/pR+rswb6rJg=;
        b=cjKQS8xywzkJvaTdiFKSs5hdgSJ5bJkykhtdgZYeFXVDELUjf5OcxC0ZydyORWnAGx
         Eh4O6IdN2ztOsCg3fRtszlfnVrDGXkWEpOvba5upRfD1J1B3GQ1y6dNICEdRaSMmJZI1
         TsEfswFzt3ZfI8l9KnPKrwH0a/9AMw8bO9ptjdlxIGvcux2dlMq+qyzZVti3eDp/+NVT
         hcEd66u2Wp22mkVwV2oxd0bTuE11klt7eE7v5BWuV6CVfbNpFsLJj5IpwZQ/9+OYruHN
         r0F3DErNYs9FBUcc2f7atcIShTzqCMrQehmrITlrzrT5NZN1iYVWJKCWcAia+hjX+PJo
         g5iQ==
X-Gm-Message-State: ANoB5pmLCP6YdRrDRoe+ZZ1p9sRFoLRTB8uB8BqxKg31QheR4iHvE4/9
        81MBr5MCFgcJ7SotPy6Gu2g=
X-Google-Smtp-Source: AA0mqf48o7lLpkMDzUxOkJUTi4WKlwN9mDAPsmAHUDd47sx4NrNb2/M9KnnO033o3lFPMXn+d2e5IA==
X-Received: by 2002:a05:600c:3b08:b0:3cf:8e62:f748 with SMTP id m8-20020a05600c3b0800b003cf8e62f748mr4000740wms.175.1668266379182;
        Sat, 12 Nov 2022 07:19:39 -0800 (PST)
Received: from localhost (94.197.38.186.threembb.co.uk. [94.197.38.186])
        by smtp.gmail.com with ESMTPSA id x10-20020adff64a000000b00236883f2f5csm4644777wrp.94.2022.11.12.07.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 07:19:38 -0800 (PST)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     lee@kernel.org
Cc:     mani@kernel.org, cristian.ciocaltea@gmail.com, wens@csie.org,
        tharvey@gateworks.com, cw00.choi@samsung.com,
        krzysztof.kozlowski@linaro.org, brgl@bgdev.pl,
        mazziesaccount@gmail.com, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH 03/18] mfd: axp20x: Replace irqchip mask_invert with unmask_base
Date:   Sat, 12 Nov 2022 15:18:20 +0000
Message-Id: <20221112151835.39059-4-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20221112151835.39059-1-aidanmacdonald.0x0@gmail.com>
References: <20221112151835.39059-1-aidanmacdonald.0x0@gmail.com>
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

Remove use of the deprecated mask_invert flag. Inverted mask
registers (where a '1' bit enables an IRQ) can be described more
directly as an unmask register.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/mfd/axp20x.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 88a212a8168c..6e6b5dbab098 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -506,8 +506,7 @@ static const struct regmap_irq_chip axp152_regmap_irq_chip = {
 	.name			= "axp152_irq_chip",
 	.status_base		= AXP152_IRQ1_STATE,
 	.ack_base		= AXP152_IRQ1_STATE,
-	.mask_base		= AXP152_IRQ1_EN,
-	.mask_invert		= true,
+	.unmask_base		= AXP152_IRQ1_EN,
 	.init_ack_masked	= true,
 	.irqs			= axp152_regmap_irqs,
 	.num_irqs		= ARRAY_SIZE(axp152_regmap_irqs),
@@ -518,8 +517,7 @@ static const struct regmap_irq_chip axp20x_regmap_irq_chip = {
 	.name			= "axp20x_irq_chip",
 	.status_base		= AXP20X_IRQ1_STATE,
 	.ack_base		= AXP20X_IRQ1_STATE,
-	.mask_base		= AXP20X_IRQ1_EN,
-	.mask_invert		= true,
+	.unmask_base		= AXP20X_IRQ1_EN,
 	.init_ack_masked	= true,
 	.irqs			= axp20x_regmap_irqs,
 	.num_irqs		= ARRAY_SIZE(axp20x_regmap_irqs),
@@ -531,8 +529,7 @@ static const struct regmap_irq_chip axp22x_regmap_irq_chip = {
 	.name			= "axp22x_irq_chip",
 	.status_base		= AXP20X_IRQ1_STATE,
 	.ack_base		= AXP20X_IRQ1_STATE,
-	.mask_base		= AXP20X_IRQ1_EN,
-	.mask_invert		= true,
+	.unmask_base		= AXP20X_IRQ1_EN,
 	.init_ack_masked	= true,
 	.irqs			= axp22x_regmap_irqs,
 	.num_irqs		= ARRAY_SIZE(axp22x_regmap_irqs),
@@ -543,8 +540,7 @@ static const struct regmap_irq_chip axp288_regmap_irq_chip = {
 	.name			= "axp288_irq_chip",
 	.status_base		= AXP20X_IRQ1_STATE,
 	.ack_base		= AXP20X_IRQ1_STATE,
-	.mask_base		= AXP20X_IRQ1_EN,
-	.mask_invert		= true,
+	.unmask_base		= AXP20X_IRQ1_EN,
 	.init_ack_masked	= true,
 	.irqs			= axp288_regmap_irqs,
 	.num_irqs		= ARRAY_SIZE(axp288_regmap_irqs),
@@ -556,8 +552,7 @@ static const struct regmap_irq_chip axp803_regmap_irq_chip = {
 	.name			= "axp803",
 	.status_base		= AXP20X_IRQ1_STATE,
 	.ack_base		= AXP20X_IRQ1_STATE,
-	.mask_base		= AXP20X_IRQ1_EN,
-	.mask_invert		= true,
+	.unmask_base		= AXP20X_IRQ1_EN,
 	.init_ack_masked	= true,
 	.irqs			= axp803_regmap_irqs,
 	.num_irqs		= ARRAY_SIZE(axp803_regmap_irqs),
@@ -568,8 +563,7 @@ static const struct regmap_irq_chip axp806_regmap_irq_chip = {
 	.name			= "axp806",
 	.status_base		= AXP20X_IRQ1_STATE,
 	.ack_base		= AXP20X_IRQ1_STATE,
-	.mask_base		= AXP20X_IRQ1_EN,
-	.mask_invert		= true,
+	.unmask_base		= AXP20X_IRQ1_EN,
 	.init_ack_masked	= true,
 	.irqs			= axp806_regmap_irqs,
 	.num_irqs		= ARRAY_SIZE(axp806_regmap_irqs),
@@ -580,8 +574,7 @@ static const struct regmap_irq_chip axp809_regmap_irq_chip = {
 	.name			= "axp809",
 	.status_base		= AXP20X_IRQ1_STATE,
 	.ack_base		= AXP20X_IRQ1_STATE,
-	.mask_base		= AXP20X_IRQ1_EN,
-	.mask_invert		= true,
+	.unmask_base		= AXP20X_IRQ1_EN,
 	.init_ack_masked	= true,
 	.irqs			= axp809_regmap_irqs,
 	.num_irqs		= ARRAY_SIZE(axp809_regmap_irqs),
-- 
2.38.1

