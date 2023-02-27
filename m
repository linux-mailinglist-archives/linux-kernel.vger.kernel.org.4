Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6056A4848
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjB0RjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjB0RiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:38:22 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F42241F8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:47 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 6-20020a631046000000b00502afcf62easo2138207pgq.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8qbswzDezEhzstnVvKcWG8k4mqqShtR5CvkIjaL/Ams=;
        b=S2z/SSZHK7ga7fn7K3WxQ1Z9Tp5cfnBCSQx6U3NwmV1gsUS+bGmINQRxa2j1mxprJj
         TlUS9zejozFI94Me4SRmYnZJhHoCJ1T/yWkWmu9QLBmKTP9UVKEKrUis4+6aHa3Th3fJ
         h+Y+1Jmq5YaDOU6wdiux0RRTdqhbgVjK/U97ZWeloQvvOddB9ya0oDdfoI+0RwHp4MBY
         fv4OUGk3ZqItB135iDjzRMrjgTvWp+7rVjVBq1LRXg1IvF5Kyuov7vPWbX/2nDhfcOko
         v7S1G6CGTLyAoqFG7bUJ2+HrxmmeBgvMQ0WZGMska7TydHy4EV5ohTcRFh6YPtqaKDjC
         j2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8qbswzDezEhzstnVvKcWG8k4mqqShtR5CvkIjaL/Ams=;
        b=jJ9/gUTnYGhiBGFv0svv9xmVWox3uI02m1ARhea21eJnN+8Tbv6UXxzZp+fM67gx5s
         Iqq1J3PFJ6vlmt6+rHCCTirVZF/dBVlgNIrLjg7jPOxlJ812jU5S+h+F+XqBVHcVA8oy
         PywhU2Smf1EG7WTFMD9jxnfLaEg7poYe0mokT4wLrJ2M+CB1Za+/2FTkqssbFIJtMJjG
         Nh5R4Oc/+xfLTmd+JFrld1qNapGneVj0nb627cX7i3ZNd2+u1DR7VYGguKAwyc/uyYdN
         9ep8OPvFRKhD35hRhNaEgsOfPiVS11/D0JkLiTfYF8RcL3ynahensPEeZVOD9wYoKsy/
         W5rA==
X-Gm-Message-State: AO0yUKV2x9gA7LS2cxYdvIarE1fxGAIyDG2a56S2OPZRodLRslRhvQ2M
        fOkOVYzoRNP4/cu4yHS995gWlm8I0VQ=
X-Google-Smtp-Source: AK7set9keW13BRbYPHEfojmqkqSUJl+DCAHGSXNxIKLRjiYP92gcRxEVFUNpHyaWkuSA+coR6ukP0Mdxl38=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:e1f6:21d1:eead:3897])
 (user=surenb job=sendgmr) by 2002:a63:7a56:0:b0:4fb:b88f:e98a with SMTP id
 j22-20020a637a56000000b004fbb88fe98amr6296782pgn.7.1677519466345; Mon, 27 Feb
 2023 09:37:46 -0800 (PST)
Date:   Mon, 27 Feb 2023 09:36:28 -0800
In-Reply-To: <20230227173632.3292573-1-surenb@google.com>
Mime-Version: 1.0
References: <20230227173632.3292573-1-surenb@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230227173632.3292573-30-surenb@google.com>
Subject: [PATCH v4 29/33] x86/mm: try VMA lock-based page fault handling first
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

Attempt VMA lock-based page fault handling first, and fall back to the
existing mmap_lock-based handling if that fails.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 arch/x86/Kconfig    |  1 +
 arch/x86/mm/fault.c | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a825bf031f49..df21fba77db1 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -27,6 +27,7 @@ config X86_64
 	# Options that are inherently 64-bit kernel only:
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
+	select ARCH_SUPPORTS_PER_VMA_LOCK
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select HAVE_ARCH_SOFT_DIRTY
 	select MODULES_USE_ELF_RELA
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index a498ae1fbe66..e4399983c50c 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -19,6 +19,7 @@
 #include <linux/uaccess.h>		/* faulthandler_disabled()	*/
 #include <linux/efi.h>			/* efi_crash_gracefully_on_page_fault()*/
 #include <linux/mm_types.h>
+#include <linux/mm.h>			/* find_and_lock_vma() */
 
 #include <asm/cpufeature.h>		/* boot_cpu_has, ...		*/
 #include <asm/traps.h>			/* dotraplinkage, ...		*/
@@ -1333,6 +1334,38 @@ void do_user_addr_fault(struct pt_regs *regs,
 	}
 #endif
 
+#ifdef CONFIG_PER_VMA_LOCK
+	if (!(flags & FAULT_FLAG_USER))
+		goto lock_mmap;
+
+	vma = lock_vma_under_rcu(mm, address);
+	if (!vma)
+		goto lock_mmap;
+
+	if (unlikely(access_error(error_code, vma))) {
+		vma_end_read(vma);
+		goto lock_mmap;
+	}
+	fault = handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LOCK, regs);
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
+			kernelmode_fixup_or_oops(regs, error_code, address,
+						 SIGBUS, BUS_ADRERR,
+						 ARCH_DEFAULT_PKEY);
+		return;
+	}
+lock_mmap:
+#endif /* CONFIG_PER_VMA_LOCK */
+
 	/*
 	 * Kernel-mode access to the user address space should only occur
 	 * on well-defined single instructions listed in the exception
@@ -1433,6 +1466,9 @@ void do_user_addr_fault(struct pt_regs *regs,
 	}
 
 	mmap_read_unlock(mm);
+#ifdef CONFIG_PER_VMA_LOCK
+done:
+#endif
 	if (likely(!(fault & VM_FAULT_ERROR)))
 		return;
 
-- 
2.39.2.722.g9855ee24e9-goog

