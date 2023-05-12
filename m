Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988C76FFD58
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 01:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239615AbjEKXeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 19:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239577AbjEKXeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 19:34:03 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE9865A4
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 16:34:00 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-53017eb8b2eso5547426a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 16:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683848039; x=1686440039;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=kPIJozqKXpOav88tMQOfWStS9Qhm+Sc47i+elwuNCsI=;
        b=B086lI0nSfRZjZS0qeaNeIB8DDth56jWhjosvQ9CDikIgaIEztFBmRseLITc0/8cEN
         sB4veeK84ZUL5joKqH6ggii054kSdHisLNq4Utk7jHhXp0af8TfzwZumClHUC8FvBk7J
         8Mn7v2WRwzoXX4Dh8QgorX7R9KwtJzd8qEu11tgjrMJZT1ICpcVZXQQuwZRp3qdStBe0
         dDug+R5w9hlsFahXiEhsS2LDD7b4TUG9NKTFAJYKWgj39cgoGsnveKJOxcyKQDYFaMEY
         dGTvrnwDnI8ragV8iJXBF8PH8pc4brBGGTDJKecp03K3pLmgEWeVo38MoVQ6c+QI63On
         6/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683848039; x=1686440039;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kPIJozqKXpOav88tMQOfWStS9Qhm+Sc47i+elwuNCsI=;
        b=K1+QhBqOJhWYpahTBK12o69o4Q+OJaL7ZL64ypXAEeR0Yj5SbKBb9BXCFRsw+IWNrE
         A9NipQgFeo672OIgAmd1Mvr6I6/xqbZui42uijo6Zsj8dx3dIK29BhyWHrXusccqivuH
         l6P8/26FZeRuLdgUNbX8bYMbniiIByJ/F5md51MDlp36WrfacA+01uunX+5njRD98mJ/
         j2brB4VupCJluzCuZnR65hcYXkBz6hTzOzLVJ5leuGmZ8Q7RiOKtCs6rzoWLy3ZsFGhP
         fDRIkTCFy9l6bnBlYSghS69Kenb7IVD/PFMZCvpnE9fQGkH8B/HXRuk/O6X4MpZwN4gW
         Uk7w==
X-Gm-Message-State: AC+VfDw9aQSPEXJZOfEVcHAyHlhKXEdOza0vMBIw2zEoAjKnOfwZin9Y
        f207z6oqKziIz8g1o6TDZdXQjI16Evk=
X-Google-Smtp-Source: ACHHUZ7X6FBQGLOCTTcxT9hzp5S6WwNmF7xHmxSvEmycK6vfJS89hW4oBFJWtB8q/lv6HQZ18nbdn7PJc7U=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:a1d:0:b0:530:8674:b4d5 with SMTP id
 29-20020a630a1d000000b005308674b4d5mr676894pgk.12.1683848039669; Thu, 11 May
 2023 16:33:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 11 May 2023 16:33:46 -0700
In-Reply-To: <20230511233351.635053-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230511233351.635053-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230511233351.635053-4-seanjc@google.com>
Subject: [PATCH v2 3/8] KVM: x86: Add helper to query if variable MTRR MSR is
 base (versus mask)
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper to query whether a variable MTRR MSR is a base versus as mask
MSR.  Replace the unnecessarily complex math with a simple check on bit 0;
base MSRs are even, mask MSRs are odd.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mtrr.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/mtrr.c b/arch/x86/kvm/mtrr.c
index 9fac1ec03463..f65ce4b3980f 100644
--- a/arch/x86/kvm/mtrr.c
+++ b/arch/x86/kvm/mtrr.c
@@ -25,6 +25,12 @@
 #define IA32_MTRR_DEF_TYPE_FE		(1ULL << 10)
 #define IA32_MTRR_DEF_TYPE_TYPE_MASK	(0xff)
 
+static bool is_mtrr_base_msr(unsigned int msr)
+{
+	/* MTRR base MSRs use even numbers, masks use odd numbers. */
+	return !(msr & 0x1);
+}
+
 static bool msr_mtrr_valid(unsigned msr)
 {
 	switch (msr) {
@@ -342,10 +348,9 @@ static void set_var_mtrr_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data)
 {
 	struct kvm_mtrr *mtrr_state = &vcpu->arch.mtrr_state;
 	struct kvm_mtrr_range *tmp, *cur;
-	int index, is_mtrr_mask;
+	int index;
 
 	index = (msr - 0x200) / 2;
-	is_mtrr_mask = msr - 0x200 - 2 * index;
 	cur = &mtrr_state->var_ranges[index];
 
 	/* remove the entry if it's in the list. */
@@ -356,7 +361,7 @@ static void set_var_mtrr_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data)
 	 * Set all illegal GPA bits in the mask, since those bits must
 	 * implicitly be 0.  The bits are then cleared when reading them.
 	 */
-	if (!is_mtrr_mask)
+	if (is_mtrr_base_msr(msr))
 		cur->base = data;
 	else
 		cur->mask = data | kvm_vcpu_reserved_gpa_bits_raw(vcpu);
@@ -418,11 +423,8 @@ int kvm_mtrr_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata)
 	else if (msr == MSR_IA32_CR_PAT)
 		*pdata = vcpu->arch.pat;
 	else {	/* Variable MTRRs */
-		int is_mtrr_mask;
-
 		index = (msr - 0x200) / 2;
-		is_mtrr_mask = msr - 0x200 - 2 * index;
-		if (!is_mtrr_mask)
+		if (is_mtrr_base_msr(msr))
 			*pdata = vcpu->arch.mtrr_state.var_ranges[index].base;
 		else
 			*pdata = vcpu->arch.mtrr_state.var_ranges[index].mask;
-- 
2.40.1.606.ga4b1b128d6-goog

