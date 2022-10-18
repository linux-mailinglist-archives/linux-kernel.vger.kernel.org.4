Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD8B6035D8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 00:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiJRWZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 18:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiJRWZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 18:25:12 -0400
Received: from smtpcmd0987.aruba.it (smtpcmd0987.aruba.it [62.149.156.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 605F84AD4F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 15:25:08 -0700 (PDT)
Received: from localhost.localdomain ([146.241.87.206])
        by Aruba Outgoing Smtp  with ESMTPSA
        id kv1EovliYaWj1kv1HoELBg; Wed, 19 Oct 2022 00:25:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1666131907; bh=G21UWZTIRbOHhkWY/cfvy0aqZyPYcJqojzWjie6A3oY=;
        h=From:To:Subject:Date:MIME-Version;
        b=Ud6pBCkOhW9bvos1H1dj4qs8CCcCVVIt69Nxys7taT6ylik0WXRGxKFSJxG8sYeUf
         JbJMIBUYCt1jkpq3lcR57QYVfTl5gTurPUNuelLPh6ymK5jj35Mb9d3JMLGZn55sOY
         3XwP95JCvof1pl5GjeXqt204+FvRC3Xwre65boVIoMMF2NnWbTdwjnbwDd7HejtON4
         bXM0GF57lBL3PIjwRtKUIqJRu9u8SUQ/R3McRIvSt/tLNAROw3TIS3g4W0+H7hFz0f
         E8GGWftaxRtwmbrGvtPZeCYvhUfjaz7EBNJdswcgwuMxmjYPQ3k8N49qdL4J8JdMnq
         YcYCx1oBvw2KA==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>
Subject: [PATCH v2 2/2] ARM: mm: convert empty_zero_page to array for consistency
Date:   Wed, 19 Oct 2022 00:25:03 +0200
Message-Id: <20221018222503.90118-2-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018222503.90118-1-giulio.benetti@benettiengineering.com>
References: <20221018222503.90118-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfPZlKIhA9QmVEJg8TyQBw3iOkBHZPOM6fAPP7UVSbA59v5ex4MI480bxgNdmo8uHnNiksDWqvpGUvjzux5YgGrteQPR5O48noLtBaTn1TidfdU+mLXi/
 FFtW/XkJQDDRzYNqBcP6279UyKprwgLo3h5hGUB2sfHoYxuhC8MpaLZy9WTMmtwSsSBHv/Wa19QXWDMy9MWX7lGH862VbgubxMzq55a3PtL4HadLBBpjxxPf
 MzfXXUphB7jB5T7JVxZf9Nl6/ch6X3KpE3T00QtMyr1EJm9ATRYwfOYkkmMhx3Dha4DBBMJlVD7ClieCQKKu5XfjYGeLYjfl0mFtha9uUEM6KtvVaP4d/JZ+
 LxiNlwaXaEeQ017keBant8uTh5J4txIvAB/z4TrTLyC18pEZfkAu3ubfDF6iL24AIdyF/LrA8FatnhlM+m6MpMezt0V9n1U0lOAcCBep2+a7US/j/iQZFlBu
 G1V7fNAJTLTe2e8Cb87lLxqv+3TCOnUYs5NaKR9GsYQ1T7a1ZgR5r7FGMAIA9TyC8LNCvSvzohoUY3KTmTbA5Vvmz7gJYU9dnnhVKhfUrRihsYgNRMgSg6D0
 38s=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM architecture is the only one to have empty_zero_page to be a
struct page pointer, while in all other implementations empty_zero_page is
a data pointer or directly an array(the zero page itself). So let's convert
empty_zero_page to an array for consistency and to avoid an early
allocation+dcache flush. Being the array in .bss it will be cleared earlier
in a more linear way(and a bit faster) way.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
V1->V2:
* create patch suggested by Arnd Bergmann
---
 arch/arm/include/asm/pgtable.h |  4 ++--
 arch/arm/mm/mmu.c              | 10 +---------
 arch/arm/mm/nommu.c            | 14 +-------------
 3 files changed, 4 insertions(+), 24 deletions(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index ef48a55e9af8..de402b345f55 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -15,8 +15,8 @@
  * ZERO_PAGE is a global shared page that is always zero: used
  * for zero-mapped memory areas etc..
  */
-extern struct page *empty_zero_page;
-#define ZERO_PAGE(vaddr)	(empty_zero_page)
+extern unsigned long empty_zero_page[];
+#define ZERO_PAGE(vaddr)	(virt_to_page(empty_zero_page))
 #endif
 
 #ifndef CONFIG_MMU
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 463fc2a8448f..f05a5471a45a 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -45,7 +45,7 @@ extern unsigned long __atags_pointer;
  * empty_zero_page is a special page that is used for
  * zero-initialized data and COW.
  */
-struct page *empty_zero_page;
+unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)] __page_aligned_bss;
 EXPORT_SYMBOL(empty_zero_page);
 
 /*
@@ -1760,8 +1760,6 @@ static void __init early_fixmap_shutdown(void)
  */
 void __init paging_init(const struct machine_desc *mdesc)
 {
-	void *zero_page;
-
 	pr_debug("physical kernel sections: 0x%08llx-0x%08llx\n",
 		 kernel_sec_start, kernel_sec_end);
 
@@ -1782,13 +1780,7 @@ void __init paging_init(const struct machine_desc *mdesc)
 
 	top_pmd = pmd_off_k(0xffff0000);
 
-	/* allocate the zero page. */
-	zero_page = early_alloc(PAGE_SIZE);
-
 	bootmem_init();
-
-	empty_zero_page = virt_to_page(zero_page);
-	__flush_dcache_page(NULL, empty_zero_page);
 }
 
 void __init early_mm_init(const struct machine_desc *mdesc)
diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index c1494a4dee25..e0c3f59d1c5a 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -30,7 +30,7 @@ unsigned long vectors_base;
  * empty_zero_page is a special page that is used for
  * zero-initialized data and COW.
  */
-struct page *empty_zero_page;
+unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)] __page_aligned_bss;
 EXPORT_SYMBOL(empty_zero_page);
 
 #ifdef CONFIG_ARM_MPU
@@ -155,21 +155,9 @@ void __init adjust_lowmem_bounds(void)
  */
 void __init paging_init(const struct machine_desc *mdesc)
 {
-	void *zero_page;
-
 	early_trap_init((void *)vectors_base);
 	mpu_setup();
-
-	/* allocate the zero page. */
-	zero_page = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
-	if (!zero_page)
-		panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
-		      __func__, PAGE_SIZE, PAGE_SIZE);
-
 	bootmem_init();
-
-	empty_zero_page = virt_to_page(zero_page);
-	flush_dcache_page(empty_zero_page);
 }
 
 /*
-- 
2.34.1

