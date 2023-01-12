Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DE2667266
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 13:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjALMke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 07:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjALMj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 07:39:59 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88A74C717
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 04:39:57 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id j34-20020a05600c1c2200b003da1b054057so762487wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 04:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIlme2djvGgEExw3u/UZa5uT/mD4cFx99rUFriWDSgQ=;
        b=Bj8WAYfmNP4kC2F8nv3UhSfUx5UZ90gWY74hSp4cxMWGVoIHQnh0Bo3Aef6aY83qfv
         dorhgyvnMIU6JpVga3F8+FCOQHx/uBvARy+ihQZ0C/8WV74AJPaMzUKyQMOxWObo4xvo
         yuWHhcjHALhQ/jeFg2dzzQj4pjBd/sL0+b57JLmCguGVxvc7BJU8kLBVRXYU6jzbD8NL
         pwbSJm0+gllCmV/9EGecEojyVRMShUjU5PT8WaCylGmJ9gvoU4T+QfrUR9Rl5mTF1jdq
         ETI+dso6dAkU997uRCSVMT8imMqOfh5/VSNUovnsOlDy6iQpzMcK0+DOZaMuRsXwtFZt
         7NpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIlme2djvGgEExw3u/UZa5uT/mD4cFx99rUFriWDSgQ=;
        b=4lj9D2aDbhI4fDrm8zB5VOaaWaoYVzvGkhEqigDwhNAaaoKDEnsq/WrP67HLJ9EZgB
         VlXyyLfWmmYI4rpwGoC5bWBJlMoYhkKBBvv91F5mFYGJdvCBmXDIA2QY4/bU776I1alh
         IM7sohBwncAtzlQ4xNTPdgk4AOzMCJBbqWw3l57MzD6QxK78qqKxTLmJ1DM0sdB2+dfj
         IKx9pvbUgxk9N4wEJ1Ez0EDVXrKYHKDEG+pymAASm6ecXc5iJpQWEGricBSjqclRGzTV
         mrwHq5VvoloOGxPu0ETJr8sVCufjwruY+cjnVq/gIRi8XmNbULKubjO21PYbL3PbUmF5
         AWrg==
X-Gm-Message-State: AFqh2koCAH2DTVeqg85u0l2wFMb3Dxhp+AWoi1pspiL8y7Ol1Vu1jqCV
        IwKPMFnHc4/053O4UTBk23k=
X-Google-Smtp-Source: AMrXdXsD6QZjC6CFEPGj4WDjoMUtaI4KFAhU9LRm+Y8gJ+XeTafJMWvtnaogTpLw5RcXhi33dckIGg==
X-Received: by 2002:a05:600c:1c12:b0:3d3:5841:e8af with SMTP id j18-20020a05600c1c1200b003d35841e8afmr55879654wms.25.1673527196283;
        Thu, 12 Jan 2023 04:39:56 -0800 (PST)
Received: from lucifer.home (host86-164-169-89.range86-164.btcentralplus.com. [86.164.169.89])
        by smtp.googlemail.com with ESMTPSA id q1-20020a1ce901000000b003b3307fb98fsm20890797wmc.24.2023.01.12.04.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 04:39:55 -0800 (PST)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Liam Howlett <liam.howlett@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v4 5/5] Documentation/mm: Update references to __m[un]lock_page() to *_folio()
Date:   Thu, 12 Jan 2023 12:39:32 +0000
Message-Id: <898c487169d98a7f09c1c1e57a7dfdc2b3f6bf0f.1673526881.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1673526881.git.lstoakes@gmail.com>
References: <cover.1673526881.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We now pass folios to these functions, so update the documentation
accordingly.

Additionally, correct the outdated reference to __pagevec_lru_add_fn(), the
referenced action occurs in __munlock_folio() directly now, replace reference to
lru_cache_add_inactive_or_unevictable() with the modern folio equivalent
folio_add_lru_vma() and reference folio flags by the flag name rather than
accessor.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 Documentation/mm/unevictable-lru.rst | 30 ++++++++++++++--------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/mm/unevictable-lru.rst b/Documentation/mm/unevictable-lru.rst
index 4a0e158aa9ce..2a90d0721dd9 100644
--- a/Documentation/mm/unevictable-lru.rst
+++ b/Documentation/mm/unevictable-lru.rst
@@ -308,22 +308,22 @@ do end up getting faulted into this VM_LOCKED VMA, they will be handled in the
 fault path - which is also how mlock2()'s MLOCK_ONFAULT areas are handled.
 
 For each PTE (or PMD) being faulted into a VMA, the page add rmap function
-calls mlock_vma_page(), which calls mlock_page() when the VMA is VM_LOCKED
+calls mlock_vma_page(), which calls mlock_folio() when the VMA is VM_LOCKED
 (unless it is a PTE mapping of a part of a transparent huge page).  Or when
-it is a newly allocated anonymous page, lru_cache_add_inactive_or_unevictable()
-calls mlock_new_page() instead: similar to mlock_page(), but can make better
+it is a newly allocated anonymous page, folio_add_lru_vma() calls
+mlock_new_folio() instead: similar to mlock_folio(), but can make better
 judgments, since this page is held exclusively and known not to be on LRU yet.
 
-mlock_page() sets PageMlocked immediately, then places the page on the CPU's
-mlock pagevec, to batch up the rest of the work to be done under lru_lock by
-__mlock_page().  __mlock_page() sets PageUnevictable, initializes mlock_count
+mlock_folio() sets PG_mlocked immediately, then places the page on the CPU's
+mlock folio batch, to batch up the rest of the work to be done under lru_lock by
+__mlock_folio().  __mlock_folio() sets PG_unevictable, initializes mlock_count
 and moves the page to unevictable state ("the unevictable LRU", but with
-mlock_count in place of LRU threading).  Or if the page was already PageLRU
-and PageUnevictable and PageMlocked, it simply increments the mlock_count.
+mlock_count in place of LRU threading).  Or if the page was already PG_lru
+and PG_unevictable and PG_mlocked, it simply increments the mlock_count.
 
 But in practice that may not work ideally: the page may not yet be on an LRU, or
 it may have been temporarily isolated from LRU.  In such cases the mlock_count
-field cannot be touched, but will be set to 0 later when __pagevec_lru_add_fn()
+field cannot be touched, but will be set to 0 later when __munlock_folio()
 returns the page to "LRU".  Races prohibit mlock_count from being set to 1 then:
 rather than risk stranding a page indefinitely as unevictable, always err with
 mlock_count on the low side, so that when munlocked the page will be rescued to
@@ -377,8 +377,8 @@ that it is munlock() being performed.
 
 munlock_page() uses the mlock pagevec to batch up work to be done under
 lru_lock by  __munlock_page().  __munlock_page() decrements the page's
-mlock_count, and when that reaches 0 it clears PageMlocked and clears
-PageUnevictable, moving the page from unevictable state to inactive LRU.
+mlock_count, and when that reaches 0 it clears PG_mlocked and clears
+PG_unevictable, moving the page from unevictable state to inactive LRU.
 
 But in practice that may not work ideally: the page may not yet have reached
 "the unevictable LRU", or it may have been temporarily isolated from it.  In
@@ -488,8 +488,8 @@ munlock_vma_page(), which calls munlock_page() when the VMA is VM_LOCKED
 
 munlock_page() uses the mlock pagevec to batch up work to be done under
 lru_lock by  __munlock_page().  __munlock_page() decrements the page's
-mlock_count, and when that reaches 0 it clears PageMlocked and clears
-PageUnevictable, moving the page from unevictable state to inactive LRU.
+mlock_count, and when that reaches 0 it clears PG_mlocked and clears
+PG_unevictable, moving the page from unevictable state to inactive LRU.
 
 But in practice that may not work ideally: the page may not yet have reached
 "the unevictable LRU", or it may have been temporarily isolated from it.  In
@@ -515,7 +515,7 @@ munlocking by clearing VM_LOCKED from a VMA, before munlocking all the pages
 present, if one of those pages were unmapped by truncation or hole punch before
 mlock_pte_range() reached it, it would not be recognized as mlocked by this VMA,
 and would not be counted out of mlock_count.  In this rare case, a page may
-still appear as PageMlocked after it has been fully unmapped: and it is left to
+still appear as PG_mlocked after it has been fully unmapped: and it is left to
 release_pages() (or __page_cache_release()) to clear it and update statistics
 before freeing (this event is counted in /proc/vmstat unevictable_pgs_cleared,
 which is usually 0).
@@ -527,7 +527,7 @@ Page Reclaim in shrink_*_list()
 vmscan's shrink_active_list() culls any obviously unevictable pages -
 i.e. !page_evictable(page) pages - diverting those to the unevictable list.
 However, shrink_active_list() only sees unevictable pages that made it onto the
-active/inactive LRU lists.  Note that these pages do not have PageUnevictable
+active/inactive LRU lists.  Note that these pages do not have PG_unevictable
 set - otherwise they would be on the unevictable list and shrink_active_list()
 would never see them.
 
-- 
2.39.0

