Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5877667E77
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbjALS4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 13:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234782AbjALS4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:56:23 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BF259FAB
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 10:26:17 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CHNj22017591;
        Thu, 12 Jan 2023 18:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=Z82I5GLP+uqyDlDgupDEX6N8IYIrwtQEqaS+xCBQSTc=;
 b=F8eFle9tulDMuE6eQ6+AYdAXsZ1ZBeOffkgJ4Le7S4BcyeZt1+CXyEp7kDorGJkHvc/8
 He7QSDnBDL1ZrYzgexmfKbs+/3qC8tBRJz9FOGye0/12sIaKGaXmt2Xwf5Fo1bwzUM7P
 lk9sDbMMWK8R9OX9HHbkMsBxhxfPwX3XPTZ8xr4nlAxuIK5vBWOSxIFuNAuc17t4fzk+
 b19YkkDjZL+uRYjyRj8JNAA/7GlSNby1Ua8JvJrPT07hEaYkBo7ONq6iFk7ZsL6VY+qO
 SaxN8ub5q4Ms8Y6yjqPDYP0XNPVKU/f+TtGnaR0do16r2WJlOSaFcEyWBo0erSakovz8 LA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n2edusby0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 18:26:02 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30CIQ1IG007043
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 18:26:01 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 12 Jan 2023 10:26:00 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: smccc: Include alternative-macros.h
Date:   Thu, 12 Jan 2023 10:25:47 -0800
Message-ID: <20230112182548.537295-1-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DuZHONfbr5Nfy4x5LQ36DjulHaQ2raj-
X-Proofpoint-ORIG-GUID: DuZHONfbr5Nfy4x5LQ36DjulHaQ2raj-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_10,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=634 mlxscore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120132
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build error when CONFIG_ARM64_SVE is selected and
asm/alternative-macros.h wasn't implicitly included by another header.

./include/linux/arm-smccc.h:387:25: error: expected string literal before `ALTERNATIVE'
  387 | #define SMCCC_SVE_CHECK ALTERNATIVE("nop \n",  "bl __arm_smccc_sve_check \n", \

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 include/linux/arm-smccc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index 220c8c60e021..6a627cdbbdec 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -383,6 +383,7 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
 
 /* nVHE hypervisor doesn't have a current thread so needs separate checks */
 #if defined(CONFIG_ARM64_SVE) && !defined(__KVM_NVHE_HYPERVISOR__)
+#include <asm/alternative-macros.h>
 
 #define SMCCC_SVE_CHECK ALTERNATIVE("nop \n",  "bl __arm_smccc_sve_check \n", \
 				    ARM64_SVE)

base-commit: 68a63a412d18bd2e2577c8928139f92541afa7a6
-- 
2.39.0

