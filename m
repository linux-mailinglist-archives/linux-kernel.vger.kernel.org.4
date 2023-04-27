Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993246EFE40
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 02:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242804AbjD0AKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 20:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242703AbjD0AKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 20:10:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28283C01
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 17:10:01 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QGx6XV014746;
        Thu, 27 Apr 2023 00:09:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=V8bKMJcQa6Jv2T9adbwM8jWBRAWVIiOFCv4jdhXt4wk=;
 b=1O7OzEZ6q3Uaoe9tuHIc0BR7Q0Y5MQzRvRBF53JohJ57D3BnVoGakPz0LMCaXlr5k6EE
 hcxD5lmKhhEzCaYotXvvhdcoZM2GlaWAVi0uGAe97gWkaCXkvAOoMAPYpJ2EdV7Ytq0S
 fMpw/wChwFMuBMEXu5cQ8vjvoxrH0kZ2H63FuQNA1E2CJtVvVklLv66+AZT1lQie52OH
 vXAPe8Nv/QXXF3iyefzyZ0nt6hCgrNCXm7+dd0y+ij+jdzxQbYH9cvAC/zJfiTOJjHaR
 3vOFdz2NsVHfxbdkqOAeCcHG8QQK+nMa6GmGSMNAwC2+lUJ+COrkYB7u9Zgi39ZmGxqK nQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q47fatmrn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 00:09:10 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33QN01rW007153;
        Thu, 27 Apr 2023 00:09:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4618mpbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 00:09:09 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33R0938S013888;
        Thu, 27 Apr 2023 00:09:08 GMT
Received: from ca-qasparc-x86-2.us.oracle.com (ca-qasparc-x86-2.us.oracle.com [10.147.24.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3q4618mp42-4;
        Thu, 27 Apr 2023 00:09:08 +0000
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, rppt@kernel.org, akpm@linux-foundation.org,
        ebiederm@xmission.com, keescook@chromium.org, graf@amazon.com,
        jason.zeng@intel.com, lei.l.li@intel.com,
        steven.sistare@oracle.com, fam.zheng@bytedance.com,
        mgalaxy@akamai.com, kexec@lists.infradead.org
Subject: [RFC v3 03/21] mm: PKRAM: implement object load and save functions
Date:   Wed, 26 Apr 2023 17:08:39 -0700
Message-Id: <1682554137-13938-4-git-send-email-anthony.yznaga@oracle.com>
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
X-Proofpoint-ORIG-GUID: KQ35sjKexsktQQWPCGo9miJFSnT_W4A6
X-Proofpoint-GUID: KQ35sjKexsktQQWPCGo9miJFSnT_W4A6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PKRAM nodes are further divided into a list of objects. After a save
operation has been initiated for a node, a save operation for an object
associated with the node is initiated by calling pkram_prepare_save_obj().
A new object is created and linked to the node.  The save operation for
the object is committed by calling pkram_finish_save_obj().  After a load
operation has been initiated, pkram_prepare_load_obj() is called to
delete the next object from the node and prepare the corresponding
stream for loading data from it.  After the load of object has been
finished, pkram_finish_load_obj() is called to free the object.  Objects
are also deleted when a save operation is discarded.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/pkram.h |  2 ++
 mm/pkram.c            | 72 ++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index 8def9017b16a..83718ad0e416 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -7,6 +7,7 @@
 #include <linux/mm_types.h>
 
 struct pkram_node;
+struct pkram_obj;
 
 /**
  * enum pkram_data_flags - definition of data types contained in a pkram obj
@@ -19,6 +20,7 @@ enum pkram_data_flags {
 struct pkram_stream {
 	gfp_t gfp_mask;
 	struct pkram_node *node;
+	struct pkram_obj *obj;
 };
 
 struct pkram_access;
diff --git a/mm/pkram.c b/mm/pkram.c
index bbfd8df0874e..6e3895cb9872 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -6,9 +6,14 @@
 #include <linux/mm.h>
 #include <linux/mutex.h>
 #include <linux/pkram.h>
+#include <linux/sched.h>
 #include <linux/string.h>
 #include <linux/types.h>
 
+struct pkram_obj {
+	__u64   obj_pfn;	/* points to the next object in the list */
+};
+
 /*
  * Preserved memory is divided into nodes that can be saved or loaded
  * independently of each other. The nodes are identified by unique name
@@ -18,6 +23,7 @@
  */
 struct pkram_node {
 	__u32	flags;
+	__u64	obj_pfn;	/* points to the first obj of the node */
 
 	__u8	name[PKRAM_NAME_MAX];
 };
@@ -62,6 +68,21 @@ static struct pkram_node *pkram_find_node(const char *name)
 	return NULL;
 }
 
+static void pkram_truncate_node(struct pkram_node *node)
+{
+	unsigned long obj_pfn;
+	struct pkram_obj *obj;
+
+	obj_pfn = node->obj_pfn;
+	while (obj_pfn) {
+		obj = pfn_to_kaddr(obj_pfn);
+		obj_pfn = obj->obj_pfn;
+		pkram_free_page(obj);
+		cond_resched();
+	}
+	node->obj_pfn = 0;
+}
+
 static void pkram_stream_init(struct pkram_stream *ps,
 			     struct pkram_node *node, gfp_t gfp_mask)
 {
@@ -124,12 +145,31 @@ int pkram_prepare_save(struct pkram_stream *ps, const char *name, gfp_t gfp_mask
  *
  * Returns 0 on success, -errno on failure.
  *
+ * Error values:
+ *	%ENOMEM: insufficient memory available
+ *
  * After the save has finished, pkram_finish_save_obj() (or pkram_discard_save()
  * in case of failure) is to be called.
  */
 int pkram_prepare_save_obj(struct pkram_stream *ps, enum pkram_data_flags flags)
 {
-	return -EINVAL;
+	struct pkram_node *node = ps->node;
+	struct pkram_obj *obj;
+	struct page *page;
+
+	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_SAVE);
+
+	page = pkram_alloc_page(ps->gfp_mask | __GFP_ZERO);
+	if (!page)
+		return -ENOMEM;
+	obj = page_address(page);
+
+	if (node->obj_pfn)
+		obj->obj_pfn = node->obj_pfn;
+	node->obj_pfn = page_to_pfn(page);
+
+	ps->obj = obj;
+	return 0;
 }
 
 /**
@@ -137,7 +177,9 @@ int pkram_prepare_save_obj(struct pkram_stream *ps, enum pkram_data_flags flags)
  */
 void pkram_finish_save_obj(struct pkram_stream *ps)
 {
-	WARN_ON_ONCE(1);
+	struct pkram_node *node = ps->node;
+
+	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_SAVE);
 }
 
 /**
@@ -168,6 +210,7 @@ void pkram_discard_save(struct pkram_stream *ps)
 	pkram_delete_node(node);
 	mutex_unlock(&pkram_mutex);
 
+	pkram_truncate_node(node);
 	pkram_free_page(node);
 }
 
@@ -215,11 +258,26 @@ int pkram_prepare_load(struct pkram_stream *ps, const char *name)
  *
  * Returns 0 on success, -errno on failure.
  *
+ * Error values:
+ *	%ENODATA: Stream @ps has no preserved memory objects
+ *
  * After the load has finished, pkram_finish_load_obj() is to be called.
  */
 int pkram_prepare_load_obj(struct pkram_stream *ps)
 {
-	return -EINVAL;
+	struct pkram_node *node = ps->node;
+	struct pkram_obj *obj;
+
+	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_LOAD);
+
+	if (!node->obj_pfn)
+		return -ENODATA;
+
+	obj = pfn_to_kaddr(node->obj_pfn);
+	node->obj_pfn = obj->obj_pfn;
+
+	ps->obj = obj;
+	return 0;
 }
 
 /**
@@ -229,7 +287,12 @@ int pkram_prepare_load_obj(struct pkram_stream *ps)
  */
 void pkram_finish_load_obj(struct pkram_stream *ps)
 {
-	WARN_ON_ONCE(1);
+	struct pkram_node *node = ps->node;
+	struct pkram_obj *obj = ps->obj;
+
+	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_LOAD);
+
+	pkram_free_page(obj);
 }
 
 /**
@@ -243,6 +306,7 @@ void pkram_finish_load(struct pkram_stream *ps)
 
 	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_LOAD);
 
+	pkram_truncate_node(node);
 	pkram_free_page(node);
 }
 
-- 
1.9.4

