Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1EA6EDAC6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 05:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjDYDkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 23:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbjDYDk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 23:40:26 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7E049E5;
        Mon, 24 Apr 2023 20:40:25 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33P0xmG8004207;
        Tue, 25 Apr 2023 03:40:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=bvX2vYXIK5cZmgjxE+3RHUQVscZvlNVm5kEYWLq3lP8=;
 b=E+BqtKuklLqmus8vMW0PGYL0wl2YP9MawXUrY5fuJzmUtuauWfhDgfsmLB19LEoi1VHQ
 1L0cF+kGekxJLnx15+u8HjmrnN8R6p0ZhNRVt0WmeyOTrjfEfWNXg4vm77KGrKNw2auz
 ZgN4OFX+feNIamCSz1nm3QhmPn6/Obm7vQEjmogL5ZDclgN9Kg5jBK7O+DqbRiY7pexc
 2xyymTDa//S9cwNl/U4fvBMfnNTk4DYEWvDgcZfxmAGyEsiKXfLPYQVc3BxSFQGFKkE+
 rffEBWjGn2+Vrkp0FoHLpdLXXB/OnOmc4lWu8j2ibvk92YfrYdu60S8/+sjEp+FESACO Lg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q5tk4hjg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 03:40:18 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33P3eHOY024339
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 03:40:17 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 24 Apr 2023 20:40:17 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Johan Hovold <johan@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/7] phy: qcom-qmp-combo: Introduce drm_bridge
Date:   Mon, 24 Apr 2023 20:40:08 -0700
Message-ID: <20230425034010.3789376-6-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230425034010.3789376-1-quic_bjorande@quicinc.com>
References: <20230425034010.3789376-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LvqiY1XxRLtCB4JwAZpiN4ZmGT6nrRFF
X-Proofpoint-GUID: LvqiY1XxRLtCB4JwAZpiN4ZmGT6nrRFF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_03,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304250031
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QMP combo PHY sits in an of_graph connected between the DisplayPort
controller and a USB Type-C connector (or possibly a redriver).

The TCPM needs to be able to convey the HPD signal to the DisplayPort
controller, but no directly link is provided by DeviceTree so the signal
needs to "pass through" the QMP combo phy.

Handle this by introducing a drm_bridge which upon initialization finds
the next bridge (i.e. the usb-c-connector) and chain this together. This
way HPD changes in the connector will propagate to the DisplayPort
driver.

The connector bridge is resolved lazily, as the TCPM is expected to be
able to resolve the typec mux and switch at probe time, so the QMP combo
phy will probe before the TCPM.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 36 +++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 5d6d6ef3944b..84bc08002537 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -22,6 +22,8 @@
 #include <linux/usb/typec.h>
 #include <linux/usb/typec_mux.h>
 
+#include <drm/drm_bridge.h>
+
 #include <dt-bindings/phy/phy-qcom-qmp.h>
 
 #include "phy-qcom-qmp.h"
@@ -1332,6 +1334,8 @@ struct qmp_combo {
 	struct clk_hw dp_link_hw;
 	struct clk_hw dp_pixel_hw;
 
+	struct drm_bridge bridge;
+
 	struct typec_switch_dev *sw;
 	enum typec_orientation orientation;
 };
@@ -3196,6 +3200,34 @@ static int qmp_combo_register_clocks(struct qmp_combo *qmp, struct device_node *
 	return devm_add_action_or_reset(qmp->dev, phy_clk_release_provider, dp_np);
 }
 
+static int qmp_combo_bridge_attach(struct drm_bridge *bridge,
+				   enum drm_bridge_attach_flags flags)
+{
+	struct qmp_combo *qmp = container_of(bridge, struct qmp_combo, bridge);
+	struct drm_bridge *next_bridge;
+
+	if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR))
+		return -EINVAL;
+
+	next_bridge = devm_drm_of_get_bridge(qmp->dev, qmp->dev->of_node, 0, 0);
+	if (IS_ERR(next_bridge))
+		return dev_err_probe(qmp->dev, PTR_ERR(next_bridge), "failed to acquire drm_bridge\n");
+
+	return drm_bridge_attach(bridge->encoder, next_bridge, bridge, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+}
+
+static const struct drm_bridge_funcs qmp_combo_bridge_funcs = {
+	.attach	= qmp_combo_bridge_attach,
+};
+
+static int qmp_combo_dp_register_bridge(struct qmp_combo *qmp)
+{
+	qmp->bridge.funcs = &qmp_combo_bridge_funcs;
+	qmp->bridge.of_node = qmp->dev->of_node;
+
+	return devm_drm_bridge_add(qmp->dev, &qmp->bridge);
+}
+
 static int qmp_combo_parse_dt_lecacy_dp(struct qmp_combo *qmp, struct device_node *np)
 {
 	struct device *dev = qmp->dev;
@@ -3459,6 +3491,10 @@ static int qmp_combo_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = qmp_combo_dp_register_bridge(qmp);
+	if (ret)
+		return ret;
+
 	/* Check for legacy binding with child nodes. */
 	usb_np = of_get_child_by_name(dev->of_node, "usb3-phy");
 	if (usb_np) {
-- 
2.39.2

