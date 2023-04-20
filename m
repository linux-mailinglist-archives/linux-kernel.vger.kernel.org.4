Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C6E6E9C72
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 21:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjDTTYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 15:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbjDTTYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 15:24:38 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0B835BF
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 12:24:32 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f1738d0d4cso6255145e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 12:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1682018671; x=1684610671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7qSJwDSiitY3uCpzZx4l6+eeywWmLBW7PeXm8DLhHc=;
        b=D7k+1CR96+DNx76UiY9T/db8eriT4tmt+8o1MN2Xxy3ozmNQV1fhw+Fpybe+io4ru+
         iGRpNT+weQAG45PiMGDb6+z2gtduBFba0ijcBHdZ6QEurIUoI096+MWXEpVlTSa4gMIV
         5yEQIcjSkazIGb4fVRZFAsXLisZNSIE5ijgsd3J61/hKwzRkt5ulPeIv+Z1G6ElJI20E
         sT1xtLo3prZdoro2Ng7p5zsj6GVo5D4h+YQpXgR+fBm3Lk8cDwVAZsO3ulaonX1mB7WE
         hLG7liDf6vxbS6RluuNJGgGoe2I8e16vEBKGj73YotdV0dZDSVHbR5BzxogxiPclXiqT
         41FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682018671; x=1684610671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7qSJwDSiitY3uCpzZx4l6+eeywWmLBW7PeXm8DLhHc=;
        b=c6iPxI6LnlBsjPhLrq5mK8vNbveIGM7dMbZ6dgsOCQ1D9dsZzdDDLY+ZDMZ/xgNfoV
         FlUSDWn2PdXvmxI+eVUn2caEFAOmJKuPhgro3mjRIoqlOXh3cI3CYilznm86K2w9jWFY
         vogCBwybozbPuTK5FnFFNKxRcDZO0jyQ2/F48Wfq4FYZWbPnHcX8hrDTMfXnRE1Mzfed
         y8vopdA8cseP6cFOSsGQXxKg3Ydh8DtpL7OUfn5fr/lKauvSH/nJFtyvNAaro5Jmhams
         4uOcCwGv4rol71opLgv5eMYWpPtKqh//4mLa2Z+6XSim1dlSXgmpuEDOuSIL7s82LY33
         kydg==
X-Gm-Message-State: AAQBX9cYkHwuy0GGYd4tHkEkXVYjvdNjQKsh3GJ/NdgaxwUUTjx6+m9G
        zSXN10ZaNCU+A+tFXpGNWpVq8A==
X-Google-Smtp-Source: AKy350YfTdvKHCYgM9UYQEgAWX3B/GmEPTTYBKMs4TZ4/XCaxcZgfB/MYGULDp70xn+cEwYyUHmbOw==
X-Received: by 2002:a7b:c8cb:0:b0:3f1:8167:dc30 with SMTP id f11-20020a7bc8cb000000b003f18167dc30mr79981wml.2.1682018671473;
        Thu, 20 Apr 2023 12:24:31 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id u3-20020a7bcb03000000b003f16f3cc9fcsm2825651wmj.9.2023.04.20.12.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 12:24:31 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     zev@bewilderbeest.net, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] regulator: userspace-consumer: Support multiple supplies in DT
Date:   Thu, 20 Apr 2023 21:24:02 +0200
Message-Id: <20230420192402.3695265-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230420192402.3695265-1-Naresh.Solanki@9elements.com>
References: <20230420192402.3695265-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for optional DT property 'regulator-supplies' to handle
connectors with multiple supplies.

If this property is present, it will determine all regulator supplies.
Otherwise, the 'vout' supply will be used as a fallback.

This change improves support for some connector output like PCIe
connectors on mainboards that can be powered by 12V and 3.3V supplies.

Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
...
Change in V2:
- Update commit message
- Code improved to add fallback if the property isn't used.
---
 drivers/regulator/userspace-consumer.c | 33 +++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/userspace-consumer.c b/drivers/regulator/userspace-consumer.c
index 97f075ed68c9..aaa0189d6dab 100644
--- a/drivers/regulator/userspace-consumer.c
+++ b/drivers/regulator/userspace-consumer.c
@@ -120,7 +120,10 @@ static int regulator_userspace_consumer_probe(struct platform_device *pdev)
 	struct regulator_userspace_consumer_data tmpdata;
 	struct regulator_userspace_consumer_data *pdata;
 	struct userspace_consumer_data *drvdata;
-	int ret;
+	struct device_node *np = pdev->dev.of_node;
+	struct property *prop;
+	const char *supply;
+	int ret, count = 0;
 
 	pdata = dev_get_platdata(&pdev->dev);
 	if (!pdata) {
@@ -131,11 +134,29 @@ static int regulator_userspace_consumer_probe(struct platform_device *pdev)
 		memset(pdata, 0, sizeof(*pdata));
 
 		pdata->no_autoswitch = true;
-		pdata->num_supplies = 1;
-		pdata->supplies = devm_kzalloc(&pdev->dev, sizeof(*pdata->supplies), GFP_KERNEL);
-		if (!pdata->supplies)
-			return -ENOMEM;
-		pdata->supplies[0].supply = "vout";
+
+		if (of_find_property(np, "regulator-supplies", NULL)) {
+			pdata->num_supplies = of_property_count_strings(np, "regulator-supplies");
+			if (pdata->num_supplies < 1) {
+				dev_err(&pdev->dev,
+					"could not parse property regulator-supplies\n");
+				return -EINVAL;
+			}
+			pdata->supplies = devm_kzalloc(&pdev->dev, sizeof(*pdata->supplies) *
+						       pdata->num_supplies, GFP_KERNEL);
+			if (!pdata->supplies)
+				return -ENOMEM;
+			of_property_for_each_string(np, "regulator-supplies", prop, supply) {
+				pdata->supplies[count++].supply = supply;
+			}
+		} else {
+			pdata->num_supplies = 1;
+			pdata->supplies = devm_kzalloc(&pdev->dev, sizeof(*pdata->supplies),
+						       GFP_KERNEL);
+			if (!pdata->supplies)
+				return -ENOMEM;
+			pdata->supplies[0].supply = "vout";
+		}
 	}
 
 	if (pdata->num_supplies < 1) {
-- 
2.39.1

