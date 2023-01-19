Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A506740CB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 19:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjASSWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 13:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjASSWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 13:22:04 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B3B90B18
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:22:03 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id pa16-20020a17090b265000b0020a71040b4cso1413740pjb.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b40fwcC6nngRFLft6op27vX6xZWPu1WE1VJnXnClKPs=;
        b=lPgJ+psvO0gs4F1pC7Vb9jyNcokvbED/nE4sfWUC7tB5g/4OxeLVT56AIJY01cJgOa
         EsCnN99LLBE77rh51iBGQNmTyTMhzT9Q9FXaxFpsnDNXG6uBzHfYFnmn0L71YgUiJXoc
         c+zkoS9FEo1pdbW3YSuO1zXz2IfLOGyzmNyxUAAuJ+K5nq5LxCtwyPkA8enNIr2OCPsk
         UryVt6qYaPlTl4yVAGsh+H/ZyE5tYIy6BXXfV0oOTJEdOlMUAx2yMGvvB/wSYcPdSP6L
         StepHpLKdkdeMUQWM3xGseB1/PNRmD7Zv9Ga/E8KfpFdmBQp60J+aUm2uoMumiPLQQdB
         zXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b40fwcC6nngRFLft6op27vX6xZWPu1WE1VJnXnClKPs=;
        b=68Ei/4bBqZk2ktp9FDPD2JV/fn2XVjcs023XpztwWuIubIpRKYdB3cM2kaBQ9OOo6E
         o7AsDl/OK6MzsU7k4FTYhCct3LW07oLM5L9nhqjV5eNI/RRXavC8nMaAn4bze4J39k46
         Z2jeGh76i6XHPIiySKLU9qWqIpVKdlarfVnaFueSW/k0cRqs42SlN1eAx+ePrcAK4tW5
         EK4H5DpiP20gbem8C2ej/vCEJaWGZa/VsJQFfzeu/jjsjmSB9XOMJoFfd8RIwSOsq5TN
         2D4InLRQBOLW5L2GuXzid5mSix48nNre9z8sCDkzpKz+GSduzsT6bfcnpIEf05t+cw2M
         BQeA==
X-Gm-Message-State: AFqh2krtE4TDawwArW/FxgqpWByClpgQJxyc5oBbiYhL0wU6XGD6cGhk
        apm9kUKm/XHN7CPKx6J3c+Dudn36PXw=
X-Google-Smtp-Source: AMrXdXv67WP/W+jw1oSkl8gqR+hmC3zu77fxSLGsZHoNLNooy8UzOTuEE+n7IIlf/ADQ9g1YvqSVz1is9Zw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a62:4e87:0:b0:58d:8d29:399c with SMTP id
 c129-20020a624e87000000b0058d8d29399cmr1071733pfb.44.1674152522508; Thu, 19
 Jan 2023 10:22:02 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 19 Jan 2023 18:21:58 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230119182158.4026656-1-seanjc@google.com>
Subject: [PATCH] KVM: PPC: Fix refactoring goof in kvmppc_e500mc_init()
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sean Christopherson <seanjc@google.com>
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

Fix a build error due to a mixup during a recent refactoring.  The error
was reported during code review, but the fixed up patch didn't make it
into the final commit.

Fixes: 474856bad921 ("KVM: PPC: Move processor compatibility check to module init")
Link: https://lore.kernel.org/all/87cz93snqc.fsf@mpe.ellerman.id.au
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/powerpc/kvm/booke.c  | 2 +-
 arch/powerpc/kvm/e500mc.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 7b4920e9fd26..a647bfc322b8 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1208,7 +1208,7 @@ int kvmppc_handle_exit(struct kvm_vcpu *vcpu, unsigned int exit_nr)
 
 /*
  * On cores with Vector category, KVM is loaded only if CONFIG_ALTIVEC,
- * see kvmppc_core_check_processor_compat().
+ * see kvmppc_e500mc_check_processor_compat().
  */
 #ifdef CONFIG_ALTIVEC
 	case BOOKE_INTERRUPT_ALTIVEC_UNAVAIL:
diff --git a/arch/powerpc/kvm/e500mc.c b/arch/powerpc/kvm/e500mc.c
index 611532a0dedc..a309138927ff 100644
--- a/arch/powerpc/kvm/e500mc.c
+++ b/arch/powerpc/kvm/e500mc.c
@@ -168,7 +168,7 @@ static void kvmppc_core_vcpu_put_e500mc(struct kvm_vcpu *vcpu)
 	kvmppc_booke_vcpu_put(vcpu);
 }
 
-int kvmppc_core_check_processor_compat(void)
+int kvmppc_e500mc_check_processor_compat(void)
 {
 	int r;
 
@@ -390,7 +390,7 @@ static int __init kvmppc_e500mc_init(void)
 
 	r = kvmppc_e500mc_check_processor_compat();
 	if (r)
-		return kvmppc_e500mc;
+		goto err_out;
 
 	r = kvmppc_booke_init();
 	if (r)

base-commit: 91dc252b0dbb6879e4067f614df1e397fec532a1
-- 
2.39.0.246.g2a6d74b583-goog

