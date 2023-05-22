Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225C470B42C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 06:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjEVEpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 00:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjEVEpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 00:45:36 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D159BE0;
        Sun, 21 May 2023 21:45:35 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34M4eNww005716;
        Mon, 22 May 2023 04:45:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=q5ychQUgvG+RwtfStD3Hjtu0PUnjz/wL+HYL6NgvXe4=;
 b=Op0d3AXt6Kpi7oe0VF3XOpj87ujcXTJh4xNynsOOOJ2UHJgOAFG7PHEJ0aDI134EWdWg
 HRNlCE1Mi9Oua+5Wv/cT+TzPeU8bNzNKBzAbeUYCsCUVPDNkAvSg3Y+s3zr7Rkb95/k0
 g6aIAvrRyd85djbtlxNjxKAbSRkoD6vGpqa093GjhH0IkDs4X9pLncPEnK47Go4hS0Eq
 bom7Ok8nxaZeqHjQnJ+kl+YNdp/d1Ye+NviGA1y3A4++eljYHsU2ivNZDeeJFPZ6MWWH
 pFh3lGKyxG3CI020lmJSbUV23BL5lUOwI2zH1Gq+6PiGYJ5YQX8OBUn13MkeAVpNcjMT ZA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qppe9amty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 04:45:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34M4jS6R021611
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 04:45:28 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Sun, 21 May 2023 21:45:25 -0700
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_eberman@quicinc.com>,
        Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH] firmware: qcom_scm: use the SCM_CONVENTION based on ARM / ARM64
Date:   Mon, 22 May 2023 10:15:12 +0530
Message-ID: <20230522044512.4787-1-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: noNhBxUQCLjT3E6P1jWeXZPwDOxoyXA9
X-Proofpoint-ORIG-GUID: noNhBxUQCLjT3E6P1jWeXZPwDOxoyXA9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_01,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015
 mlxlogscore=999 priorityscore=1501 mlxscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220039
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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

Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
---
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

