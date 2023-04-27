Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395B86EFE42
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 02:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242810AbjD0AKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 20:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242710AbjD0AKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 20:10:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068A63AA4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 17:10:03 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QGxDTf025309;
        Thu, 27 Apr 2023 00:09:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=kCxexgjquhm43uIqnCzaCKme8/lW/JHqc5BFLC3zBqE=;
 b=vTo9B+vvAjWpZl5sA4oPL1lKBhlH5A1X8UCeXo14KQCHh4gDG9JGTe8jsA8SvhWEA6lX
 rCwXFo16cZYMNfr4aZeivRf7u3DFx56P7YgMJx3riVsOHDgVAViRH21ldwmNdxF2DBeb
 JqNRvOwjMdpuYY+yWWgDEzFFodnBKgAjYlQhjn5Sy84JLsimXJOqFOWvEWcUM7WH2Ae3
 yxJTV377SDejfMR/5XEMdNkOD2spr/zEOAXfZVFI3I7cKVkYN4JLeqnXL9DqpOG7fOVy
 E/grQ+ERNydeVl9TX0aKf+NA2mkgf95PlZu+WMDNVMhFHDqzhiq9/daDDPxs4kFFdds/ 8A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q46622ty0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 00:09:15 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33QMwjOd007159;
        Thu, 27 Apr 2023 00:09:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4618mpep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 00:09:15 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33R0938a013888;
        Thu, 27 Apr 2023 00:09:14 GMT
Received: from ca-qasparc-x86-2.us.oracle.com (ca-qasparc-x86-2.us.oracle.com [10.147.24.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3q4618mp42-8;
        Thu, 27 Apr 2023 00:09:14 +0000
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, rppt@kernel.org, akpm@linux-foundation.org,
        ebiederm@xmission.com, keescook@chromium.org, graf@amazon.com,
        jason.zeng@intel.com, lei.l.li@intel.com,
        steven.sistare@oracle.com, fam.zheng@bytedance.com,
        mgalaxy@akamai.com, kexec@lists.infradead.org
Subject: [RFC v3 07/21] mm: PKRAM: introduce super block
Date:   Wed, 26 Apr 2023 17:08:43 -0700
Message-Id: <1682554137-13938-8-git-send-email-anthony.yznaga@oracle.com>
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
X-Proofpoint-ORIG-GUID: JPUChGVr1Ox4-7b8jQIrZtvAKfFxOq23
X-Proofpoint-GUID: JPUChGVr1Ox4-7b8jQIrZtvAKfFxOq23
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PKRAM super block is the starting point for restoring preserved
memory. By providing the super block to the new kernel at boot time,
preserved memory can be reserved and made available to be restored.
To point the kernel to the location of the super block, one passes
its pfn via the 'pkram' boot param. For that purpose, the pkram super
block pfn is exported via /sys/kernel/pkram. If none is passed, any
preserved memory will not be kept, and a new super block will be
allocated.

Originally-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/pkram.c | 102 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 100 insertions(+), 2 deletions(-)

diff --git a/mm/pkram.c b/mm/pkram.c
index da166cb6afb7..c66b2ae4d520 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -5,15 +5,18 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/list.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/notifier.h>
+#include <linux/pfn.h>
 #include <linux/pkram.h>
 #include <linux/reboot.h>
 #include <linux/sched.h>
 #include <linux/string.h>
+#include <linux/sysfs.h>
 #include <linux/types.h>
 
 #include "internal.h"
@@ -82,12 +85,38 @@ struct pkram_node {
 #define PKRAM_ACCMODE_MASK	3
 
 /*
+ * The PKRAM super block contains data needed to restore the preserved memory
+ * structure on boot. The pointer to it (pfn) should be passed via the 'pkram'
+ * boot param if one wants to restore preserved data saved by the previously
+ * executing kernel. For that purpose the kernel exports the pfn via
+ * /sys/kernel/pkram. If none is passed, preserved memory if any will not be
+ * preserved and a new clean page will be allocated for the super block.
+ *
+ * The structure occupies a memory page.
+ */
+struct pkram_super_block {
+	__u64	node_pfn;		/* first element of the node list */
+};
+
+static unsigned long pkram_sb_pfn __initdata;
+static struct pkram_super_block *pkram_sb;
+
+/*
  * For convenience sake PKRAM nodes are kept in an auxiliary doubly-linked list
  * connected through the lru field of the page struct.
  */
 static LIST_HEAD(pkram_nodes);			/* linked through page::lru */
 static DEFINE_MUTEX(pkram_mutex);		/* serializes open/close */
 
+/*
+ * The PKRAM super block pfn, see above.
+ */
+static int __init parse_pkram_sb_pfn(char *arg)
+{
+	return kstrtoul(arg, 16, &pkram_sb_pfn);
+}
+early_param("pkram", parse_pkram_sb_pfn);
+
 static inline struct page *pkram_alloc_page(gfp_t gfp_mask)
 {
 	return alloc_page(gfp_mask);
@@ -270,6 +299,7 @@ static void pkram_stream_init(struct pkram_stream *ps,
  * @gfp_mask specifies the memory allocation mask to be used when saving data.
  *
  * Error values:
+ *	%ENODEV: PKRAM not available
  *	%ENAMETOOLONG: name len >= PKRAM_NAME_MAX
  *	%ENOMEM: insufficient memory available
  *	%EEXIST: node with specified name already exists
@@ -285,6 +315,9 @@ int pkram_prepare_save(struct pkram_stream *ps, const char *name, gfp_t gfp_mask
 	struct pkram_node *node;
 	int err = 0;
 
+	if (!pkram_sb)
+		return -ENODEV;
+
 	if (strlen(name) >= PKRAM_NAME_MAX)
 		return -ENAMETOOLONG;
 
@@ -404,6 +437,7 @@ void pkram_discard_save(struct pkram_stream *ps)
  * Returns 0 on success, -errno on failure.
  *
  * Error values:
+ *	%ENODEV: PKRAM not available
  *	%ENOENT: node with specified name does not exist
  *	%EBUSY: save to required node has not finished yet
  *
@@ -414,6 +448,9 @@ int pkram_prepare_load(struct pkram_stream *ps, const char *name)
 	struct pkram_node *node;
 	int err = 0;
 
+	if (!pkram_sb)
+		return -ENODEV;
+
 	mutex_lock(&pkram_mutex);
 	node = pkram_find_node(name);
 	if (!node) {
@@ -825,6 +862,13 @@ static void __pkram_reboot(void)
 		node->node_pfn = node_pfn;
 		node_pfn = page_to_pfn(page);
 	}
+
+	/*
+	 * Zero out pkram_sb completely since it may have been passed from
+	 * the previous boot.
+	 */
+	memset(pkram_sb, 0, PAGE_SIZE);
+	pkram_sb->node_pfn = node_pfn;
 }
 
 static int pkram_reboot(struct notifier_block *notifier,
@@ -832,7 +876,8 @@ static int pkram_reboot(struct notifier_block *notifier,
 {
 	if (val != SYS_RESTART)
 		return NOTIFY_DONE;
-	__pkram_reboot();
+	if (pkram_sb)
+		__pkram_reboot();
 	return NOTIFY_OK;
 }
 
@@ -840,9 +885,62 @@ static int pkram_reboot(struct notifier_block *notifier,
 	.notifier_call = pkram_reboot,
 };
 
+static ssize_t show_pkram_sb_pfn(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	unsigned long pfn = pkram_sb ? PFN_DOWN(__pa(pkram_sb)) : 0;
+
+	return sprintf(buf, "%lx\n", pfn);
+}
+
+static struct kobj_attribute pkram_sb_pfn_attr =
+	__ATTR(pkram, 0444, show_pkram_sb_pfn, NULL);
+
+static struct attribute *pkram_attrs[] = {
+	&pkram_sb_pfn_attr.attr,
+	NULL,
+};
+
+static struct attribute_group pkram_attr_group = {
+	.attrs = pkram_attrs,
+};
+
+/* returns non-zero on success */
+static int __init pkram_init_sb(void)
+{
+	unsigned long pfn;
+	struct pkram_node *node;
+
+	if (!pkram_sb) {
+		struct page *page;
+
+		page = pkram_alloc_page(GFP_KERNEL | __GFP_ZERO);
+		if (!page) {
+			pr_err("PKRAM: Failed to allocate super block\n");
+			return 0;
+		}
+		pkram_sb = page_address(page);
+	}
+
+	/*
+	 * Build auxiliary doubly-linked list of nodes connected through
+	 * page::lru for convenience sake.
+	 */
+	pfn = pkram_sb->node_pfn;
+	while (pfn) {
+		node = pfn_to_kaddr(pfn);
+		pkram_insert_node(node);
+		pfn = node->node_pfn;
+	}
+	return 1;
+}
+
 static int __init pkram_init(void)
 {
-	register_reboot_notifier(&pkram_reboot_notifier);
+	if (pkram_init_sb()) {
+		register_reboot_notifier(&pkram_reboot_notifier);
+		sysfs_update_group(kernel_kobj, &pkram_attr_group);
+	}
 	return 0;
 }
 module_init(pkram_init);
-- 
1.9.4

