Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9436B5317
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 22:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjCJVoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 16:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbjCJVoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 16:44:12 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1277DD0C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:43:21 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id i22-20020aa787d6000000b0061dda189477so3473606pfo.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678484586;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=9q/d7g9qox1x40p0EhyhFdiJHeiHo6UfgDgcUMY2me0=;
        b=S+PLcRgF3wy1MWeNCthYcvbQ8p4zb1869uJGzKPqf8IHd47ghO2mn5LrvcqpZ7PChJ
         O8ClBe5JTfp9ZzVAdvjjPyTHmpLw5H/P36z9EqCJ97mX3SvEf6t+pZsjn+zSRW8fcfDS
         Gg7lVgXuJ+Y6Hze0ASXWtX4lj0pA0Ifa+Sq8cq5zGhPCEMb8wB2uJeQsXoW+g1/g9uBV
         DmT8vsmv5UZFoj3oWqFu8yIUW1ro+zKTDvLvPFiYJSwJ2xlk9FgfRWbvsn40KM92UvCt
         N/oy/CZtNllQNQjX1j7F/ZeD5wJy16dR6F4GaGAKIdyvlNql+cGt3T0/l0Icy7z23zig
         WEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678484586;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9q/d7g9qox1x40p0EhyhFdiJHeiHo6UfgDgcUMY2me0=;
        b=UG2veZLoBelvPx8/XUMkzlgYfdhiB17cnRJ6CvyFzxBuljbzjMG47qDUQIRGKaeHNj
         iUclGOHuBvELQGwcbuiI1evW0/WL3gpArE9GLS9tYWtVfUMw4r4MPWqrf3AKGjpCa/3z
         VQpE4OYtUmJRsDWJwGDdOPoRp58EuKKZ/UuAOUqwLKKwBg4TzEl++35WxBmPAeTJNIsv
         TzHp/jzE814kBjya+jMl3DiH1f00KmRYGhc2rPkbkOb27aNyl1x2uHXzvDJqkP0mfYr1
         2P9kDzuH17g1DZxQ+XKxIcVazXbnoev+gt/ECZFKq8eJ73/oISxQvbxAwVIpGYVfebTF
         jStw==
X-Gm-Message-State: AO0yUKXe55gltV8Bhg3PFUaI5bmcbZPOgghJhnJ9QHioJhOZvWrs0X85
        +ooVWtgWN7RWZHQug4c4TU5ODsTbgZU=
X-Google-Smtp-Source: AK7set9eBDlBdJkd/u8qVUijL7wqSOFyJWmNtSA05Z5YfjfZdOvP3ULboyA+bUhFSKPyqCoOOkv4QCMEqYI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:2dcd:b0:237:64dc:5acd with SMTP id
 q13-20020a17090a2dcd00b0023764dc5acdmr10102509pjm.7.1678484586406; Fri, 10
 Mar 2023 13:43:06 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Mar 2023 13:42:29 -0800
In-Reply-To: <20230310214232.806108-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230310214232.806108-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230310214232.806108-16-seanjc@google.com>
Subject: [PATCH v2 15/18] KVM: VMX: Ensure CPU is stable when probing basic
 VMX support
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

Disable migration when probing VMX support during module load to ensure
the CPU is stable, mostly to match similar SVM logic, where allowing
migration effective requires deliberately writing buggy code.  As a bonus,
KVM won't report the wrong CPU to userspace if VMX is unsupported, but in
practice that is a very, very minor bonus as the only way that reporting
the wrong CPU would actually matter is if hardware is broken or if the
system is misconfigured, i.e. if KVM gets migrated from a CPU that _does_
support VMX to a CPU that does _not_ support VMX.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 158853ab0d1b..374e3ddbd476 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2766,9 +2766,9 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 	return 0;
 }
 
-static bool kvm_is_vmx_supported(void)
+static bool __kvm_is_vmx_supported(void)
 {
-	int cpu = raw_smp_processor_id();
+	int cpu = smp_processor_id();
 
 	if (!(cpuid_ecx(1) & feature_bit(VMX))) {
 		pr_err("VMX not supported by CPU %d\n", cpu);
@@ -2784,13 +2784,24 @@ static bool kvm_is_vmx_supported(void)
 	return true;
 }
 
+static bool kvm_is_vmx_supported(void)
+{
+	bool supported;
+
+	migrate_disable();
+	supported = __kvm_is_vmx_supported();
+	migrate_enable();
+
+	return supported;
+}
+
 static int vmx_check_processor_compat(void)
 {
 	int cpu = raw_smp_processor_id();
 	struct vmcs_config vmcs_conf;
 	struct vmx_capability vmx_cap;
 
-	if (!kvm_is_vmx_supported())
+	if (!__kvm_is_vmx_supported())
 		return -EIO;
 
 	if (setup_vmcs_config(&vmcs_conf, &vmx_cap) < 0) {
-- 
2.40.0.rc1.284.g88254d51c5-goog

