Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDD7726CBB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbjFGUfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbjFGUfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:35:37 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41D22134
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 13:35:24 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-65a971d7337so733243b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 13:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686170124; x=1688762124;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=QKGNbuIRPOc0oEQDRY93/M6VINL0VW78jDwrnuqOT30=;
        b=ZCeDl8WSn650uNgAj+yEDQmfaZ8xkSCJMfbmlFPsuMX9pm89i/I/pi7VVwPhnkTS4M
         +KLDrmheKokh5oF82ijLJqNzIsvdWTs3bkCjpqfjy/ecWcNa/OsRUkLjSl0slVtyKd2h
         XS/aN4FY/t46GNIw/i5GqD7EehEdCdJxYZOp6ARkzbQ2k0AAWZJCjm4EqVpbKb27CWfh
         1xx7X0C99xkGysIVUeq58EH2sygyCUztrR/HPQfuwJfvuJ2lKuVKhyc1ZiIhgTAPv6Fi
         bahA3y7GrwPLiVFYnk++lTRlPXmgRGx/2HqcAtaZURFDoqr+/TQe1GgqMHYNaa0V1xaZ
         occA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686170124; x=1688762124;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QKGNbuIRPOc0oEQDRY93/M6VINL0VW78jDwrnuqOT30=;
        b=PuuR6mseXGPu+tvXOw3o+Wn6FSC3HCZey9kZOryjtDPx81yCHtljgtLqCtuxItghYG
         58FlJWslnXjE0Cqi+RptQfpSXFsaSBmW2AMr4ZBzUGmxOeoDK6r3zj9sh00Ev7bUE861
         j0eX8xdW53AiVPToLtJgawWpDyR9maDiyjibT7w5MrMi5rvUYep2Pz215H5oTtkKeCG+
         QuIAEyOAVFIj28o/wnsFJr/+hskGLCZDlApsh8lFETMFG9exH7/nkSFzN3XM/ezwhG6c
         7PsTeYkooyNoBzSLTWk3qAg2yjX/A53SZm076C2he7CIruw0XrLbU4xyERoxXcuw1zJQ
         1REw==
X-Gm-Message-State: AC+VfDxC6lt0SqzE0CYsfI28DZXR1mylVmEOHRY6tnR/rUfxUIbnagVm
        yx2Y8tz2qFNdzUE7G95frQxSbd4D3Js=
X-Google-Smtp-Source: ACHHUZ4A0Z9xGdm6L3FJIci3sFzmb3bRk8w3wgJgiZF3+B0m1nQOodqHUV+/T4EDQzeMRYR0FT2D3k7Voa8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:10:b0:662:129b:6a54 with SMTP id
 h16-20020a056a00001000b00662129b6a54mr45259pfk.1.1686170124101; Wed, 07 Jun
 2023 13:35:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  7 Jun 2023 13:35:17 -0700
In-Reply-To: <20230607203519.1570167-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230607203519.1570167-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230607203519.1570167-2-seanjc@google.com>
Subject: [PATCH 1/3] KVM: SVM: Fix dead KVM_BUG() code in LBR MSR virtualization
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Luczaj <mhal@rbox.co>, Yuan Yao <yuan.yao@intel.com>
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

Refactor KVM's handling of LBR MSRs on SVM to avoid a second layer of
case statements, and thus eliminate a dead KVM_BUG() call, which (a) will
never be hit in the current code base and (b) if a future commit breaks
things, will never fire as KVM passes "false" instead "true" or '1' for
the KVM_BUG() condition.

Reported-by: Michal Luczaj <mhal@rbox.co>
Cc: Yuan Yao <yuan.yao@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 45 +++++++++++++++---------------------------
 1 file changed, 16 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e265834fe859..b7d145571f75 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -947,43 +947,22 @@ static void svm_disable_lbrv(struct kvm_vcpu *vcpu)
 		svm_copy_lbrs(svm->vmcb01.ptr, svm->vmcb);
 }
 
-static int svm_get_lbr_msr(struct vcpu_svm *svm, u32 index)
+static struct vmcb *svm_get_lbr_vmcb(struct vcpu_svm *svm)
 {
 	/*
-	 * If the LBR virtualization is disabled, the LBR msrs are always
-	 * kept in the vmcb01 to avoid copying them on nested guest entries.
-	 *
-	 * If nested, and the LBR virtualization is enabled/disabled, the msrs
-	 * are moved between the vmcb01 and vmcb02 as needed.
+	 * If LBR virtualization is disabled, the LBR MSRs are always kept in
+	 * vmcb01.  If LBR virtualization is enabled and L1 is running VMs of
+	 * its own, the MSRs are moved between vmcb01 and vmcb02 as needed.
 	 */
-	struct vmcb *vmcb =
-		(svm->vmcb->control.virt_ext & LBR_CTL_ENABLE_MASK) ?
-			svm->vmcb : svm->vmcb01.ptr;
-
-	switch (index) {
-	case MSR_IA32_DEBUGCTLMSR:
-		return vmcb->save.dbgctl;
-	case MSR_IA32_LASTBRANCHFROMIP:
-		return vmcb->save.br_from;
-	case MSR_IA32_LASTBRANCHTOIP:
-		return vmcb->save.br_to;
-	case MSR_IA32_LASTINTFROMIP:
-		return vmcb->save.last_excp_from;
-	case MSR_IA32_LASTINTTOIP:
-		return vmcb->save.last_excp_to;
-	default:
-		KVM_BUG(false, svm->vcpu.kvm,
-			"%s: Unknown MSR 0x%x", __func__, index);
-		return 0;
-	}
+	return svm->vmcb->control.virt_ext & LBR_CTL_ENABLE_MASK ? svm->vmcb :
+								   svm->vmcb01.ptr;
 }
 
 void svm_update_lbrv(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
-	bool enable_lbrv = svm_get_lbr_msr(svm, MSR_IA32_DEBUGCTLMSR) &
-					   DEBUGCTLMSR_LBR;
+	bool enable_lbrv = svm_get_lbr_vmcb(svm)->save.dbgctl & DEBUGCTLMSR_LBR;
 
 	bool current_enable_lbrv = !!(svm->vmcb->control.virt_ext &
 				      LBR_CTL_ENABLE_MASK);
@@ -2795,11 +2774,19 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		msr_info->data = svm->tsc_aux;
 		break;
 	case MSR_IA32_DEBUGCTLMSR:
+		msr_info->data = svm_get_lbr_vmcb(svm)->save.dbgctl;
+		break;
 	case MSR_IA32_LASTBRANCHFROMIP:
+		msr_info->data = svm_get_lbr_vmcb(svm)->save.br_from;
+		break;
 	case MSR_IA32_LASTBRANCHTOIP:
+		msr_info->data = svm_get_lbr_vmcb(svm)->save.br_to;
+		break;
 	case MSR_IA32_LASTINTFROMIP:
+		msr_info->data = svm_get_lbr_vmcb(svm)->save.last_excp_from;
+		break;
 	case MSR_IA32_LASTINTTOIP:
-		msr_info->data = svm_get_lbr_msr(svm, msr_info->index);
+		msr_info->data = svm_get_lbr_vmcb(svm)->save.last_excp_to;
 		break;
 	case MSR_VM_HSAVE_PA:
 		msr_info->data = svm->nested.hsave_msr;
-- 
2.41.0.162.gfafddb0af9-goog

