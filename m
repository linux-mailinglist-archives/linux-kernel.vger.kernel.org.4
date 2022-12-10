Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7743648F36
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 15:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiLJOgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 09:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLJOgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 09:36:49 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9359818E22
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 06:36:48 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id vp12so17862878ejc.8
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 06:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=caCw02a57gWGRWx8zPRw8a1fhnbDipRs6pe9fbRP2lg=;
        b=t1oVeJs3URAwTinNH05NIKLzfvtC3zNVYPnP2dt1gz+UleUW+lD6nUsLWIJq7+h7dZ
         dznAL3cwBbC1vP8uY9zAcUGxuF0DkIhKWys/lelwp+OGDkDJ0ZuM7S/8qW9VkQ7QBBER
         b3DE8nh/d+k6wLtzuapD9qZz0lwzFJrQEFVVunOAIDE+A1+7uXfSpy5Lh3/xCZFh7tyh
         4b+iPnutWHCyWY1qAWxLNbDkfFAAHczTm0c4kG8hb/OvkLb/R68ciC9s9rP/hQc5LiPt
         XwaDdAM+F98et9Jp2ZAWnmYe+5W4gg00mpnpCXadxGK0DsNv9DiCruO98ceFcnWcLHn5
         5+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=caCw02a57gWGRWx8zPRw8a1fhnbDipRs6pe9fbRP2lg=;
        b=sQ8BcXIoCoZ7Mu3jY2bXkvcxracnOyOh1LCCCEcRpI2VZcpduBiP8ME/sUZE4IjAw2
         1lAQWkzBelRZ8QpoDrIhkn7w1Kmf6cjIFWBE4Fci4Z1gw2EClxvd44ev5dxJgrosbgFO
         NXiw8mTaRTSQR3aO0ov2qsg97RQjZPOBoh+KnNjpE6bEbpOIiWCQ4i+Sir0PrfVrjv8a
         64tp/Wy4R1Bx0pZHUFR/ghW3lSuD6eE4U3JfY/yyyMm2/Vu5J/qIaU5Tqr8mFp5Z6QwD
         Y2pczqlfq1REwbqlYjwT1tjNk0l+ugWnbkLf7lwuLNP0ufAZ32KrOpRgExbS5WEEid4Z
         836A==
X-Gm-Message-State: ANoB5pkD17o34nTzajyo9nnazHIB+/WkKTYulGwxt/qXAsmXlI02111x
        zI7Gm09hRJYHJGBF97pn/yBYr2kV3t1yHVN1
X-Google-Smtp-Source: AA0mqf75tPF4lZOnv8BC4wB75VCoJOTpPk8CgE/dbeexhStC0NsKbg0Z+dO/zv3cC8/gqZvesZ40hg==
X-Received: by 2002:a05:651c:158f:b0:26f:db34:a13f with SMTP id h15-20020a05651c158f00b0026fdb34a13fmr2380844ljq.2.1670680694350;
        Sat, 10 Dec 2022 05:58:14 -0800 (PST)
Received: from localhost.localdomain (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id p20-20020a2eba14000000b002770566d642sm614567lja.17.2022.12.10.05.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 05:58:13 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] remoteproc: qcom: pas: Add SM6375 MPSS
Date:   Sat, 10 Dec 2022 14:58:07 +0100
Message-Id: <20221210135807.10688-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221210135807.10688-1-konrad.dybcio@linaro.org>
References: <20221210135807.10688-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a config for the MPSS present on SM6375.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 920f8e54db36..405a144c9c3e 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -854,6 +854,22 @@ static const struct adsp_data slpi_resource_init = {
 		.ssctl_id = 0x16,
 };
 
+static const struct adsp_data sm6375_mpss_resource = {
+	.crash_reason_smem = 421,
+	.firmware_name = "modem.mdt",
+	.pas_id = 4,
+	.minidump_id = 3,
+	.has_aggre2_clk = false,
+	.auto_boot = false,
+	.proxy_pd_names = (char*[]){
+		"cx",
+		NULL
+	},
+	.ssr_name = "mpss",
+	.sysmon_name = "modem",
+	.ssctl_id = 0x12,
+};
+
 static const struct adsp_data sm8150_slpi_resource = {
 		.crash_reason_smem = 424,
 		.firmware_name = "slpi.mdt",
@@ -977,6 +993,7 @@ static const struct of_device_id adsp_of_match[] = {
 	{ .compatible = "qcom,sm6350-mpss-pas", .data = &mpss_resource_init},
 	{ .compatible = "qcom,sm6375-adsp-pas", .data = &sm6350_adsp_resource},
 	{ .compatible = "qcom,sm6375-cdsp-pas", .data = &sm8150_cdsp_resource},
+	{ .compatible = "qcom,sm6375-mpss-pas", .data = &sm6375_mpss_resource},
 	{ .compatible = "qcom,sm8150-adsp-pas", .data = &sm8150_adsp_resource},
 	{ .compatible = "qcom,sm8150-cdsp-pas", .data = &sm8150_cdsp_resource},
 	{ .compatible = "qcom,sm8150-mpss-pas", .data = &mpss_resource_init},
-- 
2.38.1

