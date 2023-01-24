Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518BB67A1AC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 19:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbjAXSpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 13:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbjAXSo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 13:44:57 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652037299;
        Tue, 24 Jan 2023 10:44:56 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30OFqEjJ030189;
        Tue, 24 Jan 2023 18:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=Fnf9C8QuLCGeFDnjj2KDCjQLXZy3LmK6fzqg9/IR634=;
 b=DbNdyA6xrVIc5jmOLEx9SHPVJbBX+fOjep1pT6cIlPXVeKxNLvaetOe/f8aUbor5eq7d
 8rUiVqz2Tyj/TbawPblA+EsD2/TbJ6q5PT686m08Gj+bg/cBhcF4mWyPpKKVXu5TsOwr
 yMWqnx3I2OBYANsW5OQf+/fKV1rxC7SuC0gvnzFeiMXCHaMEkIQFdd1ZoC48vy75SOU0
 SteMZwRslpy1ZmekiTissejE8we2gPSYDAdTsAxSvTWinssr5XTbiOQ7cO/OLfPhrJIF
 JHD0xyNY55gjl0/G4/wSE4+bOTCnRo06AWdnnopnSLLFSkS5CPrMot/GND4fMRVb2WAa yA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n89dndnh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 18:44:47 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30OIikdX004148
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 18:44:46 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 24 Jan 2023 10:44:45 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v2 0/3] regulator: Add Maxim MAX20411 support 
Date:   Tue, 24 Jan 2023 10:44:37 -0800
Message-ID: <20230124184440.1421074-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kjq_ybdqihIIj7eKxTteUIYAABoybJTa
X-Proofpoint-ORIG-GUID: kjq_ybdqihIIj7eKxTteUIYAABoybJTa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-24_13,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=854 suspectscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301240171
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce binding and driver for the Maxim MAX20411, and wire these up
on the Qualcomm SA8295P ADP.

Bjorn Andersson (3):
  regulator: dt-bindings: Describe Maxim MAX20411
  regulator: Introduce Maxim MAX20411 Step-Down converter
  arm64: dts: qcom: sa8295p-adp: Add max20411 on i2c12

 .../bindings/regulator/maxim,max20411.yaml    |  58 +++++++
 arch/arm64/boot/dts/qcom/sa8295p-adp.dts      |  41 +++++
 drivers/regulator/Kconfig                     |   8 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/max20411-regulator.c        | 163 ++++++++++++++++++
 5 files changed, 271 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max20411.yaml
 create mode 100644 drivers/regulator/max20411-regulator.c

-- 
2.25.1

