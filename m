Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D7E700ADC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 16:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241598AbjELO6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 10:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241623AbjELO6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 10:58:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A3E35B3
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:58:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 629A461137
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 14:58:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F83CC433D2;
        Fri, 12 May 2023 14:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683903485;
        bh=aaVyrjFt4Z24qTU7IkdzOXPq++vuBvyBWDRYOQbS9VA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YPQSWSrA4888qRlom2V9n0E4yFAcDlwO6kLEPA1Z3/jN+kNGhPXLeY8aFL0ESQTul
         RMyaIs6qUO82q50vSJrCQWrwL5FL7Zd2It0w/k09t7jeuI9/8zofE8JzaXyKCEZlUs
         6vZOfEid0lLW22Wa0vb8u5t7SQjIJphqI/J9HwOCpQIywm81oMLE6fnM89OUtnUkFn
         j8XQGA0U7Xt+BTOHhoHC7wsFBB8N8mbrfH+4xlCjWl8xkta+DzSiBxsCwtLgzfktYM
         MaJ2hhSLpdhYY4k+7RXHrTEDITwtEA6t4tJs5cfx65BsquOpd3IWQp5793KvR6uCq6
         t5vc9nXQmqCFQ==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        virtualization@lists.linux-foundation.org, linux@rivosinc.com,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 3/7] riscv: mm: Refactor create_linear_mapping_range() for hot add
Date:   Fri, 12 May 2023 16:57:33 +0200
Message-Id: <20230512145737.985671-4-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512145737.985671-1-bjorn@kernel.org>
References: <20230512145737.985671-1-bjorn@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Björn Töpel <bjorn@rivosinc.com>

Add a parameter to the direct map setup function, so it can be used in
arch_add_memory() later.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/mm/init.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index e974ff6ef036..aea8ccb3f4ae 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1247,18 +1247,19 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	pt_ops_set_fixmap();
 }
 
-static void __init create_linear_mapping_range(phys_addr_t start,
-					       phys_addr_t end)
+static void __meminit create_linear_mapping_range(phys_addr_t start, phys_addr_t end,
+						  struct mhp_params *params)
 {
 	phys_addr_t pa;
 	uintptr_t va, map_size;
 
 	for (pa = start; pa < end; pa += map_size) {
+		pgprot_t pgprot;
+
 		va = (uintptr_t)__va(pa);
+		pgprot =  params ? params->pgprot : pgprot_from_va(va);
 		map_size = best_map_size(pa, end - pa);
-
-		create_pgd_mapping(swapper_pg_dir, va, pa, map_size,
-				   pgprot_from_va(va));
+		create_pgd_mapping(swapper_pg_dir, va, pa, map_size, pgprot);
 	}
 }
 
@@ -1288,13 +1289,12 @@ static void __init create_linear_mapping_page_table(void)
 		if (end >= __pa(PAGE_OFFSET) + memory_limit)
 			end = __pa(PAGE_OFFSET) + memory_limit;
 
-		create_linear_mapping_range(start, end);
+		create_linear_mapping_range(start, end, NULL);
 	}
 
 #ifdef CONFIG_STRICT_KERNEL_RWX
-	create_linear_mapping_range(ktext_start, ktext_start + ktext_size);
-	create_linear_mapping_range(krodata_start,
-				    krodata_start + krodata_size);
+	create_linear_mapping_range(ktext_start, ktext_start + ktext_size, NULL);
+	create_linear_mapping_range(krodata_start, krodata_start + krodata_size, NULL);
 
 	memblock_clear_nomap(ktext_start,  ktext_size);
 	memblock_clear_nomap(krodata_start, krodata_size);
-- 
2.39.2

