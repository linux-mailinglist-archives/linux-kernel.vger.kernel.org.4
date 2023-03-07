Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886ED6AD4AB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 03:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjCGC0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 21:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjCGC02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 21:26:28 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CDF4D606
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 18:26:13 -0800 (PST)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PVzl115ntz16PDB;
        Tue,  7 Mar 2023 10:23:25 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 10:26:10 +0800
From:   Wupeng Ma <mawupeng1@huawei.com>
To:     <akpm@linux-foundation.org>, <dave.hansen@linux.intel.com>,
        <luto@kernel.org>, <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <mawupeng1@huawei.com>, <bp@suse.de>
Subject: [PATCH v2 -next 2/3] x86/mm/pat: Cleanup unused parameter in follow_phys
Date:   Tue, 7 Mar 2023 10:26:05 +0800
Message-ID: <20230307022606.2367399-3-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230307022606.2367399-1-mawupeng1@huawei.com>
References: <20230307022606.2367399-1-mawupeng1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ma Wupeng <mawupeng1@huawei.com>

Parameter flags is always zero in caller untrack_pfn() and
track_pfn_copy(). let's drop it.

Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
---
 arch/x86/mm/pat/memtype.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 4fb1e89f32e4..3ec025011c90 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -951,8 +951,7 @@ static void free_pfn_range(u64 paddr, unsigned long size)
 }
 
 static int follow_phys(struct vm_area_struct *vma, unsigned long address,
-		       unsigned int flags, unsigned long *prot,
-		       resource_size_t *phys)
+		       unsigned long *prot, resource_size_t *phys)
 {
 	int ret = -EINVAL;
 	pte_t *ptep, pte;
@@ -965,9 +964,6 @@ static int follow_phys(struct vm_area_struct *vma, unsigned long address,
 		goto out;
 	pte = *ptep;
 
-	if ((flags & FOLL_WRITE) && !pte_write(pte))
-		goto unlock;
-
 	*prot = pgprot_val(pte_pgprot(pte));
 	*phys = (resource_size_t)pte_pfn(pte) << PAGE_SHIFT;
 
@@ -997,7 +993,7 @@ int track_pfn_copy(struct vm_area_struct *vma)
 		 * reserve the whole chunk covered by vma. We need the
 		 * starting address and protection from pte.
 		 */
-		if (follow_phys(vma, vma->vm_start, 0, &prot, &paddr)) {
+		if (follow_phys(vma, vma->vm_start, &prot, &paddr)) {
 			WARN_ON_ONCE(1);
 			return -EINVAL;
 		}
@@ -1084,7 +1080,7 @@ void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 	/* free the chunk starting from pfn or the whole chunk */
 	paddr = (resource_size_t)pfn << PAGE_SHIFT;
 	if (!paddr && !size) {
-		if (follow_phys(vma, vma->vm_start, 0, &prot, &paddr)) {
+		if (follow_phys(vma, vma->vm_start, &prot, &paddr)) {
 			WARN_ON_ONCE(1);
 			return;
 		}
-- 
2.25.1

