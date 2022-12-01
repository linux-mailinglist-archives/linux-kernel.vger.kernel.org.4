Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBADE63FC0C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 00:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbiLAX3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 18:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbiLAX2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 18:28:24 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A06DCF789
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 15:27:28 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id pa16-20020a17090b265000b0020a71040b4cso2938985pjb.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 15:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=nVLXdYejrcua3wTUeNkWgCThb6Lpcy1BgMQmZ5bZe4M=;
        b=TXHeUjjbugM+AmeKkD4B4A3KLhdcZ7ljZbuQPNSoSb87JxUqp1NIhswkLLphZ3dmRr
         je0ZhrVi9Hut4hTXSzT7WdZHjdMuefJJxUXxpiHwA3Q601WSolyJ7lPedgVPpW9I+kDC
         k4IAhc/4NGIK7Q6MlszXT4wyv1nbj45C/2D/QgdBf1s4QCAPZBh9BKj1uGvs5DRy9Jn2
         5WXmKEgNxxFQXPzhOsEKBbhvMESFoaQhEgV5gU4NgA85/3WeDtQ03LrjYgXfkr9eebgG
         7Eyf/fQ4jQXDYtUSUKjp8MTJf1NuHk9CrM02Rm7kI4G0RlYe1jDQ9ERXRYZ0Qa8pACR6
         c+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nVLXdYejrcua3wTUeNkWgCThb6Lpcy1BgMQmZ5bZe4M=;
        b=xdX/kS8QqSP70R4pYtu9NbEY7VkjTFzA46ntcxQZLcdixhxu21Qzdoxml8PD+Mxyoo
         gEkzAsOc+e6bu1jhXOE5MtSMqobLLSK/t1iqjBFJdf8i/0x4t4sEKqJQGkDE3ulPmem5
         ligqxZ+JNsDENP0cCbgNPrs7J1nItC3AvRFbFThOfHAzDrALkWh+BI+9MfmPrxaQoiCN
         Gp7fvPliHN8rrZXR8UWXVGe9ZgrLM2RcsNS4AsscaUVvB6umIJ67GYrZbTAIbNEOvkAd
         tkvYNFlBr8m2dC3hW2yXyA4PiR/QEQ21gWgnO0IolEA83QsVCWivMw3KKP6MuBMcec54
         nvdQ==
X-Gm-Message-State: ANoB5pn3qm9803klwRkxzBKbqiL0OyJdyd7TnuLHVpggH7Hqi/qOzUg8
        rbW4361K/EsKC/ofx0wDpRTGP2MNli4=
X-Google-Smtp-Source: AA0mqf6C1RuHk9+9pQBBmj5QPNvYMawTzMK/5CWJaDKDXJYU+1useC2MDvF4QdkOIMDVyFOnGH3L1J4KMho=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a62:52c4:0:b0:576:e21:8a32 with SMTP id
 g187-20020a6252c4000000b005760e218a32mr6732194pfb.46.1669937245736; Thu, 01
 Dec 2022 15:27:25 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  1 Dec 2022 23:26:53 +0000
In-Reply-To: <20221201232655.290720-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221201232655.290720-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221201232655.290720-15-seanjc@google.com>
Subject: [PATCH 14/16] x86/virt: KVM: Move "disable SVM" helper into KVM SVM
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Andrew Cooper <Andrew.Cooper3@citrix.com>
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

Move cpu_svm_disable() into KVM proper now that all hardware
virtualization management is routed through KVM.  Remove the now-empty
virtext.h.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/virtext.h | 47 ----------------------------------
 arch/x86/kvm/svm/svm.c         | 25 +++++++++++++++---
 2 files changed, 22 insertions(+), 50 deletions(-)
 delete mode 100644 arch/x86/include/asm/virtext.h

diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
deleted file mode 100644
index 683d20411335..000000000000
--- a/arch/x86/include/asm/virtext.h
+++ /dev/null
@@ -1,47 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/* CPU virtualization extensions handling
- *
- * This should carry the code for handling CPU virtualization extensions
- * that needs to live in the kernel core.
- *
- * Author: Eduardo Habkost <ehabkost@redhat.com>
- *
- * Copyright (C) 2008, Red Hat Inc.
- *
- * Contains code from KVM, Copyright (C) 2006 Qumranet, Inc.
- */
-#ifndef _ASM_X86_VIRTEX_H
-#define _ASM_X86_VIRTEX_H
-
-#include <asm/processor.h>
-
-#include <asm/vmx.h>
-#include <asm/svm.h>
-#include <asm/tlbflush.h>
-
-/*
- * SVM functions:
- */
-/** Disable SVM on the current CPU
- */
-static inline void cpu_svm_disable(void)
-{
-	uint64_t efer;
-
-	wrmsrl(MSR_VM_HSAVE_PA, 0);
-	rdmsrl(MSR_EFER, efer);
-	if (efer & EFER_SVME) {
-		/*
-		 * Force GIF=1 prior to disabling SVM, e.g. to ensure INIT and
-		 * NMI aren't blocked.  Eat faults on STGI, as it #UDs if SVM
-		 * isn't enabled and SVM can be disabled by an NMI callback.
-		 */
-		asm_volatile_goto("1: stgi\n\t"
-				  _ASM_EXTABLE(1b, %l[fault])
-				  ::: "memory" : fault);
-fault:
-		wrmsrl(MSR_EFER, efer & ~EFER_SVME);
-	}
-}
-
-#endif /* _ASM_X86_VIRTEX_H */
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index ba281651dee4..2aec27b34487 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -41,7 +41,6 @@
 #include <asm/reboot.h>
 #include <asm/fpu/api.h>
 
-#include <asm/virtext.h>
 #include "trace.h"
 
 #include "svm.h"
@@ -571,9 +570,29 @@ void __svm_write_tsc_multiplier(u64 multiplier)
 	preempt_enable();
 }
 
+static inline void kvm_cpu_svm_disable(void)
+{
+	uint64_t efer;
+
+	wrmsrl(MSR_VM_HSAVE_PA, 0);
+	rdmsrl(MSR_EFER, efer);
+	if (efer & EFER_SVME) {
+		/*
+		 * Force GIF=1 prior to disabling SVM, e.g. to ensure INIT and
+		 * NMI aren't blocked.  Eat faults on STGI, as it #UDs if SVM
+		 * isn't enabled and SVM can be disabled by an NMI callback.
+		 */
+		asm_volatile_goto("1: stgi\n\t"
+				  _ASM_EXTABLE(1b, %l[fault])
+				  ::: "memory" : fault);
+fault:
+		wrmsrl(MSR_EFER, efer & ~EFER_SVME);
+	}
+}
+
 static void svm_emergency_disable(void)
 {
-	cpu_svm_disable();
+	kvm_cpu_svm_disable();
 }
 
 static void svm_hardware_disable(void)
@@ -582,7 +601,7 @@ static void svm_hardware_disable(void)
 	if (tsc_scaling)
 		__svm_write_tsc_multiplier(SVM_TSC_RATIO_DEFAULT);
 
-	cpu_svm_disable();
+	kvm_cpu_svm_disable();
 
 	amd_pmu_disable_virt();
 }
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

