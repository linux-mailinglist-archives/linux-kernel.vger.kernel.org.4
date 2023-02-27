Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627536A4842
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjB0Rir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjB0RiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:38:01 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09D72449F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:32 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536bbaeceeaso152738957b3.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=arZZ82aLoZGzTODI4V3Ds+XnXRSv5CvpGtFg8O7kSHU=;
        b=FEvdPkuedKMzzGsmheGWPizHKb0nGjYHVNnx+9kAk6JWaGUBiX99d1Bv/O2GM6XSSl
         gB8+ecHQ4IjEhzwJPfml0bM5L6LYZ2SwUORgwjGkuiwqlRjsYJT4KPxwzw1UlC60m4aZ
         A90w9fKe9n+yvmErALp7FrbdpDMG/bmb9rYVdsVvHwUyt0atMOUCv41ig6x8R+tdHGZS
         c/nc1AnKLbHyXNdSxCybAre4lyR5J1UNPqZOtvyqt/5yJckeBvBSk6OPvMXjo6UK2C1R
         s7BFEuIEED1IHyyqkGYjy7EtZvl+QTa1y4yJouRGAzmHG8rSxuivFT0pWoYd4Spinq1k
         BQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=arZZ82aLoZGzTODI4V3Ds+XnXRSv5CvpGtFg8O7kSHU=;
        b=qjSpG2Y2h7n+yazIQgurYij6+rDu5yKYr1YjuQXX4yD9X6PoQlBqHjPWlHrBTj4y09
         f5BQLxfAsBwUPss1esalNFiFu2WnVpMHzgmfKkd9RIIRmc2BFWjeYgIVDuOVEyRcY7Jz
         6rzo6cSudD7fT7Z9dV9wsMOjL0iC1I72v85kxhEpCYuxoEuqegL5k7Z6uf0gchTMf7pP
         KeezjPxC+aBW/Eg7wxenvZ2V3eU8nJRqNh2KzrBwVizjEAOs1yJTAMLW4zC9FBbpGzT0
         m5Onk65UwoPtHtYaSFi/jJCHVt0No6CdzaDQQOWzkGTYx+YOChKWPsFk9WJl/bRe+Di0
         8d0A==
X-Gm-Message-State: AO0yUKVxFbxx1L3wQx/4WDcXjQS34+BWGRDRrwlAZ5BADFZaTTv8HhFn
        w6QtH/3mlZpp3Vz5ntFi/8iSy+X/4V4=
X-Google-Smtp-Source: AK7set/UVPuqJo669/ldHphDhViQWe/utENdYlZ/T7NeJi51KLkDK1GElSVGwaBDs6B97rQ0tmz39GqO0ZQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:e1f6:21d1:eead:3897])
 (user=surenb job=sendgmr) by 2002:a81:ac68:0:b0:535:18be:4126 with SMTP id
 z40-20020a81ac68000000b0053518be4126mr10693031ywj.6.1677519449031; Mon, 27
 Feb 2023 09:37:29 -0800 (PST)
Date:   Mon, 27 Feb 2023 09:36:21 -0800
In-Reply-To: <20230227173632.3292573-1-surenb@google.com>
Mime-Version: 1.0
References: <20230227173632.3292573-1-surenb@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230227173632.3292573-23-surenb@google.com>
Subject: [PATCH v4 22/33] mm: introduce vma detached flag
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

Per-vma locking mechanism will search for VMA under RCU protection and
then after locking it, has to ensure it was not removed from the VMA
tree after we found it. To make this check efficient, introduce a
vma->detached flag to mark VMAs which were removed from the VMA tree.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h       | 11 +++++++++++
 include/linux/mm_types.h |  3 +++
 mm/mmap.c                |  2 ++
 3 files changed, 16 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3d5e8666892d..895bb3950e8a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -693,6 +693,14 @@ static inline void vma_assert_write_locked(struct vm_area_struct *vma)
 	VM_BUG_ON_VMA(vma->vm_lock_seq != READ_ONCE(vma->vm_mm->mm_lock_seq), vma);
 }
 
+static inline void vma_mark_detached(struct vm_area_struct *vma, bool detached)
+{
+	/* When detaching vma should be write-locked */
+	if (detached)
+		vma_assert_write_locked(vma);
+	vma->detached = detached;
+}
+
 #else /* CONFIG_PER_VMA_LOCK */
 
 static inline void vma_init_lock(struct vm_area_struct *vma) {}
@@ -701,6 +709,8 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
 static inline void vma_end_read(struct vm_area_struct *vma) {}
 static inline void vma_start_write(struct vm_area_struct *vma) {}
 static inline void vma_assert_write_locked(struct vm_area_struct *vma) {}
+static inline void vma_mark_detached(struct vm_area_struct *vma,
+				     bool detached) {}
 
 #endif /* CONFIG_PER_VMA_LOCK */
 
@@ -712,6 +722,7 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 	vma->vm_mm = mm;
 	vma->vm_ops = &dummy_vm_ops;
 	INIT_LIST_HEAD(&vma->anon_vma_chain);
+	vma_mark_detached(vma, false);
 	vma_init_lock(vma);
 }
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index a4e7493bacd7..45a219d33c6b 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -511,6 +511,9 @@ struct vm_area_struct {
 #ifdef CONFIG_PER_VMA_LOCK
 	int vm_lock_seq;
 	struct rw_semaphore lock;
+
+	/* Flag to indicate areas detached from the mm->mm_mt tree */
+	bool detached;
 #endif
 
 	/*
diff --git a/mm/mmap.c b/mm/mmap.c
index b947d82e8522..df13c33498db 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -600,6 +600,7 @@ static inline void vma_complete(struct vma_prepare *vp,
 
 	if (vp->remove) {
 again:
+		vma_mark_detached(vp->remove, true);
 		if (vp->file) {
 			uprobe_munmap(vp->remove, vp->remove->vm_start,
 				      vp->remove->vm_end);
@@ -2261,6 +2262,7 @@ static inline int munmap_sidetree(struct vm_area_struct *vma,
 	if (mas_store_gfp(mas_detach, vma, GFP_KERNEL))
 		return -ENOMEM;
 
+	vma_mark_detached(vma, true);
 	if (vma->vm_flags & VM_LOCKED)
 		vma->vm_mm->locked_vm -= vma_pages(vma);
 
-- 
2.39.2.722.g9855ee24e9-goog

