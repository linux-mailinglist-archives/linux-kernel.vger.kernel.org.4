Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8423D67EEBB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjA0TrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbjA0Tq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:46:29 -0500
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25A08D0BD
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:44:10 -0800 (PST)
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-482d3bf0266so65384517b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MNwo0rhG4y8C+tQG7LPM4nLJWTbIHprc8uVQsZA2GSc=;
        b=JxxlO5586M0z4sVDSxHugqEEADB1cAjEHo2xluVRFI46WqHTOUsszCaJjysGoPqCq8
         ztKkJGmntymAGuEGxdM2A7EX8Sykw/reCFrQFVsgm7kaRoHFsG9BNF/PmmjyzPElNA3A
         u2zVx465PKwxuuDkWTqvf70dFDsT4sE76+Q1i+nyNMyErq//frz9WqLOph65UMZVM1Q3
         1JnBBBOhnZpIDf2DrbbDSdhADbiUH2oov3flacw7sejkvu/YDNPNLxViqgxSV8aAiDpN
         WEe8RN23e0S32q4tATcZ7ZhVfhZ7+NOeU1bzW/fjTQ6HzW6TJlQUp4mHpwvwuOr4rhfO
         QkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MNwo0rhG4y8C+tQG7LPM4nLJWTbIHprc8uVQsZA2GSc=;
        b=4FF1nk0tYt6b6Z3EunkU6EU6kG6eBxGs3ME3FwLhXpLxF38mP7rovlU2by3mKOGy6q
         Pd6kgN1MTV666QKgtZC1AjGMzWq16tFNdkQPh7HA08EfNbj8a+olr6EkkGBzvh6H6d6d
         FbyfXvqsFapeMOWOMmnxgxEt6GFsd9YfYJhEh8EuoQLvWSfzFbB4ju7zkXgMKu7BqXdt
         pDRGrPN7Mo6q1DGjH3roDtkRJKRTFhLVdeX9EX4JnzrXj2tHztIISYOz2fAL4NOTj8sW
         EdqZWU25C/LfRDN1fYPWZGvWUB8MD5GkaryBxI/Ke0Bkzs8H+gCn0zvglAVA250/yfO0
         0bCg==
X-Gm-Message-State: AFqh2kpB9jhSGcccYp0gXXc8NN57H5pBxnTR9OBDe2wFuS6D1MPKBouZ
        FduU3do8ldCdXsDfGJ+nsPevuudIYm0=
X-Google-Smtp-Source: AMrXdXv6cPUTMY06wj7LHpX7SofIKh9xmcnJ1P5+6wR9m3ToK9ikAh4HiQMQbcnL8It7MYI0W5hAcMnIURQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:4e19:be9:c5d0:8483])
 (user=surenb job=sendgmr) by 2002:a81:5b88:0:b0:462:e278:1a08 with SMTP id
 p130-20020a815b88000000b00462e2781a08mr5361156ywb.243.1674848545116; Fri, 27
 Jan 2023 11:42:25 -0800 (PST)
Date:   Fri, 27 Jan 2023 11:41:07 -0800
In-Reply-To: <20230127194110.533103-1-surenb@google.com>
Mime-Version: 1.0
References: <20230127194110.533103-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230127194110.533103-31-surenb@google.com>
Subject: [PATCH v2 30/33] arm64/mm: try VMA lock-based page fault handling first
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attempt VMA lock-based page fault handling first, and fall back to the
existing mmap_lock-based handling if that fails.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 arch/arm64/Kconfig    |  1 +
 arch/arm64/mm/fault.c | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c5ccca26a408..9f2c0e352da3 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -95,6 +95,7 @@ config ARM64
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK
+	select ARCH_SUPPORTS_PER_VMA_LOCK
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION if COMPAT
 	select ARCH_WANT_DEFAULT_BPF_JIT
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index f4cb0f85ccf4..16588dda9258 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -535,6 +535,9 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 	unsigned long vm_flags;
 	unsigned int mm_flags = FAULT_FLAG_DEFAULT;
 	unsigned long addr = untagged_addr(far);
+#ifdef CONFIG_PER_VMA_LOCK
+	struct vm_area_struct *vma;
+#endif
 
 	if (kprobe_page_fault(regs, esr))
 		return 0;
@@ -585,6 +588,36 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
 
+#ifdef CONFIG_PER_VMA_LOCK
+	if (!(mm_flags & FAULT_FLAG_USER) || atomic_read(&mm->mm_users) == 1)
+		goto lock_mmap;
+
+	vma = lock_vma_under_rcu(mm, addr);
+	if (!vma)
+		goto lock_mmap;
+
+	if (!(vma->vm_flags & vm_flags)) {
+		vma_end_read(vma);
+		goto lock_mmap;
+	}
+	fault = handle_mm_fault(vma, addr & PAGE_MASK,
+				mm_flags | FAULT_FLAG_VMA_LOCK, regs);
+	vma_end_read(vma);
+
+	if (!(fault & VM_FAULT_RETRY)) {
+		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
+		goto done;
+	}
+	count_vm_vma_lock_event(VMA_LOCK_RETRY);
+
+	/* Quick path to respond to signals */
+	if (fault_signal_pending(fault, regs)) {
+		if (!user_mode(regs))
+			goto no_context;
+		return 0;
+	}
+lock_mmap:
+#endif /* CONFIG_PER_VMA_LOCK */
 	/*
 	 * As per x86, we may deadlock here. However, since the kernel only
 	 * validly references user space from well defined areas of the code,
@@ -628,6 +661,9 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 	}
 	mmap_read_unlock(mm);
 
+#ifdef CONFIG_PER_VMA_LOCK
+done:
+#endif
 	/*
 	 * Handle the "normal" (no error) case first.
 	 */
-- 
2.39.1

