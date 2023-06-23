Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3A573BCCF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 18:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjFWQke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 12:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbjFWQkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 12:40:23 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC333273D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 09:40:20 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-528ab71c95cso507524a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 09:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687538420; x=1690130420;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Awz9MouaWvhYEsa6uGhopM2ZzPpu93glS/WPXSA5BTo=;
        b=34QbFsFBy9aHUrBbbyPZvNf2E6cREYDEJ3OjWNnfkIABbwc6TGNrC1vrgVO6MW9NbF
         eqg/aLoYmKTPEpf/V4fsvvxZE2OH/jKO4vFZZEDXI9Fw9rFIdjqAghj7mM553FLclePO
         KLLFRlkp1ktiExq7SI5uSKhq1wmLqwGDDEZNOLOElvL4lS0kRfXPXgsWyOuJxhzdyMqv
         nNxyqnDxgcoLV/l2B8Oh7QU4LpW04N+ipd0x+tjGDQNo7DnIZ+46hlrSdKqHVfqSfpu2
         IMvjSxyQLqGS45aGc7DQuYRsR+7dKrGsp2eRYXyTB07mxB+Es4MLo7hX+4zKOg4KauQE
         RrNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687538420; x=1690130420;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Awz9MouaWvhYEsa6uGhopM2ZzPpu93glS/WPXSA5BTo=;
        b=llkCglROWrpzNGpDxfUTFv008bipClTOGK8TU5ba5qOwBp5GlxaTZ/0b8+5PqVVWjQ
         LkCxiijC2oIJYC6+EPBbhgPQYubC7Tj4Nc35ncGwwVzzFOhOoWq3+5V2yM9SrJ9kPGHZ
         5vU5bdjTGjfQBHo1e30LkeF1K8zadHN0dqyUgqa4ImqkHnkj9H+pue29nqw0gK3PoEI/
         Qfmm2bJbSIErjDC5RHM14JeVTky3SJxnMFSW4QOgksApYWpGGR45OdyHu5OC7xu5NVBN
         pvRt4Ilps25cOFD1e/K6dZcXDIuRtb6bVLj9NWd3S6l3Z8n+AAtx0uoJPqPcmQTr7h0u
         RwBg==
X-Gm-Message-State: AC+VfDx76FurdaugeZQYjZfxo0HCTusvBxdPOxvL2TV5z8K/5q6NJJFs
        hJcZLrn061slUOB2sVtuLOtfRRT0F/Vxtw==
X-Google-Smtp-Source: ACHHUZ5jab1Tbf6QleE2xBkm4fTrRupoObLUsNIdT3ISEaHPrxP1Xi1eIjnLCw3mlAhfFGWA7aDdu24vu/Y4Uw==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a65:6793:0:b0:553:9251:558b with SMTP id
 e19-20020a656793000000b005539251558bmr2555744pgr.8.1687538420513; Fri, 23 Jun
 2023 09:40:20 -0700 (PDT)
Date:   Fri, 23 Jun 2023 16:40:12 +0000
In-Reply-To: <20230623164015.3431990-1-jiaqiyan@google.com>
Mime-Version: 1.0
References: <20230623164015.3431990-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230623164015.3431990-2-jiaqiyan@google.com>
Subject: [PATCH v2 1/4] mm/hwpoison: delete all entries before traversal in __folio_free_raw_hwp
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

Traversal on llist (e.g. llist_for_each_safe) is only safe AFTER entries
are deleted from the llist.

llist_del_all are lock free with itself. folio_clear_hugetlb_hwpoison()s
from __update_and_free_hugetlb_folio and memory_failure won't need
explicit locking when freeing the raw_hwp_list.

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 mm/memory-failure.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 004a02f44271..c415c3c462a3 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1825,12 +1825,11 @@ static inline struct llist_head *raw_hwp_list_head(struct folio *folio)
 
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
@@ -1840,7 +1839,6 @@ static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
 		kfree(p);
 		count++;
 	}
-	llist_del_all(head);
 	return count;
 }
 
-- 
2.41.0.162.gfafddb0af9-goog

