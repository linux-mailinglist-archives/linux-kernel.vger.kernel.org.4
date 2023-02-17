Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD46869A6F4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 09:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjBQIde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 03:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBQIdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:33:33 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA6E5ECBF;
        Fri, 17 Feb 2023 00:33:32 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31H7sitp019948;
        Fri, 17 Feb 2023 08:33:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=/M73eNYmXrRUBA9lxigWb3ft+EYJwn1JIdPueC8kays=;
 b=ID0qUznxOw8xbX3O6hsDJ7GuSDsz/sPI9YzIYm7CaQd6aoVul+KHQ9BG2bxCTYQUp++X
 Y2iiSyQluCylHZyge9waPL2ShrxKVdMkPfUqDaW/XTdv6ufLAg9lGVy09xSS8iSfzp7S
 gWkaGn36GUD/KI6bBpXsCrUYEcvpFa0y5+Mi6MZV1J8LDoKP8JMJLNgAgXJJRIvSSOrX
 Qvry3OSOj0SNpPrwEXSDwHDdbiBffr8bm4Nbl9aNZ+WgDoLxjR5Bf4G5EJQYbYMigFLl
 /3PfU/Jov5j8rI5iE/tLLFv1O28xeS0q/mNKWqxI8i3+e3TLuwRGW8EUHZA6ZSeuWy0C +Q== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nt5kur30v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 08:33:27 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31H8XRpr015355
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 08:33:27 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 17 Feb 2023 00:33:22 -0800
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>, <quic_srichara@quicinc.com>,
        Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH V3 0/5] Add APSS clock driver support for IPQ5332
Date:   Fri, 17 Feb 2023 14:03:03 +0530
Message-ID: <20230217083308.12017-1-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8uhotncwlFJQxc9dDqhxZl9cKZNObyh6
X-Proofpoint-ORIG-GUID: 8uhotncwlFJQxc9dDqhxZl9cKZNObyh6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_04,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 mlxlogscore=802 mlxscore=0 adultscore=0
 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302170076
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Changes since V2:
	- Pick up R-b tags and sort the node in DTS
	- V2 can be found at
	   https://lore.kernel.org/linux-arm-msm/20230208042850.1687-1-quic_kathirav@quicinc.com/

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

