Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5DB65E8CB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbjAEKT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbjAEKTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:19:20 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACA648CCE
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:19:02 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-47ede4426e1so257845227b3.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HIG9BIAJU+cdFn89xXe0LNee36+C1EcX0L4kUoSH9VA=;
        b=CMFdycOsnlaZrP1tfINkoF9MpUwFHEYphAoiyklgUZsVLZG1tYthaAIbMq5iR4qWCX
         OXHWYueDyEFCpfBnjUioieM42w8NXjNUz5fmKNAAz8wLLvn5nPj/Bs9/ErfoA3IO4IPY
         c5oqUYecWCJ1I0u3x2YoT/ifuZ7HYu6l6/zffhFRBo2upvwZyY7aMzs+EuiwuXlkfrtN
         iASt+00Ipmgct2pD5KbpfbNwwHjYtIXrPj370sJlaEw+j7kbcNb7n2JHv67hdVJRv4uI
         ls+rD3wSrKgqrGl9nm1pKSRgOs1WF84oEpvybmix2WpHGSw3rcDgV7GQxKLzlEWTzLiD
         +41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HIG9BIAJU+cdFn89xXe0LNee36+C1EcX0L4kUoSH9VA=;
        b=qRN1WeLS8RBaZAtJXCfqXzGAkMnyu2Yb1aaBD9Pynf+6gM3RPBJilEnDS3FlngxL3o
         753UylRkdvkV13EvFh3OwTjDDdnqqzMqz0qOMXAPqp94eYUozODR2lnV7F9OpieDxx8J
         5XUkBqrXoDNdLtla2KNBjdlkrgLgLpIJlUEURJtAAFBsBW05hMrmGUe8/ccCDQfkEt2l
         w2gVzmyokQHgJNFhoJFr4sPZjtmvmHUz/FynuWWfNQOZoa86IZPLNVvOuZ0DGpW0clI0
         BFteA+sb+1k7DbrVlRjJJbF0YhxGg/V4CFggAJmEBIWgzV5EnxYkg6AgvKBz3q0n3pJR
         m0Gw==
X-Gm-Message-State: AFqh2krKWncdI8CDoNsw4ow8P0CH+UO6PMhIvTip7mknC8UZX6aXzkXl
        axKnyTfHdQ9gZnRCX9MM33eL0ybTdd5IKWrF
X-Google-Smtp-Source: AMrXdXvjR0Xro5c3Mgl40GsMzrllYRIX708i1RiJNWNcFVeIh0ysu1H8PYfOp0t36jr4OJW9kNNJCYFikuDhylAm
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:58c3:0:b0:703:5949:3b2a with SMTP
 id m186-20020a2558c3000000b0070359493b2amr3359803ybb.525.1672913941310; Thu,
 05 Jan 2023 02:19:01 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:18:04 +0000
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-7-jthoughton@google.com>
Subject: [PATCH 06/46] mm: add VM_HUGETLB_HGM VMA flag
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

VM_HUGETLB_HGM indicates that a HugeTLB VMA may contain high-granularity
mappings. Its VmFlags string is "hm".

Signed-off-by: James Houghton <jthoughton@google.com>
---
 fs/proc/task_mmu.c             | 3 +++
 include/linux/mm.h             | 7 +++++++
 include/trace/events/mmflags.h | 7 +++++++
 3 files changed, 17 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index e35a0398db63..41b5509bde0e 100644
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
index c37f9330f14e..738b3605f80e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -372,6 +372,13 @@ extern unsigned int kobjsize(const void *objp);
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
index 412b5a46374c..88ce04b2ff69 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -163,6 +163,12 @@ IF_HAVE_PG_SKIP_KASAN_POISON(PG_skip_kasan_poison, "skip_kasan_poison")
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
@@ -187,6 +193,7 @@ IF_HAVE_UFFD_MINOR(VM_UFFD_MINOR,	"uffd_minor"	)		\
 	{VM_ACCOUNT,			"account"	},		\
 	{VM_NORESERVE,			"noreserve"	},		\
 	{VM_HUGETLB,			"hugetlb"	},		\
+IF_HAVE_HUGETLB_HGM(VM_HUGETLB_HGM,	"hugetlb_hgm"	)		\
 	{VM_SYNC,			"sync"		},		\
 	__VM_ARCH_SPECIFIC_1				,		\
 	{VM_WIPEONFORK,			"wipeonfork"	},		\
-- 
2.39.0.314.g84b9a713c41-goog

