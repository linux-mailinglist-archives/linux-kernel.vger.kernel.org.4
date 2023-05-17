Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62308706F5B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 19:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjEQR02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 13:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjEQR0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 13:26:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C74AD3A;
        Wed, 17 May 2023 10:26:01 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HCTY8L029308;
        Wed, 17 May 2023 17:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=TSWWrlw7RAJA3TsQuX1ZICmW15vT9/5FlcTvKyFdusA=;
 b=PvqQfmg9S0p623C/Ge06+qvmqgUyO33BNVqM1m2WVRaNWc0SJlczANQ9dDasi3n1Qml3
 l17nSyn+cfB/4Jz6g1PS0fvp3YOnNohb/d+dKp8OtdrPLyZE59XE0JMLhXLnonukwaJW
 6dyRNBQdLDlIY20pGwHXOiq6dcX8bksYo9u4RqdQy6kzrmcWJCelDG6EmpAfsgou/vWP
 Rva8Kzd4Keijyafho5RDDu8pHNniJTHv9YFropQZqO5Yp80Ny9zfrG48jcuGNzTY8WyX
 dFMDAJBXKkpZaQdZA2m9d2C5XOaC1ovOlmyDAiGMEXPHwSwagGnjhbFI5dzLd0fbXhaX 1w== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qmxyp0q31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 17:25:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34HHPjFR006920
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 17:25:45 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 17 May 2023 10:25:41 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>
Subject: [PATCH V5 0/3] Add regulator support for IPQ9574 SoC
Date:   Wed, 17 May 2023 22:55:24 +0530
Message-ID: <20230517172527.1968-1-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9OmuzeIj-fPsPcTKsvUMIdNrIkGWxqib
X-Proofpoint-GUID: 9OmuzeIj-fPsPcTKsvUMIdNrIkGWxqib
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=285
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ9574 SoC uses the PMIC MP5496 and SMPA1 regulator for APSS voltage scaling.
This patch series adds support for the same and also enables the RPM 
communication over the RPMSG framework.

DTS patch depends on the below series which applies cleanly on top of [1]
https://lore.kernel.org/linux-arm-msm/20230406061314.10916-1-quic_devipriy@quicinc.com/

[1] https://lore.kernel.org/linux-arm-msm/20230515150722.12196-1-quic_anusha@quicinc.com/

[V5]: 
	- Dropped the below patches as they are already part of linux-next/master
		[1/5] regulator: qcom_smd: Add s1 sub-node to mp5496 regulator
		[2/5] regulator: qcom_smd: Add MP5496 S1 regulator

	- Rebased on the below series
	https://lore.kernel.org/linux-arm-msm/20230406061314.10916-1-quic_devipriy@quicinc.com/

[V4]:
	https://lore.kernel.org/linux-arm-msm/20230407155727.20615-1-quic_devipriy@quicinc.com/
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

Devi Priya (3):
  arm64: dts: qcom: ipq9574: Add RPM related nodes
  arm64: dts: qcom: ipq9574: Add SMPA1 regulator node
  arm64: dts: qcom: ipq9574: Add cpufreq support

 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts | 19 +++++
 arch/arm64/boot/dts/qcom/ipq9574.dtsi       | 77 ++++++++++++++++++++-
 2 files changed, 95 insertions(+), 1 deletion(-)

-- 
2.17.1

