Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79437737810
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 01:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjFTX5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 19:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjFTX5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 19:57:36 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDF819F
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 16:57:35 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bf34588085bso3242704276.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 16:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687305454; x=1689897454;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BGbrY/f1fvBNW9z8go6Nnz06u29111qaAGQndqYmZbI=;
        b=P9ZGKNT+TEzfnNjgXfWsFMxrjrmo19InxA9Ltzw94eBOzcf0DrJjIadY39g5B1ARES
         UM8Tb66YAZoM1qvWyjNLmdfb7GBwdGln7qA5RgXbZWXGaZHvI0XHaH/HBL1QpJNOQgUm
         6OloW5Gfvh2xzMIEA3ALlJsZDF0ta5gG6htWRcVitzaGC/HTclOzVZESltb69EPM+Vbp
         ulOrRqMr+3gQkWyLLTEaVyZRb1j645qYTNnqpW50MZl/4SibKrzjz7laJRB/LZnjYsyE
         XMOaY7sjsOrxZl8Y6VKGCVQZWc8BmHDWraN0TJszAdVqPx1QEoL6EPZTqJhDF1Ftewq7
         eOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687305454; x=1689897454;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BGbrY/f1fvBNW9z8go6Nnz06u29111qaAGQndqYmZbI=;
        b=IwOWlrT8F0vRn91nCBV0pb8nDFj7HfW3lUTIoN+Qc9c8g70aN19WpVI/Uuv/wVU0Dn
         igbSYKOdwDfxywZkAkvTxID9pcXAN1ZbCHZjKq3F+DcwZzD4UOZSyl00tWk8td8+je3W
         MRTXleCE0GVrYNbpFw0ReCPsVVzpEQJbdcSMmU1zU2V6sjw1XR3qSN/KzqG32EnrC1E+
         aQHCyaqNoiI5tHOt7ft4QnfY3k0b21qVId+osLg7MA1PzotyMvFOnisoecDv3vOmdtVQ
         m9MK686vjDFE1mM6PHj1kw3NDegvJRrMgw43/JbhrHe63zusYMSzm7KA0oShbydpe6Y9
         z6KQ==
X-Gm-Message-State: AC+VfDxDaD6KJODSd+koF4j7p71HKxSB+gKkBSarZIyICUGE4RnmRK9m
        sAIHmEAH05yoUL5qh6WTmnDo++T0HZM=
X-Google-Smtp-Source: ACHHUZ6kw7oTpcpzUTFKAorHv5DtOn6LBqwlXR1p5RtO+KTrOjHZ+LXWbslSzGMAafSpF8zUkeChCRjPRTw=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:3f57:9854:e19:8906])
 (user=surenb job=sendgmr) by 2002:a5b:bc9:0:b0:bad:41b:f343 with SMTP id
 c9-20020a5b0bc9000000b00bad041bf343mr5127082ybr.1.1687305454340; Tue, 20 Jun
 2023 16:57:34 -0700 (PDT)
Date:   Tue, 20 Jun 2023 16:57:26 -0700
In-Reply-To: <20230620235726.3873043-1-surenb@google.com>
Mime-Version: 1.0
References: <20230620235726.3873043-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230620235726.3873043-3-surenb@google.com>
Subject: [PATCH 3/3] mm: check for VMA being detached before destroying it
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, torvalds@linuxfoundation.org,
        vegard.nossum@oracle.com, mpe@ellerman.id.au,
        Liam.Howlett@oracle.com, lrh2000@pku.edu.cn, mgorman@suse.de,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By the time VMA is freed it has to be detached with the exception of
exit_mmap which is destroying the whole VMA tree. Enforce this
requirement before freeing the VMA. exit_mmap in the only user calling
__vm_area_free directly, therefore it won't trigger the new check.
Change VMA initialization to mark new VMAs as detached and change that
flag once the VMA is added into a tree.

Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h | 4 ++--
 kernel/fork.c      | 2 ++
 mm/internal.h      | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 74e3033c9fc2..9a10fcdb134e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -247,7 +247,7 @@ void setup_initial_init_mm(void *start_code, void *end_code,
 struct vm_area_struct *vm_area_alloc(struct mm_struct *);
 struct vm_area_struct *vm_area_dup(struct vm_area_struct *);
 void vm_area_free(struct vm_area_struct *);
-/* Use only if VMA has no other users */
+/* Use only if VMA has no other users and might still be attached to a tree */
 void __vm_area_free(struct vm_area_struct *vma);
 
 #ifndef CONFIG_MMU
@@ -751,7 +751,7 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 	vma->vm_mm = mm;
 	vma->vm_ops = &dummy_vm_ops;
 	INIT_LIST_HEAD(&vma->anon_vma_chain);
-	vma_mark_detached(vma, false);
+	vma->detached = true;
 	vma_numab_state_init(vma);
 }
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 41c964104b58..000fc429345c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -540,6 +540,7 @@ static void vm_area_free_rcu_cb(struct rcu_head *head)
 
 	/* The vma should not be locked while being destroyed. */
 	VM_BUG_ON_VMA(rwsem_is_locked(&vma->vm_lock->lock), vma);
+	WARN_ON_ONCE(!vma->detached);
 	__vm_area_free(vma);
 }
 #endif
@@ -549,6 +550,7 @@ void vm_area_free(struct vm_area_struct *vma)
 #ifdef CONFIG_PER_VMA_LOCK
 	call_rcu(&vma->vm_rcu, vm_area_free_rcu_cb);
 #else
+	WARN_ON_ONCE(!vma->detached);
 	__vm_area_free(vma);
 #endif
 }
diff --git a/mm/internal.h b/mm/internal.h
index 68410c6d97ac..728189e6c703 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1068,6 +1068,7 @@ static inline void vma_iter_store(struct vma_iterator *vmi,
 	vmi->mas.index = vma->vm_start;
 	vmi->mas.last = vma->vm_end - 1;
 	mas_store_prealloc(&vmi->mas, vma);
+	vma_mark_detached(vma, false);
 }
 
 static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
-- 
2.41.0.162.gfafddb0af9-goog

