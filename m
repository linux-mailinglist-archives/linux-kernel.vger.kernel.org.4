Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8008772530F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 06:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbjFGEyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 00:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbjFGEyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 00:54:37 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9195E49;
        Tue,  6 Jun 2023 21:54:35 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3573q254023309;
        Wed, 7 Jun 2023 04:54:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=Lg1ZRRn3hbaOYd3haOfZwy2zN9qEKcE7ftKuXNzY2Lc=;
 b=LzGAKgGExXU3QgGMje3bDAOB2yI5BYkgP3qxMCHCE46S+5Iw6P/Lb9nUDP3rKOy9adlN
 rOzQ7022Bddkn5NFzRZD1Rin2HyYxfiVAHnwO26wOqCfJIEwbV0Beabe7Z+Rfnqt02/7
 FsKGpVnq9nXOJJJwn10OaWw2IU00OWPs5bMBk/6KTOAp4kAg9ttqr1CX6/H+KFq460pH
 8RbnP3di0wGc87pRGvxJxZCpatI9z6Td/VI2spMB/76wGO1MZKY8OVTo9MWN4ad1a87c
 1u3rTZOXoZ3CPCCKTWLOZ8lTSdlDuFkPJ7+ESpv7gGts77YmrqTWvxm8mwC5Nx8C/60H dA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r2a7k0wsx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 04:54:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3574s2EC025761
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Jun 2023 04:54:02 GMT
Received: from anusha-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 6 Jun 2023 21:53:58 -0700
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman <eberman@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_eberman@quicinc.com>,
        Kathiravan T <quic_kathirav@quicinc.com>,
        <stable@vger.kernel.org>
Subject: [PATCH V2] firmware: qcom_scm: use the SCM_CONVENTION based on ARM / ARM64
Date:   Wed, 7 Jun 2023 10:23:45 +0530
Message-ID: <20230607045345.25049-1-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mWJiQuOT2pTwe7e0HkqvdPCdzc5f0Z7j
X-Proofpoint-GUID: mWJiQuOT2pTwe7e0HkqvdPCdzc5f0Z7j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_02,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 impostorscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306070038
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During SCM probe, to identify the SCM convention, scm call is made with
SMC_CONVENTION_ARM_64 followed by SMC_CONVENTION_ARM_32. Based on the
result what convention to be used is decided.

IPQ chipsets starting from IPQ807x, supports both 32bit and 64bit kernel
variants, however TZ firmware runs in 64bit mode. When running on 32bit
kernel, scm call is made with SMC_CONVENTION_ARM_64 is causing the
system crash, due to the difference in the register sets between ARM and
AARCH64, which is accessed by the TZ.

To avoid this, use SMC_CONVENTION_ARM_64 only on ARM64 builds.

Cc: stable@vger.kernel.org
Fixes: 9a434cee773a ("firmware: qcom_scm: Dynamically support SMCCC and legacy conventions")
Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
---
Changes in V2:
	- Added the Fixes tag and cc'd stable mailing list

 drivers/firmware/qcom_scm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index fde33acd46b7..db6754db48a0 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -171,6 +171,7 @@ static enum qcom_scm_convention __get_convention(void)
 	if (likely(qcom_scm_convention != SMC_CONVENTION_UNKNOWN))
 		return qcom_scm_convention;
 
+#if IS_ENABLED(CONFIG_ARM64)
 	/*
 	 * Device isn't required as there is only one argument - no device
 	 * needed to dma_map_single to secure world
@@ -191,6 +192,7 @@ static enum qcom_scm_convention __get_convention(void)
 		forced = true;
 		goto found;
 	}
+#endif
 
 	probed_convention = SMC_CONVENTION_ARM_32;
 	ret = __scm_smc_call(NULL, &desc, probed_convention, &res, true);
-- 
2.17.1

