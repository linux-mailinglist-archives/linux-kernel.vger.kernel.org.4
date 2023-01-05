Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177CB65E8CE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjAEKUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbjAEKTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:19:35 -0500
Received: from mail-vk1-xa49.google.com (mail-vk1-xa49.google.com [IPv6:2607:f8b0:4864:20::a49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666784FD67
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:19:07 -0800 (PST)
Received: by mail-vk1-xa49.google.com with SMTP id r23-20020a1f2b17000000b003b89463c349so9997548vkr.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wyTgKoUPaqLvPlKgkL6dENYZlNeSHJ5X+BJXc4mR0WE=;
        b=mO/o/8j5uzBbSG/A9cnee+je9u5JCkoj3aSd2P7vs7zhonYorgkMtjaT6Camo16MRO
         HNtN+6XL9Mv6MTsGSvNsS0ThZoOWReEOx+mlNlqsi2BHHzTVLxaSyppMdsTCWcfSc5jK
         6+ZKrfvxX1DRZ4xkYZFJxsbNBzLnTyhaq61sRVQmunxV1fBNLuDxQ/deFSB6JHPEpTUt
         5/tku/ASVRacTDjSteTyVtqapAitjwzsKEVznkEuAhKi0Dyl3YHpk9+wTziB0iAhpapX
         LWhXUWqa8fiTZGxfOcvuaDuvdtQuOtDLPsve4S6HaeJ5gJdlA8bacDMpeFwBpswodRai
         BbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wyTgKoUPaqLvPlKgkL6dENYZlNeSHJ5X+BJXc4mR0WE=;
        b=RQWNQcAMo9jUKxbIrCePps+iM+7q65whRLZ2QffYspEnowHnRzGiMQZLioXXWghZdc
         4aReJZaR75keIxK8aJKMJiNzGe/eauhJ/WdEo4dcViTsmSoWZlWQGBY/4IBPhtMeQb0w
         UTe4wFwq4cyYMaKmMtJH0VJxBdBaqcH6k+7zPcf4Twzo7zpp4t2+B9d9juQMGKsQXaVM
         3Cmx2Fq3e6u9oVF/+ZbIKpJ3asRIQqW7HDIHIL8WN5tcbdf9+xOuQHSduEeslf9ai5md
         o7rX2Av4brVQBciLFJnrw1l060hqxLM9nHj4u83k4Cxs9hWLdqtmZLoc3ULyYZWtfygl
         agnQ==
X-Gm-Message-State: AFqh2koeU63/cvNKUSzCWgq5ew655+S5fwut1cPJTQoBqfG1B0hg1FBj
        +3ssmcpL4WfT9UrRglNU1P/63CmwSb8aQ+z6
X-Google-Smtp-Source: AMrXdXvO4uC3f87rB5JMezqUX+x18qYnUlhtx11jU+WhbWs+qlfQayBtMoiabh7QOd7CQ701U3D2KnBikpjvwFJS
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a67:eb15:0:b0:3c6:5f9:689d with SMTP id
 a21-20020a67eb15000000b003c605f9689dmr4653326vso.8.1672913946620; Thu, 05 Jan
 2023 02:19:06 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:18:07 +0000
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-10-jthoughton@google.com>
Subject: [PATCH 09/46] mm: add MADV_SPLIT to enable HugeTLB HGM
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

Issuing ioctl(MADV_SPLIT) on a HugeTLB address range will enable
HugeTLB HGM. MADV_SPLIT was chosen for the name so that this API can be
applied to non-HugeTLB memory in the future, if such an application is
to arise.

MADV_SPLIT provides several API changes for some syscalls on HugeTLB
address ranges:
1. UFFDIO_CONTINUE is allowed for MAP_SHARED VMAs at PAGE_SIZE
   alignment.
2. read()ing a page fault event from a userfaultfd will yield a
   PAGE_SIZE-rounded address, instead of a huge-page-size-rounded
   address (unless UFFD_FEATURE_EXACT_ADDRESS is used).

There is no way to disable the API changes that come with issuing
MADV_SPLIT. MADV_COLLAPSE can be used to collapse high-granularity page
table mappings that come from the extended functionality that comes with
using MADV_SPLIT.

For post-copy live migration, the expected use-case is:
1. mmap(MAP_SHARED, some_fd) primary mapping
2. mmap(MAP_SHARED, some_fd) alias mapping
3. MADV_SPLIT the primary mapping
4. UFFDIO_REGISTER/etc. the primary mapping
5. Copy memory contents into alias mapping and UFFDIO_CONTINUE the
   corresponding PAGE_SIZE sections in the primary mapping.

More API changes may be added in the future.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 arch/alpha/include/uapi/asm/mman.h     |  2 ++
 arch/mips/include/uapi/asm/mman.h      |  2 ++
 arch/parisc/include/uapi/asm/mman.h    |  2 ++
 arch/xtensa/include/uapi/asm/mman.h    |  2 ++
 include/linux/hugetlb.h                |  2 ++
 include/uapi/asm-generic/mman-common.h |  2 ++
 mm/hugetlb.c                           |  3 +--
 mm/madvise.c                           | 26 ++++++++++++++++++++++++++
 8 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi/asm/mman.h
index 763929e814e9..7a26f3648b90 100644
--- a/arch/alpha/include/uapi/asm/mman.h
+++ b/arch/alpha/include/uapi/asm/mman.h
@@ -78,6 +78,8 @@
 
 #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
 
+#define MADV_SPLIT	26		/* Enable hugepage high-granularity APIs */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/arch/mips/include/uapi/asm/mman.h b/arch/mips/include/uapi/asm/mman.h
index c6e1fc77c996..f8a74a3a0928 100644
--- a/arch/mips/include/uapi/asm/mman.h
+++ b/arch/mips/include/uapi/asm/mman.h
@@ -105,6 +105,8 @@
 
 #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
 
+#define MADV_SPLIT	26		/* Enable hugepage high-granularity APIs */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/include/uapi/asm/mman.h
index 68c44f99bc93..a6dc6a56c941 100644
--- a/arch/parisc/include/uapi/asm/mman.h
+++ b/arch/parisc/include/uapi/asm/mman.h
@@ -72,6 +72,8 @@
 
 #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
 
+#define MADV_SPLIT	74		/* Enable hugepage high-granularity APIs */
+
 #define MADV_HWPOISON     100		/* poison a page for testing */
 #define MADV_SOFT_OFFLINE 101		/* soft offline page for testing */
 
diff --git a/arch/xtensa/include/uapi/asm/mman.h b/arch/xtensa/include/uapi/asm/mman.h
index 1ff0c858544f..f98a77c430a9 100644
--- a/arch/xtensa/include/uapi/asm/mman.h
+++ b/arch/xtensa/include/uapi/asm/mman.h
@@ -113,6 +113,8 @@
 
 #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
 
+#define MADV_SPLIT	26		/* Enable hugepage high-granularity APIs */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 8713d9c4f86c..16fc3e381801 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -109,6 +109,8 @@ struct hugetlb_vma_lock {
 	struct vm_area_struct *vma;
 };
 
+void hugetlb_vma_lock_alloc(struct vm_area_struct *vma);
+
 extern struct resv_map *resv_map_alloc(void);
 void resv_map_release(struct kref *ref);
 
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index 6ce1f1ceb432..996e8ded092f 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -79,6 +79,8 @@
 
 #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
 
+#define MADV_SPLIT	26		/* Enable hugepage high-granularity APIs */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d27fe05d5ef6..5bd53ae8ca4b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -92,7 +92,6 @@ struct mutex *hugetlb_fault_mutex_table ____cacheline_aligned_in_smp;
 /* Forward declaration */
 static int hugetlb_acct_memory(struct hstate *h, long delta);
 static void hugetlb_vma_lock_free(struct vm_area_struct *vma);
-static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma);
 static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma);
 
 static inline bool subpool_is_free(struct hugepage_subpool *spool)
@@ -361,7 +360,7 @@ static void hugetlb_vma_lock_free(struct vm_area_struct *vma)
 	}
 }
 
-static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
+void hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
 {
 	struct hugetlb_vma_lock *vma_lock;
 
diff --git a/mm/madvise.c b/mm/madvise.c
index 025be3517af1..04ee28992e52 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1011,6 +1011,24 @@ static long madvise_remove(struct vm_area_struct *vma,
 	return error;
 }
 
+static int madvise_split(struct vm_area_struct *vma,
+			 unsigned long *new_flags)
+{
+	if (!is_vm_hugetlb_page(vma) || !hugetlb_hgm_eligible(vma))
+		return -EINVAL;
+	/*
+	 * Attempt to allocate the VMA lock again. If it isn't allocated,
+	 * MADV_COLLAPSE won't work.
+	 */
+	hugetlb_vma_lock_alloc(vma);
+
+	/* PMD sharing doesn't work with HGM. */
+	hugetlb_unshare_all_pmds(vma);
+
+	*new_flags |= VM_HUGETLB_HGM;
+	return 0;
+}
+
 /*
  * Apply an madvise behavior to a region of a vma.  madvise_update_vma
  * will handle splitting a vm area into separate areas, each area with its own
@@ -1089,6 +1107,11 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
 		break;
 	case MADV_COLLAPSE:
 		return madvise_collapse(vma, prev, start, end);
+	case MADV_SPLIT:
+		error = madvise_split(vma, &new_flags);
+		if (error)
+			goto out;
+		break;
 	}
 
 	anon_name = anon_vma_name(vma);
@@ -1183,6 +1206,9 @@ madvise_behavior_valid(int behavior)
 	case MADV_HUGEPAGE:
 	case MADV_NOHUGEPAGE:
 	case MADV_COLLAPSE:
+#endif
+#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
+	case MADV_SPLIT:
 #endif
 	case MADV_DONTDUMP:
 	case MADV_DODUMP:
-- 
2.39.0.314.g84b9a713c41-goog

