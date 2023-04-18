Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538466E6B16
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 19:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbjDRRaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 13:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbjDRRaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 13:30:08 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B763D1258E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 10:30:05 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-63b54cd223dso1983542b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 10:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681839005; x=1684431005;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PlOlbguZJLrNwmoIaPL1ifiEMFL+mnPjJo6jiLeiwy0=;
        b=G9HWkOlA0TiZebZZw+BMSxSLc5r9Jiy9rx89WRkLtCGZZZ36xur97IUfA5HnEoyh9G
         KAIlk6yeNa97YBy19TiATPTOyZmAJwh07XsiZfSXhjZm6iDzKsA7vGqvXg+TXZsAdmGh
         HYn2FaRZC2EpVHyewDTC17u4mCjI5eBBhM6pdfkPqTzA2K+Xgx1W+et0dTYlBeW3C5kY
         90Zl1vjuesr2FIufXZK0VNUubN/QktlHs4WIrSDeuvkxIJfYmIexL3mG7RC6ZeTdac9i
         saJJ40b6xgvv5MOqo3xJr/NAOVxQWx+oucZsKe4rMUSkFuPX+Pl00ZYMtU4TWRsK7vRx
         /Cpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681839005; x=1684431005;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PlOlbguZJLrNwmoIaPL1ifiEMFL+mnPjJo6jiLeiwy0=;
        b=Yq4/s6Yl5GL6rUitHWSAKsgQyZERhOaIp8HOANjCCJhW64pJri4coOwT7jL4AQBG+N
         vWo0pXK8wWi7sKIBefsmhqA7SauhFr6vc6+0GnsOicSyj/N8ESp+4jFkfmfr4pRTcYGy
         2e3ZLLw+F3IDoGhMzwrH7d5cEIPOZoxS6HO2iQ2Ly2cZK5359CjNTw3zL4f1HJ0SM0ge
         yvGAlywP4I5Q0wC0l+aKSJm/n4rZ7/fpwXLK66koHOcAWYsBqU4cWivcYKFf64xmZpxT
         nf34EcBCf/C/cVU7Oz7CyDDE2TRlOgGpPOn9aps0w5bMZ5sQLQ75hUisLU3sYG49YPM2
         PMNA==
X-Gm-Message-State: AAQBX9ds1mESTNH+jIA0xbiHW0sPao6hSMGqzo1Z9JPMjJ3uEFgn/t1P
        C8o9+NywfvnQTSxqTip0h/zIF3uz
X-Google-Smtp-Source: AKy350aIAJlfwJhWzziM8p+6vuzo1W8STSemhYtD8EtCpnLuWYwtfa8K+Iydds8sLtUmL6GmTkx9cQb5
X-Received: from fvdl-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:46ab])
 (user=fvdl job=sendgmr) by 2002:a05:6a00:10cd:b0:625:66a9:c393 with SMTP id
 d13-20020a056a0010cd00b0062566a9c393mr346478pfu.0.1681839005210; Tue, 18 Apr
 2023 10:30:05 -0700 (PDT)
Date:   Tue, 18 Apr 2023 17:29:42 +0000
In-Reply-To: <e6cd1f1e-e54c-87ae-ed23-cc1eca26837c@quicinc.com>
Mime-Version: 1.0
References: <e6cd1f1e-e54c-87ae-ed23-cc1eca26837c@quicinc.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418172942.740769-1-fvdl@google.com>
Subject: Re: [PATCH V7 0/2] mm: shmem: support POSIX_FADV_[WILL|DONT]NEED for
 shmem files
From:   Frank van der Linden <fvdl@google.com>
To:     quic_charante@quicinc.com
Cc:     akpm@linux-foundation.org, hughd@google.com, willy@infradead.org,
        markhemm@googlemail.com, rientjes@google.com, surenb@google.com,
        shakeelb@google.com, quic_pkondeti@quicinc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is a quick patch to allow FADVISE_DONTNEED for shmem to reclaim
mapped pages too. This would fit our usecase, and matches MADV_PAGEOUT
more closely.

The patch series as posted skips mapped pages even if you remove
the folio_mapped() check, because page_referenced() in
shrink_page_list() will find page tables with the page mapped,
and ignore_references is not set when called from reclaim_pages().

You can make this work in a similar fashion to MADV_PAGEOUT by
first unmapping a page, but only if the mapping belongs to
the caller. You just have to change the check for "is there
only one mapping and am I the owner". To do that, change a few
lines in try_to_unmap to allow for checking the mm the mapping
belongs to, and pass in current->mm (NULL still unmaps all mappings).

I lightly tested this in a somewhat older codebase, so the diff
below isn't fully tested. But if there are no objections to
this approach, we could add it on top of your patchset after
better testing.

- Frank

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index b87d01660412..4403cc2ccc4c 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -368,6 +368,8 @@ int folio_referenced(struct folio *, int is_locked,
 
 void try_to_migrate(struct folio *folio, enum ttu_flags flags);
 void try_to_unmap(struct folio *, enum ttu_flags flags);
+void try_to_unmap_mm(struct mm_struct *mm, struct folio *folio,
+			enum ttu_flags flags);
 
 int make_device_exclusive_range(struct mm_struct *mm, unsigned long start,
 				unsigned long end, struct page **pages,
diff --git a/mm/rmap.c b/mm/rmap.c
index 8632e02661ac..4d30e8f5afe2 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1443,6 +1443,11 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
 	munlock_vma_folio(folio, vma, compound);
 }
 
+struct unmap_arg {
+	enum ttu_flags flags;
+	struct mm_struct *mm;
+};
+
 /*
  * @arg: enum ttu_flags will be passed to this argument
  */
@@ -1455,7 +1460,11 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 	struct page *subpage;
 	bool anon_exclusive, ret = true;
 	struct mmu_notifier_range range;
-	enum ttu_flags flags = (enum ttu_flags)(long)arg;
+	struct unmap_arg *uap = (struct unmap_arg *)arg;
+	enum ttu_flags flags = uap->flags;
+
+	if (uap->mm && uap->mm != mm)
+		return true;
 
 	/*
 	 * When racing against e.g. zap_pte_range() on another cpu,
@@ -1776,6 +1785,7 @@ static int folio_not_mapped(struct folio *folio)
 
 /**
  * try_to_unmap - Try to remove all page table mappings to a folio.
+ * @mm: mm to unmap from (NULL to unmap from all)
  * @folio: The folio to unmap.
  * @flags: action and flags
  *
@@ -1785,11 +1795,16 @@ static int folio_not_mapped(struct folio *folio)
  *
  * Context: Caller must hold the folio lock.
  */
-void try_to_unmap(struct folio *folio, enum ttu_flags flags)
+void try_to_unmap_mm(struct mm_struct *mm, struct folio *folio,
+		enum ttu_flags flags)
 {
+	struct unmap_arg ua = {
+		.flags = flags,
+		.mm = mm,
+	};
 	struct rmap_walk_control rwc = {
 		.rmap_one = try_to_unmap_one,
-		.arg = (void *)flags,
+		.arg = (void *)&ua,
 		.done = folio_not_mapped,
 		.anon_lock = folio_lock_anon_vma_read,
 	};
@@ -1800,6 +1815,11 @@ void try_to_unmap(struct folio *folio, enum ttu_flags flags)
 		rmap_walk(folio, &rwc);
 }
 
+void try_to_unmap(struct folio *folio, enum ttu_flags flags)
+{
+	try_to_unmap_mm(NULL, folio, flags);
+}
+
 /*
  * @arg: enum ttu_flags will be passed to this argument.
  *
diff --git a/mm/shmem.c b/mm/shmem.c
index 1af85259b6fc..b24af2fb3378 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2362,8 +2362,24 @@ static void shmem_isolate_pages_range(struct address_space *mapping, loff_t star
 
 		if (!folio_try_get(folio))
 			continue;
-		if (folio_test_unevictable(folio) || folio_mapped(folio) ||
-				folio_isolate_lru(folio)) {
+
+		if (folio_test_unevictable(folio)) {
+			folio_put(folio);
+			continue;
+		}
+
+		/*
+		 * If the folio is mapped once, try to unmap it from the
+		 * caller's page table. If it's still mapped afterwards,
+		 * it belongs to someone else, and we're not going to
+		 * change someone else's mapping.
+		 */
+		if (folio_mapcount(folio) == 1 && folio_trylock(folio)) {
+			try_to_unmap_mm(current->mm, folio, TTU_BATCH_FLUSH);
+			folio_unlock(folio);
+		}
+
+		if (folio_mapped(folio) || folio_isolate_lru(folio)) {
 			folio_put(folio);
 			continue;
 		}
@@ -2383,6 +2399,8 @@ static void shmem_isolate_pages_range(struct address_space *mapping, loff_t star
 		}
 	}
 	rcu_read_unlock();
+
+	try_to_unmap_flush();
 }
 
 static int shmem_fadvise_dontneed(struct address_space *mapping, loff_t start,
