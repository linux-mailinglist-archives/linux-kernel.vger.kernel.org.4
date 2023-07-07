Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB57174AA45
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 07:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjGGFRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 01:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjGGFRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 01:17:15 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E8919B2;
        Thu,  6 Jul 2023 22:17:14 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3675H88F015205;
        Fri, 7 Jul 2023 05:17:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=i/B+4q0NsCQBolsiKLtsrV/YIb1atzdQRs1P9nb79fM=;
 b=Z/7eYOKicJ/pI2ySfl7+pJ94MQ+fE2d4NKA2NvEEKAkiDL1o2l5/7JAwbo1Z8pfMyGx3
 7bhrVdfOz8Ctp2h6uOYyPahm/VcDwma8jyzPhSMGDiI6szvduaWxkcxiKST6JauVlXc4
 EyiY0gmCKJ+SclB7QaJde2sHgftRa73X65TVCPdsNCb8wNkc4D7JjjPnoi5DQhXZwGui
 Ujps4y6Ot+LGCrxZqFTPCeLwKQiD66n3f08+yZSKtL30mQqst/TiR909kLBeWaxokKNH
 XEv2khOsuU+sxjr+40dk7SvJHSgHKF7aA/fMVo92ZSuxwtYTMfqQmkwQh57hbMNfmB51 Tg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rp9vp0930-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 05:17:10 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3675H9Ca017827
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Jul 2023 05:17:09 GMT
Received: from hu-ptalari-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 6 Jul 2023 22:17:05 -0700
From:   Praveen Talari <quic_ptalari@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_msavaliy@quicinc.com>, <quic_vtanuku@quicinc.com>,
        <quic_vnivarth@quicinc.com>, <quic_arandive@quicinc.com>,
        Praveen Talari <quic_ptalari@quicinc.com>
Subject: [PATCH v5 0/2] spi-geni-qcom: Add SPI device mode support for GENI based QuPv3
Date:   Fri, 7 Jul 2023 10:46:34 +0530
Message-ID: <20230707051636.5301-1-quic_ptalari@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ufHtwm8jMBFRQ0-gGlc08SagrG__9tnx
X-Proofpoint-ORIG-GUID: ufHtwm8jMBFRQ0-gGlc08SagrG__9tnx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_02,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 impostorscore=0
 mlxlogscore=458 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2307070048
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
v4 -> v5:
- Addressed review comments in driver

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

 drivers/spi/spi-geni-qcom.c      | 53 ++++++++++++++++++++++++++++----
 include/linux/soc/qcom/geni-se.h |  9 ++++++
 2 files changed, 56 insertions(+), 6 deletions(-)

-- 
2.17.1

