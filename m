Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C856E688420
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 17:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjBBQUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 11:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbjBBQTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 11:19:43 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDD56B374
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 08:19:41 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so4113848wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 08:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8TFBPo8Ik7unXzigxuHt3Uqoz8brKDN9WgByPaSgg0=;
        b=di+DTSEME47k+eUSJH20fVKTnFF0bGKgtVJ1zywshrewXPYmEYB1GmHr+yDaq/LWX+
         MPNFC6WgLl7t77OFuvUBmKvdgh/fJxHSS860AKs3w0RaUO/h7FJnV2PZYdoQ+Y3VUsaZ
         K4Wu1J0jbPGZPgt6X3ExY/1s9G5rvpQXqAlZrVyolR1gxTBVBiqnapcEQ5jfqf3zNu1Y
         rth0jYQRkV3Lr2PrQQUMp6aZyBBZqLt6UMiFy/M/Ea52Y3mDDbbf8d9hQsctvBbeJBYU
         kHkZD6IXqMMDi40H+4oCXooi+1aRAKZukIJSNOeKoUKKn/nY3E/IPUQoR4vyt2+27zol
         PNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8TFBPo8Ik7unXzigxuHt3Uqoz8brKDN9WgByPaSgg0=;
        b=Te6FsOlli5xc9fIJIIYDv+6QHVquQyQEb//ZdASw+JJBUeHkFHwhvK0Ksh8uFrdPzp
         JgLPMcKgqwo/OJcMyPRlTZO6IqIbZWDT1MLmM1DBfAROrDQUIiGg9sCeDIuBV5QrXiSd
         n8fsHSavpu8Bs6+jp99SPD453oZO+i91qTIi1UfA4L5AVZJvdBr9LnV9hxic2AA56FU9
         VcajSgT71yVTuX4heCaallSrJj6zK4fhrdf0XNAqDPSCF6/2HMBh1iBrkfQakkB2WIkd
         KgxpBSBeQdb8BMZZZ1aKbvKMhE95aaVCVyJ8fl9skoHuzwQCeaGIYNb7XMK/Lyy/81MO
         +sGQ==
X-Gm-Message-State: AO0yUKUHdMO0pZqtb9OAjiF0RUwhMuoTmLJ1/DC9+ldwQ1Fjn5HVy/5h
        hRi6u01C4wL/rk8yv7YZakks3w==
X-Google-Smtp-Source: AK7set+mwutHWqAinDWHeXsdufMWMjyvrW/Zq+XZNJUM8vbew9Gvd3OVGfZSvkvC08mv4huWkIazOg==
X-Received: by 2002:a05:600c:198b:b0:3df:3bd6:63e5 with SMTP id t11-20020a05600c198b00b003df3bd663e5mr4851702wmq.12.1675354779683;
        Thu, 02 Feb 2023 08:19:39 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600c351000b003dc521f336esm212416wmq.14.2023.02.02.08.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 08:19:39 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 03/13] mailbox: qcom-apcs-ipc: do not grow the of_device_id
Date:   Thu,  2 Feb 2023 17:18:46 +0100
Message-Id: <20230202161856.385825-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230202161856.385825-1-krzysztof.kozlowski@linaro.org>
References: <20230202161856.385825-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-organize the compatible devices and add a comment to avoid unneeded
of_device_id growth with every new SoC.  These devices have quite a lot
of similarities and they can use only one compatible fallback for driver
binding.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
index 0e9f9cba8668..4143209de2c8 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -142,17 +142,19 @@ static int qcom_apcs_ipc_remove(struct platform_device *pdev)
 /* .data is the offset of the ipc register within the global block */
 static const struct of_device_id qcom_apcs_ipc_of_match[] = {
 	{ .compatible = "qcom,ipq6018-apcs-apps-global", .data = &ipq6018_apcs_data },
-	{ .compatible = "qcom,ipq8074-apcs-apps-global", .data = &ipq6018_apcs_data },
 	{ .compatible = "qcom,msm8916-apcs-kpss-global", .data = &msm8916_apcs_data },
-	{ .compatible = "qcom,msm8939-apcs-kpss-global", .data = &msm8916_apcs_data },
 	{ .compatible = "qcom,msm8953-apcs-kpss-global", .data = &msm8994_apcs_data },
+	{ .compatible = "qcom,msm8996-apcs-hmss-global", .data = &msm8996_apcs_data },
+	{ .compatible = "qcom,sc7180-apss-shared", .data = &apps_shared_apcs_data },
+	{ .compatible = "qcom,sdx55-apcs-gcc", .data = &sdx55_apcs_data },
+	/* Do not add any more entries using existing driver data */
+	{ .compatible = "qcom,ipq8074-apcs-apps-global", .data = &ipq6018_apcs_data },
+	{ .compatible = "qcom,msm8939-apcs-kpss-global", .data = &msm8916_apcs_data },
 	{ .compatible = "qcom,msm8976-apcs-kpss-global", .data = &msm8994_apcs_data },
 	{ .compatible = "qcom,msm8994-apcs-kpss-global", .data = &msm8994_apcs_data },
-	{ .compatible = "qcom,msm8996-apcs-hmss-global", .data = &msm8996_apcs_data },
 	{ .compatible = "qcom,msm8998-apcs-hmss-global", .data = &msm8994_apcs_data },
 	{ .compatible = "qcom,qcm2290-apcs-hmss-global", .data = &msm8994_apcs_data },
 	{ .compatible = "qcom,qcs404-apcs-apps-global", .data = &msm8916_apcs_data },
-	{ .compatible = "qcom,sc7180-apss-shared", .data = &apps_shared_apcs_data },
 	{ .compatible = "qcom,sc8180x-apss-shared", .data = &apps_shared_apcs_data },
 	{ .compatible = "qcom,sdm660-apcs-hmss-global", .data = &msm8994_apcs_data },
 	{ .compatible = "qcom,sdm845-apss-shared", .data = &apps_shared_apcs_data },
@@ -160,7 +162,6 @@ static const struct of_device_id qcom_apcs_ipc_of_match[] = {
 	{ .compatible = "qcom,sm6125-apcs-hmss-global", .data = &msm8994_apcs_data },
 	{ .compatible = "qcom,sm8150-apss-shared", .data = &apps_shared_apcs_data },
 	{ .compatible = "qcom,sm6115-apcs-hmss-global", .data = &msm8994_apcs_data },
-	{ .compatible = "qcom,sdx55-apcs-gcc", .data = &sdx55_apcs_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, qcom_apcs_ipc_of_match);
-- 
2.34.1

