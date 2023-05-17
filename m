Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BF3706DAA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjEQQKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjEQQKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:10:02 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D24268C
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:10:01 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1ae515ff6a9so976625ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684339801; x=1686931801;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=woRAdaWYV8FD8vab19hJA4MPyBeuK73rImQoSJfr/I0=;
        b=YE1b/zymZ9vc5qJrU2yZ6Y6Sk4upJCBRZPNMxGSUkSJ4NmR9re5sc7FtxyFCA6op5Z
         NYFItdPqItmJDGSzZeWAH3tLZk1Wm8Afz5r3LdakqUg7OhhCWIIdGn7UMn0FZjneF7a+
         bisIrHgG+Aut0UuT0TMLzqNQqD7aRu51rTrV0uDZzw1l+caeFdr0GilMHPWzBABPv15M
         X4eJsAFnhsiuhrdvQNPjyZTVUft46X+7oX5ruBdVoJ1jwWqEudjOGdVLWk0A5g6E9K6h
         emxl51IemdopSKTESt1Ud6k+QmEevHfSkIuOBN+uVG3cweipz2hw8QLMUNEJwvHVbkK9
         kVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684339801; x=1686931801;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=woRAdaWYV8FD8vab19hJA4MPyBeuK73rImQoSJfr/I0=;
        b=V7I39NxV/JDfIKRP7L5B8O6aKctKzU03tqiUZpReGw4Ttpwm2YMXKTDPvwReIitHAn
         bnvsvjKZITUUyDRtw4fJ1lZeD5KyzqWpN1Y2IQMU6zEY3XeLDmswGwfuzj5dGWdnWU/8
         FKyolGnQB9LprcjQifwYdFwr3/xBYGt2/G24K76ysGTYw2LCyqEr5g3ZQlu2NnqwooMY
         C0lC7E4VUL5fHmXrvgbVo2LVdE4lscbihOgN0IgTkPe/tQTYEYWS+VyFVPQAIploebub
         ZzKMX1egvfOoxNc6+hdkkmQGVmRFUpMUmkO5+fsJPsVnskziBaY9bENrWvIyqyhFVez+
         iTbw==
X-Gm-Message-State: AC+VfDw8L3KXjrqtayPVq7bob6eEa65tn6rXr+QCVPFtMIuj+xFvPuas
        7wDz9d3DP+kfa5f7jOkFi/92digLXIcCvA==
X-Google-Smtp-Source: ACHHUZ4THj5Qkl03JCHCjTlSWp/o7bV04vsyL93TtgiK33g3S4UGmuzEa+WOM6LmC0yaPTlWwNF+duECY3Pn7A==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a17:903:334f:b0:1ae:531f:366a with SMTP
 id ka15-20020a170903334f00b001ae531f366amr637380plb.5.1684339801269; Wed, 17
 May 2023 09:10:01 -0700 (PDT)
Date:   Wed, 17 May 2023 16:09:46 +0000
In-Reply-To: <20230517160948.811355-1-jiaqiyan@google.com>
Mime-Version: 1.0
References: <20230517160948.811355-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230517160948.811355-2-jiaqiyan@google.com>
Subject: [PATCH v1 1/3] mm/hwpoison: find subpage in hugetlb HWPOISON list
From:   Jiaqi Yan <jiaqiyan@google.com>
To:     mike.kravetz@oracle.com, songmuchun@bytedance.com,
        naoya.horiguchi@nec.com, shy828301@gmail.com, linmiaohe@huawei.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
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

Adds the functionality to search a subpage's corresponding raw_hwp_page
in hugetlb page's HWPOISON list. This functionality can also tell if a
subpage is a raw HWPOISON page.

Exports this functionality to be immediately used in the read operation
for hugetlbfs.

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 include/linux/mm.h  | 23 +++++++++++++++++++++++
 mm/memory-failure.c | 26 ++++++++++++++++----------
 2 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 27ce77080c79..f191a4119719 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3683,6 +3683,29 @@ enum mf_action_page_type {
  */
 extern const struct attribute_group memory_failure_attr_group;
 
+#ifdef CONFIG_HUGETLB_PAGE
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
+ * Given @subpage, a raw page in a hugepage, find its location in @folio's
+ * _hugetlb_hwpoison list. Return NULL if @subpage is not in the list.
+ */
+struct raw_hwp_page *find_raw_hwp_page(struct folio *folio,
+				       struct page *subpage);
+#endif
+
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
 extern void clear_huge_page(struct page *page,
 			    unsigned long addr_hint,
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 5b663eca1f29..c49e6c2d1f07 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1818,18 +1818,24 @@ EXPORT_SYMBOL_GPL(mf_dax_kill_procs);
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
+struct raw_hwp_page *find_raw_hwp_page(struct folio *folio,
+				       struct page *subpage)
 {
-	return (struct llist_head *)&folio->_hugetlb_hwpoison;
+	struct llist_node *t, *tnode;
+	struct llist_head *raw_hwp_head = raw_hwp_list_head(folio);
+	struct raw_hwp_page *hwp_page = NULL;
+	struct raw_hwp_page *p;
+
+	llist_for_each_safe(tnode, t, raw_hwp_head->first) {
+		p = container_of(tnode, struct raw_hwp_page, node);
+		if (subpage == p->page) {
+			hwp_page = p;
+			break;
+		}
+	}
+
+	return hwp_page;
 }
 
 static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
-- 
2.40.1.606.ga4b1b128d6-goog

