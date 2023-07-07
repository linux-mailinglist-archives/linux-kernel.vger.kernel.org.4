Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2162C74B7C3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 22:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbjGGUTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 16:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbjGGUTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 16:19:20 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01382114
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 13:19:16 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b8130aceefso30900095ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 13:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688761156; x=1691353156;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8FNetjBnnWs4aWcoESXEPv5EQNod9M4H8ra/lwVlWng=;
        b=VqyQmTQkCzL2+2WReICnzA6BIm0pcsZl2UxgOC96YeMxOiWjK9NhMMsd6sh9vgNsyp
         l48aVL+YSen8q6QehXxVJmNvqqI169EdhdJF1wP18IrISpvNJpDmE8qvdh8iCozeWtb6
         JHgOCmY5zsqIie6UwoBTIJKIq84brRDTo5Ou4o4qfUOH/nsVpBgCFa70jcSCS8JQjRGc
         YPkr1zj/Al/4tkKYO5OxobtQsE4XPWag4pb/fMTB6fXhhvDh+IoKStTY4VGEtEBkAolL
         +GRm79XEsc5P3ls1k+A19D7pSp5BkV+9M69nyu7mjSupo4UAMKBhqh3ZJivJ7t7YjP3Z
         tU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688761156; x=1691353156;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8FNetjBnnWs4aWcoESXEPv5EQNod9M4H8ra/lwVlWng=;
        b=VpV0Qg/ynk+7W2KX8qdFPvY1s1EMr4qx7aNSKou0Pf3Q9hUO3ZtI1lvPATg/jcI+iP
         ZMvBunc6qKVx+uKdmGS8z2ni7Z5sVyc34rtAgQxCpRKD5O5FbiujJWjZhnHbaBExYGDr
         MB5GaOBPrl3CJ0Sbnk0WQKd95CQ+sVoE4ogLBN7fbWAMGrB4gh67/CnQBsQevhGwnTtB
         kclM1NkA0HHWG7CtDjdVKOTZKdOaMRDoQHiN+eJHRA4HXS9qZ3rGDxwPHKoxETYJ6XX2
         xCpqxYObfefOE47FrqrURMjCpASsYEYZapuc7A+wE2kLGVcwFtWioxMN7tO6GNiarWzj
         GIDQ==
X-Gm-Message-State: ABy/qLYoHPihWsJupAghCCLQmRZxTIv6ZeZ7b0nzEvr8Rt9xS8IioGaf
        3sslkk4f0eyVunuZRGg8/BM+GFPsNkm3Hg==
X-Google-Smtp-Source: APBJJlF/mGcdbnw0xXdoe2sEjVsVM5DocIm81TfZezvsw+ScgL/1ytfRgEc6ZH2UhLuK+hvQLPJDpV1K7/EAPA==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a17:902:ec88:b0:1b7:fa05:e0c7 with SMTP
 id x8-20020a170902ec8800b001b7fa05e0c7mr5745441plg.13.1688761156325; Fri, 07
 Jul 2023 13:19:16 -0700 (PDT)
Date:   Fri,  7 Jul 2023 20:19:01 +0000
In-Reply-To: <20230707201904.953262-1-jiaqiyan@google.com>
Mime-Version: 1.0
References: <20230707201904.953262-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230707201904.953262-2-jiaqiyan@google.com>
Subject: [PATCH v3 1/4] mm/hwpoison: delete all entries before traversal in  __folio_free_raw_hwp
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

Traversal on llist (e.g. llist_for_each_safe) is only safe AFTER entries
are deleted from the llist. Correct the way __folio_free_raw_hwp deletes
and frees raw_hwp_page entries in raw_hwp_list: first llist_del_all, then
kfree within llist_for_each_safe.

As of today, concurrent adding, deleting, and traversal on raw_hwp_list
from hugetlb.c and/or memory-failure.c are fine with each other. Note
this is guaranteed partly by the lock-free nature of llist, and partly
by holding hugetlb_lock and/or mf_mutex. For example, as llist_del_all
is lock-free with itself, folio_clear_hugetlb_hwpoison()s from
__update_and_free_hugetlb_folio and memory_failure won't need explicit
locking when freeing the raw_hwp_list. New code that manipulates
raw_hwp_list must be careful to ensure the concurrency correctness.

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 mm/memory-failure.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index e245191e6b04..a08677dcf953 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1829,12 +1829,11 @@ static inline struct llist_head *raw_hwp_list_head(struct folio *folio)
 
 static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
 {
-	struct llist_head *head;
-	struct llist_node *t, *tnode;
+	struct llist_node *t, *tnode, *head;
 	unsigned long count = 0;
 
-	head = raw_hwp_list_head(folio);
-	llist_for_each_safe(tnode, t, head->first) {
+	head = llist_del_all(raw_hwp_list_head(folio));
+	llist_for_each_safe(tnode, t, head) {
 		struct raw_hwp_page *p = container_of(tnode, struct raw_hwp_page, node);
 
 		if (move_flag)
@@ -1844,7 +1843,6 @@ static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
 		kfree(p);
 		count++;
 	}
-	llist_del_all(head);
 	return count;
 }
 
-- 
2.41.0.255.g8b1d071c50-goog

