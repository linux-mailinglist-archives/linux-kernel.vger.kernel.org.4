Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29ACE6B89F9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 06:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjCNFAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 01:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjCNFA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 01:00:28 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5056A2CF;
        Mon, 13 Mar 2023 22:00:26 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32E3W8W9011023;
        Tue, 14 Mar 2023 05:00:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=VmvISJ9S+puBdzxd0tEom+iAE8DzGYP8H8n24xD8r6Q=;
 b=V5zCB06bmC5Y5ZNEYjzJYwx2IddJWUF7GML7AihefdZZDu79pKU+2u5t0778+8tXzyi1
 6YnB+jdH9bkDxV21x+gLE0b5MiDOCAUKgQ9yCCiIPdly51PlI3ZiyefyTNBBfkbo2NrO
 EcZh61XRRsxLI2epbKZSrGp7OEpfG4eT04eoGdL40/ZABP3QpFW5wuUXNfWNWaU1bxwa
 wY7Rl61leLeChAv1TeSOyLB7r05eNshTxyRAjPsU6T6os0Nm2TaIgoTeQOBB3x3lZyMu
 ReVKhwV39+v/4gjYO/ui5UAjITjyebcTbhczMMXRZ9OOpPFhzTTEetn40/ZHyC4d6wX7 XA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pa44bt83m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 05:00:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32E50L1N008515
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 05:00:21 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 13 Mar 2023 22:00:18 -0700
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jassisinghbrar@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH V2 0/3] rework mailbox compatibles for Qualcomm IPQ SoCs
Date:   Tue, 14 Mar 2023 10:30:02 +0530
Message-ID: <20230314050005.10409-1-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -sHzcp2EePy5KYFcqLMaioXtojIKdRbn
X-Proofpoint-ORIG-GUID: -sHzcp2EePy5KYFcqLMaioXtojIKdRbn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_13,2023-03-13_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=579 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303140044
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As suggested by Krzysztof[1], we can use the fallback compatible to
avoid duplicating the same device data.

Krzysztof already submitted a series[2] for this by reworking entire
binding and driver and it is conflicting with the Dmitry's series as
mentioned by Krzysztof[3].

So this series addresses IPQ SoCs alone, as I see no dependency with it.

[1]
https://lore.kernel.org/linux-arm-msm/1b75ab1a-44c9-c4a8-7fa4-d601fc710d2a@linaro.org/
[2]
https://lore.kernel.org/linux-arm-msm/20230202161856.385825-1-krzysztof.kozlowski@linaro.org/
[3]
https://lore.kernel.org/linux-arm-msm/fa6dc60c-3799-d384-da24-f282b7cbd3ef@linaro.org/

Kathiravan T (2):
  dt-bindings: mailbox: qcom: use fallback for IPQ8074 SoC
  mailbox: qcom-apcs-ipc: drop the IPQ8074 and IPQ5332 compatible

Krzysztof Kozlowski (1):
  arm64: dts: qcom: ipq8074: add compatible fallback to mailbox

 .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml    | 4 +---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi                         | 3 ++-
 drivers/mailbox/qcom-apcs-ipc-mailbox.c                       | 2 --
 3 files changed, 3 insertions(+), 6 deletions(-)

-- 
2.17.1

