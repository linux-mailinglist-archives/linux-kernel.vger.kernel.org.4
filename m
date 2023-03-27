Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B5A6CAD26
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 20:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjC0SiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 14:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbjC0Sh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:37:59 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B361711;
        Mon, 27 Mar 2023 11:37:57 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4PlhQB0MMmz9sSr;
        Mon, 27 Mar 2023 20:37:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1679942274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UYNhSu+2Wobyn2s4WHdqzJN3u63ahHSl1LNIJlpGGUg=;
        b=gR6UI5cM0lSHtl1L3DB5zAYGKT2/vbODgBjpX8klFCCx8NaIbt56YXQHCUMZ7MsO2lem6H
        xOZFG32lQ9T35IJCWZlUv9LeYgZ2S+zjZBvTWDZd7hZcNMKXUUVKne/ijNwqlpu0CXI1qv
        V40rk+jWJrKzifFEcWCWjOG2JOLyzhOR22GMhidzapkZzp7fT7mPDqw1+KeHCDgnPA7jcx
        MBYGbVKNFUAvWoLbXq8Vnw9Aoy7hQ1c9gpB5Vj2epk9P2lyUDpnOtDP9ku3Rscndp5l6fi
        5EpH2igSDXDuTu+S6oyHvXEZYlURocKtJmvth44SztwZ+YmzPHaJo/Lp6ANzFQ==
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
        Dylan Van Assche <me@dylanvanassche.be>
Subject: [PATCH v2 2/3] remoteproc: qcom: pas: add SDM845 SLPI resource
Date:   Mon, 27 Mar 2023 20:37:35 +0200
Message-Id: <20230327183736.496170-3-me@dylanvanassche.be>
In-Reply-To: <20230327183736.496170-1-me@dylanvanassche.be>
References: <20230327183736.496170-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4PlhQB0MMmz9sSr
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SLPI resources for the SDM845 Qualcomm SoC to the Qualcomm
remoteproc q6v5_pas driver to define the default firmware name
and GLink edge name.

Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index c99a20542685..d82b6f4bced4 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -1028,6 +1028,22 @@ static const struct adsp_data slpi_resource_init = {
 		.ssctl_id = 0x16,
 };
 
+static const struct adsp_data sdm845_slpi_resource = {
+		.crash_reason_smem = 424,
+		.firmware_name = "slpi.mdt",
+		.pas_id = 12,
+		.auto_boot = true,
+		.proxy_pd_names = (char*[]){
+			"lcx",
+			"lmx",
+			NULL
+		},
+		.load_state = "slpi",
+		.ssr_name = "dsps",
+		.sysmon_name = "slpi",
+		.ssctl_id = 0x16,
+};
+
 static const struct adsp_data sm8150_slpi_resource = {
 		.crash_reason_smem = 424,
 		.firmware_name = "slpi.mdt",
@@ -1201,6 +1217,7 @@ static const struct of_device_id adsp_of_match[] = {
 	{ .compatible = "qcom,sdm660-adsp-pas", .data = &adsp_resource_init},
 	{ .compatible = "qcom,sdm845-adsp-pas", .data = &sdm845_adsp_resource_init},
 	{ .compatible = "qcom,sdm845-cdsp-pas", .data = &sdm845_cdsp_resource_init},
+	{ .compatible = "qcom,sdm845-slpi-pas", .data = &sdm845_slpi_resource},
 	{ .compatible = "qcom,sdx55-mpss-pas", .data = &sdx55_mpss_resource},
 	{ .compatible = "qcom,sm6115-adsp-pas", .data = &adsp_resource_init},
 	{ .compatible = "qcom,sm6115-cdsp-pas", .data = &cdsp_resource_init},
-- 
2.39.2

