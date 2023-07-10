Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC3274CC8B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 08:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjGJGA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 02:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjGJGAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 02:00:55 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05008FD;
        Sun,  9 Jul 2023 23:00:53 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36A4LYnW008582;
        Mon, 10 Jul 2023 06:00:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=nMMlfpVJ+UOeVGD2dtc8/N7imAyEaUSCV1mdaihTP0w=;
 b=kuf+EpJI3guDerzZxYiBLNtWJ6EV1r7ARyQK4hUBX/J4h+kuLcYVBXG/Cw0dUS/+MAX9
 ERZFxgaLjKM7Cp8DpmPjfPP2VWa3FICeYbgC9mQZN6BSTiTy3wljZzms3toxyTfF2o+n
 p6ERbqrivHOMlz19JxfrtdAZRuOdyiQLTxLtt6o53BMVx1lDf9IPQBSVKGZPJb2bV4BB
 HvH9CVtcbiQreA+EaG0EiicU3znGLXtpn6c6xixulhK93w+v65mrmwxDs2X9XnIHdjYy
 vx1Ws2SjjIIB0xOLwyBXkZlKwatX4i78OSvvh55OQiz/4OP0ufL/JoOxcMQkMAoVO+p/ fw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rq06d2k7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 06:00:23 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36A60M2D027122
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 06:00:22 GMT
Received: from aiquny2-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sun, 9 Jul 2023 23:00:19 -0700
From:   Maria Yu <quic_aiquny@quicinc.com>
To:     <will@kernel.org>, <corbet@lwn.net>, <catalin.marinas@arm.com>
CC:     <maz@kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_kaushalk@quicinc.com>, <quic_satyap@quicinc.com>,
        <quic_shashim@quicinc.com>, <quic_songxue@quicinc.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Maria Yu <quic_aiquny@quicinc.com>
Subject: [PATCH] arm64: Add the arm64.nolse_atomics command line option
Date:   Mon, 10 Jul 2023 13:59:55 +0800
Message-ID: <20230710055955.36551-1-quic_aiquny@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: m3sXGeh0TbaOb70k3S1OMxS1nxYXB0t8
X-Proofpoint-GUID: m3sXGeh0TbaOb70k3S1OMxS1nxYXB0t8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_04,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=911 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307100054
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to be able to disable lse_atomic even if cpu
support it, most likely because of memory controller
cannot deal with the lse atomic instructions, use a
new idreg override to deal with it.

Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  2 ++
 arch/arm64/include/asm/cpufeature.h             |  1 +
 arch/arm64/kernel/cpufeature.c                  |  4 +++-
 arch/arm64/kernel/idreg-override.c              | 11 +++++++++++
 4 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 85fb0fa5d091..6ad754549f1d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -433,6 +433,8 @@
 	arm64.nomops	[ARM64] Unconditionally disable Memory Copy and Memory
 			Set instructions support
 
+	arm64.nolse_atomic [ARM64] Unconditionally disable LSE Atomic support
+
 	ataflop=	[HW,M68k]
 
 	atarimouse=	[HW,MOUSE] Atari Mouse
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 96e50227f940..9d56dea1fe62 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -916,6 +916,7 @@ extern struct arm64_ftr_override id_aa64pfr0_override;
 extern struct arm64_ftr_override id_aa64pfr1_override;
 extern struct arm64_ftr_override id_aa64zfr0_override;
 extern struct arm64_ftr_override id_aa64smfr0_override;
+extern struct arm64_ftr_override id_aa64isar0_override;
 extern struct arm64_ftr_override id_aa64isar1_override;
 extern struct arm64_ftr_override id_aa64isar2_override;
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index f9d456fe132d..9bd766880807 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -669,6 +669,7 @@ struct arm64_ftr_override __ro_after_init id_aa64pfr0_override;
 struct arm64_ftr_override __ro_after_init id_aa64pfr1_override;
 struct arm64_ftr_override __ro_after_init id_aa64zfr0_override;
 struct arm64_ftr_override __ro_after_init id_aa64smfr0_override;
+struct arm64_ftr_override __ro_after_init id_aa64isar0_override;
 struct arm64_ftr_override __ro_after_init id_aa64isar1_override;
 struct arm64_ftr_override __ro_after_init id_aa64isar2_override;
 
@@ -721,7 +722,8 @@ static const struct __ftr_reg_entry {
 	ARM64_FTR_REG(SYS_ID_AA64DFR1_EL1, ftr_raz),
 
 	/* Op1 = 0, CRn = 0, CRm = 6 */
-	ARM64_FTR_REG(SYS_ID_AA64ISAR0_EL1, ftr_id_aa64isar0),
+	ARM64_FTR_REG_OVERRIDE(SYS_ID_AA64ISAR0_EL1, ftr_id_aa64isar0,
+			       &id_aa64isar0_override),
 	ARM64_FTR_REG_OVERRIDE(SYS_ID_AA64ISAR1_EL1, ftr_id_aa64isar1,
 			       &id_aa64isar1_override),
 	ARM64_FTR_REG_OVERRIDE(SYS_ID_AA64ISAR2_EL1, ftr_id_aa64isar2,
diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
index 2fe2491b692c..af41ab4f3d94 100644
--- a/arch/arm64/kernel/idreg-override.c
+++ b/arch/arm64/kernel/idreg-override.c
@@ -105,6 +105,15 @@ static const struct ftr_set_desc pfr1 __initconst = {
 	},
 };
 
+static const struct ftr_set_desc isar0 __initconst = {
+	.name		= "id_aa64isar0",
+	.override	= &id_aa64isar0_override,
+	.fields		= {
+	        FIELD("atomic", ID_AA64ISAR0_EL1_ATOMIC_SHIFT, NULL),
+		{}
+	},
+};
+
 static const struct ftr_set_desc isar1 __initconst = {
 	.name		= "id_aa64isar1",
 	.override	= &id_aa64isar1_override,
@@ -163,6 +172,7 @@ static const struct ftr_set_desc * const regs[] __initconst = {
 	&mmfr1,
 	&pfr0,
 	&pfr1,
+	&isar0,
 	&isar1,
 	&isar2,
 	&smfr0,
@@ -185,6 +195,7 @@ static const struct {
 	{ "arm64.nomops",		"id_aa64isar2.mops=0" },
 	{ "arm64.nomte",		"id_aa64pfr1.mte=0" },
 	{ "nokaslr",			"arm64_sw.nokaslr=1" },
+	{ "arm64.nolse_atomic",         "id_aa64isar0.atomic=0" },
 };
 
 static int __init parse_nokaslr(char *unused)
-- 
2.17.1

