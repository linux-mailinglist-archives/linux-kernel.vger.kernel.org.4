Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F8F607C6F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbiJUQig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiJUQhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:37:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED1F27B55C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:30 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p66-20020a257445000000b006ca0ba7608fso3732176ybc.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vfmRA2hXHJo+o02NNvf+xyYOK4fmmGYkyLRnRI2e0ew=;
        b=N0Njss2tbbufEOGB3mWef6ZPPCsGQk8p/qgNHuo+xubJr8V06BeblG2+fHSKMDlxA/
         UJHivxWkHImjyXzOSjLEeYcZId2JJN2s+UU8otxIgWTW9duZ5h63B+TLoNO25kQvzWXU
         HeD3Hvh1l9z43C29huY50us4lyvu6ehOMFBsaP/qsg6yn2ieehrftiopv/q8ZpHCLJ3Y
         K7UMsTw8/CtFVq/Ds71EirrkPGmvM7a28uKqnCDpCM+PSuE49qWj9kjs6TX0wErVJMdC
         fBYvTwS4YdM1mYbSThmJwyUIU5RPiBM8YE1g/uw7dhpETOePIsSy4CEuuJN9RhbaqsIy
         0rtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vfmRA2hXHJo+o02NNvf+xyYOK4fmmGYkyLRnRI2e0ew=;
        b=pLsxIW+Znhwb5czVtOkwP4MfdVlHE0FAd5jFU4PU6c96ulf3QuFhtz/mQj14NXhluV
         b3HQ6oOpMvAEEY6p4zRFFq2LV3fP4cHFhrxOLzNM6jPSPu7qYG4Lc5m75VS6cRy7FjfH
         trKdxVT3YQuLFALesgyMOIHRr85zw/P6R9qI8Azkj4SA/hOt+u2VHtPgjLPh0i7qtzOY
         jAURiwz3aFmLjVQNdQx5Y1r3j7Mw9nm37LQSulHzGitRZRqIbJiXrk0J3xnWCsFw3lwl
         Fq22Ux9Ap8Le4MlA/sq8yTeLR52OdzZJ6lyr+p4bMkhvzWE1gOaIsz0g7+E102B77SAt
         TW8w==
X-Gm-Message-State: ACrzQf0+J5HMG2PiQ8WV2ZorU207EpquGUe9EaQftVM784AMzGUMqQxO
        4xAKPVB7e1rHzp2vrI6xOnRWCN2i9T0A+AUo
X-Google-Smtp-Source: AMsMyM75iODIU2u9+2Ko6JMPySQIphDFX4W2ca1ATqg4hjaMgjVtf9dtnIOEwBdlJcFpQluhwu54PMNKNN8Zpw+u
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:ca8d:0:b0:6c1:99ab:5798 with SMTP
 id a135-20020a25ca8d000000b006c199ab5798mr17535543ybg.19.1666370249622; Fri,
 21 Oct 2022 09:37:29 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:36:30 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-15-jthoughton@google.com>
Subject: [RFC PATCH v2 14/47] hugetlb: make default arch_make_huge_pte
 understand small mappings
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a simple change: don't create a "huge" PTE if we are making a
regular, PAGE_SIZE PTE. All architectures that want to implement HGM
likely need to be changed in a similar way if they implement their own
version of arch_make_huge_pte.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 include/linux/hugetlb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 4b1548adecde..d305742e9d44 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -907,7 +907,7 @@ static inline void arch_clear_hugepage_flags(struct page *page) { }
 static inline pte_t arch_make_huge_pte(pte_t entry, unsigned int shift,
 				       vm_flags_t flags)
 {
-	return pte_mkhuge(entry);
+	return shift > PAGE_SHIFT ? pte_mkhuge(entry) : entry;
 }
 #endif
 
-- 
2.38.0.135.g90850a2211-goog

