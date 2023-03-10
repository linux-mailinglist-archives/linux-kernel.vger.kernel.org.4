Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACDF86B4738
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbjCJOtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbjCJOrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:47:51 -0500
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A1C10D300;
        Fri, 10 Mar 2023 06:47:27 -0800 (PST)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-176b90e14a9so6039149fac.9;
        Fri, 10 Mar 2023 06:47:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7aVJSVz34DokQhgf1apHT5Wo0nZSIGiR/8xWoexMPms=;
        b=nXH27exN38fBDlw1t52X+M/FV97XhF1uXC1IbKen4ozh/Kx3QrJvtOXUIybqRVaT82
         SC6S4TfBC6bCu/k4Uc8G6Htgr4RFOPnJs/5h3QnmQw4BqoDf0Elquqrlg5ALNf6q3SZo
         uVdoTtoeP7Li7rK8gs7FGKDrdNIjuxmj20Rh4Vkkps27dGw+yqJAi5JDSazbZtaROvMI
         VRiwRT37xV3CrEJKEXDQd0CdLbkYjVIy6s9WTRttnMIVbgd8g9Fbex58fUg0NXRQg/af
         n3UWR0JHQPuIeieb5sh996gIeNV2lko8p0Lc2tbcPvtldYpe3psfoca3pjPA+9IAKLjk
         EccQ==
X-Gm-Message-State: AO0yUKVvzzWiJnw2NO71ewwJfynk+S8cqcXH0qmLrbpRUhRNfcLxOf9M
        8hsx1WThwf1Bpa6tU9SkSNRONdA93Q==
X-Google-Smtp-Source: AK7set84O7ae//Tb1w7E3gHghP7sQBZtp+uQINoy8eIKOer9z+iKremPlLiW1Y0HF0q2Mv4q7TXkUw==
X-Received: by 2002:a05:6870:2050:b0:172:832e:2670 with SMTP id l16-20020a056870205000b00172832e2670mr14804596oad.34.1678459644413;
        Fri, 10 Mar 2023 06:47:24 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n22-20020a4ae1d6000000b005253a5cc3cfsm865468oot.29.2023.03.10.06.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:47:23 -0800 (PST)
Received: (nullmailer pid 1543501 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:12 -0000
From:   Rob Herring <robh@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH] mfd: Use of_property_read_bool() for boolean properties
Date:   Fri, 10 Mar 2023 08:47:12 -0600
Message-Id: <20230310144712.1543449-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties.
Convert reading boolean properties to to of_property_read_bool().

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/mfd/88pm860x-core.c |  3 +--
 drivers/mfd/wm8994-core.c   | 19 +++++--------------
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index 6ba7169cb953..581d4d6a785d 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -1117,8 +1117,7 @@ static int pm860x_dt_init(struct device_node *np,
 {
 	int ret;
 
-	if (of_get_property(np, "marvell,88pm860x-irq-read-clr", NULL))
-		pdata->irq_mode = 1;
+	pdata->irq_mode = of_property_read_bool(np, "marvell,88pm860x-irq-read-clr");
 	ret = of_property_read_u32(np, "marvell,88pm860x-slave-addr",
 				   &pdata->companion_addr);
 	if (ret) {
diff --git a/drivers/mfd/wm8994-core.c b/drivers/mfd/wm8994-core.c
index a89221bffde5..c419ab0c0eae 100644
--- a/drivers/mfd/wm8994-core.c
+++ b/drivers/mfd/wm8994-core.c
@@ -279,20 +279,11 @@ static int wm8994_set_pdata_from_of(struct wm8994 *wm8994)
 	of_property_read_u32_array(np, "wlf,micbias-cfg", pdata->micbias,
 				   ARRAY_SIZE(pdata->micbias));
 
-	pdata->lineout1_diff = true;
-	pdata->lineout2_diff = true;
-	if (of_find_property(np, "wlf,lineout1-se", NULL))
-		pdata->lineout1_diff = false;
-	if (of_find_property(np, "wlf,lineout2-se", NULL))
-		pdata->lineout2_diff = false;
-
-	if (of_find_property(np, "wlf,lineout1-feedback", NULL))
-		pdata->lineout1fb = true;
-	if (of_find_property(np, "wlf,lineout2-feedback", NULL))
-		pdata->lineout2fb = true;
-
-	if (of_find_property(np, "wlf,ldoena-always-driven", NULL))
-		pdata->lineout2fb = true;
+	pdata->lineout1_diff = !of_property_read_bool(np, "wlf,lineout1-se");
+	pdata->lineout2_diff = !of_property_read_bool(np, "wlf,lineout2-se");
+	pdata->lineout1fb = of_property_read_bool(np, "wlf,lineout1-feedback");
+	pdata->lineout2fb = of_property_read_bool(np, "wlf,lineout2-feedback") ||
+		of_property_read_bool(np, "wlf,ldoena-always-driven");
 
 	pdata->spkmode_pu = of_property_read_bool(np, "wlf,spkmode-pu");
 
-- 
2.39.2

