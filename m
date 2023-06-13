Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A73472DA36
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 08:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239993AbjFMGxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 02:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237542AbjFMGxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 02:53:37 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4955210D4;
        Mon, 12 Jun 2023 23:53:36 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35D5PpSq021690;
        Tue, 13 Jun 2023 06:53:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=54DHUo5WbYLCjWWOot671sFzmkPE9kMRrVQ5UIj8z8A=;
 b=RO3q6P7c1r5ei3ldsEDOwrC8zWgGmc3xxOivnrpQZ3FoTAWGdqv0oZlXchdcCOsXcyhh
 dq5ErJJQX5c9pQbRiGXVqDjhj14p+6V/WslAnxw+de/Z3r9P3jlMYJ/CwFm4k2bOpb/S
 f1xr23Ulz30vUBbKsMs/KYZSgK9hPCli3O6ZSV95cK6CmxLCurM5uxUsCWS/wSBkuKxx
 Q6ZD/6l2lET8dWayhmdKSC1D5dSub/qFjHjZ6ijojQpu1sjs3m+oqOJtLWWnshVdhyUT
 u8h9TkwUNN9cIIKM/Da5EEJII93gIn7FzGpadzIC427oWMkZWCccTGVJ9mez8MsfLb73 EQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r69nwgwmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 06:53:24 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35D6rN1g023430
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 06:53:23 GMT
Received: from hu-ptalari-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 12 Jun 2023 23:53:19 -0700
From:   Praveen Talari <quic_ptalari@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_msavaliy@quicinc.com>, <quic_vtanuku@quicinc.com>,
        <quic_vnivarth@quicinc.com>, <quic_arandive@quicinc.com>,
        Praveen Talari <quic_ptalari@quicinc.com>
Subject: [PATCH 0/2] spi-geni-qcom: Add SPI SLAVE mode support for GENI based QuPv3
Date:   Tue, 13 Jun 2023 12:22:27 +0530
Message-ID: <20230613065229.5619-1-quic_ptalari@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MKzRpWBVMBwEd6Wr1B5vJQTHOIlrX6RU
X-Proofpoint-GUID: MKzRpWBVMBwEd6Wr1B5vJQTHOIlrX6RU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_03,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 mlxlogscore=410 impostorscore=0 lowpriorityscore=0 clxscore=1011
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306130061
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds spi slave mode functionality to geni based Qupv3.
The common header file contains spi slave related registers and masks.

Praveen Talari (2):
  soc: qcom: geni-se: Add SPI SLAVE mode support for GENI based QuPv3
  spi: spi-geni-qcom: Add SPI SLAVE mode support for GENI based QuPv3

 drivers/spi/spi-geni-qcom.c      | 55 ++++++++++++++++++++++++++++----
 include/linux/soc/qcom/geni-se.h |  9 ++++++
 2 files changed, 58 insertions(+), 6 deletions(-)

-- 
2.17.1

