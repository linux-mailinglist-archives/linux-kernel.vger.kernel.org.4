Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58C06EFE3D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 02:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242772AbjD0AKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 20:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242701AbjD0AKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 20:10:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD193C13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 17:10:02 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QGxJYE009644;
        Thu, 27 Apr 2023 00:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=GKXPxESVfvIM+pNIB5lGbZkr/9+GXI6AMF73iO2olBA=;
 b=Fr50ImkcFewD5fhKQE2bdokl3ohNxwbCvzToQ3b3qQt8nmwfevLzs25EG7cuy39H0eWI
 n1LOh78LxZm9im3r9t7TbZe9BB3hn1nNdRiHeT9nPO+1uIo0+IM7jW8Nhi9WY9+llkpC
 C/hv+kIvPkuBGcQeWZeAHkGuhJKvx2Q2mu4mdrCOq9O3mqjJWFFzeVRC6bkX+TU9BPew
 B3hlYsgLWoUYC/EAzBBk2Kj2SXpbhsLn6xM59mCHDWHbJINIhPBxQtipbfWF6rvidti+
 y2+4OGsrI+sJd8YTcewFfgjMScpiVf/CVq/hrFB+6a2eCVKnpqU302dIFuD/UE0e+l+f Ew== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q484utq2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 00:09:30 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33QN01rh007153;
        Thu, 27 Apr 2023 00:09:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4618mpsr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 00:09:30 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33R0938u013888;
        Thu, 27 Apr 2023 00:09:29 GMT
Received: from ca-qasparc-x86-2.us.oracle.com (ca-qasparc-x86-2.us.oracle.com [10.147.24.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3q4618mp42-18;
        Thu, 27 Apr 2023 00:09:29 +0000
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, rppt@kernel.org, akpm@linux-foundation.org,
        ebiederm@xmission.com, keescook@chromium.org, graf@amazon.com,
        jason.zeng@intel.com, lei.l.li@intel.com,
        steven.sistare@oracle.com, fam.zheng@bytedance.com,
        mgalaxy@akamai.com, kexec@lists.infradead.org
Subject: [RFC v3 17/21] kexec: PKRAM: avoid clobbering already preserved pages
Date:   Wed, 26 Apr 2023 17:08:53 -0700
Message-Id: <1682554137-13938-18-git-send-email-anthony.yznaga@oracle.com>
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
X-Proofpoint-GUID: AvvXex8oIgFKryG_FPd3JZhh5CVfptob
X-Proofpoint-ORIG-GUID: AvvXex8oIgFKryG_FPd3JZhh5CVfptob
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure destination ranges of the kexec segments do not overlap
with any kernel pages marked to be preserved across kexec.

For kexec_load, return EADDRNOTAVAIL if overlap is detected.

For kexec_file_load, skip ranges containing preserved pages when
seaching for available ranges to use.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 kernel/kexec_core.c | 3 +++
 kernel/kexec_file.c | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 3d578c6fefee..e0d52f70cb48 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -40,6 +40,7 @@
 #include <linux/hugetlb.h>
 #include <linux/objtool.h>
 #include <linux/kmsg_dump.h>
+#include <linux/pkram.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -178,6 +179,8 @@ int sanity_check_segment_list(struct kimage *image)
 			return -EADDRNOTAVAIL;
 		if (mend >= KEXEC_DESTINATION_MEMORY_LIMIT)
 			return -EADDRNOTAVAIL;
+		if (pkram_has_preserved_pages(mstart, mend))
+			return -EADDRNOTAVAIL;
 	}
 
 	/* Verify our destination addresses do not overlap.
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index ca2aa2d61955..8bca01060d32 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -490,6 +490,11 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
 			continue;
 		}
 
+		if (pkram_has_preserved_pages(temp_start, temp_end + 1)) {
+			temp_start = temp_start - PAGE_SIZE;
+			continue;
+		}
+
 		/* We found a suitable memory range */
 		break;
 	} while (1);
-- 
1.9.4

