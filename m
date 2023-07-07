Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675B874B7C6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 22:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbjGGUT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 16:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbjGGUTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 16:19:22 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DB52126
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 13:19:18 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-55b2c66d713so3346115a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 13:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688761158; x=1691353158;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lhHFjAXtuMYeiDPTb9enUa1sagPmUht2lF56qHA5nAY=;
        b=Lm821Q9A8z9/jwUhSfYSBmBg3a1CJgB8uC9S29RR8iamr7rpAYSfO0Eeq787JeWICj
         aSBaqXte1TU+6+8Sh0EwU0DomQ2dskj2yaXJhdXbMBNjJ8QUuqx8PFueYsGG0LTCGMQM
         AG5oIBFVs6KD00JEaeesIKk4hiB7jSUeRJ5U9ZVeA4Xg20DZQrowBV2mwu3oDdpyaXg2
         VSPJ+oq7NOFgZNlDG3dULstPjbk7FgX8TBv4efKwHSj4dG2SHkzR24FKkM89NmGdxa+V
         ORZx2FMfNdL9uzR1qedaRjJLe7tuSJorO9cCwuwQmen2ZaI5XXih1iy8y9odfFxhoErc
         4nvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688761158; x=1691353158;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lhHFjAXtuMYeiDPTb9enUa1sagPmUht2lF56qHA5nAY=;
        b=OQtSlw81L/X+Cft54edpqtYZzn3QBJ3yuyRk/rQ2bjQdEkJDi9UMNOX727vcZ6nkIE
         eptZ2Pz77edVoNmPdJNp4C6nytOp8ejqofkCtajlVTF2STMm+HgGW4gVIRVA5KQYeZQt
         s1akhcl3olJvd0Ccfz2UoRTbmaNbjMsJ2j9Lpap0NUQVW3vD422rne0ulZ5Z5QaqN7Cg
         chJpFAt5HebKq/otse+w2ChXO2KhQ7UZxj6kX20nCgIwbzkgFbC7fE1+ICCdcAQd6fI0
         WBAQAdJfsK4rmp6SZsnlYfzd+9YHdaji20DPasvd/5gNG+iuqFN3+/Psj2rjHIIi+cwE
         zTAA==
X-Gm-Message-State: ABy/qLbAIIN9DN0JLZr1iaXm+jDS8Q53DSvRP4bymIRoQIT9X/N/9jze
        Tl1aZGnkyR+IGbxRS2zxYPcSzIWYLHOKSA==
X-Google-Smtp-Source: APBJJlFoY61HjNHb0rFEYpqM/xY1hMlpJ1lQz10syaUR+Qp6bGufuof79IX3dfbrgyCAU0fML5WpoZTLRKI8TQ==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a63:7f51:0:b0:557:5649:381 with SMTP id
 p17-20020a637f51000000b0055756490381mr4012081pgn.3.1688761157717; Fri, 07 Jul
 2023 13:19:17 -0700 (PDT)
Date:   Fri,  7 Jul 2023 20:19:02 +0000
In-Reply-To: <20230707201904.953262-1-jiaqiyan@google.com>
Mime-Version: 1.0
References: <20230707201904.953262-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230707201904.953262-3-jiaqiyan@google.com>
Subject: [PATCH v3 2/4] mm/hwpoison: check if a subpage of a hugetlb folio is
 raw HWPOISON
From:   Jiaqi Yan <jiaqiyan@google.com>
To:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        naoya.horiguchi@nec.com
Cc:     songmuchun@bytedance.com, shy828301@gmail.com,
        linmiaohe@huawei.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duenwen@google.com,
        axelrasmussen@google.com, jthoughton@google.com,
        Jiaqi Yan <jiaqiyan@google.com>
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

Add the functionality, is_raw_hwp_subpage, to tell if a subpage of a
hugetlb folio is a raw HWPOISON page. This functionality relies on
RawHwpUnreliable to be not set; otherwise hugepage's raw HWPOISON list
becomes meaningless.

is_raw_hwp_subpage needs to hold hugetlb_lock in order to synchronize
with __get_huge_page_for_hwpoison, who iterates and inserts an entry to
raw_hwp_list. llist itself doesn't ensure insertion is synchornized with
the iterating used by __is_raw_hwp_list. Caller can minimize the
overhead of lock cycles by first checking if folio / head page's
HWPOISON flag is set.

Exports this functionality to be immediately used in the read operation
for hugetlbfs.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 include/linux/hugetlb.h | 19 +++++++++++++++++++
 include/linux/mm.h      |  7 +++++++
 mm/hugetlb.c            | 10 ++++++++++
 mm/memory-failure.c     | 34 ++++++++++++++++++++++++----------
 4 files changed, 60 insertions(+), 10 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index ca3c8e10f24a..4a745af98525 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1007,6 +1007,25 @@ void hugetlb_register_node(struct node *node);
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
index 74f1be743ba2..edaa18b6f731 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3680,6 +3680,7 @@ extern const struct attribute_group memory_failure_attr_group;
 extern void memory_failure_queue(unsigned long pfn, int flags);
 extern int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 					bool *migratable_cleared);
+extern bool __is_raw_hwp_subpage(struct folio *folio, struct page *subpage);
 void num_poisoned_pages_inc(unsigned long pfn);
 void num_poisoned_pages_sub(unsigned long pfn, long i);
 struct task_struct *task_early_kill(struct task_struct *tsk, int force_early);
@@ -3694,6 +3695,12 @@ static inline int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
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
index bce28cca73a1..9c608d2f6630 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7373,6 +7373,16 @@ int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
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
index a08677dcf953..5b6c8ceb13c0 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1813,18 +1813,32 @@ EXPORT_SYMBOL_GPL(mf_dax_kill_procs);
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
2.41.0.255.g8b1d071c50-goog

