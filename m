Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3223B7329DF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245459AbjFPIdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjFPIdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:33:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3A92D4D;
        Fri, 16 Jun 2023 01:33:32 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35G8EYmH032761;
        Fri, 16 Jun 2023 08:33:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=qUqY/n6KDFwI17yYU0Q9hBztJRtqKxxJ9IpJOixWwgo=;
 b=QbnqYdt4fL54yELn6LY2sbVOMm89jvs+pEgGrNQiokw8dROSp7KvcOHyAxqMlhcaS2pE
 NwhjpfwxjbppnhJuuO0ZydflZcZueeFk4HKCU+PAeJa1E//8lEWg/8rdvdNFnD3qG3Ev
 ArxSFwETnM8WqMEh+NQW9KvtWSxnZCTd+F7H9mgtH5xylo0yKXDaakMfstL0OAHE9E69
 YyOTsmv6IYW0g3iXT2cg7Ws2pG/zmJfVZ7EeZzFDm+ywAmPzVaIRmN2OQDAJCE7uv38m
 ix27c2QRXwEFyyF+1oHIt9ngVzV8w2dcYijvgGoU6OJLHl0nMIo0JCmkPpx7GJGHwifG pw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r8m1mg125-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jun 2023 08:33:29 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35G8XS3x018455
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jun 2023 08:33:28 GMT
Received: from sridsn-linux.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 16 Jun 2023 01:33:02 -0700
From:   Sridharan S N <quic_sridsn@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Sridharan S N <quic_sridsn@quicinc.com>
Subject: [PATCH V4 0/2] Add support for GPIO based leds and buttons on IPQ5332/9574 devices
Date:   Fri, 16 Jun 2023 14:02:36 +0530
Message-ID: <20230616083238.20690-1-quic_sridsn@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GkORsIUBzv49E_agTg9CZXPMEYin0-3U
X-Proofpoint-GUID: GkORsIUBzv49E_agTg9CZXPMEYin0-3U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-16_05,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=557 malwarescore=0 adultscore=0 clxscore=1015
 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306160075
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for wlan-2g led and wps button available on IPQ5332 and
IPQ9574

Changes since V1:
	- Updated patch series title. Mentioned platform in series
	  title
	  
Sridharan S N (2):
  arm64: dts: qcom: ipq5332: enable GPIO based LEDs and Buttons
  arm64: dts: qcom: ipq9574: enable GPIO based LEDs

 .../boot/dts/qcom/ipq5332-rdp-common.dtsi     | 39 +++++++++++++++++++
 .../boot/dts/qcom/ipq9574-rdp-common.dtsi     | 20 ++++++++++
 2 files changed, 59 insertions(+)

-- 
2.17.1

