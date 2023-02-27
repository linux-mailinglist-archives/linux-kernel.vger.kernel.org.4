Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197A66A484C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjB0RjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjB0Ri0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:38:26 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10E635B4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:52 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536cb268ab8so154468307b3.17
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hcfd1e1CYNsfSesf73569pOSKya0WHju+cd+LlOfzq8=;
        b=lbYIqJZdRbbdDZdXc3KPyecDlcIgvcbfb+DcxfEk3pJ0tkCKREu4kmt7prlFLJ1+FQ
         T7SrZzz7AESmHbsebVB/dcsUJ3sSPqxUDap8J4TM2PMm/f0fKj2d5agwEF1dRo2i14i7
         2Tm7gxYItOsxZ6/P6dejoIKGIeHHxYKwoxOS0Hzf8d46xNc4trKpV4bsx+tVItCky7z5
         aUXOUsg8Vx6avsDKLvMNoEFIIJZIXtu9ciloUm8OADOlD0yqFEBOdNzn/R9lnJBdqTeu
         YgUEQUdg6StQbFTiY+Ix3uwxS+O8mpUohpFOuENl70pA6HrQlHtgGjdfJeJSJ8v+j9zf
         qj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hcfd1e1CYNsfSesf73569pOSKya0WHju+cd+LlOfzq8=;
        b=WaaBjqlhvTXUCjOF6UtafV+Qsy/Rhei2q/DxFMQSBf58LXlQLWK+hQ+0NBObyyZ4Vr
         T0ygYJZRMJXoaKYicINYg+UuDgK3/9jdXqf2xG/IzCaM619FGNWVoJm92EBa7ZunKiI1
         DrMrNlvyTsCkGDya4idCFELjhHpzjqUNyZnLXxYbLtVH7HBu9+KAtcU1Ec0sNaNHH9ij
         tjMALS9bzB7R6WWT0/wCso0BzGZxWde8SK2SBq4AASCUuORBw7PGBJrkSitSwk5RTJu0
         4SoHRe6pwbed1scJICR04Ecfov7A1MVem8YYgRWJi78m0UibFg/EkWLUN7WyhGiMqa/8
         HfxQ==
X-Gm-Message-State: AO0yUKW96IP/x5ZkIL5nm49oWMv7TmSZse13pHRGPkjWqEz7y4kwi9/s
        idkKcUO+KwSoDQdDlBFTIkk+ICgYfso=
X-Google-Smtp-Source: AK7set/pwIZDrdxVaNh2CuYGKu4UYoRP2oxQl2zbmcloOQnN3ea3mqmxriAC+2y4Q2nBddYhpyeOIu/z0Zw=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:e1f6:21d1:eead:3897])
 (user=surenb job=sendgmr) by 2002:a05:690c:31c:b0:52f:184a:da09 with SMTP id
 bg28-20020a05690c031c00b0052f184ada09mr265273ywb.2.1677519471088; Mon, 27 Feb
 2023 09:37:51 -0800 (PST)
Date:   Mon, 27 Feb 2023 09:36:30 -0800
In-Reply-To: <20230227173632.3292573-1-surenb@google.com>
Mime-Version: 1.0
References: <20230227173632.3292573-1-surenb@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230227173632.3292573-32-surenb@google.com>
Subject: [PATCH v4 31/33] powerc/mm: try VMA lock-based page fault handling first
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
index b481c5c8bae1..9c205fe0e619 100644
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
2.39.2.722.g9855ee24e9-goog

