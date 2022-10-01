Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A175F18CF
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 05:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbiJADF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 23:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbiJADFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 23:05:12 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF533844A;
        Fri, 30 Sep 2022 20:04:54 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2912oaNN003721;
        Sat, 1 Oct 2022 03:04:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=igv6niMS2DbBmnf0TO0/yZyVq6ba24oDDUVUV0BoS0o=;
 b=DScxxCg3U0hDSS8q3E7dpQxTWia1w/n/G0SJI5yhdtewD6mug2CVgc5LgBFugQd/C31s
 YvJUWfBfBymvwTpFXmVfeGZcxaBV118zJrl4jk1HDMsf1wUNtICkqanAOGYCzOk1SLta
 jIDwWJhLNRssNomviwEunpWYvDBnGKZ7lCkj/BsN9Adv2Btk/XzQo8cA+JtPUjzIhmjS
 Eqiqeqr+AyavkSubRL/BhC4dBOTtS39ylqsCdXNM7bFx2C18iWUB+FyEDAOe5vCugsYD
 DgZe1HgGUVFQGuu7vhDOxeFazie9IKlJXyre3ubHoq7IIDDtnMt0uFE2BEkueU6N04um rA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jx70grpfe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 01 Oct 2022 03:04:33 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29134W2W029604
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 1 Oct 2022 03:04:32 GMT
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 30 Sep 2022 20:04:32 -0700
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH 0/5] clk: qcom: Add clocks for the QDU1000 and QRU1000 SoCs
Date:   Fri, 30 Sep 2022 20:03:58 -0700
Message-ID: <20221001030403.27659-1-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hMmyXbbYZiuXI_tEk7tPidP7-7iks5rJ
X-Proofpoint-ORIG-GUID: hMmyXbbYZiuXI_tEk7tPidP7-7iks5rJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-01_02,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 malwarescore=0 mlxlogscore=873 adultscore=0 impostorscore=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210010016
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the GCC, RPMh, and PDC clock support required for the
QDU1000 and QRU1000 SoCs along with the devicetree bindings for them.

The Qualcomm Technologies, Inc. Distributed Unit 1000 and Radio Unit
1000 are new SoCs meant for enabling Open RAN solutions. See more at
https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/qualcomm_5g_ran_platforms_product_brief.pdf

This patchset is based on the YAML conversion patch [1] submitted already.

[1] https://lore.kernel.org/r/20220103074348.6039-1-luca.weiss@fairphone.com

Melody Olvera (4):
  dt-bindings: clock: Add QDU1000 and QRU1000 GCC clock bindings
  dt-bindings: clock: Add RPMHCC bindings for QDU1000 and QRU1000
  clk: qcom: Add support for QDU1000 and QRU1000 RPMh clocks
  dt-bindings: clock: Introduce pdc bindings for QDU1000 and QRU1000

Taniya Das (1):
  clk: qcom: Add QDU1000 and QRU1000 GCC support

 .../bindings/clock/qcom,gcc-qdru1000.yaml     |   74 +
 .../bindings/clock/qcom,rpmhcc.yaml           |    2 +
 .../interrupt-controller/qcom,pdc.yaml        |    2 +
 drivers/clk/qcom/Kconfig                      |    8 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/clk-branch.c                 |    5 +
 drivers/clk/qcom/clk-branch.h                 |    2 +
 drivers/clk/qcom/clk-rpmh.c                   |   14 +
 drivers/clk/qcom/gcc-qdru1000.c               | 2649 +++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-qdru1000.h |  170 ++
 10 files changed, 2927 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-qdru1000.yaml
 create mode 100644 drivers/clk/qcom/gcc-qdru1000.c
 create mode 100644 include/dt-bindings/clock/qcom,gcc-qdru1000.h


base-commit: 987a926c1d8a40e4256953b04771fbdb63bc7938
prerequisite-patch-id: d3a56569439f223ee220dee951400e18983fee3e
-- 
2.37.3

