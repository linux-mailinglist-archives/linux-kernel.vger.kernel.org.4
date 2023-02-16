Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5C8698BAB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjBPFTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 00:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjBPFSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:18:48 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A62946153
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:20 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a4-20020a5b0004000000b006fdc6aaec4fso842945ybp.20
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nnxUMMQI6vT0M/Q5sa1IAaTl/WTbc27CfHmxL3/FviM=;
        b=KnhAt7quYBwXQRhfuSYaJDek4wttI7RDXOOACIL/F63Nz/58eVv03No3Zqh2UIwNdl
         TkKGisyfzRrXImR2jOkU2wcQekf+kt9/XxXIsRoXlqskuIeX6hOhHTNZXgdfaMplle7K
         SAATQyrMS3HXKQy7j0lc9Kc3dK3KueDsfgI8ryy5OQhnNBROeaCbU2Hmg2SLUQOwNbgt
         XwBV7zK7XX+1ClOK24Y2b0Ex8amo9ljLG0ZokYkKzEniw9mpgT07P+84GOQVR154zkPK
         4YJcp2AEGd79KcxB1dsy4RuRGjRlYt9yxaLz/0Wa2WtK7Y2fqnfOErlG1kh3RHBuBBJK
         58yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nnxUMMQI6vT0M/Q5sa1IAaTl/WTbc27CfHmxL3/FviM=;
        b=cizoPD8FGYc8oxJRSDOtod6y2ksbkM9Nf7KWgULp83n5IriPxwPRahnd4O3DT1HBtx
         Cq7BTBuNRYLwvbaRm+q2TDaXBlnOv0y1Dgx+rJi4JCaloNIGSMJI2SSO+f+6c2Dvtyik
         NgEJxQXkQS6sY3c+AnrggVru9x2lictY3igIprMtmgP4WHNz5lIw/leWt4goToMKI5fG
         ORyew4tAYjNSwcA804jmA8rNHiNtptIZZTXCReLLrMpKR452rgkDQ7akhFJYCSD5Gv06
         h3HVRfTLBYXVcn05/EvtplkZw8kaYSylqyHXvDoQFEUG3sTyeDLfkoL2sXrMZyc1Yinp
         n7cg==
X-Gm-Message-State: AO0yUKUKPzTYf3nE/WewVHG8+B4azpm9YHaBTLhUC7pzxdOnfYOY7QiD
        MF14gF/ag0j+e1tgo2kv26XY7rzLgRI=
X-Google-Smtp-Source: AK7set+tlzm8noztFtNGPsWUqf3Z7zno+mYjAZ9UmWznIF5F5gJ5LrgX6pBfJhOwGepp15lWUy19j/IuAtc=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:f781:d5ed:1806:6ebb])
 (user=surenb job=sendgmr) by 2002:a81:a20c:0:b0:52e:f79e:b639 with SMTP id
 w12-20020a81a20c000000b0052ef79eb639mr389199ywg.283.1676524699450; Wed, 15
 Feb 2023 21:18:19 -0800 (PST)
Date:   Wed, 15 Feb 2023 21:17:25 -0800
In-Reply-To: <20230216051750.3125598-1-surenb@google.com>
Mime-Version: 1.0
References: <20230216051750.3125598-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230216051750.3125598-11-surenb@google.com>
Subject: [PATCH v3 10/35] mm: rcu safe VMA freeing
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
index 3fd5305dbbf9..fb4e2afad787 100644
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

