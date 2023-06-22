Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AB773A285
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjFVOAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjFVOAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:00:36 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8D3E2;
        Thu, 22 Jun 2023 07:00:30 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35MCjGig008256;
        Thu, 22 Jun 2023 14:00:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=h2EBvV+4ERBDJFI7Nkia3mS5+PDriEEjcQlmLmcedpg=;
 b=DqAbW5EL8hV+2GRJbEvCo3rc85U9/U2Ucg5GLB/6HZ0A96wdq9EBETWQ2Nlw0p2fmxRD
 ROCBIUx1C37Cb61OoH2Zn420Rn3W0M0Fwxa6VyYSjf7kSY04vwZSItJAhzowyGKX+DPF
 je2+oUPhq2tE0HkvZGwcTE5SRly/PoZqgPz6xv8CJ6dSRIeqJl4ro7eSi1xd7Dv8DRhc
 ciL2qYhyNoYs9Ve9wbk2kyBhxEv3pyNOoVHcZ0KzRuPur50mgIouGtksofo4XtjVNzYp
 th7nvXNAJja1n+zG+2I/kM8SwljCMvvgJm1FGtdjBNnFWVWfJD4ouM5EqfgOHMXko3As YA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rcpjh8687-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 14:00:27 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35ME0NeT029032
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 14:00:25 GMT
Received: from hu-ptalari-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 22 Jun 2023 07:00:19 -0700
From:   Praveen Talari <quic_ptalari@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_msavaliy@quicinc.com>, <quic_vtanuku@quicinc.com>,
        <quic_vnivarth@quicinc.com>, <quic_arandive@quicinc.com>,
        Praveen Talari <quic_ptalari@quicinc.com>
Subject: [PATCH v3 0/3] spi-geni-qcom: Add SPI device mode support for GENI based QuPv3
Date:   Thu, 22 Jun 2023 19:29:52 +0530
Message-ID: <20230622135955.941-1-quic_ptalari@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cc5Z3JJCLpA9AQ_uwlr4zXL26UHGCOAB
X-Proofpoint-GUID: cc5Z3JJCLpA9AQ_uwlr4zXL26UHGCOAB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_10,2023-06-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=709 impostorscore=0 malwarescore=0 clxscore=1011 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306220118
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds spi device mode functionality to geni based Qupv3.
The common header file contains spi slave related registers and masks.

Praveen Talari (3):
  soc: qcom: geni-se: Add SPI Device mode support for GENI based QuPv3
  spi: dt-bindings: qcom,spi-geni-qcom: Add SPI device mode support for
    GENI based QuPv3
  spi: spi-geni-qcom: Add SPI Device mode support for GENI based QuPv3
---
v2 -> v3:
- Modified commit message
- Addressed comment on dt-binding
	
v1 -> v2:
- Added dt-binding change for spi slave
- Modified commit message
- Addressed review comments in driver

 .../bindings/spi/qcom,spi-geni-qcom.yaml      |  4 ++
 drivers/spi/spi-geni-qcom.c                   | 57 +++++++++++++++++--
 include/linux/soc/qcom/geni-se.h              |  9 +++
 3 files changed, 64 insertions(+), 6 deletions(-)

-- 
2.17.1

