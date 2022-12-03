Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F500641265
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 01:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbiLCAkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 19:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234962AbiLCAkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 19:40:10 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A58028E34
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 16:37:54 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3d2994e2d7dso65031047b3.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 16:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=MC/w1VbeKPVS25p2PBg2D3e4noKU6INLaclNyyEmubA=;
        b=lRQYhjIc4/WNKpsAG3TSnyxqKZMKkMSQrtjb2IXntcDwtksdx2B0jag/JkM/mVKjeq
         mc3EGMC02yQVWZycq4T/tbx1RHPVDaCltg20PVtI8v84pyouV1kLZIxn4mc0NXpND4ca
         RJbuaVprWxsxEW5libijt60tMCYit/NO3mK/ak0mQZOmHxggxsFpPhUPr6XNx8JitC7b
         RwlzTIXU8NxpZVPHfGZbwWj2boX770JttTo67pfOyj5WDUylTgaLPD7zCSCO0D9GO5fn
         WS1xXi8D4YWG73cb+ZgaF60pz2LScS+S24QdWF785CSoRJXSdYm/AHtAU9NQsL3AOoAW
         SD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MC/w1VbeKPVS25p2PBg2D3e4noKU6INLaclNyyEmubA=;
        b=M5igaCbuZfykt7/v2YXkAWsaBjSprdjDg8wXii9B67Tp7Lm2bGY2TS4pHXNcdkO5Uv
         HgtWR7KDBWfn2ZIdHv647blmO7DrP95hrzIJaZF3Dy0P5iur2fKlxb1bIHJKCdEB8UyO
         cNkC7JDVcYy7HATt8IBLTwkaholctCch7ZQgjSY/eh0/MRDWONj7VDc5zEDH8kEIfduD
         W4qJqUTNCKuOwHZmskhkSposLR+vgqaDVhADwR5VchN+B7/iB4idAV9G2f94rFG5Ual1
         h4XE299cvABD7jCkq+nGD2+CKtFhcM8dB5WUczg6NAUAafJnxzggMtU+piYLN05wbLYS
         9b6w==
X-Gm-Message-State: ANoB5pnosItIcvstTJAbHzivpILTbap9mVRYaV7WSnfdypYdBVQNcia7
        4dhiv5yZzOmJbjLgkbri3/lntdCBr8w=
X-Google-Smtp-Source: AA0mqf6vTM5n+Jbn22HITAdZ+WfIVU4LeqSU7BZS9gjBGZ1bvvHeAbwlLIIgFx4bqx37wOnKUte4P8NPX1E=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:5f50:0:b0:6f2:6848:d383 with SMTP id
 h16-20020a255f50000000b006f26848d383mr40249407ybm.39.1670027873963; Fri, 02
 Dec 2022 16:37:53 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat,  3 Dec 2022 00:37:45 +0000
In-Reply-To: <20221203003745.1475584-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221203003745.1475584-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221203003745.1475584-4-seanjc@google.com>
Subject: [PATCH 3/3] KVM: VMX: Drop manual checks on X86_FEATURE_MSR_IA32_FEAT_CTL
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

Drop manual checks on X86_FEATURE_MSR_IA32_FEAT_CTL and instead rely
solely on the X86_FEATURE_VMX check to detect VMX support now that VMX is
disabled via apply_cpuid_deps() if X86_FEATURE_MSR_IA32_FEAT_CTL isn't
supported.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/bugs.c | 3 +--
 arch/x86/kvm/vmx/vmx.c     | 6 ++----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 9e84b685328f..3071e2a97f0d 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2222,8 +2222,7 @@ static ssize_t l1tf_show_state(char *buf)
 
 static ssize_t itlb_multihit_show_state(char *buf)
 {
-	if (!boot_cpu_has(X86_FEATURE_MSR_IA32_FEAT_CTL) ||
-	    !boot_cpu_has(X86_FEATURE_VMX))
+	if (!boot_cpu_has(X86_FEATURE_VMX))
 		return sysfs_emit(buf, "KVM: Mitigation: VMX unsupported\n");
 	else if (!(cr4_read_shadow() & X86_CR4_VMXE))
 		return sysfs_emit(buf, "KVM: Mitigation: VMX disabled\n");
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 9dba04b6b019..de3fe3932ee8 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2423,8 +2423,7 @@ static __init int cpu_has_kvm_support(void)
 
 static __init int vmx_disabled_by_bios(void)
 {
-	return !boot_cpu_has(X86_FEATURE_MSR_IA32_FEAT_CTL) ||
-	       !boot_cpu_has(X86_FEATURE_VMX);
+	return !boot_cpu_has(X86_FEATURE_VMX);
 }
 
 static int kvm_cpu_vmxon(u64 vmxon_pointer)
@@ -7413,8 +7412,7 @@ static int __init vmx_check_processor_compat(void)
 	struct vmcs_config vmcs_conf;
 	struct vmx_capability vmx_cap;
 
-	if (!this_cpu_has(X86_FEATURE_MSR_IA32_FEAT_CTL) ||
-	    !this_cpu_has(X86_FEATURE_VMX)) {
+	if (!this_cpu_has(X86_FEATURE_VMX)) {
 		pr_err("kvm: VMX is disabled on CPU %d\n", smp_processor_id());
 		return -EIO;
 	}
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

