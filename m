Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B70E60E892
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbiJZTIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbiJZTHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:07:40 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755BF2CCA4;
        Wed, 26 Oct 2022 12:05:35 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QIqq06019545;
        Wed, 26 Oct 2022 19:05:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=z5LhUf1XS04XIWQgbRjWfhuTcYRjIq3iPI/E7vn7TXo=;
 b=L0/pVMM+NPKTwj+4Zj5VUCrCUcKQa6fwintSe57Mul3C85bt0MNnLawSyuvqqrtSfo4B
 0yVB4qqFmIk82URI2HEOb/oo4v2jIonzHdh/pGwUeDc1vnTnOpfKDxS2zeCDpUfV5BVl
 GnOLcR5c5zxh+n+Nq5z5m/xgGKdF3UKnBtnL4eOiA4d4+J4q+VEQ5kgakjhXJHK9lgGA
 h39aBHnoXA5x6v846ETYNX2ufMwAnbL7bjs2Xqf0ClOlNYmgGA0FeUMawVS158+/BKkj
 4Ca7z//jA0YUF3jUcg9/YSq6EL/yNzNo7Ib+prYZkctN1cnxMwn7J714n6vZOrL1kXte oQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kfaj001gk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 19:05:32 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29QJ5VEZ006207
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 19:05:31 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 26 Oct 2022 12:05:31 -0700
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Odelu Kukatla <quic_okukatla@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH v3 0/3] Add interconnect support for QDU1000/QRU1000 SoCs
Date:   Wed, 26 Oct 2022 12:05:17 -0700
Message-ID: <20221026190520.4004264-1-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aVE82Aw8p9Bo1RWs2UXr0BSQWH8aM7iO
X-Proofpoint-ORIG-GUID: aVE82Aw8p9Bo1RWs2UXr0BSQWH8aM7iO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_07,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 bulkscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=883
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2210260107
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt bindings and driver support for the Qualcomm QDU1000 and QRU1000
SoCs.

The Qualcomm Technologies, Inc. Distributed Unit 1000 and Radio Unit
1000 are new SoCs meant for enabling Open RAN solutions. See more at
https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/qualcomm_5g_ran_platforms_product_brief.pdf

Changes from v2:
- Dropped qru compat strings
- Removed required reg string for interconnects

Melody Olvera (3):
  dt-bindings: interconnect: Remove required reg field
  dt-bindings: interconnect: Add QDU1000/QRU1000 dt bindings
  interconnect: qcom: Add QDU1000/QRU1000 interconnect driver

 .../bindings/interconnect/qcom,rpmh.yaml      |    5 +-
 drivers/interconnect/qcom/Kconfig             |    9 +
 drivers/interconnect/qcom/Makefile            |    2 +
 drivers/interconnect/qcom/qdu1000.c           | 1079 +++++++++++++++++
 drivers/interconnect/qcom/qdu1000.h           |   95 ++
 .../dt-bindings/interconnect/qcom,qdu1000.h   |   98 ++
 6 files changed, 1287 insertions(+), 1 deletion(-)
 create mode 100644 drivers/interconnect/qcom/qdu1000.c
 create mode 100644 drivers/interconnect/qcom/qdu1000.h
 create mode 100644 include/dt-bindings/interconnect/qcom,qdu1000.h


base-commit: 60eac8672b5b6061ec07499c0f1b79f6d94311ce
-- 
2.25.1

