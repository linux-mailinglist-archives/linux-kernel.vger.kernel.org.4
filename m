Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D046365F8F1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 02:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbjAFBRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 20:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjAFBQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 20:16:14 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B796865ACD
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 17:14:17 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id g15-20020a17090a128f00b0022628a85a1cso125277pja.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 17:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=J1V7EU+EWrvW5nteFG4b5GW6PZRHrRfQBnmCjlAIqUI=;
        b=rDxj9tQKYiqzEAX+7OptTHqneRJr0YZTO6aN9x2uXwofIdTLT+XyoddoR04GgEymcW
         25D9NbmM6Vgxi0CgBfoiD3JVPyjTkX0GiuWUYqrP0ZNe05jdX/VbXNcZ5c8J0vzsBsv6
         ujJcI9s4r9ExZTWATWI8o6fbaFJoF+aOmrVNfw4fCQSYCaLNG5VsjIGmNR+08wBm3Drb
         B57EFQ87pbPdeCc3NufrdRe1bo9pg7o0yCRUEwvs3Hgjzdwo2Ca5VTroIQEdWgSVzzYv
         mlhm/Z6a0pm/y23HQH6gmGxkAA7HtHBaUvgSffwXOme8r+mYa7SGg7BsGqygbGmKSCda
         kYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J1V7EU+EWrvW5nteFG4b5GW6PZRHrRfQBnmCjlAIqUI=;
        b=qdVlcKc8lnOmRQbw4bVLwYn8az+yFPAAhnRNzNH4xxozXwJRBl+g0YnA28U6xGUK4q
         AaJLw2IAtMgnl7VmbL/jQzJ4BltplceCOcSEgfBxRieLJG4s5NPbr3KEooNF5Mjvui4/
         9K6BBU7o2mNK+3TUMCOtGmxs40LQwR2E3QJNhtV8mC3l1Ho2RSs0Yqh+wBG+j9jloSlm
         X3hMhefK2BH18fPsGU1gdB66P8UmuGlj3Qx7ZrYCHiFJOMT6QoequgROollcx87xdTre
         xBGKWkZjK4JKjOVANBGwzGw8PYxtO55OXt7Kq3d4BRBEuqrq4HAqlaZarkvOKi/7xKrK
         pDdA==
X-Gm-Message-State: AFqh2kq8shHN3KpkivsVE0B5iMKPSi2QQ3/AmoTIBrHs7W2SQEN1otnH
        HScVHpf1uAlvQ/r3zZgMWHBQoQcmwkA=
X-Google-Smtp-Source: AMrXdXuM1Zf3I6N21WYVCEKzK0BaaasVg37qf8H7UQ2G6VwfuCFBj22ob5iTFvQCuSf2Ul2Ql0Gy5P66Hf4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:af91:b0:219:9eaa:80e2 with SMTP id
 w17-20020a17090aaf9100b002199eaa80e2mr3338754pjq.207.1672967638285; Thu, 05
 Jan 2023 17:13:58 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  6 Jan 2023 01:12:59 +0000
In-Reply-To: <20230106011306.85230-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230106011306.85230-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230106011306.85230-27-seanjc@google.com>
Subject: [PATCH v5 26/33] KVM: SVM: Update svm->ldr_reg cache even if LDR is "bad"
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Li RongQing <lirongqing@baidu.com>,
        Greg Edwards <gedwards@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update SVM's cache of the LDR even if the new value is "bad".  Leaving
stale information in the cache can result in KVM missing updates and/or
invalidating the wrong entry, e.g. if avic_invalidate_logical_id_entry()
is triggered after a different vCPU has "claimed" the old LDR.

Fixes: 18f40c53e10f ("svm: Add VMEXIT handlers for AVIC")
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 144e383a4c5d..5b33f91b701c 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -539,7 +539,7 @@ static u32 *avic_get_logical_id_entry(struct kvm_vcpu *vcpu, u32 ldr, bool flat)
 	return &logical_apic_id_table[index];
 }
 
-static int avic_ldr_write(struct kvm_vcpu *vcpu, u8 g_physical_id, u32 ldr)
+static void avic_ldr_write(struct kvm_vcpu *vcpu, u8 g_physical_id, u32 ldr)
 {
 	bool flat;
 	u32 *entry, new_entry;
@@ -547,15 +547,13 @@ static int avic_ldr_write(struct kvm_vcpu *vcpu, u8 g_physical_id, u32 ldr)
 	flat = kvm_lapic_get_reg(vcpu->arch.apic, APIC_DFR) == APIC_DFR_FLAT;
 	entry = avic_get_logical_id_entry(vcpu, ldr, flat);
 	if (!entry)
-		return -EINVAL;
+		return;
 
 	new_entry = READ_ONCE(*entry);
 	new_entry &= ~AVIC_LOGICAL_ID_ENTRY_GUEST_PHYSICAL_ID_MASK;
 	new_entry |= (g_physical_id & AVIC_LOGICAL_ID_ENTRY_GUEST_PHYSICAL_ID_MASK);
 	new_entry |= AVIC_LOGICAL_ID_ENTRY_VALID_MASK;
 	WRITE_ONCE(*entry, new_entry);
-
-	return 0;
 }
 
 static void avic_invalidate_logical_id_entry(struct kvm_vcpu *vcpu)
@@ -575,7 +573,6 @@ static void avic_invalidate_logical_id_entry(struct kvm_vcpu *vcpu)
 
 static void avic_handle_ldr_update(struct kvm_vcpu *vcpu)
 {
-	int ret = 0;
 	struct vcpu_svm *svm = to_svm(vcpu);
 	u32 ldr = kvm_lapic_get_reg(vcpu->arch.apic, APIC_LDR);
 	u32 id = kvm_xapic_id(vcpu->arch.apic);
@@ -589,11 +586,8 @@ static void avic_handle_ldr_update(struct kvm_vcpu *vcpu)
 
 	avic_invalidate_logical_id_entry(vcpu);
 
-	if (ldr)
-		ret = avic_ldr_write(vcpu, id, ldr);
-
-	if (!ret)
-		svm->ldr_reg = ldr;
+	svm->ldr_reg = ldr;
+	avic_ldr_write(vcpu, id, ldr);
 }
 
 static void avic_handle_dfr_update(struct kvm_vcpu *vcpu)
-- 
2.39.0.314.g84b9a713c41-goog

