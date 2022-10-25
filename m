Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002CC60C316
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 07:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiJYFIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 01:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiJYFHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 01:07:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46FC133311;
        Mon, 24 Oct 2022 22:06:30 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29P4KMOB008691;
        Tue, 25 Oct 2022 05:06:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=8xyiXvZjbxXhCBSXY+hjWgeku7qnVeQ3Jkuvo1+Tu8Q=;
 b=hipVOKORk+Zaya0rzrvCVzikobKFBBZgqRqx/GOJbJqPCm5CPQq/UabdcQx2ZBXSgLWv
 OMBUSa/yM+WeyNIHnEMu2nrB/1gMYbGV0w9doUIboZ9JEKFj8Y3YxoWPPN9FUC6feXut
 gE0g73z8HdPlTaG51vhS65tes8r4nPXVpnTKbLM+3Qruc6XlALk9j6g5Vemdqz5VV762
 45AmfKoDMRMDjgLTGIfFzcMu13AD2/f0i2vBtas3GIkDGJ7s6nBXHG6kgp3bNONGGsAc
 wJSzTqFycA7rhwgcUDKF4rF1TynGRGOFtGuI+rRthjR4FAHm7ZIC1Tr5PV5kUKRRxVgH VQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kc848dbty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Oct 2022 05:06:27 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29P56Qj1018074
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Oct 2022 05:06:26 GMT
Received: from fenglinw2-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 24 Oct 2022 22:06:24 -0700
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sboyd@kernel.org>
CC:     <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_fenglinw@quicinc.com>
Subject: [RESEND PATCH v1 0/2] Add changes to support SPMI resource protection
Date:   Tue, 25 Oct 2022 13:06:04 +0800
Message-ID: <20221025050608.2635173-1-quic_fenglinw@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cop_2Ilyxr4SBY9V16QGSHuKszjuEZie
X-Proofpoint-ORIG-GUID: cop_2Ilyxr4SBY9V16QGSHuKszjuEZie
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_01,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxlogscore=650 adultscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 clxscore=1011 mlxscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210250028
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a secure VM uses the SPMI PMIC arbiter driver to access PMIC modules
with secure access, such as in a trust UI feature when the secure VM is
accessing PMIC modules that supply to display power rails, the display
driver in primary VM (no-secure) needs to translate the SPMI address of
the PMIC modules and get the corresponding physical SoC register range
within the SPMI PMIC arbiter that is used to initiate SPMI write transactions,
and lend the memory range to the secure VM via a hypervisor call to prevent
any SPMI access to these modules from the non-secure VM. Hence, an API for
such SPMI address translation is added and exported.

Further, the secure-VM that loads the SPMI PMIC arbiter driver can't specify
the PMIC arbiter HLOS EE summary IRQ becuase it can't have the permission,
also the secure VM has no needs to use the PMIC modules interrupt, hence add
a change to make the interrupt support optional for the secure-VM to specify
the PMIC arbiter device node without interrupt support. The driver change has
a binding document change which has already been applied:
https://lore.kernel.org/all/YmxnIQ9niVbyASfN@robh.at.kernel.org/

David Collins (2):
  spmi: pmic-arb: add support to map SPMI addresses to physical addr
  spmi: pmic-arb: make interrupt support optional

 drivers/spmi/spmi-pmic-arb.c           | 149 ++++++++++++++++++++++---
 include/linux/soc/qcom/spmi-pmic-arb.h |  23 ++++
 2 files changed, 155 insertions(+), 17 deletions(-)
 create mode 100644 include/linux/soc/qcom/spmi-pmic-arb.h

-- 
2.25.1

