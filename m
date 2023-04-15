Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75496E2FAE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 10:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjDOITX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 04:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDOITV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 04:19:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDC04ED5
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 01:19:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67F2D60E98
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 08:19:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68DCEC433D2;
        Sat, 15 Apr 2023 08:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681546757;
        bh=ljAiPSwIhWGmapP/c1uNdTrp/qDU7fl0aVv/azO7YYc=;
        h=From:To:Cc:Subject:Date:From;
        b=Wl3gzEypngqcW08OZvjH6HF9OZf/zXny3K7LUCUsq++UnsVLaDKvBzCnhntZEYtQK
         AdB9V6nMsz4R1ufYFZULYMFVAZSDK8ynDrMXz1jq1KTK4udt9Q5xLqSIN9p4eTcs87
         b50ZibD2Eh59IxclwgnAp1/U+qO7oK4EjJ0rv/gbAKKYQ+uqaqERJSJn1kGtIIFnr5
         AHjH5ltIKRs+cDY9eMjqab2PHhVcroegZgBk10mO6WzgSLNbOP6m9LsjdE2kwul5XY
         kmklVMWmjC1IK0WvXsS3piYyalfFDaaEw79LF5x/x+nWKSBDnFHZuVKa4vLKWoXDlO
         a3MDw3OJUipSg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, llvm@lists.linux.dev,
        Vineet Gupta <vgupta@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] [v2] mm: make arch_has_descending_max_zone_pfns() static
Date:   Sat, 15 Apr 2023 10:18:20 +0200
Message-Id: <20230415081904.969049-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
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

From: Arnd Bergmann <arnd@arndb.de>

clang produces a build failure on x86 for some randconfig builds
after a change that moves around code to mm/mm_init.c:

Cannot find symbol for section 2: .text.
mm/mm_init.o: failed

I have not been able to figure out why this happens, but the __weak
annotation on arch_has_descending_max_zone_pfns() is the trigger here.

Removing the weak function in favor of an open-coded Kconfig option
check avoids the problem and becomes clearer as well as better to
optimize by the compiler.

Fixes: 9420f89db2dd ("mm: move most of core MM initialization to mm/mm_init.c")
Cc: llvm@lists.linux.dev
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: fix logic bug reported-by: kernel test robot <oliver.sang@intel.com>,
see https://lore.kernel.org/oe-lkp/202304151422.5e4d380b-oliver.sang@intel.com
---
 arch/arc/mm/init.c | 5 -----
 include/linux/mm.h | 1 -
 mm/mm_init.c       | 4 ++--
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
index ce4e939a7f07..2b89b6c53801 100644
--- a/arch/arc/mm/init.c
+++ b/arch/arc/mm/init.c
@@ -74,11 +74,6 @@ void __init early_init_dt_add_memory_arch(u64 base, u64 size)
 		base, TO_MB(size), !in_use ? "Not used":"");
 }
 
-bool arch_has_descending_max_zone_pfns(void)
-{
-	return !IS_ENABLED(CONFIG_ARC_HAS_PAE40);
-}
-
 /*
  * First memory setup routine called from setup_arch()
  * 1. setup swapper's mm @init_mm
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 63acf4a598fe..75d8adce0aee 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3061,7 +3061,6 @@ extern void setup_per_cpu_pageset(void);
 extern int min_free_kbytes;
 extern int watermark_boost_factor;
 extern int watermark_scale_factor;
-extern bool arch_has_descending_max_zone_pfns(void);
 
 /* nommu.c */
 extern atomic_long_t mmap_pages_allocated;
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 35302b7bca83..7f7f9c677854 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1754,9 +1754,9 @@ static void __init free_area_init_memoryless_node(int nid)
  * Some architectures, e.g. ARC may have ZONE_HIGHMEM below ZONE_NORMAL. For
  * such cases we allow max_zone_pfn sorted in the descending order
  */
-bool __weak arch_has_descending_max_zone_pfns(void)
+static bool arch_has_descending_max_zone_pfns(void)
 {
-	return false;
+	return IS_ENABLED(CONFIG_ARC) && !IS_ENABLED(CONFIG_ARC_HAS_PAE40);
 }
 
 /**
-- 
2.39.2

