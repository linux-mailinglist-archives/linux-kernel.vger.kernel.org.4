Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CD7611710
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiJ1QIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiJ1QGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:06:49 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C09C14
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:06:00 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SFi76Q037322;
        Fri, 28 Oct 2022 16:05:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Ag61Q8Xg55sUv7jlbJD5dxol/V7IGyeMOcpLHVlRgKg=;
 b=ZXCtEZNoaDkxNsFS8wPL7gpTXbQ6DM9x+hpzZAMVQaSB62KgKQkhciwtTJrQf5d+hTQX
 7GIT2rZMaAtQ+HN360Vzeb+bmIidbeBO4BpYekBWw9uL3rtfLhLUiLYwSEMMB6Y0dgTS
 VIiKhUciRl0t0hR/q1DbYZwKhLapqIADnasUdQjnv03E9wSaU77LEjEnfR+5MdpoXzmV
 bq921REj5QBQxlXPBfiB/m4CypAGC1lYgkbyOZONcFxXXqNErlaXrvcbyvvz+ERtlDBX
 kAcJqixo/j8UgofGqbG5ym62LdFxr4mooOJNfyy2h0rm6MtkkY4aZrUv6YEw+gRzsUy3 8Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kghyw8q6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 16:05:49 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29SFlXf5010291;
        Fri, 28 Oct 2022 16:05:49 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kghyw8q59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 16:05:49 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29SFppHt004243;
        Fri, 28 Oct 2022 16:00:38 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 3kfbg2ar0x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 16:00:38 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29SG1BhP29295030
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 16:01:11 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8614711C04A;
        Fri, 28 Oct 2022 16:00:36 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D25511C04C;
        Fri, 28 Oct 2022 16:00:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.94.157])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 28 Oct 2022 16:00:36 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] powerpc: Take in account addition CPU node when building kexec FDT
Date:   Fri, 28 Oct 2022 18:00:34 +0200
Message-Id: <20221028160034.44400-3-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221028160034.44400-1-ldufour@linux.ibm.com>
References: <20221028160034.44400-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JPYw-6l1ZhIYxfCFG3f87yUQjTYgtouA
X-Proofpoint-ORIG-GUID: XDD6smsMZ-tfigq6HbcTJXcfw1qNR-gN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280100
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
 arch/powerpc/kexec/file_load_64.c | 59 ++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index 349a781cea0b..1476922cd7c5 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -928,6 +928,46 @@ int setup_purgatory_ppc64(struct kimage *image, const void *slave_code,
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
@@ -937,7 +977,10 @@ int setup_purgatory_ppc64(struct kimage *image, const void *slave_code,
  */
 unsigned int kexec_extra_fdt_size_ppc64(struct kimage *image)
 {
+	struct device_node *dn;
 	u64 usm_entries;
+	unsigned int cpu_nodes = 0;
+	unsigned int extra_size;
 
 	if (image->type != KEXEC_TYPE_CRASH)
 		return 0;
@@ -949,7 +992,21 @@ unsigned int kexec_extra_fdt_size_ppc64(struct kimage *image)
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

