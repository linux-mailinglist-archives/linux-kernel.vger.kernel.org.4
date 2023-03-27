Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF9F6CA73E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbjC0ORI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbjC0OQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:16:51 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BEF5BBE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:15:20 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x3so36741143edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679926470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ypp3NNcegTahHFAJNE8cAdEswtLOr/02h21RPqRbA94=;
        b=OPSWVcDdoVEuWN3Zw9tIjO3jwrBx/Orrb0Pigm+CooSKbjqiVGMTC32LXGXhBmWuJx
         quK4glIZrWL05bS2bxUQg4DEYNLVQ4ESRpi6ni3ubXCRVFFrBJp+Yu/rJNq55J4oaz5q
         43wbF2EL/EFQGq/Q6D8EQFFZjCDehZ0DHfutCYmikHeoMOr66QUxNUsGFF/U7MwTCe5o
         Doqxpprx0GYl31NIA2rZLzfeWfmLQ8gwQ9a5z9BnHERl6lfkNnEf+Hh7mwLNUtvcvnqo
         fH4Fk1o6M15aPhgX87omLyz3uFZCpV/S8cJQP5W7NifvfDVIsUGV1t+7+RGG8H7sSKvy
         72lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679926470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ypp3NNcegTahHFAJNE8cAdEswtLOr/02h21RPqRbA94=;
        b=msxA1lh5WJ7l7q+/4nxDcSlEr+cH52SQD364BdGcsV/m3U8h4hAoZRANdXyCMzeX9B
         8O+c5WSyfoNVfu3hjmQMlMTgJuNJYWY33oRD7v19AoettTdM6/MrW8Bfq76NhyNXUZT9
         QDDUV0xYGxb8Hk40/9L2WI+Po2ZTphZXf8/cop4I+Esnp5DiV+tTw4OLSag1nrW/pado
         HDTW7qM/MGcFmz7GiQRNfBTq4MK+7ghLI5seRYxEdeshdmY7XdBgDtDN6BTWi5+5x1wv
         VDym0R3XwcmQxupNN4bDEGnGWUy8YXiVPyUmVn2z8GGT5DTJp96S9AizPmgmKoL4/BT9
         kTzQ==
X-Gm-Message-State: AAQBX9fLdwFDANosu7E146DqPFFJc+bV/RRi1HvTBsLn7Nchfqovvgon
        i9Kv/FhBTb/pD1EkSqE3KTtr1Q==
X-Google-Smtp-Source: AKy350ZWu65scU+w1dPWdRX0dJtcdEO11ugkZOZ3p+kqY0PWkPqdNleawHDU9QbpmCtWx46vAzlrvA==
X-Received: by 2002:a17:907:1707:b0:922:ae30:3c23 with SMTP id le7-20020a170907170700b00922ae303c23mr12428458ejc.18.1679926470538;
        Mon, 27 Mar 2023 07:14:30 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:581e:789c:7616:5ee])
        by smtp.gmail.com with ESMTPSA id ha25-20020a170906a89900b00934212e973esm11273339ejb.198.2023.03.27.07.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 07:14:30 -0700 (PDT)
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
Subject: [PATCH v4 2/5] mailbox: qcom-apcs-ipc: do not grow the of_device_id
Date:   Mon, 27 Mar 2023 16:07:49 +0200
Message-Id: <20230327140752.163009-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230327140752.163009-1-krzysztof.kozlowski@linaro.org>
References: <20230327140752.163009-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 6bbf87c6d60b..002a135ee868 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -141,9 +141,7 @@ static int qcom_apcs_ipc_remove(struct platform_device *pdev)
 
 /* .data is the offset of the ipc register within the global block */
 static const struct of_device_id qcom_apcs_ipc_of_match[] = {
-	{ .compatible = "qcom,ipq5332-apcs-apps-global", .data = &ipq6018_apcs_data },
 	{ .compatible = "qcom,ipq6018-apcs-apps-global", .data = &ipq6018_apcs_data },
-	{ .compatible = "qcom,ipq8074-apcs-apps-global", .data = &ipq6018_apcs_data },
 	{ .compatible = "qcom,msm8916-apcs-kpss-global", .data = &msm8916_apcs_data },
 	{ .compatible = "qcom,msm8939-apcs-kpss-global", .data = &msm8916_apcs_data },
 	{ .compatible = "qcom,msm8953-apcs-kpss-global", .data = &msm8994_apcs_data },
@@ -153,15 +151,18 @@ static const struct of_device_id qcom_apcs_ipc_of_match[] = {
 	{ .compatible = "qcom,msm8998-apcs-hmss-global", .data = &msm8994_apcs_data },
 	{ .compatible = "qcom,qcm2290-apcs-hmss-global", .data = &msm8994_apcs_data },
 	{ .compatible = "qcom,qcs404-apcs-apps-global", .data = &msm8916_apcs_data },
-	{ .compatible = "qcom,sc7180-apss-shared", .data = &apps_shared_apcs_data },
-	{ .compatible = "qcom,sc8180x-apss-shared", .data = &apps_shared_apcs_data },
 	{ .compatible = "qcom,sdm660-apcs-hmss-global", .data = &msm8994_apcs_data },
 	{ .compatible = "qcom,sdm845-apss-shared", .data = &apps_shared_apcs_data },
 	{ .compatible = "qcom,sm4250-apcs-hmss-global", .data = &msm8994_apcs_data },
 	{ .compatible = "qcom,sm6125-apcs-hmss-global", .data = &msm8994_apcs_data },
-	{ .compatible = "qcom,sm8150-apss-shared", .data = &apps_shared_apcs_data },
 	{ .compatible = "qcom,sm6115-apcs-hmss-global", .data = &msm8994_apcs_data },
 	{ .compatible = "qcom,sdx55-apcs-gcc", .data = &sdx55_apcs_data },
+	/* Do not add any more entries using existing driver data */
+	{ .compatible = "qcom,ipq5332-apcs-apps-global", .data = &ipq6018_apcs_data },
+	{ .compatible = "qcom,ipq8074-apcs-apps-global", .data = &ipq6018_apcs_data },
+	{ .compatible = "qcom,sc7180-apss-shared", .data = &apps_shared_apcs_data },
+	{ .compatible = "qcom,sc8180x-apss-shared", .data = &apps_shared_apcs_data },
+	{ .compatible = "qcom,sm8150-apss-shared", .data = &apps_shared_apcs_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, qcom_apcs_ipc_of_match);
-- 
2.34.1

