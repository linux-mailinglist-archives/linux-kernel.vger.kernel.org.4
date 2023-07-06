Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5BC7494E1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 07:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbjGFFLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 01:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjGFFLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 01:11:45 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757E8B2;
        Wed,  5 Jul 2023 22:11:44 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3664kSoD019146;
        Thu, 6 Jul 2023 05:11:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=NxGh3J3PeOX8iijqLo4eMKsBOMvKJGE2dN2EmFUBTTM=;
 b=VhS3EWli4BTFfastZ7oFVGxc/hU9xwfZqfb3gB03TzYuF0Z9o2HHktBS8P0fwdU5UBS8
 8wHSPYa3YuZKYwVVNnXaODC2S3QhwIHH6RWf28HsPDIIMQP5ERw6CRuHmrcTNG0k5qaM
 f1Uh6WXlOZuUrlNPzOnjE/B3VFnwv0am+cz2j6fNvbg8aIClOdfAmZMQ6FeDisuL+DX3
 0d8R/gygei/jm0L+PJzTk8SV6gAUIeA/zTTk8quS/uxNmooaO1+dCJ3+8mGFS1Sw6aKp
 qzFaffQn0U49QabBTUp1IQBo11K3hzHuGde06nu0PNV8lwX9ZpDSAR7H7Qz/wUXiQ6hJ xg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rmny9bmqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 05:11:40 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3665Bd7e002503
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Jul 2023 05:11:39 GMT
Received: from hu-ptalari-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 5 Jul 2023 22:11:36 -0700
From:   Praveen Talari <quic_ptalari@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_msavaliy@quicinc.com>, <quic_vtanuku@quicinc.com>,
        <quic_vnivarth@quicinc.com>, <quic_arandive@quicinc.com>,
        Praveen Talari <quic_ptalari@quicinc.com>
Subject: [PATCH v4 0/2] spi-geni-qcom: Add SPI device mode support for
Date:   Thu, 6 Jul 2023 10:40:22 +0530
Message-ID: <20230706051024.15422-1-quic_ptalari@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OGPIdHQw2X265dQMqWrmk90Tgpfsyom-
X-Proofpoint-ORIG-GUID: OGPIdHQw2X265dQMqWrmk90Tgpfsyom-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_02,2023-07-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 mlxscore=0 adultscore=0 mlxlogscore=456
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060045
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds spi device mode functionality to geni based Qupv3.
The common header file contains spi slave related registers and masks.

Praveen Talari (2):
  soc: qcom: geni-se: Add SPI Device mode support for GENI based QuPv3
  spi: spi-geni-qcom: Add SPI Device mode support for GENI based QuPv3
---
v3 -> v4:
- Used existing property spi-slave
- Hence dropped dt-binding changes
 
v2 -> v3:
- Modified commit message
- Addressed comment on dt-binding

v1 -> v2:
- Added dt-binding change for spi slave
- Modified commit message
- Addressed review comments in driver

 drivers/spi/spi-geni-qcom.c      | 57 ++++++++++++++++++++++++++++----
 include/linux/soc/qcom/geni-se.h |  9 +++++
 2 files changed, 60 insertions(+), 6 deletions(-)

-- 
2.17.1

