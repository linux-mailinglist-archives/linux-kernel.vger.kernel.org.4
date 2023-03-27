Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175CF6CAADF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjC0Qmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbjC0Qly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:41:54 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646C4271E;
        Mon, 27 Mar 2023 09:41:51 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32RDv4BU015017;
        Mon, 27 Mar 2023 16:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=WBWxgfw1drJhnxfAO2rN43QRoy939GS0Cvk3nm2plig=;
 b=ZLtWQLMDnuE9j9VtCphYcvdC7H3nVVw23nBKbCghUt0+9Q7T0gIbji6UsRfsXQ2MAXNN
 1Icmwg4oov1BtnJuT7pj9NSyzhq/6Gex1EorhVh+iJpAEfeWTMbOTP5uOOse6CGsohhD
 rWsO6nibtVNBIeYDumVtv5gNKQ3+sK3Q/EsC/Jq8D1EvUNi/cg6rlv8U92DS5NtAMnxz
 4kzA7rD4LWiao40rdIu6n2Qkfcx6t8mMY8biq1Ohbzc4rIK9mVKj7Cnu+b4a6OdZmFLC
 07M2DzPCcTht5kxbI/APIP1NgBoshdqj2VKjignOfrGOKIJG7YidoQsHhSG+NvoSTIdW lA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pkby48k0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 16:41:48 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32RGfl1j022812
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 16:41:47 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 27 Mar 2023 09:41:44 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linus.walleij@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, Mukesh Ojha <quic_mojha@quicinc.com>,
        Poovendhan Selvaraj <quic_poovendh@quicinc.com>
Subject: [PATCH v4 3/5] firmware: scm: Modify only the download bits in TCSR register
Date:   Mon, 27 Mar 2023 22:11:19 +0530
Message-ID: <1679935281-18445-4-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1679935281-18445-1-git-send-email-quic_mojha@quicinc.com>
References: <1679935281-18445-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dL0mLgZziigV_OZ2r9BkioyTvvUzIk3W
X-Proofpoint-GUID: dL0mLgZziigV_OZ2r9BkioyTvvUzIk3W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303270134
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 drivers/firmware/qcom_scm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 431fe1f..3c6c5e7 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -30,6 +30,9 @@ module_param(download_mode, bool, 0);
 #define SCM_HAS_IFACE_CLK	BIT(1)
 #define SCM_HAS_BUS_CLK		BIT(2)
 
+#define QCOM_DOWNLOAD_MODE_MASK 0x30
+#define QCOM_DOWNLOAD_FULLDUMP	0x1
+
 struct qcom_scm {
 	struct device *dev;
 	struct clk *core_clk;
@@ -448,8 +451,9 @@ static void qcom_scm_set_download_mode(bool enable)
 	if (avail) {
 		ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
 	} else if (__scm->dload_mode_addr) {
-		ret = qcom_scm_io_writel(__scm->dload_mode_addr,
-				enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0);
+		ret = qcom_scm_io_update_field(__scm->dload_mode_addr,
+				QCOM_DOWNLOAD_MODE_MASK,
+				enable ? QCOM_DOWNLOAD_FULLDUMP : 0);
 	} else {
 		dev_err(__scm->dev,
 			"No available mechanism for setting download mode\n");
-- 
2.7.4

