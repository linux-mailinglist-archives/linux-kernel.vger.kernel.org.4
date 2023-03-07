Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE586AD4AC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 03:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjCGC0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 21:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjCGC03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 21:26:29 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17466A428
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 18:26:13 -0800 (PST)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PVzl062xwznWTK;
        Tue,  7 Mar 2023 10:23:24 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 10:26:11 +0800
From:   Wupeng Ma <mawupeng1@huawei.com>
To:     <akpm@linux-foundation.org>, <dave.hansen@linux.intel.com>,
        <luto@kernel.org>, <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <mawupeng1@huawei.com>, <bp@suse.de>
Subject: [PATCH v2 -next 3/3] x86/mm/pat: Remove WARN_ON_ONCE if follow_phys fails
Date:   Tue, 7 Mar 2023 10:26:06 +0800
Message-ID: <20230307022606.2367399-4-mawupeng1@huawei.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ma Wupeng <mawupeng1@huawei.com>

WARN_ON_ONCE here is not useful for solving problem since why this PA is
not valid is still unknown if follow_phys fails in
track_pfn_copy/untrack_pfn, Drop it.

Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
---
 arch/x86/mm/pat/memtype.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 3ec025011c90..bda4b6b910c2 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -993,10 +993,9 @@ int track_pfn_copy(struct vm_area_struct *vma)
 		 * reserve the whole chunk covered by vma. We need the
 		 * starting address and protection from pte.
 		 */
-		if (follow_phys(vma, vma->vm_start, &prot, &paddr)) {
-			WARN_ON_ONCE(1);
+		if (follow_phys(vma, vma->vm_start, &prot, &paddr))
 			return -EINVAL;
-		}
+
 		pgprot = __pgprot(prot);
 		return reserve_pfn_range(paddr, vma_size, &pgprot, 1);
 	}
@@ -1080,10 +1079,8 @@ void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 	/* free the chunk starting from pfn or the whole chunk */
 	paddr = (resource_size_t)pfn << PAGE_SHIFT;
 	if (!paddr && !size) {
-		if (follow_phys(vma, vma->vm_start, &prot, &paddr)) {
-			WARN_ON_ONCE(1);
+		if (follow_phys(vma, vma->vm_start, &prot, &paddr))
 			return;
-		}
 
 		size = vma->vm_end - vma->vm_start;
 	}
-- 
2.25.1

