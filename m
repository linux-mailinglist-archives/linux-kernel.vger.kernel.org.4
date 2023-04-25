Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDDB6EDFCE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 11:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbjDYJ5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 05:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbjDYJ5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 05:57:36 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECF7C158
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 02:57:35 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33P515tr026691;
        Tue, 25 Apr 2023 09:57:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=PQ1NG+EmbpIr7UvjvbEBagbyzxtD/7ejbD7HOQd/vys=;
 b=hyURHrd8PocigB3BuOEWMwwewrYji/TVd9Q0JURUgxPmMegXbpiVZ/M9Uf1gwJZCCsqe
 gpw8/F8pnYZGJy3bxsSeXTfnJqazfoik7t8S4GpQI8koV7X6oXd8zegAQiLPh0V0EQvL
 ZUu2rivh0mCYri5nrti38ytYYFGFwQufVjHIkiKlg6S2cinLB2zxvGN5h6FfzER/zcOH
 5q+2t77GS2AFb0AmrMyl7IS1zVV2wZUFpTK31eT8OCgIahrE2DK1TjfkB1PdQwsSAoD5
 jQ9IyGNfT79oONmHw41DZSWpNtOIsv9HFbdUnfSG/3LHv/xrubjBbbOb17wZHbaeoQDF tw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q5uwj27q8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 09:57:16 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33P9vFHg005337
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 09:57:16 GMT
Received: from localhost (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 25 Apr
 2023 02:57:14 -0700
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
To:     <catalin.marinas@arm.com>, <ardb@kernel.org>,
        <mark.rutland@arm.com>, <kristina.martsenko@arm.com>,
        <maz@kernel.org>, <broonie@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>
Subject: [PATCH] arm64: Fix label placement in record_mmu_state()
Date:   Tue, 25 Apr 2023 15:27:00 +0530
Message-ID: <20230425095700.22005-1-quic_neeraju@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8vbUDGArZSiLX3vhjyEyjVoxDSEOcoBT
X-Proofpoint-GUID: 8vbUDGArZSiLX3vhjyEyjVoxDSEOcoBT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_03,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 clxscore=1011 malwarescore=0 spamscore=0
 mlxlogscore=806 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250088
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix label so that pre_disable_mmu_workaround() is called
before clearing sctlr_el1.M.

Fixes: 2ced0f30a426 ("arm64: head: Switch endianness before populating the ID map")
Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
---
 arch/arm64/kernel/head.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index b98970907226..e92caebff46a 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -150,8 +150,8 @@ CPU_BE( tbz	x19, #SCTLR_ELx_EE_SHIFT, 1f	)
 	pre_disable_mmu_workaround
 	msr	sctlr_el2, x19
 	b	3f
-	pre_disable_mmu_workaround
-2:	msr	sctlr_el1, x19
+2:	pre_disable_mmu_workaround
+	msr	sctlr_el1, x19
 3:	isb
 	mov	x19, xzr
 	ret
-- 
2.17.1

