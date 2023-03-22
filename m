Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3D06C4DD0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjCVOdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjCVOdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:33:35 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303651E5E8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:33:06 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id b1-20020a17090a8c8100b002400db03706so376866pjo.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679495585;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=KHddjm9SvmO326/A0Q7jULC0QAh5K2TYnQIugXYVvT8=;
        b=No31MRJt5QhKgYPLLBEr35zF5an//OlzoWQKh4HjGAEjmmTvKuMSC8hmZO7gm33iXI
         3pC58nrLgUtZdQGy/xrhYwrkA9OAt31qAhDKlEv4rqg9n6p7kwoDBuVO2pX6xyFgV8XR
         xvl3IoH7H2/i3YIsUq189uPfmzXC+eaaNgHuJIQAQ32QAFUUb9uQ5Mpu90XxQxGshhOn
         bl4aBMN9POFzjbhHHwoFWYhOF7dzCF6nRML3HNLEWHq/p/Fcph7t6Ff+HJr/7aDvvxwS
         Aw3thoKPZYSDZSI06mf0CKQ8kG0yiBZ3z47QvT9VVwtpixAzJ+VJ9fzrEr7K3uRmJfV1
         TcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679495585;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KHddjm9SvmO326/A0Q7jULC0QAh5K2TYnQIugXYVvT8=;
        b=x37lYLA2H3M3eM8g+W5gcSG3B6tiZktanv2enbd3n+2zrTZ6n5yktsel1rT+CF3dd4
         q7vrHq8Mt2V0XPmBpb2Yj+FMq58lyIAs9wgfRhAKHAuwruehlU8Yky2g1GRavtqxUH5M
         ROUu1mdWkYv0bv/K1SlsRV9pKofkupl6qzRBlbGKH5XpG6Xp38NvJ4Qcm1wSZFpVVhxq
         shGh1zNTCbFRAPW89PwV8wEcWf4tsTIv1DO7IkKntsiuHYU9AO9oMAZxiI3iE0o3RCM8
         C3eRCV7pN/dMLbCysfGCnl5y7QtjGklPvFp5A2IKE235iCTHzjC22xaDMEMIvHVgef6N
         4yRQ==
X-Gm-Message-State: AAQBX9c5sWer4AEB/jromaaaY5jMkvHp1o5HsE9ej3pPkn9ArBf4mBZt
        ObZK/tOHhJOJaQ0XFYMKNLaWaZ/KWU4=
X-Google-Smtp-Source: AKy350alMo6+Lkih/Ywrb2SG5XRKmM/2FcrkJhJGC/vIR6CCpVkrNxeblRuG0AxzJWq1COwntZ/VJ0Qp8Tk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:1f49:b0:236:a1f9:9a9d with SMTP id
 y9-20020a17090a1f4900b00236a1f99a9dmr970610pjy.2.1679495585023; Wed, 22 Mar
 2023 07:33:05 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 22 Mar 2023 07:32:59 -0700
In-Reply-To: <20230322143300.2209476-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230322143300.2209476-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <20230322143300.2209476-2-seanjc@google.com>
Subject: [PATCH 1/2] KVM: x86: Clear "has_error_code", not "error_code", for
 RM exception injection
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When injecting an exception into a vCPU in Real Mode, suppress the error
code by clearing the flag that tracks whether the error code is valid, not
by clearing the error code itself.  The "typo" was introduced by recent
fix for SVM's funky Paged Real Mode.

Opportunistically hoist the logic above the tracepoint so that the trace
is coherent with respect to what is actually injected (this was also the
behavior prior to the buggy commit).

Fixes: b97f07458373 ("KVM: x86: determine if an exception has an error code only when injecting it.")
Cc: stable@vger.kernel.org
Cc: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f706621c35b8..e74aaf57eab5 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9884,13 +9884,20 @@ int kvm_check_nested_events(struct kvm_vcpu *vcpu)
 
 static void kvm_inject_exception(struct kvm_vcpu *vcpu)
 {
+	/*
+	 * Suppress the error code if the vCPU is in Real Mode, as Real Mode
+	 * exceptions don't report error codes.  The presence of an error code
+	 * is carried with the exception and only stripped when the exception
+	 * is injected as intercepted #PF VM-Exits for AMD's Paged Real Mode do
+	 * report an error code despite the CPU being in Real Mode.
+	 */
+	vcpu->arch.exception.has_error_code &= is_protmode(vcpu);
+
 	trace_kvm_inj_exception(vcpu->arch.exception.vector,
 				vcpu->arch.exception.has_error_code,
 				vcpu->arch.exception.error_code,
 				vcpu->arch.exception.injected);
 
-	if (vcpu->arch.exception.error_code && !is_protmode(vcpu))
-		vcpu->arch.exception.error_code = false;
 	static_call(kvm_x86_inject_exception)(vcpu);
 }
 
-- 
2.40.0.rc2.332.ga46443480c-goog

