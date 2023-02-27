Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFE06A4844
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjB0Rio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjB0RiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:38:01 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8522449A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:32 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536cad819c7so153281707b3.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iRRoEkIKRwl2QQHnq1OJVyPp4L6+mQc5CWukcTSQqHI=;
        b=M2xu6PJmgtYFCFjZtLFUAhDJwsRj1PNvn9tpCCynDkmhHKgKWgNMPKAbFeMB0d7vzQ
         aKVeG6bXcHl5yxZ6JEXjbkVB2BvokKvbI4LCTQCQPJySbeEhyr0HdzjFd7UV7XC52Nqd
         IM/Y4Y2oz4P4pwkohu9Bqul5qghmRgidkrq66aJWcYZe5Ah2frrlViyJFqWif5WyIuln
         lwhBindA8HTOjteANHg0VaUlc+wXF2i0bjESG2yKoDnx3/qzuFoEw7K8TYty79uXoeAT
         DG0JzJNCfRj4E5rbsNquxz9O5F/H/zOUYZHgnCU0K2ioTwSn7zpOFzVjAn3t3qu4Rbvy
         YYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iRRoEkIKRwl2QQHnq1OJVyPp4L6+mQc5CWukcTSQqHI=;
        b=y9na5U0qDi21qBAsnJHbPzounsTntLvQkhZlXN9o2VPt93mV9Rc1O9exuCbhlOm3Uo
         fAmH8/SZB0RBdDhAd9weSIzXnzs5xviA670YxGqJUnRfFErNFZWMsye7R2ZOQKOkYAz+
         h273258vMQDT7/xiTtbNrrtzN2vM3yzavsHIgx/nwy1hlmDpUBQYtHZYqx3yG+h+gtzq
         nUzI3d+3q1QGLJnGVXPugWyJwFlo5rq25xRgCQSCQTZE637ia9lMJDcqIxBNtFdLTGhK
         akKOjdGtrVYY5TvMxI6c17WoDUe0ma0iIKr62hJhqcm3vBsSWM/DLP3X/BZvJaB2o0n1
         qNog==
X-Gm-Message-State: AO0yUKXYIVpxuDSm/e204c6V8k/q4qSehtgDtX/aWZC9+fAYoXQvtJnc
        2UWeaION7JXYzDjv9ip4ESMp3K2u6Yw=
X-Google-Smtp-Source: AK7set8ux+VAfJlkMlZWU+S8XCIwu1HZ1wVSlOGqhGsiL0aWWxFXwk2KW/a7dOnnyUwvPtqegO11CuQKxxM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:e1f6:21d1:eead:3897])
 (user=surenb job=sendgmr) by 2002:a5b:6cf:0:b0:a03:da3f:3e65 with SMTP id
 r15-20020a5b06cf000000b00a03da3f3e65mr9154608ybq.6.1677519451327; Mon, 27 Feb
 2023 09:37:31 -0800 (PST)
Date:   Mon, 27 Feb 2023 09:36:22 -0800
In-Reply-To: <20230227173632.3292573-1-surenb@google.com>
Mime-Version: 1.0
References: <20230227173632.3292573-1-surenb@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230227173632.3292573-24-surenb@google.com>
Subject: [PATCH v4 23/33] mm: introduce lock_vma_under_rcu to be used from
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
index 895bb3950e8a..46d2db743b1a 100644
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
index f7f412833e42..bda4c1a991f0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5221,6 +5221,52 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
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
2.39.2.722.g9855ee24e9-goog

