Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E17C71308B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 01:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243376AbjEZXpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 19:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238032AbjEZXo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 19:44:57 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0738E42
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 16:44:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bad475920a8so633623276.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 16:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685144693; x=1687736693;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7JLLUnbPXAaoH9i/N14KC8FRF4yfK0mZvbZkcTBOq5Y=;
        b=Ne/YRQ/svpJFGXhXpgHmwxc0D9cLMxIoz8hghy2YEExILLlaUzGTTLTu8b32WLIGJt
         Pl2W5ENMW5Sa2Kwrgh0yVLYa4j/IXKl/wxvEFqusCYfl9i2LCglCwg4qFOwnu/SiZlAZ
         epK5zgrczZWcQF0/2oLgZ8laj6CsPXbNpnBrvrF3XhoGhjELY5RWTIQgLbNJgOlO3uxt
         4d+XiEr2KggZNk0D2a/3M0F1IRHplA5m+1NXrAN0tP918Y2nokL0n9zRLbfOWAMyaJ2Q
         beEb9W4X5NKj/DpGHg7ZQVC9QnQZ7wDRATscsNx8htwusD9k+VmLxpoV1j1SSPGezxSx
         58Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685144693; x=1687736693;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7JLLUnbPXAaoH9i/N14KC8FRF4yfK0mZvbZkcTBOq5Y=;
        b=anMb0t9Glpu3K95EuJXc7QOY2b0zO+34FivWTruuX8GUWh9+cB53hYSaSYR7AdVAvT
         eebD6UF42ihI6kmCRyQrb8aRdSwFX7J+Xj8jePLYvLdb/PJgPkxBZCYGG43B7L+mBQ/g
         dfKwlZ0vRHJ/jT7xMZaV/5UIzOdkc3BWIU9MB5XxUaCMP0Ixar4co6Yn4zFZ9LXc9JhG
         KxubRouyFC0Dk88uG+VrbtDy1Cy9tfSwATit6uh0bjjjjNyoAQjBlPVR6pYzEO2VVB+S
         z5eNmsLpWAzZ9zMQ47cgupdW5mOe4qUwub3JeKHMu+QYIhEwxncEZaVjJPUDJVgExuhw
         N+rg==
X-Gm-Message-State: AC+VfDyXVMTYSEOw4sCOzneYmANBcBIA9XX7eRoH2NYBv0ftFzYCOtEK
        880LF5iLs+IYebsZ6DC0304UGNxQKfo=
X-Google-Smtp-Source: ACHHUZ5CZlpEmT2VkUcPhwDn9jTP7EScM/+97DNWp/Z/n1uD6F2Bv8HNZfloYPpxuZT6MB0BvBWbDvtVv+8=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:910f:8a15:592b:2087])
 (user=yuzhao job=sendgmr) by 2002:a5b:9c6:0:b0:ba8:381b:f764 with SMTP id
 y6-20020a5b09c6000000b00ba8381bf764mr354063ybq.3.1685144692904; Fri, 26 May
 2023 16:44:52 -0700 (PDT)
Date:   Fri, 26 May 2023 17:44:33 -0600
In-Reply-To: <20230526234435.662652-1-yuzhao@google.com>
Message-Id: <20230526234435.662652-9-yuzhao@google.com>
Mime-Version: 1.0
References: <20230526234435.662652-1-yuzhao@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH mm-unstable v2 08/10] kvm/x86: move tdp_mmu_enabled and shadow_accessed_mask
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Alistair Popple <apopple@nvidia.com>,
        Anup Patel <anup@brainfault.org>,
        Ben Gardon <bgardon@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Gavin Shan <gshan@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        Marc Zyngier <maz@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Larabel <michael@michaellarabel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Paul Mackerras <paulus@ozlabs.org>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Huth <thuth@redhat.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.linux.dev,
        kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-trace-kernel@vger.kernel.org, x86@kernel.org,
        linux-mm@google.com, Yu Zhao <yuzhao@google.com>
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

tdp_mmu_enabled and shadow_accessed_mask are needed to implement
kvm_arch_has_test_clear_young().

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 arch/x86/include/asm/kvm_host.h | 6 ++++++
 arch/x86/kvm/mmu.h              | 6 ------
 arch/x86/kvm/mmu/spte.h         | 1 -
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index fb9d1f2d6136..753c67072c47 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1772,6 +1772,7 @@ struct kvm_arch_async_pf {
 
 extern u32 __read_mostly kvm_nr_uret_msrs;
 extern u64 __read_mostly host_efer;
+extern u64 __read_mostly shadow_accessed_mask;
 extern bool __read_mostly allow_smaller_maxphyaddr;
 extern bool __read_mostly enable_apicv;
 extern struct kvm_x86_ops kvm_x86_ops;
@@ -1855,6 +1856,11 @@ void kvm_fire_mask_notifiers(struct kvm *kvm, unsigned irqchip, unsigned pin,
 			     bool mask);
 
 extern bool tdp_enabled;
+#ifdef CONFIG_X86_64
+extern bool tdp_mmu_enabled;
+#else
+#define tdp_mmu_enabled false
+#endif
 
 u64 vcpu_tsc_khz(struct kvm_vcpu *vcpu);
 
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 92d5a1924fc1..84aedb2671ef 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -253,12 +253,6 @@ static inline bool kvm_shadow_root_allocated(struct kvm *kvm)
 	return smp_load_acquire(&kvm->arch.shadow_root_allocated);
 }
 
-#ifdef CONFIG_X86_64
-extern bool tdp_mmu_enabled;
-#else
-#define tdp_mmu_enabled false
-#endif
-
 static inline bool kvm_memslots_have_rmaps(struct kvm *kvm)
 {
 	return !tdp_mmu_enabled || kvm_shadow_root_allocated(kvm);
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 1279db2eab44..a82c4fa1c47b 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -153,7 +153,6 @@ extern u64 __read_mostly shadow_mmu_writable_mask;
 extern u64 __read_mostly shadow_nx_mask;
 extern u64 __read_mostly shadow_x_mask; /* mutual exclusive with nx_mask */
 extern u64 __read_mostly shadow_user_mask;
-extern u64 __read_mostly shadow_accessed_mask;
 extern u64 __read_mostly shadow_dirty_mask;
 extern u64 __read_mostly shadow_mmio_value;
 extern u64 __read_mostly shadow_mmio_mask;
-- 
2.41.0.rc0.172.g3f132b7071-goog

