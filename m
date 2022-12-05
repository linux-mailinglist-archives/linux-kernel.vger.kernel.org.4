Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A69642F1E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 18:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiLERo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 12:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbiLERot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 12:44:49 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7203201A8;
        Mon,  5 Dec 2022 09:44:48 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5Godfe029593;
        Mon, 5 Dec 2022 17:44:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=+4v0gZ9Y0cpTmz2emGV8ZzNG4y0YjdqSJgVtfDcDy1k=;
 b=et1b+LQ5OV7VahhPoIWDKMmX2PIZo5otGdM0vVu582OQojn7tBMP6oXhqXEBqKJ7gDEu
 y9bQd2Kjt0W9FalaIigcfR81s5jwHyUovPtCcVjkrS/ZSLc1xw8tZ1JUjEQDOaJvw2pT
 eEa6Bh03jt4HIBtEGZZ77dXnzWb1GPhheyL/0gM7ZLXT0FCC6SX9K5QGNUfPDxlBBuiC
 r2TjOhnlBjl6U/uW2zZ/lSNHhvdytg/T42THVwew6PHH35m+Vx2gNGv5fhIOUMtr6jDu
 3AkwJS9Fxv2qFUQ9FbjUIAS2cUzaTqmXL6Tzn56pt4JtXbsLVTNqa3Kn8JW76tBIriVn 3Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m9eev13tw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Dec 2022 17:44:42 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B5HifG7006227
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 5 Dec 2022 17:44:41 GMT
Received: from th-lint-050.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 5 Dec 2022 09:44:40 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        "Kuogee Hsieh" <quic_khsieh@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 03/13] drm/msm: Introduce SC8280XP MDSS
Date:   Mon, 5 Dec 2022 09:44:23 -0800
Message-ID: <20221205174433.16847-4-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221205174433.16847-1-quic_bjorande@quicinc.com>
References: <20221205174433.16847-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3jpQX6Dzs4YGLNalIKTOmSkPe7zGp5kU
X-Proofpoint-GUID: 3jpQX6Dzs4YGLNalIKTOmSkPe7zGp5kU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212050146
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Add compatible for the SC8280XP Mobile Display Subsystem and
initialization for version 8.0.0.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---

Changes since v3:
- Split out from DPU patch

 drivers/gpu/drm/msm/msm_mdss.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index 86b28add1fff..8677e74868cf 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -287,6 +287,9 @@ static int msm_mdss_enable(struct msm_mdss *msm_mdss)
 	case DPU_HW_VER_720:
 		msm_mdss_setup_ubwc_dec_40(msm_mdss, UBWC_3_0, 6, 1, 1, 1);
 		break;
+	case DPU_HW_VER_800:
+		msm_mdss_setup_ubwc_dec_40(msm_mdss, UBWC_4_0, 6, 1, 2, 1);
+		break;
 	}
 
 	return ret;
@@ -513,6 +516,7 @@ static const struct of_device_id mdss_dt_match[] = {
 	{ .compatible = "qcom,sc7180-mdss" },
 	{ .compatible = "qcom,sc7280-mdss" },
 	{ .compatible = "qcom,sc8180x-mdss" },
+	{ .compatible = "qcom,sc8280xp-mdss" },
 	{ .compatible = "qcom,sm6115-mdss" },
 	{ .compatible = "qcom,sm8150-mdss" },
 	{ .compatible = "qcom,sm8250-mdss" },
-- 
2.37.3

