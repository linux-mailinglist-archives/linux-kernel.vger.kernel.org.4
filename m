Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7FC7007C3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 14:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241103AbjELMZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 08:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240916AbjELMZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 08:25:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298821434E;
        Fri, 12 May 2023 05:24:55 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CBVVlg001397;
        Fri, 12 May 2023 12:24:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=TOLDap9g4CiRSss99GzEPDthDzvKUOxBI4x2i5gHuY8=;
 b=DTDUkmR5FiFz7nzFNwawTF539aFOktMTrGczJ06C8ZmFVxmS5IPGejjCmahryeq5atQh
 /B3mD1WZ2udlHWuSXY8RgTGMrh/VO1djFeKhDTR3hoCvRV78sR56KzIZhU2bKYVpS9No
 tqHqRulcGllOJjOu0I1e5jzu323Dzg85gtn3YWypVaWbyBY2vvR2lmWVkdC1EgnqILns
 BKcqCboZXlrQD1oo6vaaZVVZ+5fEGONmc64ArYU44lSOS/TKGx4FM2jUIB92hR2yHh/h
 BgDNvEXDidqJAVI4CmxSEent/tJMCvVQizzCYT+GGL9df8yb4OPL6BdOA16kIfb+Uolg dQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qhdf412ra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 12:24:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34CCOOMT019869
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 12:24:24 GMT
Received: from hu-tdas-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 12 May 2023 05:24:19 -0700
From:   Taniya Das <quic_tdas@quicinc.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <jkona@quicinc.com>,
        <quic_rohiagar@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>
Subject: [PATCH V2 0/5] Add GCC and RPMHCC support for sdx75
Date:   Fri, 12 May 2023 17:53:42 +0530
Message-ID: <20230512122347.1219-1-quic_tdas@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hf5MuzCXo0-DEPF6MD4wNr1LvVQbZvrs
X-Proofpoint-ORIG-GUID: hf5MuzCXo0-DEPF6MD4wNr1LvVQbZvrs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_08,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 clxscore=1011 bulkscore=0 spamscore=0 suspectscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120104
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches extends the invert logic for branch2 clocks and adds
GCC, RPMH clocks devicetree bindings and driver support for SDX75 platform.

Imran Shaik (5):
  clk: qcom: branch: Extend the invert logic for branch2 clocks
  dt-bindings: clock: qcom: Add GCC clocks for SDX75
  dt-bindings: clock: qcom: Add RPMHCC for SDX75
  clk: qcom: rpmh: Add RPMH clocks support for SDX75
  clk: qcom: Add GCC driver support for SDX75

 .../bindings/clock/qcom,rpmhcc.yaml           |    1 +
 .../bindings/clock/qcom,sdx75-gcc.yaml        |   65 +
 drivers/clk/qcom/Kconfig                      |    8 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/clk-branch.c                 |    6 +-
 drivers/clk/qcom/clk-rpmh.c                   |   19 +
 drivers/clk/qcom/gcc-sdx75.c                  | 2970 +++++++++++++++++
 include/dt-bindings/clock/qcom,sdx75-gcc.h    |  193 ++
 8 files changed, 3260 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sdx75-gcc.yaml
 create mode 100644 drivers/clk/qcom/gcc-sdx75.c
 create mode 100644 include/dt-bindings/clock/qcom,sdx75-gcc.h

-- 
2.17.1

