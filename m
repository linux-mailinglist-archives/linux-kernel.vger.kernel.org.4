Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9037741113
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 14:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjF1Miq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 08:38:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131]:19726 "EHLO
        mx0b-0031df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231920AbjF1Mg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 08:36:57 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35S6A6Mp009106;
        Wed, 28 Jun 2023 12:36:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=djE97bwYNjcxAluIW2+Cfgiqlpbzj4NG+dPedZwtHls=;
 b=ZkqpxLSH9zR99JHx/OcyvykWqTnmoepPGhrHscWSAH3MpiJDNeYbGbmpyKbIULzsDvyd
 iMHPWOX0HXTt02oNetLKgrcmEPkuY3dnjKnEECKhcOoaHmJc80noGp9EXrrcUL3/6KFP
 o/lbMeGYZx6MmELU2UbIcjjgWtTvq1LR5YIUYG3epD6TuRpSfSHgBeEDtpgTjLvwi3wu
 hnhOu7IMXR+9t7wrwthveErQVZ+rv4BCveiBe3WAx7vz31PsiT2NpYXXeC1KuvZI/Gm9
 HT1bMY0fKig8EfaeL4Q1orQ5kKYXEOBUQ1B7xhMpFlEDncMZm5IGd9Gx0XzEXfu9F/Jg IQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rgemk0x78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 12:36:38 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35SCab3x026965
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 12:36:37 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 28 Jun 2023 05:36:30 -0700
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
Subject: [PATCH v4 12/21] remoteproc: qcom: Expand MD_* as MINIDUMP_*
Date:   Wed, 28 Jun 2023 18:04:39 +0530
Message-ID: <1687955688-20809-13-git-send-email-quic_mojha@quicinc.com>
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
X-Proofpoint-GUID: I06AKbz5qS12S7u74FTJu05S2HG2AFk-
X-Proofpoint-ORIG-GUID: I06AKbz5qS12S7u74FTJu05S2HG2AFk-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_08,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280111
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expand MD_* as MINIDUMP_* which makes more sense than the
abbreviation.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/remoteproc/qcom_common.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
index a0d4238492e9..805e525df3b5 100644
--- a/drivers/remoteproc/qcom_common.c
+++ b/drivers/remoteproc/qcom_common.c
@@ -29,9 +29,9 @@
 #define MAX_NUM_OF_SS           10
 #define MAX_REGION_NAME_LENGTH  16
 #define SBL_MINIDUMP_SMEM_ID	602
-#define MD_REGION_VALID		('V' << 24 | 'A' << 16 | 'L' << 8 | 'I' << 0)
-#define MD_SS_ENCR_DONE		('D' << 24 | 'O' << 16 | 'N' << 8 | 'E' << 0)
-#define MD_SS_ENABLED		('E' << 24 | 'N' << 16 | 'B' << 8 | 'L' << 0)
+#define MINIDUMP_REGION_VALID		('V' << 24 | 'A' << 16 | 'L' << 8 | 'I' << 0)
+#define MINIDUMP_SS_ENCR_DONE		('D' << 24 | 'O' << 16 | 'N' << 8 | 'E' << 0)
+#define MINIDUMP_SS_ENABLED		('E' << 24 | 'N' << 16 | 'B' << 8 | 'L' << 0)
 
 /**
  * struct minidump_region - Minidump region
@@ -125,7 +125,7 @@ static int qcom_add_minidump_segments(struct rproc *rproc, struct minidump_subsy
 
 	for (i = 0; i < seg_cnt; i++) {
 		memcpy_fromio(&region, ptr + i, sizeof(region));
-		if (le32_to_cpu(region.valid) == MD_REGION_VALID) {
+		if (le32_to_cpu(region.valid) == MINIDUMP_REGION_VALID) {
 			name = kstrndup(region.name, MAX_REGION_NAME_LENGTH - 1, GFP_KERNEL);
 			if (!name) {
 				iounmap(ptr);
@@ -168,8 +168,8 @@ void qcom_minidump(struct rproc *rproc, unsigned int minidump_id,
 	 */
 	if (subsystem->regions_baseptr == 0 ||
 	    le32_to_cpu(subsystem->status) != 1 ||
-	    le32_to_cpu(subsystem->enabled) != MD_SS_ENABLED ||
-	    le32_to_cpu(subsystem->encryption_status) != MD_SS_ENCR_DONE) {
+	    le32_to_cpu(subsystem->enabled) != MINIDUMP_SS_ENABLED ||
+	    le32_to_cpu(subsystem->encryption_status) != MINIDUMP_SS_ENCR_DONE) {
 		dev_err(&rproc->dev, "Minidump not ready, skipping\n");
 		return;
 	}
-- 
2.7.4

