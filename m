Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B456EFE35
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 02:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242701AbjD0AKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 20:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242728AbjD0AKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 20:10:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F2A40C6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 17:10:06 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QGxER0025323;
        Thu, 27 Apr 2023 00:09:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=iVHkxnhPmN3ZiIllDQA4XN9d0CPfj30tNxwbJaWlZYE=;
 b=uln3/Y5F+Sv5bX0Aapb9pqhswccVRvqb/9UqSXysiUWJfvKaAtGgueeexgYxPSyeDVU1
 JY61SJ0QAxIz9xFLQu1a+bfAQ7BoRsRMO/zykqYENeQfQX2Tsp31Pwuci7L745E6EStq
 al6VWV501TMo24pZir/gWgRySI/5HjAKGGrMSanISa8maMcnnLFivFO29ZEDyZLAdXSZ
 RWl2os1ejhXGKljBNkHolMvKGrZDQUtuY+vOxt6u02F5SFOr5ARd7jtA13Qssv/4Q+Nd
 ZEr7Z+4EcuFibdjMmqSjL+Co/bgWhtdnklJ3asiCwPFLUA3oIv16J3DXTRhyeQz5K8J3 vA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q46622tyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 00:09:28 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33QNRYCp007326;
        Thu, 27 Apr 2023 00:09:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4618mprm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 00:09:28 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33R0938s013888;
        Thu, 27 Apr 2023 00:09:27 GMT
Received: from ca-qasparc-x86-2.us.oracle.com (ca-qasparc-x86-2.us.oracle.com [10.147.24.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3q4618mp42-17;
        Thu, 27 Apr 2023 00:09:27 +0000
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, rppt@kernel.org, akpm@linux-foundation.org,
        ebiederm@xmission.com, keescook@chromium.org, graf@amazon.com,
        jason.zeng@intel.com, lei.l.li@intel.com,
        steven.sistare@oracle.com, fam.zheng@bytedance.com,
        mgalaxy@akamai.com, kexec@lists.infradead.org
Subject: [RFC v3 16/21] PKRAM: provide a way to check if a memory range has preserved pages
Date:   Wed, 26 Apr 2023 17:08:52 -0700
Message-Id: <1682554137-13938-17-git-send-email-anthony.yznaga@oracle.com>
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
X-Proofpoint-ORIG-GUID: 2bK9bjHYj08MJyIhhXZ9v97WqmZ7xyPq
X-Proofpoint-GUID: 2bK9bjHYj08MJyIhhXZ9v97WqmZ7xyPq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a kernel is loaded for kexec the address ranges where the kexec
segments will be copied to may conflict with pages already set to be
preserved. Provide a way to determine if preserved pages exist in a
specified range.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/pkram.h |  2 ++
 mm/pkram.c            | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index 29109e875604..bec9ae75e802 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -104,11 +104,13 @@ int pkram_prepare_save(struct pkram_stream *ps, const char *name,
 void pkram_reserve(void);
 void pkram_cleanup(void);
 void pkram_ban_region(unsigned long start, unsigned long end);
+int pkram_has_preserved_pages(unsigned long start, unsigned long end);
 #else
 #define pkram_reserved_pages 0UL
 static inline void pkram_reserve(void) { }
 static inline void pkram_cleanup(void) { }
 static inline void pkram_ban_region(unsigned long start, unsigned long end) { }
+static inline int pkram_has_preserved_pages(unsigned long start, unsigned long end) { return 0; }
 #endif
 
 #endif /* _LINUX_PKRAM_H */
diff --git a/mm/pkram.c b/mm/pkram.c
index cef75bd8ba99..474fb6fc8355 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -1690,3 +1690,23 @@ void __init pkram_cleanup(void)
 		pkram_reserved_pages--;
 	}
 }
+
+static int has_preserved_pages_cb(unsigned long base, unsigned long size, void *private)
+{
+	int *has_preserved = (int *)private;
+
+	*has_preserved = 1;
+	return 1;
+}
+
+/*
+ * Check whether the memory range [start, end) contains preserved pages.
+ */
+int pkram_has_preserved_pages(unsigned long start, unsigned long end)
+{
+	int has_preserved = 0;
+
+	pkram_find_preserved(start, end, &has_preserved, has_preserved_pages_cb);
+
+	return has_preserved;
+}
-- 
1.9.4

