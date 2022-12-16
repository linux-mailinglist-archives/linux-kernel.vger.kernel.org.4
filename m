Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E03964F4C8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 00:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiLPXKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 18:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiLPXJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 18:09:37 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79455654D1;
        Fri, 16 Dec 2022 15:09:32 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BGN6l8U011537;
        Fri, 16 Dec 2022 23:09:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=abE5fN9BKXfdOQk5IijP/5E8GaI2PRSA7XaxT9cxz8Q=;
 b=iLJ72iVduENiWktIN4KdnObsw+jkvfPs0rdbKZIOfuRLdmxQeMri2my0WEh2aUU3vqL7
 grz+btlRp3fawBdUrtZ3xsrdwFDyqFFRxDuIBLt+7PNMqHp7mmETuVrwoi9HXTgrRg2x
 0B9P0/k7Xv7dB7AfMZRHfSHsrmBPbbXSiItE7bMhLCnX6ebClSRqb6QClW7AOy7xhjtG
 a5lkglUAD232Ui2JCtJSHrd57E8RjT344T0+OzKucbYh6j1ZmUmNlbjtUjoPEzUtUdLg
 O76AzqerDIYGAYv5IiQM9QRCWUwUwQA6ey/3fHis/xRPxg9SfwRjNm+u7e1mTHu/5UsW jQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mg2vwdh9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 23:09:25 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BGN9P1Y001936
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 23:09:25 GMT
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 16 Dec 2022 15:09:24 -0800
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Odelu Kukatla <quic_okukatla@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH v5 0/2] Add interconnect support for QDU1000/QRU1000 SoCs
Date:   Fri, 16 Dec 2022 15:09:12 -0800
Message-ID: <20221216230914.21771-1-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: J6gCaLGQxftq_QVxnOrcFXOsCgmljViO
X-Proofpoint-ORIG-GUID: J6gCaLGQxftq_QVxnOrcFXOsCgmljViO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_14,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 clxscore=1011 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 impostorscore=0 mlxlogscore=918 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212160205
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Changes from v4:
- Removed virt rpmh bindings document
- Moved all new bindings for QDU1000 to a separate doc
- Changed include file name to follow convention for separate doc

Changes from v3:
- add bindings document for virt rpmh devices
- explictly defined const structs as so

Changes from v2:
- Dropped qru compat strings
- Removed required reg string for interconnects

Melody Olvera (2):
  dt-bindings: interconnect: Add QDU1000/QRU1000 devices
  interconnect: qcom: Add QDU1000/QRU1000 interconnect driver

 .../interconnect/qcom,qdu1000-rpmh.yaml       |   70 ++
 drivers/interconnect/qcom/Kconfig             |    9 +
 drivers/interconnect/qcom/Makefile            |    2 +
 drivers/interconnect/qcom/qdu1000.c           | 1069 +++++++++++++++++
 drivers/interconnect/qcom/qdu1000.h           |   95 ++
 .../interconnect/qcom,qdu1000-rpmh.h          |   98 ++
 6 files changed, 1343 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qdu1000-rpmh.yaml
 create mode 100644 drivers/interconnect/qcom/qdu1000.c
 create mode 100644 drivers/interconnect/qcom/qdu1000.h
 create mode 100644 include/dt-bindings/interconnect/qcom,qdu1000-rpmh.h


base-commit: ca39c4daa6f7f770b1329ffb46f1e4a6bcc3f291
-- 
2.38.1

