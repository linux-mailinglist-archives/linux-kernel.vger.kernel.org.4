Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32773731033
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243703AbjFOHKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbjFOHJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:09:23 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640C6294F;
        Thu, 15 Jun 2023 00:08:04 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35F41aig010655;
        Thu, 15 Jun 2023 07:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=Vauiuyl3X2oKiyWXW3lpTG9zTGHJSwIk2Ckvq1ljeTs=;
 b=By+eCrCukT+/n/XSuDA2Wrat37aSlO3XzPe4PPmvmrC8bGY9kwOLseHS04BhcXAGUbgA
 hrLRQ16is17WAUTkUcVRljLGHQPbKmkj6Dfc7Uokdl9+d3dlxiBP2cf0y8OMJfh5MTbS
 SiCpeooTbcVzoGqC5R3Hv8lDdzp5c2DCtp9rmqSi2IlbbUxa8ZGhALE3lLVSrIgWm51c
 MYDouRJePjYf+EmUozFTmyU9JMZNXCkEDWMMPI3PoGD6fe4HEKxmijq8PMnkjP1GeCOT
 QveNdFk2xLnAIBpJS+SOrSJ+HldAeqTjN5bzvDrI+5vYX/A54iiDeYCjXogZEcVSdIKQ ug== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r7u8c8avb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 07:08:00 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35F77xo5026993
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 07:07:59 GMT
Received: from hu-ptalari-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 15 Jun 2023 00:07:54 -0700
From:   Praveen Talari <quic_ptalari@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_msavaliy@quicinc.com>, <quic_vtanuku@quicinc.com>,
        <quic_vnivarth@quicinc.com>, <quic_arandive@quicinc.com>,
        Praveen Talari <quic_ptalari@quicinc.com>
Subject: [PATCH v2 0/3] spi-geni-qcom: Add SPI SLAVE mode support for
Date:   Thu, 15 Jun 2023 12:37:03 +0530
Message-ID: <20230615070706.18322-1-quic_ptalari@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eO9b5pNS-fhSY8uTww-PyrCvRyb3XEqW
X-Proofpoint-GUID: eO9b5pNS-fhSY8uTww-PyrCvRyb3XEqW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-15_04,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 mlxlogscore=588 malwarescore=0
 phishscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306150058
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds spi slave mode functionality to geni based Qupv3.
The common header file contains spi slave related registers and masks.

Praveen Talari (3):
  soc: qcom: geni-se: Add SPI SLAVE mode support for GENI based QuPv3
  spi: dt-bindings: qcom,spi-geni-qcom: Add SPI SLAVE mode support for
    GENI based QuPv3
  spi: spi-geni-qcom: Add SPI SLAVE mode support for GENI based QuPv3
---
v1 -> v2:
- Added dt-binding change for spi slave
- Modified commit message
- Addressed review comments in driver
 .../bindings/spi/qcom,spi-geni-qcom.yaml      |  2 +
 drivers/spi/spi-geni-qcom.c                   | 57 +++++++++++++++++--
 include/linux/soc/qcom/geni-se.h              |  9 +++
 3 files changed, 62 insertions(+), 6 deletions(-)

-- 
2.17.1

