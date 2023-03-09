Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD676B2553
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 14:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjCIN2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 08:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjCIN2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:28:08 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31222CC74
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 05:28:05 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so3584310wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 05:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678368485;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Me4C4fQFNMtjmgr5s2tA3sC3KLsu8zUaVlmas3j7y04=;
        b=RlmyYzxthCHz1Jnxi41F235xuzMqMoWmaWZKHpnLd+3WL6wf9wp1S6r3eWfeniSe0b
         LlkfrKN49wdF2ueQvwYs6lEkqyGI9BK0mLShrv84f9AaMvQvZGeUumqxNfWN64ldidfI
         6RX0wmO7elvojPkf80qmX7wFVeL7AjH2q/Wfkid0Ia8xBzML3KTS8ALP3hBU1sWsaYPQ
         mzwJOQ1mk6NqGtcKXxBDcgVZ1Sw37kdafde3qLrAVlUIZDNDG6Na1xVDWReGZJH6FUDY
         C0ew/SeC658KSRTzK7AcRt1HX45gBP0QOGBWbd+os4/LXWYkDJgAPt/Tn5T5KFe68nnl
         g/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678368485;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Me4C4fQFNMtjmgr5s2tA3sC3KLsu8zUaVlmas3j7y04=;
        b=0a7z6o2+FbVzoBrgtXvxL3QxoB/7+vE3B7QMLIv/nV/RG3LoeuEUopBi8CYVY2PeHO
         sTOtr03PUNKtNEMlJfJ4SpEYYxUvGZYxQb0OqhCls2QjIJhiITQPRP8pv0gpv5jF/yyT
         9NC+kjnSkhY5uwEIMohUBSjNOMyQ6OPVjRmsNMVt5XEHBGnfDWHd0btJlFpMAeMLz2BZ
         U9+F4eCcNYEV0MLD/NgLuLAE4/1chGMQusU6ptvOnbN1NLTb5kq/m81nKo+SgO6WVCYd
         GrCh+A+jOkoAjZPHlFGpq1r6rBHON/FvgNVZkz0j1tLRxza0PttMTL/Sg4SLlfzcFV6X
         p4bw==
X-Gm-Message-State: AO0yUKXKgcwPQ7dEHFnFGP0AduHa392LtkOa+6wHfGtxUtjH/DWKxU7l
        HTUtPglYuM8LujnyZAP/v+FLrw==
X-Google-Smtp-Source: AK7set9m4WA1Fv+o8/SeCJ7YTQxnXIIwTF6jiza2+3a1RYU8tdchDxaYWiVFu+Uu0A59Xpu5XmqDBA==
X-Received: by 2002:a05:600c:4ec6:b0:3e2:147f:ac16 with SMTP id g6-20020a05600c4ec600b003e2147fac16mr20257953wmq.10.1678368485184;
        Thu, 09 Mar 2023 05:28:05 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c458700b003eb966d39desm2926714wmo.2.2023.03.09.05.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 05:28:04 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 09 Mar 2023 14:27:55 +0100
Subject: [PATCH v3 04/12] soc: qcom: pmic_glink: register ucsi aux device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230130-topic-sm8450-upstream-pmic-glink-v3-4-4c860d265d28@linaro.org>
References: <20230130-topic-sm8450-upstream-pmic-glink-v3-0-4c860d265d28@linaro.org>
In-Reply-To: <20230130-topic-sm8450-upstream-pmic-glink-v3-0-4c860d265d28@linaro.org>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only register UCSI on know working devices, like on the SM8450
or SM8550 which requires UCSI to get USB mode switch events.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/soc/qcom/pmic_glink.c | 63 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 53 insertions(+), 10 deletions(-)

diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
index bb3fb57abcc6..48e015fee8e9 100644
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
+	const struct of_device_id *match;
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
+	match = of_device_get_match_data(&pdev->dev);
+	if (match)
+		pg->client_mask = (unsigned long)match->data;
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
@@ -301,7 +338,13 @@ static int pmic_glink_remove(struct platform_device *pdev)
 	return 0;
 }
 
+/* Do not handle altmode for now on those platforms */
+static const unsigned long pmic_glink_sm8450_client_mask = BIT(PMIC_GLINK_CLIENT_BATT) |
+							   BIT(PMIC_GLINK_CLIENT_UCSI);
+
 static const struct of_device_id pmic_glink_of_match[] = {
+	{ .compatible = "qcom,sm8450-pmic-glink", .data = &pmic_glink_sm8450_client_mask },
+	{ .compatible = "qcom,sm8550-pmic-glink", .data = &pmic_glink_sm8450_client_mask },
 	{ .compatible = "qcom,pmic-glink", },
 	{}
 };

-- 
2.34.1

