Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3945F73B9C7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjFWOSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjFWOSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:18:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D1F10D;
        Fri, 23 Jun 2023 07:18:32 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NDLkhm031167;
        Fri, 23 Jun 2023 14:18:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=Wi4cFQk9or+XQgY+OqPrYSjSZ0nwiMpRcfaUZ70Ofm8=;
 b=NM3IN8ljpDS/Ow2Enc0hTl1LrOE77tY0PZXmW7j2OsDcp1KWuHYZebKqCTFWxThBaVlX
 vKApvRt1DQLLlL3OyDCkJxTg9W15fRJgcNfg4C9E5TC9ETpJi1YzQr6HfQ58zFp1wGa9
 2lKiFrUcMxqemIpPvk399DSeGFygisJFGifY4MnuYDAasjsSncFWZrWN059fk7h6XLnq
 +GxSTU0OL3U99UAtShT/1IytwU7YiMkSrUtLPeEt+dmReGd7hXSHmsBjIdmrNqqWJOJW
 DUiTmypXjR08tSP0crb+SjSFgB3+BBVXjExkU1YPWKrkNFN2EqoT0d/hHK7DONsYwtyl /g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rcw93hnbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 14:18:28 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35NEIRPT013190
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 14:18:27 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 23 Jun 2023 07:18:23 -0700
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Komal-Bajaj <quic_kbajaj@quicinc.com>
Subject: [PATCH v4 0/6] soc: qcom: llcc: Add support for QDU1000/QRU1000
Date:   Fri, 23 Jun 2023 19:48:00 +0530
Message-ID: <20230623141806.13388-1-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4dTuosr0_9od_NxDsUUb8p2XaNbDUe8Y
X-Proofpoint-ORIG-GUID: 4dTuosr0_9od_NxDsUUb8p2XaNbDUe8Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_08,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 adultscore=0 clxscore=1011 impostorscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230130
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Komal-Bajaj <quic_kbajaj@quicinc.com>

This patch series does the following -
 * Add secure qfprom driver for reading secure fuse region in qfprom driver
 * Add dt-bindings for secure qfprom
 * Refactor LLCC driver to support multiple configuration
 * Add support for multi channel DDR configuration in LLCC
 * Add LLCC support for the Qualcomm QDU1000 and QRU1000 SoCs

Changes in v4 -
 - Created a separate driver for reading from secure fuse region as suggested.
 - Added patch for dt-bindings of secure qfprom driver accordingly.
 - Added new properties in the dt-bindings for LLCC. 
 - Implemented new logic to read the nvmem cell as suggested by Bjorn.
 - Separating the DT patches from this series as per suggestion.

Changes in v3-
 - Addressed comments from Krzysztof and Mani.
 - Using qfprom to read DDR configuration from feature register.

Changes in v2:
  - Addressing comments from Konrad.

Komal Bajaj (6):
  dt-bindings: nvmem: sec-qfprom: Add bindings for secure qfprom
  dt-bindings: cache: qcom,llcc: Add LLCC compatible for QDU1000/QRU1000
  nvmem: sec-qfprom: Add Qualcomm secure QFPROM support.
  soc: qcom: llcc: Refactor llcc driver to support multiple
    configuration
  soc: qcom: Add LLCC support for multi channel DDR
  soc: qcom: llcc: Add QDU1000 and QRU1000 LLCC support

 .../devicetree/bindings/cache/qcom,llcc.yaml  |  10 +
 .../bindings/nvmem/qcom,sec-qfprom.yaml       |  58 ++++
 drivers/nvmem/Kconfig                         |  12 +
 drivers/nvmem/Makefile                        |   2 +
 drivers/nvmem/sec-qfprom.c                    | 116 +++++++
 drivers/soc/qcom/Kconfig                      |   2 +
 drivers/soc/qcom/llcc-qcom.c                  | 304 +++++++++++++-----
 include/linux/soc/qcom/llcc-qcom.h            |   2 +-
 8 files changed, 416 insertions(+), 90 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/qcom,sec-qfprom.yaml
 create mode 100644 drivers/nvmem/sec-qfprom.c

-- 
2.40.1

