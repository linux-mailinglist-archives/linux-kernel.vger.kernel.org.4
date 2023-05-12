Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6127012B1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 01:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241304AbjELXv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 19:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241047AbjELXuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 19:50:51 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC7C9EFA
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:50:44 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-559ffd15df9so171524397b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683935443; x=1686527443;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=XrP26l12dblklnP33ZoJ42tkdCuUxCksg2I7hVQj90o=;
        b=t3l3UThP2dJQk781dgfm6ckxPk0wInH63kNwS1OxOB5doCeMhOaQ3QCXkQXvuUOA22
         f500PigbQpIBdH2L/iV9XKXKmJBE5MSuSvQPGDjtyzUbExUbv/sIzHHFD8tUjK52BCI0
         Y+UQneyRIAprJu6zNMgiQ7+5VC9LUoyyAgYLFz2IPzVqdrQFmyu7zqrD528/W/QvjSCz
         p4IyB3q3+NIIppbhu+S9j9P4m/QenC8u7xxgvihHzvBMezKm8ffOtRi3dn9ayb6slaPk
         NqjANNiGDzr1vrweDks4SWJ6Xs/zvvsU82qGHDybQx1cmHSVayh1VoU3yVv/OeK3VYc5
         vipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683935443; x=1686527443;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XrP26l12dblklnP33ZoJ42tkdCuUxCksg2I7hVQj90o=;
        b=JqJfkYrUXBU6WKbNfhjM6maDL6ycs7wvIwXmLfu5RyPphWhGGSnmhq09RFqKaJyBao
         HrII/A4irOdW4A8hR1dWJplBrUnQGscI9nqcYxtYhH66em6/cdlZ/TIUU1YzEURzVZbj
         tRrBOyjqHIZz46fQIS4BNU9FyFyNBUCvzftjhUy0EEmHX6IFqAYo+DqyDle/vmQA5+zy
         bKILQUXNm+uHnAs4OS1EA01jYXxgILdSJN2JC3UUVXbxTNLxAkgHWjrsACo26pAIh0of
         7AJcs5ROZRay542WBF5adqTJHrjZPcnQu15uER6DO4VmY0spVmBBeswiFlzQ175S8SNb
         aBoQ==
X-Gm-Message-State: AC+VfDxSa0yQhDk32E1lDo0kPwzl2iZ9VckqyUQTIJm6vBlvsK1JZ/Be
        +lMMzjX2M9w05zH/vL2OC3VAsTf5o78=
X-Google-Smtp-Source: ACHHUZ6M2e4Ssla5r6FTjmFpHe6ltl5bE07hk4DQg/mz/hvAn1S6vuXVAqtyoscKHvcT/LmMkGccQQCY/Ak=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:c70a:0:b0:55d:6af3:1e2c with SMTP id
 m10-20020a81c70a000000b0055d6af31e2cmr15498070ywi.3.1683935443126; Fri, 12
 May 2023 16:50:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 12 May 2023 16:50:15 -0700
In-Reply-To: <20230512235026.808058-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230512235026.808058-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230512235026.808058-8-seanjc@google.com>
Subject: [PATCH v3 07/18] x86/reboot: Hoist "disable virt" helpers above
 "emergency reboot" path
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Kai Huang <kai.huang@intel.com>, Chao Gao <chao.gao@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the various "disable virtualization" helpers above the emergency
reboot path so that emergency_reboot_disable_virtualization() can be
stubbed out in a future patch if neither KVM_INTEL nor KVM_AMD is enabled,
i.e. if there is no in-tree user of CPU virtualization.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/reboot.c | 90 ++++++++++++++++++++--------------------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index fddfea5f1d20..493d66e59a4f 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -529,6 +529,51 @@ static inline void kb_wait(void)
 
 static inline void nmi_shootdown_cpus_on_restart(void);
 
+/* RCU-protected callback to disable virtualization prior to reboot. */
+static cpu_emergency_virt_cb __rcu *cpu_emergency_virt_callback;
+
+void cpu_emergency_register_virt_callback(cpu_emergency_virt_cb *callback)
+{
+	if (WARN_ON_ONCE(rcu_access_pointer(cpu_emergency_virt_callback)))
+		return;
+
+	rcu_assign_pointer(cpu_emergency_virt_callback, callback);
+}
+EXPORT_SYMBOL_GPL(cpu_emergency_register_virt_callback);
+
+void cpu_emergency_unregister_virt_callback(cpu_emergency_virt_cb *callback)
+{
+	if (WARN_ON_ONCE(rcu_access_pointer(cpu_emergency_virt_callback) != callback))
+		return;
+
+	rcu_assign_pointer(cpu_emergency_virt_callback, NULL);
+	synchronize_rcu();
+}
+EXPORT_SYMBOL_GPL(cpu_emergency_unregister_virt_callback);
+
+/*
+ * Disable virtualization, i.e. VMX or SVM, to ensure INIT is recognized during
+ * reboot.  VMX blocks INIT if the CPU is post-VMXON, and SVM blocks INIT if
+ * GIF=0, i.e. if the crash occurred between CLGI and STGI.
+ */
+void cpu_emergency_disable_virtualization(void)
+{
+	cpu_emergency_virt_cb *callback;
+
+	/*
+	 * IRQs must be disabled as KVM enables virtualization in hardware via
+	 * function call IPIs, i.e. IRQs need to be disabled to guarantee
+	 * virtualization stays disabled.
+	 */
+	lockdep_assert_irqs_disabled();
+
+	rcu_read_lock();
+	callback = rcu_dereference(cpu_emergency_virt_callback);
+	if (callback)
+		callback();
+	rcu_read_unlock();
+}
+
 static void emergency_reboot_disable_virtualization(void)
 {
 	local_irq_disable();
@@ -785,54 +830,9 @@ void machine_crash_shutdown(struct pt_regs *regs)
 }
 #endif
 
-/* RCU-protected callback to disable virtualization prior to reboot. */
-static cpu_emergency_virt_cb __rcu *cpu_emergency_virt_callback;
-
-void cpu_emergency_register_virt_callback(cpu_emergency_virt_cb *callback)
-{
-	if (WARN_ON_ONCE(rcu_access_pointer(cpu_emergency_virt_callback)))
-		return;
-
-	rcu_assign_pointer(cpu_emergency_virt_callback, callback);
-}
-EXPORT_SYMBOL_GPL(cpu_emergency_register_virt_callback);
-
-void cpu_emergency_unregister_virt_callback(cpu_emergency_virt_cb *callback)
-{
-	if (WARN_ON_ONCE(rcu_access_pointer(cpu_emergency_virt_callback) != callback))
-		return;
-
-	rcu_assign_pointer(cpu_emergency_virt_callback, NULL);
-	synchronize_rcu();
-}
-EXPORT_SYMBOL_GPL(cpu_emergency_unregister_virt_callback);
-
 /* This is the CPU performing the emergency shutdown work. */
 int crashing_cpu = -1;
 
-/*
- * Disable virtualization, i.e. VMX or SVM, to ensure INIT is recognized during
- * reboot.  VMX blocks INIT if the CPU is post-VMXON, and SVM blocks INIT if
- * GIF=0, i.e. if the crash occurred between CLGI and STGI.
- */
-void cpu_emergency_disable_virtualization(void)
-{
-	cpu_emergency_virt_cb *callback;
-
-	/*
-	 * IRQs must be disabled as KVM enables virtualization in hardware via
-	 * function call IPIs, i.e. IRQs need to be disabled to guarantee
-	 * virtualization stays disabled.
-	 */
-	lockdep_assert_irqs_disabled();
-
-	rcu_read_lock();
-	callback = rcu_dereference(cpu_emergency_virt_callback);
-	if (callback)
-		callback();
-	rcu_read_unlock();
-}
-
 #if defined(CONFIG_SMP)
 
 static nmi_shootdown_cb shootdown_callback;
-- 
2.40.1.606.ga4b1b128d6-goog

