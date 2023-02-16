Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D06699FAD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 23:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjBPWWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 17:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjBPWWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 17:22:48 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6D24C3F4;
        Thu, 16 Feb 2023 14:22:47 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id r25so205362wrr.5;
        Thu, 16 Feb 2023 14:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+TRGyUkANFG/SzjJ0lbiLz+Z2ORFm0iM0jvwJBSduI=;
        b=dswPiC+U9PBL72bD2C+u0izfDhYpogqVWUTWAOam4Ha00rv9pGCv3vj+fBk0uEiozR
         Y5Q/E6rJ6Dz/xcnG5S1U6HDQ2+SQ70dRfPyXFszsI8VZl4Sva6/7jEwhi7ZXXAeWV3Yb
         3UDM8OVCsM0dU4ckgPX0IBBzWACr4SgLH6UmqtCGbQleIq2kII5SHxIHgsB/KPbkBIlV
         mRuXf25PJQWdU4ZEBlLn78Hk8D7BmZD6ACg9rjW0HsCCn3MN2oz83xiQ1Lclhv3+1ado
         9Zma7EsDtd3wq6LW59Oj8X48zG0VMFC14oqTOx/p4Wc4e/pnGO8EFNa1Td1th7f8HOku
         sNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+TRGyUkANFG/SzjJ0lbiLz+Z2ORFm0iM0jvwJBSduI=;
        b=OKFE1/H1pXvbpg07ljSWCpIylFKVotcNLyn9vIM2XppQABFzZDq4NYtb1FFPKQsKpL
         0z3Tpt1EP+0k9mbHNFJOiJqKfnGfIdtvvXaChNt59OGggDeHRalcXlXxrO9Do8YQ0gbW
         KH6lPquCR6LHspcB7sizSLIWR1yZxIGZNOlcoTU9BDZY8NZ/N623ljnyETrC3GFuGAmZ
         fj3AoEBn4Sk1tLO8kxSiz9OlutuvThAsQ4qK2mjGIqIbOStz1CY5P00udGpEtdgY25EJ
         tMsclL8k2l4WOpL9BLJn14ZEfLQeKCek27zdT/BzlEesRLkBJGvs4KN1czgODpSNDRWG
         A1Pg==
X-Gm-Message-State: AO0yUKUMh9f5qRabTXGlHmgxqkalIHUhtLvMMrDkwA4n0pNFogB3D1jj
        2caMVN6TQg4E46PvB601i44=
X-Google-Smtp-Source: AK7set8CayRU/sR7tImdGcDOqjGJXPlySxe3xD4vFX4LrUmeT+RN+68CZxwjDh7xuW2SwJxLVsKOYw==
X-Received: by 2002:a5d:43d1:0:b0:2c5:3d1c:efd8 with SMTP id v17-20020a5d43d1000000b002c53d1cefd8mr6008378wrr.63.1676586165505;
        Thu, 16 Feb 2023 14:22:45 -0800 (PST)
Received: from localhost (94.197.187.145.threembb.co.uk. [94.197.187.145])
        by smtp.gmail.com with ESMTPSA id q9-20020a1ce909000000b003e00c453447sm5935410wmc.48.2023.02.16.14.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 14:22:45 -0800 (PST)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, lee@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/4] mfd: qcom-pm8008: Remove workaround for a regmap-irq quirk
Date:   Thu, 16 Feb 2023 22:22:14 +0000
Message-Id: <20230216222214.138671-5-aidanmacdonald.0x0@gmail.com>
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

Remove pm8008_init(), which according to the comments exists only
as a workaround for regmap-irq's odd treatment of type registers.
This workaround shouldn't be needed anymore because this driver
uses config registers, which are always programmed by regmap-irq
no matter what the initial register state is.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/mfd/qcom-pm8008.c | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
index 4bcdf0e50c40..a33fbc42ac8e 100644
--- a/drivers/mfd/qcom-pm8008.c
+++ b/drivers/mfd/qcom-pm8008.c
@@ -142,30 +142,6 @@ static struct regmap_config qcom_mfd_regmap_cfg = {
 	.max_register	= 0xFFFF,
 };
 
-static int pm8008_init(struct regmap *regmap)
-{
-	int rc;
-
-	/*
-	 * Set TEMP_ALARM peripheral's TYPE so that the regmap-irq framework
-	 * reads this as the default value instead of zero, the HW default.
-	 * This is required to enable the writing of TYPE registers in
-	 * regmap_irq_sync_unlock().
-	 */
-	rc = regmap_write(regmap, (PM8008_TEMP_ALARM_ADDR | INT_SET_TYPE_OFFSET), BIT(0));
-	if (rc)
-		return rc;
-
-	/* Do the same for GPIO1 and GPIO2 peripherals */
-	rc = regmap_write(regmap, (PM8008_GPIO1_ADDR | INT_SET_TYPE_OFFSET), BIT(0));
-	if (rc)
-		return rc;
-
-	rc = regmap_write(regmap, (PM8008_GPIO2_ADDR | INT_SET_TYPE_OFFSET), BIT(0));
-
-	return rc;
-}
-
 static int pm8008_probe_irq_peripherals(struct device *dev,
 					struct regmap *regmap,
 					int client_irq)
@@ -174,12 +150,6 @@ static int pm8008_probe_irq_peripherals(struct device *dev,
 	struct regmap_irq_type *type;
 	struct regmap_irq_chip_data *irq_data;
 
-	rc = pm8008_init(regmap);
-	if (rc) {
-		dev_err(dev, "Init failed: %d\n", rc);
-		return rc;
-	}
-
 	for (i = 0; i < ARRAY_SIZE(pm8008_irqs); i++) {
 		type = &pm8008_irqs[i].type;
 
-- 
2.39.2

