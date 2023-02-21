Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F23269DEC8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 12:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbjBUL1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 06:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbjBUL0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 06:26:53 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA1325BB2;
        Tue, 21 Feb 2023 03:26:43 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31L6tqin018089;
        Tue, 21 Feb 2023 11:26:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=TcziFNzo6w/1eDpF33ybbfCgf5liqThhc/yZzX+FQd0=;
 b=HkO6/mMkV1JBvZXK5rIdpO5Fk5o+2dCg6us+OAxSosgJ/wHdUX0ipMG2PZ+vDwsRqIlo
 uPd2kqiojfY4ScUc/5/mRF7WEj1AN72siwm3y1jyTuDzX50QzZBv5HOF9Rr1yt24xNRl
 W2PCjW//0v618qxe0UcaXqcLI0eEwOHwepTUg+xyxazzvno/3IcTmwSRKQs/kJInswfn
 nouIE8Q/RtT5QrxABOJ99W7uDN9vQBvCYJ0gnA/GXmZq9NlZOVBBOt71/mjPMHOH1N9k
 W8fe35w7RvQ3dTWx3yqJxmgn/8B1ohT0IbtbYYrXbgZQTQBmLj60U8FZ8nY6vj9bA1xj tQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nvprgrvyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 11:26:28 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31LBQRkv007449
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 11:26:27 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 21 Feb 2023 03:26:23 -0800
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <keescook@chromium.org>,
        <tony.luck@intel.com>, <gpiccoli@igalia.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [RFC PATCH 5/6] remoterproc: qcom: refactor to leverage exported minidump symbol
Date:   Tue, 21 Feb 2023 16:55:12 +0530
Message-ID: <1676978713-7394-6-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1676978713-7394-1-git-send-email-quic_mojha@quicinc.com>
References: <1676978713-7394-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: b7-B17u5Sf5A51gBHlHomjhYIwez2F5m
X-Proofpoint-ORIG-GUID: b7-B17u5Sf5A51gBHlHomjhYIwez2F5m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_06,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302210098
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
index f607e1e..273f92b 100644
--- a/drivers/remoteproc/qcom_common.c
+++ b/drivers/remoteproc/qcom_common.c
@@ -89,19 +89,10 @@ void qcom_minidump(struct rproc *rproc, unsigned int minidump_id)
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

