Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76167698BC6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjBPFVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 00:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjBPFUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:20:48 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AF1460A3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:19:19 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-52ec987d600so8366607b3.21
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gCR40Nt3TWmXm3CiMW8diiOUlGd9n6tZbm3lsLizpE8=;
        b=JAL2Aq1jm/4r1JqeZYEWBrue/W3MPTrJmtqCzmWLkH/WIKCq/WNMS7CZcuyalyxOey
         IosycXB+MxcwT4QBmmHaciSLx6z1YK/qs/xuZHAZ6O8LZPapUolphd/QYky6xf7HXG4m
         TIajJoSTXZu0Yk9TmYuKl91OepBHI9VMsFb9wtZhCPHchjEtdJSeWxPPYnIrHgMp6AHH
         zReb74rJ9HRrecOXakA/GD9/YkepqNwyoeE0Te0FwV1uNkov7IGEqryUYtJWv/bTKuMJ
         k46shKzXYlPWW+imaaqXvyzMwcruK2EkfBqoUiODxJ9SCK0t0Bhmm1Z4Ww2xAI1rN1gq
         fZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gCR40Nt3TWmXm3CiMW8diiOUlGd9n6tZbm3lsLizpE8=;
        b=ne2K9KfM1ct5nTmkX7ZN4nf31K0RWOY4fgfp3HjE1tLCv5IRVCzXsWF9smSE+pmDs7
         cu49UBbmaUYU8wp6VqKk3mztEfx+B+cgIHtXax+NjwmCul2lnt2XvGlVycCd1fuygooC
         06E9MJ0esIG+qcz6SjeyyNKzGt64hAJzEMlxnjlnIgXfP6gzvFqC+fTFSuzDxQhU152m
         x+NJbYnFYSFWRrYBxXZCLH+bymZShB/E0BA1/++vZMGsmlIKy7hgfb6kBGDw6tMwHsws
         wm9vQlYqxFfRiUG9EQiCwyFQiT//Kdqh/R/hm6QtZ1u/KAGPVavZJmDWAcTIdYdxEKvm
         Ns5g==
X-Gm-Message-State: AO0yUKUq/dtOs4gzVO6zXEXxAZYPc8QqHZOSck2JtSzb0qpbZG41Lnq0
        RHDB7C51Ux3ZvLUhLhtzmlVBfSklfzg=
X-Google-Smtp-Source: AK7set+zfCXRRrabneP7jbhvgAuIkh3ByJMNAQijkS9aLyX/yWFovh9nbJLYkoOZH5rfO4SiFvvO8qqtNyU=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:f781:d5ed:1806:6ebb])
 (user=surenb job=sendgmr) by 2002:a5b:609:0:b0:80b:adf8:4f9b with SMTP id
 d9-20020a5b0609000000b0080badf84f9bmr575565ybq.33.1676524756940; Wed, 15 Feb
 2023 21:19:16 -0800 (PST)
Date:   Wed, 15 Feb 2023 21:17:49 -0800
In-Reply-To: <20230216051750.3125598-1-surenb@google.com>
Mime-Version: 1.0
References: <20230216051750.3125598-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230216051750.3125598-35-surenb@google.com>
Subject: [PATCH v3 34/35] mm/mmap: free vm_area_struct without call_rcu in exit_mmap
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com, paulmck@kernel.org,
        mingo@redhat.com, will@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        chriscli@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, rppt@kernel.org, jannh@google.com,
        shakeelb@google.com, tatashin@google.com, edumazet@google.com,
        gthelen@google.com, gurua@google.com, arjunroy@google.com,
        soheil@google.com, leewalsh@google.com, posk@google.com,
        michalechner92@googlemail.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Suren Baghdasaryan <surenb@google.com>
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

call_rcu() can take a long time when callback offloading is enabled.
Its use in the vm_area_free can cause regressions in the exit path when
multiple VMAs are being freed.
Because exit_mmap() is called only after the last mm user drops its
refcount, the page fault handlers can't be racing with it. Any other
possible user like oom-reaper or process_mrelease are already synchronized
using mmap_lock. Therefore exit_mmap() can free VMAs directly, without
the use of call_rcu().
Expose __vm_area_free() and use it from exit_mmap() to avoid possible
call_rcu() floods and performance regressions caused by it.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h |  2 ++
 kernel/fork.c      |  2 +-
 mm/mmap.c          | 11 +++++++----
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3c9167529417..cedef02dfd2b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -256,6 +256,8 @@ void setup_initial_init_mm(void *start_code, void *end_code,
 struct vm_area_struct *vm_area_alloc(struct mm_struct *);
 struct vm_area_struct *vm_area_dup(struct vm_area_struct *);
 void vm_area_free(struct vm_area_struct *);
+/* Use only if VMA has no other users */
+void __vm_area_free(struct vm_area_struct *vma);
 
 #ifndef CONFIG_MMU
 extern struct rb_root nommu_region_tree;
diff --git a/kernel/fork.c b/kernel/fork.c
index a08cc0e2bfde..d0999de82f94 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -480,7 +480,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 	return new;
 }
 
-static void __vm_area_free(struct vm_area_struct *vma)
+void __vm_area_free(struct vm_area_struct *vma)
 {
 	free_anon_vma_name(vma);
 	kmem_cache_free(vm_area_cachep, vma);
diff --git a/mm/mmap.c b/mm/mmap.c
index adf40177e68f..d847be615720 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -133,7 +133,7 @@ void unlink_file_vma(struct vm_area_struct *vma)
 /*
  * Close a vm structure and free it.
  */
-static void remove_vma(struct vm_area_struct *vma)
+static void remove_vma(struct vm_area_struct *vma, bool unreachable)
 {
 	might_sleep();
 	if (vma->vm_ops && vma->vm_ops->close)
@@ -141,7 +141,10 @@ static void remove_vma(struct vm_area_struct *vma)
 	if (vma->vm_file)
 		fput(vma->vm_file);
 	mpol_put(vma_policy(vma));
-	vm_area_free(vma);
+	if (unreachable)
+		__vm_area_free(vma);
+	else
+		vm_area_free(vma);
 }
 
 static inline struct vm_area_struct *vma_prev_limit(struct vma_iterator *vmi,
@@ -2135,7 +2138,7 @@ static inline void remove_mt(struct mm_struct *mm, struct ma_state *mas)
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted += nrpages;
 		vm_stat_account(mm, vma->vm_flags, -nrpages);
-		remove_vma(vma);
+		remove_vma(vma, false);
 	}
 	vm_unacct_memory(nr_accounted);
 	validate_mm(mm);
@@ -3085,7 +3088,7 @@ void exit_mmap(struct mm_struct *mm)
 	do {
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted += vma_pages(vma);
-		remove_vma(vma);
+		remove_vma(vma, true);
 		count++;
 		cond_resched();
 	} while ((vma = mas_find(&mas, ULONG_MAX)) != NULL);
-- 
2.39.1

