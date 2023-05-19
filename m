Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DC5709FB1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 21:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjESTJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 15:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjESTJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 15:09:42 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8C0A2
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 12:09:17 -0700 (PDT)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JHWEkj024725;
        Fri, 19 May 2023 19:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=MwEcF3wqivG6f5Xew+DgcPMveJbhktL16VB8vHcGDMQ=;
 b=SpfKiC1cVwZ7FqOeQASbyLJTv8IK/NkUN82JUHpbhkO7QmBYukFZ8Ph47MqPtPupo/Qv
 atiX2cfTF16BVThyYeWODh/z/lV3fU5roHA0mnoKPxnfWdytxehaiqWrINa7dm+X0FBy
 JPT/ID+7vygXMXoKc5bicOx0SbK2Fb4vhmLXH8yeXgY8pTAxYxTOyICo4NYMAe5chOVp
 cYPGq2b58VCtlj5lAZJ15XP37KTSCWk/umS05h/W6u8I+eFcFYgE2c9rnHfh79G1kes2
 uCzPrNThrtlhF4pbZl/Dgxp/M34SXbJ7fg79pe0HiJ9Fq9egCrbQZh5OpwFneBlF9wWz GQ== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3qp3xs5yaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 19:07:56 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id CC3D7804DCC;
        Fri, 19 May 2023 19:07:55 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id E68B7809A8E;
        Fri, 19 May 2023 19:07:54 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id 595723031304D; Fri, 19 May 2023 14:07:52 -0500 (CDT)
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v5 8/8] x86/platform/uv: Update UV[23] platform code for SNC
Date:   Fri, 19 May 2023 14:07:52 -0500
Message-Id: <20230519190752.3297140-9-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230519190752.3297140-1-steve.wahl@hpe.com>
References: <20230519190752.3297140-1-steve.wahl@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _yNh-yBQDraidRg8Sid9hKNWD6yveEvP
X-Proofpoint-GUID: _yNh-yBQDraidRg8Sid9hKNWD6yveEvP
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_14,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 spamscore=0
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305190164
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previous Sub-NUMA Clustering changes need not just a count of blades
present, but a count that includes any missing ids for blades not
present; in other words, the range from lowest to highest blade id.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 42 +++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 1836330ff7b3..d9384d5b4b8e 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -1462,11 +1462,37 @@ static int __init decode_uv_systab(void)
 	return 0;
 }
 
+/*
+ * Given a bitmask 'bits' representing presnt blades, numbered
+ * starting at 'base', masking off unused high bits of blade number
+ * with 'mask', update the minimum and maximum blade numbers that we
+ * have found.  (Masking with 'mask' necessary because of BIOS
+ * treatment of system partitioning when creating this table we are
+ * interpreting.)
+ */
+static inline void blade_update_min_max(unsigned long bits, int base, int mask, int *min, int *max)
+{
+	int first, last;
+
+	if (!bits)
+		return;
+	first = (base + __ffs(bits)) & mask;
+	last =  (base + __fls(bits)) & mask;
+
+	if (*min > first)
+		*min = first;
+	if (*max < last)
+		*max = last;
+}
+
 /* Set up physical blade translations from UVH_NODE_PRESENT_TABLE */
 static __init void boot_init_possible_blades(struct uv_hub_info_s *hub_info)
 {
 	unsigned long np;
 	int i, uv_pb = 0;
+	int sock_min = INT_MAX, sock_max = -1, s_mask;
+
+	s_mask = (1 << uv_cpuid.n_skt) - 1;
 
 	if (UVH_NODE_PRESENT_TABLE) {
 		pr_info("UV: NODE_PRESENT_DEPTH = %d\n",
@@ -1474,23 +1500,31 @@ static __init void boot_init_possible_blades(struct uv_hub_info_s *hub_info)
 		for (i = 0; i < UVH_NODE_PRESENT_TABLE_DEPTH; i++) {
 			np = uv_read_local_mmr(UVH_NODE_PRESENT_TABLE + i * 8);
 			pr_info("UV: NODE_PRESENT(%d) = 0x%016lx\n", i, np);
-			uv_pb += hweight64(np);
+			blade_update_min_max(np, i * 64, s_mask, &sock_min, &sock_max);
 		}
 	}
 	if (UVH_NODE_PRESENT_0) {
 		np = uv_read_local_mmr(UVH_NODE_PRESENT_0);
 		pr_info("UV: NODE_PRESENT_0 = 0x%016lx\n", np);
-		uv_pb += hweight64(np);
+		blade_update_min_max(np, 0, s_mask, &sock_min, &sock_max);
 	}
 	if (UVH_NODE_PRESENT_1) {
 		np = uv_read_local_mmr(UVH_NODE_PRESENT_1);
 		pr_info("UV: NODE_PRESENT_1 = 0x%016lx\n", np);
-		uv_pb += hweight64(np);
+		blade_update_min_max(np, 64, s_mask, &sock_min, &sock_max);
+	}
+
+	/* Only update if we actually found some bits indicating blades present */
+	if (sock_max >= sock_min) {
+		_min_socket = sock_min;
+		_max_socket = sock_max;
+		uv_pb = sock_max - sock_min + 1;
 	}
 	if (uv_possible_blades != uv_pb)
 		uv_possible_blades = uv_pb;
 
-	pr_info("UV: number nodes/possible blades %d\n", uv_pb);
+	pr_info("UV: number nodes/possible blades %d (%d - %d)\n",
+		uv_pb, sock_min, sock_max);
 }
 
 static int __init alloc_conv_table(int num_elem, unsigned short **table)
-- 
2.26.2

