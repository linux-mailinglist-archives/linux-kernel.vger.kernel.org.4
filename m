Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991C063FBFE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 00:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbiLAX2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 18:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbiLAX1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 18:27:45 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F5CC9369
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 15:27:16 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e202-20020a2550d3000000b006f9d739c724so3283628ybb.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 15:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=mxnx1olCgpn8Pr+RNzUvtPR2vQ070ZCifbSFVF3Ymvo=;
        b=cTIoFoh3mPUgLL/QEB0t8d8mxoaMjs0WFC4VTtxM2YNkBjNbFk2j4FQLz7ApkM+Nk6
         G33twuelGjD4foWG1Syr5r/C2YpXmkrHPJbJHFQwo/fYv9dfswhlMX9aEbBJFGJzncEq
         3Lm4gk+tvERDgIyxTBgBDJjgEiVpOOvYRJueMb4ZvBoPxQJ01/Z7T1bHQF9vQmJTHxQg
         0TNYH5tBUnsfkHyU0QHy0D8zV+Gf9OCOyHbo9+/vs2eKSedoZcYnELHQU/24rDLMgxXI
         w660ch7/tSYm5Pyi29T2Wu83D+3Qs22B/grTMju+6gUumLPHBrDqhvHPBKiY0LhJuQiy
         6NbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mxnx1olCgpn8Pr+RNzUvtPR2vQ070ZCifbSFVF3Ymvo=;
        b=GSS96IiYDvDD8ZM7fry3ytHO+nJpDGGXxf3cKTwNB5MxQ9/yq5vqT7cLzploS3NNI6
         A/5TaT5Fl13PhO5l0dnOtrgPnEw7q8HJaSOiMKplddxATMT//t8nE7Qe3F+vi8Kko2HS
         ZQrAFl4Q9O4/n6nlJYM+lA4H/vJM52oZGv3L6EpB9l2Z07SRiQy4KfC00qPCV7USJQO4
         9juxZ3i2fikO+RvMOV2u2dPfIOuHE+gIDXIcreoplC60rcCdx9wEvlo9Dsl828QgadmH
         MAlb/8ampaSN39nXnKjB9ES2WY3omJeZMh1EATe7nbVKnjJ2KPHileRzQC7i41TF8QrT
         6Mcw==
X-Gm-Message-State: ANoB5pmnoodb1eU8AtxhLhrSmUCOp7awEQ9C1PX6MPegujGGEy5SiN/s
        4Qa1zYg8pT47Mwi8v6IPnCpoNDxRSWo=
X-Google-Smtp-Source: AA0mqf7YorijRGbMLOiJH8OO7bjSUhytkGUCubeB0e+1e9Wx6/ILmXuh7TNQXpI/A6dFp5ks9Z29TaerEmY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:88c6:0:b0:38d:e8f4:c8ba with SMTP id
 y189-20020a8188c6000000b0038de8f4c8bamr66092474ywf.159.1669937235862; Thu, 01
 Dec 2022 15:27:15 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  1 Dec 2022 23:26:47 +0000
In-Reply-To: <20221201232655.290720-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221201232655.290720-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221201232655.290720-9-seanjc@google.com>
Subject: [PATCH 08/16] x86/reboot: Disable virtualization during reboot iff
 callback is registered
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attempt to disable virtualization during an emergency reboot if and only
if there is a registered virt callback, i.e. iff a hypervisor (KVM) is
active.  If there's no active hypervisor, then the CPU can't be operating
with VMX or SVM enabled (barring an egregious bug).

Note, IRQs are disabled, which prevents KVM from coming along and enabling
virtualization after the fact.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/reboot.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index a006ddaa1405..e0dd1b00ba01 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -22,7 +22,6 @@
 #include <asm/reboot_fixups.h>
 #include <asm/reboot.h>
 #include <asm/pci_x86.h>
-#include <asm/virtext.h>
 #include <asm/cpu.h>
 #include <asm/nmi.h>
 #include <asm/smp.h>
@@ -570,7 +569,6 @@ void cpu_emergency_disable_virtualization(void)
 		callback();
 	rcu_read_unlock();
 }
-#endif /* CONFIG_KVM_INTEL || CONFIG_KVM_AMD */
 
 static void emergency_reboot_disable_virtualization(void)
 {
@@ -587,7 +585,7 @@ static void emergency_reboot_disable_virtualization(void)
 	 * Do the NMI shootdown even if virtualization is off on _this_ CPU, as
 	 * other CPUs may have virtualization enabled.
 	 */
-	if (cpu_has_vmx() || cpu_has_svm(NULL)) {
+	if (rcu_access_pointer(cpu_emergency_virt_callback)) {
 		/* Safely force _this_ CPU out of VMX/SVM operation. */
 		cpu_emergency_disable_virtualization();
 
@@ -595,6 +593,9 @@ static void emergency_reboot_disable_virtualization(void)
 		nmi_shootdown_cpus_on_restart();
 	}
 }
+#else
+static void emergency_reboot_disable_virtualization(void) { }
+#endif /* CONFIG_KVM_INTEL || CONFIG_KVM_AMD */
 
 
 void __attribute__((weak)) mach_reboot_fixups(void)
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

