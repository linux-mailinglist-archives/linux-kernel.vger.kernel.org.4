Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C9767D570
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjAZTi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbjAZTiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:38:06 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA29125BB
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:38:03 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id n203-20020a2572d4000000b0078f09db9888so2930733ybc.18
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zlALSRCxyJ0x7DG1bpOTgFUYMDutHYK+9H12DiNU8rs=;
        b=hZNOyExz2CHhT7Lv8/1Oy+IakRoysLUTyaLrhwc6OvOl1RbVfyxPx8HhLjEmNLtcA/
         BY0BX8hVwmwqOoBOAUbSQfgCR7McBjwSKMlnib3/r+Av8uTAud1UBhrmVG6TzF1g76mR
         nuKWivb9Q4wk66ty4yI9N1cosIfPbmFsheg2/502610l56CKG4QzLSoUZoExOYXjJCTQ
         j2mkcTGMWryRdUGvLYawFTWuoFK7ET78LKvwGsKOravZ5CcFDpVAFxFbBhoiYUfS0ekE
         vHIKanEeNQgRE6ZGBJnrux4jsyMuoU7VO1dgH6FWHeLmXl9fOCxu7UFXShpt7uDJ75T0
         D5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zlALSRCxyJ0x7DG1bpOTgFUYMDutHYK+9H12DiNU8rs=;
        b=Yw4oyFJZGr3BQ+Pft7kbx5LXLdcpRD7h2HVNWhlFSy/TH7AuBcpKU2SDfW3qyaalzL
         bYPmMJaoz1pxevFfzvmyCrBF2E/aOIC2AvWr/fGuQKjm+wQlTmPzjN5bGpVdt0qsPHHc
         QoLIB1cv+tO1k8/YgpKDyGFPVGN0cVnZ1Bo9Y/DfheNknBYD+kO25Bf/a2AtNZ93P1MW
         VOCgyf6CF/GRzy22o6OvZaaQpdummb3Uw1FBjxDEI60nktjT+tE36DrPJ2/Ko0L9jc+l
         QigjYeCFtOj3IGF2HaJqUxnd1rVajnShIPebESRD8m5AEWi3mv+Lznz+XHHw2hAa2gF1
         Betw==
X-Gm-Message-State: AO0yUKWnEizw6r8MXJb5uqCEHwNrp4+SZTk9gqms/0+IAHRT0+L0aLwR
        9+2ZzcqbzvaotWgdP9OEaHx2lfkxQB4=
X-Google-Smtp-Source: AK7set+wPgjPE4jCPi3P5+z8aENnhk2aKoIt+MqVYJV+W2PRabPfSrmAUbfkb2zGPKmrtE86F6tpsEUUWTA=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:d774:88af:bab3:648d])
 (user=surenb job=sendgmr) by 2002:a81:52ce:0:b0:506:60ca:21c3 with SMTP id
 g197-20020a8152ce000000b0050660ca21c3mr1424396ywb.197.1674761883577; Thu, 26
 Jan 2023 11:38:03 -0800 (PST)
Date:   Thu, 26 Jan 2023 11:37:48 -0800
In-Reply-To: <20230126193752.297968-1-surenb@google.com>
Mime-Version: 1.0
References: <20230126193752.297968-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230126193752.297968-4-surenb@google.com>
Subject: [PATCH v4 3/7] mm: replace VM_LOCKED_CLEAR_MASK with VM_LOCKED_MASK
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

To simplify the usage of VM_LOCKED_CLEAR_MASK in vm_flags_clear(),
replace it with VM_LOCKED_MASK bitmask and convert all users.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 include/linux/mm.h | 4 ++--
 kernel/fork.c      | 2 +-
 mm/hugetlb.c       | 4 ++--
 mm/mlock.c         | 6 +++---
 mm/mmap.c          | 6 +++---
 mm/mremap.c        | 2 +-
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index abb31103d060..ad4fdb9405ba 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -421,8 +421,8 @@ extern unsigned int kobjsize(const void *objp);
 /* This mask defines which mm->def_flags a process can inherit its parent */
 #define VM_INIT_DEF_MASK	VM_NOHUGEPAGE
 
-/* This mask is used to clear all the VMA flags used by mlock */
-#define VM_LOCKED_CLEAR_MASK	(~(VM_LOCKED | VM_LOCKONFAULT))
+/* This mask represents all the VMA flag bits used by mlock */
+#define VM_LOCKED_MASK	(VM_LOCKED | VM_LOCKONFAULT)
 
 /* Arch-specific flags to clear when updating VM flags on protection change */
 #ifndef VM_ARCH_CLEAR
diff --git a/kernel/fork.c b/kernel/fork.c
index 9260f975b8f4..5e3029ea8e1e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -659,7 +659,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 			tmp->anon_vma = NULL;
 		} else if (anon_vma_fork(tmp, mpnt))
 			goto fail_nomem_anon_vma_fork;
-		tmp->vm_flags &= ~(VM_LOCKED | VM_LOCKONFAULT);
+		vm_flags_clear(tmp, VM_LOCKED_MASK);
 		file = tmp->vm_file;
 		if (file) {
 			struct address_space *mapping = file->f_mapping;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b6cbba105ffc..3a01a9dbf445 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6970,8 +6970,8 @@ static unsigned long page_table_shareable(struct vm_area_struct *svma,
 	unsigned long s_end = sbase + PUD_SIZE;
 
 	/* Allow segments to share if only one is marked locked */
-	unsigned long vm_flags = vma->vm_flags & VM_LOCKED_CLEAR_MASK;
-	unsigned long svm_flags = svma->vm_flags & VM_LOCKED_CLEAR_MASK;
+	unsigned long vm_flags = vma->vm_flags & ~VM_LOCKED_MASK;
+	unsigned long svm_flags = svma->vm_flags & ~VM_LOCKED_MASK;
 
 	/*
 	 * match the virtual addresses, permission and the alignment of the
diff --git a/mm/mlock.c b/mm/mlock.c
index 0336f52e03d7..5c4fff93cd6b 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -497,7 +497,7 @@ static int apply_vma_lock_flags(unsigned long start, size_t len,
 		if (vma->vm_start != tmp)
 			return -ENOMEM;
 
-		newflags = vma->vm_flags & VM_LOCKED_CLEAR_MASK;
+		newflags = vma->vm_flags & ~VM_LOCKED_MASK;
 		newflags |= flags;
 		/* Here we know that  vma->vm_start <= nstart < vma->vm_end. */
 		tmp = vma->vm_end;
@@ -661,7 +661,7 @@ static int apply_mlockall_flags(int flags)
 	struct vm_area_struct *vma, *prev = NULL;
 	vm_flags_t to_add = 0;
 
-	current->mm->def_flags &= VM_LOCKED_CLEAR_MASK;
+	current->mm->def_flags &= ~VM_LOCKED_MASK;
 	if (flags & MCL_FUTURE) {
 		current->mm->def_flags |= VM_LOCKED;
 
@@ -681,7 +681,7 @@ static int apply_mlockall_flags(int flags)
 	for_each_vma(vmi, vma) {
 		vm_flags_t newflags;
 
-		newflags = vma->vm_flags & VM_LOCKED_CLEAR_MASK;
+		newflags = vma->vm_flags & ~VM_LOCKED_MASK;
 		newflags |= to_add;
 
 		/* Ignore errors */
diff --git a/mm/mmap.c b/mm/mmap.c
index d4abc6feced1..fa3cbd625850 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2671,7 +2671,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
 					is_vm_hugetlb_page(vma) ||
 					vma == get_gate_vma(current->mm))
-			vma->vm_flags &= VM_LOCKED_CLEAR_MASK;
+			vm_flags_clear(vma, VM_LOCKED_MASK);
 		else
 			mm->locked_vm += (len >> PAGE_SHIFT);
 	}
@@ -3340,8 +3340,8 @@ static struct vm_area_struct *__install_special_mapping(
 	vma->vm_start = addr;
 	vma->vm_end = addr + len;
 
-	vma->vm_flags = vm_flags | mm->def_flags | VM_DONTEXPAND | VM_SOFTDIRTY;
-	vma->vm_flags &= VM_LOCKED_CLEAR_MASK;
+	vm_flags_init(vma, (vm_flags | mm->def_flags |
+		      VM_DONTEXPAND | VM_SOFTDIRTY) & ~VM_LOCKED_MASK);
 	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
 
 	vma->vm_ops = ops;
diff --git a/mm/mremap.c b/mm/mremap.c
index 1b3ee02bead7..55157b990091 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -687,7 +687,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 
 	if (unlikely(!err && (flags & MREMAP_DONTUNMAP))) {
 		/* We always clear VM_LOCKED[ONFAULT] on the old vma */
-		vma->vm_flags &= VM_LOCKED_CLEAR_MASK;
+		vm_flags_clear(vma, VM_LOCKED_MASK);
 
 		/*
 		 * anon_vma links of the old vma is no longer needed after its page
-- 
2.39.1

