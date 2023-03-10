Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525436B52FD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 22:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjCJVmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 16:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjCJVmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 16:42:44 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B6E130C00
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:42:43 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id m9-20020a170902db0900b0019ea0e227e4so3427598plx.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678484563;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=m9B074ZWiEHZYM5cOwoFqQdD3ATusTMpSAjOh2gg06o=;
        b=Xi0LdulpSAj5xMQpDvfavN0f/y7xMY/kjeHiUUYhU2XVndRnwmBBUtQboHMhjo6cNN
         ZyCsDsTxXx8CQ8td4o51Kroke1ngCZCjZ8UwITBNeFUI+az9fmxHSh/AwPKonTDo1VQK
         uNgTRlSSucxi/QlCB0o912iZP2u6754DtJk+ZKN8ScdL+MdhE0DC+HPJxVVLDbZoi2bP
         vDUScLT584Qza/HDtme1czgDS5a8e9HgWQF11yJG7pcFCqR4onL/85xnciWUaLlQWKCx
         C1gbODJnvg5RuJf9QtfEHMaXIad15rTqI2a7tfN7rspYr5D3otXBgC/gSY1qEPEpHPD7
         iiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678484563;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m9B074ZWiEHZYM5cOwoFqQdD3ATusTMpSAjOh2gg06o=;
        b=IQuGfa/SlRKxX+ltezDqSeSB7Se1b0vG6UJmqV5KvhTwtxGX0qPpSvhTMbnh5zeiXu
         aFsYaB5Ny9S4YI8njyc4CA3N3Ssq3Igr7TJv1qfddLNOBk6/j/2n/259efQlVQ8eDGqC
         zcG2Dg7ejEPEOAdzmUO597yUGfdnPY4bXLmr5ijG6XYFsyzxRM4v77nzjURN64JVXCim
         OMRIWve6hmfoQCgD81Kquk2WdV+kyGGnEyNs2dtTz3qih1F/riDwS12R2hAwkI2EQIpZ
         BEHvbGrUISshnyQxfhxUvgunlPdjU0NIGZwWiVjlAivFgg2pyp+AWgtKjtkEM+9soF+T
         w3vQ==
X-Gm-Message-State: AO0yUKVhHYlz7oCa2iDpnLye0yezgp0M0Wk5uqgRfS4j7jfXSsZ/+vie
        WrE+zgUIOYIafxgn/uMJa0HYkYhpBOI=
X-Google-Smtp-Source: AK7set9ji6/BQh9z47m7QssioXbRDOMCgUULIOrEXFNjR/pD1Kdx3OKxzf+8QXKZ9QwOB4Lfq/5HQ6MtV1E=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:3312:b0:19d:756:d99c with SMTP id
 jk18-20020a170903331200b0019d0756d99cmr10284912plb.1.1678484563343; Fri, 10
 Mar 2023 13:42:43 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Mar 2023 13:42:17 -0800
In-Reply-To: <20230310214232.806108-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230310214232.806108-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230310214232.806108-4-seanjc@google.com>
Subject: [PATCH v2 03/18] x86/reboot: Harden virtualization hooks for
 emergency reboot
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

Provide dedicated helpers to (un)register virt hooks used during an
emergency crash/reboot, and WARN if there is an attempt to overwrite
the registered callback, or an attempt to do an unpaired unregister.

Opportunsitically use rcu_assign_pointer() instead of RCU_INIT_POINTER(),
mainly so that the set/unset paths are more symmetrical, but also because
any performance gains from using RCU_INIT_POINTER() are meaningless for
this code.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/reboot.h |  5 +++--
 arch/x86/kernel/reboot.c      | 30 ++++++++++++++++++++++++------
 arch/x86/kvm/vmx/vmx.c        |  6 ++----
 3 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/reboot.h b/arch/x86/include/asm/reboot.h
index 33c8e911e0de..1d098a7d329a 100644
--- a/arch/x86/include/asm/reboot.h
+++ b/arch/x86/include/asm/reboot.h
@@ -26,8 +26,9 @@ void __noreturn machine_real_restart(unsigned int type);
 #define MRR_APM		1
 
 #if IS_ENABLED(CONFIG_KVM_INTEL)
-typedef void crash_vmclear_fn(void);
-extern crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
+typedef void (cpu_emergency_virt_cb)(void);
+void cpu_emergency_register_virt_callback(cpu_emergency_virt_cb *callback);
+void cpu_emergency_unregister_virt_callback(cpu_emergency_virt_cb *callback);
 #endif
 void cpu_emergency_disable_virtualization(void);
 
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 6c0b1634b884..78182b2969db 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -795,17 +795,35 @@ void machine_crash_shutdown(struct pt_regs *regs)
  *
  * protected by rcu.
  */
-crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
-EXPORT_SYMBOL_GPL(crash_vmclear_loaded_vmcss);
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
 
 static inline void cpu_crash_vmclear_loaded_vmcss(void)
 {
-	crash_vmclear_fn *do_vmclear_operation = NULL;
+	cpu_emergency_virt_cb *callback;
 
 	rcu_read_lock();
-	do_vmclear_operation = rcu_dereference(crash_vmclear_loaded_vmcss);
-	if (do_vmclear_operation)
-		do_vmclear_operation();
+	callback = rcu_dereference(cpu_emergency_virt_callback);
+	if (callback)
+		callback();
 	rcu_read_unlock();
 }
 #endif
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 302086255be6..41095fc864f3 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8551,8 +8551,7 @@ static void __vmx_exit(void)
 {
 	allow_smaller_maxphyaddr = false;
 
-	RCU_INIT_POINTER(crash_vmclear_loaded_vmcss, NULL);
-	synchronize_rcu();
+	cpu_emergency_unregister_virt_callback(crash_vmclear_local_loaded_vmcss);
 
 	vmx_cleanup_l1d_flush();
 }
@@ -8602,8 +8601,7 @@ static int __init vmx_init(void)
 		pi_init_cpu(cpu);
 	}
 
-	rcu_assign_pointer(crash_vmclear_loaded_vmcss,
-			   crash_vmclear_local_loaded_vmcss);
+	cpu_emergency_register_virt_callback(crash_vmclear_local_loaded_vmcss);
 
 	vmx_check_vmcs12_offsets();
 
-- 
2.40.0.rc1.284.g88254d51c5-goog

