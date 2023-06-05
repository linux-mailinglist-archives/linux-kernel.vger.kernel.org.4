Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E088721D7E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 07:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjFEFaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 01:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbjFEFaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 01:30:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB3DDA;
        Sun,  4 Jun 2023 22:30:00 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35558Csn009125;
        Mon, 5 Jun 2023 05:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=GYvKC/BuUbwvCcEPHzu8xJOy0DyY1lXU4C20wmC9xq8=;
 b=JkV5y7Rr65msB6BBrOWo0chqtw1J7U11T0JxS7MOXkoVjcDh2dkZVm6FjLR7JqebwY9c
 u3btluWPlaKAnHwKLN4QUf6dmGxqm4RPuHGhbPGC67IY5nJxAqkUn+cB3zRvYIH1yqDb
 I0xFrFDvjmxR02wNeeSKxfhi0Kqh3HG6KjuXG8H2TO8W8jaXQtwUjnim5Pii5KZwISww
 PJjBp55f7SMGWA5qgr9yQDCmVApUoAxTlP2o+BL1FHddIp5l/E6JQ8sQ2JbxZZxatCGU
 noyh7DcxrjtCnbGV5z4zzqeTb0M2sAjdaAi1EeRo+NDH9NRtp6fji52SFMvbVmAOGwMA cA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qyvfxjqqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jun 2023 05:29:58 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3555TvJ6003315
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 5 Jun 2023 05:29:57 GMT
Received: from sridsn-linux.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Sun, 4 Jun 2023 22:29:53 -0700
From:   Sridharan S N <quic_sridsn@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Sridharan S N <quic_sridsn@quicinc.com>
Subject: [PATCH V2 0/2] Add support for GPIO based leds and buttons
Date:   Mon, 5 Jun 2023 10:59:05 +0530
Message-ID: <20230605052907.18837-1-quic_sridsn@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lYLKkNv9v6hfWyshcvFSoiHoHc_e6lTN
X-Proofpoint-ORIG-GUID: lYLKkNv9v6hfWyshcvFSoiHoHc_e6lTN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-03_08,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=561
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306050048
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for wlan-2g led and wps button available on IPQ5332 and
IPQ9574

Sridharan S N (2):
  arm64: dts: qcom: ipq5332: enable GPIO based LEDs and Buttons
  arm64: dts: qcom: ipq9574: enable GPIO based LEDs

 arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts | 42 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts | 42 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts | 42 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/ipq9574-rdp418.dts | 20 ++++++++++
 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts | 20 ++++++++++
 arch/arm64/boot/dts/qcom/ipq9574-rdp449.dts | 20 ++++++++++
 arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts | 20 ++++++++++
 7 files changed, 206 insertions(+)

-- 
2.17.1

