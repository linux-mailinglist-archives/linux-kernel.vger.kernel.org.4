Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B3E6BEE45
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 17:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjCQQ3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 12:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjCQQ2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 12:28:48 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9950E2760;
        Fri, 17 Mar 2023 09:28:37 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32HEoEud005689;
        Fri, 17 Mar 2023 16:28:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=rOqyaP58V4I+pR9h3qJL/GGfnieE1g/V9Z3CjuwrvLA=;
 b=VufqM+efoOZfGFr9ACg+vKt3lYzIjb9Tn4qJPEmEcbZH8Slye90f5uA18j16c6z006Cy
 KutRqNs2UDFOW4wF19u5bEiIj8sZ0Xgc5NcgFolIuLsMTCt0xa40PhuSoI5H7bcnmfBZ
 14l56gVJO+g/Pm+d2oi0FdJ5kfadl8TPR2HATMvyb2FRKntMaxrbugwqalk/nNiTCtYL
 qgo0dx1I0s0H9TJUd+8kWAS728gLrXMGMgu3A4VO9Ww4vzVKuSncQ5SFJfw1QOnwbzrt
 VnM2JGWxMtQdWRAErTuCPPuAwjJ9bqXmkXEWw+xf/IU9tDPO6CsICkWFz0JIH40Lc4y0 nw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pctap8f3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 16:28:35 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32HGSYlP031407
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 16:28:34 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 17 Mar 2023 09:28:31 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linus.walleij@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, Mukesh Ojha <quic_mojha@quicinc.com>,
        Poovendhan Selvaraj <quic_poovendh@quicinc.com>
Subject: [PATCH v3 3/5] firmware: scm: Modify only the download bits in TCSR register
Date:   Fri, 17 Mar 2023 21:58:00 +0530
Message-ID: <1679070482-8391-4-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1679070482-8391-1-git-send-email-quic_mojha@quicinc.com>
References: <1679070482-8391-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xYFq1WydpWgW5O39-yGMCt-Fv9YFcKEf
X-Proofpoint-GUID: xYFq1WydpWgW5O39-yGMCt-Fv9YFcKEf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_10,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303170110
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CrashDump collection is based on the DLOAD bit of TCSR register.
To retain other bits, we read the register and modify only the
DLOAD bit as the other bits have their own significance.

Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/firmware/qcom_scm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index aca2556..eb491da 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -30,6 +30,8 @@ module_param(download_mode, bool, 0);
 #define SCM_HAS_IFACE_CLK	BIT(1)
 #define SCM_HAS_BUS_CLK		BIT(2)
 
+#define QCOM_DOWNLOAD_MODE_MASK 0x30
+
 struct qcom_scm {
 	struct device *dev;
 	struct clk *core_clk;
@@ -448,7 +450,8 @@ static void qcom_scm_set_download_mode(bool enable)
 	if (avail) {
 		ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
 	} else if (__scm->dload_mode_addr) {
-		ret = qcom_scm_io_writel(__scm->dload_mode_addr,
+		ret = qcom_scm_io_update_field(__scm->dload_mode_addr,
+				QCOM_DOWNLOAD_MODE_MASK,
 				enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0);
 	} else {
 		dev_err(__scm->dev,
-- 
2.7.4

