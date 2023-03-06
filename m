Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8829C6AD1D6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 23:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjCFWmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 17:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjCFWlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:41:47 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD3B7430C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 14:41:43 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id cl18-20020a17090af69200b0023470d96ae6so127343pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 14:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678142503;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ntsWJChvbXfy8t9EA+eQUOa7LNpcvZXYoCa+kOc7Xxo=;
        b=QE3wGxcpDkwXukGXapdK3z5AcvymfM9fTDSInE4aMcqqqhApqI13rGs3g8WKQUaPS/
         zZ6kNb4R7uz/pdmbRfaqJcYVYuRq+bQgvKsN86OU0tlFIWLibxnJpuqg0yKTzMCyuR1X
         pL28Sm386yDPzPua4c49qPfANPTKuZn9aWIUurbKMbZucDPpluT8Syfvw708TGu5WMO0
         hjDTHUxu7yWc5s4/oRuSPQU74v9qCJL0SWCVXIoKKH6qhy3+hgUFKF39UdJnzPCFwNtA
         PsAmluDoVGVvbeYF4h5LW3dAFwVLGK0yDNSdG3miH//Ijl6QzEc9pgGGk9eEMrDtuikC
         CFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678142503;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ntsWJChvbXfy8t9EA+eQUOa7LNpcvZXYoCa+kOc7Xxo=;
        b=l2jsHc6NQk6UuCnfsVi6I6SMMWzQ4ePzF/94et/4PQ7xzoXnVoJrb4Y1uV1QEte514
         nRA/LYVeBF2f/VGkffi5vu/NwsmYsbH1/QvOnbBNojdHpRsUUDRZBX7qoRI2OYvDdxhm
         XoLg8/iXdCIsoe6coYANrZjEAwkPgPesM4zOxjZ3Pp6pMlgkSMhpomcC61zSDQuXhxUw
         /YuWzurcCvMTVH/j4Z/lz0xlP619A0fymciEWWs+AzSZa+j36m6jLfJpf19mL0wTx9X8
         tN9C7Aqjb2iCJzgqwBgxMSXxqrD1bGl/15Cz3ScfrdJl896r8Nq1DOg1ngHmN4p7Mmsn
         zlfg==
X-Gm-Message-State: AO0yUKWEgzJm28cby3KOrQI/o/cVOC7kqWD9aFmxb3VaDVoqAUj2UoLM
        fPt1UkvrkpwUirRCz/diquVXBFi5Vot1
X-Google-Smtp-Source: AK7set+ZI2aBqjIrxBqymLM25KRuDPXvrPAuiXEE5P98Cs7Ib72ELWHQ9A1FvjqxxCOH6L09ow62WHf25Ci6
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a63:7e11:0:b0:503:913f:77b9 with SMTP id
 z17-20020a637e11000000b00503913f77b9mr4352737pgc.6.1678142503145; Mon, 06 Mar
 2023 14:41:43 -0800 (PST)
Date:   Mon,  6 Mar 2023 14:41:14 -0800
In-Reply-To: <20230306224127.1689967-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20230306224127.1689967-1-vipinsh@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230306224127.1689967-6-vipinsh@google.com>
Subject: [Patch v4 05/18] KVM: x86/mmu: Add split_shadow_page_cache pages to
 global count of MMU cache pages
From:   Vipin Sharma <vipinsh@google.com>
To:     seanjc@google.com, pbonzini@redhat.com, bgardon@google.com,
        dmatlack@google.com
Cc:     jmattson@google.com, mizhang@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vipin Sharma <vipinsh@google.com>
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

Add pages in split_shadow_page_cache to the global counter
kvm_total_unused_cached_pages. These pages will be freed by MMU shrinker
in future commit.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index df8dcb7e5de7..0ebb8a2eaf47 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6149,7 +6149,9 @@ static void mmu_free_vm_memory_caches(struct kvm *kvm)
 {
 	kvm_mmu_free_memory_cache(&kvm->arch.split_desc_cache);
 	kvm_mmu_free_memory_cache(&kvm->arch.split_page_header_cache);
-	kvm_mmu_free_memory_cache(&kvm->arch.split_shadow_page_cache);
+	mutex_lock(&kvm->slots_lock);
+	mmu_free_sp_memory_cache(&kvm->arch.split_shadow_page_cache);
+	mutex_unlock(&kvm->slots_lock);
 }
 
 void kvm_mmu_uninit_vm(struct kvm *kvm)
@@ -6303,7 +6305,7 @@ static int topup_split_caches(struct kvm *kvm)
 	if (r)
 		return r;
 
-	return kvm_mmu_topup_memory_cache(&kvm->arch.split_shadow_page_cache, 1);
+	return mmu_topup_sp_memory_cache(&kvm->arch.split_shadow_page_cache, 1);
 }
 
 static struct kvm_mmu_page *shadow_mmu_get_sp_for_split(struct kvm *kvm, u64 *huge_sptep)
@@ -6328,6 +6330,7 @@ static struct kvm_mmu_page *shadow_mmu_get_sp_for_split(struct kvm *kvm, u64 *hu
 	/* Direct SPs do not require a shadowed_info_cache. */
 	caches.page_header_cache = &kvm->arch.split_page_header_cache;
 	caches.shadow_page_cache = &kvm->arch.split_shadow_page_cache;
+	caches.count_shadow_page_allocation = true;
 
 	/* Safe to pass NULL for vCPU since requesting a direct SP. */
 	return __kvm_mmu_get_shadow_page(kvm, NULL, &caches, gfn, role);
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

