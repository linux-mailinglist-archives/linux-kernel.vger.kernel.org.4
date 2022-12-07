Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9469064639A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 23:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiLGWAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 17:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiLGWAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 17:00:31 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8042985645;
        Wed,  7 Dec 2022 14:00:28 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7KtpkW022795;
        Wed, 7 Dec 2022 22:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=JPXoq1IFqoOnCKk5Pmg/8TT1x/drI+wYVh5KWLZu3EI=;
 b=Z4f3xyfy4hqEVCocoPeBvi+6JQbMoq5nacXQqVg7lxW1vX9tJ38aQJZ4XwNggoLLF8hV
 YuoGXMV1+aRc4CnRdv4WYDOZBKT907r6bAx5CAmFEEvdM8ZFnK/mZNUREvmIfVpF6awg
 Gj9V2SkACiNsh9dpIk6cE82h0J9HxTUojWwlovD4tg8H2z+AqSj0CGl9igEKmQOaCI1G
 U5P1Aa7ScnVNOc3jZecSpJ9OwYgHe4AlovbJ/hhivpcxNFvXR1CF2m5R2xsQg8C2KacF
 +yP/Eiw4nubuois15x9ewfz7AgLzFRF8LOpvQitx7S47Biupu5Ctmx78k44ye8Vml1q6 XA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3majt4a5q6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Dec 2022 22:00:19 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B7M0Ior027882
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Dec 2022 22:00:18 GMT
Received: from th-lint-050.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 7 Dec 2022 14:00:17 -0800
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
Subject: [PATCH v5 00/12] drm/msm: Add SC8280XP support
Date:   Wed, 7 Dec 2022 14:00:00 -0800
Message-ID: <20221207220012.16529-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ifjefZuldzsU08NeFsTk4XpTyOsnVym4
X-Proofpoint-ORIG-GUID: ifjefZuldzsU08NeFsTk4XpTyOsnVym4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_11,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 clxscore=1015 adultscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212070186
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces support for the SC8280XP platform in the MDSS, DPU and
DP driver. It reworks the HDP handling in the DP driver to support
external HPD sources - such as the dp-connector, or USB Type-C altmode.

It then introduces the display clock controllers, mdss, dpu and
displayport controllers and link everything together, for both the MDSS
instances on the platform, and lastly enables EDP on the compute
reference device and 6 of the MiniDP outputs on the automotive
development platform.


The patches was previously sent separately, but submitting them together
here as they (except dts addition) goes in the same tree.

Bjorn Andersson (12):
  dt-bindings: display/msm: Add binding for SC8280XP MDSS
  drm/msm/dpu: Introduce SC8280XP
  drm/msm: Introduce SC8280XP MDSS
  dt-bindings: msm/dp: Add SDM845 and SC8280XP compatibles
  drm/msm/dp: Stop using DP id as index in desc
  drm/msm/dp: Add DP and EDP compatibles for SC8280XP
  drm/msm/dp: Add SDM845 DisplayPort instance
  drm/msm/dp: Rely on hpd_enable/disable callbacks
  drm/msm/dp: Implement hpd_notify()
  arm64: dts: qcom: sc8280xp: Define some of the display blocks
  arm64: dts: qcom: sc8280xp-crd: Enable EDP
  arm64: dts: qcom: sa8295-adp: Enable DP instances

 .../bindings/display/msm/dp-controller.yaml   |   3 +
 .../display/msm/qcom,sc8280xp-dpu.yaml        | 122 +++
 .../display/msm/qcom,sc8280xp-mdss.yaml       | 143 +++
 arch/arm64/boot/dts/qcom/sa8295p-adp.dts      | 243 ++++-
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     |  72 +-
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        | 838 ++++++++++++++++++
 .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    | 217 +++++
 .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h    |   1 +
 .../gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c |  18 +
 .../gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h |   3 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h   |   2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |   1 +
 drivers/gpu/drm/msm/dp/dp_display.c           | 151 ++--
 drivers/gpu/drm/msm/dp/dp_display.h           |   1 +
 drivers/gpu/drm/msm/dp/dp_drm.c               |   3 +
 drivers/gpu/drm/msm/dp/dp_drm.h               |   4 +
 drivers/gpu/drm/msm/msm_drv.h                 |   1 +
 drivers/gpu/drm/msm/msm_mdss.c                |   4 +
 18 files changed, 1770 insertions(+), 57 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sc8280xp-dpu.yaml
 create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sc8280xp-mdss.yaml

-- 
2.37.3

