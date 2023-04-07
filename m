Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A776DAFEC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 17:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbjDGP5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 11:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDGP5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 11:57:51 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A784B6EB7;
        Fri,  7 Apr 2023 08:57:50 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 337Esl68031504;
        Fri, 7 Apr 2023 15:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=pdQyPeL8PLRJLtK4NoOm2t41du0/gRjqTNHbuqp88bY=;
 b=HVJttcdsoX65xfcxg4NtvIE6VLNDRDxTliBtTCuaTFiEIebzd2Y7ds80piQ+b2oq4TOC
 KiYHx4KCleBgIGY07sV6Ii/9AjcAAOnyr9VN66gy1YuhXOI6ucBn8o3bFagkh8a+6P0B
 g6nwJo9swjnxI67Y6jdGOqS9ItOXHdsalmzxCXbpbSfveT+/RRqe4Z5+xBfmM2kQWI9f
 E+ZNZ/PfYyklTvUfIK3ULijqxNc/RVaashfFWuiEsgvTUuvKX+EVLcvE53Yr0oWHQZY9
 puMbROD7RCQlssshLOMiCv/0A6hctkU8LQiPp3VozlboWU7DNTBuNwrpB8VEkjx/95CU LQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ptb9whb3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 15:57:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 337FvkEu006940
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Apr 2023 15:57:46 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 7 Apr 2023 08:57:40 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>
Subject: [PATCH V4 0/5] Add regulator support for IPQ9574 SoC
Date:   Fri, 7 Apr 2023 21:27:22 +0530
Message-ID: <20230407155727.20615-1-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -QvzJblJ0jUdWJTsDXOfsyyaHr7Lu-DX
X-Proofpoint-ORIG-GUID: -QvzJblJ0jUdWJTsDXOfsyyaHr7Lu-DX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_10,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 mlxlogscore=456 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304070146
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ9574 SoC uses the PMIC MP5496 and SMPA1 regulator for APSS voltage scaling.
This patch series adds support for the same and also enables the RPM 
communication over the RPMSG framework.

DTS patch depends on the below series
https://lore.kernel.org/linux-arm-msm/20230406061314.10916-1-quic_devipriy@quicinc.com/

[V4]:
	- Detailed change logs are added to the respective patches
[V3]:
	https://lore.kernel.org/linux-arm-msm/20230406070032.22243-1-quic_devipriy@quicinc.com/
	- Dropped PATCH [1/6] dt-bindings: soc: qcom: smd-rpm: Add IPQ9574 compatible
	  as it is available in linux-next/master
	- Dropped PATCH [4/6] regulator: qcom_smd: Add support to define the bootup voltage
	  and updated the nominal voltage in the Board DT as discussed
	- Splitted the board DT changes to a separate patch as suggested
	- Detailed change logs are added to the respective patches
[V2]:
	https://lore.kernel.org/linux-arm-msm/20230217142030.16012-1-quic_devipriy@quicinc.com/
	- Reordered the patches to have the bindings and driver changes
	  in place before the device tree support
	- Dropped the 'soc: qcom: smd-rpm: Add IPQ9574 compatible' since
	  it is already part of the linux-next/master
	- Detailed change log is added to the respective patches
[V1]:
	https://lore.kernel.org/linux-arm-msm/20230113150310.29709-1-quic_devipriy@quicinc.com/

Devi Priya (5):
  regulator: qcom_smd: Add s1 sub-node to mp5496 regulator
  regulator: qcom_smd: Add MP5496 S1 regulator
  arm64: dts: qcom: ipq9574: Add RPM related nodes
  arm64: dts: qcom: ipq9574: Add SMPA1 regulator node
  arm64: dts: qcom: ipq9574: Add cpufreq support

 .../regulator/qcom,smd-rpm-regulator.yaml     |  2 +-
 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts   | 19 +++++
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         | 75 +++++++++++++++++++
 drivers/regulator/qcom_smd-regulator.c        |  5 +-
 4 files changed, 98 insertions(+), 3 deletions(-)

-- 
2.17.1

