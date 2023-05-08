Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982236FB1B6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbjEHNhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbjEHNhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:37:25 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41EC33D5E;
        Mon,  8 May 2023 06:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Cc:To:In-Reply-To:References:Message-Id:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
        Reply-To:Content-ID:Content-Description;
        bh=srA3euTk/5sjMRb84lbIHFc1mB5nmRpPgU1BRVL2uW0=; b=d1IKuU0QJzbptvYQyztNEI2xdM
        MUVyODdv4KijIhe8/YR5rNEfC5EJC6OCUJdlaeyW3y9uHJJrfGD98hiMiH3SBQcxGA0aDgsaMU9qf
        Ez6ZFbO2ciqdP34Mb5h6NNA5ktsd1RgZPCLuSdrwo+vlxqTfBxNaI4QqWsUOwUvMM7Pt6JlmGg1gO
        QhJGDewUZH92JQ2ZS2eQwnBt2IrzXjDcet83ixhaSjQrwR59In1af62q0Tr70A/of8StuBqdUI3s+
        icCevsYci8PfynSmAYOuNVJ8R35C8hddLQ2Dw8Lp0NogPt+9r/pYxdjYVylJC/EM6T4G+Dwrize2u
        L+ylw68A==;
Received: from [10.22.3.24] (helo=serv1.dd1.int.kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2)
        id 1pw0hK-009LZn-Lp; Mon, 08 May 2023 15:14:38 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Date:   Mon, 08 May 2023 15:13:39 +0200
Subject: [PATCH v4 2/6] thermal: qcom: tsens-v0_1: Fix mdm9607 slope values
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230508-msm8909-tsens-v4-2-d9119622cb19@kernkonzept.com>
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

According to the msm-3.18 vendor kernel from Qualcomm [1], mdm9607 uses
a non-standard slope value of 3000 (instead of 3200) for all sensors.
Fill it properly similar to the 8939 code added recently.

[1]: https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/blob/LE.UM.4.3.2.r1-04200-9x07/arch/arm/boot/dts/qcom/mdm9607.dtsi#L875

Fixes: a2149ab815fc ("thermal/drivers/qcom/tsens-v0_1: Add support for MDM9607")
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
 drivers/thermal/qcom/tsens-v0_1.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index 106d26076e3f..1b454de3928d 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -222,6 +222,16 @@ static int __init init_8939(struct tsens_priv *priv) {
 	return init_common(priv);
 }
 
+static int __init init_9607(struct tsens_priv *priv)
+{
+	int i;
+
+	for (i = 0; i < priv->num_sensors; ++i)
+		priv->sensor[i].slope = 3000;
+
+	return init_common(priv);
+}
+
 /* v0.1: 8916, 8939, 8974, 9607 */
 
 static struct tsens_features tsens_v0_1_feat = {
@@ -271,12 +281,6 @@ static const struct reg_field tsens_v0_1_regfields[MAX_REGFIELDS] = {
 	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
 };
 
-static const struct tsens_ops ops_v0_1 = {
-	.init		= init_common,
-	.calibrate	= tsens_calibrate_common,
-	.get_temp	= get_temp_common,
-};
-
 static const struct tsens_ops ops_8916 = {
 	.init		= init_common,
 	.calibrate	= calibrate_8916,
@@ -320,9 +324,15 @@ struct tsens_plat_data data_8974 = {
 	.fields	= tsens_v0_1_regfields,
 };
 
+static const struct tsens_ops ops_9607 = {
+	.init		= init_9607,
+	.calibrate	= tsens_calibrate_common,
+	.get_temp	= get_temp_common,
+};
+
 struct tsens_plat_data data_9607 = {
 	.num_sensors	= 5,
-	.ops		= &ops_v0_1,
+	.ops		= &ops_9607,
 	.feat		= &tsens_v0_1_feat,
 	.fields	= tsens_v0_1_regfields,
 };

-- 
2.30.2

