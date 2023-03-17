Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28EF6BEC2E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 16:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjCQPEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 11:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjCQPEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 11:04:35 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C4710EA84
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:04:30 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id i9so4727719wrp.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679065468;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JVCCrg+cX3A/ZZOueoMy5bBjL6UJS6dXroqCT+2ZBjw=;
        b=gJRXQbqoyvqjgwCKUleES2udxlxGrjCsHZv0KfpRljEh0xynWPF+eMxRjEhLt7FXMn
         CjL1wbQW07o52UwzyDSx10BSPKLiFuCE9CIEiuMh7bWs3i/i/pzPSsbzp7573b0m2HX+
         TuTp42GhLEfolzGuvzdv+H7zrJNM1Ujt037Uk81W3N9YStUy0OBYANuOwxvKAY94xZsi
         3RLAMFbFQbDe7kZthl5fdPanEFrZe7ucgRM77X/BU29Y8feTxaS5WSo0YUr7zKPU2tED
         6O6/xCeCOJFFEeR1wO/6THBbaMmcoDv828PyyZUKvBQ6INfRwnSMK5g53jpECemZEYYR
         RLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679065468;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVCCrg+cX3A/ZZOueoMy5bBjL6UJS6dXroqCT+2ZBjw=;
        b=LZlnyJxdJ5L1Gj3El2GOtz+FLkKqckvA/NUeEQB8zTNgyS0Ta/HHM/PQMPlz3deaLp
         ooEWpb+HxpPwgqfprGvsKs903EORdeEqR1ZDNa2XcG3UQjhg561tfQJ9NA6H2E5hnqli
         rEo48Ly/KHvJ69E6AbRcYUVFLb2q+vC1fJ9byY0TNnF7VqbO8hUyJ0pPv5/wbwTbGXTb
         FoXrJQGMp8vNWi/4Dw3uiG507paknmeB9al/2dFH8xGshmvEgoo1wZ7xjPBpA/YwLZq/
         zXZR5EH3n+N+M6cuphQHqL/CumdgaPhumRhbjalTIwYBbbXwCSOEswRR68LjbDywPBER
         2R+Q==
X-Gm-Message-State: AO0yUKXQgfb0Gv/uHtZeCXIDx7sW0KyHyO+3GQsVq007j9AFIJvUPzu+
        zaFnvd/KrZVsdOSXcjYD9Upnew==
X-Google-Smtp-Source: AK7set9wlW5nBDmjNFvSZz03pq56IeFoP9t4mBgAQEnmSx7EgtxUSg6FiOkkD18wnC46wPwVRn1EFw==
X-Received: by 2002:a5d:50cf:0:b0:2d1:14fa:8048 with SMTP id f15-20020a5d50cf000000b002d114fa8048mr6204251wrt.39.1679065468589;
        Fri, 17 Mar 2023 08:04:28 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id q14-20020a05600000ce00b002be505ab59asm2133773wrx.97.2023.03.17.08.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 08:04:28 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 17 Mar 2023 16:04:20 +0100
Subject: [PATCH v4 04/12] soc: qcom: pmic_glink: register ucsi aux device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230130-topic-sm8450-upstream-pmic-glink-v4-4-38bf0f5d07bd@linaro.org>
References: <20230130-topic-sm8450-upstream-pmic-glink-v4-0-38bf0f5d07bd@linaro.org>
In-Reply-To: <20230130-topic-sm8450-upstream-pmic-glink-v4-0-38bf0f5d07bd@linaro.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only register UCSI on know working devices, like on the SM8450
or SM8550 which requires UCSI to get USB mode switch events.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/soc/qcom/pmic_glink.c | 65 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 54 insertions(+), 11 deletions(-)

diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
index bb3fb57abcc6..8bf95df0a56a 100644
--- a/drivers/soc/qcom/pmic_glink.c
+++ b/drivers/soc/qcom/pmic_glink.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2022, Linaro Ltd
  */
 #include <linux/auxiliary_bus.h>
+#include <linux/of_device.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/rpmsg.h>
@@ -11,12 +12,23 @@
 #include <linux/soc/qcom/pdr.h>
 #include <linux/soc/qcom/pmic_glink.h>
 
+enum {
+	PMIC_GLINK_CLIENT_BATT = 0,
+	PMIC_GLINK_CLIENT_ALTMODE,
+	PMIC_GLINK_CLIENT_UCSI,
+};
+
+#define PMIC_GLINK_CLIENT_DEFAULT	(BIT(PMIC_GLINK_CLIENT_BATT) |	\
+					 BIT(PMIC_GLINK_CLIENT_ALTMODE))
+
 struct pmic_glink {
 	struct device *dev;
 	struct pdr_handle *pdr;
 
 	struct rpmsg_endpoint *ept;
 
+	unsigned long client_mask;
+
 	struct auxiliary_device altmode_aux;
 	struct auxiliary_device ps_aux;
 	struct auxiliary_device ucsi_aux;
@@ -233,6 +245,7 @@ static struct rpmsg_driver pmic_glink_rpmsg_driver = {
 
 static int pmic_glink_probe(struct platform_device *pdev)
 {
+	const unsigned long *match_data;
 	struct pdr_service *service;
 	struct pmic_glink *pg;
 	int ret;
@@ -249,12 +262,27 @@ static int pmic_glink_probe(struct platform_device *pdev)
 	mutex_init(&pg->client_lock);
 	mutex_init(&pg->state_lock);
 
-	ret = pmic_glink_add_aux_device(pg, &pg->altmode_aux, "altmode");
-	if (ret)
-		return ret;
-	ret = pmic_glink_add_aux_device(pg, &pg->ps_aux, "power-supply");
-	if (ret)
-		goto out_release_altmode_aux;
+	match_data = (unsigned long *)of_device_get_match_data(&pdev->dev);
+	if (match_data)
+		pg->client_mask = *match_data;
+	else
+		pg->client_mask = PMIC_GLINK_CLIENT_DEFAULT;
+
+	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_UCSI)) {
+		ret = pmic_glink_add_aux_device(pg, &pg->ucsi_aux, "ucsi");
+		if (ret)
+			return ret;
+	}
+	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_ALTMODE)) {
+		ret = pmic_glink_add_aux_device(pg, &pg->altmode_aux, "altmode");
+		if (ret)
+			goto out_release_ucsi_aux;
+	}
+	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_BATT)) {
+		ret = pmic_glink_add_aux_device(pg, &pg->ps_aux, "power-supply");
+		if (ret)
+			goto out_release_altmode_aux;
+	}
 
 	pg->pdr = pdr_handle_alloc(pmic_glink_pdr_callback, pg);
 	if (IS_ERR(pg->pdr)) {
@@ -278,9 +306,14 @@ static int pmic_glink_probe(struct platform_device *pdev)
 out_release_pdr_handle:
 	pdr_handle_release(pg->pdr);
 out_release_aux_devices:
-	pmic_glink_del_aux_device(pg, &pg->ps_aux);
+	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_BATT))
+		pmic_glink_del_aux_device(pg, &pg->ps_aux);
 out_release_altmode_aux:
-	pmic_glink_del_aux_device(pg, &pg->altmode_aux);
+	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_ALTMODE))
+		pmic_glink_del_aux_device(pg, &pg->altmode_aux);
+out_release_ucsi_aux:
+	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_UCSI))
+		pmic_glink_del_aux_device(pg, &pg->ucsi_aux);
 
 	return ret;
 }
@@ -291,8 +324,12 @@ static int pmic_glink_remove(struct platform_device *pdev)
 
 	pdr_handle_release(pg->pdr);
 
-	pmic_glink_del_aux_device(pg, &pg->ps_aux);
-	pmic_glink_del_aux_device(pg, &pg->altmode_aux);
+	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_BATT))
+		pmic_glink_del_aux_device(pg, &pg->ps_aux);
+	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_ALTMODE))
+		pmic_glink_del_aux_device(pg, &pg->altmode_aux);
+	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_UCSI))
+		pmic_glink_del_aux_device(pg, &pg->ucsi_aux);
 
 	mutex_lock(&__pmic_glink_lock);
 	__pmic_glink = NULL;
@@ -301,8 +338,14 @@ static int pmic_glink_remove(struct platform_device *pdev)
 	return 0;
 }
 
+/* Do not handle altmode for now on those platforms */
+static const unsigned long pmic_glink_sm8450_client_mask = BIT(PMIC_GLINK_CLIENT_BATT) |
+							   BIT(PMIC_GLINK_CLIENT_UCSI);
+
 static const struct of_device_id pmic_glink_of_match[] = {
-	{ .compatible = "qcom,pmic-glink", },
+	{ .compatible = "qcom,sm8450-pmic-glink", .data = &pmic_glink_sm8450_client_mask },
+	{ .compatible = "qcom,sm8550-pmic-glink", .data = &pmic_glink_sm8450_client_mask },
+	{ .compatible = "qcom,pmic-glink" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, pmic_glink_of_match);

-- 
2.34.1

