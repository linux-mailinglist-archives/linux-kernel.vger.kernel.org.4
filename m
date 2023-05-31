Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D675771741D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 05:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbjEaDKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 23:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbjEaDJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 23:09:59 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4875311C;
        Tue, 30 May 2023 20:09:57 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34V2n0fR026928;
        Wed, 31 May 2023 03:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=8yovoSzJaDk9s+XFbJsReakzGS4nCwJKV3N9YJRfAJA=;
 b=TAH1SYcfanEHIKO/YCFYmZjyxl10pJ3z+wjZWt1hl92D9iYDvE7JNdV6d18PbpjQJoL+
 xtft/LknXlaTkgywNEjI9+8b5fiK/479Pzq3GtL6084zVYHX6nJbXtZNtHIc+fXq4Hzt
 ZXcjWXEoqEPq5FK64m3wVoVjaS0b7urf8pMUqQk3k/H1mKvjXBqJSPVIGmFqgnPcl5Fb
 7Duio/psOOZu4gutUiOYhzKI2Vax+fYVa7rGoWoU1zRR2z8O9io24ka+ULJXsRhzGTeC
 YFMHhPYxKJD4MhqOwhgvxlHVKQAo4JGpGls5+euGRTd2zataWK0slqAFFyCHdgiDPlP2 Pg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qwwbtg2dr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 03:09:52 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34V39peL022668
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 03:09:51 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 30 May 2023 20:09:50 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <johan@kernel.org>,
        <mani@kernel.org>
Subject: [PATCH v3 0/3] drm/msm/adreno: GPU support on SC8280XP
Date:   Tue, 30 May 2023 20:09:42 -0700
Message-ID: <20230531030945.4109453-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5Vq4wySYh9EGG0onFFBWEtoXb7CgHlQF
X-Proofpoint-ORIG-GUID: 5Vq4wySYh9EGG0onFFBWEtoXb7CgHlQF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_18,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 mlxlogscore=717 adultscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305310024
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces support for A690 in the DRM/MSM driver and
enables it for the two SC8280XP laptops.

Bjorn Andersson (3):
  drm/msm/adreno: Add Adreno A690 support
  arm64: dts: qcom: sc8280xp: Add GPU related nodes
  arm64: dts: qcom: sc8280xp: Enable GPU related nodes

 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     |  26 +++
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    |  26 +++
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        | 181 ++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c         | 113 ++++++++++-
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c         |  33 ++++
 drivers/gpu/drm/msm/adreno/adreno_device.c    |  14 ++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h       |  11 +-
 7 files changed, 399 insertions(+), 5 deletions(-)

-- 
2.39.2

