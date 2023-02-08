Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD53868E70E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 05:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjBHE3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 23:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBHE3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 23:29:14 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532CD3B677;
        Tue,  7 Feb 2023 20:29:13 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31841FVq019455;
        Wed, 8 Feb 2023 04:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=AZBtbN86MnL3/WzWM8oN+UDB8m7i7HmzJmiVNUxVVfE=;
 b=mJydNIyY5x5Z06lxEe/ctbS0rlCb/50L+rSmFe3tSGy6cpH17cR8LtfpocdtEvJk7H+p
 +JI9KgKqsGecwIMjsvFituWsVrDSyObtE4JrFp0jjfq5oDty/ezgOpxAHWCmXcopb466
 ofQfleSrLfsgQ3C8GFcLyNHryE6mLHUXuMII7hDUEOWL+ISmfMdhDzOLcp0mOSJ0lqu+
 zSREGiE0kAPMJfr5muBztUkC4VpDH+8qEfFUu2jllLOIzAr1svPvAZ63gII3JMdREdwE
 rLAar7e75ljnhXTYNOU4YRoVjgjHGzLVTdsx7EJ4+ix7wTlW+hGGG5Fcq275I2Y6Ddm5 7A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nke4h3cw0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 04:29:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3184T7ZR005858
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Feb 2023 04:29:07 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 7 Feb 2023 20:29:02 -0800
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>, <quic_srichara@quicinc.com>,
        Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH V2 0/6] Add APSS clock driver support for IPQ5332
Date:   Wed, 8 Feb 2023 09:58:45 +0530
Message-ID: <20230208042850.1687-1-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IGjU3gBrJYHoOiffZ6GpZleuKUTJ6J6t
X-Proofpoint-ORIG-GUID: IGjU3gBrJYHoOiffZ6GpZleuKUTJ6J6t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-07_15,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=775 spamscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302080039
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the APSS clock to bump the CPU frequency
above 800MHz.

APSS PLL found in the IPQ5332 is of type Stromer Plus. However the
existing IPQ targets uses the Huayra PLL. So the driver has to
refactored to accommodate the different PLL types. The first patch in
the series does the refactoring, which can be independenty merged.

For the Stromer PLL separate function clk_stromer_pll_configure is
introduced, so the 3rd patch in the series depends on the below patch
https://lore.kernel.org/linux-arm-msm/20230120082631.22053-1-quic_kathirav@quicinc.com/

DTS patch depends on the IPQ5332 baseport series
https://lore.kernel.org/linux-arm-msm/20230130114702.20606-1-quic_kathirav@quicinc.com/

Changes since V1:
	- Dropped the patch 5/6, since the fallback mechanism for compatible
	  is introduced to avoid bloating the of_device_id table
	- V1 can be found at
	  https://lore.kernel.org/linux-arm-msm/20230202145208.2328032-1-quic_kathirav@quicinc.com/

Kathiravan T (5):
  clk: qcom: apss-ipq-pll: refactor the driver to accommodate different
    PLL types
  dt-bindings: clock: qcom,a53pll: add IPQ5332 compatible
  clk: qcom: apss-ipq-pll: add support for IPQ5332
  dt-bindings: mailbox: qcom: add compatible for the IPQ5332 SoC
  arm64: dts: qcom: ipq5332: enable the CPUFreq support

 .../bindings/clock/qcom,a53pll.yaml           |   1 +
 .../mailbox/qcom,apcs-kpss-global.yaml        |  18 ++-
 arch/arm64/boot/dts/qcom/ipq5332.dtsi         |  37 ++++++
 drivers/clk/qcom/apss-ipq-pll.c               | 116 +++++++++++++++---
 4 files changed, 147 insertions(+), 25 deletions(-)

-- 
2.17.1

