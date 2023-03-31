Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75436D262B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 18:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbjCaQsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 12:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjCaQry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 12:47:54 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0819746BE
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:45:39 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id x17so29723602lfu.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680281138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEC86w6mjGLupeK5H+hGWpVXZB98Fs+7rvadaDpP8J4=;
        b=p85ERDf/jMV4ob2/oqgTlrWAK3V19HCBtPsq9MXOplwdSl0R3QzzDYLWADWpnnoYc/
         wxfqzK1fzWD3Uj/hL23h2O3sgy1glBnuA+vPr3ih0/0TtL0ChflFe5EkkUXlg53gxR79
         rsfkfyN9NBftT21Ui+t4HQZ7LiNtFErXpTEBGML1IdkPlw7QgGAsOj5SB5XqEqDM3wBk
         GJgGzwZ/Z1ybCxXG1fa/5drXNQORJcSsmaph67/IGOa7pDpWwT8QMFhGpDg9JJlOCCFv
         0zogtU9iIO/pct0dQtTK4TCToH5XC+to+gNRV8HbBQu6t7Exxi2vYl6LiGT13OqBC5Qn
         qmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680281138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NEC86w6mjGLupeK5H+hGWpVXZB98Fs+7rvadaDpP8J4=;
        b=2SoXf5Zj2r8aQXaLHIEYP5kuAVc4Auu4GH9Xjc6M/TYsKB2LZdhSykUpjCGhwKLGZj
         juESrSrCXCM8SduSyAval9Bl9ZpqtAcuq2TFmgMkf9RHlcsO7opwjCUPfSbRuOkQ5XvO
         yvLMK0XmakdU4uRFB9n6o/dUP3x4TDInMDLx29g8GuYMgSZ9km1CHPzVt6WFpsGN6ZTu
         0ihydIMsQmGPPwdhwZgtmQFZFCE7mfcpfYqF9N0lY8a12PBd6db0q6HGN30z+POx79Lo
         zv86dQ2EdR7FotyolfmaXEx9qiGx+2iBwrEjkh/YHJ+AQlQnnoOV5I7VKRhDlzuGSUYV
         Jz7A==
X-Gm-Message-State: AAQBX9dJHVCgl4rBSIgsunJImRm75Vzjnkk/aXqHTO2lOOdI9NvGVckn
        /tpLsqjswPWsI+F90ISSpE7nsg==
X-Google-Smtp-Source: AKy350aKcKEyQ3S6iCH2Xpl5FdJpp5gJCNqjLHpViOd03ipHhs/BsroiJf7eTbN5CTyAQYKhu4V+nw==
X-Received: by 2002:a05:6512:204:b0:4b4:e14a:ec7d with SMTP id a4-20020a056512020400b004b4e14aec7dmr8057796lfo.17.1680281138238;
        Fri, 31 Mar 2023 09:45:38 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u26-20020ac2519a000000b004e8483bff82sm439872lfi.271.2023.03.31.09.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 09:45:37 -0700 (PDT)
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
Subject: [PATCH 3/7] soundwire: qcom: allow 16-bit sample interval for ports
Date:   Fri, 31 Mar 2023 18:45:26 +0200
Message-Id: <20230331164530.227302-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230331164530.227302-1-krzysztof.kozlowski@linaro.org>
References: <20230331164530.227302-1-krzysztof.kozlowski@linaro.org>
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
 drivers/soundwire/qcom.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index c296e0bf897b..80147fd0294b 100644
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
+	};
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

