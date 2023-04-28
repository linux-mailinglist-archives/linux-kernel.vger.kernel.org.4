Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AE66F0FB9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 02:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344335AbjD1AmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 20:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344643AbjD1Alv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 20:41:51 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA252D50
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 17:41:50 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-64115ef7234so6820724b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 17:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682642510; x=1685234510;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cdjbuBZu8tlGo1pxc0tk7o3QpZ2/1SgnLkFhr9tanbY=;
        b=NA00K5Oq++SM0fGqna1cu6q3oeHcwy8f6So1qbLBBkMZpAFX9KXHuuDhs+gKOGNWxO
         BhUnhKp6iJbWjTLkiohP0DmdwrNXAziXuc0rvi0ihCWDhd7KVFxtgwOLgIjQlCxv10Cb
         Fr6lK4GVdCDCCuqabbeuFGr2SIxFl+p/TQ0exA+3rwcuGyQVsa66S5vAjj2+5psPOGf+
         xKc58mbSpQGNsTNlj2VAUHQltWBcsb5W8OiCbzA004IXZZA/CdrPP2C+gtRnuVuprbCi
         P+Bwl8NfFz/7uOfeFZvdmYgCjQhOuj1pGE5/iVs2S/NXjYWrLHuFkM8vb6hoL8o2cfhT
         CcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682642510; x=1685234510;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cdjbuBZu8tlGo1pxc0tk7o3QpZ2/1SgnLkFhr9tanbY=;
        b=FM16TUf8xkrb6L1Dn0+Ry/8x2RHH/ozboM8SyvsZIoGaNsRBflR73mjM2jPL3j6wA6
         V+q1fyPdSa3xUglMBY+15NGYue/5M78tIsCoyWSetdOQAlJflSDTVFbaDMKp7ONwCo/P
         BC1RvqhHCkFRUqS9Snb+v89tgRAMl1oSaAuD1ge2LdfHEdSJdsjukWYBzRxirYei2UCp
         x6qkKvqMsaiGYcCdt5jnfi5vGM1mwGuEUaZeo39Nq6tM4Rg5TI/FQOmV2Jzypf2pwDin
         X8AQ50eYTSdBJ9wyd8uqp79DNvfEPaxMzxFo8RYjQw9SFYpGAbv+J/4beDdz2WPd8y/K
         TKCA==
X-Gm-Message-State: AC+VfDwScHh6twdDQBuE/pnHW8IGeqJw8KeVJnSDNSt5fAGqudSV8CDd
        2+g/naY+8fOZVR2LGfc36nqdCm47ZGT9SA==
X-Google-Smtp-Source: ACHHUZ5uI4KkTztNfACbj2ihd4x1PB/LmRz8ATBzfiQsUsXj0jD9z3cDdKYJarS81OndGtMC5UktDsmysZGalA==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a05:6a00:44c9:b0:63d:24ea:4172 with SMTP
 id cv9-20020a056a0044c900b0063d24ea4172mr2753850pfb.1.1682642510002; Thu, 27
 Apr 2023 17:41:50 -0700 (PDT)
Date:   Fri, 28 Apr 2023 00:41:35 +0000
In-Reply-To: <20230428004139.2899856-1-jiaqiyan@google.com>
Mime-Version: 1.0
References: <20230428004139.2899856-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230428004139.2899856-4-jiaqiyan@google.com>
Subject: [RFC PATCH v1 3/7] mm: publish raw_hwp_page in mm.h
From:   Jiaqi Yan <jiaqiyan@google.com>
To:     mike.kravetz@oracle.com, peterx@redhat.com, naoya.horiguchi@nec.com
Cc:     songmuchun@bytedance.com, duenwen@google.com,
        axelrasmussen@google.com, jthoughton@google.com,
        rientjes@google.com, linmiaohe@huawei.com, shy828301@gmail.com,
        baolin.wang@linux.alibaba.com, wangkefeng.wang@huawei.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jiaqi Yan <jiaqiyan@google.com>
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

raw_hwp_page will be needed by HugeTLB to determine if a raw subpage
in a hugepage is poisoned and either should be unmapped or not
faulted in at PAGE_SIZE PTE level

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 include/linux/mm.h  | 16 ++++++++++++++++
 mm/memory-failure.c | 13 -------------
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9d3216b4284a..4496d7bdd3ea 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3522,6 +3522,22 @@ enum mf_action_page_type {
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
+#endif
+
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
 extern void clear_huge_page(struct page *page,
 			    unsigned long addr_hint,
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index eb5579b6787e..48e62d04af17 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1826,19 +1826,6 @@ EXPORT_SYMBOL_GPL(mf_dax_kill_procs);
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
-
-static inline struct llist_head *raw_hwp_list_head(struct folio *folio)
-{
-	return (struct llist_head *)&folio->_hugetlb_hwpoison;
-}
 
 static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
 {
-- 
2.40.1.495.gc816e09b53d-goog

