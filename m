Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9803067EEB6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjA0Tpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjA0ToI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:44:08 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C2859769
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:43:10 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-4c11ae6ab25so65258697b3.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zr26Tmb2M01sb1afZfnklHdnYeWn0/HWZzrpjXJYooI=;
        b=I2P3olZBrDoCFDP1jHcaHXqtsXyUzxQr/ws4wX6bBu3CUipyuxA31yRpWa3MnFa/SU
         pcf5+CCx+WnMbozlzDdIg2ALFwq/OFj8s/q24FIJwL7Tizh8I6eeGtbBFib4zJzLB5md
         /zjFFlwtWXGghsSwviKTLUSRcwBRmcJaXn6b7nEXFweXpvU3ZyCKtcIxikLC8+UQ9pUQ
         JujyWegWeeB7qz6qsENh+jKg1foSfeMqF01FuGu+Yb/GyFYoIS6vq3ynrguPkj0pOoLx
         BYJ8cK1I9Z+jOMo/TqTeh+dlSH9FVfZfZ84FkijhY572Ij8GlcP0ii8VORVWe0sgl8Ck
         Cp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zr26Tmb2M01sb1afZfnklHdnYeWn0/HWZzrpjXJYooI=;
        b=Wt59uesTdyZ7RecOO9SwzT8Xwl6yO2QvhuTj8m7BoEQaWSRQOjKdcI3IjZ/g+rUr3j
         bNenf9ptvCrnBNMwf74exRSsJ5Q3T5uGAYdAO6b4YEMlLY1WX1d81wh/f2x6I5U6GAIF
         Hjk4PGttpM7orqJ4mnvziEG6ckWhVNvq5KQgrRXtYE7GJbSF2l+2Hm9TudC6/udIAAjw
         MLK85E7LMHI/cXdlBMI+e6A+HZSuSDzenLCmj9RlUhIyXdaoZ1z6hOC+qGGuSVzQx2Vo
         3GDtR25Z++F+NE7B0Ga/hKu/1WPlPUtK+gTlzHuuQHbfk0cvpR4TifYVSfLglVU67BpZ
         Khkw==
X-Gm-Message-State: AO0yUKWipz/yH/5hlrIGEDO6lM+lbHKeq0yj//Qi6W4YsOW0mLAWaveZ
        rNPT32humK10JIhg5Kgj02jYslr4d7E=
X-Google-Smtp-Source: AK7set8yRf6g7ktuBKP0CQzBeFyUCv/mUJgTqrv00u2WfcKZqCCOgg0GVy3Vw6WGmXU8JBT03ehy/weY7OA=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:4e19:be9:c5d0:8483])
 (user=surenb job=sendgmr) by 2002:a0d:eb09:0:b0:506:391c:6d37 with SMTP id
 u9-20020a0deb09000000b00506391c6d37mr2021270ywe.88.1674848542935; Fri, 27 Jan
 2023 11:42:22 -0800 (PST)
Date:   Fri, 27 Jan 2023 11:41:06 -0800
In-Reply-To: <20230127194110.533103-1-surenb@google.com>
Mime-Version: 1.0
References: <20230127194110.533103-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230127194110.533103-30-surenb@google.com>
Subject: [PATCH v2 29/33] x86/mm: try VMA lock-based page fault handling first
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

Attempt VMA lock-based page fault handling first, and fall back to the
existing mmap_lock-based handling if that fails.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 arch/x86/Kconfig    |  1 +
 arch/x86/mm/fault.c | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3604074a878b..3647f7bdb110 100644
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
index a498ae1fbe66..122c8fe4af12 100644
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
+	if (!(flags & FAULT_FLAG_USER) || atomic_read(&mm->mm_users) == 1)
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
2.39.1

