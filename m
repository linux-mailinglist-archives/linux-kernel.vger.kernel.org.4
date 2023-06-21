Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF3A738F71
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjFUTBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjFUTBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:01:09 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C109DB4;
        Wed, 21 Jun 2023 12:01:05 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LHtmAk006865;
        Wed, 21 Jun 2023 19:00:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=qVmVwv5lBXo2mzhJIw+jA/mdwdbctTzwNXxp+Kidd4g=;
 b=BUK5nFhiBOgNM4+DQHAieAl8bRAhPJsrzpg/DI84Ey4cKUTkNmh3/GY32bVPMcA1noMc
 cmkl+3TnMgSNafsmN6shyF8iE7kWaVp9mQP7clz7zdPqA4WQ7lOxpbq6dfSVVcdNtvu7
 a3dgrimj2ajtvQo/7CcdeNbw29K2XCqnWB0+heTxsXVCe3pk+KTrqITn+wTCP2WOTqlj
 +55C42l/7EvyXtPGe2LDxmVRgJL0Nf5TCAPAqAdsjrLWifGwo9gm4Fkv4uL4hjlbLgxG
 WuoueT3einU2F9RLP+semvJjoKcqLyYNDP9ET3aht7mqblz2iXRqhOeKJwhMBKYGdKtB hw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rbqkhj4qh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 19:00:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35LJ0jVS024917
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 19:00:45 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 21 Jun 2023 12:00:44 -0700
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <pavel@ucw.cz>, <lee@kernel.org>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>
CC:     <konrad.dybcio@linaro.org>, <u.kleine-koenig@pengutronix.de>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: [PATCH 0/7] Add support for LUT PPG
Date:   Wed, 21 Jun 2023 11:59:43 -0700
Message-ID: <20230621185949.2068-1-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ecsGRqo74DEqjJoxQGrNZ84lvFb2IBqf
X-Proofpoint-ORIG-GUID: ecsGRqo74DEqjJoxQGrNZ84lvFb2IBqf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_11,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 impostorscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=757
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306210158
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In certain PMICs, LUT pattern and LPG configuration can be stored in SDAM
modules instead of LUT peripheral. This feature is called PPG.

This change series adds support for PPG. Thanks!

Anjelique Melendez (7):
  dt-bindings: soc: qcom: Add qcom-pbs bindings
  dt-bindings: leds: leds-qcom-lpg: Add support for LUT through NVMEM
    devices
  soc: qcom: add QCOM PBS driver
  leds: rgb: leds-qcom-lpg: Add support for LUT pattern through single
    SDAM
  leds: rgb: leds-qcom-lpg: Update PMI632 lpg_data to support PPG
  leds: rgb: leds-qcom-lpg: Support two-nvmem PPG Scheme
  leds: rgb: Update PM8350C lpg_data to support two-nvmem PPG Scheme

 .../bindings/leds/leds-qcom-lpg.yaml          |  85 ++++
 .../bindings/soc/qcom/qcom-pbs.yaml           |  41 ++
 drivers/leds/rgb/leds-qcom-lpg.c              | 393 ++++++++++++++++--
 drivers/soc/qcom/Kconfig                      |   9 +
 drivers/soc/qcom/Makefile                     |   1 +
 drivers/soc/qcom/qcom-pbs.c                   | 343 +++++++++++++++
 include/linux/soc/qcom/qcom-pbs.h             |  36 ++
 7 files changed, 877 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom-pbs.yaml
 create mode 100644 drivers/soc/qcom/qcom-pbs.c
 create mode 100644 include/linux/soc/qcom/qcom-pbs.h

-- 
2.40.0

