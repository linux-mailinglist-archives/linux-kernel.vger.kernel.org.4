Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556FE6EFE39
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 02:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242826AbjD0AKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 20:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242719AbjD0AKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 20:10:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC7C3ABD
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 17:10:04 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QGx8Pf014802;
        Thu, 27 Apr 2023 00:09:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=/klwynvryfeEh0hvbf4HAyTY1q/nlnl3HuBNmoKxWqE=;
 b=0j0n+Kwn3Bvz2+mjvASxMuPf8yoNwQ+WflTC1dDKD5SawtcQeSwCAX5Kl9PhTbjLM7XR
 0SZX9uzBB7nHTzqDuYT3ExaruHA9SVIUtnOMZT42jsPxL3vRnz7XBauO5nY7dbWI8FGa
 k+a1xB0bz8FRktPPGJfMWdBAzSN67DoN4vn/wLfmsPxiBZXp0NViGyfMYOIiBfLxFYT4
 YXmoG776eXjaC1bOyRIBJqyj52I0AsEr/DhPR3yHpLY7noBzb6XnjLZj8fFYuYmVKzKv
 Q/FhZ+/q1DvdVY6ADsoIdHyzTV0xawqFouIVJzNEoW/6uIlQ72P899/I2IKT1PoYoTBo 0Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q47fatms1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 00:09:24 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33QNIv5l007334;
        Thu, 27 Apr 2023 00:09:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4618mpnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 00:09:23 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33R0938m013888;
        Thu, 27 Apr 2023 00:09:23 GMT
Received: from ca-qasparc-x86-2.us.oracle.com (ca-qasparc-x86-2.us.oracle.com [10.147.24.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3q4618mp42-14;
        Thu, 27 Apr 2023 00:09:23 +0000
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, rppt@kernel.org, akpm@linux-foundation.org,
        ebiederm@xmission.com, keescook@chromium.org, graf@amazon.com,
        jason.zeng@intel.com, lei.l.li@intel.com,
        steven.sistare@oracle.com, fam.zheng@bytedance.com,
        mgalaxy@akamai.com, kexec@lists.infradead.org
Subject: [RFC v3 13/21] PKRAM: prevent inadvertent use of a stale superblock
Date:   Wed, 26 Apr 2023 17:08:49 -0700
Message-Id: <1682554137-13938-14-git-send-email-anthony.yznaga@oracle.com>
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
X-Proofpoint-ORIG-GUID: dA85op-dAowHiRV38HyLZKKt_wYwuMGr
X-Proofpoint-GUID: dA85op-dAowHiRV38HyLZKKt_wYwuMGr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When pages have been saved to be preserved by the current boot, set
a magic number on the super block to be validated by the next kernel.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/pkram.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/pkram.c b/mm/pkram.c
index c63b27bb711b..befdffc76940 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -22,6 +22,7 @@
 
 #include "internal.h"
 
+#define PKRAM_MAGIC		0x706B726D
 
 /*
  * Represents a reference to a data page saved to PKRAM.
@@ -110,6 +111,8 @@ struct pkram_region_list {
  * The structure occupies a memory page.
  */
 struct pkram_super_block {
+	__u32	magic;
+
 	__u64	node_pfn;		/* first element of the node list */
 	__u64	region_list_pfn;
 	__u64	nr_regions;
@@ -179,6 +182,11 @@ void __init pkram_reserve(void)
 		err = PTR_ERR(pkram_sb);
 		goto out;
 	}
+	if (pkram_sb->magic != PKRAM_MAGIC) {
+		pr_err("PKRAM: invalid super block\n");
+		err = -EINVAL;
+		goto out;
+	}
 	/* An empty pkram_sb is not an error */
 	if (!pkram_sb->node_pfn) {
 		pkram_sb = NULL;
@@ -1012,6 +1020,7 @@ static void __pkram_reboot(void)
 	 */
 	memset(pkram_sb, 0, PAGE_SIZE);
 	if (!err && node_pfn) {
+		pkram_sb->magic = PKRAM_MAGIC;
 		pkram_sb->node_pfn = node_pfn;
 		pkram_sb->region_list_pfn = rl_pfn;
 		pkram_sb->nr_regions = nr_regions;
-- 
1.9.4

