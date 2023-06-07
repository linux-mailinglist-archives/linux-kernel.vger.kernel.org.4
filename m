Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF58726CBF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbjFGUgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbjFGUfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:35:40 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C8C2703
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 13:35:26 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-2564b3494baso2840929a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 13:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686170126; x=1688762126;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=DquDErYwSPFQFhe20Zbr/7qCAnoddW9Z0B+S6Q5Fhio=;
        b=FWGwOMWthgPc7UaDciIlmjesryq0AK5GA+YXJcOdu9psUB2gPqYflrXJurDw3MfrmF
         xp0Z49eUO7QsMN3rNY0J1alAZYZVNzeP+Mu3QTZzSGz5fInRhB2bRA5IN7ibxTkvMdRO
         0/Nxq+wibrs8faMQnqw7EmBrIRJSQDsulrVe1AkJ4Ceo58bipREb9vDr8AEuGoNE45y+
         z01xOaiLmbXcd/KkH+qG8k2EmLGEo2cwH08QFZhwMckgO8uuNQbWIhSRFvTMcursA1IB
         9d0mbPQsrJLjrc3trMUHYnTwkmGUaAwMlkrnfd7O147NByHy+8b4Fn89fdgNSE2izsDZ
         Edbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686170126; x=1688762126;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DquDErYwSPFQFhe20Zbr/7qCAnoddW9Z0B+S6Q5Fhio=;
        b=FMvQzp9h4vmy6Sjt2ebspU2TGyNVrr3yULyBsScDotDZ0Xc9nbrktG9BpUgy4T/lov
         zy6dgixowR4/G2uKtZFtf1MHdZkcc6iBm0cMPqDv6vM4C0JawJpO5AFsXqUDvGtMUHH1
         3allGtIxvpmWpxD1oRxVJIyyasOOlGRa+Xx5BM9OKmN4VOFQiCJWxs8Pa7Qbz5G/K52G
         xkDhpylKHymtNo9oUO/WKc+s4XVq/MizzYAekgbFYXeTVEhtWcakjceAi3UD+5s2xIJl
         q7QEwyCMOXw3am2rE0hHcTa4F3grGrC4tP98SKkTid1DaywWupotKf0wlYrJaOYMbOwA
         LCoA==
X-Gm-Message-State: AC+VfDzp1OQFvIJIdY5m2QkCKlCDoLa5JWZCKwThrRsj6SUoMiKrFSAN
        i6oFA5SDKM2knBclBRC1G6MtGNT+B6E=
X-Google-Smtp-Source: ACHHUZ4Bu6Z4iuKJGZ/XdfxdMPwtpbxA9+mAfD76YKLnzNWMnhs0o+MBIjCmUylppJXZ4F8X9XT+FHSQJDM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:907:b0:253:56ee:2172 with SMTP id
 bo7-20020a17090b090700b0025356ee2172mr1643711pjb.6.1686170125989; Wed, 07 Jun
 2023 13:35:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  7 Jun 2023 13:35:18 -0700
In-Reply-To: <20230607203519.1570167-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230607203519.1570167-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230607203519.1570167-3-seanjc@google.com>
Subject: [PATCH 2/3] KVM: SVM: Clean up handling of LBR virtualization enabled
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

Clean up the enable_lbrv computation in svm_update_lbrv() to consolidate
the logic for computing enable_lbrv into a single statement, and to remove
the coding style violations (lack of curly braces on nested if).

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index b7d145571f75..db97eca6c1ae 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -961,15 +961,10 @@ static struct vmcb *svm_get_lbr_vmcb(struct vcpu_svm *svm)
 void svm_update_lbrv(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
-
-	bool enable_lbrv = svm_get_lbr_vmcb(svm)->save.dbgctl & DEBUGCTLMSR_LBR;
-
-	bool current_enable_lbrv = !!(svm->vmcb->control.virt_ext &
-				      LBR_CTL_ENABLE_MASK);
-
-	if (unlikely(is_guest_mode(vcpu) && svm->lbrv_enabled))
-		if (unlikely(svm->nested.ctl.virt_ext & LBR_CTL_ENABLE_MASK))
-			enable_lbrv = true;
+	bool current_enable_lbrv = svm->vmcb->control.virt_ext & LBR_CTL_ENABLE_MASK;
+	bool enable_lbrv = (svm_get_lbr_vmcb(svm)->save.dbgctl & DEBUGCTLMSR_LBR) ||
+			   (is_guest_mode(vcpu) && svm->lbrv_enabled &&
+			    (svm->nested.ctl.virt_ext & LBR_CTL_ENABLE_MASK));
 
 	if (enable_lbrv == current_enable_lbrv)
 		return;
-- 
2.41.0.162.gfafddb0af9-goog

