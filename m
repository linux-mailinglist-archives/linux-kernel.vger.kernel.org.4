Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147AD68E79E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 06:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjBHFfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 00:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjBHFe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 00:34:59 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28272D170;
        Tue,  7 Feb 2023 21:34:50 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3185Vf9C014283;
        Wed, 8 Feb 2023 05:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=ut718roIadzdaNnZsWxLsjpG5owC/eAxrCb2vzzvBN0=;
 b=BJoJ/kqYUZFfPZ5JJbUXOLTqvgkqcPcnK8hz81evfkUE5f6qrFCkDCoNz8Si9WOUdqbR
 iQL9rP/HBA2NO+xygxLqvhfdYp39bypaW7a8P/4tRCNQ+sfI63adNx07P3wrE1+6jCpX
 uGbiYuKMyKbccqZ03R4RRBRNbmxBlrERkGu97uyccVyo7R+kqWHEADVbSOFYBBq1h3ax
 4XsOQ6yZfqoy+342I6aGGfw4KDaFrktsn8ImnMMVEwWdNBvx/5y48OpmSXUuMSCa2vg2
 BvADGKjr44PlXg80REffJbUej9CZ4eLXTwtThav6ehHDVwa6NRyWCnocYoPAv3EX1nTs wQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nkga2u7f0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 05:34:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3185YS6G027211
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Feb 2023 05:34:28 GMT
Received: from poovendh-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 7 Feb 2023 21:34:18 -0800
From:   Poovendhan Selvaraj <quic_poovendh@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <jassisinghbrar@gmail.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <robimarko@gmail.com>,
        <dmitry.baryshkov@linaro.org>, <nfraprado@collabora.com>,
        <broonie@kernel.org>, <quic_gurus@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_devipriy@quicinc.com>
Subject: [PATCH V3 3/5] firmware: scm: Modify only the DLOAD bit in TCSR register for download mode
Date:   Wed, 8 Feb 2023 11:03:30 +0530
Message-ID: <20230208053332.16537-4-quic_poovendh@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230208053332.16537-1-quic_poovendh@quicinc.com>
References: <20230208053332.16537-1-quic_poovendh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fKk0KDAQvH98jx30_BgJZCpLaw7nQ0Re
X-Proofpoint-ORIG-GUID: fKk0KDAQvH98jx30_BgJZCpLaw7nQ0Re
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_02,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302080049
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CrashDump collection is based on the DLOAD bit of TCSR register.
To retain other bits, we read the register and modify only the DLOAD bit as
the other bits have their own significance.

Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
Co-developed-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
---
 Changes in V3:
	- retain the value of tcsr register when download mode is not set

 drivers/firmware/qcom_scm.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 2000323722bf..2ad7ccf0abcd 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -407,7 +407,7 @@ int qcom_scm_set_remote_state(u32 state, u32 id)
 }
 EXPORT_SYMBOL(qcom_scm_set_remote_state);
 
-static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
+static int __qcom_scm_set_dload_mode(struct device *dev, u32 val, bool enable)
 {
 	struct qcom_scm_desc desc = {
 		.svc = QCOM_SCM_SVC_BOOT,
@@ -417,7 +417,7 @@ static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
 		.owner = ARM_SMCCC_OWNER_SIP,
 	};
 
-	desc.args[1] = enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0;
+	desc.args[1] = enable ? val | QCOM_SCM_BOOT_SET_DLOAD_MODE : val;
 
 	return qcom_scm_call_atomic(__scm->dev, &desc, NULL);
 }
@@ -426,15 +426,19 @@ static void qcom_scm_set_download_mode(bool enable)
 {
 	bool avail;
 	int ret = 0;
+	u32 dload_addr_val;
 
 	avail = __qcom_scm_is_call_available(__scm->dev,
 					     QCOM_SCM_SVC_BOOT,
 					     QCOM_SCM_BOOT_SET_DLOAD_MODE);
+	ret = qcom_scm_io_readl(__scm->dload_mode_addr, &dload_addr_val);
+
 	if (avail) {
-		ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
+		ret = __qcom_scm_set_dload_mode(__scm->dev, dload_addr_val, enable);
 	} else if (__scm->dload_mode_addr) {
 		ret = qcom_scm_io_writel(__scm->dload_mode_addr,
-				enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0);
+				enable ? dload_addr_val |
+				QCOM_SCM_BOOT_SET_DLOAD_MODE : dload_addr_val);
 	} else {
 		dev_err(__scm->dev,
 			"No available mechanism for setting download mode\n");
-- 
2.17.1

