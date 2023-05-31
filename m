Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6CD717755
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 08:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbjEaG5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 02:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234464AbjEaG5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 02:57:30 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A092C123;
        Tue, 30 May 2023 23:57:17 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34V4qpA2031333;
        Wed, 31 May 2023 06:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=NR3Q8HzM/kNZvUW8fosfrOWA+FQP1xa9077RQjFPCRU=;
 b=n0jUFH0ExkxQOxqWQGG5j5JXVsy4VNO6I4dIUSkaPPoulopSY8lN9Vrg77P/PKRpYvMY
 rYhJjew71pEURp3q5XBg7dXxhWdbLgB4OF5BETreVyX6KpepCmUy9+1sp8Bv0dHYuvmb
 aNO+3vS85wJYYJI7VMd5499D234c26jLX4fIwtxAYE+4SvYveeK3LuIQ/chW2MWlf4qX
 Z/Y+NkxGeSdQjhF83tG3/0J3V5LzAoOt6Xz3Jk6vUwPs3OHDgxlv1+sDAdjlZlJHOs9J
 HNzAg1MLWNffnhmgzGhTaAIgQyycd55jNx260482fBskXF1k7zVBRgtPk4UH2e3ZiskQ /Q== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qwx8q8cj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 06:57:13 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34V6vC7X025284
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 06:57:12 GMT
Received: from sridsn-linux.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 30 May 2023 23:57:09 -0700
From:   Sridharan S N <quic_sridsn@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Sridharan S N <quic_sridsn@quicinc.com>
Subject: [PATCH 0/2] Add support for GPIO based leds and buttons
Date:   Wed, 31 May 2023 12:26:17 +0530
Message-ID: <20230531065619.9181-1-quic_sridsn@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: D5lverxT6EwCN_8Cfy1qY6ONoGxu403L
X-Proofpoint-GUID: D5lverxT6EwCN_8Cfy1qY6ONoGxu403L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_03,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=563 adultscore=0 impostorscore=0 malwarescore=0 clxscore=1011
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305310061
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
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

 arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts | 43 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts | 43 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts | 43 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/ipq9574-rdp418.dts | 20 ++++++++++
 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts | 20 ++++++++++
 arch/arm64/boot/dts/qcom/ipq9574-rdp449.dts | 20 ++++++++++
 arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts | 20 ++++++++++
 7 files changed, 209 insertions(+)

-- 
2.17.1

