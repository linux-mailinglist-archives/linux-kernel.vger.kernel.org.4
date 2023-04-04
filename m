Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A34B6D6EB6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 23:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236378AbjDDVPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 17:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbjDDVPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 17:15:09 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E63A49ED
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 14:15:04 -0700 (PDT)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334KJl2R025055;
        Tue, 4 Apr 2023 21:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=MwEcF3wqivG6f5Xew+DgcPMveJbhktL16VB8vHcGDMQ=;
 b=FXEArhMVODkgd3qO+LLTFYHEmQaX0W/HcsQ8rYXG7X+edKi9mcv2D/GEvwMGEWvDwpQG
 2VpRFnP1cB3wZoW8Ir9G78GDkDurS3Qb0e15drbSthX5OrZPCDVmUb+9F8AHy3f23SYk
 tverVrb+v+drQV1PuuMZxgrYu64ditTMSLcm6Knih69YJzsDRzpuGgp7wCIEomd/Aab+
 tJD6ST4fDH7mGr2ggPMcTW+irTKKHwDGLWEwSC8qmlzoVq2PVngj/6D3zXkObCz9pWZV
 4aX7Ojqe12N7BeLJFlIiVu30NthC64HDYatO9uMW1NCwXuT7VlsAO7Ur/DxZaZcxNu/M Ag== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3prtu18byt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 21:14:35 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id C017113053;
        Tue,  4 Apr 2023 21:14:34 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 9CE7A8161B6;
        Tue,  4 Apr 2023 21:14:34 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id 0F8D93031304D; Tue,  4 Apr 2023 16:14:32 -0500 (CDT)
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 8/8] x86/platform/uv: Update UV[23] platform code for SNC
Date:   Tue,  4 Apr 2023 16:14:31 -0500
Message-Id: <20230404211431.776248-9-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230404211431.776248-1-steve.wahl@hpe.com>
References: <20230404211431.776248-1-steve.wahl@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: tXiyCVJTYwUL4DMoZd9buqY6T9OB1TOh
X-Proofpoint-ORIG-GUID: tXiyCVJTYwUL4DMoZd9buqY6T9OB1TOh
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_12,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304040193
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

