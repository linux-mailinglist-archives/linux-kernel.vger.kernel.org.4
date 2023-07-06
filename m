Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E4A74A0CF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbjGFPWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjGFPWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:22:46 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B749AA
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 08:22:45 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-569e7aec37bso9357237b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 08:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688656965; x=1691248965;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VKkGNFGAOB4USWKpvy2EpxfGhrOPACQMax7HtOyXC/I=;
        b=CyZPgXDdQ30bQCb+jUXEjDDQXXJT5YgeNBsjGo+1f3Glm2lnPhGi/N/oCHxE8goUvy
         ZWFLQOncK2rg99pr6GAB+tLnbXmaKUIjNKHenSrHkcoksyZfKlptazxIFWma25pIVAGh
         yZrWcJL4CwqFgcE/hjAto4uuJ6E+pqSUfoBIa+CssasTC0TdWtSKLbMdMLvllY9iIvhg
         6hkdI4/k0+WcjLZnLbI5i4a8wuSs7/bPbKMTwuipRzYvnckjt4RYqYPOZBgcdWei++4t
         CUXP2ZiHe2YeEY620Noqz5gCChdRA5NnbbuXfoYF1DfU6rVR5dvdMZvbRLZXoEDqPzQD
         xY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688656965; x=1691248965;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VKkGNFGAOB4USWKpvy2EpxfGhrOPACQMax7HtOyXC/I=;
        b=KClZVjB06LPGh+eQuEj7fJqlRNMwa8dB2Re+/yzxMYYXUD+v2rXwu86oSjmM0/W3uj
         E7ldo6PrBECBchTdH20n0UrW8zXTZTO+6wLE81N98itnVif9+g49x0aBKQIYpiTBdB1I
         v5FXMo+hH85r253p66TVD7atu6N6OG7Vyfc0ATWfox+K3ZwjFgF2hOJq0GR3Xeijh1ao
         5pfGGvWg2/qor6zSnr1OtJXPf/TwdRoUngtQQVhabOjpKhErsoU3MKrZKhw4c5ky1ov4
         slVASvtCq4PCkU+kcGgKaVwJGDmGlkjQ7xEAPr1dgWMtZInKLYAiRVhJLFKwKbUt+2N9
         9gzQ==
X-Gm-Message-State: ABy/qLbjHWBLaP+rinVjF5jFU8K9VRpABX8pDn0v8uHcsyag8NnqA5cc
        B3bc8k2kWCS35pEVBD1LNpE1UL6ArISdvQ==
X-Google-Smtp-Source: APBJJlEko497DGUDiRAMdGkTRXbHaagFdl9o7KP6ciruOG47DGGSg4wy6ycDr0AdERo3Ke4qRabvPOuh2fk33g==
X-Received: from mostafa.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a81:4323:0:b0:56c:e585:8b17 with SMTP id
 q35-20020a814323000000b0056ce5858b17mr16822ywa.5.1688656964807; Thu, 06 Jul
 2023 08:22:44 -0700 (PDT)
Date:   Thu,  6 Jul 2023 15:22:40 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230706152240.685684-1-smostafa@google.com>
Subject: [PATCH v2] KVM: arm64: Add missing BTI instructions
From:   Mostafa Saleh <smostafa@google.com>
To:     maz@kernel.org, oliver.upton@linux.dev,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     tabba@google.com, qperret@google.com, will@kernel.org,
        catalin.marinas@arm.com, yuzenghui@huawei.com,
        suzuki.poulose@arm.com, james.morse@arm.com, bgardon@google.com,
        gshan@redhat.com, sudeep.holla@arm.com,
        Mostafa Saleh <smostafa@google.com>
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

Some bti instructions were missing from
commit b53d4a272349 ("KVM: arm64: Use BTI for nvhe")

1) kvm_host_psci_cpu_entry
kvm_host_psci_cpu_entry is called from __kvm_hyp_init_cpu through "br"
instruction as __kvm_hyp_init_cpu resides in idmap section while
kvm_host_psci_cpu_entry is in hyp .text so the offset is larger than
128MB range covered by "b".
Which means that this function should start with "bti j" instruction.

LLVM which is the only compiler supporting BTI for Linux, adds "bti j"
for jump tables or by when taking the address of the block [1].
Same behaviour is observed with GCC.

As kvm_host_psci_cpu_entry is a C function, this must be done in
assembly.

Another solution is to use X16/X17 with "br", as according to ARM
ARM DDI0487I.a RLJHCL/IGMGRS, PACIASP has an implicit branch
target identification instruction that is compatible with
PSTATE.BTYPE 0b01 which includes "br X16/X17"
And the kvm_host_psci_cpu_entry has PACIASP as it is an external
function.
Although, using explicit "bti" makes it more clear than relying on
which register is used.

A third solution is to clear SCTLR_EL2.BT, which would make PACIASP
compatible PSTATE.BTYPE 0b11 ("br" to other registers).
However this deviates from the kernel behaviour (in bti_enable()).

2) Spectre vector table
"br" instructions are generated at runtime for the vector table
(__bp_harden_hyp_vecs).
These branches would land on vectors in __kvm_hyp_vector at offset 8.
As all the macros are defined with valid_vect/invalid_vect, it is
sufficient to add "bti j" at the correct offset.

[1] https://reviews.llvm.org/D52867

Fixes: b53d4a272349 ("KVM: arm64: Use BTI for nvhe")
Signed-off-by: Mostafa Saleh <smostafa@google.com>
Reported-by: Sudeep Holla <sudeep.holla@arm.com>
---
v1 -> v2:
- Add another missing bti in spectre vector table.
v1: https://lore.kernel.org/all/20230705171632.3912123-1-smostafa@google.com/
---
 arch/arm64/kvm/hyp/hyp-entry.S       |  8 ++++++++
 arch/arm64/kvm/hyp/nvhe/host.S       | 10 ++++++++++
 arch/arm64/kvm/hyp/nvhe/psci-relay.c |  2 +-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
index 8f3f93fa119e..03f97d71984c 100644
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -154,6 +154,12 @@ SYM_CODE_END(\label)
 	esb
 	stp	x0, x1, [sp, #-16]!
 662:
+	/*
+	 * spectre vectors __bp_harden_hyp_vecs generate br instructions at runtime
+	 * that jump at offset 8 at __kvm_hyp_vector.
+	 * As hyp .text is guarded section, it needs bti j.
+	 */
+	bti j
 	b	\target
 
 check_preamble_length 661b, 662b
@@ -165,6 +171,8 @@ check_preamble_length 661b, 662b
 	nop
 	stp	x0, x1, [sp, #-16]!
 662:
+	/* Check valid_vect */
+	bti j
 	b	\target
 
 check_preamble_length 661b, 662b
diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
index c87c63133e10..7693a6757cd7 100644
--- a/arch/arm64/kvm/hyp/nvhe/host.S
+++ b/arch/arm64/kvm/hyp/nvhe/host.S
@@ -297,3 +297,13 @@ SYM_CODE_START(__kvm_hyp_host_forward_smc)
 
 	ret
 SYM_CODE_END(__kvm_hyp_host_forward_smc)
+
+/*
+ * kvm_host_psci_cpu_entry is called through br instruction, which requires
+ * bti j instruction as compilers (gcc and llvm) doesn't insert bti j for external
+ * functions, but bti c instead.
+ */
+SYM_CODE_START(kvm_host_psci_cpu_entry)
+       bti j
+       b __kvm_host_psci_cpu_entry
+SYM_CODE_END(kvm_host_psci_cpu_entry)
diff --git a/arch/arm64/kvm/hyp/nvhe/psci-relay.c b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
index 08508783ec3d..24543d2a3490 100644
--- a/arch/arm64/kvm/hyp/nvhe/psci-relay.c
+++ b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
@@ -200,7 +200,7 @@ static int psci_system_suspend(u64 func_id, struct kvm_cpu_context *host_ctxt)
 			 __hyp_pa(init_params), 0);
 }
 
-asmlinkage void __noreturn kvm_host_psci_cpu_entry(bool is_cpu_on)
+asmlinkage void __noreturn __kvm_host_psci_cpu_entry(bool is_cpu_on)
 {
 	struct psci_boot_args *boot_args;
 	struct kvm_cpu_context *host_ctxt;
-- 
2.41.0.255.g8b1d071c50-goog

