Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F2D6A0145
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 03:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjBWCob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 21:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbjBWCo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 21:44:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9540E279BF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 18:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=vQjHgoe5Jm+n0b1ADMVciA5nvYNCQKcIEIUc76XY5yA=; b=nobDFyPW1FDWru83lnPC9EwGl6
        R/FHdKwibKNjX3q9wvjpliuLql+NoQ9c0rhOKA0yrjL0c2fVAZ8p5RDkCW6T/uLryGWU6LLvIkYK3
        H8ZiDSzxHfM1HiVyVJJIIX+A6Fs2dWqSFF4Mm8kGPxhMBXeV+81ZHgNBeGyY6UUKuDDPhMnjqGLO5
        TABWOhP+CZw4oNP8VfJdPVbrNk70Mb5neyvgQ6W/IecffA3e/SrfwO1okz2f1jrhReSmm+2oITWqW
        LBsLcoG8bQlb1BH852kJkU4dTTBSJiFZIiW9Bx4gy3pLT+qeSzmlOw0EHq2ID8LlnX29yOscwqVJd
        SxirXIAw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pV1ah-00EmNC-8r; Thu, 23 Feb 2023 02:44:15 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hughd@google.com, akpm@linux-foundation.org, willy@infradead.org
Cc:     linux-mm@kvack.org, p.raghav@samsung.com, dave@stgolabs.net,
        a.manzanares@samsung.com, yosryahmed@google.com, mcgrof@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC v2 3/5] shmem: move reclaim check early on writepages()
Date:   Wed, 22 Feb 2023 18:44:10 -0800
Message-Id: <20230223024412.3522465-4-mcgrof@kernel.org>
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

i915_gem requires huge folios to be split when swapping.
However we have  check for usage of writepages() to ensure
it used only for swap purposes later. Avoid the splits if
we're not being called for reclaim, even if they should in
theory not happen.

This makes the conditions easier to follow on shem_writepage().

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/shmem.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 1269482d0a5c..626eb1a0856c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1337,6 +1337,18 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 	swp_entry_t swap;
 	pgoff_t index;
 
+	/*
+	 * Our capabilities prevent regular writeback or sync from ever calling
+	 * shmem_writepage; but a stacking filesystem might use ->writepage of
+	 * its underlying filesystem, in which case tmpfs should write out to
+	 * swap only in response to memory pressure, and not for the writeback
+	 * threads or sync.
+	 */
+	if (!wbc->for_reclaim) {
+		WARN_ON_ONCE(1);	/* Still happens? Tell us about it! */
+		goto redirty;
+	}
+
 	/*
 	 * If /sys/kernel/mm/transparent_hugepage/shmem_enabled is "always" or
 	 * "force", drivers/gpu/drm/i915/gem/i915_gem_shmem.c gets huge pages,
@@ -1357,18 +1369,6 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 	if (!total_swap_pages)
 		goto redirty;
 
-	/*
-	 * Our capabilities prevent regular writeback or sync from ever calling
-	 * shmem_writepage; but a stacking filesystem might use ->writepage of
-	 * its underlying filesystem, in which case tmpfs should write out to
-	 * swap only in response to memory pressure, and not for the writeback
-	 * threads or sync.
-	 */
-	if (!wbc->for_reclaim) {
-		WARN_ON_ONCE(1);	/* Still happens? Tell us about it! */
-		goto redirty;
-	}
-
 	/*
 	 * This is somewhat ridiculous, but without plumbing a SWAP_MAP_FALLOC
 	 * value into swapfile.c, the only way we can correctly account for a
-- 
2.39.1

