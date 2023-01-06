Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190D76601A5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 14:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbjAFN7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 08:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbjAFN7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 08:59:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6303E77AD5
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 05:59:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0769AB81D3F
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 13:59:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151EAC433D2;
        Fri,  6 Jan 2023 13:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673013547;
        bh=Ux2bGedOxwHk3RH/wvtMaN/mA8enbpkQkw8iBZv2Syc=;
        h=From:To:Cc:Subject:Date:From;
        b=rZRmravGDjgIHGpYL8H7+iEcV5MbvuOEMVon3TIbVyQdGYrjkyfitTusw3i5P/pYq
         5EXS5M8Cra/DzmogFy1KyMXXcJVBInmRlXo/dKzzPZW4VKM1WhZQufzGlquu+UpmpF
         cZSlhUp8T47AG01ihx6U8KHw+OonIeNWhalcF//o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     akpm@linux-foundation.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: remove PageMovable export
Date:   Fri,  6 Jan 2023 14:59:00 +0100
Message-Id: <20230106135900.3763622-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2872; i=gregkh@linuxfoundation.org; h=from:subject; bh=Ux2bGedOxwHk3RH/wvtMaN/mA8enbpkQkw8iBZv2Syc=; b=owGbwMvMwCRo6H6F97bub03G02pJDMk7NBV3puwRKTlU9ZFV8I3M5hc52yXLBdtjqqPWJPw+E/X+ 3rPUjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZiI8AqGBUsvKC3VEFp1pHTt7RlJiX MF+r8JrWSYK+LiPrMu3mKtyiPdF3OUcz0f5BizAwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only in-kernel users that need PageMovable() to be exported are
z3fold and zsmalloc and they are only using it for dubious debugging
functionality.  So remove those usages and the export so that no driver
code accidentally thinks that they are allowed to use this symbol.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vitaly Wool <vitaly.wool@konsulko.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/compaction.c | 1 -
 mm/z3fold.c     | 2 --
 mm/zsmalloc.c   | 3 ---
 3 files changed, 6 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index ca1603524bbe..62a61de44658 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -122,7 +122,6 @@ bool PageMovable(struct page *page)
 
 	return false;
 }
-EXPORT_SYMBOL(PageMovable);
 
 void __SetPageMovable(struct page *page, const struct movable_operations *mops)
 {
diff --git a/mm/z3fold.c b/mm/z3fold.c
index a4de0c317ac7..0cef845d397b 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -1450,7 +1450,6 @@ static bool z3fold_page_isolate(struct page *page, isolate_mode_t mode)
 	struct z3fold_header *zhdr;
 	struct z3fold_pool *pool;
 
-	VM_BUG_ON_PAGE(!PageMovable(page), page);
 	VM_BUG_ON_PAGE(PageIsolated(page), page);
 
 	if (test_bit(PAGE_HEADLESS, &page->private))
@@ -1490,7 +1489,6 @@ static int z3fold_page_migrate(struct page *newpage, struct page *page,
 	struct z3fold_header *zhdr, *new_zhdr;
 	struct z3fold_pool *pool;
 
-	VM_BUG_ON_PAGE(!PageMovable(page), page);
 	VM_BUG_ON_PAGE(!PageIsolated(page), page);
 	VM_BUG_ON_PAGE(!test_bit(PAGE_CLAIMED, &page->private), page);
 	VM_BUG_ON_PAGE(!PageLocked(newpage), newpage);
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 9445bee6b014..6aafacd664fc 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1973,7 +1973,6 @@ static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
 	 * Page is locked so zspage couldn't be destroyed. For detail, look at
 	 * lock_zspage in free_zspage.
 	 */
-	VM_BUG_ON_PAGE(!PageMovable(page), page);
 	VM_BUG_ON_PAGE(PageIsolated(page), page);
 
 	zspage = get_zspage(page);
@@ -2005,7 +2004,6 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	if (mode == MIGRATE_SYNC_NO_COPY)
 		return -EINVAL;
 
-	VM_BUG_ON_PAGE(!PageMovable(page), page);
 	VM_BUG_ON_PAGE(!PageIsolated(page), page);
 
 	/* The page is locked, so this pointer must remain valid */
@@ -2070,7 +2068,6 @@ static void zs_page_putback(struct page *page)
 {
 	struct zspage *zspage;
 
-	VM_BUG_ON_PAGE(!PageMovable(page), page);
 	VM_BUG_ON_PAGE(!PageIsolated(page), page);
 
 	zspage = get_zspage(page);
-- 
2.39.0

