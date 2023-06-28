Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD4574115A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 14:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbjF1Mjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 08:39:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131]:50678 "EHLO
        mx0b-0031df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232100AbjF1Mhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 08:37:33 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SCQcpx013316;
        Wed, 28 Jun 2023 12:37:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=voO1wmpy58Dpce/ayyfsuuOHNRZFLt28O+ScPtTvxDU=;
 b=U2rtcJ/ZAL/atIwFCGFN28JlUInAruvSQINjwU6cgKCnlNO/TkrNkoGv+VKQcpOHJJfv
 RILmfmti9Y7TjfEhmV70HaMrg+QOa7IRDDccOX3afk/MT7sPAnw5oRy0HkqAjuOtxR9A
 5V24edg0RnlO7sWp/tmsackW0JgVYNklXdBW6amoEjHu1mYv2U0YCWY2z4OPGSr3s2/x
 PQJOJFehWkWJEnUI3PiObxYO0z2qDeyGyUsOU/DppVptiEsOfz3KR7o79xZ9TlZBP3d5
 lPZr3eEFRpW0vFpcVmZvxeof+dWcgTM3WjDKG2Uw0slxAtBtu+s+O1HAsWXRaF+FNTP1 Hg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rfrdtbqa0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 12:37:13 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35SCbCFL002061
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 12:37:12 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 28 Jun 2023 05:37:05 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <corbet@lwn.net>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>,
        "Mukesh Ojha" <quic_mojha@quicinc.com>
Subject: [PATCH v4 17/21] firmware: qcom_scm: provide a read-modify-write function
Date:   Wed, 28 Jun 2023 18:04:44 +0530
Message-ID: <1687955688-20809-18-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vfaykQFcelw4SH3fZYkfHb4aTKdaVkU3
X-Proofpoint-GUID: vfaykQFcelw4SH3fZYkfHb4aTKdaVkU3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_08,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 phishscore=0 mlxlogscore=797
 lowpriorityscore=0 clxscore=1015 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280111
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was realized by Srinivas K. that there is a need of
read-modify-write scm exported function so that it can
be used by multiple clients.

Let's introduce qcom_scm_io_update_field() which masks
out the bits and write the passed value to that
bit-offset. Subsequent patch will use this function.

Suggested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/firmware/qcom_scm.c            | 15 +++++++++++++++
 include/linux/firmware/qcom/qcom_scm.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index fde33acd46b7..104d86e49b97 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -407,6 +407,21 @@ int qcom_scm_set_remote_state(u32 state, u32 id)
 }
 EXPORT_SYMBOL(qcom_scm_set_remote_state);
 
+int qcom_scm_io_update_field(phys_addr_t addr, unsigned int mask, unsigned int val)
+{
+	unsigned int old, new;
+	int ret;
+
+	ret = qcom_scm_io_readl(addr, &old);
+	if (ret)
+		return ret;
+
+	new = (old & ~mask) | (val & mask);
+
+	return qcom_scm_io_writel(addr, new);
+}
+EXPORT_SYMBOL(qcom_scm_io_update_field);
+
 static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
 {
 	struct qcom_scm_desc desc = {
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index 250ea4efb7cb..ca41e4eb33ad 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -84,6 +84,8 @@ extern bool qcom_scm_pas_supported(u32 peripheral);
 
 extern int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val);
 extern int qcom_scm_io_writel(phys_addr_t addr, unsigned int val);
+extern int qcom_scm_io_update_field(phys_addr_t addr, unsigned int mask,
+				    unsigned int val);
 
 extern bool qcom_scm_restore_sec_cfg_available(void);
 extern int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare);
-- 
2.7.4

