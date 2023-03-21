Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9276C32AE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 14:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjCUNW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 09:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjCUNWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 09:22:12 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6FB28D31
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 06:21:49 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id t17-20020a05600c451100b003edc906aeeaso721135wmo.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 06:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679404906;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JVCCrg+cX3A/ZZOueoMy5bBjL6UJS6dXroqCT+2ZBjw=;
        b=wv5YlsFkbhuTRFObWvPFHkjKUsT/E9xt/WGJFtzRT5bjjww73q+Wt5Tn1EuZXPuI0W
         2p3LdgZAz6knrXMCJZNeyrOONMEJMTXT6T1nN4xOavQH0TXSdaaF5riVfSp5w/x5u1f1
         VgKt2OvoAnwrMxPNEutoRbV8cHW4Jv005r6tY4rsLBKBpmoGUSlayYtlhaPlQ3/JjNtg
         txMztxtXPTFY1R9DXD7Zl1GZxU1NeS3Biy8vr42QMXnAL3H1XriyFthlfdZNTKcGyxuX
         x7+ry5x9h2Qfxo0pB2mmg1au5XewywGwDEXPXYueNAakOmx9osPGvYXEdUN9ZfsyQ8aM
         gx/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679404906;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVCCrg+cX3A/ZZOueoMy5bBjL6UJS6dXroqCT+2ZBjw=;
        b=lnClNo1cHG6I51h1ASZtrtnLvK/9Nhhbg7VLwWhDWYzHz8kLGvczliGlWanwrS0fLm
         zVWfpLJzLLZpwhpdhfoyCpjIslF99RvPFRg1JQaRt1MSNjC+4j8G/4UJo7uiJTosYYgW
         XlRtEdAAR7KOjEQW+uPvu68By9ajCOyEMJRAvGLV5j4dEEZ5E6i9N/sGTbHMTnqAmibc
         qAYlx/saKJ0NsjaMgP6TjuAx7IXXvqFb0E5oJk9myPW4n1Vh4Rofwrkdu+TFKh9+JmlT
         p7609lWTG2amO+eaPRtd8/SwXlVxEspaYYfEULYRRkSTeTzdKMQBre+c1X+sYSoiIA7v
         ZfIQ==
X-Gm-Message-State: AO0yUKXvQpVEQALDo86cOXbEdUFTSm+j6Di+UChDU2E5XOkJ+ZpYuWFI
        rOKDjKeRFn/MoBt2RfbCOC36HQ==
X-Google-Smtp-Source: AK7set9XG36FDzM5ga4r3ydCatOch2H5MMqXJc7+5XfEp0MsUsY1ZV4N0NivhhEJZfw69K2nmSR+nQ==
X-Received: by 2002:a1c:4b1a:0:b0:3ed:316d:668d with SMTP id y26-20020a1c4b1a000000b003ed316d668dmr2573327wma.5.1679404906385;
        Tue, 21 Mar 2023 06:21:46 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id v26-20020a05600c215a00b003eafc47eb09sm13393016wml.43.2023.03.21.06.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 06:21:46 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 21 Mar 2023 14:21:44 +0100
Subject: [PATCH v5 04/12] soc: qcom: pmic_glink: register ucsi aux device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230130-topic-sm8450-upstream-pmic-glink-v5-4-552f3b721f9e@linaro.org>
References: <20230130-topic-sm8450-upstream-pmic-glink-v5-0-552f3b721f9e@linaro.org>
In-Reply-To: <20230130-topic-sm8450-upstream-pmic-glink-v5-0-552f3b721f9e@linaro.org>
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

