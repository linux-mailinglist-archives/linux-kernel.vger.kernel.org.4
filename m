Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A9E6B5302
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 22:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjCJVnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 16:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjCJVmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 16:42:55 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4A71308F8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:42:47 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id u4-20020a170902bf4400b0019e30a57694so3511732pls.20
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678484567;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=6AjMm+ZIflXjbG/NDelvXH8TSuo2TKT9NTo2PS7seCw=;
        b=Qw1EdmDhXaeYs1tE5XZaNY1Ci+xXV0fhwEeQm8/bJRZ42DmkCzGLUDPeyGTOgJGVEK
         7wxUV1aVPx2u8QqcjPKcwpnh8EbRvNn/NZ7kB4tUYIcTwc2h6iSgUrMitfaB2Sc5t+D5
         gkIUnlg3UsW/Kjbt5BlyrQy4s6bx5R0O2TBUE0NaJ4Hwr+MeINZ+kbAa377moYsHMkKE
         1ZMHIceeOUqdT5nxA4BsJ62tO0RwiR6qi94zhB5bNZ7uBcIa4PhX9T7yvfHjJxL71kzb
         ugpq53ovQTF50Gs4t+JbNjsf2q5WWdeqDnamFuNJuTN7Ce6VwLw7Ijz0PAcYPiKlQXPG
         82gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678484567;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6AjMm+ZIflXjbG/NDelvXH8TSuo2TKT9NTo2PS7seCw=;
        b=UDUxpwYl0OQhJ1SG/Vrhdt+fD4UN5FtPF010Qyy1QogFam6TXqazKZmNsiTmFreFP0
         WNlA1w9LLZlgoaE663stMnMsQivpwxg+jzn5S8UZzQ/iyHcVN0HFFLpunBvNwFDPzu1b
         ayTnwKKaoGZyIY/QBtFn0h10ab8CAvyoR6l4aBwJs3rh4peKMiUdXjDzg++575RK+V7t
         W5nuktro5CVUy+RIr435/2SzlH6bIbTOLaCKoy8zFRkiMoIMv9yqwcya5NM/Z0YRXXPa
         F13q4h9AeMHlTl0xEWd9N/jZjiH/3Umdv3Zte49pqFSUgmhdC4TGN8bGESv5oEK5ae1m
         9AQg==
X-Gm-Message-State: AO0yUKUDs/3U+7BefZvDqfm0j0bik9GDQ8DBE7HiKyookZogOe8e+RPT
        HaZUf+nqNulO82eWB7e06Ihv6HtD0h8=
X-Google-Smtp-Source: AK7set9aOEql7O+HQq5HAwihTY5VX5S7zfziF0JC6sqjBHX7AnMbfkiQnAelE3c+OCSc5p5PK2q9BT5AxGw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:4282:b0:19a:ac0b:9d93 with SMTP id
 ju2-20020a170903428200b0019aac0b9d93mr10675117plb.0.1678484567461; Fri, 10
 Mar 2023 13:42:47 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Mar 2023 13:42:19 -0800
In-Reply-To: <20230310214232.806108-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230310214232.806108-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230310214232.806108-6-seanjc@google.com>
Subject: [PATCH v2 05/18] x86/reboot: KVM: Disable SVM during reboot via
 virt/KVM reboot callback
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

Use the virt callback to disable SVM (and set GIF=1) during an emergency
instead of blindly attempting to disable SVM.  Like the VMX case, if KVM
(or an out-of-tree hypervisor) isn't loaded/active, SVM can't be in use.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/reboot.h  |  2 +-
 arch/x86/include/asm/virtext.h |  8 --------
 arch/x86/kernel/reboot.c       |  6 ++----
 arch/x86/kvm/svm/svm.c         | 19 +++++++++++++++++--
 4 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/reboot.h b/arch/x86/include/asm/reboot.h
index 1d098a7d329a..dc2b77e6704b 100644
--- a/arch/x86/include/asm/reboot.h
+++ b/arch/x86/include/asm/reboot.h
@@ -25,7 +25,7 @@ void __noreturn machine_real_restart(unsigned int type);
 #define MRR_BIOS	0
 #define MRR_APM		1
 
-#if IS_ENABLED(CONFIG_KVM_INTEL)
+#if IS_ENABLED(CONFIG_KVM_INTEL) || IS_ENABLED(CONFIG_KVM_AMD)
 typedef void (cpu_emergency_virt_cb)(void);
 void cpu_emergency_register_virt_callback(cpu_emergency_virt_cb *callback);
 void cpu_emergency_unregister_virt_callback(cpu_emergency_virt_cb *callback);
diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
index 5bc29fab15da..aaed66249ccf 100644
--- a/arch/x86/include/asm/virtext.h
+++ b/arch/x86/include/asm/virtext.h
@@ -133,12 +133,4 @@ static inline void cpu_svm_disable(void)
 	}
 }
 
-/** Makes sure SVM is disabled, if it is supported on the CPU
- */
-static inline void cpu_emergency_svm_disable(void)
-{
-	if (cpu_has_svm(NULL))
-		cpu_svm_disable();
-}
-
 #endif /* _ASM_X86_VIRTEX_H */
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 5fb1fbf14c82..db535542b7ab 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -787,7 +787,7 @@ void machine_crash_shutdown(struct pt_regs *regs)
 }
 #endif
 
-#if IS_ENABLED(CONFIG_KVM_INTEL)
+#if IS_ENABLED(CONFIG_KVM_INTEL) || IS_ENABLED(CONFIG_KVM_AMD)
 /* RCU-protected callback to disable virtualization prior to reboot. */
 static cpu_emergency_virt_cb __rcu *cpu_emergency_virt_callback;
 
@@ -821,7 +821,7 @@ int crashing_cpu = -1;
  */
 void cpu_emergency_disable_virtualization(void)
 {
-#if IS_ENABLED(CONFIG_KVM_INTEL)
+#if IS_ENABLED(CONFIG_KVM_INTEL) || IS_ENABLED(CONFIG_KVM_AMD)
 	cpu_emergency_virt_cb *callback;
 
 	rcu_read_lock();
@@ -830,8 +830,6 @@ void cpu_emergency_disable_virtualization(void)
 		callback();
 	rcu_read_unlock();
 #endif
-	/* KVM_AMD doesn't yet utilize the common callback. */
-	cpu_emergency_svm_disable();
 }
 
 #if defined(CONFIG_SMP)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index b43775490074..541dd978a94b 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -38,6 +38,7 @@
 #include <asm/spec-ctrl.h>
 #include <asm/cpu_device_id.h>
 #include <asm/traps.h>
+#include <asm/reboot.h>
 #include <asm/fpu/api.h>
 
 #include <asm/virtext.h>
@@ -565,6 +566,11 @@ void __svm_write_tsc_multiplier(u64 multiplier)
 	preempt_enable();
 }
 
+static void svm_emergency_disable(void)
+{
+	cpu_svm_disable();
+}
+
 static void svm_hardware_disable(void)
 {
 	/* Make sure we clean up behind us */
@@ -5092,6 +5098,13 @@ static struct kvm_x86_init_ops svm_init_ops __initdata = {
 	.pmu_ops = &amd_pmu_ops,
 };
 
+static void __svm_exit(void)
+{
+	kvm_x86_vendor_exit();
+
+	cpu_emergency_unregister_virt_callback(svm_emergency_disable);
+}
+
 static int __init svm_init(void)
 {
 	int r;
@@ -5105,6 +5118,8 @@ static int __init svm_init(void)
 	if (r)
 		return r;
 
+	cpu_emergency_register_virt_callback(svm_emergency_disable);
+
 	/*
 	 * Common KVM initialization _must_ come last, after this, /dev/kvm is
 	 * exposed to userspace!
@@ -5117,14 +5132,14 @@ static int __init svm_init(void)
 	return 0;
 
 err_kvm_init:
-	kvm_x86_vendor_exit();
+	__svm_exit();
 	return r;
 }
 
 static void __exit svm_exit(void)
 {
 	kvm_exit();
-	kvm_x86_vendor_exit();
+	__svm_exit();
 }
 
 module_init(svm_init)
-- 
2.40.0.rc1.284.g88254d51c5-goog

