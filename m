Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A14694FF3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjBMSxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjBMSxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:53:22 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE4F12849;
        Mon, 13 Feb 2023 10:53:19 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DIlahB008363;
        Mon, 13 Feb 2023 18:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=ZcPZD8e4wxh+7dBC+CQ0oeJCKLJZAAih0oiGJ9JG4xY=;
 b=pjg+nOuMxZgQEVn0j1UXs9NDI1mFENqCqEa97FAFwN/OYSKNHW9MCzs5mnu96Yrh6Jt/
 DVgZenaNHXJNuY39bBrTpA2+IQXOmAYqNuSGY8W5xgjWDNE+Wi01Zcf4hzV0nWOYEVA5
 WH62VS6/avtw2OakB+LXZ+PJZ7ZNpIRSvQjeiUZE3IzWC4LhdQ7vla0PN91K9jGA0wNR
 MW3Nd2EpG2w8OFosQwyalvQYC8jI6XJ5zcLscS2cZis2JbqAR84pz2+/djrl0+jxRfKn
 jaUER+AXNNp7MiM8Y6EhpKpl1dEbt/47Tkz7ecQnF1qdzczvdb5ajBlwqgxYMNpgcx9P 1w== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nqtsur0d0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 18:53:15 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31DIrEeF006970
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 18:53:14 GMT
Received: from hu-molvera-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 13 Feb 2023 10:53:13 -0800
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
CC:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
Subject: [PATCH 0/9] remoteproc: qcom_q6v5_pas: Add support for QDU1000/QRU1000 mpss
Date:   Mon, 13 Feb 2023 10:52:09 -0800
Message-ID: <20230213185218.166520-1-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tbMqf4JVd_5G7q6BvI5oBw8TTMmCrsHw
X-Proofpoint-ORIG-GUID: tbMqf4JVd_5G7q6BvI5oBw8TTMmCrsHw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_12,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=973 phishscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 adultscore=0 impostorscore=0
 suspectscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302130165
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for the mpss found in the QDU1000 and QRU1000
SoCs. 

The mpss boot process now supports late attach for an already running
mpss. For this, it uses an RMB register space to perform a handshake
with the mpss for the late attach process. This is implemented in the
patches below. The patches also address issues with split binary
detection to support loading of split binaries more robustly.

Gokul Krishna Krishnakumar (1):
  soc: qcom: mdt_loader: Enhance split binary detection

Melody Olvera (8):
  dt-bindings: firmware: qcom,scm: Update QDU1000/QRU1000 compatible
  dt-bindings: mailbox: qcom-ipcc: Add compatible for QDU1000/QRU1000
  dt-bindings: soc: qcom: aoss: Document power-domain-cells for aoss
  dt-bindings: soc: qcom: aoss: Document QDU1000/QRU1000 compatible
  dt-bindings: remoteproc: mpss: Document QDU1000/QRU1000 mpss devices
  remoteproc: qcom: q6v5: Add support for q6 rmb registers
  remoteproc: qcom_q6v5_pas: Add support to attach a DSP
  remoteproc: qcom_q6v5_pas: Add QDU1000/QRU1000 mpss compatible & data

 .../bindings/firmware/qcom,scm.yaml           |   1 +
 .../bindings/mailbox/qcom-ipcc.yaml           |   1 +
 .../bindings/remoteproc/qcom,qdu1000-pas.yaml | 127 ++++++++++++++++++
 .../bindings/soc/qcom/qcom,aoss-qmp.yaml      |   5 +
 drivers/remoteproc/qcom_q6v5.c                |   9 ++
 drivers/remoteproc/qcom_q6v5.h                |   8 ++
 drivers/remoteproc/qcom_q6v5_pas.c            | 126 ++++++++++++++++-
 drivers/soc/qcom/mdt_loader.c                 |  64 +++++----
 8 files changed, 311 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,qdu1000-pas.yaml


base-commit: 09e41676e35ab06e4bce8870ea3bf1f191c3cb90
-- 
2.25.1

