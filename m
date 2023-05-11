Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC26A6FED51
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 09:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237656AbjEKH6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 03:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237149AbjEKH6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 03:58:48 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2275183CE;
        Thu, 11 May 2023 00:58:45 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34B5w4PT028473;
        Thu, 11 May 2023 07:58:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=yxIaDKbTZyQioRWP53dehZTWKzvQDJYxDuHpbkUnO68=;
 b=Lg7Ncl9BKwJAyJXi7A2iDoA+IpbSuZl3Ei4ExaRdfdWbQbSr5CkQR0ZYOAARLWFwmO00
 Cr9Zz4oDdEXEwyKEK4XfkiUMIDCRLyYf2Xoonof/kHFHexChf+g2y6Kga/V14kD6da1h
 bFacYNrAL3Zb+rCK4GzL2ZAW0BrqoDHB2sh1/h9a7PvDY7FcdW3Le5Go/MuqCIft3A6k
 fip2ECILfsQ6HWY1J+nbpuuyiqlPyiYpMmyemBgB9rdaop59nvWjyBLvSyKZoSnk3Q2C
 m9mWG1EuzEaWKjLMMxVfzGcsR0gWSKtXwjRHB6Wq41E9PkEgzOagsXjhqylSQCqE/AoS qw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qgkxmrwhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 07:58:36 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34B7wZ79012400
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 07:58:35 GMT
Received: from poovendh-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 11 May 2023 00:58:29 -0700
From:   Poovendhan Selvaraj <quic_poovendh@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <uic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_devipriy@quicinc.com>
Subject: [PATCH V7 0/2] Enable crashdump collection support for IPQ9574
Date:   Thu, 11 May 2023 13:28:12 +0530
Message-ID: <20230511075814.2370-1-quic_poovendh@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: y13i4iTRejS1SfTvk_4LZnmxTBwtkXZI
X-Proofpoint-GUID: y13i4iTRejS1SfTvk_4LZnmxTBwtkXZI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-11_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 clxscore=1011 mlxlogscore=539 priorityscore=1501
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305110068
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Crashdump collection is enabled based on the DLOAD bit in the TCSR register.
This bit is set during bootup and clearing during shutdown. During crash,
dload bit is not cleared, due to which uboot starts crashdump collection.

Enable the support for download mode to collect the crashdumps if
system crashes, to debug crashes extensively.

During the bootup, bootloaders initialize the SMEM. However the bootup
after crash, SMEM will not be initialized again. If the memory for the
SMEM is not reserved, linux consumes that region, which leads to the
loss of SMEM data. So, during the next bootup after crash, bootloaders
will hang due to invalid data present in the SMEM region. Due to this,
added the SMEM support along with crashdump collection series.

This patch series adds the support for crashdump collection.

DTS patch depends on the IPQ9574 baseport series
	  https://lore.kernel.org/linux-arm-msm/20230425084010.15581-1-quic_devipriy@quicinc.com/
V7:
	- [1/2] Sorted the firmware node alphabetically
	- [2/2] No changes

V6 can be found at
	  https://lore.kernel.org/linux-arm-msm/20230328102013.21361-1-quic_poovendh@quicinc.com/
	  
V5 can be found at
	  https://lore.kernel.org/linux-arm-kernel/20230216120012.28357-1-quic_poovendh@quicinc.com/

V4 can be found at
	  https://lore.kernel.org/linux-arm-kernel/20230214051414.10740-1-quic_poovendh@quicinc.com/

V3 can be found at
	  https://lore.kernel.org/linux-arm-msm/20230208053332.16537-1-quic_poovendh@quicinc.com/

Changes in V2:
	- rebased on linux-next/master
	- dropped co-developed by tag wherever applicable
	- V1 can be found at
	  https://lore.kernel.org/linux-arm-kernel/20230113160012.14893-1-quic_poovendh@quicinc.com/

Poovendhan Selvaraj (2):
  arm64: dts: qcom: ipq9574: Enable the download mode support
  arm64: dts: qcom: ipq9574: Add SMEM support

 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)


base-commit: aabe491169befbe5481144acf575a0260939764a
-- 
2.17.1

