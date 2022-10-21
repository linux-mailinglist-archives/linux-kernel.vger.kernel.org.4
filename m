Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66E6607C78
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiJUQjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiJUQiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:38:15 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1782892C7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:38 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i16-20020a056902069000b006c3ef07d22eso3768440ybt.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A8A4WdJUmtZ3pZn0W1kJeWoXW7oHHPnmlapm5XaH58o=;
        b=QyZNlwrSq5mo4QWYzR3oK0EIR216wpexI9Df6hEZNyICuoeMeDmrMlBrvBhG5G9oMH
         eDwoSKuwVOkw2F+eA1UKjuSgQ/4G0YaIvKDgPK5/l7J3Q8CkdNBISRGJo0HwWGWEUNrf
         Hsg26jVqMIfXyFuiBuWIPRk3e/w2Ynh00CNLcq8RUWHyxHLWPosuj8ILf6dtKr/srDKf
         VgnkAvfVFAk1eD2bIu3KwtmPY4idqkPwVNcFidZU4Qvqi2ndAMirEsPVmZ++CLhMi7or
         QE1FxE7zy+/P5OQx3hmNlYrC8AT26Ti6pHfMan5PLEwpAZLEhxJr4VhMjlaxssiD5v+m
         jbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A8A4WdJUmtZ3pZn0W1kJeWoXW7oHHPnmlapm5XaH58o=;
        b=j62+WE5X4X+PrlleKBIqlythGDRbdSizXhECm2SBNcDhP89+iucsL5fluS9hL5St7i
         gwTGXlW0wEeDY1lGhvpJhkqNbgAEGmCFNYwoxHfAveR3fFBvVj7z+nvpWovnFBKCl1oL
         V78pfoBW6NwtFFo777zAG+Rnayxs+UGjlGZ6hkuPHYnPWHh12s7au2XARi2/O4WB4YV9
         yjwBcPjPYdipBa7KJTJIU+exDZysSeCLm0Sy+FSzakMi0261QkBCh+0fnu2evtKNzU/X
         DXvyPPdZKgWJKHQfnuLxH3405c/7BiHQwR3rjgEZkRU6SqaG15roOFDsGEG3zb16Pq6I
         /AGw==
X-Gm-Message-State: ACrzQf0dNSZeiSqweeEq2AeCD2YqL/MCBtXLeLWe+UjVPA0TuWtRmnSM
        yw+8RQ1iHrwlEfvjBFarXc7ycpcLOZoH+GKQ
X-Google-Smtp-Source: AMsMyM7mqFcWFty/hD8NAlbP6ayFKJzD6/8Ky2ha3bC8YyWht+9XnIfNeF0UVQPRo5YyUUff1SZwDTyeE2m4y1Pj
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:cd45:0:b0:6c2:2d8a:e3f4 with SMTP
 id d66-20020a25cd45000000b006c22d8ae3f4mr17406990ybf.395.1666370257496; Fri,
 21 Oct 2022 09:37:37 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:36:39 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-24-jthoughton@google.com>
Subject: [RFC PATCH v2 23/47] rmap: update hugetlb lock comment for HGM
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

The VMA lock is used to prevent high-granularity HugeTLB mappings from
being collapsed while other threads are doing high-granularity page
table walks.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 mm/rmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 19850d955aea..527463c1e936 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -47,7 +47,8 @@
  *
  * hugetlbfs PageHuge() take locks in this order:
  *   hugetlb_fault_mutex (hugetlbfs specific page fault mutex)
- *     vma_lock (hugetlb specific lock for pmd_sharing)
+ *     vma_lock (hugetlb specific lock for pmd_sharing and high-granularity
+ *               mapping)
  *       mapping->i_mmap_rwsem (also used for hugetlb pmd sharing)
  *         page->flags PG_locked (lock_page)
  */
-- 
2.38.0.135.g90850a2211-goog

