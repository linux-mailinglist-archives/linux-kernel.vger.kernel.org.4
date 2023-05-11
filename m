Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2CB6FFD55
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 01:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239594AbjEKXeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 19:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239574AbjEKXd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 19:33:59 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB6D5FD2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 16:33:58 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1aad9af33c1so93826465ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 16:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683848037; x=1686440037;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=cOrgUlHpOAMPmZ+StptvgqaX6DcVrL8V0qVFj+MTpWU=;
        b=3Fa2pfYTrzongvw+2wZAPpSntt85/6aUe3Vtm86lOFwvxfbwMs78Q3I2sTq9MovEpR
         aoNsErsK+Bef8YseM7drICvYFVQQ5IyvsNcDQ8f5Cazlc0O8K+hQTEQEfX6wAs1yCaXp
         P/UK2gJ8FtA/wOLMlfom8DZmJ3NPPK87eRmkqG75tEijyAnLL7pcOd40Qle53l1an76L
         1f+9oIrohRY5Us6SCxGAi/r7Kt7ZZml42CCC6czfGkWfrisfMcu7Syp3vWjwiqpIV2Xn
         +LMr/4hhvfc1fyi6j49wvBy7ckFxzNq+xwti3aYTsbXS+zA8vlyzoXLHFxB49NLp0A53
         93Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683848037; x=1686440037;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cOrgUlHpOAMPmZ+StptvgqaX6DcVrL8V0qVFj+MTpWU=;
        b=bCWVi8cJkGUDL/yCEudtgg/p1Z+aXLdF6BSmyATS8U7+KqAy63VIkfjzBhE/qhco/2
         rTgZNp8xYDWGVu12xzDlH/Iw3RdgLATLWurIlsnpWaYCk9nn6rup8ANn9+1UMMND1lK3
         E2jRFC2PP7B/L/uht/8nbikZiD8g3no8vqBgik7ES0V786ZbpqU3G2FrIvZmIkBMHtkn
         pHIE2PC8tBI/4rUqHHlxE899MWAQtXmQeNFoaDKVPp/95gsUkYMzjaykKFhohCPo+bYB
         ZfG+QRLtUiiARCCm8zb0lzms0uGPY8vlQmKbG9Gi6QHq9b68KNYLlTblkj+E5ugg51L5
         gDWw==
X-Gm-Message-State: AC+VfDwtZG2erXGK2K0YsWtFY/YNmCw6eA3ilePOeNbMoDZSYgRbcYB5
        LENLrR37qIUof6UYgXHiVqvnukaqDy4=
X-Google-Smtp-Source: ACHHUZ4iV5UzOGo0s0EI3akrtwRyHYxvSNNz/jrEoxL9ORDVEiIunJIWVIcQPv8RbK2l2oGYvTLJ0CrLL6Y=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:a612:b0:1a6:9363:163a with SMTP id
 u18-20020a170902a61200b001a69363163amr8568408plq.10.1683848037734; Thu, 11
 May 2023 16:33:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 11 May 2023 16:33:45 -0700
In-Reply-To: <20230511233351.635053-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230511233351.635053-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230511233351.635053-3-seanjc@google.com>
Subject: [PATCH v2 2/8] KVM: SVM: Use kvm_pat_valid() directly instead of kvm_mtrr_valid()
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai Huang <kai.huang@intel.com>,
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

From: Ke Guo <guoke@uniontech.com>

Use kvm_pat_valid() directly instead of bouncing through kvm_mtrr_valid().
The PAT is not an MTRR, and kvm_mtrr_valid() just redirects to
kvm_pat_valid(), i.e. is exempt from KVM's "zap SPTEs" logic that's
needed to honor guest MTRRs when the VM has a passthrough device with
non-coherent DMA (KVM does NOT set "ignore guest PAT" in this case, and so
enables hardware virtualization of the guest's PAT, i.e. doesn't need to
manually emulate the PAT memtype).

Signed-off-by: Ke Guo <guoke@uniontech.com>
[sean: massage changelog]
Reviewed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index eb308c9994f9..db237ccdc957 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2935,7 +2935,7 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 
 		break;
 	case MSR_IA32_CR_PAT:
-		if (!kvm_mtrr_valid(vcpu, MSR_IA32_CR_PAT, data))
+		if (!kvm_pat_valid(data))
 			return 1;
 		vcpu->arch.pat = data;
 		svm->vmcb01.ptr->save.g_pat = data;
-- 
2.40.1.606.ga4b1b128d6-goog

