Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D85726CBE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbjFGUf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbjFGUfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:35:43 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41393269E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 13:35:28 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5428d1915acso645596a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 13:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686170128; x=1688762128;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=jgGL3J+y4YYi/bcB6j3OZN64JX2gA8WjmgGOG10ljEs=;
        b=FtBRDqEhDT9q55n0xQR6Rf5ieQVZhE5Cnn1NvZJ/TW8wF2Xyb/C4lAicVY8vUnhIZD
         zPBOufIPplRK+DIZYdrQOiMeEqGn4V6di7knmWJpsclovsxrV3RFThS1t7e4tDAQp1y6
         HGEVhQ+nPGLIquEqvsomGP/LYHdgnPMONWxL3P8HWN/96ixdKk6p3lNk3mdc35g+rOC9
         fubFNxCLRgEoBBguaAQiaKRSmcWPm3jJvKDLz7sCO+kiX64y6H4TYjtGVqqBDhED3Wrn
         jBcTblIf5gIIukhkejMk2chPPJBVy/svUYv+fo6l8m0qpRfVkPx3+LO44CpRDKsFyzqW
         e9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686170128; x=1688762128;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jgGL3J+y4YYi/bcB6j3OZN64JX2gA8WjmgGOG10ljEs=;
        b=PJanm6DhGPgF/pIM9bogpsw+12P2ARo+3EmDhhE/K++bd98zLw+Cop4R01qfugAwGQ
         ruvr9vbrMDW8boImx7DW4ruHLwO6Cgqb73qxywqG+r6clLtbFNRQI9YX0/71xzaN4m2M
         UAYSJIq8wrpBixocGAta6F5gfhozqqZJ9iWiNRuSNmN4i4mPAkL1/ezgv4wqmVSzi4Gl
         3wCKbB4z7UTH+LMbwMaWECcrQrMLLpqUuWqlEvmknin8ZBmqsTUS1fXresDJlXZKeDUR
         nieT6ARd2G5uUv3CF67i820zGPpu0DKV1tgeKPtZl+Eca+a3BWFs0yEqRAVdZrDaaDx4
         wFZA==
X-Gm-Message-State: AC+VfDzr/aGroruayV+oUShFKo7+pk2WP8PPFm4zJu9ig1/uuVUzEnMT
        /qN6p+pIJ9Ulwy2Vuy0ffUokoLKnVwk=
X-Google-Smtp-Source: ACHHUZ5M9Mnni96gdicl/P/GXr4xEvyfmHJT1HLOEDpoaRo1Anwb1LGOQI0fXiOkt2NBM9HRSDswbjgkXOw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:6c0e:0:b0:53f:9a37:c199 with SMTP id
 y14-20020a656c0e000000b0053f9a37c199mr33964pgu.1.1686170127719; Wed, 07 Jun
 2023 13:35:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  7 Jun 2023 13:35:19 -0700
In-Reply-To: <20230607203519.1570167-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230607203519.1570167-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230607203519.1570167-4-seanjc@google.com>
Subject: [PATCH 3/3] KVM: SVM: Use svm_get_lbr_vmcb() helper to handle writes
 to DEBUGCTL
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Luczaj <mhal@rbox.co>, Yuan Yao <yuan.yao@intel.com>
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

Use the recently introduced svm_get_lbr_vmcb() instead an open coded
equivalent to retrieve the target VMCB when emulating writes to
MSR_IA32_DEBUGCTLMSR.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index db97eca6c1ae..b700de261ce8 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3012,13 +3012,8 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		if (data & DEBUGCTL_RESERVED_BITS)
 			return 1;
 
-		if (svm->vmcb->control.virt_ext & LBR_CTL_ENABLE_MASK)
-			svm->vmcb->save.dbgctl = data;
-		else
-			svm->vmcb01.ptr->save.dbgctl = data;
-
+		svm_get_lbr_vmcb(svm)->save.dbgctl = data;
 		svm_update_lbrv(vcpu);
-
 		break;
 	case MSR_VM_HSAVE_PA:
 		/*
-- 
2.41.0.162.gfafddb0af9-goog

