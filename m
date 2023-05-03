Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62986F5BBF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 18:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjECQIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 12:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjECQIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 12:08:47 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A995FD9
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 09:08:45 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-24e1e19f63fso1586562a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 09:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683130125; x=1685722125;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=F144eoCeyA3mGp/9QFbuPwEidkOEdjSbu5w6lAyh6tg=;
        b=bzRemaUOhe4C2ko7GCOlJLuq4pAEvX1VHd29wjyOtd4yYZaBvIwoy/d+o1waEdMyJj
         BCgAibDdiUHQbECs2na1CLXIDKB8pKhbMPaifjHkxl7PwyoJCRUPb+XXAXe1VpCyvZzF
         7IACK9zyJZOsu5REQr/z65uvP+RIC6+GaVIzmT33T0r6LS6sCDP1yzEacksdwPT0L582
         KR3RWa86mAFLWYWQeAI8NOF/HxqdxLv82FA5TYSmGjd3xBpRz6FZPe4oVDKGDUeRjbfj
         YXPEkHv31IlyuPYpResgGE3Yqrn4AenSHyAqfRwZVDh+C/2NM49WlnJ0lIhaxEhlK6ap
         lcvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683130125; x=1685722125;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F144eoCeyA3mGp/9QFbuPwEidkOEdjSbu5w6lAyh6tg=;
        b=h5eSpl1yVKaCuaMWK9jndyu7d1CNiUtxBYvncQUnSHxWDKB2MfU8Ig5YeWr1zqja3Z
         ydydqlY+czEaYQb5hlbeyPqUSnj82eNYgUGB/vMwU50WQqhAmPoEM6a3nTt+Rga4a87P
         LK2/k7Qj56YFKDWeYio5WLFXAMEzoOK2PjHt+FaOvOleWmLwcTQ8HC4M3jITfq0E+FG1
         SZjqXKfec1gqSWaQhQ83Qgt/wxdly3lLoGR1b0VXQAPRmlqbYqdpxKeRePl95g1SIAS0
         rF0maaSAy4bsjP7fSNkHFFdAWMtFxjZnOx6yvLoSBQrAa7vFl+0+1B7u5JtQhV2qUb29
         bLrg==
X-Gm-Message-State: AC+VfDx25G+LZtMbibi64orZfrsomtfxIhBhN95lKMSKHKKVXR8x+eBz
        323GLySqWfb6mKeAJui4dTOwSqdSfis=
X-Google-Smtp-Source: ACHHUZ6MHMBXR1R7NPeyJnsAeK9YlOAQkFyod6bpbvy1HtIkhwmS+KE19Sd2GwwHAaNjKX7GnvENM5ocE3c=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:b616:b0:1a9:baa9:e573 with SMTP id
 b22-20020a170902b61600b001a9baa9e573mr178574pls.5.1683130125382; Wed, 03 May
 2023 09:08:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  3 May 2023 09:08:37 -0700
In-Reply-To: <20230503160838.3412617-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230503160838.3412617-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230503160838.3412617-3-seanjc@google.com>
Subject: [PATCH v2 2/3] KVM: x86: Don't adjust guest's CPUID.0x12.1 (allowed
 SGX enclave XFRM)
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop KVM's manipulation of guest's CPUID.0x12.1 ECX and EDX, i.e. the
allowed XFRM of SGX enclaves, now that KVM explicitly checks the guest's
allowed XCR0 when emulating ECREATE.

Note, this could theoretically break a setup where userspace advertises
a "bad" XFRM and relies on KVM to provide a sane CPUID model, but QEMU
is the only known user of KVM SGX, and QEMU explicitly sets the SGX CPUID
XFRM subleaf based on the guest's XCR0.

Reviewed-by: Kai Huang <kai.huang@intel.com>
Tested-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 123bf8b97a4b..0c9660a07b23 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -253,7 +253,6 @@ static void __kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu, struct kvm_cpuid_e
 				       int nent)
 {
 	struct kvm_cpuid_entry2 *best;
-	u64 guest_supported_xcr0 = cpuid_get_supported_xcr0(entries, nent);
 
 	best = cpuid_entry2_find(entries, nent, 1, KVM_CPUID_INDEX_NOT_SIGNIFICANT);
 	if (best) {
@@ -292,21 +291,6 @@ static void __kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu, struct kvm_cpuid_e
 					   vcpu->arch.ia32_misc_enable_msr &
 					   MSR_IA32_MISC_ENABLE_MWAIT);
 	}
-
-	/*
-	 * Bits 127:0 of the allowed SECS.ATTRIBUTES (CPUID.0x12.0x1) enumerate
-	 * the supported XSAVE Feature Request Mask (XFRM), i.e. the enclave's
-	 * requested XCR0 value.  The enclave's XFRM must be a subset of XCRO
-	 * at the time of EENTER, thus adjust the allowed XFRM by the guest's
-	 * supported XCR0.  Similar to XCR0 handling, FP and SSE are forced to
-	 * '1' even on CPUs that don't support XSAVE.
-	 */
-	best = cpuid_entry2_find(entries, nent, 0x12, 0x1);
-	if (best) {
-		best->ecx &= guest_supported_xcr0 & 0xffffffff;
-		best->edx &= guest_supported_xcr0 >> 32;
-		best->ecx |= XFEATURE_MASK_FPSSE;
-	}
 }
 
 void kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu)
-- 
2.40.1.495.gc816e09b53d-goog

