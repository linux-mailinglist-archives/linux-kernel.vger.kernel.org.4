Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A3E66320F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237845AbjAIU6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237559AbjAIU5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:57:31 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722B48CBEB
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:54:57 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-4c11ae6ab25so104151227b3.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 12:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UA5+XYk5SNGwY0wBqjbKeTB68Smdf1b2WfFGnAueiFI=;
        b=T55Sv4TWznVzBLEvpmky/jAR0QJoeEeCX90o+hjvZVdyHXxi4X+dLVqm78fwsxY8qM
         7mstQqJ2q4Sn5cjstBMo6qt6HReHOpVXqnm5LMKSQ635M0MCSPIfIgxAkOTHc8oB12I/
         ai6kXEsVt00A/xCygYMywSMRtpTqMTCmAJNGp6/HS0isXJekWM6FOqzBH2+trv87L4rS
         u+h7CTRZzB07Ow9ioaR2euNV+QdGF1fgPh0hG8fHh3bLFfxrE2kcC3qaflJTUkk0dQTh
         8vb62xpka2Ra5fG5NjEzQJYLTJMKCpwH3JBwVijZjrLZOBQ13qNu1ZZEA2iHn/6uZCd9
         oE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UA5+XYk5SNGwY0wBqjbKeTB68Smdf1b2WfFGnAueiFI=;
        b=09eAUy0m5bvmYB9GNbnJPlQtcmZKV0c6yoKGDri0M8/FxmMGv59D1WLb6UZgjsNiyr
         AN7yu93u6DdJ3Rt+8TIfkHZpzT4n5ZWxJ+UzkNIz0G98zVS3/px7EdSw9Fpr5aR5lUXE
         tBOTHJmf++MggIBVpIo5ItwUkEw04cTm2Te+x3DpyyBB8/XJ6YlsVVvo/w/9FYl5NPnN
         HbiVlEnC//pWf1NF6fMDzquKdkGnEqEHWvaKckZHPOg3O9350umI5DawHJqx0xnUcQA8
         QSXQqNtkA+Y31Enn4BbYSGV2wen776tb5DZFZa/tUZt66qt1ntj+Vp58WIWikUQ87KF+
         npjg==
X-Gm-Message-State: AFqh2kpMIdlavF4C9TcUgYsF1FtT1WVPFVmADICdmIJRw0kL0PDD0qGR
        AS3iUdP01+y/tpXydWvmhts0IqHm8wI=
X-Google-Smtp-Source: AMrXdXsg8SKnvt1lG56Fk9uUJaowgWL0vbqBlxMLAmQhblw+uvVMcBKNRkD6OuTHfHWzX2ebIh14gNZU+Cs=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:9393:6f7a:d410:55ca])
 (user=surenb job=sendgmr) by 2002:a05:6902:920:b0:781:eeed:9abf with SMTP id
 bu32-20020a056902092000b00781eeed9abfmr7003326ybb.538.1673297691543; Mon, 09
 Jan 2023 12:54:51 -0800 (PST)
Date:   Mon,  9 Jan 2023 12:53:23 -0800
In-Reply-To: <20230109205336.3665937-1-surenb@google.com>
Mime-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230109205336.3665937-29-surenb@google.com>
Subject: [PATCH 28/41] mm: introduce lock_vma_under_rcu to be used from
 arch-specific code
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
 mm/memory.c        | 51 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c464fc8a514c..d0fddf6a1de9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -687,6 +687,9 @@ static inline void vma_assert_no_reader(struct vm_area_struct *vma)
 		      vma);
 }
 
+struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
+					  unsigned long address);
+
 #else /* CONFIG_PER_VMA_LOCK */
 
 static inline void vma_init_lock(struct vm_area_struct *vma) {}
diff --git a/mm/memory.c b/mm/memory.c
index 9ece18548db1..a658e26d965d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5242,6 +5242,57 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
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
+	struct vm_area_struct *vma, *validate;
+
+	rcu_read_lock();
+	vma = mas_walk(&mas);
+retry:
+	if (!vma)
+		goto inval;
+
+	/* Only anonymous vmas are supported for now */
+	if (!vma_is_anonymous(vma))
+		goto inval;
+
+	if (!vma_read_trylock(vma))
+		goto inval;
+
+	/* Check since vm_start/vm_end might change before we lock the VMA */
+	if (unlikely(address < vma->vm_start || address >= vma->vm_end)) {
+		vma_read_unlock(vma);
+		goto inval;
+	}
+
+	/* Check if the VMA got isolated after we found it */
+	mas.index = address;
+	validate = mas_walk(&mas);
+	if (validate != vma) {
+		vma_read_unlock(vma);
+		count_vm_vma_lock_event(VMA_LOCK_MISS);
+		/* The area was replaced with another one. */
+		vma = validate;
+		goto retry;
+	}
+
+	rcu_read_unlock();
+	return vma;
+inval:
+	rcu_read_unlock();
+	count_vm_vma_lock_event(VMA_LOCK_ABORT);
+	return NULL;
+}
+#endif /* CONFIG_PER_VMA_LOCK */
+
 #ifndef __PAGETABLE_P4D_FOLDED
 /*
  * Allocate p4d page table.
-- 
2.39.0

