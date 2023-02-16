Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBD5698BBD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjBPFUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 00:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjBPFTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:19:40 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6742B410B9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:56 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 191-20020a2504c8000000b008e2fd9e34e6so855049ybe.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rll6a/VW4pEw1AhNBjbFoMRbi+XwYRGQoRwSBUD0bh4=;
        b=hu+sMS9oSFHR1r7khxhf1UbXFcs2Z++5UsWdyoPEf98HLaKpCA/5NqLhTjKtFbNcAI
         bq4IC94z3LeKr+N8fZ27HaBeoB9eV7FJUK2PbLxLqtWEgkZI6C3sySZgRKxnS+2i/7yz
         RFGxaAOIl8opKirVI8bfAZAj2T7sVtyi7tZlmgl6KCk8dFxbKL8va87izUWyHNnCWm+i
         wFd5WvNjbROGmsVfKcufeNfiLR4xBKkikebAtyhw//UrLzCCkecCcI/c1WZAFUB1nZ5g
         ONtU8uW/bb5j1wyQf5MWCYTwREIrfwMyez4h+y24cgMUk3OrfInLJF7DZne80Aw4Hh2T
         oQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rll6a/VW4pEw1AhNBjbFoMRbi+XwYRGQoRwSBUD0bh4=;
        b=0gKH/Uhd8pfqI3ivqX5DKP0pz/tLKTJDON9T74FLHKTuLdlQ6R59qDSzCG8A4F5BxR
         RdE3J6vSfZRG2JM9LFNcR3iGACpLNFGMZg6akGpF8yv77NZZEbpDimkKii8BC/7T87eg
         wFpCbx9IcBtxMPYumKvf4HIhzAkf6Y279xBU98IVfs68JqKespmtTT4SeSekpAdAaUKy
         LNZD5b4qCSD/7lrJHRuw0nlUSy1GHii33zUA0YQeYVqHD5VzOA4h2v/pSq+F/c/pwhLI
         uzQV3Z/c+CO0CBiGludJhO1J2u3ICvsEuO/Bir8ZZxC8wRlzaOph84VeDHpBjkigmdJZ
         iVAA==
X-Gm-Message-State: AO0yUKXMOfqZfLcDlbaDfFJJuvb/GBj0IdZXeS3M1fMMslwjyDgtlSMW
        J1/nZzGMsv2rMhYOwhioG21GyTrQMM8=
X-Google-Smtp-Source: AK7set/t52sA7P5kGXoASmYABiID5pIEjMuKzn7Z6yq6NOdnfI/iNhk3E99tS5Gm4PH95uk7/Rdn/fKqkhY=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:f781:d5ed:1806:6ebb])
 (user=surenb job=sendgmr) by 2002:a25:9012:0:b0:874:380b:887e with SMTP id
 s18-20020a259012000000b00874380b887emr545965ybl.239.1676524735071; Wed, 15
 Feb 2023 21:18:55 -0800 (PST)
Date:   Wed, 15 Feb 2023 21:17:40 -0800
In-Reply-To: <20230216051750.3125598-1-surenb@google.com>
Mime-Version: 1.0
References: <20230216051750.3125598-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230216051750.3125598-26-surenb@google.com>
Subject: [PATCH v3 25/35] mm: introduce lock_vma_under_rcu to be used from
 arch-specific code
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

Introduce lock_vma_under_rcu function to lookup and lock a VMA during
page fault handling. When VMA is not found, can't be locked or changes
after being locked, the function returns NULL. The lookup is performed
under RCU protection to prevent the found VMA from being destroyed before
the VMA lock is acquired. VMA lock statistics are updated according to
the results.
For now only anonymous VMAs can be searched this way. In other cases the
function returns NULL.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h |  3 +++
 mm/memory.c        | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3f98344f829c..36172bb38e6b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -701,6 +701,9 @@ static inline void vma_mark_detached(struct vm_area_struct *vma, bool detached)
 	vma->detached = detached;
 }
 
+struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
+					  unsigned long address);
+
 #else /* CONFIG_PER_VMA_LOCK */
 
 static inline void vma_init_lock(struct vm_area_struct *vma) {}
diff --git a/mm/memory.c b/mm/memory.c
index 8177c59ffd2d..5e1c124552a1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5220,6 +5220,52 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 }
 EXPORT_SYMBOL_GPL(handle_mm_fault);
 
+#ifdef CONFIG_PER_VMA_LOCK
+/*
+ * Lookup and lock a VMA under RCU protection. Returned VMA is guaranteed to be
+ * stable and not isolated. If the VMA is not found or is being modified the
+ * function returns NULL.
+ */
+struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
+					  unsigned long address)
+{
+	MA_STATE(mas, &mm->mm_mt, address, address);
+	struct vm_area_struct *vma;
+
+	rcu_read_lock();
+retry:
+	vma = mas_walk(&mas);
+	if (!vma)
+		goto inval;
+
+	/* Only anonymous vmas are supported for now */
+	if (!vma_is_anonymous(vma))
+		goto inval;
+
+	if (!vma_start_read(vma))
+		goto inval;
+
+	/* Check since vm_start/vm_end might change before we lock the VMA */
+	if (unlikely(address < vma->vm_start || address >= vma->vm_end)) {
+		vma_end_read(vma);
+		goto inval;
+	}
+
+	/* Check if the VMA got isolated after we found it */
+	if (vma->detached) {
+		vma_end_read(vma);
+		/* The area was replaced with another one */
+		goto retry;
+	}
+
+	rcu_read_unlock();
+	return vma;
+inval:
+	rcu_read_unlock();
+	return NULL;
+}
+#endif /* CONFIG_PER_VMA_LOCK */
+
 #ifndef __PAGETABLE_P4D_FOLDED
 /*
  * Allocate p4d page table.
-- 
2.39.1

