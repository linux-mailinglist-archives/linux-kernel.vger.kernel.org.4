Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F12F632261
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiKUMiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbiKUMiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:38:05 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C35D9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 04:38:04 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALARnTH010078
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 12:38:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=tKyahOyvv7NJSSQ3I1JSCs/ym0L7h8gpvO2DVKj+SZ0=;
 b=buhBCLRgjCMzpNBPsoW9CKRccmSUualLAkANAUEMcKcDbIMUKRmvcUiSOpx9/z4odTCK
 +Cfc1XG31mVZtwntfrHSyZJuMMeXedGMmdJNMdBqFe9AslGrHBi+kld9OXOHD8cD5uuI
 k975pb3PUUbtt/VP8xxmUz9fuvbhsSManOtpFLb1Cbdvejes3f44HuwnruSJ0hOy2QOs
 TaRytdXpas713JupWSI03sQwoNqdXyah9dw/xFt6DyvD3tpGOZ88HULTdjTkE2qfpB9a
 xddk2B/qR220yKsuYjRjCIXNLy0TVBiEp5+PaMpLrv983WwpysBunLVr6lnDYhHhjV6/ Gw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kxrf5mgur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 12:38:04 +0000
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2ALCc37e002007
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 12:38:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA04.qualcomm.com (PPS) with ESMTP id 3kxr7kf9fx-1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 12:38:03 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2ALCc3Ft001998
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 12:38:03 GMT
Received: from hu-devc-lv-u18-c.qualcomm.com (hu-vtanuku-lv.qualcomm.com [10.47.206.121])
        by NALASPPMTA04.qualcomm.com (PPS) with ESMTP id 2ALCc386001993;
        Mon, 21 Nov 2022 12:38:03 +0000
Received: by hu-devc-lv-u18-c.qualcomm.com (Postfix, from userid 410733)
        id 1A2165000A7; Mon, 21 Nov 2022 04:38:03 -0800 (PST)
From:   Visweswara Tanuku <quic_vtanuku@quicinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     quic_vnivarth@quicinc.com,
        Visweswara Tanuku <quic_vtanuku@quicinc.com>
Subject: [PATCH] soc: qcom-geni-se: Update Tx and Rx fifo depth based on QUP HW version
Date:   Mon, 21 Nov 2022 04:37:58 -0800
Message-Id: <20221121123758.5052-1-quic_vtanuku@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aRDF680FiBSvSlxiDMWQyLYEq9ZKsdqQ
X-Proofpoint-ORIG-GUID: aRDF680FiBSvSlxiDMWQyLYEq9ZKsdqQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_13,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=349 spamscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211210098
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From QUP HW Version 3.10 and above the Tx and Rx
fifo depth bits are increased to 23:16 bits from
21:16 bits in SE_HW_PARAM registers accomodating
256bytes of fifo depth.

Updated geni_se_get_tx_fifo_depth and
geni_se_get_rx_fifo_depth to retrieve right fifo
depth based on QUP HW version.

Signed-off-by: Visweswara Tanuku <quic_vtanuku@quicinc.com>
---
 include/linux/qcom-geni-se.h | 42 ++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/include/linux/qcom-geni-se.h b/include/linux/qcom-geni-se.h
index f5672785c0c4..5ea5351f8818 100644
--- a/include/linux/qcom-geni-se.h
+++ b/include/linux/qcom-geni-se.h
@@ -242,12 +242,22 @@ struct geni_se {
 /* SE_HW_PARAM_0 fields */
 #define TX_FIFO_WIDTH_MSK		GENMASK(29, 24)
 #define TX_FIFO_WIDTH_SHFT		24
+/*
+ * For QUP HW Version >= 3.10 Tx fifo depth support is increased
+ * to 256bytes and corresponding bits are 16 to 23
+ */
+#define TX_FIFO_DEPTH_MSK_256_BYTES	GENMASK(23, 16)
 #define TX_FIFO_DEPTH_MSK		GENMASK(21, 16)
 #define TX_FIFO_DEPTH_SHFT		16
 
 /* SE_HW_PARAM_1 fields */
 #define RX_FIFO_WIDTH_MSK		GENMASK(29, 24)
 #define RX_FIFO_WIDTH_SHFT		24
+/*
+ * For QUP HW Version >= 3.10 Rx fifo depth support is increased
+ * to 256bytes and corresponding bits are 16 to 23
+ */
+#define RX_FIFO_DEPTH_MSK_256_BYTES	GENMASK(23, 16)
 #define RX_FIFO_DEPTH_MSK		GENMASK(21, 16)
 #define RX_FIFO_DEPTH_SHFT		16
 
@@ -388,7 +398,8 @@ static inline void geni_se_abort_s_cmd(struct geni_se *se)
 
 /**
  * geni_se_get_tx_fifo_depth() - Get the TX fifo depth of the serial engine
- * @se:	Pointer to the concerned serial engine.
+ * based on QUP HW version
+ * @se: Pointer to the concerned serial engine.
  *
  * This function is used to get the depth i.e. number of elements in the
  * TX fifo of the serial engine.
@@ -397,11 +408,20 @@ static inline void geni_se_abort_s_cmd(struct geni_se *se)
  */
 static inline u32 geni_se_get_tx_fifo_depth(struct geni_se *se)
 {
-	u32 val;
+	u32 val, hw_version, hw_major, hw_minor, tx_fifo_depth_mask;
+
+	hw_version = geni_se_get_qup_hw_version(se);
+	hw_major = GENI_SE_VERSION_MAJOR(hw_version);
+	hw_minor = GENI_SE_VERSION_MINOR(hw_version);
+
+	if ((hw_major == 3 && hw_minor >= 10) || hw_major > 3)
+		tx_fifo_depth_mask = TX_FIFO_DEPTH_MSK_256_BYTES;
+	else
+		tx_fifo_depth_mask = TX_FIFO_DEPTH_MSK;
 
 	val = readl_relaxed(se->base + SE_HW_PARAM_0);
 
-	return (val & TX_FIFO_DEPTH_MSK) >> TX_FIFO_DEPTH_SHFT;
+	return (val & tx_fifo_depth_mask) >> TX_FIFO_DEPTH_SHFT;
 }
 
 /**
@@ -424,7 +444,8 @@ static inline u32 geni_se_get_tx_fifo_width(struct geni_se *se)
 
 /**
  * geni_se_get_rx_fifo_depth() - Get the RX fifo depth of the serial engine
- * @se:	Pointer to the concerned serial engine.
+ * based on QUP HW version
+ * @se: Pointer to the concerned serial engine.
  *
  * This function is used to get the depth i.e. number of elements in the
  * RX fifo of the serial engine.
@@ -433,11 +454,20 @@ static inline u32 geni_se_get_tx_fifo_width(struct geni_se *se)
  */
 static inline u32 geni_se_get_rx_fifo_depth(struct geni_se *se)
 {
-	u32 val;
+	u32 val, hw_version, hw_major, hw_minor, rx_fifo_depth_mask;
+
+	hw_version = geni_se_get_qup_hw_version(se);
+	hw_major = GENI_SE_VERSION_MAJOR(hw_version);
+	hw_minor = GENI_SE_VERSION_MINOR(hw_version);
+
+	if ((hw_major == 3 && hw_minor >= 10) || hw_major > 3)
+		rx_fifo_depth_mask = RX_FIFO_DEPTH_MSK_256_BYTES;
+	else
+		rx_fifo_depth_mask = RX_FIFO_DEPTH_MSK;
 
 	val = readl_relaxed(se->base + SE_HW_PARAM_1);
 
-	return (val & RX_FIFO_DEPTH_MSK) >> RX_FIFO_DEPTH_SHFT;
+	return (val & rx_fifo_depth_mask) >> RX_FIFO_DEPTH_SHFT;
 }
 
 void geni_se_init(struct geni_se *se, u32 rx_wm, u32 rx_rfr);
-- 
2.17.1

