Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A46871F7AF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 03:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbjFBBTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 21:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbjFBBT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 21:19:28 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7121138
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 18:19:27 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-53feeb13975so687672a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 18:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685668767; x=1688260767;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=+pKuNGyydAX4a3/pRiWzlYTFJ55l4Lts1hOT1bxh70Q=;
        b=HuEEKcFTGWsLhgAq0uhw1LFlEWjSIHS//Cctgv5rRa4ZofTh/wptGYGJeUmoHYjLB2
         xXLs1Z/XvL8KkU294OqIMI6O4P42EGxJjKQu6tCyzO3A+btITECikf+j+Vwfn/d3gImJ
         rdkPRZyClxsCI7uYBvgilahYNwU0X79M2XdjTCmGFL1EM2n84bAlr9c8sU925Giuoa1N
         hDVd3NCAsQTbtpMxrUtD5jctX2rqYE9S5XKsAWqWYsZbNI9EPO9vVsQCG1ObontUDaBy
         /npPqT+zGybKuj9Nae0msQh1F2s13ilxo1XcmjWBCTkcyHiGiMVsP6MZSmWY8ho6SUfA
         2Z+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685668767; x=1688260767;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+pKuNGyydAX4a3/pRiWzlYTFJ55l4Lts1hOT1bxh70Q=;
        b=DwTsnBSN/WUAnTQRVSPuK437Ayh8wIDF1I+YYbO/IIxW1htAOZj2sGeeiUII+IU+mA
         RfLh4jz521f1jkmVJaVCRMceGE9A7RjAXTGU1VQSXN6W2peugqJeSREpKxjfGkEg0Fql
         eNsiosGdboE7D/zb6v3Dg6R7XXkR4y/g2LEyYhdTLUrfcerFNwh091SsjYTxeEVgKlFw
         EnmryjDTznd6bn+8zZ+uCyZkEruyTWSZe0DeNX9XSRgWFpzNx9Bxg9V0OgPfhmLA8KAe
         dSJpidMV3gkL/VMzoKF1UJr5isPzgT6ssE69hK5NuUkj3WOFk9OBb2G+SMr7SkZa0rIo
         SEfA==
X-Gm-Message-State: AC+VfDxRIHxqJRgwKNOuOe0ypZoAteoOsGC4AK01hppkWot7yd6GJtC+
        LbHtrmoMGdfeNsI2JliRf3SIQdpLYWg=
X-Google-Smtp-Source: ACHHUZ5qFvorJUM/c/ZgvYGXlJeig6a3Tn2AOe3ErM7QWAfYoEUgk2myRBtD4kk5tuY6QKc8/ICuL5Flf8Y=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:6850:0:b0:534:7596:7791 with SMTP id
 q16-20020a656850000000b0053475967791mr2047702pgt.1.1685668767101; Thu, 01 Jun
 2023 18:19:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  1 Jun 2023 18:19:20 -0700
In-Reply-To: <20230602011920.787844-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230602011920.787844-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
Message-ID: <20230602011920.787844-3-seanjc@google.com>
Subject: [PATCH 2/2] KVM: SVM: Invoke trace_kvm_exit() for fastpath VM-Exits
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
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

Move SVM's call to trace_kvm_exit() from the "slow" VM-Exit handler to
svm_vcpu_run() so that KVM traces fastpath VM-Exits that re-enter the
guest without bouncing through the slow path.  This bug is benign in the
current code base as KVM doesn't currently support any such exits on SVM.

Fixes: a9ab13ff6e84 ("KVM: X86: Improve latency for single target IPI fastpath")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index ca32389f3c36..6845f4f2dc33 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3418,8 +3418,6 @@ static int svm_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 	struct kvm_run *kvm_run = vcpu->run;
 	u32 exit_code = svm->vmcb->control.exit_code;
 
-	trace_kvm_exit(vcpu, KVM_ISA_SVM);
-
 	/* SEV-ES guests must use the CR write traps to track CR registers. */
 	if (!sev_es_guest(vcpu->kvm)) {
 		if (!svm_is_intercept(svm, INTERCEPT_CR0_WRITE))
@@ -4156,6 +4154,8 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu)
 		     SVM_EXIT_EXCP_BASE + MC_VECTOR))
 		svm_handle_mce(vcpu);
 
+	trace_kvm_exit(vcpu, KVM_ISA_SVM);
+
 	svm_complete_interrupts(vcpu);
 
 	if (is_guest_mode(vcpu))
-- 
2.41.0.rc2.161.g9c6817b8e7-goog

