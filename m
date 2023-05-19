Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6397093E4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 11:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjESJn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 05:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjESJnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 05:43:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D00D2D79;
        Fri, 19 May 2023 02:41:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A3AF61167;
        Fri, 19 May 2023 09:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C86C433EF;
        Fri, 19 May 2023 09:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684489204;
        bh=62m/R5D6FGhqWG6KoI9PHPEn7TdMdQqLFV3wk0LBtDc=;
        h=From:To:Cc:Subject:Date:From;
        b=r5ynEHQ4VnYlo+YQjrf4A6aNXFbJk6j3c64Y7p0QM+DrWvOKJbZh68x46Tqydb38O
         MzJEmqOAOCv/UjBxt/7hYmy5B5C8xXNk+Pk4slcPAxTzm5btMMHC8Tq4NLUcW99nsw
         EHkGmjo/iZ9JE/YY1bu16vysaEMjywfEh8dG2cv4T4U7F1sYQWJ137x0R7n1LKD+ug
         5o7PlE0O4QN5ybvdtJkliLy1JQG4V3dwzKwfGg4D+x90k9W+F1nhotMLMP+WPAY/so
         mQGAkaUOWqty6IqB1mzWmq2/FnYe5i3AgFTYmLaxD46SMuJQ7Cr0Ckz7+VFoXphUWy
         fEs8pclnp2+HQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org
Subject: [PATCH] [suggestion] mm/gup: avoid IS_ERR_OR_NULL
Date:   Fri, 19 May 2023 11:39:13 +0200
Message-Id: <20230519093953.10972-1-arnd@kernel.org>
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

While looking at an unused-variable warning, I noticed a new interface coming
in that requires the use of IS_ERR_OR_NULL(), which tends to indicate bad
interface design and is usually surprising to users.

Change get_user_page_vma_remote() to return -EIO when no pages were
found and adapt the callers to match.

Fixes: eca1a00155df ("mm/gup: remove vmas parameter from get_user_pages_remote()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I see the real bug is already fixed, but this seemed worth pointing out still.
Not sure if this is the best way to handle the return types here, but the version
in linux-next doesn't look great either.
---
 arch/arm64/kernel/mte.c | 4 ++--
 include/linux/mm.h      | 2 +-
 kernel/events/uprobes.c | 5 ++++-
 mm/memory.c             | 2 +-
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index 4c5ef9b20065..6983ba35ce16 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -434,8 +434,8 @@ static int __access_remote_tags(struct mm_struct *mm, unsigned long addr,
 		struct page *page = get_user_page_vma_remote(mm, addr,
 							     gup_flags, &vma);
 
-		if (IS_ERR_OR_NULL(page)) {
-			err = page == NULL ? -EIO : PTR_ERR(page);
+		if (IS_ERR(page)) {
+			err = PTR_ERR(page);
 			break;
 		}
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 42ff3e04c006..4bb172e4818c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2397,7 +2397,7 @@ static inline struct page *get_user_page_vma_remote(struct mm_struct *mm,
 	if (got < 0)
 		return ERR_PTR(got);
 	if (got == 0)
-		return NULL;
+		return ERR_PTR(-EIO);
 
 	vma = vma_lookup(mm, addr);
 	if (WARN_ON_ONCE(!vma)) {
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index cac3aef7c6f7..9cf2d4ba760e 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -474,7 +474,10 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 		gup_flags |= FOLL_SPLIT_PMD;
 	/* Read the page with vaddr into memory */
 	old_page = get_user_page_vma_remote(mm, vaddr, gup_flags, &vma);
-	if (IS_ERR_OR_NULL(old_page))
+	if (old_page == ERR_PTR(-EIO))
+		return 0;
+
+	if (IS_ERR(old_page))
 		return PTR_ERR(old_page);
 
 	ret = verify_opcode(old_page, vaddr, &opcode);
diff --git a/mm/memory.c b/mm/memory.c
index 8358f3b853f2..f9a81278e76d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5604,7 +5604,7 @@ int __access_remote_vm(struct mm_struct *mm, unsigned long addr, void *buf,
 		struct page *page = get_user_page_vma_remote(mm, addr,
 							     gup_flags, &vma);
 
-		if (IS_ERR_OR_NULL(page)) {
+		if (IS_ERR(page)) {
 #ifndef CONFIG_HAVE_IOREMAP_PROT
 			break;
 #else
-- 
2.39.2

