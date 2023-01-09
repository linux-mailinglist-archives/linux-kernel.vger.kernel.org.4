Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A805A6631EE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237496AbjAIUyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237338AbjAIUyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:54:05 -0500
Received: from mail-oi1-x24a.google.com (mail-oi1-x24a.google.com [IPv6:2607:f8b0:4864:20::24a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAE374598
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:54:04 -0800 (PST)
Received: by mail-oi1-x24a.google.com with SMTP id b8-20020a056808010800b0035e342ff33aso3044932oie.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 12:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D1pZqRdf8jzuIQZRLrMCJmLqIEvbyFYNYfXzudRZz6Y=;
        b=plHU/zWrfFxaQ0yt/JPDRB18eEsMPdd+ZJ4E4yT8T5NRkdKBZYZu2kA11sksr3NXzt
         jDgkb12AloyToG1qepTp/9j3c1S/nL9/sMLfiUGj3EbCeKSxNDyG2Qbnp2R8KUfjKQNu
         1hUjiCYEdhUY2xqldYVyznhCdRudSDrsopmij1IaAdQfZY5giCy+PasuJa7G7ZNci7e/
         L6oXIEMKihljCOjvvq+Mko/UGqlkYlK33Q2p9mFgU8soW7h5CIdjJbM9Bn0dub4CcI+s
         5hJtucAeeWPqjUkI2FPiSFxFnJ3u2uppPiS920i95ViALBCSjuucJs6UET/oQp6p8GLF
         Q6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D1pZqRdf8jzuIQZRLrMCJmLqIEvbyFYNYfXzudRZz6Y=;
        b=NV+uWW8kSqjnzXC7qxYInTBwa5wfHfVMsbOIQqaJNekLb+x92UzFDOITuhZVR35I6M
         maTYcagBmSw0p6cnWX89HQoEBJvKXb9HC4Goe4mRSE0CFeDkkIureH+3F/kWsmUTykEu
         QAbPgrH77pV5CpM3UqJ3AkCYpu6Ncz2J4oGtouexcSyikyhKH6ByLtagDS9ErMbkOE6r
         ViT1xBKbZQiSTFzm/T9E7orv1aCzM0CokbzxMzmOEmKxy3hiupTsRLk0rumgEZdQ5Pqe
         jGyF6CL5IDaHnnYhQOsIgljGyx+qK5WAP1pRaPUNMFamMOHOJWSFZneA5woLsMQ9EORT
         td+Q==
X-Gm-Message-State: AFqh2kppwJH6haqOwDXv8UaB65ED3bl/GpTGkLwz6VFs7LRqjzVnYVa1
        IwmsGmNXlqfR8JqNfMj6XbWlDVi0uuY=
X-Google-Smtp-Source: AMrXdXv95OTi9We7BklH2FBX3pkox2UVBRMtva8Mm7ne7fTGkQBBnTiOs3huBoDZBy+tfDGkNugi4GYzEh4=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:9393:6f7a:d410:55ca])
 (user=surenb job=sendgmr) by 2002:a05:6870:649e:b0:143:509f:17f0 with SMTP id
 cz30-20020a056870649e00b00143509f17f0mr4940900oab.211.1673297643629; Mon, 09
 Jan 2023 12:54:03 -0800 (PST)
Date:   Mon,  9 Jan 2023 12:53:04 -0800
In-Reply-To: <20230109205336.3665937-1-surenb@google.com>
Mime-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230109205336.3665937-10-surenb@google.com>
Subject: [PATCH 09/41] mm: rcu safe VMA freeing
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        surenb@google.com
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

From: Michel Lespinasse <michel@lespinasse.org>

This prepares for page faults handling under VMA lock, looking up VMAs
under protection of an rcu read lock, instead of the usual mmap read lock.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm_types.h | 13 ++++++++++---
 kernel/fork.c            | 13 +++++++++++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 4b6bce73fbb4..d5cdec1314fe 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -535,9 +535,16 @@ struct anon_vma_name {
 struct vm_area_struct {
 	/* The first cache line has the info for VMA tree walking. */
 
-	unsigned long vm_start;		/* Our start address within vm_mm. */
-	unsigned long vm_end;		/* The first byte after our end address
-					   within vm_mm. */
+	union {
+		struct {
+			/* VMA covers [vm_start; vm_end) addresses within mm */
+			unsigned long vm_start;
+			unsigned long vm_end;
+		};
+#ifdef CONFIG_PER_VMA_LOCK
+		struct rcu_head vm_rcu;	/* Used for deferred freeing. */
+#endif
+	};
 
 	struct mm_struct *vm_mm;	/* The address space we belong to. */
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 58aab6c889a4..5986817f393c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -479,10 +479,23 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 	return new;
 }
 
+#ifdef CONFIG_PER_VMA_LOCK
+static void __vm_area_free(struct rcu_head *head)
+{
+	struct vm_area_struct *vma = container_of(head, struct vm_area_struct,
+						  vm_rcu);
+	kmem_cache_free(vm_area_cachep, vma);
+}
+#endif
+
 void vm_area_free(struct vm_area_struct *vma)
 {
 	free_anon_vma_name(vma);
+#ifdef CONFIG_PER_VMA_LOCK
+	call_rcu(&vma->vm_rcu, __vm_area_free);
+#else
 	kmem_cache_free(vm_area_cachep, vma);
+#endif
 }
 
 static void account_kernel_stack(struct task_struct *tsk, int account)
-- 
2.39.0

