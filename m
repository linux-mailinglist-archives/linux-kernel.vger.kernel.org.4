Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FA55BF82A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 09:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiIUHtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 03:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiIUHs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 03:48:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4910D85AB7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 00:48:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55E1762890
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 07:48:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DDEFC433C1;
        Wed, 21 Sep 2022 07:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663746535;
        bh=IzRgoxZ6RnaM4sIz+et5DXk5atJjzwXvP8kXZDGpFW8=;
        h=From:To:Cc:Subject:Date:From;
        b=DbCIWuPqOvmII3MueM54cgiUWWfQ+1BUCg5m0OqB0SQQfrUiFyPNFUNYnoeNpyfHK
         Q9RYQn6ZETswdPjOM4f86LCrVUi9T2rrZom/e58q82hJJTkp+WZ8fKDKwFMhObwwgf
         733GPgF4faztXTv3HyUS3iuThQ7VEbLPD+dpjy44q6ccFTIZGGABXv9s598IsOisZZ
         3+tTegtFCWc2Dc/vDiWvZYlo4FhnnedeKkWbJkhNNVas/aIrEV63uHsFHqn4soWdVl
         F0aFRR65ExQDko2+ZZ3pKGV0+WOVM4Zbe0WO65TLUZ9sCzlm2Rq4kqQjW/iW9AMrpF
         C/QdvM9q7qVHw==
From:   Mike Rapoport <rppt@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/mm: fold check for KFENCE into can_set_direct_map()
Date:   Wed, 21 Sep 2022 10:48:41 +0300
Message-Id: <20220921074841.382615-1-rppt@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

KFENCE requires linear map to be mapped at page granularity, so that it
is possible to protect/unprotect single pages, just like with
rodata_full and DEBUG_PAGEALLOC.

Instead of repating

	can_set_direct_map() || IS_ENABLED(CONFIG_KFENCE)

make can_set_direct_map() handle the KFENCE case.

This also prevents potential false positives in kernel_page_present()
that may return true for non-present page if CONFIG_KFENCE is enabled.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm64/mm/mmu.c      | 8 ++------
 arch/arm64/mm/pageattr.c | 8 +++++++-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index e7ad44585f40..c5065abec55a 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -535,7 +535,7 @@ static void __init map_mem(pgd_t *pgdp)
 	 */
 	BUILD_BUG_ON(pgd_index(direct_map_end - 1) == pgd_index(direct_map_end));
 
-	if (can_set_direct_map() || IS_ENABLED(CONFIG_KFENCE))
+	if (can_set_direct_map())
 		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
 	/*
@@ -1547,11 +1547,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
 
 	VM_BUG_ON(!mhp_range_allowed(start, size, true));
 
-	/*
-	 * KFENCE requires linear map to be mapped at page granularity, so that
-	 * it is possible to protect/unprotect single pages in the KFENCE pool.
-	 */
-	if (can_set_direct_map() || IS_ENABLED(CONFIG_KFENCE))
+	if (can_set_direct_map())
 		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
 	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 64e985eaa52d..d107c3d434e2 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -21,7 +21,13 @@ bool rodata_full __ro_after_init = IS_ENABLED(CONFIG_RODATA_FULL_DEFAULT_ENABLED
 
 bool can_set_direct_map(void)
 {
-	return rodata_full || debug_pagealloc_enabled();
+	/*
+	 * rodata_full, DEBUG_PAGEALLOC and KFENCE require linear map to be
+	 * mapped at page granularity, so that it is possible to
+	 * protect/unprotect single pages.
+	 */
+	return rodata_full || debug_pagealloc_enabled() ||
+		IS_ENABLED(CONFIG_KFENCE);
 }
 
 static int change_page_range(pte_t *ptep, unsigned long addr, void *data)
-- 
2.35.3

