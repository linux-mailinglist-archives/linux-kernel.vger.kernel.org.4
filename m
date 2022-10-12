Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6E75FCA70
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 20:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiJLSSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 14:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiJLSRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 14:17:38 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591E2A87B9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 11:17:25 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id m16-20020a17090ab79000b0020abf0d3ff4so8457519pjr.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 11:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=6LjPpC5WMK+HN+fw4FsDT2cJnXsT7lM8aCSyAvCtEgA=;
        b=NuW25Nv3biN2IHS4poTdCD4rAjew+qpVd76+lQVBDIym1H9FoBeMG+X5ODgl4H7p+j
         ZpINWlCzUXGsBCo+2p0WR5bMJ301Ad+BvriGTTYQfCAA8N5N2XXgElBzbFpja/WmjtbD
         r1U8sdlPTHKYjp8AvuMc1BWKuAZP28hM/xHbow2I2ehjSa41fxbYvgHZ8ZEzsL9i/0ME
         ygk4gfSIsEx7D8ZGXcxyuXrxbMtiuDj2aklQMMfTSeLfRo56aPgXRP+spNxfF50lNsqQ
         HTvy9TUINVREz4MVmhk7Qka+Qs1NjZoIMI5z2xXnuFzD0+FsaKIJA1oySTG7+XOptZNb
         URPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6LjPpC5WMK+HN+fw4FsDT2cJnXsT7lM8aCSyAvCtEgA=;
        b=5XcdZqU/IPWVSBPazYadj0DvJOGNDrIdLaJUeJ8JUmE8Zca45o1SmZIcRFBxqoSDbN
         ry0AEiUR37PQlyk3kLaHyCU7TTHaGBPebka2tgd9L7QH4nE7rwe7iWob7Dj/r0jnDebN
         uiN9ZvXVMm3h0dqQrE9bHdNTUBZd5+wMfnleApoARbiyqssHTCviy4K44xzgr7e4Dktr
         kTlXl25SyyjE7pI4JgxvfzgBxfYkVOWcvqcqGcG1omHsn4uLSvVA/24gRuYRV1deTzSY
         jjU7IdF45wcWAo20G+kUbQ0kJ4PUsSklLSEcfqvtGRhckX3JEXMlutC4NPLcfH5zoYrZ
         Ajmw==
X-Gm-Message-State: ACrzQf3/XgfmUQwZ2xbxswCAnNvTL82dsjU68Yif0X2cXpvh220LLm2R
        xWqUqD+Ju//BlkbeNAahyOG8g1LWO1A=
X-Google-Smtp-Source: AMsMyM7htAu+wDIbq1XRbKYSbs7Fwquqh8ysfXFz2L3IgX1ZynIZzrjBpLYtIdUWzgxbDYA5EHlVbNckaRM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:e7d0:b0:20c:169f:7503 with SMTP id
 kb16-20020a17090ae7d000b0020c169f7503mr6483671pjb.175.1665598643087; Wed, 12
 Oct 2022 11:17:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 12 Oct 2022 18:17:00 +0000
In-Reply-To: <20221012181702.3663607-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221012181702.3663607-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221012181702.3663607-10-seanjc@google.com>
Subject: [PATCH v4 09/11] KVM: x86/mmu: Replace open coded usage of
 tdp_mmu_page with is_tdp_mmu_page()
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

Use is_tdp_mmu_page() instead of querying sp->tdp_mmu_page directly so
that all users benefit if KVM ever finds a way to optimize the logic.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c     | 2 +-
 arch/x86/kvm/mmu/tdp_mmu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 1598aaf29c4a..4792d76edd6d 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1907,7 +1907,7 @@ static bool is_obsolete_sp(struct kvm *kvm, struct kvm_mmu_page *sp)
 		return true;
 
 	/* TDP MMU pages due not use the MMU generation. */
-	return !sp->tdp_mmu_page &&
+	return !is_tdp_mmu_page(sp) &&
 	       unlikely(sp->mmu_valid_gen != kvm->arch.mmu_valid_gen);
 }
 
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index f7c4555d5d36..477418a2ed9b 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -134,7 +134,7 @@ void kvm_tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root,
 	if (!refcount_dec_and_test(&root->tdp_mmu_root_count))
 		return;
 
-	WARN_ON(!root->tdp_mmu_page);
+	WARN_ON(!is_tdp_mmu_page(root));
 
 	/*
 	 * The root now has refcount=0.  It is valid, but readers already
-- 
2.38.0.rc1.362.ged0d419d3c-goog

