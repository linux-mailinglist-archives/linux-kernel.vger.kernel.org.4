Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDECD67EE8C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjA0Tn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjA0TnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:43:00 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C453F82432
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:42:36 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-4ff7c6679f2so65753727b3.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nu9/mdu38G6WtBjXb6Do7xpUyt6CdrDbmAUDhoyp47k=;
        b=oFyOjlhEa6jPD1d+pKzu8xqMu9sShcBJM0zkcdXAO9bWZHfs5hDegJ8sEKWFr4AQNl
         iGPCIH7iC8aR5RiIjRoH9W2KUncZPWl0b5vsJXQEB2UE60mYiP5ldYuNlEW3dM96CgJp
         +2KdvoCyVN7G6APzAMKWAfXHTUhAA+JaJZhJgfnGwlr68Zr0GLZrYj2YnOQkKo96sWGj
         Ng0DOWnRANnP+XQns5edhVeWyYl+9EdfDgkHbYKOkVF++Ku/0IaWanDTI7HqCQuL/w5R
         edw8ZGqmSQJCCmVgs5lV30HhGrOZqx2K3qMJgNbHCqjkT1CdH2dJNnKk0QEKLZZ9jCPS
         y7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nu9/mdu38G6WtBjXb6Do7xpUyt6CdrDbmAUDhoyp47k=;
        b=h3TEow3zRjG0lfCe5mvSQw5za2RRH4bDNJ2uFc8FE1Vk4O+/vca4y+1MhzhifpHZjF
         E8iCbuMu3k8njZgssRUSPH0Nd28ho8ZoHuDe/DrMao42v5gYamGAagDmFjMhhxzkzSY/
         UGAvLWHmSvZ2kK07e9pNJDPSV5292hZDRv7kt29SfJpizclfJMrE8MiPfp73a38gqvcr
         080uEza2rx7zqJmrUmIfF78T30hK+psCMEuX2cREmAgIXE1DQKox+FzA2kkBRXYBECRL
         BwOusTDNLykSbKbiuSxxKy9DNyBUFR0jTkCS2UlXO7udGjoxuP6PcHGuE+YDWaAhj8Q2
         ZRHw==
X-Gm-Message-State: AFqh2krEdkqLw+u/U5/61Hh8v+Wvx4W99aaUMVbiwxIw9pXjUSRW9QFK
        ek0PN/SUSzJ9s7kXfSjfZQEDIW8k5cQ=
X-Google-Smtp-Source: AMrXdXtMMT5r56SGjlxKGvDbQirEmfUIu1ilIQcv1/3wi/4TSk/ascWeVtYTcuwkoFwuriGWfFUnQoKWHlg=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:4e19:be9:c5d0:8483])
 (user=surenb job=sendgmr) by 2002:a0d:cdc7:0:b0:4df:f712:5d57 with SMTP id
 p190-20020a0dcdc7000000b004dff7125d57mr3818080ywd.303.1674848495850; Fri, 27
 Jan 2023 11:41:35 -0800 (PST)
Date:   Fri, 27 Jan 2023 11:40:46 -0800
In-Reply-To: <20230127194110.533103-1-surenb@google.com>
Mime-Version: 1.0
References: <20230127194110.533103-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230127194110.533103-10-surenb@google.com>
Subject: [PATCH v2 09/33] mm: rcu safe VMA freeing
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
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
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
 kernel/fork.c            | 20 +++++++++++++++++++-
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 8410c3052148..62e413f84011 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -480,9 +480,16 @@ struct anon_vma_name {
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
index 5f23d5e03362..314d51eb91da 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -479,12 +479,30 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 	return new;
 }
 
-void vm_area_free(struct vm_area_struct *vma)
+static void __vm_area_free(struct vm_area_struct *vma)
 {
 	free_anon_vma_name(vma);
 	kmem_cache_free(vm_area_cachep, vma);
 }
 
+#ifdef CONFIG_PER_VMA_LOCK
+static void vm_area_free_rcu_cb(struct rcu_head *head)
+{
+	struct vm_area_struct *vma = container_of(head, struct vm_area_struct,
+						  vm_rcu);
+	__vm_area_free(vma);
+}
+#endif
+
+void vm_area_free(struct vm_area_struct *vma)
+{
+#ifdef CONFIG_PER_VMA_LOCK
+	call_rcu(&vma->vm_rcu, vm_area_free_rcu_cb);
+#else
+	__vm_area_free(vma);
+#endif
+}
+
 static void account_kernel_stack(struct task_struct *tsk, int account)
 {
 	if (IS_ENABLED(CONFIG_VMAP_STACK)) {
-- 
2.39.1

