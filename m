Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E830725C8E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239728AbjFGLAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240481AbjFGLAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:00:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0C31FD4;
        Wed,  7 Jun 2023 03:58:49 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357AkX5O013660;
        Wed, 7 Jun 2023 10:57:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=JfyrxHYByNtJUYhrMn4hXvVYxwljS/KNBKAElLPjG8I=;
 b=YKoyLLsiPg9wTKlYiSEcu4mpz3dFdRbPrwHuviKAi293jPleGTq3oDgajLXBW2ZmG/HR
 GAo3zw79RgEZrzQ0Ye3qEHdvUA+97RwYU5bM88WcUPSJPmA2v4c1ofaJP8FQamPQ/4s0
 ruXsnGWDGU9Xz6XCZgx8o0ocnNC6+19h/F5K6I0xBDEMN6o4p4usSnO5OMFzcwyU/uKA
 HIZG7HF6Ou6gUas5ceekVAl1VCIjhc7bhosl3o+o5uYXMuqlWHIXZPiBoF1Rta+3hALW
 q8FgkIhVSxABkRyCFLDHSYE8q83mR3OXn/6wHjcg2yupZDJ1YVuErBfYtUFnc73StT8M bw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r2a719np0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 10:57:23 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 357AvMSa010124
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Jun 2023 10:57:22 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 7 Jun 2023 03:57:13 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <p.zabel@pengutronix.de>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <neil.armstrong@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <rafal@milecki.pl>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.org>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH 6/9] phy: qcom: Add qcom,m31 USB phy driver
Date:   Wed, 7 Jun 2023 16:26:10 +0530
Message-ID: <353c5affd1d638bdc7e4ed187616a938e8d763a4.1686126439.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1686126439.git.quic_varada@quicinc.com>
References: <cover.1686126439.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sv5o8tnQfjGr9Ab465gX__8xLrmD_Hxi
X-Proofpoint-ORIG-GUID: sv5o8tnQfjGr9Ab465gX__8xLrmD_Hxi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_06,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=730 suspectscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306070089
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include M31 phy driver if CONFIG_PHY_QCOM_M31_USB is enabled

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 drivers/phy/qualcomm/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/qualcomm/Makefile b/drivers/phy/qualcomm/Makefile
index de3dc9c..79a6e75 100644
--- a/drivers/phy/qualcomm/Makefile
+++ b/drivers/phy/qualcomm/Makefile
@@ -21,3 +21,4 @@ obj-$(CONFIG_PHY_QCOM_USB_HS_28NM)	+= phy-qcom-usb-hs-28nm.o
 obj-$(CONFIG_PHY_QCOM_USB_SS)		+= phy-qcom-usb-ss.o
 obj-$(CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2)+= phy-qcom-snps-femto-v2.o
 obj-$(CONFIG_PHY_QCOM_IPQ806X_USB)		+= phy-qcom-ipq806x-usb.o
+obj-$(CONFIG_PHY_QCOM_M31_USB)		+= phy-qcom-m31.o
-- 
2.7.4

