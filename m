Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A618A6FB1C2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbjEHNh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbjEHNht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:37:49 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E2A33865;
        Mon,  8 May 2023 06:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Cc:To:In-Reply-To:References:Message-Id:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
        Reply-To:Content-ID:Content-Description;
        bh=NOkAIQUPJO28ZJg22Jb1eVbFAiUIZlNRpNU5m2FRP5E=; b=EE5V4tWpDwtjBnTfbVkN+3p7ci
        sg2A6hiutkktUQSXBF8ueZMosQDNH4Qfw1SyG359v5u3w32dPJh2y6jepyG/+uWPfQoWmT7RHPHAp
        SXE3SWmC6c2CYP/4hQSl0NSSu2XMjxtFZMAmXQTOFcP3wocr/otRM1XOQm83zSCN/pyOFnIWvQS/y
        TlWmY1ZZidMDAxZbqFAk8gIf0AN3AUD8OUPYKuDOp4QuPDwHHqORG3/wunnCa5LJ/hGaFEuTG7cE4
        YZ+DAvCVpA+rhYLAJUJKBrizMjqnVUM2Z93nih58AM+ckZLORRYF3uSLi999il+h0yxJijI6x2ztr
        G+CH5APA==;
Received: from [10.22.3.24] (helo=serv1.dd1.int.kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2)
        id 1pw0hW-009LZn-Bf; Mon, 08 May 2023 15:14:50 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Date:   Mon, 08 May 2023 15:13:43 +0200
Subject: [PATCH v4 6/6] thermal: qcom: tsens-v0_1: Add MSM8909 data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230508-msm8909-tsens-v4-6-d9119622cb19@kernkonzept.com>
References: <20230508-msm8909-tsens-v4-0-d9119622cb19@kernkonzept.com>
In-Reply-To: <20230508-msm8909-tsens-v4-0-d9119622cb19@kernkonzept.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MSM8909 SoC has 5 thermal sensors in a TSENS v0.1 block. Like
MDM9607 it uses a non-standard default slope value of 3000 [1] and needs
per-sensor "correction factors" to workaround issues with the factory
calibration [2].

[1]: https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/blob/LA.UM.7.7.c26-09100-8x09.0/arch/arm/boot/dts/qcom/msm8909.dtsi#L476
[2]: https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/commit/6df022c6d0c2c1b4a5a6c2124dba4d57910c0911

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
 drivers/thermal/qcom/tsens-v0_1.c | 36 +++++++++++++++++++++++++++++++++++-
 drivers/thermal/qcom/tsens.c      |  3 +++
 drivers/thermal/qcom/tsens.h      |  2 +-
 3 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index e69889dd524a..f97d313f0536 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -207,6 +207,27 @@ static int calibrate_8974(struct tsens_priv *priv)
 	return 0;
 }
 
+static int __init init_8909(struct tsens_priv *priv)
+{
+	int i;
+
+	for (i = 0; i < priv->num_sensors; ++i)
+		priv->sensor[i].slope = 3000;
+
+	priv->sensor[0].p1_calib_offset = 0;
+	priv->sensor[0].p2_calib_offset = 0;
+	priv->sensor[1].p1_calib_offset = -10;
+	priv->sensor[1].p2_calib_offset = -6;
+	priv->sensor[2].p1_calib_offset = 0;
+	priv->sensor[2].p2_calib_offset = 0;
+	priv->sensor[3].p1_calib_offset = -9;
+	priv->sensor[3].p2_calib_offset = -9;
+	priv->sensor[4].p1_calib_offset = -8;
+	priv->sensor[4].p2_calib_offset = -10;
+
+	return init_common(priv);
+}
+
 static int __init init_8939(struct tsens_priv *priv) {
 	priv->sensor[0].slope = 2911;
 	priv->sensor[1].slope = 2789;
@@ -243,7 +264,7 @@ static int __init init_9607(struct tsens_priv *priv)
 	return init_common(priv);
 }
 
-/* v0.1: 8916, 8939, 8974, 9607 */
+/* v0.1: 8909, 8916, 8939, 8974, 9607 */
 
 static struct tsens_features tsens_v0_1_feat = {
 	.ver_major	= VER_0_1,
@@ -292,6 +313,19 @@ static const struct reg_field tsens_v0_1_regfields[MAX_REGFIELDS] = {
 	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
 };
 
+static const struct tsens_ops ops_8909 = {
+	.init		= init_8909,
+	.calibrate	= tsens_calibrate_common,
+	.get_temp	= get_temp_common,
+};
+
+struct tsens_plat_data data_8909 = {
+	.num_sensors	= 5,
+	.ops		= &ops_8909,
+	.feat		= &tsens_v0_1_feat,
+	.fields	= tsens_v0_1_regfields,
+};
+
 static const struct tsens_ops ops_8916 = {
 	.init		= init_common,
 	.calibrate	= calibrate_8916,
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 065d0f9728a5..1d7c149038e0 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1109,6 +1109,9 @@ static const struct of_device_id tsens_table[] = {
 	}, {
 		.compatible = "qcom,mdm9607-tsens",
 		.data = &data_9607,
+	}, {
+		.compatible = "qcom,msm8909-tsens",
+		.data = &data_8909,
 	}, {
 		.compatible = "qcom,msm8916-tsens",
 		.data = &data_8916,
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 880be6be5c3f..c88287dede96 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -639,7 +639,7 @@ int get_temp_common(const struct tsens_sensor *s, int *temp);
 extern struct tsens_plat_data data_8960;
 
 /* TSENS v0.1 targets */
-extern struct tsens_plat_data data_8916, data_8939, data_8974, data_9607;
+extern struct tsens_plat_data data_8909, data_8916, data_8939, data_8974, data_9607;
 
 /* TSENS v1 targets */
 extern struct tsens_plat_data data_tsens_v1, data_8976, data_8956;

-- 
2.30.2

