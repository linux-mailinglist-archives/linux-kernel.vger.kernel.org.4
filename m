Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871AF63C6CD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 18:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236402AbiK2RxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 12:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235974AbiK2RxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 12:53:09 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B6E2BB1A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 09:53:08 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3d0465d32deso22732517b3.20
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 09:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=TE8QWGQorC/1BoZc6tBunzgB7sNwcvzYphQolAm92kE=;
        b=ZRkZwzRyxYLC7OVvXyieN2+DQai2f+Xfj7wfnj14FqduUWE2x5UnhV5Uk44DFCTOlc
         +O4oLJWBjNswhNxYocIIR6JxaTkkESabsFIxEBhDrFYesv1N4TbE5msXjxeL05aK1o8V
         qCLnVGyouPviLFQzR/b/E0Xen8uLPLQ7DHv6bJYWYxbBKBIFTI90O06d/9sIpbbK2+a+
         vZmTuUgbcuQqO8kwq5vBYndxn1KmoJNSvcH5cJ9iQ63hjXawnfzi1VM5JY/UunfB3x3B
         FPszD65HzSoRFhWChz55SBRKztztXe6bCM3W6R+jKR/oX5Q7gMt58A+caFQ0EQq6cSpp
         cBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TE8QWGQorC/1BoZc6tBunzgB7sNwcvzYphQolAm92kE=;
        b=IyLtryFAxhMGOc+E1wgtCpdHomkVFaWlIMoKlY6/xFT3vmlnh0q+shCncrFsRGpUNX
         8Q4iYmEkjcxy9IxJCCaZUUtNQulWy2JvOO7UXg/o0fRrOJt4KhTKMWiI4YVA4qiphKtF
         cs3/KjAYKWDhAR9tivft+lf+XVmpeuEAlhs/WjxNihxIcMy0nMwMwOY96AsdYwyDvQt1
         iGVDJf8W1uqfqLr8v1GKmLvJwm5qtgy549DSqy3x3LpNAqEVgv2h0OFGbS+hqq3emJtI
         hCGwr0peSxLd5gRaYcMY39bdrBa7cjRE9YBnFIHsAKBkBCsE37hOC1727OhdM9mNDsnO
         JDFg==
X-Gm-Message-State: ANoB5pkLcpmp0q6edwZQ57mqq9OYJBiIkAlNgIr6UzgzYl1r3ZbSx92R
        7P1GGPvyxtV/0Fg3GfVyiNVVsj+xn/o=
X-Google-Smtp-Source: AA0mqf53GkAVWGl5pFphtF5KnD4Rh+dv3qIDHGkZOLbOZB0Cvo2PSPSnAuznsatL/GFRCwz+PzWqLeBACVs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:af1b:0:b0:34d:15db:6195 with SMTP id
 n27-20020a81af1b000000b0034d15db6195mr54721730ywh.240.1669744387838; Tue, 29
 Nov 2022 09:53:07 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 29 Nov 2022 17:53:00 +0000
In-Reply-To: <20221129175300.4052283-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221129175300.4052283-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221129175300.4052283-3-seanjc@google.com>
Subject: [PATCH 2/2] KVM: selftests: Restore assert for non-nested VMs in
 access tracking test
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>
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

Restore the assert (on x86-64) that <10% of pages are still idle when NOT
running as a nested VM in the access tracking test.  The original assert
was converted to a "warning" to avoid false failures when running the
test in a VM, but the non-nested case does not suffer from the same
"infinite TLB size" issue.

Using the HYPERVISOR flag isn't infallible as VMMs aren't strictly
required to enumerate the "feature" in CPUID, but practically speaking
anyone that is running KVM selftests in VMs is going to be using a VMM
and hypervisor that sets the HYPERVISOR flag.

Cc: David Matlack <dmatlack@google.com>
Cc: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/access_tracking_perf_test.c   | 17 ++++++++++++-----
 .../selftests/kvm/include/x86_64/processor.h    |  1 +
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/access_tracking_perf_test.c b/tools/testing/selftests/kvm/access_tracking_perf_test.c
index d45ef319a68f..9f9503e40ca5 100644
--- a/tools/testing/selftests/kvm/access_tracking_perf_test.c
+++ b/tools/testing/selftests/kvm/access_tracking_perf_test.c
@@ -46,6 +46,7 @@
 #include "test_util.h"
 #include "memstress.h"
 #include "guest_modes.h"
+#include "processor.h"
 
 /* Global variable used to synchronize all of the vCPU threads. */
 static int iteration;
@@ -180,15 +181,21 @@ static void mark_vcpu_memory_idle(struct kvm_vm *vm,
 	 * access tracking but low enough as to not make the test too brittle
 	 * over time and across architectures.
 	 *
-	 * Note that when run in nested virtualization, this check will trigger
-	 * much more frequently because TLB size is unlimited and since no flush
-	 * happens, much more pages are cached there and guest won't see the
-	 * "idle" bit cleared.
+	 * When running the guest as a nested VM, "warn" instead of asserting
+	 * as the TLB size is effectively unlimited and the KVM doesn't
+	 * explicitly flush the TLB when aging SPTEs.  As a result, more pages
+	 * are cached and the guest won't see the "idle" bit cleared.
 	 */
-	if (still_idle >= pages / 10)
+	if (still_idle >= pages / 10) {
+#ifdef __x86_64__
+		TEST_ASSERT(this_cpu_has(X86_FEATURE_HYPERVISOR),
+			    "vCPU%d: Too many pages still idle (%lu out of %lu)",
+			    vcpu_idx, still_idle, pages);
+#endif
 		printf("WARNING: vCPU%d: Too many pages still idle (%lu out of %lu), "
 		       "this will affect performance results.\n",
 		       vcpu_idx, still_idle, pages);
+	}
 
 	close(page_idle_fd);
 	close(pagemap_fd);
diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 5d310abe6c3f..22852bd32d7b 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -94,6 +94,7 @@ struct kvm_x86_cpu_feature {
 #define	X86_FEATURE_XSAVE		KVM_X86_CPU_FEATURE(0x1, 0, ECX, 26)
 #define	X86_FEATURE_OSXSAVE		KVM_X86_CPU_FEATURE(0x1, 0, ECX, 27)
 #define	X86_FEATURE_RDRAND		KVM_X86_CPU_FEATURE(0x1, 0, ECX, 30)
+#define	X86_FEATURE_HYPERVISOR		KVM_X86_CPU_FEATURE(0x1, 0, ECX, 31)
 #define X86_FEATURE_PAE			KVM_X86_CPU_FEATURE(0x1, 0, EDX, 6)
 #define	X86_FEATURE_MCE			KVM_X86_CPU_FEATURE(0x1, 0, EDX, 7)
 #define	X86_FEATURE_APIC		KVM_X86_CPU_FEATURE(0x1, 0, EDX, 9)
-- 
2.38.1.584.g0f3c55d4c2-goog

