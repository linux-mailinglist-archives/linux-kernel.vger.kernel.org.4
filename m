Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E92F61170A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiJ1QIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiJ1QGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:06:47 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08BD1DC800
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:05:53 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SFnqZp031911;
        Fri, 28 Oct 2022 16:05:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=m5gmoe5nzt1dR38vy96xlF8K5GaVfd5hD1tpJKcT8y0=;
 b=fe9RPeqiZw6/Jm6jyYy58khmfLHhqhgbZu9vcgn7n3x0sTbqUlMwaeIq70xrW3CN24FJ
 SK7xBJTQGdqXuZYXcKltAM9iy4BfxZ30KxKYa8qcBNoGVsik8pyAN39x9JxZLI1nyKIP
 WcYKsv3kTiieCg+4pvKheBDJo8nGx4htY8y930w8Kbxl5XCwtDni8IfN/7JJHiJeyAbC
 3iCbXyR+sJpTCmw/F3CB4FSw54SIRw6Q94d7cdrJn1aFjgMoa9xudS4gcLZbI7GKpnSV
 vyFVcqecvrCSNBQD3vgJVWAxcacwab7v2s21szJnltz5UaLKaCqvkmuxVFYw6GiFZHEg Gg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kgj2n8he3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 16:05:44 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29SFnpYW031812;
        Fri, 28 Oct 2022 16:05:44 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kgj2n8hcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 16:05:44 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29SFp6YK023375;
        Fri, 28 Oct 2022 16:00:38 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 3kfahmjt7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 16:00:38 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29SG1BpG29295026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 16:01:11 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DC4111C04A;
        Fri, 28 Oct 2022 16:00:36 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9F1011C050;
        Fri, 28 Oct 2022 16:00:35 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.94.157])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 28 Oct 2022 16:00:35 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] powerpc: export the CPU node count
Date:   Fri, 28 Oct 2022 18:00:33 +0200
Message-Id: <20221028160034.44400-2-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221028160034.44400-1-ldufour@linux.ibm.com>
References: <20221028160034.44400-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ILStheXaMmokWjvPpmUjqmkfJvUUO0oR
X-Proofpoint-GUID: nRy3YEhyd_d89r4ajn7fB5olKmnQ_TwI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280100
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At boot time, the FDT is parsed to compute the number of CPUs.
In addition count the number of CPU nodes and export it.

This is useful when building the FDT for a kexeced kernel since we need to
take in account the CPU node added since the boot time during CPU hotplug
operations.

Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
---
 arch/powerpc/include/asm/kexec_ranges.h | 2 ++
 arch/powerpc/kernel/prom.c              | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/arch/powerpc/include/asm/kexec_ranges.h b/arch/powerpc/include/asm/kexec_ranges.h
index f83866a19e87..bf35d00ddd09 100644
--- a/arch/powerpc/include/asm/kexec_ranges.h
+++ b/arch/powerpc/include/asm/kexec_ranges.h
@@ -22,4 +22,6 @@ int add_rtas_mem_range(struct crash_mem **mem_ranges);
 int add_opal_mem_range(struct crash_mem **mem_ranges);
 int add_reserved_mem_ranges(struct crash_mem **mem_ranges);
 
+extern unsigned int boot_cpu_node_count;
+
 #endif /* _ASM_POWERPC_KEXEC_RANGES_H */
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 1eed87d954ba..d326148fd5a4 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -56,6 +56,7 @@
 #include <asm/drmem.h>
 #include <asm/ultravisor.h>
 #include <asm/prom.h>
+#include <asm/kexec_ranges.h>
 
 #include <mm/mmu_decl.h>
 
@@ -72,6 +73,7 @@ int __initdata iommu_is_off;
 int __initdata iommu_force_on;
 unsigned long tce_alloc_start, tce_alloc_end;
 u64 ppc64_rma_size;
+unsigned int boot_cpu_node_count __ro_after_init;
 #endif
 static phys_addr_t first_memblock_size;
 static int __initdata boot_cpu_count;
@@ -335,6 +337,8 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 	if (type == NULL || strcmp(type, "cpu") != 0)
 		return 0;
 
+	boot_cpu_node_count++;
+
 	/* Get physical cpuid */
 	intserv = of_get_flat_dt_prop(node, "ibm,ppc-interrupt-server#s", &len);
 	if (!intserv)
-- 
2.38.1

