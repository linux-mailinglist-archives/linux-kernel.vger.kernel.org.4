Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6B168CCDE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 03:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjBGCxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 21:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjBGCxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 21:53:12 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59D5468B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 18:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ppc+iA/4jLT/kyK/2EkWiSyEAfiza0foS2nW0M1ktaU=; b=Hyly4Ctgcl2ybcZ9Uf6YVJBbZj
        d8rXp8MTOtkLsYo89C6303qGny+ZLJ8X1/OlyBMSZJiK5eMMDXxjvBmjonKGnjQ60/1hfMX6pbfg8
        yiKR4m6fBQf9AmmC/PJ3Sfm6BxquDZdjRcVWMEhdS6CAi2O3XaUWdAA1WK4305EBn7wctnsiPwLLc
        HlI1EXwYA1U1BLrsam0jMtbVPygKbeNK0X1ap6NHxElHw5Vshw6660O0DRiXF2lpD7cUTvkaqNDg+
        fFL17wN/1bPIrceXZHl+j0O+JrhHxGb7P5oTJxapL85uPnZY8Kw3vxY2kKsojLU/jZ8kPUpN88pMo
        SMb57LLQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPE6S-00AaIb-SN; Tue, 07 Feb 2023 02:53:04 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hughd@google.com, akpm@linux-foundation.org, willy@infradead.org
Cc:     linux-mm@kvack.org, p.raghav@samsung.com, dave@stgolabs.net,
        a.manzanares@samsung.com, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC 1/2] shmem: set shmem_writepage() variables early
Date:   Mon,  6 Feb 2023 18:52:58 -0800
Message-Id: <20230207025259.2522793-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230207025259.2522793-1-mcgrof@kernel.org>
References: <20230207025259.2522793-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

shmem_writepage() sets up variables typically used *after* a possible
huge page split. However even if that does happen the address space
mapping should not change. So it should be safe to set that from
the beginning.

The folio should always be locked from the start as well. It however
was not clear if the folio address can / should change, as well as
the first inode.

This commit makes no functional changes other a double check on the
folio locking which might be superflous. This change should help make
the subsequent patch easier to review.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/shmem.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 28f3c699c8ce..a2c6aa11aab8 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1332,11 +1332,13 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 {
 	struct folio *folio = page_folio(page);
 	struct shmem_inode_info *info;
-	struct address_space *mapping;
-	struct inode *inode;
+	struct address_space *mapping = folio->mapping;
+	struct inode *inode = mapping->host;
 	swp_entry_t swap;
 	pgoff_t index;
 
+	BUG_ON(!folio_test_locked(folio));
+
 	/*
 	 * If /sys/kernel/mm/transparent_hugepage/shmem_enabled is "always" or
 	 * "force", drivers/gpu/drm/i915/gem/i915_gem_shmem.c gets huge pages,
@@ -1351,8 +1353,8 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 		folio_clear_dirty(folio);
 	}
 
+	/* Can the folio or first inode change on after a split? */
 	BUG_ON(!folio_test_locked(folio));
-	mapping = folio->mapping;
 	index = folio->index;
 	inode = mapping->host;
 	info = SHMEM_I(inode);
-- 
2.39.0

