Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2808B6FB1AE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbjEHNhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjEHNhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:37:17 -0400
X-Greylist: delayed 1353 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 08 May 2023 06:37:12 PDT
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBC233169;
        Mon,  8 May 2023 06:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Cc:To:In-Reply-To:References:Message-Id:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
        Reply-To:Content-ID:Content-Description;
        bh=mOseTxwGsFqvCCOX46fJqAaMaCn90Qk+xtOVYSA8awE=; b=Dk032G458xZecq5cd3P+eY/iVo
        qXHdks3fPPt/PslF/Qvqsmi4Jeywm7kDHGumpRItgfXF22yIjJAVXHB7+bp2NGa1AsDvpbrypbNlj
        x8o2hRsmX0DMSto1AObec6EsFMyiPFOeQACKB256dckq8IRmXbwMlr8XZTeWbQ58jCfLFUGBRx3J5
        l037XXKq7XLiOWu8AqGlnyAjLaEklpYTwmOWYE3KTnfTLyAL86R//EL1n3beCStZUBHoxfDNMvG25
        eZQxtZtU+q0piduR4Pgcp6sKETOme+3wwUS3qfKExHyyzOkdcZ4IC5yykAxZ8kb5G6zHpHfy3Pm/v
        F5UjxM+w==;
Received: from [10.22.3.24] (helo=serv1.dd1.int.kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2)
        id 1pw0hN-009LZn-Db; Mon, 08 May 2023 15:14:41 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Date:   Mon, 08 May 2023 15:13:40 +0200
Subject: [PATCH v4 3/6] thermal: qcom: tsens-v0_1: Add mdm9607 correction
 offsets
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230508-msm8909-tsens-v4-3-d9119622cb19@kernkonzept.com>
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

According to the msm-3.18 vendor kernel from Qualcomm, mdm9607 needs
"correction factors" to adjust for additional offsets observed after the
factory calibration values in the fuses [1, 2].

The fixed offsets should be applied unless there is a special
calibration mode value that indicates that no offsets are needed [3].

Note that the new calibration mode values are called differently in this
patch compared to the vendor kernel:
  - TSENS_TWO_POINT_CALIB_N_WA        -> ONE_PT_CALIB2_NO_OFFSET
  - TSENS_TWO_POINT_CALIB_N_OFFSET_WA -> TWO_PT_CALIB_NO_OFFSET
This is because close inspection of the calibration function [3] reveals
that TSENS_TWO_POINT_CALIB_N_WA is actually a "one point" calibration
because the if statements skip all "point2" related code for it.

[1]: https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/commit/d9d2db1b82bf3f72f5de0803d55e6849eb5b671e
[2]: https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/commit/d75aef53a760e8ff7bac54049d00c8b2ee1b193e
[3]: https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/blob/LE.UM.4.3.2.r1-04200-9x07/drivers/thermal/msm-tsens.c#L2987-3136

Fixes: a2149ab815fc ("thermal/drivers/qcom/tsens-v0_1: Add support for MDM9607")
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
 drivers/thermal/qcom/tsens-v0_1.c | 11 +++++++++++
 drivers/thermal/qcom/tsens.c      | 16 +++++++++++++++-
 drivers/thermal/qcom/tsens.h      |  4 ++++
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index 1b454de3928d..e69889dd524a 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -229,6 +229,17 @@ static int __init init_9607(struct tsens_priv *priv)
 	for (i = 0; i < priv->num_sensors; ++i)
 		priv->sensor[i].slope = 3000;
 
+	priv->sensor[0].p1_calib_offset = 1;
+	priv->sensor[0].p2_calib_offset = 1;
+	priv->sensor[1].p1_calib_offset = -4;
+	priv->sensor[1].p2_calib_offset = -2;
+	priv->sensor[2].p1_calib_offset = 4;
+	priv->sensor[2].p2_calib_offset = 8;
+	priv->sensor[3].p1_calib_offset = -3;
+	priv->sensor[3].p2_calib_offset = -5;
+	priv->sensor[4].p1_calib_offset = -4;
+	priv->sensor[4].p2_calib_offset = -4;
+
 	return init_common(priv);
 }
 
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index d3218127e617..065d0f9728a5 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -134,10 +134,12 @@ int tsens_read_calibration(struct tsens_priv *priv, int shift, u32 *p1, u32 *p2,
 			p1[i] = p1[i] + (base1 << shift);
 		break;
 	case TWO_PT_CALIB:
+	case TWO_PT_CALIB_NO_OFFSET:
 		for (i = 0; i < priv->num_sensors; i++)
 			p2[i] = (p2[i] + base2) << shift;
 		fallthrough;
 	case ONE_PT_CALIB2:
+	case ONE_PT_CALIB2_NO_OFFSET:
 		for (i = 0; i < priv->num_sensors; i++)
 			p1[i] = (p1[i] + base1) << shift;
 		break;
@@ -149,6 +151,18 @@ int tsens_read_calibration(struct tsens_priv *priv, int shift, u32 *p1, u32 *p2,
 		}
 	}
 
+	/* Apply calibration offset workaround except for _NO_OFFSET modes */
+	switch (mode) {
+	case TWO_PT_CALIB:
+		for (i = 0; i < priv->num_sensors; i++)
+			p2[i] += priv->sensor[i].p2_calib_offset;
+		fallthrough;
+	case ONE_PT_CALIB2:
+		for (i = 0; i < priv->num_sensors; i++)
+			p1[i] += priv->sensor[i].p1_calib_offset;
+		break;
+	}
+
 	return mode;
 }
 
@@ -254,7 +268,7 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
 
 		if (!priv->sensor[i].slope)
 			priv->sensor[i].slope = SLOPE_DEFAULT;
-		if (mode == TWO_PT_CALIB) {
+		if (mode == TWO_PT_CALIB || mode == TWO_PT_CALIB_NO_OFFSET) {
 			/*
 			 * slope (m) = adc_code2 - adc_code1 (y2 - y1)/
 			 *	temp_120_degc - temp_30_degc (x2 - x1)
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index dba9cd38f637..880be6be5c3f 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -10,6 +10,8 @@
 #define ONE_PT_CALIB		0x1
 #define ONE_PT_CALIB2		0x2
 #define TWO_PT_CALIB		0x3
+#define ONE_PT_CALIB2_NO_OFFSET	0x6
+#define TWO_PT_CALIB_NO_OFFSET	0x7
 #define CAL_DEGC_PT1		30
 #define CAL_DEGC_PT2		120
 #define SLOPE_FACTOR		1000
@@ -57,6 +59,8 @@ struct tsens_sensor {
 	unsigned int			hw_id;
 	int				slope;
 	u32				status;
+	int				p1_calib_offset;
+	int				p2_calib_offset;
 };
 
 /**

-- 
2.30.2

