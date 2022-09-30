Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7185F16BB
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 01:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbiI3Xkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 19:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbiI3Xkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 19:40:36 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6363E118B31
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 16:40:35 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-354262a27c8so55828577b3.15
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 16:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date;
        bh=gvhk32URY2NSKU2Qoi+jLcRts74JXpln1inKdURSUy0=;
        b=cZphvyv8l3Wjvx+c/J8n2t1402SDO9OqukGSRvptGLQp/Gxup9aDqo2f45jtX7fhIb
         ddc+5xpIo7/10kHWeWqGp57C056F1bxasJNs17GWQPv31041TvMm4OWHXGEClaNeHU8Y
         LA95gmij58JvZXcGMbvMueLh154zWCptXyv78IVpP5wqT2/FM2s/Ie7iKSBH9i6Dw2OM
         5+1ptGboqejzMJXvXiNVob/fwn1WABIj0io25lb9ZAhvaiJGDo+bwz+/JJ3DwQE1UgqZ
         VzXyz1bqfoNZ/16Yd5tKKNIVQWKIFHtm1P6Hy4CaHnb3kBq5zWRWZZBKg7eXEZmR1+V9
         /dHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date;
        bh=gvhk32URY2NSKU2Qoi+jLcRts74JXpln1inKdURSUy0=;
        b=krbEgju0whhcM9iZVIYUOndEKWyHrnMXE3NGAy4G+K5WxcTiAFgB1iwTtGQBQ1tcgQ
         DMt3Rf1oQ0S2cxdB+u9HSIeqbxbwWe4H7OP28FFzlK7t1mwO+r/37Tau8aTZHFS9sJcs
         wtrijoH9ggAqW6bPCrf2gwuqPhJT7iwqtMkYtVdFoR92cGQ8ZaIMYCB3a5VmXimz+Ps5
         wI2VSBr6LMZDSAvfuEGU5upj3Sh2y70CagpB4zqqT6Mj/2QDcTQ+SgGPv8o0j3wnwYw2
         lQGRlO1o0oqnLQ7iyL+5FNClUjfwOoPRoJf7VwdQoW+AAu1d9C7ORKCkC8D3fDMuUSoD
         n/vQ==
X-Gm-Message-State: ACrzQf1GKQR9HggYta5BCm5A9r+OY39MdVA0hCFQ2iHJSxw1iYzVzJy1
        iFcpyRAObvNem8xANcyzygxEKo9HGG4=
X-Google-Smtp-Source: AMsMyM45o1XKFlDSrx6HGeAT37nt/BYNSj7ET74GnVHVkQzfPob2hrv+d0qRVVl/UIQU+JKl6ajDW87tyng=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:c2c7:0:b0:6bc:a55e:4ef8 with SMTP id
 s190-20020a25c2c7000000b006bca55e4ef8mr10342546ybf.287.1664581234686; Fri, 30
 Sep 2022 16:40:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 30 Sep 2022 23:40:31 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20220930234031.1732249-1-seanjc@google.com>
Subject: [PATCH] KVM: SVM: Skip WRMSR fastpath on VM-Exit if next RIP isn't valid
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
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

Skip the WRMSR fastpath in SVM's VM-Exit handler if the next RIP isn't
valid, e.g. because KVM is running with nrips=false.  SVM must decode and
emulate to skip the WRMSR if the CPU doesn't provide the next RIP.
Getting the instruction bytes to decode the WRMSR requires reading guest
memory, which in turn means dereferencing memslots, and that isn't safe
because KVM doesn't hold SRCU when the fastpath runs.

Don't bother trying to enable the fastpath for this case, e.g. by doing
only the WRMSR and leaving the "skip" until later.  NRIPS is supported on
all modern CPUs (KVM has considered making it mandatory), and the next
RIP will be valid the vast, vast majority of the time.

  =============================
  WARNING: suspicious RCU usage
  6.0.0-smp--4e557fcd3d80-skip #13 Tainted: G           O
  -----------------------------
  include/linux/kvm_host.h:954 suspicious rcu_dereference_check() usage!

  other info that might help us debug this:

  rcu_scheduler_active = 2, debug_locks = 1
  1 lock held by stable/206475:
   #0: ffff9d9dfebcc0f0 (&vcpu->mutex){+.+.}-{3:3}, at: kvm_vcpu_ioctl+0x8b/0x620 [kvm]

  stack backtrace:
  CPU: 152 PID: 206475 Comm: stable Tainted: G           O       6.0.0-smp--4e557fcd3d80-skip #13
  Hardware name: Google, Inc. Arcadia_IT_80/Arcadia_IT_80, BIOS 10.48.0 01/27/2022
  Call Trace:
   <TASK>
   dump_stack_lvl+0x69/0xaa
   dump_stack+0x10/0x12
   lockdep_rcu_suspicious+0x11e/0x130
   kvm_vcpu_gfn_to_memslot+0x155/0x190 [kvm]
   kvm_vcpu_gfn_to_hva_prot+0x18/0x80 [kvm]
   paging64_walk_addr_generic+0x183/0x450 [kvm]
   paging64_gva_to_gpa+0x63/0xd0 [kvm]
   kvm_fetch_guest_virt+0x53/0xc0 [kvm]
   __do_insn_fetch_bytes+0x18b/0x1c0 [kvm]
   x86_decode_insn+0xf0/0xef0 [kvm]
   x86_emulate_instruction+0xba/0x790 [kvm]
   kvm_emulate_instruction+0x17/0x20 [kvm]
   __svm_skip_emulated_instruction+0x85/0x100 [kvm_amd]
   svm_skip_emulated_instruction+0x13/0x20 [kvm_amd]
   handle_fastpath_set_msr_irqoff+0xae/0x180 [kvm]
   svm_vcpu_run+0x4b8/0x5a0 [kvm_amd]
   vcpu_enter_guest+0x16ca/0x22f0 [kvm]
   kvm_arch_vcpu_ioctl_run+0x39d/0x900 [kvm]
   kvm_vcpu_ioctl+0x538/0x620 [kvm]
   __se_sys_ioctl+0x77/0xc0
   __x64_sys_ioctl+0x1d/0x20
   do_syscall_64+0x3d/0x80
   entry_SYSCALL_64_after_hwframe+0x63/0xcd

Fixes: 404d5d7bff0d ("KVM: X86: Introduce more exit_fastpath_completion enum values")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 58f0077d9357..de9ea2b77f7d 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3904,8 +3904,14 @@ static int svm_vcpu_pre_run(struct kvm_vcpu *vcpu)
 
 static fastpath_t svm_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
 {
-	if (to_svm(vcpu)->vmcb->control.exit_code == SVM_EXIT_MSR &&
-	    to_svm(vcpu)->vmcb->control.exit_info_1)
+	struct vmcb_control_area *control = &to_svm(vcpu)->vmcb->control;
+
+	/*
+	 * Note, the next RIP must be provided as SRCU isn't held, i.e. KVM
+	 * can't read guest memory (dereference memslots) to decode the WRMSR.
+	 */
+	if (control->exit_code == SVM_EXIT_MSR && control->exit_info_1 &&
+	    nrips && control->next_rip)
 		return handle_fastpath_set_msr_irqoff(vcpu);
 
 	return EXIT_FASTPATH_NONE;

base-commit: c59fb127583869350256656b7ed848c398bef879
-- 
2.38.0.rc1.362.ged0d419d3c-goog

