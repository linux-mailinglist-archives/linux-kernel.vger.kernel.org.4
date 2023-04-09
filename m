Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F95A6DC0F7
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 20:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjDISUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 14:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDIST7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 14:19:59 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFFA2D6B;
        Sun,  9 Apr 2023 11:19:58 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 339IG9n6030867;
        Sun, 9 Apr 2023 18:19:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=HFWt632w13eu7crNuaAZJaG0Z2AsJR73zPVwExvaiDI=;
 b=f/DG79aht04HPWBzwKNpFBAQ6cBEhsFvHSI09x+Q1Dl9ey4zRnkJC2hyQ5GVseZMD9bc
 eqFhmB3rHHbV6ieGxAAvGlBh9Ct0vv6CYLOLcagxtnK+WiyLTYlR5ByVNAfMlBgIHnT8
 OpX/MKjon5Ez86STsLG96N+/nCVKtzci7ruhlsuX2Unl2KmF6Yiq7B1duSQqo0uJBEHd
 Ee8dx8qNUvgcemhdw+ZsYO/NtbbIxpafxJQyhdKvY/5mrIAivuf1ZpkeP1tk+V0Auk7x
 wc058Ig/DnwYNbSHc70A5gGTOgnDq6ACLzVqnNbREhQk1j7Kn3g+5FUwoNVFlYWraN3e Kw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ptwmysthc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 09 Apr 2023 18:19:41 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 339IJeLL032714
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 9 Apr 2023 18:19:40 GMT
Received: from car-linux11.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Sun, 9 Apr 2023 11:19:40 -0700
From:   Nikunj Kela <quic_nkela@quicinc.com>
To:     <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nikunj Kela <quic_nkela@quicinc.com>
Subject: [PATCH 0/2] Allow parameter in smc/hvc calls
Date:   Sun, 9 Apr 2023 11:19:16 -0700
Message-ID: <20230409181918.29270-1-quic_nkela@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fDnl3jJFTuodqjJR4frDiAxp7U4JmLpI
X-Proofpoint-GUID: fDnl3jJFTuodqjJR4frDiAxp7U4JmLpI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-09_13,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 priorityscore=1501 adultscore=0 spamscore=0 mlxscore=0 clxscore=1011
 suspectscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=561 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304090167
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, smc/hvc calls are made with parameters set
to zeros. We are using multiple scmi instances within
a VM and hypervisor associates a tag with each instance
and expects the tag in smc calls from that instance, while
sharing the same smc-id(func_id) among the instances.

This patch series introduces new optional dtb bindings which
can be used to pass parameters to smc/hvc calls.

Nikunj Kela (2):
  dt-bindings: firmware: arm,scmi: support parameter passing in smc/hvc
  firmware: arm_scmi: Augment SMC/HVC to allow optional parameters

 .../bindings/firmware/arm,scmi.yaml           | 16 +++++
 drivers/firmware/arm_scmi/smc.c               | 66 ++++++++++++++++++-
 2 files changed, 81 insertions(+), 1 deletion(-)

-- 
2.17.1

