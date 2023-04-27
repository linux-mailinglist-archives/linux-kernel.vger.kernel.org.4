Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9C56EFE33
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 02:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242729AbjD0AKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 20:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242697AbjD0AKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 20:10:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261FF3AB6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 17:10:01 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QGx2Ov004937;
        Thu, 27 Apr 2023 00:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=Ubk61ivo6vmHzGraxUFDO1r49XLMJqa4VVETk4Cbi0M=;
 b=FbqfouMwai47X2F7jNvsJULqyrfxpV15OToo/loakJHJQEPmxoEdpqyIHRa9xadym2iu
 Zfj3nxbIdNpCk2h9qaTsdZeZJOhA/A8QwbQ9vqot2Pmw4tcVa5qExJaA5QclNyOSEjxX
 Nw0W6/FfI79xQncISher39+JSNcaco3uaQ8BhrKSNNqcACD58W1dtnCPmxTEo2M7bsaB
 yklcT/WnUpoYfsWS9mEFJt9lu0jnwkwk/wMTDtBP/V5JOuMNzVKJVYsIpHKD8QXsqlgI
 2VLOSJBeOHOwEuIzNy8aRR5TyDsY/oq4xcl5TIXA81o+4TrlYj9fxI45DAynbDiVR2SL kg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q46gbtshn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 00:09:14 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33QNdMUZ007383;
        Thu, 27 Apr 2023 00:09:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4618mpdh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 00:09:13 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33R0938Y013888;
        Thu, 27 Apr 2023 00:09:13 GMT
Received: from ca-qasparc-x86-2.us.oracle.com (ca-qasparc-x86-2.us.oracle.com [10.147.24.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3q4618mp42-7;
        Thu, 27 Apr 2023 00:09:12 +0000
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, rppt@kernel.org, akpm@linux-foundation.org,
        ebiederm@xmission.com, keescook@chromium.org, graf@amazon.com,
        jason.zeng@intel.com, lei.l.li@intel.com,
        steven.sistare@oracle.com, fam.zheng@bytedance.com,
        mgalaxy@akamai.com, kexec@lists.infradead.org
Subject: [RFC v3 06/21] mm: PKRAM: link nodes by pfn before reboot
Date:   Wed, 26 Apr 2023 17:08:42 -0700
Message-Id: <1682554137-13938-7-git-send-email-anthony.yznaga@oracle.com>
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
X-Proofpoint-GUID: 4dfsl940M32SqdTr3kz-hSfm9AlSY8O0
X-Proofpoint-ORIG-GUID: 4dfsl940M32SqdTr3kz-hSfm9AlSY8O0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since page structs are used for linking PKRAM nodes and cleared
on boot, organize all PKRAM nodes into a list singly-linked by pfns
before reboot to facilitate restoring the node list in the new kernel.

Originally-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/pkram.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/mm/pkram.c b/mm/pkram.c
index eac8cf6b0cdf..da166cb6afb7 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -2,12 +2,16 @@
 #include <linux/err.h>
 #include <linux/gfp.h>
 #include <linux/highmem.h>
+#include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/mm.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/notifier.h>
 #include <linux/pkram.h>
+#include <linux/reboot.h>
 #include <linux/sched.h>
 #include <linux/string.h>
 #include <linux/types.h>
@@ -60,11 +64,15 @@ struct pkram_obj {
  * singly-linked list of PKRAM link structures (see above), the node has a
  * pointer to the head of.
  *
+ * To facilitate data restore in the new kernel, before reboot all PKRAM nodes
+ * are organized into a list singly-linked by pfn's (see pkram_reboot()).
+ *
  * The structure occupies a memory page.
  */
 struct pkram_node {
 	__u32	flags;
 	__u64	obj_pfn;	/* points to the first obj of the node */
+	__u64	node_pfn;	/* points to the next node in the node list */
 
 	__u8	name[PKRAM_NAME_MAX];
 };
@@ -73,6 +81,10 @@ struct pkram_node {
 #define PKRAM_LOAD		2
 #define PKRAM_ACCMODE_MASK	3
 
+/*
+ * For convenience sake PKRAM nodes are kept in an auxiliary doubly-linked list
+ * connected through the lru field of the page struct.
+ */
 static LIST_HEAD(pkram_nodes);			/* linked through page::lru */
 static DEFINE_MUTEX(pkram_mutex);		/* serializes open/close */
 
@@ -796,3 +808,41 @@ size_t pkram_read(struct pkram_access *pa, void *buf, size_t count)
 	}
 	return read_count;
 }
+
+/*
+ * Build the list of PKRAM nodes.
+ */
+static void __pkram_reboot(void)
+{
+	struct page *page;
+	struct pkram_node *node;
+	unsigned long node_pfn = 0;
+
+	list_for_each_entry_reverse(page, &pkram_nodes, lru) {
+		node = page_address(page);
+		if (WARN_ON(node->flags & PKRAM_ACCMODE_MASK))
+			continue;
+		node->node_pfn = node_pfn;
+		node_pfn = page_to_pfn(page);
+	}
+}
+
+static int pkram_reboot(struct notifier_block *notifier,
+		       unsigned long val, void *v)
+{
+	if (val != SYS_RESTART)
+		return NOTIFY_DONE;
+	__pkram_reboot();
+	return NOTIFY_OK;
+}
+
+static struct notifier_block pkram_reboot_notifier = {
+	.notifier_call = pkram_reboot,
+};
+
+static int __init pkram_init(void)
+{
+	register_reboot_notifier(&pkram_reboot_notifier);
+	return 0;
+}
+module_init(pkram_init);
-- 
1.9.4

