Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E956AD1EB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 23:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjCFWnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 17:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjCFWm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:42:56 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377B17C9E3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 14:42:24 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id s15-20020a170902ea0f00b0019d0c7a83dfso6628243plg.14
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 14:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678142526;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OeL8Ykd+iCS6JS8scOAtZXT6SgE3Ouj+/URgOQ2sX3s=;
        b=hk8vRpbEWBqSY4vpUw9bpWUeCVvQ/YeUcq66u5udQO+XKtmkRe5XynuiaC71UhBsmb
         MJX5G46cSivSg2VyHO2BLfr3zi+MPvsQQPrlUg0fklhseJRi492oFo6Omn0JeoMCiIDA
         ehcsBIttFvLE0M6Z0VE3ZVD8e2ATxMcgmx5gk5b88p/1DDvplGFnZ99N1VQ7grjJ2hX1
         m4Rs2BUrBU3Yjazwt4qvtCMRJMwPuvSnaYwonWVuEmnwDyA2W/r/85gkfWZjutvxQf7J
         yo2LwCs1SLZHtKalYgNMvcaZgVakuyiUlG+IUprqGugBQTirUZbsBqM8O4BeJRmWkQO4
         hLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678142526;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OeL8Ykd+iCS6JS8scOAtZXT6SgE3Ouj+/URgOQ2sX3s=;
        b=Pa106kt+KaH/ZjiqjsDWRMcLhSdmw/b7XSM4lV8HiEOzJx0gwpa7Fh+OqEbn8URpEu
         bK8x6Ve2VFPH16a2lOVtGlvrm/nme1dtkjZrjwcg6oE8xNMfofUPIsmOQtQgN+vQDPMF
         WRs727nJ2wkrs8Qa3DbXniAosN19ODLO1/5iMK+4hoZ0dLBl8XHvYKSPwT2mC3ZjGZbj
         RC5LOL3pO+v0yNy4XM46jE2txsZdou5OWahHTkSkEynJZ+xe5zbEPmxsLUI2881j2EkA
         3ooZyDguEabwLHNxtfl2oKJsNktIk4HaYgfSAdrgzf/YygbcxypdQgH35c9UBnxpAX5S
         623g==
X-Gm-Message-State: AO0yUKXlv2jdpACDmxalxerY8d0mRmtb1Jjc2tbgD4SuB3QuvdARnEge
        5wsG9Ah3Zwz1jANwbo3bIDnPlGHurJGa
X-Google-Smtp-Source: AK7set/bN7t34vpFP3b5g8As+ZIP6EwS/0kB74bTqu6kV7sDF35fTifkklq2UmD/u6GAqDmSpVbet0qAjEWc
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a17:90b:504:b0:233:df5f:4778 with SMTP id
 r4-20020a17090b050400b00233df5f4778mr4600717pjz.6.1678142526350; Mon, 06 Mar
 2023 14:42:06 -0800 (PST)
Date:   Mon,  6 Mar 2023 14:41:27 -0800
In-Reply-To: <20230306224127.1689967-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20230306224127.1689967-1-vipinsh@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230306224127.1689967-19-vipinsh@google.com>
Subject: [Patch v4 18/18] KVM: x86/mmu: Reduce default mmu memory cache size
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

Reduce KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE to PT64_ROOT_MAX_LEVEL - 1.
Opportunistically, use this reduced value for topping up caches.

There was no specific reason to set this value to 40. With addition of
multi NUMA node caches, it is good to save space and make these cachees
lean.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 arch/x86/include/asm/kvm_types.h | 6 +++++-
 arch/x86/kvm/mmu/mmu.c           | 8 ++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/kvm_types.h b/arch/x86/include/asm/kvm_types.h
index 08f1b57d3b62..80aff231b708 100644
--- a/arch/x86/include/asm/kvm_types.h
+++ b/arch/x86/include/asm/kvm_types.h
@@ -2,6 +2,10 @@
 #ifndef _ASM_X86_KVM_TYPES_H
 #define _ASM_X86_KVM_TYPES_H
 
-#define KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE 40
+/*
+ * For each fault only PT64_ROOT_MAX_LEVEL - 1 pages are needed. Root
+ * page is allocated in a separate flow.
+ */
+#define KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE (PT64_ROOT_MAX_LEVEL - 1)
 
 #endif /* _ASM_X86_KVM_TYPES_H */
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 6d44a4e08328..5463ce6e52fa 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -713,11 +713,11 @@ static int mmu_topup_memory_caches(struct kvm_vcpu *vcpu, bool maybe_indirect)
 	if (kvm_numa_aware_page_table_enabled(vcpu->kvm)) {
 		for_each_online_node(nid) {
 			r = mmu_topup_sp_memory_cache(&vcpu->arch.mmu_shadow_page_cache[nid],
-						      PT64_ROOT_MAX_LEVEL);
+						      KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE);
 		}
 	} else {
 		r = mmu_topup_sp_memory_cache(&vcpu->arch.mmu_shadow_page_cache[nid],
-					      PT64_ROOT_MAX_LEVEL);
+					      KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE);
 	}
 
 	if (r)
@@ -725,12 +725,12 @@ static int mmu_topup_memory_caches(struct kvm_vcpu *vcpu, bool maybe_indirect)
 
 	if (maybe_indirect) {
 		r = mmu_topup_sp_memory_cache(&vcpu->arch.mmu_shadowed_info_cache,
-					      PT64_ROOT_MAX_LEVEL);
+					      KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE);
 		if (r)
 			return r;
 	}
 	return kvm_mmu_topup_memory_cache(&vcpu->arch.mmu_page_header_cache,
-					  PT64_ROOT_MAX_LEVEL);
+					  KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE);
 }
 
 static void mmu_free_memory_caches(struct kvm_vcpu *vcpu)
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

