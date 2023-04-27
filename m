Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0596EFE37
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 02:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242840AbjD0AKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 20:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242714AbjD0AKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 20:10:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E985E3C1D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 17:10:04 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QGx3sS004984;
        Thu, 27 Apr 2023 00:09:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=G4RP12t8eWRPBRfP51I1pAfPsGdNJr7M6XikXc8e+iY=;
 b=IZlqAoUK9fHXAG95V5pJiDT0eeJVAQiL96nlqaKKbncGPOq4+NjDLrwT+LKmBt73JFkD
 3mcPIMqgzlzA47ShALrJPkkxu7pusb4qi26KHoPAGbSpX/M1JkOMZO4JOtVmpSLR0jX9
 v6EeFv0n1eY20Q2PLxjvtu1oxZk6jQhbzO6B+YZAzZEf1Dt7fxFNdTu0cCovcI4krNkC
 YCzNxBI2NikR170m1E32WLPrnbIeT83z/r8rH2LuL9SE8ib9UzhQQAVzwkNu+NT3zLlP
 AuUK3EEshPKJCjhjeWrWKljfngifihSrxos/AK80RytyAn6rR1izL4yHZkPJbhQxVjDF RQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q46gbtshv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 00:09:23 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33R00niN007445;
        Thu, 27 Apr 2023 00:09:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4618mpmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 00:09:22 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33R0938k013888;
        Thu, 27 Apr 2023 00:09:21 GMT
Received: from ca-qasparc-x86-2.us.oracle.com (ca-qasparc-x86-2.us.oracle.com [10.147.24.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3q4618mp42-13;
        Thu, 27 Apr 2023 00:09:21 +0000
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, rppt@kernel.org, akpm@linux-foundation.org,
        ebiederm@xmission.com, keescook@chromium.org, graf@amazon.com,
        jason.zeng@intel.com, lei.l.li@intel.com,
        steven.sistare@oracle.com, fam.zheng@bytedance.com,
        mgalaxy@akamai.com, kexec@lists.infradead.org
Subject: [RFC v3 12/21] PKRAM: free the preserved ranges list
Date:   Wed, 26 Apr 2023 17:08:48 -0700
Message-Id: <1682554137-13938-13-git-send-email-anthony.yznaga@oracle.com>
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
X-Proofpoint-GUID: PNCavCd6ue3p59Kx26J25bbv7bWbtwP3
X-Proofpoint-ORIG-GUID: PNCavCd6ue3p59Kx26J25bbv7bWbtwP3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free the pages used to pass the preserved ranges to the new boot.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 arch/x86/mm/init_64.c |  1 +
 include/linux/pkram.h |  2 ++
 mm/pkram.c            | 20 ++++++++++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index a46ffb434f39..9e68f07367fa 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1340,6 +1340,7 @@ void __init mem_init(void)
 	after_bootmem = 1;
 	x86_init.hyper.init_after_bootmem();
 
+	pkram_cleanup();
 	totalram_pages_add(pkram_reserved_pages);
 	/*
 	 * Must be done after boot memory is put on freelist, because here we
diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index 53d5a1ec42ff..c909aa299fc4 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -102,9 +102,11 @@ int pkram_prepare_save(struct pkram_stream *ps, const char *name,
 #ifdef CONFIG_PKRAM
 extern unsigned long pkram_reserved_pages;
 void pkram_reserve(void);
+void pkram_cleanup(void);
 #else
 #define pkram_reserved_pages 0UL
 static inline void pkram_reserve(void) { }
+static inline void pkram_cleanup(void) { }
 #endif
 
 #endif /* _LINUX_PKRAM_H */
diff --git a/mm/pkram.c b/mm/pkram.c
index b711f94dbef4..c63b27bb711b 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -1456,3 +1456,23 @@ int __init pkram_merge_with_reserved(void)
 
 	return 0;
 }
+
+void __init pkram_cleanup(void)
+{
+	struct pkram_region_list *rl;
+	unsigned long next_pfn;
+
+	if (!pkram_sb || !pkram_reserved_pages)
+		return;
+
+	next_pfn = pkram_sb->region_list_pfn;
+
+	while (next_pfn) {
+		struct page *page = pfn_to_page(next_pfn);
+
+		rl = pfn_to_kaddr(next_pfn);
+		next_pfn = rl->next_pfn;
+		__free_pages_core(page, 0);
+		pkram_reserved_pages--;
+	}
+}
-- 
1.9.4

