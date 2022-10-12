Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29785FCA72
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 20:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiJLSS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 14:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiJLSRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 14:17:39 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05240FE92B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 11:17:27 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id h11-20020a170902f54b00b001780f0f7ea7so12189008plf.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 11:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=JdxEzOf9q3jZxRIV3R0387viDqqF4uKKm+TfA/ON3Oc=;
        b=mjDpSoePv7poy+PxVm7eiwY47bJwFz/gpt0nUUv0PO3BzPC/Ttl5kJNv/EhwE5Br5+
         bUMnLKeE3xFl6B7J99VsEUlfYUgeZWSmS2rlVTiGepzXgRNWLhF9uimu9rChtT9FEumR
         3ALWn4Qa6kpNgLaSsK0ryJOF2xk0gxWiZ28fX+CwlhTyTWr7fBrI4ltb+fCBAo24SHXZ
         hRrGqpTktRlB7L9lkNDoFLp0U5Ay41OcozgoxbnB6yMaR71c3HIOQmbvwzVvx6WzU85U
         Gni28BZphgiauWAj3isz0DK3rKUVLchYmMcdMej9pt35495AhP7HxjdtpmyNyFDN2JQe
         wJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JdxEzOf9q3jZxRIV3R0387viDqqF4uKKm+TfA/ON3Oc=;
        b=jzSdJNC+hoMKdItyH7uOQmk8O/m+QkePe8oTLMkXERJ13gRK2xGO0wBxK/qr9XCrlD
         kTH1Pv6XlsRURhTLCctmfDHANZQZT7uN/s7eyRbNdVer4gueaWTBbo0nwHt4thP7lIfY
         SeoB3WpFipvwEv5CDxctD5QdA2oR/qTaMcci94EP8goiH6Zx5uCYLpl+CZKk2wJNCc8y
         nTzojr/1LafZakVEo0Hg4A6O12M9gF+sq7ENjw4MrbvjTTlDpSHVfeGXkm76vTg5tcH8
         yv7xJe51nUscwhqQL650pMDzeva4vJfxlZoDiI5Fl9sX21q6W24lCuU7mAXQA3qUgjrz
         TGgw==
X-Gm-Message-State: ACrzQf2TAx1AdL2hix+J59ukUK0CuVakBBZci3aAZrSzjd17dj5Zs9CG
        +06r63xEqrrmusk31U42tGx3UuaBDgk=
X-Google-Smtp-Source: AMsMyM5/uWnwIatGAE/VXqmY8wTRmoVUxQ1aOTxsVOaXPyrDvX9WcpjiI+C70U/g26pFUrSK8I2l6Dbui38=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:9f97:b0:183:ee9e:59ef with SMTP id
 g23-20020a1709029f9700b00183ee9e59efmr8652275plq.38.1665598646155; Wed, 12
 Oct 2022 11:17:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 12 Oct 2022 18:17:02 +0000
In-Reply-To: <20221012181702.3663607-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221012181702.3663607-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221012181702.3663607-12-seanjc@google.com>
Subject: [PATCH v4 11/11] KVM: x86/mmu: Stop needlessly making MMU pages
 available for TDP MMU
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Matlack <dmatlack@google.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>
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

From: David Matlack <dmatlack@google.com>

Stop calling make_mmu_pages_available() when handling TDP MMU faults and
when allocating TDP MMU roots.  The TDP MMU does not participate in the
"available MMU pages" tracking and limiting so calling this function is
unnecessary work when handling TDP MMU faults.

Signed-off-by: David Matlack <dmatlack@google.com>
[sean: apply to root allocation too]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index a5ba7b41263d..0fcf4560f4d8 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3569,9 +3569,12 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 	int r;
 
 	write_lock(&vcpu->kvm->mmu_lock);
-	r = make_mmu_pages_available(vcpu);
-	if (r < 0)
-		goto out_unlock;
+
+	if (!is_tdp_mmu_enabled()) {
+		r = make_mmu_pages_available(vcpu);
+		if (r < 0)
+			goto out_unlock;
+	}
 
 	if (is_tdp_mmu_enabled()) {
 		root = kvm_tdp_mmu_get_vcpu_root_hpa(vcpu);
@@ -4289,14 +4292,15 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	if (is_page_fault_stale(vcpu, fault))
 		goto out_unlock;
 
-	r = make_mmu_pages_available(vcpu);
-	if (r)
-		goto out_unlock;
-
-	if (is_tdp_mmu_enabled())
+	if (is_tdp_mmu_enabled()) {
 		r = kvm_tdp_mmu_map(vcpu, fault);
-	else
+	} else {
+		r = make_mmu_pages_available(vcpu);
+		if (r)
+			goto out_unlock;
+
 		r = __direct_map(vcpu, fault);
+	}
 
 out_unlock:
 	if (is_tdp_mmu_enabled())
-- 
2.38.0.rc1.362.ged0d419d3c-goog

