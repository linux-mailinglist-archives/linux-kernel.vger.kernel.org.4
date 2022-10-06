Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144645F5E09
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 02:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiJFAvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 20:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJFAvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 20:51:32 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5233FEEE
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 17:51:31 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 11-20020a63060b000000b00449979478e3so189143pgg.19
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 17:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=N2JzrA6LKGjY2GS+S+Iq2eIC2x3Ha7I+pGoKcHyzxdc=;
        b=L1/6WDDeAm5HVOrbvSVQEM0+So88TrzHSsH72wCu24BDKYaX9fF0pyusTWzV+MMu0Y
         kjfBM3RYlIIjiNdpaenQso1A7RSSTLvb63g8NcbJ8WPnu0C6nSrShmTzpi+uFt2QDw2K
         WpP3jiG+NKKi4MnuaBQ4GQ3AtXYIkI+cDxZ6Q/DAtkqABQyOG2D/s6CcZeChrVv0VtKq
         8bCdwm23/ovUKOj6c8QCiXwd8EvEiUUOWvcqNa6Dg0+y+bTFXamSkqQ8XjcSOk+/4RKO
         JzQnuzz5mvhTRdMieJpXd0CW5B2jsJOQjDbW9TaMzvcgM4/wlfpErjpQEIJ4rzg2oqfk
         uCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N2JzrA6LKGjY2GS+S+Iq2eIC2x3Ha7I+pGoKcHyzxdc=;
        b=vDK9vnFFO9JfSM7t0Ni8kvpP93jB7r05+Q8exzaiC7qKwTKWxGFAVUC+Ag1JBrBdup
         uBLknMqmVw0OIVNZ/EbKCiBi+0c+P3D7YphnmtFnUAvXXfqNhe/Lax0iFGCHDk69crKX
         pB6v3DEWFr8aroB2mczUcxfOa3pWK4kySReADvA2mzmL0d17rxPNx0vn2JFbrvbCYOBv
         v33KdC5mHIim+7h11EJ9NVUSZ63rIMNP6eQ4CrsPbjC5y1C1JTCGvhRq5P8xCsfiZEuO
         yRMtvuIu4PpWI7ANuLAlcJk8piAYqmIsTU8MYY0B/JKD0h6+UStrpw0A8ndiFREB6nGq
         v+lw==
X-Gm-Message-State: ACrzQf09cpFTQ2hDFHKaFR8N8yrqI50LbsUuqZOTD7uefF9x16p+KRfJ
        YyuXZ936CnDbZXwdjtdUzqmjZTmuet8=
X-Google-Smtp-Source: AMsMyM7o86PSzvKQ/Ty4+habRH661xvYI4/6xuTYZouO+eGC6sL1qCG71WfKyD8RG0jJSX9rEXqKfXIXKYg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:2d85:b0:20a:d20e:a5fe with SMTP id
 sj5-20020a17090b2d8500b0020ad20ea5femr2416301pjb.96.1665017491320; Wed, 05
 Oct 2022 17:51:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  6 Oct 2022 00:51:15 +0000
In-Reply-To: <20221006005125.680782-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221006005125.680782-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221006005125.680782-3-seanjc@google.com>
Subject: [PATCH 02/12] KVM: selftests: Refactor X86_FEATURE_* framework to
 prep for X86_PROPERTY_*
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>
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

Refactor the X86_FEATURE_* framework to prepare for extending the core
logic to support "properties".  The "feature" framework allows querying a
single CPUID bit to detect the presence of a feature; the "property"
framework will extend the idea to allow querying a value, i.e. to get a
value that is a set of contiguous bits in a CPUID leaf.

Opportunistically add static asserts to ensure features are fully defined
at compile time, and to try and catch mistakes in the definition of
features.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/x86_64/processor.h  | 38 ++++++++++++-------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index bb9c5f34a893..144268e30b22 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -63,16 +63,21 @@ struct kvm_x86_cpu_feature {
 	u8	reg;
 	u8	bit;
 };
-#define	KVM_X86_CPU_FEATURE(fn, idx, gpr, __bit)	\
-({							\
-	struct kvm_x86_cpu_feature feature = {		\
-		.function = fn,				\
-		.index = idx,				\
-		.reg = KVM_CPUID_##gpr,			\
-		.bit = __bit,				\
-	};						\
-							\
-	feature;					\
+#define	KVM_X86_CPU_FEATURE(fn, idx, gpr, __bit)				\
+({										\
+	struct kvm_x86_cpu_feature feature = {					\
+		.function = fn,							\
+		.index = idx,							\
+		.reg = KVM_CPUID_##gpr,						\
+		.bit = __bit,							\
+	};									\
+										\
+	static_assert((fn & 0xc0000000) == 0 ||					\
+		      (fn & 0xc0000000) == 0x40000000 ||			\
+		      (fn & 0xc0000000) == 0x80000000 ||			\
+		      (fn & 0xc0000000) == 0xc0000000);				\
+	static_assert(idx < BIT(sizeof(feature.index) * BITS_PER_BYTE));	\
+	feature;								\
 })
 
 /*
@@ -426,15 +431,22 @@ static inline void cpuid(uint32_t function,
 	return __cpuid(function, 0, eax, ebx, ecx, edx);
 }
 
-static inline bool this_cpu_has(struct kvm_x86_cpu_feature feature)
+static inline uint32_t __this_cpu_has(uint32_t function, uint32_t index,
+				      uint8_t reg, uint8_t lo, uint8_t hi)
 {
 	uint32_t gprs[4];
 
-	__cpuid(feature.function, feature.index,
+	__cpuid(function, index,
 		&gprs[KVM_CPUID_EAX], &gprs[KVM_CPUID_EBX],
 		&gprs[KVM_CPUID_ECX], &gprs[KVM_CPUID_EDX]);
 
-	return gprs[feature.reg] & BIT(feature.bit);
+	return (gprs[reg] & GENMASK(hi, lo)) >> lo;
+}
+
+static inline bool this_cpu_has(struct kvm_x86_cpu_feature feature)
+{
+	return __this_cpu_has(feature.function, feature.index,
+			      feature.reg, feature.bit, feature.bit);
 }
 
 #define SET_XMM(__var, __xmm) \
-- 
2.38.0.rc1.362.ged0d419d3c-goog

