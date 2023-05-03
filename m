Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA886F5DE9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 20:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjECS3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 14:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjECS3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 14:29:01 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C64D35B6
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 11:29:00 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-64115ef7234so4721162b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 11:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683138539; x=1685730539;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=HR9sDhe1dBWwYsQO66isTNLen+QloTOYlqac4Dib2S0=;
        b=RpPim3urdDOUWuJ3wzy0utodCmxX0rjPl4mUUzwsMX1hw3s9PCKBeD92U/Flg1VcXo
         BMbqTLLdj3Gx+nc7TzpBr5JLhosnACTWbU/0TivFrLub70MDUpfAHs0InFAoISRRSUp5
         4NlW5AgbyWlxTr1gGf8HlzJWL6KgxFkdynlz8+tHNMBJJlw7ATdALt5US3SEahkdNYd1
         dIwiZLYlUblywLajLjSm/9axWRGxsCEhBzqFau67BCzEzwvURmB17++fg+byQc22wiYq
         iMsyTypPoYLBkHF5sXZ4TQC3Zsjq1YTb/kirR7uPmKL81tsozyRZG93BvGjGArcBuy/8
         xDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683138539; x=1685730539;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HR9sDhe1dBWwYsQO66isTNLen+QloTOYlqac4Dib2S0=;
        b=JBFwPtBtzkgSrYUFLMT7pWEo7wi+ijo4daBR32oLbgOriXQ/cJX4tFwk+xZXt5wGeR
         ywqdL46Q66OFKvJwjA2WNoqGfH7+kk56Ix9CNAsqwuDeT4JAFcBGrqHVazHsm/8kDmNa
         kdet7Snxljj60bjEOZUjcPHux8gWciAX5YOfNloBWY3AHUngaQvL8XBxkUvbPnbpNgrq
         Lr9rGMYBSkyheNNH9+QP3ZJrYcizkRv05qz/QCvpITguLncmKlgvlwxOvtaWNQLTqlmr
         69828F3F/YbMCm5UyO6t26Ifu9fY+gqtbe/UCMd8S1BGtfIls0uM2sttH1UmXTkXYSzM
         Yg6Q==
X-Gm-Message-State: AC+VfDxHVsf37k2V2LUAwgnsWmyZumShl/8Q2Uhy9s56AnDFie4QENEs
        r8h+DBZXCTiaeVtmfSF6RexRzk08jFs=
X-Google-Smtp-Source: ACHHUZ5vnASrY3rkukhJSdTxihZ9oIFdZd4vjgC2U7Dd72NAC5HyWufuYAK64L7jBvjgUGjqegNa8gPOV8U=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:2c14:0:b0:51a:7d6a:65c9 with SMTP id
 s20-20020a632c14000000b0051a7d6a65c9mr714454pgs.6.1683138539464; Wed, 03 May
 2023 11:28:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  3 May 2023 11:28:48 -0700
In-Reply-To: <20230503182852.3431281-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230503182852.3431281-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230503182852.3431281-2-seanjc@google.com>
Subject: [PATCH 1/5] KVM: VMX: Open code writing vCPU's PAT in VMX's MSR handler
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wenyao Hai <haiwenyao@uniontech.com>,
        Ke Guo <guoke@uniontech.com>
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

From: Wenyao Hai <haiwenyao@uniontech.com>

Open code setting "vcpu->arch.pat" in vmx_set_msr() instead of bouncing
through kvm_set_msr_common() to get to the same code in kvm_mtrr_set_msr().

Note, MSR_IA32_CR_PAT is 0x277, and is very subtly handled by

	case 0x200 ... MSR_IA32_MC0_CTL2 - 1:

in kvm_set_msr_common().

Signed-off-by: Wenyao Hai <haiwenyao@uniontech.com>
[sean: massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 44fb619803b8..53e249109483 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2294,12 +2294,10 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		    get_vmcs12(vcpu)->vm_exit_controls & VM_EXIT_SAVE_IA32_PAT)
 			get_vmcs12(vcpu)->guest_ia32_pat = data;
 
-		if (vmcs_config.vmentry_ctrl & VM_ENTRY_LOAD_IA32_PAT) {
+		if (vmcs_config.vmentry_ctrl & VM_ENTRY_LOAD_IA32_PAT)
 			vmcs_write64(GUEST_IA32_PAT, data);
-			vcpu->arch.pat = data;
-			break;
-		}
-		ret = kvm_set_msr_common(vcpu, msr_info);
+
+		vcpu->arch.pat = data;
 		break;
 	case MSR_IA32_MCG_EXT_CTL:
 		if ((!msr_info->host_initiated &&
-- 
2.40.1.495.gc816e09b53d-goog

