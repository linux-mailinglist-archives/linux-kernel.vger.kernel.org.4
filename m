Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2306175DC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 05:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiKCE73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 00:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKCE71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 00:59:27 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BB817E1E;
        Wed,  2 Nov 2022 21:59:24 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A34gIlJ002831;
        Thu, 3 Nov 2022 04:59:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=pzAfUujfgyx2soS+jvSWnljo9EBbCo8FnhU0j8z3GiM=;
 b=WzvkdtSB8dPNHTZycpB5FHYs2F6opz3brP1sjeZCh3qXzBK8b128wk7ET6xF+28MJL7G
 BJsEdGrgKmCGOASkgPRp0hsiGDyTRGD5HpunuJvRInloEX/9d2bvn6kSfq7Jr32zdZyE
 rr9t2CDSxniZJ1QP6e4xmgMvuOBK2MvoP3IEHJ84+To/8O7hBftjr+OX83iQDEqDF80h
 zpOT18ij1grT06ndIJVcAPBx5peS5mcs6bfwofuRs7oVHxEt0EeoWbR567hzmxREmwTH
 PkVjSgNvYKkLcVTRSBj4t05prFaWnaXZPT6E0iifgmyp1NACpNEc/M8dAF6luGQQP8NG Yw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3km6tnr2fc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 04:59:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A34xDrq000688
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Nov 2022 04:59:13 GMT
Received: from blr-ubuntu-87.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 2 Nov 2022 21:59:10 -0700
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <sudeep.holla@arm.com>,
        <cristian.marussi@arm.com>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <konrad.dybcio@somainline.org>, <quic_avajid@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [RFC 0/2] Add support for SCMI QTI Memlat Vendor Protocol
Date:   Thu, 3 Nov 2022 10:28:30 +0530
Message-ID: <1667451512-9655-1-git-send-email-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 72A2vlz4NC6tNXzgA4pkOPkaGRBHslF0
X-Proofpoint-ORIG-GUID: 72A2vlz4NC6tNXzgA4pkOPkaGRBHslF0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=812
 priorityscore=1501 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211030035
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch series documents the bindings and adds support for the
SCMI QTI memlat (memory latency) vendor protocol. The protocol takes
in several tuneables including the IPM ratio (Instructions Per Miss),
bus bandwidth requirements and PMU maps to enable frequency scaling
of various buses (L3/LLCC/DDR). The scaling is performed by the HW
memory latency governor running on the CPUSS Control Processor.

Depends on CPUCP mailbox driver:
https://patchwork.kernel.org/project/linux-arm-msm/cover/1663135386-26270-1-git-send-email-quic_sibis@quicinc.com/

Sibi Sankar (2):
  dt-bindings: firmware: arm,scmi: Add support for memlat vendor
    protocol
  firmware: arm_scmi: Add SCMI QTI Memlat vendor protocol

 .../devicetree/bindings/firmware/arm,scmi.yaml     | 164 +++++++++++++
 drivers/firmware/arm_scmi/Kconfig                  |  10 +
 drivers/firmware/arm_scmi/Makefile                 |   1 +
 drivers/firmware/arm_scmi/qcom_memlat_vendor.c     | 269 +++++++++++++++++++++
 include/linux/scmi_protocol.h                      |  36 +++
 5 files changed, 480 insertions(+)
 create mode 100644 drivers/firmware/arm_scmi/qcom_memlat_vendor.c

-- 
2.7.4

