Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2523673452E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 08:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjFRG6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 02:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjFRG6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 02:58:02 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19F1E78
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 23:58:00 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-66872bfa48aso364502b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 23:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687071480; x=1689663480;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x1i7wt10FRqoJR/0k/fRkwJvkZET8us7vWtGv6N9JkM=;
        b=wiiXK9RVcjc6zXXnvOnzIHx0QvWcLndYS5cikYrM2XoqA5fnzzO4iZ3MVCVVrJ6Fwn
         As4BvVUIQ75yp5oF65LfjuNfJryRmjH7FleuGKzWg4HXPHQ8MMFz2J+/md40tNJ/m3e/
         imNsFC1Qwc1K2vwpAOjFKRAikJCrYKJEqLpfqHtTtuL/PXuC6HnOwhtteQ7ASIMuMqLG
         NeLsple1mPw1PS3FEyOxIXW8hSxpNZNK5TcuBTRVIJgJEoMQS2UGi6tFiipF3+sawrW2
         T7qYdku1evM2j1oRkchbHm0j4VDRm4ldH8CRDCvDaDfBgW0b9PhEzY51U/tI8QK009jn
         Y/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687071480; x=1689663480;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x1i7wt10FRqoJR/0k/fRkwJvkZET8us7vWtGv6N9JkM=;
        b=PXLiPipB5icS+JZGr8zNpl5PB4doGjHz1QIL1FiJbINvM29QiXRhqr1PTWo73dyTDQ
         4FRMMK4/kzuJx4lUY8HcOGMw/HzuVNQHoR2KVdm/2adT+0wKBcyEvnScmCZ/HyN99FfM
         NpPmkcikS8jOUomLapTUADeciq/bSAvO7Hj8wABZ4Kd+6ryS3thpXNeZaJKof3AEkOWd
         duym6jYPU6wUnrgSEkCeEajt1PsSxMGIrrCgHH0QbMzmi+bciUTWj++Q8KfJGBH55T+c
         AlrlLvPyAswERhCVA485U9fmhSkcqZ8Lf/e9VnXx8wJW5rapG3pbhcvPOwHMnYuVn8BM
         jWWQ==
X-Gm-Message-State: AC+VfDzeFOFz+F0aWRPK/U79kDfl7fzb2jTspD2LNzRQ0JAKZ0c1ue5Y
        V9igHjpMG6zf2+mjnwqui4Bd36c1vQZFdONg
X-Google-Smtp-Source: ACHHUZ6Id6BCQc4em9nIdd8QYYHd6lTWLtvplCqOWsU+BGezvy9ft4sskTUOwDO98945URQ+GDemSFWaK1L6vnbw
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a05:6a00:14c4:b0:668:7143:50ea with
 SMTP id w4-20020a056a0014c400b00668714350eamr577347pfu.4.1687071480165; Sat,
 17 Jun 2023 23:58:00 -0700 (PDT)
Date:   Sun, 18 Jun 2023 06:57:56 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230618065756.1364399-1-yosryahmed@google.com>
Subject: [RFC PATCH 2/5] mm/mlock: fixup mlock_count during unmap
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

In the rare case where an mlocked order-0 folio is mapped 2^20 or more
times, the high mapcount can be interpreted mistakenly by munlock() as
an mlock_count, causing PG_mlocked to not be cleared, possibly leaving
the folio stranded as unevictable endlessly.

To fix this, add a hook during unmapping to check if the bits used for
mlock_count are 0s yet PG_mlocked is set. In this case, call make sure
to perform the missed munlock operation.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 include/linux/mm.h |  4 ++++
 mm/mlock.c         | 18 +++++++++++++++++-
 mm/rmap.c          |  1 +
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3994580772b3..b341477a83e8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1050,6 +1050,7 @@ unsigned long vmalloc_to_pfn(const void *addr);
 extern bool is_vmalloc_addr(const void *x);
 extern int is_vmalloc_or_module_addr(const void *x);
 extern int folio_mlocked_mapcount(struct folio *folio);
+extern void folio_mlock_unmap_check(struct folio *folio);
 #else
 static inline bool is_vmalloc_addr(const void *x)
 {
@@ -1063,6 +1064,9 @@ static inline int folio_mlocked_mapcount(struct folio *folio)
 {
 	return 0;
 }
+static inline void folio_mlock_unmap_check(struct folio *folio)
+{
+}
 #endif
 
 /*
diff --git a/mm/mlock.c b/mm/mlock.c
index 5c5462627391..8261df11d6a6 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -66,7 +66,8 @@ EXPORT_SYMBOL(can_do_mlock);
  * (1) The mapcount will be incorrect (underestimated). It will be correct again
  * once the number of mappings falls below MLOCK_COUNT_BIAS.
  * (2) munlock() can misinterpret the large number of mappings as an mlock_count
- * and leave PG_mlocked set.
+ * and leave PG_mlocked set. This will be fixed when the number of mappings
+ * falls below MLOCK_COUNT_BIAS by folio_mlock_unmap_check().
  */
 #define MLOCK_COUNT_SHIFT 20
 #define MLOCK_COUNT_BIAS (1U << MLOCK_COUNT_SHIFT)
@@ -139,6 +140,21 @@ static int folio_mlock_count_dec(struct folio *folio)
 	return mlock_count - 1;
 }
 
+/*
+ * Call after decrementing the mapcount. If the mapcount previously overflowed
+ * beyond the lower 20 bits for an order-0 mlocked folio, munlock() have
+ * mistakenly left the folio mlocked. Fix it here.
+ */
+void folio_mlock_unmap_check(struct folio *folio)
+{
+	int mapcount = atomic_read(&folio->_mapcount) + 1;
+	int mlock_count = mapcount >> MLOCK_COUNT_SHIFT;
+
+	if (unlikely(!folio_test_large(folio) && folio_test_mlocked(folio) &&
+		     mlock_count == 0))
+		munlock_folio(folio);
+}
+
 /*
  * Mlocked folios are marked with the PG_mlocked flag for efficient testing
  * in vmscan and, possibly, the fault path; and to support semi-accurate
diff --git a/mm/rmap.c b/mm/rmap.c
index 19392e090bec..02e558551f15 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1392,6 +1392,7 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
 			nr = atomic_dec_return_relaxed(mapped);
 			nr = (nr < COMPOUND_MAPPED);
 		}
+		folio_mlock_unmap_check(folio);
 	} else if (folio_test_pmd_mappable(folio)) {
 		/* That test is redundant: it's for safety or to optimize out */
 
-- 
2.41.0.162.gfafddb0af9-goog

