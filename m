Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B9F60E8AC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbiJZTKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbiJZTIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:08:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E48B12600;
        Wed, 26 Oct 2022 12:06:07 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QIo0Mn021675;
        Wed, 26 Oct 2022 19:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=CPc4fs7XB08ekd5Q9q9uAFbFtYYtZPwVr2mxX0naXEA=;
 b=QmhVokpBIYC+5o5D6YqM095PkIQypjIz1tt/T9P9J4c5WO3N9lNdNTRXw3sbCMwRic0X
 GmrmqSZTJKTNca6hvNlTv0v3DtdF0AhwOhLpQPBnQ0bqAM58tOPl0r71afV0G30z/RYS
 c/WVlLJEcv1Pu7eT6DGBHpkN00WX1vlmT0JoqPGFSHS17zuBHkIaCDONtC1MNxAS4o6I
 FS+eGSLIz1vm5zNHPCVPiupEYeZGkkpeA4Rom/ZZkQOZBYC3kWS52yV6OeNKSfL2e/0z
 Jce0tK88ZisjWAXTqx1uZ8TxK+SzSmuxX+SN7AGVFHq6TBZkooH0lMxXZNBfBra3wfxw 9g== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kfah4r21b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 19:06:03 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29QJ63N0003995
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 19:06:03 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 26 Oct 2022 12:06:02 -0700
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH v3 3/5] soc: qcom: rpmhpd: Add QDU1000/QRU1000 power domains
Date:   Wed, 26 Oct 2022 12:05:47 -0700
Message-ID: <20221026190549.4005703-4-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221026190549.4005703-1-quic_molvera@quicinc.com>
References: <20221026190549.4005703-1-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rmnT-NSkiWFaLGk1G41EMnip4JFpTTZk
X-Proofpoint-ORIG-GUID: rmnT-NSkiWFaLGk1G41EMnip4JFpTTZk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_07,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=754
 clxscore=1015 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210260107
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the power domains exposed by RPMH in the Qualcomm QDU1000
and QRU1000 platforms.

Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
 drivers/soc/qcom/rpmhpd.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
index b0c0e151c80a..7af68cd720f5 100644
--- a/drivers/soc/qcom/rpmhpd.c
+++ b/drivers/soc/qcom/rpmhpd.c
@@ -372,6 +372,19 @@ static const struct rpmhpd_desc sm8450_desc = {
 	.num_pds = ARRAY_SIZE(sm8450_rpmhpds),
 };
 
+/* QDU1000/QRU1000 RPMH powerdomains */
+static struct rpmhpd *qdu1000_rpmhpds[] = {
+	[QDU1000_CX] = &cx,
+	[QDU1000_EBI] = &ebi,
+	[QDU1000_MSS] = &mss,
+	[QDU1000_MX] = &mx,
+};
+
+static const struct rpmhpd_desc qdu1000_desc = {
+	.rpmhpds = qdu1000_rpmhpds,
+	.num_pds = ARRAY_SIZE(qdu1000_rpmhpds),
+};
+
 /* SC7180 RPMH powerdomains */
 static struct rpmhpd *sc7180_rpmhpds[] = {
 	[SC7180_CX] = &cx_w_mx_parent,
@@ -449,6 +462,7 @@ static const struct rpmhpd_desc sc8280xp_desc = {
 };
 
 static const struct of_device_id rpmhpd_match_table[] = {
+	{ .compatible = "qcom,qdu1000-rpmhpd", .data = &qdu1000_desc },
 	{ .compatible = "qcom,sa8540p-rpmhpd", .data = &sa8540p_desc },
 	{ .compatible = "qcom,sc7180-rpmhpd", .data = &sc7180_desc },
 	{ .compatible = "qcom,sc7280-rpmhpd", .data = &sc7280_desc },
-- 
2.25.1

