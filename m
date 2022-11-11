Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882A6624EC8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 01:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbiKKASr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 19:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKKASo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 19:18:44 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01C2D2ED
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 16:18:43 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id x14-20020a17090a2b0e00b002134b1401ddso1878582pjc.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 16:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F2sF9sKVeJ8Hy0mPBnq+5X2UG8c6CtO5Y5aaiJ32Ab8=;
        b=iWxHPBQdfxc7Ady8snj2Fq6LrD5knjzXVP9qN7cdFukXzp+TGCInUVYKCRov6aD1eP
         5w6yk66ck4sYfoBBc2ZQnHzt91eK9cx+GTwF1rW9bm/wNH7PLUa4QopuRcM4Z2p7hEbl
         w251avWXQQjSa3PzKYbR+hYhv0jvJ2QAnlmSxmxlGBLHa6YX/6Eu/6HsHABO3T76ZeKu
         2+aEIgFn7omVh9I3ZABEe4WzKkPQCuGCboUwfvuAKqNySiHga9xq8UzSiWUcTYJfQbrQ
         o35wEbJs43B8cQPeQyIhhn8eHuhKc1L/N6/zdXizA1IOR4IrnIEBevjGt1aKIvfetJjK
         GNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F2sF9sKVeJ8Hy0mPBnq+5X2UG8c6CtO5Y5aaiJ32Ab8=;
        b=Rdo5sIZwAES9EZp81fXboJO2EitZxVGP8UO2uZusNrpf7ZKPu+hxXAJVUP4PMrkYt9
         gDsoDjRgtk0OGsXq/1KYlVu/lnOBm17hOqQpF95Yi4UYPs3rQo402HkQshzP8ZqveZBI
         nkMS4I5DRSrT3O/kdoic6ndoSwYM8pK4oNKEF3Ir3Jr7TcyS9jWWbWLLuSK03fp+wZvf
         hH4+Br9vScTyT5YvpPfNAe8pUXDbL2Tbleue3D6aH4AapAB814i+d02XdvyELfQikwwo
         pj9VBXbrz+Y3v4K1LG97YJSaYPsgZAvAAvAHbLPAMhfECco8ywujRYBeB3VcOaJFTWfz
         tiYw==
X-Gm-Message-State: ACrzQf3X5Rb4QCUZm1wN6wlQJIOgGEkxKniBhv58pkWz8e/J1rhNNoTN
        bE2e4Yhinsppop/xPTd3QJnzS97wDWs=
X-Google-Smtp-Source: AMsMyM7BrHlBgWbShhkyyoU74kyn4h0d1z1NeCWQQMYL5oUkL7jcUxM2j3EIwwrfwHiToC/Bz7eptbOXnlU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e194:b0:17e:587:6bb6 with SMTP id
 y20-20020a170902e19400b0017e05876bb6mr2768221pla.114.1668125923558; Thu, 10
 Nov 2022 16:18:43 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Nov 2022 00:18:41 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221111001841.2412598-1-seanjc@google.com>
Subject: [PATCH] KVM: x86/mmu: Block all page faults during kvm_zap_gfn_range()
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
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

When zapping a GFN range, pass 0 => ALL_ONES for the to-be-invalidated
range to effectively block all page faults while the zap is in-progress.
The invalidation helpers take a host virtual address, whereas zapping a
GFN obviously provides a guest physical address and with the wrong unit
of measurement (frame vs. byte).

Alternatively, KVM could walk all memslots to get the associated HVAs,
but thanks to SMM, that would require multiple lookups.  And practically
speaking, kvm_zap_gfn_range() usage is quite rare and not a hot path,
e.g. MTRR and CR0.CD are almost guaranteed to be done only on vCPU0
during boot, and APICv inhibits are similarly infrequent operations.

Fixes: edb298c663fc ("KVM: x86/mmu: bump mmu notifier count in kvm_zap_gfn_range")
Reported-by: Chao Peng <chao.p.peng@linux.intel.com>
Cc: stable@vger.kernel.org
Cc: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 93c389eaf471..f14efcaebec3 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6098,7 +6098,7 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
 
 	write_lock(&kvm->mmu_lock);
 
-	kvm_mmu_invalidate_begin(kvm, gfn_start, gfn_end);
+	kvm_mmu_invalidate_begin(kvm, 0, -1ul);
 
 	flush = kvm_rmap_zap_gfn_range(kvm, gfn_start, gfn_end);
 
@@ -6112,7 +6112,7 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
 		kvm_flush_remote_tlbs_with_address(kvm, gfn_start,
 						   gfn_end - gfn_start);
 
-	kvm_mmu_invalidate_end(kvm, gfn_start, gfn_end);
+	kvm_mmu_invalidate_end(kvm, 0, -1ul);
 
 	write_unlock(&kvm->mmu_lock);
 }

base-commit: d663b8a285986072428a6a145e5994bc275df994
-- 
2.38.1.431.g37b22c650d-goog

