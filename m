Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C325B3B00
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbiIIOqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbiIIOqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:46:20 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524B26F555
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 07:46:18 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 289Ei4ZX002803;
        Fri, 9 Sep 2022 14:46:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=pNr4hQb+JRu+4w1VuR78KoAZItBcUt49PAzbKmqpMcc=;
 b=UpQA3U6wvdCiZWKR8Pqx+yjBTZ+d5EnNSC0V4/+QeMiGo2Qoq2Pft10ZMUOxmaYfGi4o
 F7LcskMavkKZTruRyqj4cORfTmQKdXQtB72x0Dq421ocox2qh4CbJaM8/lBUbxOxqPWS
 jxzPjZo049A0G8AuclGs8oINMSuV8ES+/YWROyr6+9GN7v+xuOYwbGaSrvOi+EX3os4D
 ni+ADLt275encxtWTbaYESoR9EIefYgqfCsONqslkJ8HHJVdHon0uSgd7GZ4SOB43Udn
 2Wfuwkb5s+sqrcBcLo2VndTzxYa7rm1LOr/FZH9PN9iQUGju1cTYi/giC+upfgco75+U jQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jg5uq09ju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 14:46:02 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 289Ek1go006489
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Sep 2022 14:46:01 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 9 Sep 2022 07:46:01 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        "Alexandru Elisei" <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>
Subject: [PATCH v2] KVM: arm64: Only set KVM_MODE_PROTECTED if is_hyp_mode_available()
Date:   Fri, 9 Sep 2022 07:45:52 -0700
Message-ID: <20220909144552.3000716-1-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tLwa4QKuo59sSsPVGKdBidMjGzXEWi6h
X-Proofpoint-ORIG-GUID: tLwa4QKuo59sSsPVGKdBidMjGzXEWi6h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_08,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxlogscore=635 impostorscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209090051
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not switch kvm_mode to KVM_MODE_PROTECTED if hypervisor mode is not
available. This prevents "Protected KVM" cpu capability being reported
when Linux is booting in EL1 and would not have KVM enabled.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 arch/arm64/kvm/arm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 8fe73ee5fa84..861f4b388879 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -2272,7 +2272,9 @@ static int __init early_kvm_mode_cfg(char *arg)
 		return -EINVAL;
 
 	if (strcmp(arg, "protected") == 0) {
-		if (!is_kernel_in_hyp_mode())
+		if (!is_hyp_mode_available())
+			kvm_mode = KVM_MODE_DEFAULT;
+		else if (!is_kernel_in_hyp_mode())
 			kvm_mode = KVM_MODE_PROTECTED;
 		else
 			pr_warn_once("Protected KVM not available with VHE\n");

base-commit: 0982c8d859f8f7022b9fd44d421c7ec721bb41f9
-- 
2.25.1

