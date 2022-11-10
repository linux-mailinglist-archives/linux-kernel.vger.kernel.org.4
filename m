Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A55362490A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiKJSGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiKJSGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:06:38 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6480B63B3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 10:06:37 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AAHqOLw028088;
        Thu, 10 Nov 2022 18:06:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=6yrW636fqCp62zNO6e7icAOgbXhM+JFZKFb7pIKsSuo=;
 b=iT30AsLoEJb7+YFbxBU1jonNUwkumazsHkC1Li4N2nCSUkRMECQgUflyCCYvQYgR2jDG
 p3HGAizlCzoh2NAWv3VKTNJwHs1Ol04lWH1AMnpCSnSx/Des1BAW1E/2f3ytaJ6p+ZlU
 +EauujAZPyi54j9c0+/rSvvumiLzVJZ0rZE1zfXPV5X3xIiFNm0FMUTo+GZlJe1/r+Tz
 3i2c/YMTC1EI1e/CSlgIFj1o82LzYkzouMAihtg3YnkVawjgJkSikGTF4apbSYnKraFz
 qd93p+xPS7O77twRhcvlaYC7OOBU8ifJ2xMNJlGQuFHA7jeVWte/U/hpRHYMO/Ge31th 8Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ks635ren4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 18:06:26 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AAHr131029255;
        Thu, 10 Nov 2022 18:06:26 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ks635rem4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 18:06:26 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AAHoYZN015561;
        Thu, 10 Nov 2022 18:06:24 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 3kngmqnhdh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 18:06:24 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AAI6MDH57672058
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 18:06:22 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50A2CAE051;
        Thu, 10 Nov 2022 18:06:22 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F19F4AE045;
        Thu, 10 Nov 2022 18:06:21 +0000 (GMT)
Received: from pomme.tlslab.ibm.com (unknown [9.101.4.33])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 10 Nov 2022 18:06:21 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] powerpc: Take in account addition CPU node when building kexec FDT
Date:   Thu, 10 Nov 2022 19:06:19 +0100
Message-Id: <20221110180619.15796-3-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221110180619.15796-1-ldufour@linux.ibm.com>
References: <20221110180619.15796-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sw4pmto-tG0SojxlH4a3ZrKvAo6-WjVf
X-Proofpoint-ORIG-GUID: crMpBqeFaocd5gAKAcUPc_NX1uDxQ3Gt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_12,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0
 clxscore=1015 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211100126
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a system with a large number of CPUs, the creation of the FDT for a
kexec kernel may fail because the allocated FDT is not large enough.

When this happens, such a message is displayed on the console:

Unable to add ibm,processor-vadd-size property: FDT_ERR_NOSPACE

The property's name may change depending when the buffer overwrite is
detected.

Obviously the created FDT is missing information, and it is expected that
system dump or kexec kernel failed to run properly.

When the FDT is allocated, the size of the FDT the kernel received at boot
time is used and an extra size can be applied. Currently, only memory added
after boot time is taken in account, not the CPU nodes.

The extra size should take in account these additional CPU nodes and
compute the required extra space. To achieve that, the size of a CPU node,
including its subnode is computed once and multiplied by the number of
additional CPU nodes.

The assumption is that the size of the CPU node is _same_ for all the node,
the only variable part should be the name "PowerPC,POWERxx@##" where "##"
may vary a bit.

Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
---
 arch/powerpc/kexec/file_load_64.c | 60 ++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index 349a781cea0b..6865cd7dc3ca 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -26,6 +26,7 @@
 #include <asm/firmware.h>
 #include <asm/kexec_ranges.h>
 #include <asm/crashdump-ppc64.h>
+#include <asm/prom.h>
 
 struct umem_info {
 	u64 *buf;		/* data buffer for usable-memory property */
@@ -928,6 +929,46 @@ int setup_purgatory_ppc64(struct kimage *image, const void *slave_code,
 	return ret;
 }
 
+/**
+ * get_cpu_node_size - Compute the size of a CPU node in the FDT.
+ *                     This should be done only once and the value is stored in
+ *                     a static variable.
+ * Returns the max size of a CPU node in the FDT.
+ */
+static unsigned int cpu_node_size(void)
+{
+	static unsigned int cpu_node_size;
+	struct device_node *dn;
+	struct property *pp;
+
+	/*
+	 * Don't compute it twice, we are assuming that the per CPU node size
+	 * doesn't change during the system's life.
+	 */
+	if (cpu_node_size)
+		return cpu_node_size;
+
+	dn = of_find_node_by_type(NULL, "cpu");
+	if (!dn) {
+		/* Unlikely to happen */
+		WARN_ON_ONCE(1);
+		return 0;
+	}
+
+	/*
+	 * We compute the sub node size for a CPU node, assuming it
+	 * will be the same for all.
+	 */
+	cpu_node_size += strlen(dn->name) + 5;
+	for_each_property_of_node(dn, pp) {
+		cpu_node_size += strlen(pp->name);
+		cpu_node_size += pp->length;
+	}
+
+	of_node_put(dn);
+	return cpu_node_size;
+}
+
 /**
  * kexec_extra_fdt_size_ppc64 - Return the estimated additional size needed to
  *                              setup FDT for kexec/kdump kernel.
@@ -937,7 +978,10 @@ int setup_purgatory_ppc64(struct kimage *image, const void *slave_code,
  */
 unsigned int kexec_extra_fdt_size_ppc64(struct kimage *image)
 {
+	struct device_node *dn;
 	u64 usm_entries;
+	unsigned int cpu_nodes = 0;
+	unsigned int extra_size;
 
 	if (image->type != KEXEC_TYPE_CRASH)
 		return 0;
@@ -949,7 +993,21 @@ unsigned int kexec_extra_fdt_size_ppc64(struct kimage *image)
 	 */
 	usm_entries = ((memblock_end_of_DRAM() / drmem_lmb_size()) +
 		       (2 * (resource_size(&crashk_res) / drmem_lmb_size())));
-	return (unsigned int)(usm_entries * sizeof(u64));
+
+	extra_size = (unsigned int)(usm_entries * sizeof(u64));
+
+	/*
+	 * Get the number of CPU nodes in the current DT. This allows to
+	 * reserve places for CPU nodes added since the boot time.
+	 */
+	for_each_node_by_type(dn, "cpu") {
+		cpu_nodes++;
+	}
+
+	if (cpu_nodes > boot_cpu_node_count)
+		extra_size += (cpu_nodes - boot_cpu_node_count) * cpu_node_size();
+
+	return extra_size;
 }
 
 /**
-- 
2.38.1

