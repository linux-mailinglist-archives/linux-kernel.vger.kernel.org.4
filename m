Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B156631F2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237696AbjAIUzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237545AbjAIUyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:54:44 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3B67A38A
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:54:16 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-4c6bd2981d8so66539597b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 12:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q5vG3v1PIcAm/ERdB03D9/j7bAwMWdEUWbQM9OP8Y4c=;
        b=jGV2twit8eMqqlAwxSI2kIyw+GdbQsmn963oqlT3GN/ehTsmuPHj865pM8TWLhKQHd
         jTIMTXUStd0tYuBt7C6hb5YIOb4/wBppGWfSzDrzDKFeyuMa9uP2aNs8o441PZXFnjCo
         UTpNeX3UnEavX2v58G4+rqPOBU9aUnr6H/ChTcAvQIipWCjxL9GlTdM7oqLGXY19DPFQ
         q7bt4dBbBloqbwmYh9ylKkKgLjVpvssPEYXAiDYbhfBukg85oeSOt+1VHZNlGA7zFiYp
         8fJla0RzQ4AZwln2gfdXjRilgUN42dHF3aEjUxK8uZvM/sfKPj53v6EzOYOtMmGPRMLa
         fuFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q5vG3v1PIcAm/ERdB03D9/j7bAwMWdEUWbQM9OP8Y4c=;
        b=xnE7xeBMf35lai2BSz+66tt2XvOg6wKkMkkQ9HD3nPDWo3IzBmOGah/42Eil7CZ4x1
         wtgl/HKpTR4b++KJZQ7rjH52E3c9lzFcmw08NIVt7gaTC4ZDl7ot/7TemfqxFnbGcCTq
         R4BqH3ySwT+magtPgbg7QFUgwQz6XU9MS704JK375Sm5xbcHv79AXeFyVGsreJPq5uzU
         sDmMyeKgSTLwC1tyJCeexi8CY4HDkguMVfRHl7RZgPTv0UMtHWB2Z3TqIekMkhdFzp37
         lRJORcrThZOVK2+2c3X1gyYaqliYRxxusk0+/3Oa1BPYQwlm4Q2m3Sw6kOFtjD9Sd73a
         NLPQ==
X-Gm-Message-State: AFqh2koRYH4OCCRAs4DNFKpu3anK8p91T4F4sebKX8KvytH+bSkdD2vk
        8yW4Tryf2qHjOYv/lASo8jMiIQ0SZVc=
X-Google-Smtp-Source: AMrXdXvsQzJo8PSoW1ccRcrlqwtefe5KwIQ7Te6dX0P6/V4WPjQWsck4Zjq+DJXzzvFNYEa755Hhn8p6kg0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:9393:6f7a:d410:55ca])
 (user=surenb job=sendgmr) by 2002:a25:ca88:0:b0:7bf:24c7:997e with SMTP id
 a130-20020a25ca88000000b007bf24c7997emr393826ybg.217.1673297656291; Mon, 09
 Jan 2023 12:54:16 -0800 (PST)
Date:   Mon,  9 Jan 2023 12:53:09 -0800
In-Reply-To: <20230109205336.3665937-1-surenb@google.com>
Mime-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230109205336.3665937-15-surenb@google.com>
Subject: [PATCH 14/41] mm: replace VM_LOCKED_CLEAR_MASK with VM_LOCKED_MASK
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

To simplify the usage of VM_LOCKED_CLEAR_MASK in clear_vm_flags(),
replace it with VM_LOCKED_MASK bitmask and convert all users.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h | 4 ++--
 kernel/fork.c      | 2 +-
 mm/hugetlb.c       | 4 ++--
 mm/mlock.c         | 6 +++---
 mm/mmap.c          | 6 +++---
 mm/mremap.c        | 2 +-
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 35cf0a6cbcc2..2b16d45b75a6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -416,8 +416,8 @@ extern unsigned int kobjsize(const void *objp);
 /* This mask defines which mm->def_flags a process can inherit its parent */
 #define VM_INIT_DEF_MASK	VM_NOHUGEPAGE
 
-/* This mask is used to clear all the VMA flags used by mlock */
-#define VM_LOCKED_CLEAR_MASK	(~(VM_LOCKED | VM_LOCKONFAULT))
+/* This mask represents all the VMA flag bits used by mlock */
+#define VM_LOCKED_MASK	(VM_LOCKED | VM_LOCKONFAULT)
 
 /* Arch-specific flags to clear when updating VM flags on protection change */
 #ifndef VM_ARCH_CLEAR
diff --git a/kernel/fork.c b/kernel/fork.c
index c026d75108b3..1591dd8a0745 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -674,7 +674,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 			tmp->anon_vma = NULL;
 		} else if (anon_vma_fork(tmp, mpnt))
 			goto fail_nomem_anon_vma_fork;
-		tmp->vm_flags &= ~(VM_LOCKED | VM_LOCKONFAULT);
+		clear_vm_flags(tmp, VM_LOCKED_MASK);
 		file = tmp->vm_file;
 		if (file) {
 			struct address_space *mapping = file->f_mapping;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index db895230ee7e..24861cbfa2b1 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6950,8 +6950,8 @@ static unsigned long page_table_shareable(struct vm_area_struct *svma,
 	unsigned long s_end = sbase + PUD_SIZE;
 
 	/* Allow segments to share if only one is marked locked */
-	unsigned long vm_flags = vma->vm_flags & VM_LOCKED_CLEAR_MASK;
-	unsigned long svm_flags = svma->vm_flags & VM_LOCKED_CLEAR_MASK;
+	unsigned long vm_flags = vma->vm_flags & ~VM_LOCKED_MASK;
+	unsigned long svm_flags = svma->vm_flags & ~VM_LOCKED_MASK;
 
 	/*
 	 * match the virtual addresses, permission and the alignment of the
diff --git a/mm/mlock.c b/mm/mlock.c
index 7032f6dd0ce1..06aa9e204fac 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -490,7 +490,7 @@ static int apply_vma_lock_flags(unsigned long start, size_t len,
 		prev = mas_prev(&mas, 0);
 
 	for (nstart = start ; ; ) {
-		vm_flags_t newflags = vma->vm_flags & VM_LOCKED_CLEAR_MASK;
+		vm_flags_t newflags = vma->vm_flags & ~VM_LOCKED_MASK;
 
 		newflags |= flags;
 
@@ -662,7 +662,7 @@ static int apply_mlockall_flags(int flags)
 	struct vm_area_struct *vma, *prev = NULL;
 	vm_flags_t to_add = 0;
 
-	current->mm->def_flags &= VM_LOCKED_CLEAR_MASK;
+	current->mm->def_flags &= ~VM_LOCKED_MASK;
 	if (flags & MCL_FUTURE) {
 		current->mm->def_flags |= VM_LOCKED;
 
@@ -682,7 +682,7 @@ static int apply_mlockall_flags(int flags)
 	mas_for_each(&mas, vma, ULONG_MAX) {
 		vm_flags_t newflags;
 
-		newflags = vma->vm_flags & VM_LOCKED_CLEAR_MASK;
+		newflags = vma->vm_flags & ~VM_LOCKED_MASK;
 		newflags |= to_add;
 
 		/* Ignore errors */
diff --git a/mm/mmap.c b/mm/mmap.c
index 9db37adfc00a..5c4b608edde9 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2721,7 +2721,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
 					is_vm_hugetlb_page(vma) ||
 					vma == get_gate_vma(current->mm))
-			vma->vm_flags &= VM_LOCKED_CLEAR_MASK;
+			clear_vm_flags(vma, VM_LOCKED_MASK);
 		else
 			mm->locked_vm += (len >> PAGE_SHIFT);
 	}
@@ -3392,8 +3392,8 @@ static struct vm_area_struct *__install_special_mapping(
 	vma->vm_start = addr;
 	vma->vm_end = addr + len;
 
-	vma->vm_flags = vm_flags | mm->def_flags | VM_DONTEXPAND | VM_SOFTDIRTY;
-	vma->vm_flags &= VM_LOCKED_CLEAR_MASK;
+	init_vm_flags(vma, (vm_flags | mm->def_flags |
+		      VM_DONTEXPAND | VM_SOFTDIRTY) & ~VM_LOCKED_MASK);
 	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
 
 	vma->vm_ops = ops;
diff --git a/mm/mremap.c b/mm/mremap.c
index fe587c5d6591..5f6f9931bff1 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -686,7 +686,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 
 	if (unlikely(!err && (flags & MREMAP_DONTUNMAP))) {
 		/* We always clear VM_LOCKED[ONFAULT] on the old vma */
-		vma->vm_flags &= VM_LOCKED_CLEAR_MASK;
+		clear_vm_flags(vma, VM_LOCKED_MASK);
 
 		/*
 		 * anon_vma links of the old vma is no longer needed after its page
-- 
2.39.0

