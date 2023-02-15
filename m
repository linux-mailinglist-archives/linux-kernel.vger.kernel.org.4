Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552E36975AB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 06:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbjBOFFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 00:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBOFFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 00:05:47 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9BA28221;
        Tue, 14 Feb 2023 21:05:46 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31F4G0E2014845;
        Wed, 15 Feb 2023 05:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=z16GGCBpKwEvBuB2oLs3wE4UgR+zoXFcFzJ50HDfsTo=;
 b=UjMtutp15otkFySrkeFZ+3s9i0NV7Rt3bbSccaBHKtq9J+uModsaosy5kmjbVs9Zf/bX
 /zUXqDQljaElM/Aj1Mr7g5szoY0thPU2EykQHVaQTHxv8d5qOLnvgwIBgmnGEDC03p+3
 VOsBncAqEzbQx5ZcH/Luc2TwSj+ms3syMDh03Q2ylKZ9hkeTUQcmDdA0Gc2SumHkCJU5
 KnSkk9wV10voMulIaMv7LobL8DAYfh/1A764kR5zeD510YCLC2fXBWrlEwUtbg4BpN78
 n4PG5r5VCDjQIs1lzW0RSVBiFh9LhGf7hnBpgohffkylnkFyJ8FmMR6UUzdcfkIsr2uw 1A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nqts7vdp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 05:05:42 +0000
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 31F55fug018995;
        Wed, 15 Feb 2023 05:05:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 3np43n406e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 15 Feb 2023 05:05:41 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31F55eHh018981;
        Wed, 15 Feb 2023 05:05:40 GMT
Received: from hu-devc-lv-u18-c.qualcomm.com (hu-vtanuku-lv.qualcomm.com [10.47.206.121])
        by NALASPPMTA04.qualcomm.com (PPS) with ESMTP id 31F55eCp018980;
        Wed, 15 Feb 2023 05:05:40 +0000
Received: by hu-devc-lv-u18-c.qualcomm.com (Postfix, from userid 410733)
        id 83B2E5000A7; Tue, 14 Feb 2023 21:05:40 -0800 (PST)
From:   Visweswara Tanuku <quic_vtanuku@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org,
        gregkh@linuxfoundation.org, konrad.dybcio@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_eberman@quicinc.com, quic_satyap@quicinc.com,
        quic_msavaliy@quicinc.com, quic_vnivarth@quicinc.com,
        Visweswara Tanuku <quic_vtanuku@quicinc.com>
Subject: [PATCH] soc: qcom: geni-se: Update Tx and Rx fifo depth based on QUP HW version
Date:   Tue, 14 Feb 2023 21:05:28 -0800
Message-Id: <20230215050528.9507-1-quic_vtanuku@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: b2zfzd_rlakrp4I6WdhWi3GmLZWvcLH5
X-Proofpoint-ORIG-GUID: b2zfzd_rlakrp4I6WdhWi3GmLZWvcLH5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_02,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=417 mlxscore=0 impostorscore=0 spamscore=0 phishscore=0
 clxscore=1011 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302150045
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
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
 include/linux/soc/qcom/geni-se.h | 42 +++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/include/linux/soc/qcom/geni-se.h b/include/linux/soc/qcom/geni-se.h
index 400213daa461..c55a0bc8cb0e 100644
--- a/include/linux/soc/qcom/geni-se.h
+++ b/include/linux/soc/qcom/geni-se.h
@@ -245,12 +245,22 @@ struct geni_se {
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
 
@@ -391,7 +401,8 @@ static inline void geni_se_abort_s_cmd(struct geni_se *se)
 
 /**
  * geni_se_get_tx_fifo_depth() - Get the TX fifo depth of the serial engine
- * @se:	Pointer to the concerned serial engine.
+ * based on QUP HW version
+ * @se: Pointer to the concerned serial engine.
  *
  * This function is used to get the depth i.e. number of elements in the
  * TX fifo of the serial engine.
@@ -400,11 +411,20 @@ static inline void geni_se_abort_s_cmd(struct geni_se *se)
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
@@ -427,7 +447,8 @@ static inline u32 geni_se_get_tx_fifo_width(struct geni_se *se)
 
 /**
  * geni_se_get_rx_fifo_depth() - Get the RX fifo depth of the serial engine
- * @se:	Pointer to the concerned serial engine.
+ * based on QUP HW version
+ * @se: Pointer to the concerned serial engine.
  *
  * This function is used to get the depth i.e. number of elements in the
  * RX fifo of the serial engine.
@@ -436,11 +457,20 @@ static inline u32 geni_se_get_tx_fifo_width(struct geni_se *se)
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

