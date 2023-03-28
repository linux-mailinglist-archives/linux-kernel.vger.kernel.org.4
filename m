Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6944D6CBC6E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjC1KUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 06:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjC1KUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 06:20:47 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4734EE8;
        Tue, 28 Mar 2023 03:20:45 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32SA39Rf021238;
        Tue, 28 Mar 2023 10:20:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=WI7hat+HkOS+r0DWL2leZsJFqenf6gVLJkg4WXWjSh0=;
 b=mw8TbpBpJgonbm/BMFTAZ0Ng/XFSjZl57xix7tBcu0tAHqEaQmsIorqIBg6p0mhAeqzC
 jix/L6SJE5NZTHHpm/o0fDqBJZ9FAI4YjjznG0s4W7JFJ5xNrbX968VuB3cAiOVJEwou
 27snQ4jSRx10mY3ePsM5fcDTxOinVGwW6bfc/btKocW3LjFojCl6rmP5KcKiMsavbiEN
 UoZPTWuzFbzUB8S86UyKX7s2MX/Q/94N999lTa6ifz0w+sGjobBLXPDCltSfDc9n6kBa
 qpnf9PIssyRdcrtSGaqe2dW75/tasEXmqXXOhjkGJ3/c1/wk1DDOQgpYGUOpdWmFYtA5 Dg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pkx4t8157-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 10:20:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32SAKbY6005002
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 10:20:37 GMT
Received: from poovendh-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 28 Mar 2023 03:20:31 -0700
From:   Poovendhan Selvaraj <quic_poovendh@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_devipriy@quicinc.com>
Subject: [PATCH V6 0/2] Enable crashdump collection support for IPQ9574
Date:   Tue, 28 Mar 2023 15:50:11 +0530
Message-ID: <20230328102013.21361-1-quic_poovendh@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WjELJyxGZMFaeLPJlZwGeyde4OKkiGgd
X-Proofpoint-ORIG-GUID: WjELJyxGZMFaeLPJlZwGeyde4OKkiGgd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=832 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303280086
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
	https://lore.kernel.org/linux-arm-kernel/20230327132718.573-1-quic_devipriy@quicinc.com/

V6:
	- Dropped the below patches as it is already part of linux-next/master
          [1/5] dt-bindings: scm: Add compatible for IPQ9574
	  [2/5] dt-bindings: mfd: Add the tcsr compatible for IPQ9574
	- Dropping patch [5/5] firmware: scm: Modify only the DLOAD bit in TCSR
	  register for download mode as it is posted part of below series
	  https://lore.kernel.org/lkml/1676990381-18184-1-git-send-email-quic_mojha@quicinc.com/#r

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


base-commit: a6faf7ea9fcb7267d06116d4188947f26e00e57e
-- 
2.17.1

