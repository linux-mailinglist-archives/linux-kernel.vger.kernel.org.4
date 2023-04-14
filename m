Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373076E1DBD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjDNIE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDNIE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:04:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E811FF3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 01:04:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B20061610
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 08:04:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1904C433D2;
        Fri, 14 Apr 2023 08:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681459465;
        bh=kIJ6lK/Lc6cAvvvb9aZuILfOuK0T9xQHpTLzt8A9dFI=;
        h=From:To:Cc:Subject:Date:From;
        b=e6CSSlSynnb8/8SQwximjDYsEgO3iB37cizeXObEuBX6UeZi8PxJbes/BFDKFHl1r
         J845+gmamcoMiwEHZXspDymX/EUrJ1c0x2LpLkUaRUwb6c4sSDKK9Lu9lzza8abojD
         RuKF8Ji5sBj5MXlRir50HWDq3CKnkFPF18u8iPwydZ2QdJMV1Oc4gP38WMyZgvAFAw
         bSzc8eH4UpRLtxV1eCsP8mnq61xV61x6SEdQd8P0WPIzpHETQ62DyT0FuRhFfBlMA8
         VFn8ZB8lzhZGvQZooZ11s139afw6PGuEVJO6I/2qXWP+S+ACcTnOg0CGC4JK84r2mZ
         5BgtQeI+xEWQQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Vineet Gupta <vgupta@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Arnd Bergmann <arnd@arndb.de>, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] mm: make arch_has_descending_max_zone_pfns() static
Date:   Fri, 14 Apr 2023 10:03:53 +0200
Message-Id: <20230414080418.110236-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index ada57b11bb5a..a13cc121841d 100644
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
index 35302b7bca83..f6165747fd3e 100644
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
+	return !IS_ENABLED(CONFIG_ARC_HAS_PAE40);
 }
 
 /**
-- 
2.39.2

