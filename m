Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F786B475C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbjCJOuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbjCJOtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:49:00 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016AD1223B1;
        Fri, 10 Mar 2023 06:47:41 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id bm20so4397974oib.7;
        Fri, 10 Mar 2023 06:47:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lRN0jAfi5iqcqL3ePabHiQPwHcWvAmjJJvRbEXcLzU0=;
        b=QdYeEeXohwb6sBoUkcnoahw9f2B2U6eRrL9r8vN1cF/H+bBRbiCEIHu8KZmUeTd/gk
         gZwjHg04TBrhkv0sDnQ1L5ZrSh4OGNXLcGDExHKjyRZ9uwU2A+Wgn9Wfmp0upyYXHpM1
         oNvEViEpq+YBKmZNJ3+AjsmxHARfxiHRct2Z8i6Rx1BaIuMWxCPKxv+rPld3vWl3S+Sp
         kp8+VS+P8vfdE/JziVgPS5AjrEi3ne9HHg1pR3yIWEpTwlI0pjfHSeTR9ZZEH85qiqNv
         V9AYaEAj17cgvevkcNl5WbhFSjzJcBOvJeydwbMX35wdyArVb8WT9ZEDX0/lHoiW8taB
         kdgw==
X-Gm-Message-State: AO0yUKUBDA+/75U/OIIT+kQXUsMtiWMtwGvw6Nbgke74QANcHeD1MOOQ
        srA4pCG2dgBcnPnniLkDZw==
X-Google-Smtp-Source: AK7set8NyE9pelZcNVRqymxGqcdHaorNLGYGKwkwEPG5NWZLihqksz6QnJRuEAnZN8WQX6FSLVz58g==
X-Received: by 2002:a05:6808:2805:b0:37a:f32f:730c with SMTP id et5-20020a056808280500b0037af32f730cmr10660264oib.35.1678459660802;
        Fri, 10 Mar 2023 06:47:40 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y63-20020aca3242000000b00383eaea5e88sm953962oiy.38.2023.03.10.06.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:47:40 -0800 (PST)
Received: (nullmailer pid 1543406 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:12 -0000
From:   Rob Herring <robh@kernel.org>
To:     Lee Jones <lee@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] mfd: Use of_property_present() for testing DT property presence
Date:   Fri, 10 Mar 2023 08:47:12 -0600
Message-Id: <20230310144712.1543379-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties. As
part of this, convert of_get_property/of_find_property calls to the
recently added of_property_present() helper when we just want to test
for presence of a property and nothing more.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/mfd/bcm2835-pm.c | 2 +-
 drivers/mfd/khadas-mcu.c | 2 +-
 drivers/mfd/stmpe.c      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/bcm2835-pm.c b/drivers/mfd/bcm2835-pm.c
index 49cd1f03884a..aa1263d22249 100644
--- a/drivers/mfd/bcm2835-pm.c
+++ b/drivers/mfd/bcm2835-pm.c
@@ -28,7 +28,7 @@ static const struct mfd_cell bcm2835_power_devs[] = {
 static int bcm2835_pm_get_pdata(struct platform_device *pdev,
 				struct bcm2835_pm *pm)
 {
-	if (of_find_property(pm->dev->of_node, "reg-names", NULL)) {
+	if (of_property_present(pm->dev->of_node, "reg-names")) {
 		struct resource *res;
 
 		pm->base = devm_platform_ioremap_resource_byname(pdev, "pm");
diff --git a/drivers/mfd/khadas-mcu.c b/drivers/mfd/khadas-mcu.c
index 7338cc16f327..1c807c0e6d25 100644
--- a/drivers/mfd/khadas-mcu.c
+++ b/drivers/mfd/khadas-mcu.c
@@ -112,7 +112,7 @@ static int khadas_mcu_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	if (of_find_property(dev->of_node, "#cooling-cells", NULL))
+	if (of_property_present(dev->of_node, "#cooling-cells"))
 		return devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
 					    khadas_mcu_fan_cells,
 					    ARRAY_SIZE(khadas_mcu_fan_cells),
diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
index c304d20bb988..a92301dfc712 100644
--- a/drivers/mfd/stmpe.c
+++ b/drivers/mfd/stmpe.c
@@ -1378,7 +1378,7 @@ int stmpe_probe(struct stmpe_client_info *ci, enum stmpe_partnum partnum)
 
 	stmpe_of_probe(pdata, np);
 
-	if (of_find_property(np, "interrupts", NULL) == NULL)
+	if (!of_property_present(np, "interrupts"))
 		ci->irq = -1;
 
 	stmpe = devm_kzalloc(ci->dev, sizeof(struct stmpe), GFP_KERNEL);
-- 
2.39.2

