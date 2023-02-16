Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D29698BBC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjBPFUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 00:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjBPFTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:19:39 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4FA47423
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:54 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v63-20020a254842000000b008f257b16d71so842164yba.15
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u26HcyQZUssNB/wvgmnc8FNLt5Bjt6C27EcCpLSHQ2I=;
        b=e8FcGNDH5VkVzBTYRblbtAQ0+ZP2ugsPFuxmDPyoQXwVKDnKFUyAPJn/SJMrsaQ1Ia
         jo+Cd4OdGYV2adIa7Ps1WdQQvf3M0XkBbQCS2vH4hvx3mR4XIU6AeYNJ4fgFw+1soX5Z
         Pa1xM0MUFfbg6JS2S95T1SCUKSw+S8anZTC0et5KKeuEZZM6kRmGtxME3D+du+nzcvgG
         qzTaGZDic4CCJCQNQmsvjPxTw8HSPKOmRJrMlp7St/TdGbLlhdx8Vn9wPFTpNdXttF8Q
         VA64i9yGakw2MEWw1P/yGjLggzJzYv4qMjifZYLSh4iksjXsYnlNyRAbe89au2hayYpB
         yYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u26HcyQZUssNB/wvgmnc8FNLt5Bjt6C27EcCpLSHQ2I=;
        b=sNtkjqp3WiwTltWeeHGLdA0Gx0tGlfGR9f59XRhjXQRZf9+1W3vOYF1joJest+20u3
         dUlA4P6MSjsw+Dt78EkkqzKGRxxrcNCS5qGXNPM8liu3S+CcrFvc9nM+LpDr9ZfsYwgW
         pWPkEzPPIHhi7jfo0dhBeTVXgzjPJ5V9g8axCktdhSDHQ9ZSlzTI5C43jllUNcHeVOt8
         ls9DNm9Xx42TY+G8sIn8Rha5hzT9cYFRlqpkGNUj2RmDHpmosq9J06lEvUpJdoNUwMdb
         ka3+VxZN2fUYEMZQ0Fy0FqMpjSz2wpapGkDYJ9pno9HYwF5vNCvBfmNVqzvJwJhDqWzT
         1Xow==
X-Gm-Message-State: AO0yUKXSrwara7XUqoSGxke4MnoGe97GRepEpNMBc/h3QnheVl9MoNB3
        BejSWlE/oVb771b48BhQeTmFqIp7TzU=
X-Google-Smtp-Source: AK7set8LRdaZWnTNJXEEL+5OavvLJg+SJ7ELgpuDSzdI0PbEuUZjWdo/eOURR51UCivz1X36gI0P4ir+qmc=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:f781:d5ed:1806:6ebb])
 (user=surenb job=sendgmr) by 2002:a05:6902:114f:b0:855:fdcb:4467 with SMTP id
 p15-20020a056902114f00b00855fdcb4467mr31ybu.0.1676524732481; Wed, 15 Feb 2023
 21:18:52 -0800 (PST)
Date:   Wed, 15 Feb 2023 21:17:39 -0800
In-Reply-To: <20230216051750.3125598-1-surenb@google.com>
Mime-Version: 1.0
References: <20230216051750.3125598-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230216051750.3125598-25-surenb@google.com>
Subject: [PATCH v3 24/35] mm: introduce vma detached flag
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
index f4f702224ec5..3f98344f829c 100644
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
index e268723eaf44..939f4f5a1115 100644
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
index 801608726be8..adf40177e68f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -593,6 +593,7 @@ static inline void vma_complete(struct vma_prepare *vp,
 
 	if (vp->remove) {
 again:
+		vma_mark_detached(vp->remove, true);
 		if (vp->file) {
 			uprobe_munmap(vp->remove, vp->remove->vm_start,
 				      vp->remove->vm_end);
@@ -2267,6 +2268,7 @@ static inline int munmap_sidetree(struct vm_area_struct *vma,
 	if (mas_store_gfp(mas_detach, vma, GFP_KERNEL))
 		return -ENOMEM;
 
+	vma_mark_detached(vma, true);
 	if (vma->vm_flags & VM_LOCKED)
 		vma->vm_mm->locked_vm -= vma_pages(vma);
 
-- 
2.39.1

