Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4306D0BB5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjC3Qrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbjC3Qq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:46:58 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BC2CDF5;
        Thu, 30 Mar 2023 09:46:57 -0700 (PDT)
Received: from smtp102.mailbox.org (unknown [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4PnTph29Fzz9sfJ;
        Thu, 30 Mar 2023 18:46:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1680194812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uZ+dlsK3LvFYVmfHNb1x8vPNf5fkiddC6hOwcgvpDbs=;
        b=0LbtqX2CmtwpAb4aR1WTCa7KoLeatnZD8ka2ghbS2sUZif2G/THIq3j8GvEqidWbghUbsE
        r5XcBVTzYOb0Otg+JD7Jb5e880tNgK1zPqvCkckWgZE1DfkFqAMez6HmgQUXdo9xeCYAme
        ENCMaBYzbvkneAV0rj5sPPGDBjFntWxcQlVUaOihkWuo/StdOYm0exbZ8ZZKPrOk8s6CmG
        IqkiiXS4qtcImHDrd2XEo8qPODXkpP93/MU+zMdoOGyX8iSSL31vHrgdbw3gDuoBczgRyy
        XqTAh1OGsTIhwdqMvj7FiuBXJyWUqRMFHduH51Z9JsMG+IQBsrvo1AAEZhTcMA==
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dylan Van Assche <me@dylanvanassche.be>
Subject: [PATCH v3 2/3] remoteproc: qcom: pas: refactor SLPI remoteproc init
Date:   Thu, 30 Mar 2023 18:46:32 +0200
Message-Id: <20230330164633.117335-3-me@dylanvanassche.be>
In-Reply-To: <20230330164633.117335-1-me@dylanvanassche.be>
References: <20230330164633.117335-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SLPI remoteproc initialization is the same for SDM845, SM8150, SM8250,
SM8350 but is duplicated for each compatible. Refactor initialization
structs for these 4 compatibles as a single struct.

Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 48 +++++-------------------------
 1 file changed, 8 insertions(+), 40 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index c99a20542685..b96020c93e58 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -1014,7 +1014,7 @@ static const struct adsp_data sc8180x_mpss_resource = {
 	.ssctl_id = 0x12,
 };
 
-static const struct adsp_data slpi_resource_init = {
+static const struct adsp_data msm8996_slpi_resource_init = {
 		.crash_reason_smem = 424,
 		.firmware_name = "slpi.mdt",
 		.pas_id = 12,
@@ -1028,7 +1028,7 @@ static const struct adsp_data slpi_resource_init = {
 		.ssctl_id = 0x16,
 };
 
-static const struct adsp_data sm8150_slpi_resource = {
+static const struct adsp_data sdm845_slpi_resource_init = {
 		.crash_reason_smem = 424,
 		.firmware_name = "slpi.mdt",
 		.pas_id = 12,
@@ -1044,38 +1044,6 @@ static const struct adsp_data sm8150_slpi_resource = {
 		.ssctl_id = 0x16,
 };
 
-static const struct adsp_data sm8250_slpi_resource = {
-	.crash_reason_smem = 424,
-	.firmware_name = "slpi.mdt",
-	.pas_id = 12,
-	.auto_boot = true,
-	.proxy_pd_names = (char*[]){
-		"lcx",
-		"lmx",
-		NULL
-	},
-	.load_state = "slpi",
-	.ssr_name = "dsps",
-	.sysmon_name = "slpi",
-	.ssctl_id = 0x16,
-};
-
-static const struct adsp_data sm8350_slpi_resource = {
-	.crash_reason_smem = 424,
-	.firmware_name = "slpi.mdt",
-	.pas_id = 12,
-	.auto_boot = true,
-	.proxy_pd_names = (char*[]){
-		"lcx",
-		"lmx",
-		NULL
-	},
-	.load_state = "slpi",
-	.ssr_name = "dsps",
-	.sysmon_name = "slpi",
-	.ssctl_id = 0x16,
-};
-
 static const struct adsp_data wcss_resource_init = {
 	.crash_reason_smem = 421,
 	.firmware_name = "wcnss.mdt",
@@ -1184,9 +1152,9 @@ static const struct of_device_id adsp_of_match[] = {
 	{ .compatible = "qcom,msm8953-adsp-pil", .data = &msm8996_adsp_resource},
 	{ .compatible = "qcom,msm8974-adsp-pil", .data = &adsp_resource_init},
 	{ .compatible = "qcom,msm8996-adsp-pil", .data = &msm8996_adsp_resource},
-	{ .compatible = "qcom,msm8996-slpi-pil", .data = &slpi_resource_init},
+	{ .compatible = "qcom,msm8996-slpi-pil", .data = &msm8996_slpi_resource_init},
 	{ .compatible = "qcom,msm8998-adsp-pas", .data = &msm8996_adsp_resource},
-	{ .compatible = "qcom,msm8998-slpi-pas", .data = &slpi_resource_init},
+	{ .compatible = "qcom,msm8998-slpi-pas", .data = &msm8996_slpi_resource_init},
 	{ .compatible = "qcom,qcs404-adsp-pas", .data = &adsp_resource_init },
 	{ .compatible = "qcom,qcs404-cdsp-pas", .data = &cdsp_resource_init },
 	{ .compatible = "qcom,qcs404-wcss-pas", .data = &wcss_resource_init },
@@ -1211,17 +1179,17 @@ static const struct of_device_id adsp_of_match[] = {
 	{ .compatible = "qcom,sm8150-adsp-pas", .data = &sm8150_adsp_resource},
 	{ .compatible = "qcom,sm8150-cdsp-pas", .data = &sm8150_cdsp_resource},
 	{ .compatible = "qcom,sm8150-mpss-pas", .data = &mpss_resource_init},
-	{ .compatible = "qcom,sm8150-slpi-pas", .data = &sm8150_slpi_resource},
+	{ .compatible = "qcom,sm8150-slpi-pas", .data = &sdm845_slpi_resource_init},
 	{ .compatible = "qcom,sm8250-adsp-pas", .data = &sm8250_adsp_resource},
 	{ .compatible = "qcom,sm8250-cdsp-pas", .data = &sm8250_cdsp_resource},
-	{ .compatible = "qcom,sm8250-slpi-pas", .data = &sm8250_slpi_resource},
+	{ .compatible = "qcom,sm8250-slpi-pas", .data = &sdm845_slpi_resource_init},
 	{ .compatible = "qcom,sm8350-adsp-pas", .data = &sm8350_adsp_resource},
 	{ .compatible = "qcom,sm8350-cdsp-pas", .data = &sm8350_cdsp_resource},
-	{ .compatible = "qcom,sm8350-slpi-pas", .data = &sm8350_slpi_resource},
+	{ .compatible = "qcom,sm8350-slpi-pas", .data = &sdm845_slpi_resource_init},
 	{ .compatible = "qcom,sm8350-mpss-pas", .data = &mpss_resource_init},
 	{ .compatible = "qcom,sm8450-adsp-pas", .data = &sm8350_adsp_resource},
 	{ .compatible = "qcom,sm8450-cdsp-pas", .data = &sm8350_cdsp_resource},
-	{ .compatible = "qcom,sm8450-slpi-pas", .data = &sm8350_slpi_resource},
+	{ .compatible = "qcom,sm8450-slpi-pas", .data = &sdm845_slpi_resource_init},
 	{ .compatible = "qcom,sm8450-mpss-pas", .data = &sm8450_mpss_resource},
 	{ .compatible = "qcom,sm8550-adsp-pas", .data = &sm8550_adsp_resource},
 	{ .compatible = "qcom,sm8550-cdsp-pas", .data = &sm8550_cdsp_resource},
-- 
2.39.2

