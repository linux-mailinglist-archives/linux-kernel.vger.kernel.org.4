Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297626AD2A9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 00:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjCFXMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 18:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjCFXM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 18:12:28 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADAC6BDE0;
        Mon,  6 Mar 2023 15:12:26 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326LmJb8018208;
        Mon, 6 Mar 2023 23:12:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=F473ci7Bo9qB5pVyAJ4eTEqIhxsHYS7Vw2tYQOIjHLA=;
 b=LcKeXx+jSdT8KsI9JVNn9l4AfhtVNM6d8mTpYeMzpzzpgfVKwHFe1JVJi7+3tiqqgyYg
 HwkTQcjNM0N1Zy4ElThqKgqsMiK6/0d6iQ8Z2ZdUA6jEL6GdvylwafaThnK2/NlDpY2G
 bkOzNWkKlzacMOkooDIxZ7Ne/XCpjfou7Bdds7t4UpgZ9oRNZrhdo9wW2xUOX5E0vB1G
 /gt3XmUBaHDCBBQyKXmvfAM2u/jT7UA7/Ok+XxjdTRWPwOVmwhFElw0bNR27YE0JHIp5
 61BjlsBFKO7KpwmWUErWBXjqrFM8SoyuMTt8A0Fwpkfl19J6FWC3zx5k7EnILQqpsrqw KQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p417jx9am-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 23:12:22 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 326NCLm2019288
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Mar 2023 23:12:21 GMT
Received: from hu-molvera-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 6 Mar 2023 15:12:20 -0800
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
Subject: [PATCH v2 0/7] remoteproc: qcom_q6v5_pas: Add support for QDU1000/QRU1000 mpss
Date:   Mon, 6 Mar 2023 15:11:55 -0800
Message-ID: <20230306231202.12223-1-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WqfaSoCLqnldOhFeyd1xKQypaZl8WU2e
X-Proofpoint-ORIG-GUID: WqfaSoCLqnldOhFeyd1xKQypaZl8WU2e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_14,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1015 adultscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=886 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303060202
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

Changes from v1:
* Dropped changes to aoss-qmp
* Renamed mpss pas bindings
* Updated commit msg on mdt loader to be more descriptive
* Fixed syntax errors in bindings
* Updated firmware name in bindings

Gokul Krishna Krishnakumar (1):
  soc: qcom: mdt_loader: Enhance split binary detection

Melody Olvera (6):
  dt-bindings: firmware: qcom,scm: Update QDU1000/QRU1000 compatible
  dt-bindings: soc: qcom: aoss: Document QDU1000/QRU1000 compatible
  dt-bindings: remoteproc: mpss: Document QDU1000/QRU1000 mpss devices
  remoteproc: qcom: q6v5: Add support for q6 rmb registers
  remoteproc: qcom_q6v5_pas: Add support to attach a DSP
  remoteproc: qcom_q6v5_pas: Add QDU1000/QRU1000 mpss compatible & data

 .../bindings/firmware/qcom,scm.yaml           |   1 +
 .../remoteproc/qcom,qdu1000-mpss-pas.yaml     | 130 ++++++++++++++++++
 .../bindings/soc/qcom/qcom,aoss-qmp.yaml      |   1 +
 drivers/remoteproc/qcom_q6v5.c                |   9 ++
 drivers/remoteproc/qcom_q6v5.h                |   8 ++
 drivers/remoteproc/qcom_q6v5_pas.c            | 125 ++++++++++++++++-
 drivers/soc/qcom/mdt_loader.c                 |  64 +++++----
 7 files changed, 308 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,qdu1000-mpss-pas.yaml


base-commit: dc837c1a5137a8cf2e9432c1891392b6a66f4d8d
-- 
2.25.1

