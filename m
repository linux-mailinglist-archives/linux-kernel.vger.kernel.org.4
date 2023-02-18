Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D2E69B6BC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjBRA3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjBRA3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:29:15 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517526A050
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:28:53 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5366c11a9e2so12373607b3.17
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gzu9Oqr9H8Fn0tUeHEDWXYAlOB8OWdsieehz/zpOW6k=;
        b=tYpmmFQzEgrObj/2FMcbtdaJQm3sazU5VnbVoR+zz6vUh7rASk45yjIKn2FedC7eo+
         64TFERWH3kAocQ35djKIpY0U7uy4JBvt4LsnfsaNiT08MQoKwPApF8bVx1iphGbWHeEc
         IMInRpDhVgnidOgxuvPZq1H7/CcXyiRAgK7ISL6kaB1IUSOqgvGwY430h2xrB2v8neVQ
         8AN2tGoltRJlPrCZJ1MuICMziVOgA+TSNCC1pOgqumOa93V1to2Sec2gOzLTecmc35fN
         74QeAtnqV0HzcQ4DlaDW3Lxjmfem+TFSMTYeknGNL3g2HO+TM9ub4VO/dStuPqoBrn6U
         ZpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gzu9Oqr9H8Fn0tUeHEDWXYAlOB8OWdsieehz/zpOW6k=;
        b=a93MA8VZ8t8TtJv26HE1lm7513AIX+3ERm69v5wHfx0caROyNWexI4Su/Smm67Stn2
         hLfwxFfpAdFCYcn44wxSf54p9FY4ny+dc3ZDoJqrZmo0n+ymWXgjxAHgQRY7qRAQbbAQ
         sr03ioIzCOW78Hlah5Fe83OlccLcqA+AiNL4viGCf4vbySsyhDSEzg6hJMeyriCn4r1y
         5Q6MmO1gsxIRJ+CBwNUEsatMZH3OH2GeyOwgyScPCqrKPAumX6/8vWkdGRsXOo0RyNLW
         iuDozqu8CHUfmMbR5Hm4cqcmlFJtlPBjXv04ejWmrg+irsoX1mRrBR3jYNLsoQssT87D
         E8oA==
X-Gm-Message-State: AO0yUKUWztCEyXAzbrZ79lUKD8st0Ht7yksB7/OB+w7kE7VMlZhm4XBZ
        R1eI4w64b8NZk642KCmGfZ+uPvy56wDpKP9G
X-Google-Smtp-Source: AK7set9Ig32WWEUYTKzsQPjrHFiRL8Rvh2WamhJ5X+omJqqagrRjDEce35WMrY5ZjwX5thzjLfDORxzKFgGHjUzE
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6902:1024:b0:8fc:686c:cf87 with
 SMTP id x4-20020a056902102400b008fc686ccf87mr53474ybt.4.1676680132546; Fri,
 17 Feb 2023 16:28:52 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:27:42 +0000
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-10-jthoughton@google.com>
Subject: [PATCH v2 09/46] mm: add MADV_SPLIT to enable HugeTLB HGM
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
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
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
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
 
diff --git a/mm/madvise.c b/mm/madvise.c
index c2202f51e9dd..8c004c678262 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1006,6 +1006,28 @@ static long madvise_remove(struct vm_area_struct *vma,
 	return error;
 }
 
+static int madvise_split(struct vm_area_struct *vma,
+			 unsigned long *new_flags)
+{
+#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
+	if (!is_vm_hugetlb_page(vma) || !hugetlb_hgm_eligible(vma))
+		return -EINVAL;
+
+	/*
+	 * PMD sharing doesn't work with HGM. If this MADV_SPLIT is on part
+	 * of a VMA, then we will split the VMA. Here, we're unsharing before
+	 * splitting because it's simpler, although we may be unsharing more
+	 * than we need.
+	 */
+	hugetlb_unshare_all_pmds(vma);
+
+	*new_flags |= VM_HUGETLB_HGM;
+	return 0;
+#else
+	return -EINVAL;
+#endif
+}
+
 /*
  * Apply an madvise behavior to a region of a vma.  madvise_update_vma
  * will handle splitting a vm area into separate areas, each area with its own
@@ -1084,6 +1106,11 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
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
@@ -1178,6 +1205,9 @@ madvise_behavior_valid(int behavior)
 	case MADV_HUGEPAGE:
 	case MADV_NOHUGEPAGE:
 	case MADV_COLLAPSE:
+#endif
+#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
+	case MADV_SPLIT:
 #endif
 	case MADV_DONTDUMP:
 	case MADV_DODUMP:
@@ -1368,6 +1398,8 @@ int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
  *		transparent huge pages so the existing pages will not be
  *		coalesced into THP and new pages will not be allocated as THP.
  *  MADV_COLLAPSE - synchronously coalesce pages into new THP.
+ *  MADV_SPLIT - allow HugeTLB pages to be mapped at PAGE_SIZE. This allows
+ *		UFFDIO_CONTINUE to accept PAGE_SIZE-aligned regions.
  *  MADV_DONTDUMP - the application wants to prevent pages in the given range
  *		from being included in its core dump.
  *  MADV_DODUMP - cancel MADV_DONTDUMP: no longer exclude from core dump.
-- 
2.39.2.637.g21b0678d19-goog

