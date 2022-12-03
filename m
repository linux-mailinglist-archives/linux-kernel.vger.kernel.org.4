Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB51E641262
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 01:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbiLCAkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 19:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbiLCAkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 19:40:05 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A071FCE2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 16:37:51 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id d3-20020a056a0010c300b005728633819aso6231897pfu.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 16:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=MQ2DipcqCIIlOynGgQG74Sc/21NET4A4uu5IriUFE+o=;
        b=SxXUc63M6tJlnEa9G90sZBb/Ga5eyEFP62Gfiw9NU6XZfZ69koBRG2/Frc3Q8OO1Ir
         epCvPCR+Lwsf5k+Wh+9lsvuoCwEZ+NpFtEklIm5YibOyYi0oUg09BqcOqma9relrrOLi
         EXF2fSH3KYgb8w8AILUxXYy1mSxUcGwKEXfu9hMDmuhLLpFfVstM87mNxi16PLYjKpmd
         AlQ46jDB/4NYtyjm3Mg8LMVw09cCwYGC4dHCyNib2PcemJai46WlGhkOljYFlwvoH7Kh
         kMr79+aA+eGhiD9LwpFnZAOOq28GPIxB2reEE/YXVMGrdCSjj0bxIOaB7A2MJyAx7jCB
         ZRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MQ2DipcqCIIlOynGgQG74Sc/21NET4A4uu5IriUFE+o=;
        b=yYOWv08F2UFCiMF6MzRXxZlqMaGLyOsDoV3rQ6HfQlYFL1ahFcqC7w9ul9qZciDq+F
         lV918pCik6vhF2/Q8fiyAGk1n3ObjJC18nxx1tzA+ZA15wBUYl4kMaNm0L4xKXVRzOrX
         5XLF+K90xT6D5DI6jXzJ/zO5i4aS4K9ri9fZCgxLzTnGsX/pnF7QwHKiJXzJNid5nHkU
         eiyt0CMGMsdKZuac9QjuSv86Es705eYYN3fO5aZ9AAuq/cdUtQWcp2PtC8SgsBQkuGqy
         7noi3IW0Ov6zQmFIiElpXohUPOEJyBP1cUzeZNs8RyOwjVWFqheLQ0u46f/qPHb2IRoo
         12SA==
X-Gm-Message-State: ANoB5pmC9dMNXaAomqv+AuI2GLckfG8f8LqCJo5X/jD4+IxZLY+ZYuBB
        tvon//PxLD+G3qR9vvGqSSPXFQ3O5IQ=
X-Google-Smtp-Source: AA0mqf60LwLI+B5CAhzEB274z+4qWW/tmrNFD8b4CF81EQ/v0Hxz0pXGZ0T5ibAU0iU/TQJI05r0LBxcITs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:aa7:8dd3:0:b0:573:4ae5:e475 with SMTP id
 j19-20020aa78dd3000000b005734ae5e475mr54315834pfr.64.1670027870646; Fri, 02
 Dec 2022 16:37:50 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat,  3 Dec 2022 00:37:43 +0000
In-Reply-To: <20221203003745.1475584-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221203003745.1475584-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221203003745.1475584-2-seanjc@google.com>
Subject: [PATCH 1/3] x86/cpu: Process all CPUID dependencies after identifying
 CPU info
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Process all CPUID dependencies to ensure that a dependent is disabled if
one or more of its parent features is unsupported.  As is, cpuid_deps is
processed if an only if a feature is explicitly disabled via
clear_cpu_cap(), which makes it annoying/dangerous to use cpuid_deps for
features whose parent(s) do not always have explicit processing.

E.g. VMX and SGX depend on the synthetic X86_FEATURE_MSR_IA32_FEAT_CTL,
but there is no common location to clear MSR_IA32_FEAT_CTL, and so
consumers of VMX and SGX are forced to check MSR_IA32_FEAT_CTL on top
of the dependent feature.

Manually clearing X86_FEATURE_MSR_IA32_FEAT_CTL is the obvious
alternative, but it's subtly more difficult that updating
init_ia32_feat_ctl().  CONFIG_IA32_FEAT_CTL depends on any of
CONFIG_CPU_SUP_{INTEL,CENATUR,ZHAOXIN}, but init_ia32_feat_ctl() is
invoked if and only if the actual CPU type matches one of the
aforementioned CPU_SUP_* types. E.g. running a kernel built with

  CONFIG_CPU_SUP_INTEL=y
  CONFIG_CPU_SUP_AMD=y
  # CONFIG_CPU_SUP_HYGON is not set
  # CONFIG_CPU_SUP_CENTAUR is not set
  # CONFIG_CPU_SUP_ZHAOXIN is not set

on a Cenatur or Zhaoxin CPU will leave X86_FEATURE_VMX set but not set
X86_FEATURE_MSR_IA32_FEAT_CTL, and will never call init_ia32_feat_ctl()
to give the kernel a convenient opportunity to clear
X86_FEATURE_MSR_IA32_FEAT_CTL.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/cpufeature.h |  1 +
 arch/x86/kernel/cpu/common.c      |  6 ++++++
 arch/x86/kernel/cpu/cpuid-deps.c  | 10 ++++++++++
 3 files changed, 17 insertions(+)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 1a85e1fb0922..c4408d03b180 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -147,6 +147,7 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 
 extern void setup_clear_cpu_cap(unsigned int bit);
 extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
+extern void apply_cpuid_deps(struct cpuinfo_x86 *c);
 
 #define setup_force_cpu_cap(bit) do { \
 	set_cpu_cap(&boot_cpu_data, bit);	\
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index bf4ac1cb93d7..094fc69dba63 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1887,6 +1887,12 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 
 	ppin_init(c);
 
+	/*
+	 * Apply CPUID dependencies to ensure dependent features are disabled
+	 * if a parent feature is unsupported but wasn't explicitly disabled.
+	 */
+	apply_cpuid_deps(c);
+
 	/* Init Machine Check Exception if available. */
 	mcheck_cpu_init(c);
 
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index c881bcafba7d..68e26d4c8063 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -138,3 +138,13 @@ void setup_clear_cpu_cap(unsigned int feature)
 {
 	do_clear_cpu_cap(NULL, feature);
 }
+
+void apply_cpuid_deps(struct cpuinfo_x86 *c)
+{
+	const struct cpuid_dep *d;
+
+	for (d = cpuid_deps; d->feature; d++) {
+		if (!cpu_has(c, d->depends))
+			clear_cpu_cap(c, d->feature);
+	}
+}
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

