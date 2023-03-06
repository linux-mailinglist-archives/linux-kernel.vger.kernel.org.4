Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740966AD1DB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 23:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjCFWmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 17:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjCFWl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:41:59 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E268178C83
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 14:41:48 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id q9-20020a17090a9f4900b00237d026fc55so7076833pjv.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 14:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678142508;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J8x91/t3dwIfLtqbgCFfhhKLJcllwDKNOmC2E+E2xTE=;
        b=DYLWpU7tZGbEMTBqF+pAbMWErmZ3leTSXhkNG3iAzMHf9CwPyOH2PG3+hRNKU4dSKk
         54VgFhxiQNZ2uL6txzOkCI5k2T2HfkNMs9t/FSAn1IM70FurZUjAiHApnSAFDrGvpjmu
         lZU9KdqbtDhD2zRkcXX02KbU2rJ1G9vBnthgRufITUMn5EUm3D+/IwUhQMHP/nnc8Qcn
         /NndLhKuagf9LNHdfQEKWVLnHi++jOuhONrDlH57z+qYjyWcgeyYpVyJxrF3Ufh2XbrM
         y8ctN7dvwTMZwI2MmJP/RnlK+N7+mSAm7TVDbta0+EPTwyEGj4tMO815hzJooI28zziE
         +v+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678142508;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J8x91/t3dwIfLtqbgCFfhhKLJcllwDKNOmC2E+E2xTE=;
        b=WrMj3Q20Yfmm7nvWrvNjIgVzBeEpvBNVg8R0jP7VDMpXLvhnKPk/yi1kSJdci3zPyL
         SGMaYbjy/BtCYZAy73ENTFsg+yn1kaLVeNEe9QdxcSD4C0R8869mMmYC7ciHkCagKZfl
         PKDpW+2+175G3sKkE7onnRr9SijwcOqmx8T/JoJiwwc6N9GhgbiZJbmgPrw+5q87sm38
         tzbE7L7GxwnstTh7pWgfH2KEAgHrDZEhFezL4YDmEATrbBp8p5VyY4w+Rzvzoj/QNKXb
         wLL9/E49LuAqXGkEXpnLZSh3E7u837/ysqWTPbV5YfQOTLhtKxKaHsl7XAlZ2LPLqFsM
         TJpg==
X-Gm-Message-State: AO0yUKVw9MHxcLUh6w9ZeBzoS8TZvXzUiKoA972OXSsVsnn2VX5lBPs6
        9zsNj+M9q59r29X4k7fqtGzh1FA9cjuv
X-Google-Smtp-Source: AK7set+KL1AOCKwf3Kb7nrXUmS3jKvF934DJ+eKPK4nuTqt1uFT5Dh+EO/YoXMmWOFg0NqDRQkatdQds3AQZ
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a17:90a:7064:b0:230:3b84:9169 with SMTP id
 f91-20020a17090a706400b002303b849169mr4600337pjk.2.1678142508419; Mon, 06 Mar
 2023 14:41:48 -0800 (PST)
Date:   Mon,  6 Mar 2023 14:41:17 -0800
In-Reply-To: <20230306224127.1689967-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20230306224127.1689967-1-vipinsh@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230306224127.1689967-9-vipinsh@google.com>
Subject: [Patch v4 08/18] KVM: x86/mmu: Track unused mmu_shadowed_info_cache
 pages count via global counter
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

Add unused pages in mmu_shadowed_info_cache to global MMU unused page
cache counter i.e. kvm_total_unused_cached_pages. These pages will be
freed by MMU shrinker in future commit.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 arch/x86/include/asm/kvm_host.h | 3 ++-
 arch/x86/kvm/mmu/mmu.c          | 8 ++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 4322c7020d5d..185719dbeb81 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -792,7 +792,8 @@ struct kvm_vcpu_arch {
 	struct kvm_mmu_memory_cache mmu_page_header_cache;
 
 	/*
-	 * Protect allocation and release of pages from mmu_shadow_page_cache.
+	 * Protect allocation and release of pages from mmu_shadow_page_cache
+	 * and mmu_shadowed_info_cache.
 	 */
 	struct mutex mmu_shadow_page_cache_lock;
 
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 0a0962d8108b..b7ca31b5699c 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -715,8 +715,8 @@ static int mmu_topup_memory_caches(struct kvm_vcpu *vcpu, bool maybe_indirect)
 		return r;
 
 	if (maybe_indirect) {
-		r = kvm_mmu_topup_memory_cache(&vcpu->arch.mmu_shadowed_info_cache,
-					       PT64_ROOT_MAX_LEVEL);
+		r = mmu_topup_sp_memory_cache(&vcpu->arch.mmu_shadowed_info_cache,
+					      PT64_ROOT_MAX_LEVEL);
 		if (r)
 			return r;
 	}
@@ -729,8 +729,8 @@ static void mmu_free_memory_caches(struct kvm_vcpu *vcpu)
 	kvm_mmu_free_memory_cache(&vcpu->arch.mmu_pte_list_desc_cache);
 	mutex_lock(&vcpu->arch.mmu_shadow_page_cache_lock);
 	mmu_free_sp_memory_cache(&vcpu->arch.mmu_shadow_page_cache);
+	mmu_free_sp_memory_cache(&vcpu->arch.mmu_shadowed_info_cache);
 	mutex_unlock(&vcpu->arch.mmu_shadow_page_cache_lock);
-	kvm_mmu_free_memory_cache(&vcpu->arch.mmu_shadowed_info_cache);
 	kvm_mmu_free_memory_cache(&vcpu->arch.mmu_page_header_cache);
 }
 
@@ -2197,7 +2197,7 @@ static struct kvm_mmu_page *kvm_mmu_alloc_shadow_page(struct kvm *kvm,
 	sp = kvm_mmu_memory_cache_alloc(caches->page_header_cache);
 	sp->spt = mmu_sp_memory_cache_alloc(caches->shadow_page_cache);
 	if (!role.direct)
-		sp->shadowed_translation = kvm_mmu_memory_cache_alloc(caches->shadowed_info_cache);
+		sp->shadowed_translation = mmu_sp_memory_cache_alloc(caches->shadowed_info_cache);
 
 	set_page_private(virt_to_page(sp->spt), (unsigned long)sp);
 
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

