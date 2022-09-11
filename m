Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A14B5B515A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 23:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiIKVln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 17:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIKVlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 17:41:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C003201A1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 14:41:40 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28BLfACZ012463;
        Sun, 11 Sep 2022 21:41:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=172gqBHdWTQsPiaT/19OqMVWgqe3jX8FYL5YY4LecWU=;
 b=iO7OZl1YeSX35Wr6OiLm5BQ6Msub0d37eTaouQSKMx2M96EWXBbR3kvuHmCf9evzR6+t
 kGWqKBv850ASNqix5c2qSieY08VeXI0kJGZBs18+SZ4x+0b0HwIgeEdojL2AggZcHEhS
 MzAtrC6ArV8hihSxSPpSr3NGLCJOqF9qWEwPNbw0m3jJEbLQZhqtB5DmFUm1DWEGaLsP
 U8fMXwbn4D0tmjVpAbtwPcSv0RR9iX/9aWyND/kL1dCIuu4gGChK7jibpXb3bciNglH9
 amYkzgZ8UuILaMBReIdg5P/TVJ00GhhyFVUuOwe20D1djOLRy7o6QGMa6PN4myJ4a9ME pA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jgk43jp9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 11 Sep 2022 21:41:10 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28BLf9DA028608
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 11 Sep 2022 21:41:09 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Sun, 11 Sep 2022 14:41:09 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        "Alexandru Elisei" <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>
Subject: [PATCH v3] KVM: arm64: Ignore kvm-arm.mode if !is_hyp_mode_available()
Date:   Sun, 11 Sep 2022 14:40:59 -0700
Message-ID: <20220911214059.2767620-1-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: O96vbLzBZ1LFAsrLFd_xeOhMc_hcdqfA
X-Proofpoint-ORIG-GUID: O96vbLzBZ1LFAsrLFd_xeOhMc_hcdqfA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-11_12,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=861 clxscore=1015
 mlxscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209110084
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ignore kvm-arm.mode if !is_hyp_mode_available(). Specifically, we want
to avoid switching kvm_mode to KVM_MODE_PROTECTED if hypervisor mode is
not available. This prevents "Protected KVM" cpu capability being
reported when Linux is booting in EL1 and would not have KVM enabled.
Reasonably though, we should warn if the command line is requesting a
KVM mode at all if KVM isn't actually available. Don't emit warning for
"kvm-arm.mode=none" since this would disable KVM anyway.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 arch/arm64/kvm/arm.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 8fe73ee5fa84..8e5d1c8502f5 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -2271,6 +2271,16 @@ static int __init early_kvm_mode_cfg(char *arg)
 	if (!arg)
 		return -EINVAL;
 
+	if (strcmp(arg, "none") == 0) {
+		kvm_mode = KVM_MODE_NONE;
+		return 0;
+	}
+
+	if (!is_hyp_mode_available()) {
+		pr_warn_once("KVM is not available. Ignoring kvm-arm.mode\n")
+		return 0;
+	}
+
 	if (strcmp(arg, "protected") == 0) {
 		if (!is_kernel_in_hyp_mode())
 			kvm_mode = KVM_MODE_PROTECTED;
@@ -2285,11 +2295,6 @@ static int __init early_kvm_mode_cfg(char *arg)
 		return 0;
 	}
 
-	if (strcmp(arg, "none") == 0) {
-		kvm_mode = KVM_MODE_NONE;
-		return 0;
-	}
-
 	return -EINVAL;
 }
 early_param("kvm-arm.mode", early_kvm_mode_cfg);

base-commit: 0982c8d859f8f7022b9fd44d421c7ec721bb41f9
-- 
2.25.1

