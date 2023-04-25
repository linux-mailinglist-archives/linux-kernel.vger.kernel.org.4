Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6D96EDAC7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 05:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbjDYDk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 23:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbjDYDk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 23:40:26 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAC249D0;
        Mon, 24 Apr 2023 20:40:25 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33P2pxIA004558;
        Tue, 25 Apr 2023 03:40:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=mLoX4ukwOk4CWgEN8Yzoc4h9L2sozABzLHdg8UKrfwE=;
 b=hrEmH1HEn2OqniqRgoxvmrFsidSETZ/nkp5DwmKjYqjiM3CBPIMpSUGROC9kh8WUxKwb
 Wnr4aK/BohT+U/Q4qYzVEe7jZNAT/T0APPjWD/+jAAPnwi4T5+iJwR5XrhTiI+Lw0Rfc
 h9KrZpM+FGWlP+PzYHVhQ5bBiGNVviYC7fJLFN8gMZUVhFK44CNgwJyjNvNEeDCTqE3y
 Xnw2S40JPYTSKN/DZzK7WjAftlJtBt3juhVQ7pxbRjqpOdU/4iRjSCarD4nkwgD+psWq
 EQNPuef/b9BmoysctX5CX/DDZZxRUQYjXqdE93WJamu5ESSA8x9d7N2PEF5bVOh7ktjT 5Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q5mnnjcmr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 03:40:17 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33P3eG7g009992
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 03:40:16 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 24 Apr 2023 20:40:16 -0700
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
Subject: [PATCH 2/7] phy: qcom-qmp-combo: Move phy_mutex out of com_init/exit
Date:   Mon, 24 Apr 2023 20:40:05 -0700
Message-ID: <20230425034010.3789376-3-quic_bjorande@quicinc.com>
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
X-Proofpoint-GUID: D5wA9bIXoyFj-Shs-ju7bkVsS-UuJsIP
X-Proofpoint-ORIG-GUID: D5wA9bIXoyFj-Shs-ju7bkVsS-UuJsIP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_03,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 spamscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250031
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the upcoming introduction of USB Type-C orientation switching the
region of mutual exclusion needs to be extended to cover both the common
init/exit as well as the individual functions.

So move the phy_mutex one step up the stack.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 51 +++++++++++++----------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 6850e04c329b..7280f7141961 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -2463,16 +2463,13 @@ static int qmp_combo_com_init(struct qmp_combo *qmp)
 	void __iomem *com = qmp->com;
 	int ret;
 
-	mutex_lock(&qmp->phy_mutex);
-	if (qmp->init_count++) {
-		mutex_unlock(&qmp->phy_mutex);
+	if (qmp->init_count++)
 		return 0;
-	}
 
 	ret = regulator_bulk_enable(cfg->num_vregs, qmp->vregs);
 	if (ret) {
 		dev_err(qmp->dev, "failed to enable regulators, err=%d\n", ret);
-		goto err_unlock;
+		goto err;
 	}
 
 	ret = reset_control_bulk_assert(cfg->num_resets, qmp->resets);
@@ -2514,16 +2511,13 @@ static int qmp_combo_com_init(struct qmp_combo *qmp)
 	qphy_setbits(qmp->pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
 			SW_PWRDN);
 
-	mutex_unlock(&qmp->phy_mutex);
-
 	return 0;
 
 err_assert_reset:
 	reset_control_bulk_assert(cfg->num_resets, qmp->resets);
 err_disable_regulators:
 	regulator_bulk_disable(cfg->num_vregs, qmp->vregs);
-err_unlock:
-	mutex_unlock(&qmp->phy_mutex);
+err:
 
 	return ret;
 }
@@ -2532,11 +2526,8 @@ static int qmp_combo_com_exit(struct qmp_combo *qmp)
 {
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
 
-	mutex_lock(&qmp->phy_mutex);
-	if (--qmp->init_count) {
-		mutex_unlock(&qmp->phy_mutex);
+	if (--qmp->init_count)
 		return 0;
-	}
 
 	reset_control_bulk_assert(cfg->num_resets, qmp->resets);
 
@@ -2544,8 +2535,6 @@ static int qmp_combo_com_exit(struct qmp_combo *qmp)
 
 	regulator_bulk_disable(cfg->num_vregs, qmp->vregs);
 
-	mutex_unlock(&qmp->phy_mutex);
-
 	return 0;
 }
 
@@ -2555,21 +2544,29 @@ static int qmp_combo_dp_init(struct phy *phy)
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
 	int ret;
 
+	mutex_lock(&qmp->phy_mutex);
+
 	ret = qmp_combo_com_init(qmp);
 	if (ret)
-		return ret;
+		goto out_unlock;
 
 	cfg->dp_aux_init(qmp);
 
-	return 0;
+out_unlock:
+	mutex_unlock(&qmp->phy_mutex);
+	return ret;
 }
 
 static int qmp_combo_dp_exit(struct phy *phy)
 {
 	struct qmp_combo *qmp = phy_get_drvdata(phy);
 
+	mutex_lock(&qmp->phy_mutex);
+
 	qmp_combo_com_exit(qmp);
 
+	mutex_unlock(&qmp->phy_mutex);
+
 	return 0;
 }
 
@@ -2686,14 +2683,19 @@ static int qmp_combo_usb_init(struct phy *phy)
 	struct qmp_combo *qmp = phy_get_drvdata(phy);
 	int ret;
 
+	mutex_lock(&qmp->phy_mutex);
 	ret = qmp_combo_com_init(qmp);
 	if (ret)
-		return ret;
+		goto out_unlock;
 
 	ret = qmp_combo_usb_power_on(phy);
-	if (ret)
+	if (ret) {
 		qmp_combo_com_exit(qmp);
+		goto out_unlock;
+	}
 
+out_unlock:
+	mutex_unlock(&qmp->phy_mutex);
 	return ret;
 }
 
@@ -2702,11 +2704,18 @@ static int qmp_combo_usb_exit(struct phy *phy)
 	struct qmp_combo *qmp = phy_get_drvdata(phy);
 	int ret;
 
+	mutex_lock(&qmp->phy_mutex);
 	ret = qmp_combo_usb_power_off(phy);
 	if (ret)
-		return ret;
+		goto out_unlock;
 
-	return qmp_combo_com_exit(qmp);
+	ret = qmp_combo_com_exit(qmp);
+	if (ret)
+		goto out_unlock;
+
+out_unlock:
+	mutex_unlock(&qmp->phy_mutex);
+	return ret;
 }
 
 static int qmp_combo_usb_set_mode(struct phy *phy, enum phy_mode mode, int submode)
-- 
2.39.2

