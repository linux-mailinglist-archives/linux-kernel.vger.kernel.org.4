Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8BDE6AD1DC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 23:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjCFWmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 17:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjCFWmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:42:05 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979B180E26
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 14:41:50 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id s8-20020a170902b18800b0019c92f56a8aso6710666plr.22
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 14:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678142510;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ld4MGsQjtnTx0Dcfr9NtPlok1/1/gYNLFbhbEuUoYrA=;
        b=krwov+RRGwrmv2jjs5BE/jAirVZA4W+6fdZ3k7jqm0NcyoDyVN0Iy2f7RNdtZV6pL0
         taP6SnYbTHXrwcU/w37ORxzzFBrYm+IM3kOf6FMHbIrJEsfgizuWkBijapf8wpi7Ccj8
         IJtbaNqH913nKSrQP43U/ZTB0esbAJr1VnGS6Y0n27248m976Z3s9LHepZESK0jcrxYz
         ya5ruaw6MSO5mNR77y9pEo9E4FVyvmRZyHx/KGRJYnaLsDce4p0oh8njFTrb3lPdYVLi
         kpoqjKWJSECDlZ/hBKu0b2pGTcIO/OJSdAv2hJC3/3EEP2PCwYDWa9v1UDkMlUQFcY8k
         y6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678142510;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ld4MGsQjtnTx0Dcfr9NtPlok1/1/gYNLFbhbEuUoYrA=;
        b=Vkt544vK0Jeo1XOgYpk9WUqvZNvS8Uj2OcwLwRBEtZFdVn4IRUvjjKCDi9yJwTohDF
         7fv1pKFX4Kdx2IyBzpSZ1r94fc+UrpJy7FszfYk6KilKqYhv8RJWS6gu/K9u10f54AVs
         +G0dMjboZh6y2kH1a2kMDMyZ6XK8M3AhYSitZHvMjyYgPGbCuH7YeELohjXU2PpDvUEt
         DfHfHnfyM4cPO2/K4U4Qybb98eKHneqi1PDL7onRY9ds6psfIj3+KvaUPAA6hr9BURgj
         xhIKK7lgY5ZzkKiQPXUCHJvr57rCvpH766TRlpXP4D8wPD/zNa/6dbaSxaaj96czdHIh
         ZphQ==
X-Gm-Message-State: AO0yUKVvBxzzco+ZsAbZ+CDaeOw7ENJfAhaya1iG6xK1D228xIo+ZFfp
        N7TB9GMSHhzLOjugMsz2RC5VNG0UKbJu
X-Google-Smtp-Source: AK7set+nYVXnMVTVXx8L/0tlevRKDekxzEjuxmVVtiFTH9jPAVLUzGzbP9E9MA8O/R60f9kn2yP7smPPz7Ml
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a17:903:428b:b0:19a:8751:4dfc with SMTP id
 ju11-20020a170903428b00b0019a87514dfcmr4898541plb.1.1678142510172; Mon, 06
 Mar 2023 14:41:50 -0800 (PST)
Date:   Mon,  6 Mar 2023 14:41:18 -0800
In-Reply-To: <20230306224127.1689967-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20230306224127.1689967-1-vipinsh@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230306224127.1689967-10-vipinsh@google.com>
Subject: [Patch v4 09/18] KVM: x86/mmu: Shrink mmu_shadowed_info_cache via MMU shrinker
From:   Vipin Sharma <vipinsh@google.com>
To:     seanjc@google.com, pbonzini@redhat.com, bgardon@google.com,
        dmatlack@google.com
Cc:     jmattson@google.com, mizhang@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vipin Sharma <vipinsh@google.com>
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

Shrink shadow page cache via MMU shrinker based on
kvm_total_unused_cached_pages.

Tested by running dirty_log_perf_test while dropping cache
via "echo 2 > /proc/sys/vm/drop_caches" at 1 second interval. Global
always return to 0. Shrinker also gets invoked to remove pages in cache.

Above test were run with three configurations:
- EPT=N
- EPT=Y, TDP_MMU=N
- EPT=Y, TDP_MMU=Y

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index b7ca31b5699c..a4bf2e433030 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6725,6 +6725,8 @@ static unsigned long mmu_shrink_scan(struct shrinker *shrink,
 		kvm_for_each_vcpu(i, vcpu, kvm) {
 			freed += mmu_memory_cache_try_empty(&vcpu->arch.mmu_shadow_page_cache,
 							    &vcpu->arch.mmu_shadow_page_cache_lock);
+			freed += mmu_memory_cache_try_empty(&vcpu->arch.mmu_shadowed_info_cache,
+							    &vcpu->arch.mmu_shadow_page_cache_lock);
 			if (freed >= sc->nr_to_scan)
 				goto out;
 		}
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

