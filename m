Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677B36A8D05
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 00:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjCBX2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 18:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjCBX2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 18:28:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C741994
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 15:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Fz4rjXU4pv+JoX8GiRxuwd31ga6ygJiOfjuBNAA23TI=; b=TFaKHOzs5zZrjEDnSHRp+DurxS
        EZpK7uL5ROEanWcdSjADz8IiT9IvqFH7WDeg96aXeb7m3m2MRMicspkiYt/i4MJb32izDxDrcXfkR
        Ds12Y4SSHzRZi2EavEPEHkitO37g6qnc2bqD93P2Sq+ov2YZdiNMiwq8LHIGSBEKfaxEzkuVTb/Li
        eyQolkb0Tm/6Zpnk/sRhTSjX8E0AO5dabHME4Z4quDrlZlNbzf2m9AK6EB8FSAvjOQwlwch64nCYm
        vap3IRDQrZhqDi0Vi31lW7yLoGiYQQ7Tck2NBz7gPOMSSu22zuLA/5dPm8V7ADT8iujNfWaqSicNC
        2GU4CIiQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXsL9-003j3K-61; Thu, 02 Mar 2023 23:27:59 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hughd@google.com, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org
Cc:     linux-mm@kvack.org, p.raghav@samsung.com, da.gomez@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net, yosryahmed@google.com,
        keescook@chromium.org, mcgrof@kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] shmem: set shmem_writepage() variables early
Date:   Thu,  2 Mar 2023 15:27:54 -0800
Message-Id: <20230302232758.888157-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230302232758.888157-1-mcgrof@kernel.org>
References: <20230302232758.888157-1-mcgrof@kernel.org>
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
mapping should not change, and the inode does not change either. So it
should be safe to set that from the very beginning.

This commit makes no functional changes.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/shmem.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 7fff1a3af092..2b9ff585a553 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1334,9 +1334,9 @@ int shmem_unuse(unsigned int type)
 static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 {
 	struct folio *folio = page_folio(page);
-	struct shmem_inode_info *info;
-	struct address_space *mapping;
-	struct inode *inode;
+	struct address_space *mapping = folio->mapping;
+	struct inode *inode = mapping->host;
+	struct shmem_inode_info *info = SHMEM_I(inode);
 	swp_entry_t swap;
 	pgoff_t index;
 
@@ -1354,10 +1354,7 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 		folio_clear_dirty(folio);
 	}
 
-	mapping = folio->mapping;
 	index = folio->index;
-	inode = mapping->host;
-	info = SHMEM_I(inode);
 	if (info->flags & VM_LOCKED)
 		goto redirty;
 	if (!total_swap_pages)
-- 
2.39.1

