Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88FA6A4831
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjB0Rhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjB0RhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:37:15 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA772413B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:01 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536b7eb9117so153569677b3.14
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=29YuznebDbhH7LJ7uqA8Selv98qAa02JmRVPnHaqVO4=;
        b=jX0E/sUVT2RKYWg5Tqa21wWzSsitbAZllQiaBV4eWJXbUNmmhHROoBx1qNz1dBdUuE
         WfwseHSvUNs7qQdK+oiHVNrKDTVUoZgUvG4zzPJtFXGpgjghqMQHZP4+pvFGIZY9K8t8
         yTb/HpAgn0jfVzcS4IzWrxVVhGHhJpK4EoMdSwUP/MFG5D0Q4nJDsYGVVLA1YMlIDxWr
         /VFBixWLHZCmRtwCrTiJJEDxVSpInKYA+7RDdnLaY6ZEJ31POIP0qLghcCdmVf5ptWUG
         sRbVaoL3AhiMndAmHz8lepZWlnznP3Urg+vUr3DV+pv2Gj3JIWJnnqJV/02ALHT1NaZc
         S6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=29YuznebDbhH7LJ7uqA8Selv98qAa02JmRVPnHaqVO4=;
        b=A91smaaO37XfvJoDn2eJgGgS0XTGwMFAR6+jf0mRbZ5QOAcdI4jzvP29vIuz3uO+bI
         jdj4WhMmKkJSwei3zvI6+oYW+U+TKUFAbdud7vtGv2gg1FtYW9JruRmwr7BGKpK/zUnM
         s1hLGY10lU87IC/KeeOQkjj27glT0NMVai0fk/6q65NPnG9DgW4mfBujFdOy54yH3H08
         qK40dVwWF+K6/WAQbzgYMyabMvKa2ISvCM++6AFbjmydjWS6/3oGzkg37mAcdEi2r21T
         LAaIDCGQCFGprizkfggYZJiMv3XuZ0ObYWCeL9Ik+ySdCA547KIC3nKF0bZH1mIhECJ6
         B7JA==
X-Gm-Message-State: AO0yUKUXN1drzzkDelNFTLBIyc/K0czofswHBkunfD3nwwNjKyuZyUCQ
        iNkRgs0JbYzEj12MqAR1UcgkfLSg9aU=
X-Google-Smtp-Source: AK7set+1Pq3oRMVl5cZH8khR0Bvwd8LGMD5WFRsqtwPODZNGlHBw37TZClpeLubRs3LjGXy9DC4x47Xc4Uo=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:e1f6:21d1:eead:3897])
 (user=surenb job=sendgmr) by 2002:a25:9390:0:b0:a53:5825:f25b with SMTP id
 a16-20020a259390000000b00a535825f25bmr6018468ybm.0.1677519421007; Mon, 27 Feb
 2023 09:37:01 -0800 (PST)
Date:   Mon, 27 Feb 2023 09:36:09 -0800
In-Reply-To: <20230227173632.3292573-1-surenb@google.com>
Mime-Version: 1.0
References: <20230227173632.3292573-1-surenb@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230227173632.3292573-11-surenb@google.com>
Subject: [PATCH v4 10/33] mm: rcu safe VMA freeing
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
index 22b2ac82bffd..64a6b3f6b74f 100644
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
index abfcf95734c7..a63b739aeca9 100644
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
2.39.2.722.g9855ee24e9-goog

