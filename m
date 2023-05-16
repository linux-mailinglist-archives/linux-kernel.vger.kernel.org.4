Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC45704378
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 04:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjEPCfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 22:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjEPCf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 22:35:27 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFB85FF0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 19:35:25 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a75194eebso16845538276.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 19:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684204525; x=1686796525;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PFB1dkpGULUqWzGVGpWTfZD/wGkLnLUL2yYSj9UHJe8=;
        b=vKfIPmvXwnD0w7nKCyGYrqfY1+bvNHFzXFFqCB1zgx7Ey+JHvhLlTX1gixZuKdcpXU
         tiT5mMmzC+UGiH/Q00Zml7jrN0hEnCMHjQ8uXyM/k+i9GzNcZCf3vs79dfYH0Yamrfd3
         Cy1rlI9uSYMq+wvjBv5hMjQokz3Xl2kHys6gOXr3jNSdure6QZBkSzK93IkNCjmZ9U1y
         823lY14YjWLv5PCGqNrkuuZ/KPqLnX7mUm8TGj9U47m2Z8fOztmpQXhjmlTH/LDAmpDw
         jxUWGL7K2en3kCoXjKvsdWJDnfKprcI2/EKvKrie44kXLalA4JR6xQQFh8fAPBGeqBw6
         JkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684204525; x=1686796525;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PFB1dkpGULUqWzGVGpWTfZD/wGkLnLUL2yYSj9UHJe8=;
        b=bmCvKxCE1BVHNOXTM4WXUIZAW1gNblEQ4sn5aFoFmZLCpvzltnNhOrkitH3eW9SgFw
         esjGQ/LiIrO2nLfZ+YwmMcKDaPpUuTfkSPiSanx5jHgGVBfUwC7IXBdo5d3beo3SEpUs
         gnFVmaovv6NWNFbDDAUdekPRD0TTJLHcwW/EJMlDrJOcHICKvgnd4Rhy36oeHD0SJfwV
         sIUGE+idKkQn5DK+OSXL6kbn/NmCENOny+emze3ZK2PAWK9T8qoCqsLHyRyhqVj6LQDy
         IsI14IcjXXWpKJpKeH1dF1YEb1/Fot6nsIbK3KY5ta8wkQeQwB0wOkFhi2fdEwbvqzPP
         h6Ww==
X-Gm-Message-State: AC+VfDzfQweENr8OUg1qbERXCTO0w2nskGjn0dw4FBpkwhJRMVbnjv7I
        bG+yYsr5Y6tFUf6n1tzVYolvFpY=
X-Google-Smtp-Source: ACHHUZ5CfBJqKCPcdGvyED5Wc7zjHX1ZbzPa4swaTK2n5p8NxRfX+/XBk45of4pSm71BST0vk+9zGIY=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2d3:205:c825:9c0b:b4be:8ee4])
 (user=pcc job=sendgmr) by 2002:a25:dc43:0:b0:ba1:6f1b:8905 with SMTP id
 y64-20020a25dc43000000b00ba16f1b8905mr21936003ybe.4.1684204525241; Mon, 15
 May 2023 19:35:25 -0700 (PDT)
Date:   Mon, 15 May 2023 19:35:13 -0700
In-Reply-To: <20230516023514.2643054-1-pcc@google.com>
Message-Id: <20230516023514.2643054-3-pcc@google.com>
Mime-Version: 1.0
References: <20230516023514.2643054-1-pcc@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Subject: [PATCH v2 2/2] arm64: mte: Simplify swap tag restoration logic and
 fix uninitialized tag issue
From:   Peter Collingbourne <pcc@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        "=?UTF-8?q?Qun-wei=20Lin=20=28=E6=9E=97=E7=BE=A4=E5=B4=B4=29?=" 
        <Qun-wei.Lin@mediatek.com>, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "surenb@google.com" <surenb@google.com>,
        "david@redhat.com" <david@redhat.com>,
        "=?UTF-8?q?Chinwen=20Chang=20=28=E5=BC=B5=E9=8C=A6=E6=96=87=29?=" 
        <chinwen.chang@mediatek.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "=?UTF-8?q?Kuan-Ying=20Lee=20=28=E6=9D=8E=E5=86=A0=E7=A9=8E=29?=" 
        <Kuan-Ying.Lee@mediatek.com>,
        "=?UTF-8?q?Casper=20Li=20=28=E6=9D=8E=E4=B8=AD=E6=A6=AE=29?=" 
        <casper.li@mediatek.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        vincenzo.frascino@arm.com,
        Alexandru Elisei <alexandru.elisei@arm.com>, will@kernel.org,
        eugenis@google.com, Steven Price <steven.price@arm.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a result of the previous two patches, there are no circumstances
in which a swapped-in page is installed in a page table without first
having arch_swap_restore() called on it. Therefore, we no longer need
the logic in set_pte_at() that restores the tags, so remove it.

Because we can now rely on the page being locked, we no longer need to
handle the case where a page is having its tags restored by multiple tasks
concurrently, so we can slightly simplify the logic in mte_restore_tags().

This patch also fixes an issue where a page can have PG_mte_tagged set
with uninitialized tags. The issue is that the mte_sync_page_tags()
function sets PG_mte_tagged if it initializes page tags. Then we
return to mte_sync_tags(), which sets PG_mte_tagged again. At best,
this is redundant. However, it is possible for mte_sync_page_tags()
to return without having initialized tags for the page, i.e. in the
case where check_swap is true (non-compound page), is_swap_pte(old_pte)
is false and pte_is_tagged is false. So at worst, we set PG_mte_tagged
on a page with uninitialized tags. This can happen if, for example,
page migration causes a PTE for an untagged page to be replaced. If the
userspace program subsequently uses mprotect() to enable PROT_MTE for
that page, the uninitialized tags will be exposed to userspace.

Signed-off-by: Peter Collingbourne <pcc@google.com>
Link: https://linux-review.googlesource.com/id/I8ad54476f3b2d0144ccd8ce0c1d7a2963e5ff6f3
Fixes: e059853d14ca ("arm64: mte: Fix/clarify the PG_mte_tagged semantics")
Cc: <stable@vger.kernel.org> # 6.1
---
The Fixes: tag (and the commit message in general) are written assuming
that this patch is landed in a maintainer tree instead of
"arm64: mte: Do not set PG_mte_tagged if tags were not initialized".

 arch/arm64/include/asm/mte.h     |  4 ++--
 arch/arm64/include/asm/pgtable.h | 14 ++------------
 arch/arm64/kernel/mte.c          | 32 +++-----------------------------
 arch/arm64/mm/mteswap.c          |  7 +++----
 4 files changed, 10 insertions(+), 47 deletions(-)

diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
index 20dd06d70af5..dfea486a6a85 100644
--- a/arch/arm64/include/asm/mte.h
+++ b/arch/arm64/include/asm/mte.h
@@ -90,7 +90,7 @@ static inline bool try_page_mte_tagging(struct page *page)
 }
 
 void mte_zero_clear_page_tags(void *addr);
-void mte_sync_tags(pte_t old_pte, pte_t pte);
+void mte_sync_tags(pte_t pte);
 void mte_copy_page_tags(void *kto, const void *kfrom);
 void mte_thread_init_user(void);
 void mte_thread_switch(struct task_struct *next);
@@ -122,7 +122,7 @@ static inline bool try_page_mte_tagging(struct page *page)
 static inline void mte_zero_clear_page_tags(void *addr)
 {
 }
-static inline void mte_sync_tags(pte_t old_pte, pte_t pte)
+static inline void mte_sync_tags(pte_t pte)
 {
 }
 static inline void mte_copy_page_tags(void *kto, const void *kfrom)
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index b6ba466e2e8a..efdf48392026 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -337,18 +337,8 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 	 * don't expose tags (instruction fetches don't check tags).
 	 */
 	if (system_supports_mte() && pte_access_permitted(pte, false) &&
-	    !pte_special(pte)) {
-		pte_t old_pte = READ_ONCE(*ptep);
-		/*
-		 * We only need to synchronise if the new PTE has tags enabled
-		 * or if swapping in (in which case another mapping may have
-		 * set tags in the past even if this PTE isn't tagged).
-		 * (!pte_none() && !pte_present()) is an open coded version of
-		 * is_swap_pte()
-		 */
-		if (pte_tagged(pte) || (!pte_none(old_pte) && !pte_present(old_pte)))
-			mte_sync_tags(old_pte, pte);
-	}
+	    !pte_special(pte) && pte_tagged(pte))
+		mte_sync_tags(pte);
 
 	__check_safe_pte_update(mm, ptep, pte);
 
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index f5bcb0dc6267..c40728046fed 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -35,41 +35,15 @@ DEFINE_STATIC_KEY_FALSE(mte_async_or_asymm_mode);
 EXPORT_SYMBOL_GPL(mte_async_or_asymm_mode);
 #endif
 
-static void mte_sync_page_tags(struct page *page, pte_t old_pte,
-			       bool check_swap, bool pte_is_tagged)
-{
-	if (check_swap && is_swap_pte(old_pte)) {
-		swp_entry_t entry = pte_to_swp_entry(old_pte);
-
-		if (!non_swap_entry(entry))
-			mte_restore_tags(entry, page);
-	}
-
-	if (!pte_is_tagged)
-		return;
-
-	if (try_page_mte_tagging(page)) {
-		mte_clear_page_tags(page_address(page));
-		set_page_mte_tagged(page);
-	}
-}
-
-void mte_sync_tags(pte_t old_pte, pte_t pte)
+void mte_sync_tags(pte_t pte)
 {
 	struct page *page = pte_page(pte);
 	long i, nr_pages = compound_nr(page);
-	bool check_swap = nr_pages == 1;
-	bool pte_is_tagged = pte_tagged(pte);
-
-	/* Early out if there's nothing to do */
-	if (!check_swap && !pte_is_tagged)
-		return;
 
 	/* if PG_mte_tagged is set, tags have already been initialised */
 	for (i = 0; i < nr_pages; i++, page++) {
-		if (!page_mte_tagged(page)) {
-			mte_sync_page_tags(page, old_pte, check_swap,
-					   pte_is_tagged);
+		if (try_page_mte_tagging(page)) {
+			mte_clear_page_tags(page_address(page));
 			set_page_mte_tagged(page);
 		}
 	}
diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
index cd508ba80ab1..3a78bf1b1364 100644
--- a/arch/arm64/mm/mteswap.c
+++ b/arch/arm64/mm/mteswap.c
@@ -53,10 +53,9 @@ void mte_restore_tags(swp_entry_t entry, struct page *page)
 	if (!tags)
 		return;
 
-	if (try_page_mte_tagging(page)) {
-		mte_restore_page_tags(page_address(page), tags);
-		set_page_mte_tagged(page);
-	}
+	WARN_ON_ONCE(!try_page_mte_tagging(page));
+	mte_restore_page_tags(page_address(page), tags);
+	set_page_mte_tagged(page);
 }
 
 void mte_invalidate_tags(int type, pgoff_t offset)
-- 
2.40.1.606.ga4b1b128d6-goog

