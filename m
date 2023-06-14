Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0BC7301AB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245433AbjFNOWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245544AbjFNOWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:22:30 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FABA19BC;
        Wed, 14 Jun 2023 07:22:28 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EEGEwK008904;
        Wed, 14 Jun 2023 14:22:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=kSbbaWee/PlN9V2bg3yK1efNJc94MTdMdYRy8dTiyY0=;
 b=P3xHpKatcME6lmrcAo7Sb85jXo0WUrcDUVitVtcXBwT/zOc4+L2araiGoC3nDNh1BIdc
 hGPBy4YrFtOoeikm8auwTaFzDA45zCmQDuW7QRNNEYlStnGmnZ6/jNN7VQDqm0SH85WK
 dw6RBHxjCPhWa0osRfN8drW8gDtIItNZ9k0ZuA+ybZPuMSBMe5SEtiNjlH0pp0O+w6sb
 kAZilEj0TeqLBUs2co/G+BW8Zrd62DgTN/vuV6GQhJMlPHjxjozCA8E7tiIupic/Z7Y7
 dY1ySrHP85Z1MKjLlHXu7Ca10T7QPgvqzEKj87NCj2tb1H9iHzrFV1PxeSC02pK49JO2 kQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r6s3wu067-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 14:22:11 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35EEMAeh022915
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 14:22:10 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 14 Jun 2023 07:22:09 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <johan@kernel.org>,
        <mani@kernel.org>
Subject: [PATCH v4 0/2] drm/msm/adreno: GPU support on SC8280XP
Date:   Wed, 14 Jun 2023 07:22:02 -0700
Message-ID: <20230614142204.2675653-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bWoIwAdXXEatKvW8W0Zgl6ZeCHUX_0dB
X-Proofpoint-GUID: bWoIwAdXXEatKvW8W0Zgl6ZeCHUX_0dB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_10,2023-06-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 mlxlogscore=511 clxscore=1011 impostorscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306140124
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the A690 support merged in the drm/msm driver, this series adds the
DeviceTree pieces to make it go on sc8280xp.

Note that in order for the GPU driver to probe, the last change
requires (which is now in linux-next):
https://lore.kernel.org/linux-arm-msm/20230410185226.3240336-1-dmitry.baryshkov@linaro.org/

Changes since v3:
- Dropped DRM patch, as it has been merged
- Left status okay on gmu, gpucc and smmu nodes, disabled latter two in
  sa8540p for now
- s/adreno_smmu/gpu_smmu/ to get the GPU nodes adjacent in sa8540p

Changes since v2:
- Added missing opp level (both gpu and gmu)
- Corrected opp-level for highest gpu opp
- Added dma-coherent to gpu smmu

Changes since v1:
- Dropped gmu_pdc_seq region from &gmu, as it shouldn't have been used.
- Added missing compatible to &adreno_smmu.
- Dropped aoss_qmp clock in &gmu and &adreno_smmu.

Bjorn Andersson (2):
  arm64: dts: qcom: sc8280xp: Add GPU related nodes
  arm64: dts: qcom: sc8280xp: Enable GPU related nodes

 arch/arm64/boot/dts/qcom/sa8540p.dtsi         |   8 +
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     |  14 ++
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    |  14 ++
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        | 175 ++++++++++++++++++
 4 files changed, 211 insertions(+)

-- 
2.25.1

