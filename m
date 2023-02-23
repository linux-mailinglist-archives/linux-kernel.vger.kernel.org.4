Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2296A0149
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 03:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjBWCon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 21:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbjBWCo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 21:44:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521C726586
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 18:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=kiZfMZIUImYTT26kimjDxbkl+uiLHr4foE9jVeUonNw=; b=sn2iEaZxSxcZjr+lLEI+B9ZNfD
        ag2rd1ZA2IdkPMeYOuIbwUEge8ajYxG0X3vo+WuNHeE+62APWJEO/TQ+BEwvXPPTKO08otnIXs5Yn
        H5l53U6iDGmiMIOfWkieSJ1WN0Q/joKc8yr4grfgcI+SPDH7VlzINQV7egc10DDUTWILqPocCSj1o
        XDf9ihIRyG8DyPLMC9rit2JBlfpauaPYiOzpZfEAHTt+yslONZY1xDy5BC4wiV6lsokBvqZVjPYU9
        M/s2WFxV74jDhTSMO3eHfu513os/QCbn/WTrt9tXhV/ao06RvY6cmntgbABP0/E6sLUKQ8wKo25Fz
        rCFNadYA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pV1ah-00EmNE-A6; Thu, 23 Feb 2023 02:44:15 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hughd@google.com, akpm@linux-foundation.org, willy@infradead.org
Cc:     linux-mm@kvack.org, p.raghav@samsung.com, dave@stgolabs.net,
        a.manzanares@samsung.com, yosryahmed@google.com, mcgrof@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC v2 4/5] shmem: skip page split if we're not reclaiming
Date:   Wed, 22 Feb 2023 18:44:11 -0800
Message-Id: <20230223024412.3522465-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230223024412.3522465-1-mcgrof@kernel.org>
References: <20230223024412.3522465-1-mcgrof@kernel.org>
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

In theory when info->flags & VM_LOCKED we should not be getting
shem_writepage() called so we should be verifying this with a
WARN_ON_ONCE(). Since we should not be swapping then best to ensure
we also don't do the folio split earlier too. So just move the check
early to avoid folio splits in case its a dubious call.

We also have a similar early bail when !total_swap_pages so just move
that earlier to avoid the possible folio split in the same situation.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/shmem.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 626eb1a0856c..a49b31d38627 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1349,6 +1349,12 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 		goto redirty;
 	}
 
+	if (WARN_ON_ONCE(info->flags & VM_LOCKED))
+		goto redirty;
+
+	if (!total_swap_pages)
+		goto redirty;
+
 	/*
 	 * If /sys/kernel/mm/transparent_hugepage/shmem_enabled is "always" or
 	 * "force", drivers/gpu/drm/i915/gem/i915_gem_shmem.c gets huge pages,
@@ -1364,10 +1370,6 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 	}
 
 	index = folio->index;
-	if (info->flags & VM_LOCKED)
-		goto redirty;
-	if (!total_swap_pages)
-		goto redirty;
 
 	/*
 	 * This is somewhat ridiculous, but without plumbing a SWAP_MAP_FALLOC
-- 
2.39.1

