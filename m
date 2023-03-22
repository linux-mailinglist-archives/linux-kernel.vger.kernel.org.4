Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3C56C4BD4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 14:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjCVNbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 09:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjCVNba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:31:30 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A3910D1;
        Wed, 22 Mar 2023 06:31:26 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32MCpcd5032660;
        Wed, 22 Mar 2023 13:31:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=8nYnzsuGMPsj8JOqe13LRPBczbL/fuoMs9/mE/rmmaE=;
 b=X03QKN4NYu93RufzwPPydp0MUvzRl2QbwkZ5aMhMaERjnrmUwBAPPXaDRem9cuwCblM4
 k+e1TuIzhD9Q1BPQ7j6tCBR811PYbckhbuwqIFgtZO4oDp2fvaCPVu7GSCcQGioe2Qzp
 4zcbihYfW/3S4Kx8zth+OrcVQv+//YJWsCBXDsV8FPVCDLUfaBBXVIuI9NYpPhhC4NZ8
 nW96oqJiBrtALUW3nMOtgiFqvei3/OKGZsSL4rERHrWw3stoniwRpESz4VlBypNdI0MA
 EIms2nO30dIuDIy+DOC9dnwNXUXgFHjFuKBnjXEIpnWzyIiOOP15lo4XfPLp+HMVa4ZI VA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pfhnx284y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 13:31:10 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32MDV9rj013613
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 13:31:09 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 22 Mar 2023 06:31:04 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <corbet@lwn.net>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, "Mukesh Ojha" <quic_mojha@quicinc.com>
Subject: [PATCH v2 6/6] remoterproc: qcom: refactor to leverage exported minidump symbol
Date:   Wed, 22 Mar 2023 19:00:17 +0530
Message-ID: <1679491817-2498-7-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1679491817-2498-1-git-send-email-quic_mojha@quicinc.com>
References: <1679491817-2498-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OnW_maYzV8fjuRDitSe10T3kXENK82Hk
X-Proofpoint-ORIG-GUID: OnW_maYzV8fjuRDitSe10T3kXENK82Hk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_11,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303220098
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qcom_minidump driver provides qcom_minidump_subsystem_desc()
exported API which other driver can use it query subsystem
descriptor. Refactor qcom_minidump() to use this symbol.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/remoteproc/qcom_common.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
index 88fc984..240e9f7 100644
--- a/drivers/remoteproc/qcom_common.c
+++ b/drivers/remoteproc/qcom_common.c
@@ -94,19 +94,10 @@ void qcom_minidump(struct rproc *rproc, unsigned int minidump_id,
 {
 	int ret;
 	struct minidump_subsystem *subsystem;
-	struct minidump_global_toc *toc;
 
-	/* Get Global minidump ToC*/
-	toc = qcom_smem_get(QCOM_SMEM_HOST_ANY, SBL_MINIDUMP_SMEM_ID, NULL);
-
-	/* check if global table pointer exists and init is set */
-	if (IS_ERR(toc) || !toc->status) {
-		dev_err(&rproc->dev, "Minidump TOC not found in SMEM\n");
+	subsystem = qcom_minidump_subsystem_desc(minidump_id);
+	if (IS_ERR(subsystem))
 		return;
-	}
-
-	/* Get subsystem table of contents using the minidump id */
-	subsystem = &toc->subsystems[minidump_id];
 
 	/**
 	 * Collect minidump if SS ToC is valid and segment table
-- 
2.7.4

