Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4865F5D7C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 02:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiJFAEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 20:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiJFADk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 20:03:40 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E67286800
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 17:03:29 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id g3-20020a17090a7d0300b0020a644c7ff9so121135pjl.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 17:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=OOUVOx92e9TPbHiMSq0GFIi0JU6k8DvZUcmie6j5t9E=;
        b=eL/uz7eLgvELZ04pGzDuj2OMzJCUZuUVaPwvFBeZMIboI6rKy6nEP5EnUouwL6jZYy
         5XvfIKLr0XgaExVQkeaB1uRq767AWbDrqdMBA202GJFPWdMXZnKQ3rGL1KOo2A3yX/kU
         tl4mpDFSjPqbhAp7QT/Vi+NvBjxJ+JRJNnUh4anob9bsVrvfjb8wtS4gEb5UWynbtFyR
         8MTtlSKCnOJkDSbnJQMK3jNGFZGamvaNruD34ZVaIEhx90ZbdydGzWl4n4yRP34kTi81
         e+V5gLSdjvi7oSbqf8jSJP6P2oDueisaiM4Za7/qduvhGnrAm+bc1ebwq2/SyfGgdHHM
         itzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OOUVOx92e9TPbHiMSq0GFIi0JU6k8DvZUcmie6j5t9E=;
        b=c6Eznq2MI92lX2SsIUxa2gwJM/B47vtBh8y3wKG5KgZAQTyrtq4CFjKbtLJK70acO3
         rxSYkmMWUkog8jKLzrc9onIjvXi7bU/HCmRIr1Rjs+aSvjmu7s9AnwMZHxYnvSl8ByG9
         KJK2J/6qUzGUQd4uCNisPCXglAueRaSd0e2Ie0t8C71yYudlI7HzqVFR8hjtg2pk2YX0
         kabQ2fdyUzkmqBEIfuvTSE25/OwmcWKa7ZdfSO1lkFyIzahsHh2LqQa6yrlwcfoCeM6e
         qQcDfCpt/u2HatqSK1w6PZnle6aj4WbKkhZUGca11BWAV3Pcf96YO2gkHtRh2OsZkzYZ
         aegA==
X-Gm-Message-State: ACrzQf22v0gOMW2mFx1Jww3J+wqZzpZOd76WpEkTS9+GbiB3tPnA1RVo
        YhTxx8quqp1K+NF+r0B+k78lU1IvYwc=
X-Google-Smtp-Source: AMsMyM6ihFR3Fgp9UWKZShMmVif5xSTGipKmZyOjO6hfiLOnqQy5RAaUef7tz5vYtJEmsELaX8tp+hDd1Wc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:7c4a:b0:20a:b201:461a with SMTP id
 e10-20020a17090a7c4a00b0020ab201461amr2195880pjl.181.1665014608006; Wed, 05
 Oct 2022 17:03:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  6 Oct 2022 00:03:12 +0000
In-Reply-To: <20221006000314.73240-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221006000314.73240-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221006000314.73240-7-seanjc@google.com>
Subject: [PATCH v5 6/8] KVM: x86: Init vcpu->arch.perf_capabilities in common
 x86 code
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Like Xu <like.xu.linux@gmail.com>
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

Initialize vcpu->arch.perf_capabilities in x86's kvm_arch_vcpu_create()
instead of deferring initialization to vendor code.  For better or worse,
common x86 handles reads and writes to the MSR, and so common x86 should
also handle initializing the MSR.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/pmu_intel.c | 1 -
 arch/x86/kvm/x86.c           | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 24f4c22691f8..49343ee48062 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -631,7 +631,6 @@ static void intel_pmu_init(struct kvm_vcpu *vcpu)
 		pmu->fixed_counters[i].current_config = 0;
 	}
 
-	vcpu->arch.perf_capabilities = kvm_caps.supported_perf_cap;
 	lbr_desc->records.nr = 0;
 	lbr_desc->event = NULL;
 	lbr_desc->msr_passthrough = false;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4bd5f8a751de..b6a973d53f93 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11821,6 +11821,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	vcpu->arch.pat = MSR_IA32_CR_PAT_DEFAULT;
 
 	kvm_async_pf_hash_reset(vcpu);
+
+	vcpu->arch.perf_capabilities = kvm_caps.supported_perf_cap;
 	kvm_pmu_init(vcpu);
 
 	vcpu->arch.pending_external_vector = -1;
-- 
2.38.0.rc1.362.ged0d419d3c-goog

