Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646AC69ADE7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 15:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjBQOVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 09:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjBQOVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:21:35 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA3B6D78F;
        Fri, 17 Feb 2023 06:21:16 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31HCh5IT007130;
        Fri, 17 Feb 2023 14:21:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=pEgnXSOuQtNq1e1QdA9XjfC/+JH3Look3Up+AUbAB2U=;
 b=A+E6DgNtIofCifWxnI5UhUW2FFcZMnjL0o0Mj9Zdy+BxAogOThhvkSk2W3mQrJPPLIlt
 4CQ6flXZwRWs5dBidiDiexakyksnkZSpKR9zn6koy6D1flVf6isHx0EI9CqdvI3gy/3B
 6nFZ6HFPB5dyRdOpM71kEGQ49eqgoPATES4TOExVGkY6L8RlaXVTOC25Ph4mwAHd8+T7
 4kvjO/gUuxTODTySaKgzYMrc0trOwNYp1z7+f64m2x0iDSwglfizdfpmvgjJjt2sYIaX
 VOoeEOVYKsVeG/8bMc7fAsavLw0Cbe0JDRwpdX03x2r2QW3zsX0AiHsOUeNZLoQrT3OK ew== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nt6x4gk2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 14:21:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31HELC1G016495
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 14:21:12 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 17 Feb 2023 06:21:06 -0800
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_ipkumar@quicinc.com>
Subject: [PATCH V2 4/6] regulator: qcom_smd: Add support to define the bootup voltage
Date:   Fri, 17 Feb 2023 19:50:28 +0530
Message-ID: <20230217142030.16012-5-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230217142030.16012-1-quic_devipriy@quicinc.com>
References: <20230217142030.16012-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YEMFytLkcXna97A2s7soBw90a_vnxzlX
X-Proofpoint-ORIG-GUID: YEMFytLkcXna97A2s7soBw90a_vnxzlX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_09,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 phishscore=0 malwarescore=0 adultscore=0 mlxlogscore=926
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302170130
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel does not know the initial voltage set by the bootloaders.
During regulator registration, the voltage variable is just declared
and it is zero. Based on that, the regulator framework considers current
the voltage as zero and tries to bring up each regulator to minimum
the supported voltage.

This introduces a dip in the voltage during kernel boot and gets
stabilized once the voltage scaling comes into picture.

To avoid the voltage dip, adding support to define the
bootup voltage set by the boodloaders and based on it, regulator
framework understands that proper voltage is already set

Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 Changes in V2:
	- Added the bootup voltages to s2 and l2 regulators

 drivers/regulator/qcom_smd-regulator.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index a40e66cea7e7..5f9fe6b9d368 100644
--- a/drivers/regulator/qcom_smd-regulator.c
+++ b/drivers/regulator/qcom_smd-regulator.c
@@ -800,12 +800,13 @@ struct rpm_regulator_data {
 	u32 id;
 	const struct regulator_desc *desc;
 	const char *supply;
+	int boot_uV; /* To store the bootup voltage set by bootloaders */
 };
 
 static const struct rpm_regulator_data rpm_mp5496_regulators[] = {
-	{ "s1", QCOM_SMD_RPM_SMPA, 1, &mp5496_smpa1, "s1" },
-	{ "s2", QCOM_SMD_RPM_SMPA, 2, &mp5496_smpa2, "s2" },
-	{ "l2", QCOM_SMD_RPM_LDOA, 2, &mp5496_ldoa2, "l2" },
+	{ "s1", QCOM_SMD_RPM_SMPA, 1, &mp5496_smpa1, "s1", 875000  },
+	{ "s2", QCOM_SMD_RPM_SMPA, 2, &mp5496_smpa2, "s2", 875000  },
+	{ "l2", QCOM_SMD_RPM_LDOA, 2, &mp5496_ldoa2, "l2", 2950000 },
 	{}
 };
 
@@ -1388,6 +1389,9 @@ static int rpm_regulator_init_vreg(struct qcom_rpm_reg *vreg, struct device *dev
 	vreg->type	= rpm_data->type;
 	vreg->id	= rpm_data->id;
 
+	if (rpm_data->boot_uV)
+		vreg->uV = rpm_data->boot_uV;
+
 	memcpy(&vreg->desc, rpm_data->desc, sizeof(vreg->desc));
 	vreg->desc.name = rpm_data->name;
 	vreg->desc.supply_name = rpm_data->supply;
-- 
2.17.1

