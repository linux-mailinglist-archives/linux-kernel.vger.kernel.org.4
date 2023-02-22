Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9675B69FE3C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 23:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbjBVWNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 17:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbjBVWNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 17:13:38 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE0A43918
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:13:21 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id s12so9171653qtq.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNsRaJl4d7YqZipc65JwWHSPo1qnkcWEe8GKRqSMg+M=;
        b=p+blT5c7UnqpDedKTJuaegL1xV7yBrj4SNpVyJiV5ClFgm62zbf0U4JcZYroD3+yna
         kauHCJSdSFg6+mbCOLzNn6rUbrZ4ArOA87BLXPSEoZk22VjR9Fq17STuHPO2OvAtB/M2
         HxT39jqgo+CPMRhiRziypJXvHMi3CMdju9U5E+WvI4ek5Xt8PSAwnCCkE112fvVtyTuc
         wxDekild1aWJArG4mF4o2QaM+Vv2V4aoqFWBn7BovANvDJCFQNOfsQ2C2ajafOLcFep1
         Mg8szLLDW/LtRqKHFLkyFeKjC36P5rMK0I0a770zvcFWbqzGqn349RrQ164qs3o5SB1f
         K5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iNsRaJl4d7YqZipc65JwWHSPo1qnkcWEe8GKRqSMg+M=;
        b=ubnj52I/Oc0UV3g/R7MNXmhOVdaaILhxAkOrheiuov+hyfp0N58QoBmGdygm+T7J3W
         8/Il5wA1CPTgop+qhVy1sSd4pdn5HDi0CpyxcFYpWr+SFsPri0O+MaCYiT9rkYKKeExS
         6aSQIE6Ca1YzRDnh1OCCbayeyWDY8Q6MMujqnHgafzpgT5xsfZVrrG1Bic6tIG4rD62c
         D8uLByEC4EOdmIKkNO+KGMUVnoBPhdrBiHGuMGvs4SbPZ4d3vqOX0PZtp/Dbxv7g/9G5
         znAPMJxiSGcZlkIh45VdrPdkxZM1JJBszm0kIl8vRl/Ov2sgJzvtj+lb7fRUSo+AxAaF
         Gxmw==
X-Gm-Message-State: AO0yUKWcAfrcW2DHICdQsXBq3t5j8wueGiX+vHg7KqtGgJczsDYwuBKZ
        tueLfEeXpmkfxu6jCO+JBtfJBLtHTA==
X-Google-Smtp-Source: AK7set/Q+P3G4wNM4qm7CNiRH01c4Y/gAoXOPpr4ceI8RVBHNiXP3dxMPuirIpKWyRa6c3CHgHNvBw==
X-Received: by 2002:ac8:5952:0:b0:3b8:6c68:e6d with SMTP id 18-20020ac85952000000b003b86c680e6dmr17469894qtz.13.1677104000049;
        Wed, 22 Feb 2023 14:13:20 -0800 (PST)
Received: from citadel.. (075-129-116-198.res.spectrum.com. [75.129.116.198])
        by smtp.gmail.com with ESMTPSA id ey17-20020a05622a4c1100b003b86b088755sm4902460qtb.15.2023.02.22.14.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 14:13:19 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Usama Arif <usama.arif@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 2/6] x86/smpboot: Use current_task to get idle thread
Date:   Wed, 22 Feb 2023 17:12:57 -0500
Message-Id: <20230222221301.245890-3-brgerst@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230222221301.245890-1-brgerst@gmail.com>
References: <20230222221301.245890-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The idle_threads array is not populated during early boot.  Use
current_task instead, which is initialized to init_task for the boot
CPU.

Also simplify start_cpu0().  Since the boot CPU never really goes
offline, the GSBASE is still set up and can be used for per-cpu
accesses.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/kernel/asm-offsets.c | 1 +
 arch/x86/kernel/head_64.S     | 7 ++-----
 kernel/smpboot.c              | 2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 8650f29387e0..445bce086717 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -114,6 +114,7 @@ static void __used common(void)
 	OFFSET(TSS_sp1, tss_struct, x86_tss.sp1);
 	OFFSET(TSS_sp2, tss_struct, x86_tss.sp2);
 	OFFSET(X86_top_of_stack, pcpu_hot, top_of_stack);
+	OFFSET(X86_current_task, pcpu_hot, current_task);
 #ifdef CONFIG_CALL_DEPTH_TRACKING
 	OFFSET(X86_call_depth, pcpu_hot, call_depth);
 #endif
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index c1253aa737ca..c32e5b06a9ce 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -315,7 +315,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	movq	%rcx, early_gdt_descr_base(%rip)
 
 	/* Find the idle task stack */
-	movq	idle_threads(%rbx), %rcx
+	movq	pcpu_hot + X86_current_task(%rbx), %rcx
 	movq	TASK_threadsp(%rcx), %rcx
 	movq	%rcx, initial_stack(%rip)
 #endif /* CONFIG_SMP */
@@ -460,12 +460,9 @@ SYM_CODE_END(secondary_startup_64)
 SYM_CODE_START(start_cpu0)
 	ANNOTATE_NOENDBR
 	UNWIND_HINT_EMPTY
-	/* Load the per-cpu base for CPU#0 */
-	leaq	__per_cpu_offset(%rip), %rbx
-	movq	(%rbx), %rbx
 
 	/* Find the idle task stack */
-	movq	idle_threads(%rbx), %rcx
+	movq	PER_CPU_VAR(pcpu_hot) + X86_current_task, %rcx
 	movq	TASK_threadsp(%rcx), %rsp
 
 	jmp	.Ljump_to_C_code
diff --git a/kernel/smpboot.c b/kernel/smpboot.c
index a18a21dff9bc..2c7396da470c 100644
--- a/kernel/smpboot.c
+++ b/kernel/smpboot.c
@@ -25,7 +25,7 @@
  * For the hotplug case we keep the task structs around and reuse
  * them.
  */
-DEFINE_PER_CPU(struct task_struct *, idle_threads);
+static DEFINE_PER_CPU(struct task_struct *, idle_threads);
 
 struct task_struct *idle_thread_get(unsigned int cpu)
 {
-- 
2.39.2

