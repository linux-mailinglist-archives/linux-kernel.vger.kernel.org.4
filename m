Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD4B6075F8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 13:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiJULTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 07:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiJULTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 07:19:48 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162D45465C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 04:19:45 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id n19-20020a7bcbd3000000b003c4a72334e7so392320wmi.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 04:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SXYluVV8OuIAwAz2C5hZDcy+5LCar7ehD1UteGXJBs8=;
        b=kim3VsBd3Mx6kXN5MZ0Ng49VioTgo+y3AZTz7ij9qxtBoaIzk/6g3mLS1A68Q8XgkL
         jOE7qGLcpTpJMcOZ2aNLBeKyaNAVu+dnpElZlhZ2Xu1ezlo1dFmTIFKDgxHVAchuRbeM
         b63d1+G2+sJkM0uHUViYFdAHwSjmPccsCQYn1gA8UnVKMeXltesQUjnARpulcM1VTWmB
         p6sSKLj0IT34yWQMoZOrcH75jX5p7SYTHyE01GuJlpbZuAG0T1Qsz8MpC7Wmbgn4FQxG
         bEX+HWfYlHOaQVW2HAseq5vJepcVAGv9rpcs+WFN7I2ZqcbSFUMxVEYmPUhubHtg2AZz
         cPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SXYluVV8OuIAwAz2C5hZDcy+5LCar7ehD1UteGXJBs8=;
        b=EkU1hG6qId/Rgv9OfecN+CMnJRQKJEJ3HHsJz41yqh9kFFybo1SLiUavJ/PGpAIKmm
         yv44AGds8WlIC4YnJXkT52EI0fQVpsTmKtQyWXDC1Fm7X5Rz+XScLl9Q+gRQ8T6n6Ymp
         Ck7kyuAdnafFBeyc/LpQ4rIju+AnN8EopIaN8KnXyXW+d89/w9s5G7jmFerknFsUUVOr
         Wycvy24QcKWwa9N3zDNMCmuQgBstJb86CDFAsq2G7LeYthbTVI+oh3iy7bSu/jVBxcje
         fP8GDQywvlfuYq+EazrIxuj7SclZLkqJ5MrcXIfr75y2RKyTNo3xupDoGeWx00grDvdP
         na0A==
X-Gm-Message-State: ACrzQf25Y4e5dWeCyfQXTSRdckmebWBSAays6RF/Te3EY9+M/hlcnVV1
        c4vH3CCAMhDFmZoXawQfU+zKj2pjQw==
X-Google-Smtp-Source: AMsMyM7mHv4M340Lzsj3zpqptebDb1AbCqxpdeVExIntWKeVZN02GapqRdAMvyImVFU0MK/m1vIWhD+//w==
X-Received: from fuad.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1613])
 (user=tabba job=sendgmr) by 2002:a05:600c:1c97:b0:3c6:bf60:112c with SMTP id
 k23-20020a05600c1c9700b003c6bf60112cmr12657102wms.20.1666351174342; Fri, 21
 Oct 2022 04:19:34 -0700 (PDT)
Date:   Fri, 21 Oct 2022 12:19:32 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021111932.3291560-1-tabba@google.com>
Subject: [PATCH] KVM: x86/mmu: Release the pfn in handle_abnormal_pfn() error path
From:   Fuad Tabba <tabba@google.com>
To:     kvm@vger.kernel.org
Cc:     seanjc@google.com, pbonzini@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, will@kernel.org, tabba@google.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
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

Currently in case of error it returns without releasing the pfn
faulted in earlier.

Signed-off-by: Fuad Tabba <tabba@google.com>
---

Applies to 6.1-rc1. I think that kvm_release_pfn_clean() has been
replaced with kvm_mmu_release_fault() in development branches,
but the same issue is still there.
---
 arch/x86/kvm/mmu/mmu.c         | 3 ++-
 arch/x86/kvm/mmu/paging_tmpl.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 6f81539061d6..9adae837ccdd 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4250,7 +4250,7 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 
 	r = handle_abnormal_pfn(vcpu, fault, ACC_ALL);
 	if (r != RET_PF_CONTINUE)
-		return r;
+		goto out_release;
 
 	r = RET_PF_RETRY;
 
@@ -4276,6 +4276,7 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 		read_unlock(&vcpu->kvm->mmu_lock);
 	else
 		write_unlock(&vcpu->kvm->mmu_lock);
+out_release:
 	kvm_release_pfn_clean(fault->pfn);
 	return r;
 }
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 5ab5f94dcb6f..4a1e4e460990 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -847,7 +847,7 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 
 	r = handle_abnormal_pfn(vcpu, fault, walker.pte_access);
 	if (r != RET_PF_CONTINUE)
-		return r;
+		goto out_release;
 
 	/*
 	 * Do not change pte_access if the pfn is a mmio page, otherwise
@@ -881,6 +881,7 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 
 out_unlock:
 	write_unlock(&vcpu->kvm->mmu_lock);
+out_release:
 	kvm_release_pfn_clean(fault->pfn);
 	return r;
 }

base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
-- 
2.38.0.135.g90850a2211-goog

