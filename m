Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6EF6A484E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjB0RjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjB0Ric (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:38:32 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE9C59C7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:56 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id e1-20020a17090301c100b0019cd429f407so3941718plh.17
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F3L0KDnzHjfWSabmEfm0QwnSpYouz37Z4kQXdx4wyok=;
        b=AIld2qfh1hJ81pjBHIB2k6hHEBq4B9cQ7unRZ/ajU5zus4NStrM4vKSoC+D3xf5i2V
         I3lWxazmPww6pY3JnOd6ILpcq/3gMzUiBxySkT7gq+qA5zIjvIc98kXlCsV1T3OkgNoC
         wkB+0CjdoEsCW0SjfCSG1j8AzXTBtq+xLwxdRi9trKrWP6pzQ/z8RPgzdw1aTSBFWEFp
         tuWqf3fIoKXV2B5eA1r5q/mXlFY1b1mqVSiItBYfUpJVFKPT1XTPlAbMteQM7dFl9Yt7
         rI/aJtYFzH6GTH9qBEbz2dvU/L39seWUdch/8Eafr+7mGpiemwVm0woR+UJD5ik1qt28
         1vdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F3L0KDnzHjfWSabmEfm0QwnSpYouz37Z4kQXdx4wyok=;
        b=d83EgRTqfl9+qv5ad6oOXSx49I3DVx7k+fUkcrmaOR4pC/9rrgmLGeMiMo+Hws48iF
         k2c4rcCJ2H14yE9HbzSIhagA3MzwgR3IR2exE51Kj8vjpXxItb7WRcZxa2fXrIcNvOFl
         tROTI3wFw6JqKuqcY3n35TY3pdO9cSM01E0nA6uKUYFpja1GQ8C9xkGw36rlg0DRxXfc
         1e+DCr334pWTkh+dyCffavPssmJTERM1i8QvfHTgf0hcn15Vf8MUdOoWYlLL2aT7Cst6
         F3+PsWCbeZdcXepYWJUgSFbO9jVZpq4BNV5DnaId5hXmFA8gN7jf8N1wBWziQS8DeeI9
         CkKw==
X-Gm-Message-State: AO0yUKX2rt2SYKsdgJSRmZxeMgJn4dvUUwXP67SRCvAVXzsaaEgdE7bb
        f4vTMqcOv3+ktbcu1ZXbe/B0/6zlSig=
X-Google-Smtp-Source: AK7set/h2/2/QuyVN0yF0KgPZgsVR0g2a/0YsQFw2JhIAgW+zKPw0n5+assM7s0mQSWtQbHur04pQimjpmw=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:e1f6:21d1:eead:3897])
 (user=surenb job=sendgmr) by 2002:a17:90a:b388:b0:234:ba6f:c97a with SMTP id
 e8-20020a17090ab38800b00234ba6fc97amr24135pjr.3.1677519473325; Mon, 27 Feb
 2023 09:37:53 -0800 (PST)
Date:   Mon, 27 Feb 2023 09:36:31 -0800
In-Reply-To: <20230227173632.3292573-1-surenb@google.com>
Mime-Version: 1.0
References: <20230227173632.3292573-1-surenb@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230227173632.3292573-33-surenb@google.com>
Subject: [PATCH v4 32/33] mm/mmap: free vm_area_struct without call_rcu in exit_mmap
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
index d07ac923333f..5e142bfe7a58 100644
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
index bdb55f25895d..ad37f1d0c5ab 100644
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
index df13c33498db..0cd3714c2182 100644
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
@@ -2130,7 +2133,7 @@ static inline void remove_mt(struct mm_struct *mm, struct ma_state *mas)
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted += nrpages;
 		vm_stat_account(mm, vma->vm_flags, -nrpages);
-		remove_vma(vma);
+		remove_vma(vma, false);
 	}
 	vm_unacct_memory(nr_accounted);
 	validate_mm(mm);
@@ -3070,7 +3073,7 @@ void exit_mmap(struct mm_struct *mm)
 	do {
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted += vma_pages(vma);
-		remove_vma(vma);
+		remove_vma(vma, true);
 		count++;
 		cond_resched();
 	} while ((vma = mas_find(&mas, ULONG_MAX)) != NULL);
-- 
2.39.2.722.g9855ee24e9-goog

