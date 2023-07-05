Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628107489FE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 19:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjGERQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 13:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbjGERQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 13:16:40 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F5E1990
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 10:16:38 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id ffacd0b85a97d-30e3ee8a42eso4014906f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 10:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688577397; x=1691169397;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JinL7apUcf1gP8XFQ2zINdZou7Iz++svzqv8hjqcpG4=;
        b=qhATiPaQGUeviA9TREjpGVzTZx+eTBG89ShqA4kl7lRGvGT2pMGvWUaqt7NNkQzxyq
         /8PfVlQzl2LO6vi9TG7V/WxWFIjejptKtQ3gE+KS0fttIaQaez4asKtUnqd5AUYlLpuD
         awhMObsKdv38WIDH0dL6OgfJy5Ni8d4zakklW1EH4W0zfmNzHTBiGO0AhOyjihEADCxH
         Fg9FGroFeOnM7yzvUcvZ3ud/7en6PdC+nOVuASFjR7k1Q1TKyabCB3ANMsSDPWmGrMd3
         dsBf2Q/ywjG5B7GVmP2r7lTkTjtFXCkkDKTM8UkQgRORQmnMuSdIO/t0keG1MCfuxilF
         52pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688577397; x=1691169397;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JinL7apUcf1gP8XFQ2zINdZou7Iz++svzqv8hjqcpG4=;
        b=greo7zrKYQ2XXQ2sozUSRKwQ8oVhLcpjemorIdUYFM2RHdsTy8k0WNvoqcnoS/52hz
         Em9x/du4NfC8CT/lf8nXwzMD6/bkicV0n9Zfp5d3xU9tr/WvVX9BdTm3vCEdD/MtKssW
         knqt8PEtJsDoAgtqm5k/E/UmmlYfEu/cXWpnf8MvoTNtOYaQuPfjCSqvSf+xZmtw9tba
         O3Mp+czPUtGqxVCKkV7Hdp0SVefPPUoeoMcMapYn7spBGRxXWjUOUvCTzhB6pD3FPzWm
         OiVbXt/E64k/nfolR/wvX76Rbx+mK+xcBpKVmVyDt6qSqBIAqWQ+JhZqVCuOlgb6lWX0
         r46A==
X-Gm-Message-State: ABy/qLZxfdeTSfOsEGqe/6/0hTbRSCP5sxeBvlIew2Mcc1hoSwEgmQgX
        oo53QwqpUi3UI2Tfrhew2mEPu01ID7r6QQ==
X-Google-Smtp-Source: APBJJlFkHZZLMEUKPg1ln3ifk7FwbaHB5Cy7w0D302g94jAtmOYJbK1FmiBpCETF2/qG1bslXczmFq8a2EmO8w==
X-Received: from mostafa.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:adf:dd0a:0:b0:313:ff50:2855 with SMTP id
 a10-20020adfdd0a000000b00313ff502855mr108174wrm.9.1688577396831; Wed, 05 Jul
 2023 10:16:36 -0700 (PDT)
Date:   Wed,  5 Jul 2023 17:16:32 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230705171632.3912123-1-smostafa@google.com>
Subject: [PATCH] KVM: arm64: Add missing BTI instruction in kvm_host_psci_cpu_entry
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvm_host_psci_cpu_entry is called from __kvm_hyp_init_cpu through "br"
instruction as __kvm_hyp_init_cpu resides in idmap section while
kvm_host_psci_cpu_entry is in hyp .text so the offset is larger than
26 bits covered by "b".
Which means that this function should start with "bti j" instruction.

LLVM which is the only compiler supporting BTI for Linux, adds "bti j"
for jump tables or by when taking the address of the block [1].
And same behaviour is observed with GCC.

As kvm_host_psci_cpu_entry is a C function, this must be done in
assembly.

Another solution is to use X16/X17 with "br", as according to ARM
ARM DDI0487I.a RLJHCL/IGMGRS, PACIASP has an implicit branch
target identification instruction that is compatible with
PSTATE.BTYPE 0b01 which includes "br X16/X17"
And the kvm_host_psci_cpu_entry has PACIASP as it is an external
function.
Although I see that using explicit "bti" makes more clear than relying
on which register is used.

A third solution is to clear SCTLR_EL2.BT, which would make PACIASP
compatible PSTATE.BTYPE 0b11 ( "br" to other registers).
However this deviates from the kernel behaviour (in bti_enable()).

[1] https://reviews.llvm.org/D52867

Fixes: b53d4a272349 ("KVM: arm64: Use BTI for nvhe")
Signed-off-by: Mostafa Saleh <smostafa@google.com>
Reported-and-tested-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/kvm/hyp/nvhe/host.S       | 10 ++++++++++
 arch/arm64/kvm/hyp/nvhe/psci-relay.c |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
index c87c63133e10..9d6e95b32097 100644
--- a/arch/arm64/kvm/hyp/nvhe/host.S
+++ b/arch/arm64/kvm/hyp/nvhe/host.S
@@ -297,3 +297,13 @@ SYM_CODE_START(__kvm_hyp_host_forward_smc)
 
 	ret
 SYM_CODE_END(__kvm_hyp_host_forward_smc)
+
+/*
+ * kvm_host_psci_cpu_entry is called through br instruction, which requires
+ * BTI J instruction, compilers (gcc and llvm) doesn't insert BTI J for external
+ * functions, but BTI C instead.
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

