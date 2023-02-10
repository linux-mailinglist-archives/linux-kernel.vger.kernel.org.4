Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE47C692172
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjBJPCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbjBJPCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:02:25 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C2170719
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:02:14 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id bg26so4067361wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HyBwev6TUNJBaFlgSQKpbSDpQdJ67+HQlt1JHFyKM8E=;
        b=ZhQwBvVr31axX1u6bvh4QjPOYry9aOO0HyB7Tx+NvVdNjlMrzITLF58Yh0CPMnJnRC
         /K2m7vrKdiKfkb/ez2/B2ItAXAra98FCMz/hq59KZL6HAo79BY49JIDN0omIG+3YXId6
         dTjPq4I+MDtRIWHq+jNsEifxVJpKLD0HjqARHFBCPnx147QdbBFiWy0b65/p5t5Ye65n
         rZAjj9oanhLUDqrvbVwckE4NZumF9q6vSockqOuM897Qwx+93YIbprdr2B+/U0YAudQn
         peWw/YVv+F/0UmxQKx2P+QsHcafN5x4X6A5h/8DduRURHp3B02RttUr5R7xkCYAJ8stw
         p5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HyBwev6TUNJBaFlgSQKpbSDpQdJ67+HQlt1JHFyKM8E=;
        b=TitFuuR4yHxNsXNJxCnfl7cQ/uBRnonbdCx3yL8lIzslq1Ev9IcLBEltf6hdrpyQx3
         T3OLSlYBUlqVpvH7/Fd1ZWnHZISpZq1oAKi3yHR8p/MXEx5H2fIITn0k19NMe/ta1Kbn
         cb4wnz5MBVnJbyFVrRbD7xgWrWBnY3k+7uoBTbJsKTAGkN3I047fUF+A/XdMUgLJJD+A
         0uueOB8QFyYVWn3xb6q3XDc+RqNv6dzwby/dLVkeyNkAN1ycLAgK6BE1v+X2JiGELzc5
         30Q7SVyQDkmh6Fa+WOCp8aJMecbPYPla3LcJu0jBmZuqJm5EY8b/GAXuT0HftA0Q24Fg
         Of8Q==
X-Gm-Message-State: AO0yUKUixS0cnl6dECQZD3tUz3BPxfTT1eY9uxusgbP+iO+aNiqnb8uo
        4PXPmaTStcMGpM3xYwxqrYvDLg==
X-Google-Smtp-Source: AK7set9+XFOOw9Fq2Z3NhuNViDElqkS7y9kcIwC2v5TUA9spswWN9f7o06VwS6NwwTs+cmD6wy/lhw==
X-Received: by 2002:a05:600c:4384:b0:3d9:ef72:190d with SMTP id e4-20020a05600c438400b003d9ef72190dmr13122930wmn.19.1676041333361;
        Fri, 10 Feb 2023 07:02:13 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id w23-20020a1cf617000000b003db1d9553e7sm8282482wmc.32.2023.02.10.07.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 07:02:12 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 10 Feb 2023 16:02:07 +0100
Subject: [PATCH v2 04/11] soc: qcom: pmic_glink: register ucsi aux device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230130-topic-sm8450-upstream-pmic-glink-v2-4-71fea256474f@linaro.org>
References: <20230130-topic-sm8450-upstream-pmic-glink-v2-0-71fea256474f@linaro.org>
In-Reply-To: <20230130-topic-sm8450-upstream-pmic-glink-v2-0-71fea256474f@linaro.org>
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
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only register UCSI on know working devices, like on the SM8450
or Sm8550 which requires UCSI to get USB mode switch events.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/soc/qcom/pmic_glink.c | 67 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 57 insertions(+), 10 deletions(-)

diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
index bb3fb57abcc6..c7f091f4a8c1 100644
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
 
+	unsigned int client_mask;
+
 	struct auxiliary_device altmode_aux;
 	struct auxiliary_device ps_aux;
 	struct auxiliary_device ucsi_aux;
@@ -231,8 +243,19 @@ static struct rpmsg_driver pmic_glink_rpmsg_driver = {
 	},
 };
 
+/* Do not handle altmode for now on those platforms */
+static const unsigned int pmic_glink_sm8450_client_mask = BIT(PMIC_GLINK_CLIENT_BATT) |
+							  BIT(PMIC_GLINK_CLIENT_UCSI);
+
+static const struct of_device_id pmic_glink_of_client_mask[] = {
+	{ .compatible = "qcom,sm8450-pmic-glink", .data = &pmic_glink_sm8450_client_mask },
+	{ .compatible = "qcom,sm8550-pmic-glink", .data = &pmic_glink_sm8450_client_mask },
+	{}
+};
+
 static int pmic_glink_probe(struct platform_device *pdev)
 {
+	const struct of_device_id *match;
 	struct pdr_service *service;
 	struct pmic_glink *pg;
 	int ret;
@@ -249,12 +272,27 @@ static int pmic_glink_probe(struct platform_device *pdev)
 	mutex_init(&pg->client_lock);
 	mutex_init(&pg->state_lock);
 
-	ret = pmic_glink_add_aux_device(pg, &pg->altmode_aux, "altmode");
-	if (ret)
-		return ret;
-	ret = pmic_glink_add_aux_device(pg, &pg->ps_aux, "power-supply");
-	if (ret)
-		goto out_release_altmode_aux;
+	match = of_match_device(pmic_glink_of_client_mask, &pdev->dev);
+	if (match)
+		pg->client_mask = *(const unsigned int *)match->data;
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
@@ -278,9 +316,14 @@ static int pmic_glink_probe(struct platform_device *pdev)
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
@@ -291,8 +334,12 @@ static int pmic_glink_remove(struct platform_device *pdev)
 
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

-- 
2.34.1

