Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781356C05E2
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 23:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjCSWCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 18:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjCSWBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 18:01:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB35F14E86;
        Sun, 19 Mar 2023 15:01:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCA30611CF;
        Sun, 19 Mar 2023 22:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396ADC4339C;
        Sun, 19 Mar 2023 22:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679263255;
        bh=Y2ZZ0QRBPTa6+gDvoBKxwGRBX0o95+AmHfq1WGe72cg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NyEJQwJpkU2SMv4Y3ZZ45lRC4TFwcsj5YD9lknG7TIGUO6XHl7Tsz5bSI+MiTUkVj
         CLIkYngq4kK29V2ziLnjs/6syWGxq+b5U+Zq0OqwNgyVx22M/GMBKXltpZ+pjGAH9W
         gZtDiEsLitP9aR+nNb8lJ0kk5Kdw7vqWjGaV1Wa6EmugEersPCV/IF8uZoCnloJ2OT
         GwOkl1T42rTo4uq0GPZVgA8gnWyneA5YN4+FIZRVcxYPr9bnrk33nluhaurvCn9GEa
         q77ullFT+nmwLLP+mQ8+DUqLF1x/kNgJNyy9+TLFNiIGWc4SwzeW8WtpoVr7210dDx
         45oeEcYLogZJQ==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 09/15] mm: move pgtable_init() to mm/mm_init.c and make it static
Date:   Mon, 20 Mar 2023 00:00:02 +0200
Message-Id: <20230319220008.2138576-10-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230319220008.2138576-1-rppt@kernel.org>
References: <20230319220008.2138576-1-rppt@kernel.org>
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

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

pgtable_init() is only called from mm_core_init().

Move it close to the caller and make it static.

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 include/linux/mm.h | 6 ------
 mm/mm_init.c       | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2d7f095136fc..c3c67d8bc833 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2782,12 +2782,6 @@ static inline bool ptlock_init(struct page *page) { return true; }
 static inline void ptlock_free(struct page *page) {}
 #endif /* USE_SPLIT_PTE_PTLOCKS */
 
-static inline void pgtable_init(void)
-{
-	ptlock_cache_init();
-	pgtable_cache_init();
-}
-
 static inline bool pgtable_pte_page_ctor(struct page *page)
 {
 	if (!ptlock_init(page))
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 1da48762e4a2..a91fbb57c4cc 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2511,6 +2511,12 @@ void __init memblock_free_pages(struct page *page, unsigned long pfn,
 	__free_pages_core(page, order);
 }
 
+static void __init pgtable_init(void)
+{
+	ptlock_cache_init();
+	pgtable_cache_init();
+}
+
 /* Report memory auto-initialization states for this boot. */
 static void __init report_meminit(void)
 {
-- 
2.35.1

