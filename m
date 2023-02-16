Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69815698BC5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjBPFV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 00:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjBPFUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:20:35 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718B642BC0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:19:18 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5337e2cbc58so8660367b3.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UQ3ySmwJxDlPKOGcVlpRpfqxPlYDfL6UGC9Ax4HzzOw=;
        b=KGDJpcNA4oBtC5xQjxkPPkTW0kNBhMrSybgGLHrbBGSwSGEq+rySxMS3rk0dGM+Qo/
         JpvUuwvGZIqjAVk+FVRsZ45D9AgvgQzyseylKUSLhPKRWFnmJExh3o/n5uArNAg9pZmc
         szoMYmExx5uq8bOtsbN9zvU5WJmapQpCTW9YfX5yCKinl4hK2fSO0QEupE6sIVAF6mis
         0qvHvTjkF2AHE/zcyOYTuhnORntosRwKL2siaVlbrxc1aSWTq08YWLJWNhdZghaVxqan
         vIZPE33VZDXNYNH6tC5BE6Aqx0uXP/yBJaWCtfFr0Yvy7z7UrJ4q+Ys5HfXN3+WVCYvy
         Y1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UQ3ySmwJxDlPKOGcVlpRpfqxPlYDfL6UGC9Ax4HzzOw=;
        b=IlXF2F9OTqesI8pEhb1GvpT2QzL0mUv0EuG6asHPGcNWDlW55ZAk8jtl6h7EyAeBar
         f36HBv5gRS9mWypoWL7w+uBXfq6LjztmBXDdO1dXuzv5Ud+QxwedSdfqmyJPk+VJJlKP
         KBUnPQD10Rp8AUBH30r3S5VZ5Bnpe0/xhKgkHLFQU7j0EezIgmnIRkbXYGxjtOc8q8PC
         L7R9px4no80ymgFirtrIUJ3A4BcFx0L+TXCWKZl6wIfKTtemUmCppX6dgFfG4n1Xuu23
         y0A5mAfzFQU2KHUShz+tsU5s8ZV6HTTBF5X4paDdvCSJ1WcRSpMqtvoBMY1KLeB+6ihS
         8yoA==
X-Gm-Message-State: AO0yUKUNDb5BPAO0acVjbBmFIMrxDt5AOvYgOkttecgIjRJ5039gtUZw
        lUjyGNHPfnY5CGCYsTDNTOqIcYb4Jtk=
X-Google-Smtp-Source: AK7set8KqluIZbArnLHWo7hLv5kb+HlUQLsv3CceFcKXduycZudkxodptdsBc1Ay4P83RAwvWnVWegqhxxw=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:f781:d5ed:1806:6ebb])
 (user=surenb job=sendgmr) by 2002:a05:6902:114f:b0:855:fdcb:4467 with SMTP id
 p15-20020a056902114f00b00855fdcb4467mr33ybu.0.1676524754468; Wed, 15 Feb 2023
 21:19:14 -0800 (PST)
Date:   Wed, 15 Feb 2023 21:17:48 -0800
In-Reply-To: <20230216051750.3125598-1-surenb@google.com>
Mime-Version: 1.0
References: <20230216051750.3125598-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230216051750.3125598-34-surenb@google.com>
Subject: [PATCH v3 33/35] powerc/mm: try VMA lock-based page fault handling first
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

From: Laurent Dufour <ldufour@linux.ibm.com>

Attempt VMA lock-based page fault handling first, and fall back to the
existing mmap_lock-based handling if that fails.
Copied from "x86/mm: try VMA lock-based page fault handling first"

Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 arch/powerpc/mm/fault.c                | 41 ++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/Kconfig |  1 +
 arch/powerpc/platforms/pseries/Kconfig |  1 +
 3 files changed, 43 insertions(+)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 2bef19cc1b98..c7ae86b04b8a 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -469,6 +469,44 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
 	if (is_exec)
 		flags |= FAULT_FLAG_INSTRUCTION;
 
+#ifdef CONFIG_PER_VMA_LOCK
+	if (!(flags & FAULT_FLAG_USER))
+		goto lock_mmap;
+
+	vma = lock_vma_under_rcu(mm, address);
+	if (!vma)
+		goto lock_mmap;
+
+	if (unlikely(access_pkey_error(is_write, is_exec,
+				       (error_code & DSISR_KEYFAULT), vma))) {
+		int rc = bad_access_pkey(regs, address, vma);
+
+		vma_end_read(vma);
+		return rc;
+	}
+
+	if (unlikely(access_error(is_write, is_exec, vma))) {
+		int rc = bad_access(regs, address);
+
+		vma_end_read(vma);
+		return rc;
+	}
+
+	fault = handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LOCK, regs);
+	vma_end_read(vma);
+
+	if (!(fault & VM_FAULT_RETRY)) {
+		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
+		goto done;
+	}
+	count_vm_vma_lock_event(VMA_LOCK_RETRY);
+
+	if (fault_signal_pending(fault, regs))
+		return user_mode(regs) ? 0 : SIGBUS;
+
+lock_mmap:
+#endif /* CONFIG_PER_VMA_LOCK */
+
 	/* When running in the kernel we expect faults to occur only to
 	 * addresses in user space.  All other faults represent errors in the
 	 * kernel and should generate an OOPS.  Unfortunately, in the case of an
@@ -545,6 +583,9 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
 
 	mmap_read_unlock(current->mm);
 
+#ifdef CONFIG_PER_VMA_LOCK
+done:
+#endif
 	if (unlikely(fault & VM_FAULT_ERROR))
 		return mm_fault_error(regs, address, fault);
 
diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
index ae248a161b43..70a46acc70d6 100644
--- a/arch/powerpc/platforms/powernv/Kconfig
+++ b/arch/powerpc/platforms/powernv/Kconfig
@@ -16,6 +16,7 @@ config PPC_POWERNV
 	select PPC_DOORBELL
 	select MMU_NOTIFIER
 	select FORCE_SMP
+	select ARCH_SUPPORTS_PER_VMA_LOCK
 	default y
 
 config OPAL_PRD
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index a3b4d99567cb..e036a04ff1ca 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -21,6 +21,7 @@ config PPC_PSERIES
 	select HOTPLUG_CPU
 	select FORCE_SMP
 	select SWIOTLB
+	select ARCH_SUPPORTS_PER_VMA_LOCK
 	default y
 
 config PARAVIRT
-- 
2.39.1

