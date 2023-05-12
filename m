Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A8B700AE3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 16:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241661AbjELO6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 10:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241676AbjELO6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 10:58:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BBEDD8C
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:58:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F19465735
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 14:58:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9BF1C4339C;
        Fri, 12 May 2023 14:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683903498;
        bh=lRwO3YfIMF9fmZSTE+/WO7BqWpiO2x+8QNF4La5hiEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lFJE9ofAvx/W7GMthxymGs+b9O5oFO1BwdKIGcHaAN62YeWePDQ0N/sK71knTdSoF
         FVBIIqU4AmmF6IG79I2XtGg0JavzeJwFrHvwtyzSV76oVsE2HRceOMMnAX1c65IAP/
         wzRAeUAfR4ibQ4s6pSnjOcUPEJrI0Uwkbd762zC/EYqhScoqAKaEuy84NEiMva3S8O
         cUjmxdLyvrJYLCFOB3H2n8gsVJcGT3aBKjaVsXZO/B0iymi2R+/sIoE+4yZ4U/slfd
         k0/FpzS+nNiLNCLb4BGq3Qd2jSem/r0rZlEnE2QEYIKn4OVGCS3P4sJXIb6FK2umT0
         TTdE0MNOfw90w==
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
Subject: [PATCH 7/7] riscv: mm: Pre-allocate vmalloc PGD leaves
Date:   Fri, 12 May 2023 16:57:37 +0200
Message-Id: <20230512145737.985671-8-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512145737.985671-1-bjorn@kernel.org>
References: <20230512145737.985671-1-bjorn@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Björn Töpel <bjorn@rivosinc.com>

Instead of relying on vmalloc_fault() to synchronize the page-tables,
pre-allocate the PGD leaves of the vmalloc area. This is only enabled
if memory hot/add is enabled by the build.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/mm/fault.c | 7 ++++++-
 arch/riscv/mm/init.c  | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 8685f85a7474..b61e279acd50 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -233,12 +233,17 @@ void handle_page_fault(struct pt_regs *regs)
 	 * Fault-in kernel-space virtual memory on-demand.
 	 * The 'reference' page table is init_mm.pgd.
 	 *
+	 * For memory hotplug enabled systems, the PGD entries are
+	 * pre-allocated, which avoids the need to synchronize
+	 * pgd/fault-in.
+	 *
 	 * NOTE! We MUST NOT take any locks for this case. We may
 	 * be in an interrupt or a critical region, and should
 	 * only copy the information from the master page table,
 	 * nothing more.
 	 */
-	if (unlikely((addr >= VMALLOC_START) && (addr < VMALLOC_END))) {
+	if (unlikely(!IS_ENABLED(CONFIG_MEMORY_HOTPLUG) &&
+		     (addr >= VMALLOC_START) && (addr < VMALLOC_END))) {
 		vmalloc_fault(regs, code, addr);
 		return;
 	}
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index a468708d1e1c..fd5a6d3fe182 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -236,6 +236,7 @@ static void __init preallocate_pgd_pages_range(unsigned long start, unsigned lon
 static void __init prepare_memory_hotplug(void)
 {
 #ifdef CONFIG_MEMORY_HOTPLUG
+	preallocate_pgd_pages_range(VMALLOC_START, VMALLOC_END, "vmalloc");
 	preallocate_pgd_pages_range(VMEMMAP_START, VMEMMAP_END, "vmemmap");
 	preallocate_pgd_pages_range(PAGE_OFFSET, PAGE_END, "direct map");
 #endif
-- 
2.39.2

