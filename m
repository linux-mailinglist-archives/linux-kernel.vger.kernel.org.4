Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AAD65E8DF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjAEKVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbjAEKT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:19:59 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63722559F3
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:19:30 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id n203-20020a2572d4000000b0078f09db9888so19454996ybc.18
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NiUhznaM6wSBHvFTCRNfcVBZtE9H57LW0vfZq/kiKq4=;
        b=R0e0fs1qHnnMIp3WQSIqsS/oYtW5o+Yj7Qa36R5hH23w7ZdGxSpC7WlTWoe3UlQfRD
         dGgTxvzDN/xImPp7YvQkVKm27XaeHjtfDYvAANhaT1tIjTWlY7bJyEtqoyb0eUUUqrU8
         QXro3ShToMB2A8M5U7Ys2rZi65CcMRN/fFJOZAG6TsQBgyFYz/TZFDkv9hIUQiwwQiem
         r9xHbnsfSv7cyl5PTzK6aFGrR3WmNbvqetolrPlO4hROQfy+iN7qwrrmjuqcIxUxBVSJ
         t16F0RLTvqQFbGkRUXJ/5oh9tgpANRdg+EBmcNIs00ZH4Psbt9wmtDm5WNvKRja9aVfR
         jqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NiUhznaM6wSBHvFTCRNfcVBZtE9H57LW0vfZq/kiKq4=;
        b=vHvJ8MyHyvWVdwTREtpZPBjHzuNKwNhQ34zN7JlxqlbvPrD4jIUqouu2ojx5WzmUoa
         +D2Kkm6KjwxTVkV6DamCwAaBapTu8EwFXWpIZbOXtxWxJ3hiJ3twcc955C4/3feyEkF2
         hTQj8w9KOEenPDnTUNBFaLJXuGsZulvq5G4e8M1dHmHBdGcn+O07Sel1gpVPBM5nyldp
         1VNeg40r14DtMKNtSsNLiTdBSyv10A49IiSeREne5+7BqMlQkcP0FGLSQZSLnEe6yeK0
         54COwIknJ2enVd7aGE9YR6JLb5s2QuS4r1YtkUDof/5+oUHzEe9WUMiumXZQaZogB0ps
         4m4A==
X-Gm-Message-State: AFqh2kp1DtFM8qCbrHBRp9FRCqg9Dv72yk80gs2JQ/zTez60mf/Pj01m
        PdLETY/nAlDp+xwI+KQ0CfkmHzoi2y7Xav9d
X-Google-Smtp-Source: AMrXdXs97hJ5UkX9w2wjCZam/ryTvIgotSl/r0iqjglatCp7QBztYQWA8nmijVJuzbrdnXpFOYzs+TfhnvrDByvB
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:cf02:0:b0:7b4:fa63:5519 with SMTP
 id f2-20020a25cf02000000b007b4fa635519mr198616ybg.270.1672913970030; Thu, 05
 Jan 2023 02:19:30 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:18:22 +0000
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-25-jthoughton@google.com>
Subject: [PATCH 24/46] rmap: update hugetlb lock comment for HGM
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
 include/linux/hugetlb.h | 12 ++++++++++++
 mm/rmap.c               |  3 ++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index b7cf45535d64..daf993fdbc38 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -156,6 +156,18 @@ struct file_region {
 #endif
 };
 
+/*
+ * The HugeTLB VMA lock is used to synchronize HugeTLB page table walks.
+ * Right now, it is only used for VM_SHARED mappings.
+ * - The read lock is held when we want to stabilize mappings (prevent PMD
+ *   unsharing or MADV_COLLAPSE for high-granularity mappings).
+ * - The write lock is held when we want to free mappings (PMD unsharing and
+ *   MADV_COLLAPSE for high-granularity mappings).
+ *
+ * Note: For PMD unsharing and MADV_COLLAPSE, the i_mmap_rwsem is held for
+ * writing as well, so page table walkers will also be safe if they hold
+ * i_mmap_rwsem for at least reading. See hugetlb_walk() for more information.
+ */
 struct hugetlb_vma_lock {
 	struct kref refs;
 	struct rw_semaphore rw_sema;
diff --git a/mm/rmap.c b/mm/rmap.c
index ff7e6c770b0a..076ea77010e5 100644
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
2.39.0.314.g84b9a713c41-goog

