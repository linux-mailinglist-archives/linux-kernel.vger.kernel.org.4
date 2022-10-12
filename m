Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEFC95FCA73
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 20:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiJLSSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 14:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiJLSRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 14:17:46 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8116CAE237
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 11:17:25 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id pj13-20020a17090b4f4d00b0020b0a13cba4so2725705pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 11:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=oyyfiq1u1ow61sJxYdtEop67BKEuTOwTRoB44Qlve6k=;
        b=P2usEtoXL2d7Kadfzc6pHmhtZOrLbkU1dncF458jZB05kEaDR4KjrjxeuY2vSXDSFo
         bzwldY+iDn3YjfRcxMznyMfidl6/WuUWEP2QFEgmLDI3MAwPiaWHJCuCHdIGXcW+eSGN
         g/sEzO9PGlOgo6Vr6vFw6JZI73bhDmBxShW+cbqHQzscfO6bl7+73l8UYRTpUv1xyY3g
         +iU0rq7hqAlv49yzPLEq1daKsx2PPabZ8Od1fF8YSttMwMcfv7oszFPM2d32wM99sV4e
         h1fDGa/bn6rViRE0jfB29EyHUGVv1B9iTHYnpZW4bVSacmvCNnfVBmr1nw2Q07saZkag
         o1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oyyfiq1u1ow61sJxYdtEop67BKEuTOwTRoB44Qlve6k=;
        b=KZ+ZAncOzMputnKTpLKOh84OZdNYgTzsRNjZuNMUZfKXM/97WXhF7zG+ImvpFR9g5Y
         L3MRRBHAJ67rt4UtLbUuJEGhV9c9fiR9WblfVlrHclmvzGYi5PM0pXqs/N3Hf6y0lz8V
         TQatmSRUL+yNqz54mLZT1YKFKMqgfQv/4vckv9AoE1q8LtG6kIDGAWhv3KSuXy1ySem3
         zZXRx2VAZ6CHpFBuUkdNHStAaUD62m8Z0qMYiG1+JBo4FXx65dJkyZqWn7pTVVddNpQO
         1qSFFtvQjNT0kcO0w8IcTyzR4vV5gttH42LR1TZ5mKie6Bl1OM6ql8Agwe80yuscdyd6
         oX6g==
X-Gm-Message-State: ACrzQf0MkWNSpel8rOgCNaIee3FIeTfPgDvlpAB39tFv54C4of+NiPiz
        XJDqTaZ4UNovbsoS1HwYFP84roD4MzQ=
X-Google-Smtp-Source: AMsMyM5a7PIgQlH+XQAxQkl3E0hWyOTVe15+NXdqge73zQWdRTWS96H4/6KaihK8TGdSJwuYFfp8urRmBZs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1349:b0:563:654d:ce3f with SMTP id
 k9-20020a056a00134900b00563654dce3fmr17351716pfu.32.1665598644547; Wed, 12
 Oct 2022 11:17:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 12 Oct 2022 18:17:01 +0000
In-Reply-To: <20221012181702.3663607-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221012181702.3663607-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221012181702.3663607-11-seanjc@google.com>
Subject: [PATCH v4 10/11] KVM: x86/mmu: Use static key/branches for checking
 if TDP MMU is enabled
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Matlack <dmatlack@google.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>
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

Now that the TDP MMU being enabled is read-only after the vendor module
is loaded, use a static key to track whether or not the TDP MMU is
enabled to avoid conditional branches in hot paths, e.g. in
direct_page_fault() and fast_page_fault().

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu.h     |  5 +++--
 arch/x86/kvm/mmu/mmu.c | 14 ++++++++++----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 1ad6d02e103f..bc0d8a5c09f9 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -2,6 +2,7 @@
 #ifndef __KVM_X86_MMU_H
 #define __KVM_X86_MMU_H
 
+#include <linux/jump_label.h>
 #include <linux/kvm_host.h>
 #include "kvm_cache_regs.h"
 #include "cpuid.h"
@@ -230,13 +231,13 @@ static inline bool kvm_shadow_root_allocated(struct kvm *kvm)
 }
 
 #ifdef CONFIG_X86_64
-extern bool tdp_mmu_enabled;
+DECLARE_STATIC_KEY_TRUE(tdp_mmu_enabled);
 #endif
 
 static inline bool is_tdp_mmu_enabled(void)
 {
 #ifdef CONFIG_X86_64
-	return tdp_mmu_enabled;
+	return static_branch_likely(&tdp_mmu_enabled);
 #else
 	return false;
 #endif
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 4792d76edd6d..a5ba7b41263d 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -101,8 +101,10 @@ bool tdp_enabled = false;
 #ifdef CONFIG_X86_64
 static bool __ro_after_init tdp_mmu_allowed;
 
-bool __read_mostly tdp_mmu_enabled = true;
-module_param_named(tdp_mmu, tdp_mmu_enabled, bool, 0444);
+static bool __read_mostly __tdp_mmu_enabled = true;
+module_param_named(tdp_mmu, __tdp_mmu_enabled, bool, 0444);
+
+DEFINE_STATIC_KEY_TRUE(tdp_mmu_enabled);
 #endif
 
 static int max_huge_page_level __read_mostly;
@@ -5702,7 +5704,11 @@ void kvm_configure_mmu(bool enable_tdp, int tdp_forced_root_level,
 	max_tdp_level = tdp_max_root_level;
 
 #ifdef CONFIG_X86_64
-	tdp_mmu_enabled = tdp_mmu_allowed && tdp_enabled;
+	__tdp_mmu_enabled = tdp_mmu_allowed && tdp_enabled;
+	if (__tdp_mmu_enabled)
+		static_branch_enable(&tdp_mmu_enabled);
+	else
+		static_branch_disable(&tdp_mmu_enabled);
 #endif
 	/*
 	 * max_huge_page_level reflects KVM's MMU capabilities irrespective
@@ -6712,7 +6718,7 @@ void __init kvm_mmu_x86_module_init(void)
 	 * TDP MMU is actually enabled is determined in kvm_configure_mmu()
 	 * when the vendor module is loaded.
 	 */
-	tdp_mmu_allowed = tdp_mmu_enabled;
+	tdp_mmu_allowed = __tdp_mmu_enabled;
 #endif
 
 	kvm_mmu_spte_module_init();
-- 
2.38.0.rc1.362.ged0d419d3c-goog

