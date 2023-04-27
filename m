Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9A96EFE36
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 02:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242822AbjD0AKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 20:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242725AbjD0AKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 20:10:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A2E3C30
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 17:10:06 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QGxIC6009633;
        Thu, 27 Apr 2023 00:09:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=VjHtF6foxcpPkuDRLURypMKoHlv1VKb82EFT44hMcWo=;
 b=Yy0rDZNcm0K3+32Kv5Kt0bnPhZ+cjF+9HlcT8JjGanst6ujGlEFRgGR7Ty79CgHZnvhb
 7RTmGajtoDcdzYpnzsTA+k/ABNEC1jZn22VcWZc0OANw7MpS0eOUswTIk1JBI0ub4N37
 IxTv2QvPe0bmDiAlAOcHmJTDoHO8Zod3IT83urwFmtn2gzLy+JH6nmLGe+e863aIch4A
 WuzSrCLKVsUPlRJ9BwvFUGWu9PKDq5sFRAeU5XrJbS8BjGunh37SO3dCp9KefjeNn9CB
 s3FOGBZB1g9Z9GtLUzadHIQb3UVXkgecu+FEa8rdMXsWTpQtMXS/5i1nqDt2NMBR19YD 5w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q484utq26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 00:09:27 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33QNUjaj007380;
        Thu, 27 Apr 2023 00:09:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4618mpqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 00:09:26 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33R0938q013888;
        Thu, 27 Apr 2023 00:09:26 GMT
Received: from ca-qasparc-x86-2.us.oracle.com (ca-qasparc-x86-2.us.oracle.com [10.147.24.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3q4618mp42-16;
        Thu, 27 Apr 2023 00:09:26 +0000
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, rppt@kernel.org, akpm@linux-foundation.org,
        ebiederm@xmission.com, keescook@chromium.org, graf@amazon.com,
        jason.zeng@intel.com, lei.l.li@intel.com,
        steven.sistare@oracle.com, fam.zheng@bytedance.com,
        mgalaxy@akamai.com, kexec@lists.infradead.org
Subject: [RFC v3 15/21] kexec: PKRAM: prevent kexec clobbering preserved pages in some cases
Date:   Wed, 26 Apr 2023 17:08:51 -0700
Message-Id: <1682554137-13938-16-git-send-email-anthony.yznaga@oracle.com>
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
X-Proofpoint-GUID: -pxnJnsePK2q5pM0GAqWo7YuzPwuh3pz
X-Proofpoint-ORIG-GUID: -pxnJnsePK2q5pM0GAqWo7YuzPwuh3pz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When loading a kernel for kexec, dynamically update the list of physical
ranges that are not to be used for storing preserved pages with the ranges
where kexec segments will be copied to on reboot. This ensures no pages
preserved after the new kernel has been loaded will reside in these ranges
on reboot.

Not yet handled is the case where pages have been preserved before a
kexec kernel is loaded.  This will be covered by a later patch.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 kernel/kexec.c      |  9 +++++++++
 kernel/kexec_file.c | 10 ++++++++++
 2 files changed, 19 insertions(+)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 92d301f98776..cd871fc07c65 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -16,6 +16,7 @@
 #include <linux/syscalls.h>
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
+#include <linux/pkram.h>
 
 #include "kexec_internal.h"
 
@@ -153,6 +154,14 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 	if (ret)
 		goto out;
 
+	for (i = 0; i < nr_segments; i++) {
+		unsigned long mem = image->segment[i].mem;
+		size_t memsz = image->segment[i].memsz;
+
+		if (memsz)
+			pkram_ban_region(PFN_DOWN(mem), PFN_UP(mem + memsz) - 1);
+	}
+
 	/* Install the new kernel and uninstall the old */
 	image = xchg(dest_image, image);
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f1a0e4e3fb5c..ca2aa2d61955 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -27,6 +27,8 @@
 #include <linux/kernel_read_file.h>
 #include <linux/syscalls.h>
 #include <linux/vmalloc.h>
+#include <linux/pkram.h>
+
 #include "kexec_internal.h"
 
 #ifdef CONFIG_KEXEC_SIG
@@ -403,6 +405,14 @@ static int kexec_image_verify_sig(struct kimage *image, void *buf,
 	if (ret)
 		goto out;
 
+	for (i = 0; i < image->nr_segments; i++) {
+		unsigned long mem = image->segment[i].mem;
+		size_t memsz = image->segment[i].memsz;
+
+		if (memsz)
+			pkram_ban_region(PFN_DOWN(mem), PFN_UP(mem + memsz) - 1);
+	}
+
 	/*
 	 * Free up any temporary buffers allocated which are not needed
 	 * after image has been loaded
-- 
1.9.4

