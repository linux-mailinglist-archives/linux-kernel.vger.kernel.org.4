Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC1B641264
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 01:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbiLCAkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 19:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234976AbiLCAkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 19:40:07 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5203164BD
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 16:37:52 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id a18-20020a62bd12000000b0056e7b61ec78so6299798pff.17
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 16:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=DKqJP7Vjp6qJnG/7BU3uRzryYpaAgZyEUtuw+E87nQQ=;
        b=PCEzejAytOa1aJqFlw0uTsN0TWp8InRHmSRFM4htCGB+SMI/84iNIv2hajPIKx5y+I
         J/w1ZaSXb5YWmaQloVn+TvjsOH8ur8phH87vLAP6yEmymVjsmck6PuLxAx4K2NJK2k8J
         76VbWsXXgw9fHdw/k9F4+pEGXt0cpUS5Vlhk0YOIDGsbJhaOsDKw5QEjIlfMdlB+YleQ
         wKnzBZQ9akoXaZ7mlooolLtNz0TfRYcDr0KGjoWnIY54jfZdH8kGVPtRZNZelxrqOqTi
         yvEX+uz72KPwB5S96Lv3oqrq1YFHZJ6SqpitDTU+1IIKP1kEcJtV4pDKGXRE6NfiF0No
         mSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DKqJP7Vjp6qJnG/7BU3uRzryYpaAgZyEUtuw+E87nQQ=;
        b=VEXXv5gDLTYH707ICaP9yjaszoehtGi1Vyut1ISfLcJyumchcs8DBWvqGSnBWSboYm
         HTp08phiLZ5L8rSOYADNblWuys4pkFy6DixG6C9kwl6sN9nMV/bmuh+za5DjsroVPwQp
         ravAKxaL1ygPfgcelp8afSfrxgBd4VacCmXOLjuO0cUqNUbSLZ0CZIpEiX7oRK6pmtQw
         Imfi6KqoYICa4argTFtW1ddEc5T2lN58TWxIly3y5IhHrhXt/YBR44gwcXIaV3P48ZQa
         HnlG8L7AeuqbABOCSonpJ3tipWnAvGOP7ae1j6WliKZ3DIxneN2OI8+PoxVThA0QFQJP
         31xg==
X-Gm-Message-State: ANoB5plWey1hpFPeah4DlkiA/+Rk/s43Yli+VZyL1kz77jo0Bq8HvoPT
        aAhnukc/ZzzhUj7tezCl3ew9BvWQhog=
X-Google-Smtp-Source: AA0mqf7tAkACTFTjewTL0hSc4V8mUF2uZIWpoBoxKnADATbemKx0CWdfx0K3J/W6U3L4eJYI2BCTQTR4boI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:27ab:b0:56c:71a4:efe with SMTP id
 bd43-20020a056a0027ab00b0056c71a40efemr58903928pfb.84.1670027872358; Fri, 02
 Dec 2022 16:37:52 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat,  3 Dec 2022 00:37:44 +0000
In-Reply-To: <20221203003745.1475584-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221203003745.1475584-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221203003745.1475584-3-seanjc@google.com>
Subject: [PATCH 2/3] x86/cpu: Mark SGX and VMX as being dependent on MSR_IA32_FEAT_CTL
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

Mark SGX and VMX as being dependent on MSR_IA32_FEAT_CTL now that CPUID
dependencies are processed unconditionally, i.e. now that SGX and VMX
will be disabled if MSR_IA32_FEAT_CTL is unsupported even if the kernel
never explicitly disables MSR_IA32_FEAT_CTL.  Since init_ia32_feat_ctl()
is invoked if and only if the CPU might possibly support the MSR and the
kernel was built with the necessary CPU_SUP_*=y, it's possible for a CPU
that supports VMX and/or SGX to run on a kernel that never sets the
feature flag.

Explicitly clear MSR_IA32_FEAT_CTL if reading the MSR faults to handle
the extremely unlikely edge case where the RDMSR fails when restoring CPU
state after suspend, hibernate, kexec, etc.

Capturing the SGX and VMX dependencies will allow dropping manual checks
on X86_FEATURE_MSR_IA32_FEAT_CTL for code that just wants to detect if
SGX or VMX is fully supported.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/cpuid-deps.c | 2 ++
 arch/x86/kernel/cpu/feat_ctl.c   | 3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 68e26d4c8063..37abdb6fb4ea 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -72,6 +72,8 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_AVX512_FP16,		X86_FEATURE_AVX512BW  },
 	{ X86_FEATURE_ENQCMD,			X86_FEATURE_XSAVES    },
 	{ X86_FEATURE_PER_THREAD_MBA,		X86_FEATURE_MBA       },
+	{ X86_FEATURE_VMX,			X86_FEATURE_MSR_IA32_FEAT_CTL },
+	{ X86_FEATURE_SGX,			X86_FEATURE_MSR_IA32_FEAT_CTL },
 	{ X86_FEATURE_SGX_LC,			X86_FEATURE_SGX	      },
 	{ X86_FEATURE_SGX1,			X86_FEATURE_SGX       },
 	{ X86_FEATURE_SGX2,			X86_FEATURE_SGX1      },
diff --git a/arch/x86/kernel/cpu/feat_ctl.c b/arch/x86/kernel/cpu/feat_ctl.c
index 03851240c3e3..0b7186d9ba05 100644
--- a/arch/x86/kernel/cpu/feat_ctl.c
+++ b/arch/x86/kernel/cpu/feat_ctl.c
@@ -117,8 +117,7 @@ void init_ia32_feat_ctl(struct cpuinfo_x86 *c)
 	u64 msr;
 
 	if (rdmsrl_safe(MSR_IA32_FEAT_CTL, &msr)) {
-		clear_cpu_cap(c, X86_FEATURE_VMX);
-		clear_cpu_cap(c, X86_FEATURE_SGX);
+		clear_cpu_cap(c, X86_FEATURE_MSR_IA32_FEAT_CTL);
 		return;
 	}
 
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

