Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DD069B6BB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjBRA3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjBRA2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:28:51 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C6D68AD1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:28:50 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536582abb72so22511017b3.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wk7vTpC+014vSbmA7BXLNrcppJOJiIEYznqCa6jfXqI=;
        b=L4T7D1Q77q9QoOsnz1tm6Qf6BnOnAK2ZGTzjyBq232kdcaHnTPLu0KkbIFKg2iqZGi
         ur2eS2TG9FID8wSfSSNIUDRAH4/hc4cg6N78xCCSSvyxSCrRt7XxD8Kq9J+3/utwUlNa
         XwiHxLMwsKt54AmsMKUm23cdHK0jjFppi4B8oAiG6cdvRInp32jKLbSvstKyMXiqo8UK
         07XHP/2+lJH0n/T1p+F0gJBrThd4SgIk1odXs4Xk0ZR7hodPP4o/xUlKaYBCidUzDuQ8
         b+jdsTQykyqbj5MGq0jpb+xO5JrvhEf0KZUw8P19p8z3GR5sTSonXH6Em23ytW9e2DzL
         g/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wk7vTpC+014vSbmA7BXLNrcppJOJiIEYznqCa6jfXqI=;
        b=VU/kYh2YLkc4Pgq3AXqOM48MzXWsWoCVL3Y4iPPyZDykghSyXb4IQO7TH5X7u+jom6
         jurRhl+ucqR7oxsZAASoea47zGOuBU+D7WfNJf4nrF1H2pKxpFvT2LUlY97y1arTJsMG
         uvObI/VHKzvHKpavYhRsZwVl4gSicaalsiUyVayp7lfJQuRzdHpqnwjKleU7MMyAyY5l
         AL2YI2vX1/jNC1JZl5BJQ9MFh6Vn1Ez5FgaxR9mOPyDUCXuRu7kAtghKJKAJq6HSCLfT
         BP6xNO9/fX17eVby/mntmUwOaqxze+6ik94m2KrKbNxJdt5+GDIoCMt7nU4G8uAr5KXo
         INRA==
X-Gm-Message-State: AO0yUKVhn3hRpRdPGX6T/iskMO6hWI340N9wrX1HaFYN8U74nQYY4tsz
        f+zEWSL+WUQnTA2WSGwWUGZNQ5egBYE3Nb3G
X-Google-Smtp-Source: AK7set9Co62mLp/e8p6CW/1K+ZyZaQWY5gSTbmZ9xHWOnSJaaxinPhJ3ofPuLxwknQEtxTaVNR5J+AVeIdAiLUtz
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a5b:4c3:0:b0:904:2aa2:c26c with SMTP id
 u3-20020a5b04c3000000b009042aa2c26cmr196573ybp.5.1676680130224; Fri, 17 Feb
 2023 16:28:50 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:27:40 +0000
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-8-jthoughton@google.com>
Subject: [PATCH v2 07/46] mm: add VM_HUGETLB_HGM VMA flag
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

VM_HUGETLB_HGM indicates that a HugeTLB VMA may contain high-granularity
mappings. Its VmFlags string is "hm".

Signed-off-by: James Houghton <jthoughton@google.com>

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 6a96e1713fd5..77b72f42556a 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -711,6 +711,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
 		[ilog2(VM_UFFD_MINOR)]	= "ui",
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
+#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
+		[ilog2(VM_HUGETLB_HGM)]	= "hm",
+#endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
 	};
 	size_t i;
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2992a2d55aee..9d3216b4284a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -383,6 +383,13 @@ extern unsigned int kobjsize(const void *objp);
 # define VM_UFFD_MINOR		VM_NONE
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
 
+#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
+# define VM_HUGETLB_HGM_BIT	38
+# define VM_HUGETLB_HGM		BIT(VM_HUGETLB_HGM_BIT)	/* HugeTLB high-granularity mapping */
+#else /* !CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
+# define VM_HUGETLB_HGM		VM_NONE
+#endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
+
 /* Bits set in the VMA until the stack is in its final location */
 #define VM_STACK_INCOMPLETE_SETUP	(VM_RAND_READ | VM_SEQ_READ)
 
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 9db52bc4ce19..bceb960dbada 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -162,6 +162,12 @@ IF_HAVE_PG_SKIP_KASAN_POISON(PG_skip_kasan_poison, "skip_kasan_poison")
 # define IF_HAVE_UFFD_MINOR(flag, name)
 #endif
 
+#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
+# define IF_HAVE_HUGETLB_HGM(flag, name) {flag, name},
+#else
+# define IF_HAVE_HUGETLB_HGM(flag, name)
+#endif
+
 #define __def_vmaflag_names						\
 	{VM_READ,			"read"		},		\
 	{VM_WRITE,			"write"		},		\
@@ -186,6 +192,7 @@ IF_HAVE_UFFD_MINOR(VM_UFFD_MINOR,	"uffd_minor"	)		\
 	{VM_ACCOUNT,			"account"	},		\
 	{VM_NORESERVE,			"noreserve"	},		\
 	{VM_HUGETLB,			"hugetlb"	},		\
+IF_HAVE_HUGETLB_HGM(VM_HUGETLB_HGM,	"hugetlb_hgm"	)		\
 	{VM_SYNC,			"sync"		},		\
 	__VM_ARCH_SPECIFIC_1				,		\
 	{VM_WIPEONFORK,			"wipeonfork"	},		\
-- 
2.39.2.637.g21b0678d19-goog

