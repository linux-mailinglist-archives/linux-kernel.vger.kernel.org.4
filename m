Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CD3607C86
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiJUQks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbiJUQjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:39:07 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C02128B187
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:48 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n6-20020a5b0486000000b006aff8dc9865so3737759ybp.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+C7/ATuUriMIrUw34NjzRIATqKexU0rnzCYq9OSaiU4=;
        b=jJGO9Z7ZWa3ry6jjj7ApkjoGMgyzlebjLJ9uIX3/IGcrm79tNXbnUjUmPWEAbUWcEd
         55DuEMpVP9519fDyAuDBtSlqfbKbDKkyB8ijR8pErjYk3LLzCP/D/GV/wZwetPTE7Ojr
         wpMDqo/jZbCPsmNcIrkWDF+SByqBvmoi+4RjlGJDBYF3ZdmqeeL+CbWAQiFjQNnor9LY
         8qVv18b9TvK+Uf6pPv8vBqeHpFR9pTHLq1xNH9bPPuK8OH77Q8JvguOlKR7a9IFK3m+x
         IXO0PqqgFybb/i1Kn8jmukXUloBrvY5XjEr+pUxja4P0YbG1JGN8wCpY7Bj9c2UzEM8m
         BOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+C7/ATuUriMIrUw34NjzRIATqKexU0rnzCYq9OSaiU4=;
        b=uiTNWqPQYKpD8lltgshhmlRq3/grOOEv7X7NyJI7d7ZNEcgirwSv7Wf0W02B/JiSaV
         7xIyurw/Zmn8/ipL5nWBnWloBaorS2yMvSPB4Ll+iQVtB4eJJ1bqA61kQ53cOqQqiFx7
         PtiXWyM1Gon5ApsTyfDqspIOgUA0gYL6yujJ1av05UiujqsNRLaO8PX61qTcfTnxPuMk
         QtBm5xD09N0GFe5odvKlhHknDWI/URB68027mH7pwsk4OJj4pl6fRhBbUcJ7rNDdmkyX
         Et8UL83ajadWqpW3HWGQlCItvfRDq0oxsCQ7O/MtaIL7P5t31EWQvUCn5IyNmUugTF3w
         4VAA==
X-Gm-Message-State: ACrzQf2Ilt5RYE2lUdITKWHGVgVEMrtSn3GNddOsH8FhSPNEl57rlY0F
        EVmHzwZ95fcnr66eP6WWy2gOcA5pC3liLsev
X-Google-Smtp-Source: AMsMyM5P4lx4WIyqBLDAe0Bc4rPZ7u/BTYY9AuZts942sFnS05sAkglQc+I6YcdbaB2xek0CE+P143XsmtscbOX3
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:b851:0:b0:6ca:2b0b:d334 with SMTP
 id b17-20020a25b851000000b006ca2b0bd334mr9202954ybm.104.1666370267430; Fri,
 21 Oct 2022 09:37:47 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:36:49 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-34-jthoughton@google.com>
Subject: [RFC PATCH v2 33/47] userfaultfd: add UFFD_FEATURE_MINOR_HUGETLBFS_HGM
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

Userspace must provide this new feature when it calls UFFDIO_API to
enable HGM. Userspace can check if the feature exists in
uffdio_api.features, and if it does not exist, the kernel does not
support and therefore did not enable HGM.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 fs/userfaultfd.c                 | 12 +++++++++++-
 include/linux/userfaultfd_k.h    |  7 +++++++
 include/uapi/linux/userfaultfd.h |  2 ++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 07c81ab3fd4d..3a3e9ef74dab 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -226,6 +226,11 @@ static inline struct uffd_msg userfault_msg(unsigned long address,
 	return msg;
 }
 
+bool uffd_ctx_has_hgm(struct vm_userfaultfd_ctx *ctx)
+{
+	return ctx->ctx->features & UFFD_FEATURE_MINOR_HUGETLBFS_HGM;
+}
+
 #ifdef CONFIG_HUGETLB_PAGE
 /*
  * Same functionality as userfaultfd_must_wait below with modifications for
@@ -1954,10 +1959,15 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 		goto err_out;
 	/* report all available features and ioctls to userland */
 	uffdio_api.features = UFFD_API_FEATURES;
+
 #ifndef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
 	uffdio_api.features &=
 		~(UFFD_FEATURE_MINOR_HUGETLBFS | UFFD_FEATURE_MINOR_SHMEM);
-#endif
+#ifndef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
+	uffdio_api.features &= ~UFFD_FEATURE_MINOR_HUGETLBFS_HGM;
+#endif  /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
+#endif  /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
+
 #ifndef CONFIG_HAVE_ARCH_USERFAULTFD_WP
 	uffdio_api.features &= ~UFFD_FEATURE_PAGEFAULT_FLAG_WP;
 #endif
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index f07e6998bb68..d8fa37f308f7 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -162,6 +162,8 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma,
 	    vma_is_shmem(vma);
 }
 
+extern bool uffd_ctx_has_hgm(struct vm_userfaultfd_ctx *);
+
 extern int dup_userfaultfd(struct vm_area_struct *, struct list_head *);
 extern void dup_userfaultfd_complete(struct list_head *);
 
@@ -228,6 +230,11 @@ static inline bool userfaultfd_armed(struct vm_area_struct *vma)
 	return false;
 }
 
+static inline bool uffd_ctx_has_hgm(struct vm_userfaultfd_ctx *ctx)
+{
+	return false;
+}
+
 static inline int dup_userfaultfd(struct vm_area_struct *vma,
 				  struct list_head *l)
 {
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index 005e5e306266..ae8080003560 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -36,6 +36,7 @@
 			   UFFD_FEATURE_SIGBUS |		\
 			   UFFD_FEATURE_THREAD_ID |		\
 			   UFFD_FEATURE_MINOR_HUGETLBFS |	\
+			   UFFD_FEATURE_MINOR_HUGETLBFS_HGM |	\
 			   UFFD_FEATURE_MINOR_SHMEM |		\
 			   UFFD_FEATURE_EXACT_ADDRESS |		\
 			   UFFD_FEATURE_WP_HUGETLBFS_SHMEM)
@@ -217,6 +218,7 @@ struct uffdio_api {
 #define UFFD_FEATURE_MINOR_SHMEM		(1<<10)
 #define UFFD_FEATURE_EXACT_ADDRESS		(1<<11)
 #define UFFD_FEATURE_WP_HUGETLBFS_SHMEM		(1<<12)
+#define UFFD_FEATURE_MINOR_HUGETLBFS_HGM	(1<<13)
 	__u64 features;
 
 	__u64 ioctls;
-- 
2.38.0.135.g90850a2211-goog

