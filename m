Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CDF73452C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 08:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjFRG6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 02:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjFRG6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 02:58:19 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB60170D
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 23:58:12 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1b521321885so11975995ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 23:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687071492; x=1689663492;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7fjpxEmRYmfIPy9m8+B6O263cflpsiora2wxjSeJZzc=;
        b=d2187lUkhz1tQ0LdjKS/RdBcAInoS313wvVyAeapaGuheNx0zAMEP7j5tsde3Pp0ki
         JLy4R1+trXmmTvJcpQFdSwOcOoWzO74P8BuVHwFwEckpX5HpMtMVxrPYKjjQfQ24J7VO
         Q835WNmKxjc9DtFkftSG8+8pjhS98I9MXzG/PHODkUae5GHvtG2HidU7XWvjYdDqsGTB
         UZrvi6kDymzX4lmmYXUipM1X5APyR7LmwCmH4ChdN/SzeOfAhYnGUooORyYrnU8lzDzB
         US9GH11eoECaMcdkpDFewfWnZcdflNR0OzUJe7cHb8WLhYHIi48dpX5NwSXjwzQDhV86
         h4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687071492; x=1689663492;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7fjpxEmRYmfIPy9m8+B6O263cflpsiora2wxjSeJZzc=;
        b=I2XppsIk6zYeFgFBIM0yVyu5j+m+qaVcsyP8KCH516IJSe4aUCq/IQDNllS8GoeuUu
         UDjIrzf2XKav/rwabd7B4UN7Zpv4EicbdiewrCZ7DoEMYM7QhtODi2f2XUcieataVbOh
         /PRPeTjtogyKEjXcqAQGs+n3iSndBAITiS5kCXi9BBjDNuSgNgj+O6MtVbYnbS/FXsDs
         5ZoVRk4nsbEKK8z0J3pQa3zQJ7So7Up3cPdZo8KyA5qXNw3zOhKPF0GA1uklwxebBxwa
         wjeo01N//Ax6Skb7r+DqYKPJjUs78P6lQVgP8FMYnA5xihZzkQ4W9JaGNr6gTC3F2V86
         +xCg==
X-Gm-Message-State: AC+VfDx2tAcFXpkk0T+qyB6Sp963619e2oviOwqnl9XKTytP9JqtRkwq
        ju4gV2it9jzAilRLFAnhbO+pJ78YYd1Fcl0I
X-Google-Smtp-Source: ACHHUZ4KDoG+icnmkKzKlDDiXY31YTjeGkcRrxhpySyxVPdutgNKWixbpYJugmDD23KR/VXk8geceEUZPGubfthm
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:902:bb10:b0:1b2:61eb:a73f with SMTP
 id im16-20020a170902bb1000b001b261eba73fmr881124plb.9.1687071491867; Sat, 17
 Jun 2023 23:58:11 -0700 (PDT)
Date:   Sun, 18 Jun 2023 06:58:09 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230618065809.1364900-1-yosryahmed@google.com>
Subject: [RFC PATCH 3/5] mm/mlock: WARN_ON() if mapcount overflows into mlock_count
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yu Zhao <yuzhao@google.com>,
        "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
        Steven Barrett <steven@liquorix.net>,
        Brian Geffon <bgeffon@google.com>,
        "T.J. Alumbaugh" <talumbau@google.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        David Howells <dhowells@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Greg Thelen <gthelen@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
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

Add a hook when a new mapping is added to an order-0 mlocked folio to
check if the mapcount overflowed beyond the allocated 20 bits into the
mlock_count. This is useful to know if this alarm if this happens
frequently enough to cause a problem.

We do so by checking if the folio has the lower 20 bits as all 0s. For
file-backed folios, we do not hold the folio lock while adding a new
mapping, so there's a chance that two mappings are added in quick
succession such that the warning doesn't fire. Don't sweat it.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 include/linux/mm.h |  4 ++++
 mm/mlock.c         | 13 +++++++++++++
 mm/rmap.c          |  2 ++
 3 files changed, 19 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index b341477a83e8..917f81996e22 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1050,6 +1050,7 @@ unsigned long vmalloc_to_pfn(const void *addr);
 extern bool is_vmalloc_addr(const void *x);
 extern int is_vmalloc_or_module_addr(const void *x);
 extern int folio_mlocked_mapcount(struct folio *folio);
+extern void folio_mlock_map_check(struct folio *folio);
 extern void folio_mlock_unmap_check(struct folio *folio);
 #else
 static inline bool is_vmalloc_addr(const void *x)
@@ -1064,6 +1065,9 @@ static inline int folio_mlocked_mapcount(struct folio *folio)
 {
 	return 0;
 }
+static inline void folio_mlock_map_check(struct folio *folio)
+{
+}
 static inline void folio_mlock_unmap_check(struct folio *folio)
 {
 }
diff --git a/mm/mlock.c b/mm/mlock.c
index 8261df11d6a6..f8b3fb1b2986 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -140,6 +140,19 @@ static int folio_mlock_count_dec(struct folio *folio)
 	return mlock_count - 1;
 }
 
+/*
+ * Call after incrementing the mapcount. WARN_ON() if the mapcount overflows
+ * beyond the lower 20 bits for order-0 mlocked folios.
+ */
+void folio_mlock_map_check(struct folio *folio)
+{
+	int mapcount = atomic_read(&folio->_mapcount) + 1;
+
+	/* WARN if we overflow beyond the lower 20 bits */
+	if (unlikely(!folio_test_large(folio) && folio_test_mlocked(folio)))
+		WARN_ON((mapcount & MLOCK_MAPCOUNT_MASK) == 0);
+}
+
 /*
  * Call after decrementing the mapcount. If the mapcount previously overflowed
  * beyond the lower 20 bits for an order-0 mlocked folio, munlock() have
diff --git a/mm/rmap.c b/mm/rmap.c
index 02e558551f15..092529319782 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1228,6 +1228,7 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
 			nr = atomic_inc_return_relaxed(mapped);
 			nr = (nr < COMPOUND_MAPPED);
 		}
+		folio_mlock_map_check(folio);
 	} else if (folio_test_pmd_mappable(folio)) {
 		/* That test is redundant: it's for safety or to optimize out */
 
@@ -1330,6 +1331,7 @@ void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
 			nr = atomic_inc_return_relaxed(mapped);
 			nr = (nr < COMPOUND_MAPPED);
 		}
+		folio_mlock_map_check(folio);
 	} else if (folio_test_pmd_mappable(folio)) {
 		/* That test is redundant: it's for safety or to optimize out */
 
-- 
2.41.0.162.gfafddb0af9-goog

