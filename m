Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B69674591
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjASWLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjASWKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:10:53 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0C2DA8F0;
        Thu, 19 Jan 2023 13:48:03 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JLc0A7010244;
        Thu, 19 Jan 2023 21:47:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=HIul3V74UEhoJjqbqmdz4BnLDMDvH3hhdV73q8cQaYY=;
 b=M4H1sC9DIjYdksVSESasNth65yrpoeNM0NuiXw1b20mx4mp0XhAwjBwkrtB81PwGsZPd
 4uimFXFtGrLk2T1tna0+LYN+1nfHykKNAtjy3BGytFTL0ZHrZoFHO9peXpY+RMKJf+KE
 gBYRyrZhkU4E774MWflqnyIBoLym1togVwyEFsl6BmdTBIwNy2gdUoQ+NVolpOY0j7HY
 /aWE+KlRwfMMY2Ol6OwIG3q0BgtGtmZpyjt3KriqcLyXYVWO7LBciEpNJr3oY8FfSDzQ
 zdC0tpaoJaDxjs/m/Lx4SeKSPjBXMCUXsRrsb5lxaCyRlj9X9vvTx3Nfjt2Dlq1lZxLt 7Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n6vg02n2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 21:47:55 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30JLlsu2012455
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 21:47:54 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 19 Jan 2023 13:47:54 -0800
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
Subject: [PATCH 0/4] regulator: Add Maxim MAX20411 support
Date:   Thu, 19 Jan 2023 13:47:45 -0800
Message-ID: <20230119214749.4048933-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ps6HGGIyhmTwTpDBgKBrXQ91NTPZmoeB
X-Proofpoint-GUID: ps6HGGIyhmTwTpDBgKBrXQ91NTPZmoeB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_14,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 mlxlogscore=841 suspectscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190183
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

Bjorn Andersson (4):
  dt-bindings: regulator: Describe Maxim MAX20411
  regulator: Introduce Maxim MAX20411 Step-Down converter
  arm64: dts: qcom: sc8280xp: Add qup1_i2c4
  arm64: dts: qcom: sa8295p-adp: Add max20411 on i2c4

 .../bindings/regulator/maxim,max20411.yaml    |  59 +++++++
 arch/arm64/boot/dts/qcom/sa8295p-adp.dts      |  41 +++++
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        |  16 ++
 drivers/regulator/Kconfig                     |   8 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/max20411-regulator.c        | 163 ++++++++++++++++++
 6 files changed, 288 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max20411.yaml
 create mode 100644 drivers/regulator/max20411-regulator.c

-- 
2.37.3

