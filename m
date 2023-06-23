Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1156473BCD3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 18:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjFWQkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 12:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbjFWQk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 12:40:27 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8881A1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 09:40:22 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-260a18f1b43so403715a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 09:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687538422; x=1690130422;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Im1IN1ikrfOM9Z5Ok/IoUeSFmmXZyMPCiNwLLRYtHmQ=;
        b=G/oR7IPVEFTa1GT55h/HZHzutGu3XFeJ0x7CMVx0sQ3+iu4UkSa6QKG8Axe8YoI6ut
         f73cf7IUkzK073BhTuK3KODwM+XdHg/4/r/ugKvr2NDUxM1pyepVAp2riS8MYC6p3ycL
         A2dFBf9Sto7NcNpOUMSK12m/QRbu0JbpEfwyv6/fMSIQ4op5bwAMFK4VNKbcf1YjRgCy
         bsnc7/zKLPO4xteCLLsHZLJ9ZqQdRAZ//cIsnb9+r6XJ40mlk9+1lH8fixAisniBj3qi
         u3V4W4Qj6vOZ7nmsGBXnq6l/L9udH1IJeP0i8d2d/6/8vmobg24T5d8qWWXJVpt8zltv
         ipQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687538422; x=1690130422;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Im1IN1ikrfOM9Z5Ok/IoUeSFmmXZyMPCiNwLLRYtHmQ=;
        b=IPgx5pexTdFdCtpPVPCoBpA+G+8ChvGBTYOEm/UfzJA13rRynGJLxtXPLd7N4mJWWw
         HJGew79ONcPL/rDpnOEjzVIYfJtTslWVBrRLC1yM3EQVuvfsRespQTmKmVfvZ/PkAsMR
         rxl7jmBDEY2phCWHpO0Adf96R4Jz4tCUXLlC+kc1OEjExit926GRkOVf/oX3xnmbBq3i
         wERTXlXbdIgfwZ8rsIkA54N8pCPtnH9wtKndUAJiURETBNEi4xA/wmHPLwOZKdY624kG
         t0TD7qt3RDmQ++cRT8BBbBVAhzhtFOJp2t8Yw94RubuIncuXjgW8+fyH0RVc1VZ393p7
         4HDw==
X-Gm-Message-State: AC+VfDxjnOD3G9LmGOOSdsiLZNNwoAU3Ifj3vJm4ltb2LKz6GfXZHsxd
        o+qaww7lajJoavQ/bmt4oNNfcTzt8ZS4jQ==
X-Google-Smtp-Source: ACHHUZ7C66BEaKbQBmvL2pZjnqc3R82KIAB0G9Tt/kvXK5rICRDXs/YcwnK1MlTu5X6j4+3CatJBx/dm8KHUHQ==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a17:90a:bc8e:b0:25b:d596:fd30 with SMTP
 id x14-20020a17090abc8e00b0025bd596fd30mr3104900pjr.1.1687538421988; Fri, 23
 Jun 2023 09:40:21 -0700 (PDT)
Date:   Fri, 23 Jun 2023 16:40:13 +0000
In-Reply-To: <20230623164015.3431990-1-jiaqiyan@google.com>
Mime-Version: 1.0
References: <20230623164015.3431990-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230623164015.3431990-3-jiaqiyan@google.com>
Subject: [PATCH v2 2/4] mm/hwpoison: check if a subpage of a hugetlb folio is
 raw HWPOISON
From:   Jiaqi Yan <jiaqiyan@google.com>
To:     mike.kravetz@oracle.com, naoya.horiguchi@nec.com
Cc:     songmuchun@bytedance.com, shy828301@gmail.com,
        linmiaohe@huawei.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duenwen@google.com, axelrasmussen@google.com,
        jthoughton@google.com, Jiaqi Yan <jiaqiyan@google.com>
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

Adds the functionality to tell if a subpage of a hugetlb folio is a
raw HWPOISON page. This functionality relies on RawHwpUnreliable to
be not set; otherwise hugepage's HWPOISON list becomes meaningless.

Exports this functionality to be immediately used in the read operation
for hugetlbfs.

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 include/linux/hugetlb.h | 19 +++++++++++++++++++
 include/linux/mm.h      |  7 +++++++
 mm/hugetlb.c            | 10 ++++++++++
 mm/memory-failure.c     | 34 ++++++++++++++++++++++++----------
 4 files changed, 60 insertions(+), 10 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 21f942025fec..8b73a12b7b38 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1013,6 +1013,25 @@ void hugetlb_register_node(struct node *node);
 void hugetlb_unregister_node(struct node *node);
 #endif
 
+/*
+ * Struct raw_hwp_page represents information about "raw error page",
+ * constructing singly linked list from ->_hugetlb_hwpoison field of folio.
+ */
+struct raw_hwp_page {
+	struct llist_node node;
+	struct page *page;
+};
+
+static inline struct llist_head *raw_hwp_list_head(struct folio *folio)
+{
+	return (struct llist_head *)&folio->_hugetlb_hwpoison;
+}
+
+/*
+ * Check if a given raw @subpage in a hugepage @folio is HWPOISON.
+ */
+bool is_raw_hwp_subpage(struct folio *folio, struct page *subpage);
+
 #else	/* CONFIG_HUGETLB_PAGE */
 struct hstate {};
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 66032f0d515c..41a283bd41a7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3671,6 +3671,7 @@ extern const struct attribute_group memory_failure_attr_group;
 extern void memory_failure_queue(unsigned long pfn, int flags);
 extern int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 					bool *migratable_cleared);
+extern bool __is_raw_hwp_subpage(struct folio *folio, struct page *subpage);
 void num_poisoned_pages_inc(unsigned long pfn);
 void num_poisoned_pages_sub(unsigned long pfn, long i);
 struct task_struct *task_early_kill(struct task_struct *tsk, int force_early);
@@ -3685,6 +3686,12 @@ static inline int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 	return 0;
 }
 
+static inline bool __is_raw_hwp_subpage(struct folio *folio,
+					struct page *subpage)
+{
+	return false;
+}
+
 static inline void num_poisoned_pages_inc(unsigned long pfn)
 {
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ea24718db4af..6b860de87590 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7377,6 +7377,16 @@ int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 	return ret;
 }
 
+bool is_raw_hwp_subpage(struct folio *folio, struct page *subpage)
+{
+	bool ret;
+
+	spin_lock_irq(&hugetlb_lock);
+	ret = __is_raw_hwp_subpage(folio, subpage);
+	spin_unlock_irq(&hugetlb_lock);
+	return ret;
+}
+
 void folio_putback_active_hugetlb(struct folio *folio)
 {
 	spin_lock_irq(&hugetlb_lock);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index c415c3c462a3..891248e2930e 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1809,18 +1809,32 @@ EXPORT_SYMBOL_GPL(mf_dax_kill_procs);
 #endif /* CONFIG_FS_DAX */
 
 #ifdef CONFIG_HUGETLB_PAGE
-/*
- * Struct raw_hwp_page represents information about "raw error page",
- * constructing singly linked list from ->_hugetlb_hwpoison field of folio.
- */
-struct raw_hwp_page {
-	struct llist_node node;
-	struct page *page;
-};
 
-static inline struct llist_head *raw_hwp_list_head(struct folio *folio)
+bool __is_raw_hwp_subpage(struct folio *folio, struct page *subpage)
 {
-	return (struct llist_head *)&folio->_hugetlb_hwpoison;
+	struct llist_head *raw_hwp_head;
+	struct raw_hwp_page *p, *tmp;
+	bool ret = false;
+
+	if (!folio_test_hwpoison(folio))
+		return false;
+
+	/*
+	 * When RawHwpUnreliable is set, kernel lost track of which subpages
+	 * are HWPOISON. So return as if ALL subpages are HWPOISONed.
+	 */
+	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
+		return true;
+
+	raw_hwp_head = raw_hwp_list_head(folio);
+	llist_for_each_entry_safe(p, tmp, raw_hwp_head->first, node) {
+		if (subpage == p->page) {
+			ret = true;
+			break;
+		}
+	}
+
+	return ret;
 }
 
 static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
-- 
2.41.0.162.gfafddb0af9-goog

