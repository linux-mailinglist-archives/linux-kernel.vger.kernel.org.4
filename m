Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067EB7012C2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 01:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241591AbjELXwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 19:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241301AbjELXv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 19:51:58 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20057E719
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:51:16 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba69d93a6b5so6415306276.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683935459; x=1686527459;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=KGKAnySlWtkvOAmbXxK2nlX19G10s26Qrw8fOC1mwIY=;
        b=xSptbPlAmdBo3OoV/lCpZzZM3pkZJe4U21Afu0d5tN2bwXkPEValyNtS1oEWn+XSbv
         sddtILRUbr35bNgtJCqHWHVCTZuJK4YUQGqsvtkMdbHnBPRtVcEgEVQP5WUj5aq/p/Fe
         EMHqkeMn2A+c73IsL9bazRv44DPi4+wbcSkO27qRDKC4+1DNxjVhdD2whZ7Etl30iCzq
         V7if3TNYXP7wmXBA4s5axBA9bvm1slAgM5s6SLgLjOkzr0KujZ7P+tQWaRx/8ZyHx4Jn
         8CM32tr9uvqMHKRQhRvPjgImjU4WjHw7ctslGis+z1TBI89xg4LUA4HStSs4TXGNDFmV
         RFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683935459; x=1686527459;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KGKAnySlWtkvOAmbXxK2nlX19G10s26Qrw8fOC1mwIY=;
        b=Di7oatcCaNV5CwlJgVxYnS1JTCs+lKZF5cQcIFXMOyGNpStFSdcbaMS4mtWZ7g8ngr
         O9QgsjuK2+B1ImK92Hp4BxVYbCgOpH0gTskmtmHqBg+DeV1iDgBmBqWYfDFV8ilgp0SS
         sf+uqnd3A+Oz8fUFOmWuPVjhutfgcrmzA5YR5F3dhH3yNr6Xh4IZDutYYmSBVnXmdv/t
         GR9p7IcP77//yawkoYwCvJrR3q2CQ9oCdYTg2f/n8d1lPlATcIUvoIcEGfZomgq+Lpf9
         Z8jz55xv5A3+MmOirdHtXXhc4ORfr7pzxWVAi7aZlfYL+j+eCug9pkByOD6jdIgr+c/F
         lb5g==
X-Gm-Message-State: AC+VfDyMkR9lnVeO9u/yjC1HQ318br38qN+WKPVKyCzJNTztztPgwH+P
        0juaqNPfGwWUynifq/iEqx+r7pAhzLo=
X-Google-Smtp-Source: ACHHUZ6bBFVSrUuklgMDoFuwtCNwdtWGXarWaTlMpuS4Uei0RmmQyl9n5X2oX0HUPA0T5TVgW/DWQSOLPTM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:180b:b0:b1d:5061:98e3 with SMTP id
 cf11-20020a056902180b00b00b1d506198e3mr15831702ybb.6.1683935459101; Fri, 12
 May 2023 16:50:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 12 May 2023 16:50:24 -0700
In-Reply-To: <20230512235026.808058-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230512235026.808058-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230512235026.808058-17-seanjc@google.com>
Subject: [PATCH v3 16/18] x86/virt: KVM: Move "disable SVM" helper into KVM SVM
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Kai Huang <kai.huang@intel.com>, Chao Gao <chao.gao@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 arch/x86/include/asm/virtext.h | 50 ----------------------------------
 arch/x86/kvm/svm/svm.c         | 28 +++++++++++++++++--
 2 files changed, 25 insertions(+), 53 deletions(-)
 delete mode 100644 arch/x86/include/asm/virtext.h

diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
deleted file mode 100644
index 632575e257d8..000000000000
--- a/arch/x86/include/asm/virtext.h
+++ /dev/null
@@ -1,50 +0,0 @@
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
-		 * Force GIF=1 prior to disabling SVM to ensure INIT and NMI
-		 * aren't blocked, e.g. if a fatal error occurred between CLGI
-		 * and STGI.  Note, STGI may #UD if SVM is disabled from NMI
-		 * context between reading EFER and executing STGI.  In that
-		 * case, GIF must already be set, otherwise the NMI would have
-		 * been blocked, so just eat the fault.
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
index cf5f3880751b..2cc195d95d32 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -41,7 +41,6 @@
 #include <asm/reboot.h>
 #include <asm/fpu/api.h>
 
-#include <asm/virtext.h>
 #include "trace.h"
 
 #include "svm.h"
@@ -587,9 +586,32 @@ void __svm_write_tsc_multiplier(u64 multiplier)
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
+		 * Force GIF=1 prior to disabling SVM to ensure INIT and NMI
+		 * aren't blocked, e.g. if a fatal error occurred between CLGI
+		 * and STGI.  Note, STGI may #UD if SVM is disabled from NMI
+		 * context between reading EFER and executing STGI.  In that
+		 * case, GIF must already be set, otherwise the NMI would have
+		 * been blocked, so just eat the fault.
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
@@ -598,7 +620,7 @@ static void svm_hardware_disable(void)
 	if (tsc_scaling)
 		__svm_write_tsc_multiplier(SVM_TSC_RATIO_DEFAULT);
 
-	cpu_svm_disable();
+	kvm_cpu_svm_disable();
 
 	amd_pmu_disable_virt();
 }
-- 
2.40.1.606.ga4b1b128d6-goog

