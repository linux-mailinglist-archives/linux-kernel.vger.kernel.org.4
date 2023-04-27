Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4D06EFE43
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 02:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242902AbjD0ALH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 20:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242736AbjD0AKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 20:10:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FD93C30
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 17:10:09 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QGx3sV004984;
        Thu, 27 Apr 2023 00:09:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=yIENXNNzi/QzzmshoP+q+Y+PreZ+zZ5LAbsbewQ0r6M=;
 b=D93iwhD4tLk5IUOUbCMp75EVVn8pz3JVlt8axqiDirtNgTH2ZnBgIb0wXe6ekEbLRo3e
 eEPG+sS5dvN3KroM8CtCay1vQzVY8aDzCvlx8qf7BrUi/uc6Ri73ggcjNDyyOTXKHrZb
 p7qvzaHBremK6EWvwWWGnKslZqz39B4flJiXKpv5Wk0duzRK9YcIjqc0pnue7uMjxDo5
 62ZZ4RO8P1pw10cOAOEE5i57vPlb6IBrJc3759GRFGLvTLDeHDdKMQi/RPcUVjlGAY+o
 u/wecOchLHcLvkKmIRLTn5Iepx8SHgbkzjsv0cZDb8NF5yb/8y2kp/+ObTQ4ssFP3mU6 6g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q46gbtsj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 00:09:34 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33QM3usC007418;
        Thu, 27 Apr 2023 00:09:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4618mpvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 00:09:34 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33R09392013888;
        Thu, 27 Apr 2023 00:09:33 GMT
Received: from ca-qasparc-x86-2.us.oracle.com (ca-qasparc-x86-2.us.oracle.com [10.147.24.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3q4618mp42-21;
        Thu, 27 Apr 2023 00:09:33 +0000
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, rppt@kernel.org, akpm@linux-foundation.org,
        ebiederm@xmission.com, keescook@chromium.org, graf@amazon.com,
        jason.zeng@intel.com, lei.l.li@intel.com,
        steven.sistare@oracle.com, fam.zheng@bytedance.com,
        mgalaxy@akamai.com, kexec@lists.infradead.org
Subject: [RFC v3 20/21] x86/KASLR: PKRAM: support physical kaslr
Date:   Wed, 26 Apr 2023 17:08:56 -0700
Message-Id: <1682554137-13938-21-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.9.4
In-Reply-To: <1682554137-13938-1-git-send-email-anthony.yznaga@oracle.com>
References: <1682554137-13938-1-git-send-email-anthony.yznaga@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_10,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304270000
X-Proofpoint-GUID: 1EnT7XCXpRCY0gBKXVSZzw8iuiNCBjPV
X-Proofpoint-ORIG-GUID: 1EnT7XCXpRCY0gBKXVSZzw8iuiNCBjPV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid regions of memory that contain preserved pages when computing
slots used to select where to put the decompressed kernel.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 arch/x86/boot/compressed/Makefile |   3 ++
 arch/x86/boot/compressed/kaslr.c  |  10 +++-
 arch/x86/boot/compressed/misc.h   |  10 ++++
 arch/x86/boot/compressed/pkram.c  | 110 ++++++++++++++++++++++++++++++++++++++
 mm/pkram.c                        |   2 +-
 5 files changed, 132 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/boot/compressed/pkram.c

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 6b6cfe607bdb..d9a5af94a797 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -103,6 +103,9 @@ ifdef CONFIG_X86_64
 	vmlinux-objs-$(CONFIG_AMD_MEM_ENCRYPT) += $(obj)/mem_encrypt.o
 	vmlinux-objs-y += $(obj)/pgtable_64.o
 	vmlinux-objs-$(CONFIG_AMD_MEM_ENCRYPT) += $(obj)/sev.o
+ifdef CONFIG_RANDOMIZE_BASE
+	vmlinux-objs-$(CONFIG_PKRAM) += $(obj)/pkram.o
+endif
 endif
 
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 454757fbdfe5..047b8b9a0799 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -436,6 +436,7 @@ static bool mem_avoid_overlap(struct mem_vector *img,
 	struct setup_data *ptr;
 	u64 earliest = img->start + img->size;
 	bool is_overlapping = false;
+	struct mem_vector avoid;
 
 	for (i = 0; i < MEM_AVOID_MAX; i++) {
 		if (mem_overlaps(img, &mem_avoid[i]) &&
@@ -449,8 +450,6 @@ static bool mem_avoid_overlap(struct mem_vector *img,
 	/* Avoid all entries in the setup_data linked list. */
 	ptr = (struct setup_data *)(unsigned long)boot_params->hdr.setup_data;
 	while (ptr) {
-		struct mem_vector avoid;
-
 		avoid.start = (unsigned long)ptr;
 		avoid.size = sizeof(*ptr) + ptr->len;
 
@@ -475,6 +474,12 @@ static bool mem_avoid_overlap(struct mem_vector *img,
 		ptr = (struct setup_data *)(unsigned long)ptr->next;
 	}
 
+	if (pkram_has_overlap(img, &avoid) && (avoid.start < earliest)) {
+		*overlap = avoid;
+		earliest = overlap->start;
+		is_overlapping = true;
+	}
+
 	return is_overlapping;
 }
 
@@ -836,6 +841,7 @@ void choose_random_location(unsigned long input,
 		return;
 	}
 
+	pkram_init();
 	boot_params->hdr.loadflags |= KASLR_FLAG;
 
 	if (IS_ENABLED(CONFIG_X86_32))
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 20118fb7c53b..01ff5e507064 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -124,6 +124,16 @@ static inline void console_init(void)
 { }
 #endif
 
+#ifdef CONFIG_PKRAM
+void pkram_init(void);
+int pkram_has_overlap(struct mem_vector *entry, struct mem_vector *overlap);
+#else
+static inline void pkram_init(void) { }
+static inline int pkram_has_overlap(struct mem_vector *entry,
+				    struct mem_vector *overlap)
+{ return 0; }
+#endif
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 void sev_enable(struct boot_params *bp);
 void snp_check_features(void);
diff --git a/arch/x86/boot/compressed/pkram.c b/arch/x86/boot/compressed/pkram.c
new file mode 100644
index 000000000000..19267ca2ce8e
--- /dev/null
+++ b/arch/x86/boot/compressed/pkram.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "misc.h"
+
+#define PKRAM_MAGIC		0x706B726D
+
+struct pkram_super_block {
+	__u32	magic;
+
+	__u64	node_pfn;
+	__u64	region_list_pfn;
+	__u64	nr_regions;
+};
+
+struct pkram_region {
+	phys_addr_t base;
+	phys_addr_t size;
+};
+
+struct pkram_region_list {
+	__u64	prev_pfn;
+	__u64	next_pfn;
+
+	struct pkram_region regions[0];
+};
+
+#define PKRAM_REGIONS_LIST_MAX \
+	((PAGE_SIZE-sizeof(struct pkram_region_list))/sizeof(struct pkram_region))
+
+static u64 pkram_sb_pfn;
+static struct pkram_super_block *pkram_sb;
+
+void pkram_init(void)
+{
+	struct pkram_super_block *sb;
+	char arg[32];
+
+	if (cmdline_find_option("pkram", arg, sizeof(arg)) > 0) {
+		if (kstrtoull(arg, 16, &pkram_sb_pfn) != 0)
+			return;
+	} else
+		return;
+
+	sb = (struct pkram_super_block *)(pkram_sb_pfn << PAGE_SHIFT);
+	if (sb->magic != PKRAM_MAGIC) {
+		debug_putstr("PKRAM: invalid super block\n");
+		return;
+	}
+
+	pkram_sb = sb;
+}
+
+static struct pkram_region *pkram_first_region(struct pkram_super_block *sb,
+					       struct pkram_region_list **rlp, int *idx)
+{
+	if (!sb || !sb->region_list_pfn)
+		return NULL;
+
+	*rlp = (struct pkram_region_list *)(sb->region_list_pfn << PAGE_SHIFT);
+	*idx = 0;
+
+	return &(*rlp)->regions[0];
+}
+
+static struct pkram_region *pkram_next_region(struct pkram_region_list **rlp, int *idx)
+{
+	struct pkram_region_list *rl = *rlp;
+	int i = *idx;
+
+	i++;
+	if (i >= PKRAM_REGIONS_LIST_MAX) {
+		if (!rl->next_pfn) {
+			debug_putstr("PKRAM: no more pkram_region_list pages\n");
+			return NULL;
+		}
+		rl = (struct pkram_region_list *)(rl->next_pfn << PAGE_SHIFT);
+		*rlp = rl;
+		i = 0;
+	}
+	*idx = i;
+
+	if (rl->regions[i].size == 0)
+		return NULL;
+
+	return &rl->regions[i];
+}
+
+int pkram_has_overlap(struct mem_vector *entry, struct mem_vector *overlap)
+{
+	struct pkram_region_list *rl;
+	struct pkram_region *r;
+	int idx;
+
+	r = pkram_first_region(pkram_sb, &rl, &idx);
+
+	while (r) {
+		if (r->base + r->size <= entry->start) {
+			r = pkram_next_region(&rl, &idx);
+			continue;
+		}
+		if (r->base >= entry->start + entry->size)
+			return 0;
+
+		overlap->start = r->base;
+		overlap->size = r->size;
+		return 1;
+	}
+
+	return 0;
+}
diff --git a/mm/pkram.c b/mm/pkram.c
index f38236e5d836..a3e045b8dfe4 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -96,7 +96,7 @@ struct pkram_region_list {
 	__u64	prev_pfn;
 	__u64	next_pfn;
 
-	struct pkram_region regions[0];
+	struct pkram_region regions[];
 };
 
 #define PKRAM_REGIONS_LIST_MAX \
-- 
1.9.4

