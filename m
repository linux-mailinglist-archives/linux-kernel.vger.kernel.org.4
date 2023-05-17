Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0EA705D13
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 04:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjEQCVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 22:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjEQCVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 22:21:33 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17465468E
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 19:21:30 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5611211f767so2888547b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 19:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684290090; x=1686882090;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rrlZpn5lxQz0wYWidXhNS5k4qYdBDD7AOOGwfPiDsdQ=;
        b=nS7ih6tlhFuvsMZlYwq74HbaDFXcOaTcEpDv9JgzLfbOcJeYHe55FxK9/JT/+cQbri
         Mn6JAGOT1VNNKqihdxteunOmx5PruJg2/fGmmxtN3oJJTqr4S4WMMQ0nGGzH9yNCitD0
         Kqebqjin+DuMmuu1ErU226+1fL8do4fC3XsOIDYwtzvXNYfy2fVo4kDBR9Dx2K31khL6
         UbHaRwmvEWWPO7TJUQ+CmLPQ8R7iMGPQ8aPuRy4ci2qpyyMDXCg6i23WhA35RidSAMDh
         2IbzmeSuiKtMSP2SW/XYy9SByGadBaD56U2heVCkkevaE6uaQskw46S6Abvm/vT+UB+O
         0DLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684290090; x=1686882090;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rrlZpn5lxQz0wYWidXhNS5k4qYdBDD7AOOGwfPiDsdQ=;
        b=MYB5QbFGczcaptYxK/3BpkyT4YbBgDlt3dmpy6Cfxb5irAakUpuovuX51GgMn2+r+b
         2ycx1F1x9fwUN3U1bUFp7wG3XOeilE88F4pSaAdC7Kfmjp1fkWWfQZDZ5zMHWAXbPOSR
         mIgAMZ2//G+nUMw2IykR/2EBToDRYPGokILg4eWCOOx0oVJqIx4liEBaqGQKmNc6UzTw
         0LgF3ZN796DZpowfc9O34UB8Wde9Jp+6VcsaR0LXU1BW9P1WgIOA8S/mcCCd2Y1EGKRm
         zmRGakWw1DCIjfOD5F43GVL0l7aGs8MSnYD/3B4sHWgJ8a4lELwmdylhKiYc6H7x1OVs
         spPw==
X-Gm-Message-State: AC+VfDzqCx81MCvv5/h8deGnK/akP5vXKQpo6uCVLe+M3DtnxRiFgKBw
        ncwQFGVwAfk/sw8QjxUX7ygcXeQ=
X-Google-Smtp-Source: ACHHUZ7bLZybv9LVeL4X5M5xX1h96wUcd50pNUsrXoFbzJBGVtFUeHzy5iTZQluDbjMVvEYQTCD10jE=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2d3:205:b3a7:7c59:b96b:adaa])
 (user=pcc job=sendgmr) by 2002:a81:ae54:0:b0:559:f89f:bc81 with SMTP id
 g20-20020a81ae54000000b00559f89fbc81mr23166501ywk.6.1684290089941; Tue, 16
 May 2023 19:21:29 -0700 (PDT)
Date:   Tue, 16 May 2023 19:21:13 -0700
In-Reply-To: <20230517022115.3033604-1-pcc@google.com>
Message-Id: <20230517022115.3033604-4-pcc@google.com>
Mime-Version: 1.0
References: <20230517022115.3033604-1-pcc@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Subject: [PATCH v3 3/3] arm64: mte: Simplify swap tag restoration logic
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
        eugenis@google.com, Steven Price <steven.price@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Peter Collingbourne <pcc@google.com>
Link: https://linux-review.googlesource.com/id/I8ad54476f3b2d0144ccd8ce0c1d7a2963e5ff6f3
---
v3:
- Rebased onto arm64/for-next/fixes, which already has a fix
  for the issue previously tagged, therefore removed Fixes:
  tag

 arch/arm64/include/asm/mte.h     |  4 ++--
 arch/arm64/include/asm/pgtable.h | 14 ++----------
 arch/arm64/kernel/mte.c          | 37 ++++++--------------------------
 arch/arm64/mm/mteswap.c          |  7 +++---
 4 files changed, 14 insertions(+), 48 deletions(-)

diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
index c028afb1cd0b..4cedbaa16f41 100644
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
index 0bd18de9fd97..e8a252e62b12 100644
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
index 7e89968bd282..c40728046fed 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -35,41 +35,18 @@ DEFINE_STATIC_KEY_FALSE(mte_async_or_asymm_mode);
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
-	for (i = 0; i < nr_pages; i++, page++)
-		if (!page_mte_tagged(page))
-			mte_sync_page_tags(page, old_pte, check_swap,
-					   pte_is_tagged);
+	for (i = 0; i < nr_pages; i++, page++) {
+		if (try_page_mte_tagging(page)) {
+			mte_clear_page_tags(page_address(page));
+			set_page_mte_tagged(page);
+		}
+	}
 
 	/* ensure the tags are visible before the PTE is set */
 	smp_wmb();
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

