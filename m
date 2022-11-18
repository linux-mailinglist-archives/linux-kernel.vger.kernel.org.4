Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B760A62FC96
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 19:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242776AbiKRSXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 13:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242629AbiKRSXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 13:23:03 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E1F920AD;
        Fri, 18 Nov 2022 10:23:01 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AIHm6Jm021427;
        Fri, 18 Nov 2022 18:22:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=CYJ2Ai4ZT330OMgZqIoMSUjc+yrJx5wTJ+a2JEmIrZY=;
 b=ZUTEWm9fgwGAiFPsTJJyQL5j3CLLt7z8wj4kKxUCC8/PwIAFZaWek3bcZ4N7+1j4ZVuP
 +jA2mUo7s/G4q85acaoGWp3+UbKzjSyzozgflbHVk965qLqCCpoLHm68qOm3CLQz5Bel
 uDMUWJJrHmqZrf7OdZMjdZuVB5QnleqpWuJR0TnXFkhWN+KhRy/FMHe1gLVoOQPk1k3J
 PFpByR7JuHLdjsLNIGo8buFPjYjkOilXSzWLAAAYOnfL6ltgbWy1U/CYpG9K3Fx8AmTo
 DX2cZFZ70jAsFt1p+nV6O4hW+GRuea5c0T+zChlaHJKfeGahLrLlzovwVH9BkeCFKb+Y vA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kx0wu9wm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 18:22:57 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AIIMutQ031246
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 18:22:56 GMT
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 18 Nov 2022 10:22:56 -0800
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
Subject: [PATCH v4 0/3] Add interconnect support for QDU1000/QRU1000 SoCs
Date:   Fri, 18 Nov 2022 10:22:42 -0800
Message-ID: <20221118182245.31035-1-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: b0oQmnrdWLmB9FfahZj_8b9cKtb47AwB
X-Proofpoint-ORIG-GUID: b0oQmnrdWLmB9FfahZj_8b9cKtb47AwB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-18_06,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=939 phishscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211180109
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Changes from v3:
- add bindings document for virt rpmh devices
- explictly defined const structs as so

Changes from v2:
- Dropped qru compat strings
- Removed required reg string for interconnects

Melody Olvera (3):
  dt-bindings: interconnect: Add rpmh virt devices
  dt-bindings: interconnect: Add QDU1000/QRU1000 devices
  interconnect: qcom: Add QDU1000/QRU1000 interconnect driver

 .../bindings/interconnect/qcom,rpmh-virt.yaml |   55 +
 .../bindings/interconnect/qcom,rpmh.yaml      |    4 +-
 drivers/interconnect/qcom/Kconfig             |    9 +
 drivers/interconnect/qcom/Makefile            |    2 +
 drivers/interconnect/qcom/qdu1000.c           | 1079 +++++++++++++++++
 drivers/interconnect/qcom/qdu1000.h           |   95 ++
 .../dt-bindings/interconnect/qcom,qdu1000.h   |   98 ++
 7 files changed, 1340 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,rpmh-virt.yaml
 create mode 100644 drivers/interconnect/qcom/qdu1000.c
 create mode 100644 drivers/interconnect/qcom/qdu1000.h
 create mode 100644 include/dt-bindings/interconnect/qcom,qdu1000.h


base-commit: 147307c69ba4441ee90c1f8ce8edf5df4ea60f67
-- 
2.38.1

