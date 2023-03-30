Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E931F6CFEC4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 10:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjC3Imi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 04:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjC3ImO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 04:42:14 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8B36584;
        Thu, 30 Mar 2023 01:41:55 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32U4MN6l018731;
        Thu, 30 Mar 2023 08:41:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=iRsnsr0FuzceuDgW0k3bBzXdLl6ibER0NleiSWTqAp0=;
 b=ogW2Re05TCja9cOlPYKBUMC1orzS1zMbQxpqDua/qdotjR59Z35cLWYhp+zRI3yriPI6
 DX5xf55wEfUT1CW4jUd24kwla5QqNOomx1+Q202GDCIRLPmAqEWA8JiLLH0L4CPecWDu
 lLZba4Pm3AR1zBCtQQ8I6SS9vJa09mYGDYqJWdT9XpFihWY4kxc0R7IFsC7Sb4n2ovgX
 VYczhvcQIQMxFtdtadFLwhRRuTy2NHo11MDQvmwophGxYr8vAPxPwn4W1YeWAvusmu5r
 Y9uv54cVEniNypDUPZSDPkr30JnhFgHjU8+xuQDnwCrltBv24OK8n5MJ04GTgxLKCBMC +Q== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pmq1tjkvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Mar 2023 08:41:33 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32U8fW49009148
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Mar 2023 08:41:32 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 30 Mar 2023 01:41:26 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <quic_wcheng@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v5 5/8] phy: qcom-qusb2: add QUSB2 support for IPQ9574
Date:   Thu, 30 Mar 2023 14:10:47 +0530
Message-ID: <93b98873c1dbcab5f069ec96dee04a0e790eeef4.1680162377.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1680162377.git.quic_varada@quicinc.com>
References: <cover.1680162377.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qER9z05U22vtRcIgp5FVnqwvELZCVeTd
X-Proofpoint-ORIG-GUID: qER9z05U22vtRcIgp5FVnqwvELZCVeTd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-30_04,2023-03-30_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 adultscore=0 impostorscore=0 phishscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303300069
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the phy init sequence for the Super Speed ports found
on IPQ9574.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
  Changes in v2:
	- Place the entry such that the list continues to be sorted
---
 drivers/phy/qualcomm/phy-qcom-qusb2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
index 2ef638b..bec6e40 100644
--- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
+++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
@@ -912,6 +912,9 @@ static const struct of_device_id qusb2_phy_of_match_table[] = {
 		.compatible	= "qcom,ipq8074-qusb2-phy",
 		.data		= &msm8996_phy_cfg,
 	}, {
+		.compatible	= "qcom,ipq9574-qusb2-phy",
+		.data		= &ipq6018_phy_cfg,
+	}, {
 		.compatible	= "qcom,msm8953-qusb2-phy",
 		.data		= &msm8996_phy_cfg,
 	}, {
-- 
2.7.4

