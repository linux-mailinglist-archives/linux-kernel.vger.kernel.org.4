Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0046B5315
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 22:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjCJVom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 16:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjCJVoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 16:44:07 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E419A2B9DF
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:43:17 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id ju20-20020a170903429400b0019ea5ea044aso3500155plb.21
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678484584;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=R1zMC0FqfyEV/0S9ZnbLP+wjU2iwXROZi5JXQooIbHQ=;
        b=qFNLiBFLLwtMgF+IeChjoCJa+ve1zT5ko/h9MJUHy8G8CX+5NcXD0Y6sTpwQKG+qXP
         4NqQn4eVqEyN1HTU7GFiP0F/jBTXTePyXlzK+IWl2IQ6EGzCrtkqnHUUDpWgjSChI0sf
         lafMTJDPi9IKPx1rvVse3jbOarLoqHrFYV+QEY0OQj5LEG8F18DItVyjpN5xcfAI6RCg
         lb1AYL8iUu/vqeb6TvGOPRXMRk1NMUUnwF4PPQrqWcmwlrGnqd2UMjgaFilM2hI2dQIa
         kAQQa4bHO4nfqHbxjuO1rm1hp/ImvvQqskELGWC3DgLpv86gtnF7tdIaG22ZkkjAJjRe
         2QFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678484584;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R1zMC0FqfyEV/0S9ZnbLP+wjU2iwXROZi5JXQooIbHQ=;
        b=XWOXJcSvywpuCKhHYmUvqdRgh4vg8WGy2v028NXu5PSovWTXeZrYYTUemb7Q1G9CIt
         eTds4U7O3+U3M7x09Wy0zPfWo+gVE8y+jbTSAKedI/3wvlsPwTSAZfICWjPcFy7MOaaF
         qedT2UgLPW/tTi+RCOQaJWn25HHtzTHv/z2XucLh5GbiM5pyl3KGDlKwyGdqK5fQzu3X
         mcIVNNpwW1Ad031Q+60pNzjxUs/ikmcxGgl4yVWTXLrB6u/HA1uThbifZZG9Y5fhqS5F
         7t6J28pjq9frEYZ2yeZ7Mr6OX4AWcA0ADn/nh/LvyFXclnDkjRAiuzZJjklkecrsFiUp
         oL2A==
X-Gm-Message-State: AO0yUKUKM3IMAQsuuLOzgIeu1QcvAW9QWG4+4IUD1CIziaveOk2ZxEZc
        yn3JY2djMiRqA8co1Omj7m+UryfhMVI=
X-Google-Smtp-Source: AK7set8TE4zXGBqQkBmFUJYlcxB6YWIGW3QIa6wDkwV6iROjJa0Me5urReLF/uWyEXu0xpfbwbHaICFKLXE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a62:d14a:0:b0:592:5eb2:84ea with SMTP id
 t10-20020a62d14a000000b005925eb284eamr10759214pfl.4.1678484584488; Fri, 10
 Mar 2023 13:43:04 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Mar 2023 13:42:28 -0800
In-Reply-To: <20230310214232.806108-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230310214232.806108-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230310214232.806108-15-seanjc@google.com>
Subject: [PATCH v2 14/18] KVM: SVM: Check that the current CPU supports SVM in kvm_is_svm_supported()
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Kai Huang <kai.huang@intel.com>, Chao Gao <chao.gao@intel.com>
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

Check "this" CPU instead of the boot CPU when querying SVM support so that
the per-CPU checks done during hardware enabling actually function as
intended, i.e. will detect issues where SVM isn't support on all CPUs.

Disable migration for the use from svm_init() mostly so that the standard
accessors for the per-CPU data can be used without getting yelled at by
CONFIG_DEBUG_PREEMPT=y sanity checks.  Preventing the "disabled by BIOS"
error message from reporting the wrong CPU is largely a bonus, as ensuring
a stable CPU during module load is a non-goal for KVM.

Link: https://lore.kernel.org/all/ZAdxNgv0M6P63odE@google.com
Cc: Kai Huang <kai.huang@intel.com>
Cc: Chao Gao <chao.gao@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 2934f185960d..f04b61c3d9d8 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -520,18 +520,20 @@ static void svm_init_osvw(struct kvm_vcpu *vcpu)
 		vcpu->arch.osvw.status |= 1;
 }
 
-static bool kvm_is_svm_supported(void)
+static bool __kvm_is_svm_supported(void)
 {
-	int cpu = raw_smp_processor_id();
+	int cpu = smp_processor_id();
+	struct cpuinfo_x86 *c = &cpu_data(cpu);
+
 	u64 vm_cr;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
-	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON) {
+	if (c->x86_vendor != X86_VENDOR_AMD &&
+	    c->x86_vendor != X86_VENDOR_HYGON) {
 		pr_err("CPU %d isn't AMD or Hygon\n", cpu);
 		return false;
 	}
 
-	if (!boot_cpu_has(X86_FEATURE_SVM)) {
+	if (!cpu_has(c, X86_FEATURE_SVM)) {
 		pr_err("SVM not supported by CPU %d\n", cpu);
 		return false;
 	}
@@ -550,9 +552,20 @@ static bool kvm_is_svm_supported(void)
 	return true;
 }
 
+static bool kvm_is_svm_supported(void)
+{
+	bool supported;
+
+	migrate_disable();
+	supported = __kvm_is_svm_supported();
+	migrate_enable();
+
+	return supported;
+}
+
 static int svm_check_processor_compat(void)
 {
-	if (!kvm_is_svm_supported())
+	if (!__kvm_is_svm_supported())
 		return -EIO;
 
 	return 0;
-- 
2.40.0.rc1.284.g88254d51c5-goog

