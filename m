Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DBA6D45B4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 15:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjDCNZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 09:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbjDCNZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 09:25:23 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97F6236A4
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 06:25:11 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id t10so117139913edd.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 06:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680528310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNWNIuqhfrK8VPT/wc/b5owpPd0Qbj32dt41XL6jF7I=;
        b=KbIE8hHpBMmVbs1dUdcqesZJr111M3juAwR/UVy5JlGbulKsFx7d6iHgThw/UcfE/H
         g04ODRwtd7K6JWW/AkKYz82yClpeSok0TeRoIdHfTQS5tIH6oI/MxL9Al6YniKjUnWx3
         95rKlTw/YTNiVRHJYjQ1YTfXPy1LUZuyhdMD2gzeT581NPC7ChG/vf1o8Daz7p5hMY7M
         5RwASrOm4q0F4tXsKsBdHd0Aez6pVZnN0AQqt+hrU8iSFTq3djeT35MNlR/XURafW0yT
         5MpnnUX2QuMq76hKOPQlmREU4ipwp6Xj9KyNXVSu1cRLId3aKBjBJVaePjq5CPDP3Qnb
         /AwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680528310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNWNIuqhfrK8VPT/wc/b5owpPd0Qbj32dt41XL6jF7I=;
        b=tOksNQoErSKugC5LyI8/W/+c0Apv5TUo5V1lzBlp6/Jdm38G6EwcoaVKdI1GBnNOkl
         35pX8eqAvBi+eixaMwGURHjLkd54uB4e1lj7mJZXoJLF2MbxbCp4A+oZtXgRTnL+Jiyb
         MQ3PtTHplxaVp7fx12OfJpugC8cI+8UxjCnjBll4qdX+56ui846cmDPph/ZSisZpWXrc
         q3Wlx0X44TEXEiVjO9rOIMpVVnl1G1ld/oG0Qos7JXfEo91Mv4vWzxezezHi1Q/gLTNu
         ehwqBnEborlJEplrQsFBAWXVpJ2PDtrDwN9i6s/uL3I/8hRpRHO92CSC0uXrCvVta302
         LUuw==
X-Gm-Message-State: AAQBX9dWN9Ngz67BJqshPqLvCnwDXRDKfzrdTZJ29job6bgVxYprzVmh
        s5S9hr6+hGhzr53tUEbuW/4EdA==
X-Google-Smtp-Source: AKy350aNoUlBedlJkAaKw8U0tZgt086mXDJsj0D3EEMN2efvta5ShNiO6t6OdWHXPV90xvmimW0M3A==
X-Received: by 2002:a05:6402:2693:b0:4bc:edde:150d with SMTP id w19-20020a056402269300b004bcedde150dmr17348061edd.0.1680528310030;
        Mon, 03 Apr 2023 06:25:10 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:ae90:d80:1069:4805])
        by smtp.gmail.com with ESMTPSA id p18-20020a170906229200b00930ba362216sm4658489eja.176.2023.04.03.06.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 06:25:09 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Patrick Lai <quic_plai@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 3/7] soundwire: qcom: allow 16-bit sample interval for ports
Date:   Mon,  3 Apr 2023 15:24:59 +0200
Message-Id: <20230403132503.62090-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230403132503.62090-1-krzysztof.kozlowski@linaro.org>
References: <20230403132503.62090-1-krzysztof.kozlowski@linaro.org>
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

The port sample interval was always 16-bit, split into low and high
bytes.  This split was unnecessary, although harmless for older devices
because all of them used only lower byte (so values < 0xff).  With
support for Soundwire controller on Qualcomm SM8550 and its devices,
both bytes will be used, thus add a new 'qcom,ports-sinterval' property
to allow 16-bit sample intervals.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Drop unneeded semicolon.
---
 drivers/soundwire/qcom.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index c296e0bf897b..faa091e7472a 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -95,6 +95,7 @@
 #define SWRM_DP_BLOCK_CTRL2_BANK(n, m)	(0x1130 + 0x100 * (n - 1) + 0x40 * m)
 #define SWRM_DP_PORT_HCTRL_BANK(n, m)	(0x1134 + 0x100 * (n - 1) + 0x40 * m)
 #define SWRM_DP_BLOCK_CTRL3_BANK(n, m)	(0x1138 + 0x100 * (n - 1) + 0x40 * m)
+#define SWRM_DP_SAMPLECTRL2_BANK(n, m)	(0x113C + 0x100 * (n - 1) + 0x40 * m)
 #define SWRM_DIN_DPn_PCM_PORT_CTRL(n)	(0x1054 + 0x100 * (n - 1))
 #define SWR_MSTR_MAX_REG_ADDR		(0x1740)
 
@@ -131,7 +132,7 @@ enum {
 };
 
 struct qcom_swrm_port_config {
-	u8 si;
+	u32 si;
 	u8 off1;
 	u8 off2;
 	u8 bp_mode;
@@ -806,12 +807,20 @@ static int qcom_swrm_transport_params(struct sdw_bus *bus,
 
 	value = pcfg->off1 << SWRM_DP_PORT_CTRL_OFFSET1_SHFT;
 	value |= pcfg->off2 << SWRM_DP_PORT_CTRL_OFFSET2_SHFT;
-	value |= pcfg->si;
+	value |= pcfg->si & 0xff;
 
 	ret = ctrl->reg_write(ctrl, reg, value);
 	if (ret)
 		goto err;
 
+	if (pcfg->si > 0xff) {
+		value = (pcfg->si >> 8) & 0xff;
+		reg = SWRM_DP_SAMPLECTRL2_BANK(params->port_num, bank);
+		ret = ctrl->reg_write(ctrl, reg, value);
+		if (ret)
+			goto err;
+	}
+
 	if (pcfg->lane_control != SWR_INVALID_PARAM) {
 		reg = SWRM_DP_PORT_CTRL_2_BANK(params->port_num, bank);
 		value = pcfg->lane_control;
@@ -1185,7 +1194,7 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
 	struct device_node *np = ctrl->dev->of_node;
 	u8 off1[QCOM_SDW_MAX_PORTS];
 	u8 off2[QCOM_SDW_MAX_PORTS];
-	u8 si[QCOM_SDW_MAX_PORTS];
+	u32 si[QCOM_SDW_MAX_PORTS];
 	u8 bp_mode[QCOM_SDW_MAX_PORTS] = { 0, };
 	u8 hstart[QCOM_SDW_MAX_PORTS];
 	u8 hstop[QCOM_SDW_MAX_PORTS];
@@ -1193,6 +1202,7 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
 	u8 blk_group_count[QCOM_SDW_MAX_PORTS];
 	u8 lane_control[QCOM_SDW_MAX_PORTS];
 	int i, ret, nports, val;
+	bool si_32 = false;
 
 	ctrl->reg_read(ctrl, SWRM_COMP_PARAMS, &val);
 
@@ -1236,9 +1246,14 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
 		return ret;
 
 	ret = of_property_read_u8_array(np, "qcom,ports-sinterval-low",
-					si, nports);
-	if (ret)
-		return ret;
+					(u8 *)si, nports);
+	if (ret) {
+		ret = of_property_read_u32_array(np, "qcom,ports-sinterval",
+						 si, nports);
+		if (ret)
+			return ret;
+		si_32 = true;
+	}
 
 	ret = of_property_read_u8_array(np, "qcom,ports-block-pack-mode",
 					bp_mode, nports);
@@ -1266,7 +1281,10 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
 
 	for (i = 0; i < nports; i++) {
 		/* Valid port number range is from 1-14 */
-		ctrl->pconfig[i + 1].si = si[i];
+		if (si_32)
+			ctrl->pconfig[i + 1].si = si[i];
+		else
+			ctrl->pconfig[i + 1].si = ((u8 *)si)[i];
 		ctrl->pconfig[i + 1].off1 = off1[i];
 		ctrl->pconfig[i + 1].off2 = off2[i];
 		ctrl->pconfig[i + 1].bp_mode = bp_mode[i];
-- 
2.34.1

