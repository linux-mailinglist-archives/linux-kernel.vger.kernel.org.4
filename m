Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4AC17007A7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 14:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241033AbjELMWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 08:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240813AbjELMWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 08:22:03 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB1A1329C;
        Fri, 12 May 2023 05:22:00 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CBpUaI022683;
        Fri, 12 May 2023 12:21:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=Es3qey8KHPuV4tiYvQ8GpMi07nfr68jTUjXyMMD4BJQ=;
 b=W7URFXYWAxcItcKmjIp/SYANMO0npxI3yq7X8QWgUByciN6vip3qup25JAekdXdynYC5
 /Et3w/Tyk+S2qDjtvm8LkiH5/uDMUVknqCz4qlpgoUA/wToUloR6xR5AvvFBCtn8GUio
 P1MO9rOr1TwOkvGV2w9eVKK+7tk59phrFM9hmra6+HAiVz3p1COOyhxmzWRayVKRvcpe
 BDs4tH7ICE8lLBnRJ3Hfqh/tdVHpb3VL2W7pqAzlfD0HoKp3Lc//yBnmebrCIfapTYWN
 qBiCor832XduBeSJPUIh2Auy5k7BGPmGZ4YcFa5MOoad9N+0XgHHnGTJrXserQF6P8jV YQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qh27tte5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 12:21:56 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34CCLhu3028973;
        Fri, 12 May 2023 12:21:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3qdy59u1uf-1;
        Fri, 12 May 2023 12:21:43 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34CCLh6D028967;
        Fri, 12 May 2023 12:21:43 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-kbajaj-hyd.qualcomm.com [10.147.247.189])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 34CCLgMT028966;
        Fri, 12 May 2023 12:21:43 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2340697)
        id 2EA6852974D; Fri, 12 May 2023 17:51:42 +0530 (+0530)
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Komal Bajaj <quic_kbajaj@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 00/10] soc: qcom: llcc: Add support for QDU1000/QRU1000
Date:   Fri, 12 May 2023 17:51:24 +0530
Message-Id: <20230512122134.24339-1-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZTmxwA9YlEPA9V1moDpalJbEDXlasAjy
X-Proofpoint-GUID: ZTmxwA9YlEPA9V1moDpalJbEDXlasAjy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_08,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=725 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120103
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series does the following -
 * Add support for reading secure fuse region in qfprom driver
 * Add support for qfprom on QDU1000 and QRU1000 SoCs
 * Refactor LLCC driver to support multiple configuration
 * Add support for multi channel DDR configuration in LLCC
 * Add LLCC support for the Qualcomm QDU1000 and QRU1000 SoCs

Changes in v3-
 - Addressed comments from Krzysztof and Mani.
 - Using qfprom to read DDR configuration from feature register.

Changes in v2:
  - Addressing comments from Konrad.

Komal Bajaj (10):
  nvmem: qfprom: Add support for secure reading
  dt-bindings: nvmem: qfprom: Add compatible for QDU1000/QRU1000
  arm64: dts: qcom: qdu1000: Add properties to qfprom for multi channel
    DDR
  nvmem: qfprom: Add support for secure reading on QDU1000/QRU1000
  soc: qcom: llcc: Refactor llcc driver to support multiple
    configuration
  soc: qcom: Add LLCC support for multi channel DDR
  dt-bindings: arm: msm: Add LLCC compatible for QDU1000/QRU1000
  Revert "arm64: dts: qcom: qdu1000: Add LLCC/system-cache-controller"
  arm64: dts: qcom: qdu1000: Add LLCC/system-cache-controller
  soc: qcom: llcc: Add QDU1000 and QRU1000 LLCC support

 .../devicetree/bindings/cache/qcom,llcc.yaml  |   2 +
 .../bindings/nvmem/qcom,qfprom.yaml           |   1 +
 arch/arm64/boot/dts/qcom/qdu1000.dtsi         |  30 +-
 drivers/nvmem/qfprom.c                        |  74 ++++-
 drivers/soc/qcom/llcc-qcom.c                  | 304 +++++++++++++-----
 include/linux/soc/qcom/llcc-qcom.h            |   2 +-
 6 files changed, 301 insertions(+), 112 deletions(-)

-- 
2.17.1

