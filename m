Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7432463FBF2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 00:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbiLAX1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 18:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbiLAX1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 18:27:06 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278B7C936E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 15:27:06 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-360b9418f64so31382377b3.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 15:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=mFvMnjrU77HgMpRAg1eTYLQtly5wyhFPGsQhVSSbZ5w=;
        b=V5XJwdVzMPCeeU5F81jrySi2kZlFiOI6k5hfWuJgTghq/nNMqUROcbCoQ2Kw7fcy9X
         W8O+jP6seA9KJMHoGJ9/YVtFsHsy0cIUOsqkCyq6Oy2MSK0Mnqn40ilb06qPFzmF7Am+
         KQL6aiFyJTMBvoRp2nKo8SVAkskXxp1Jo9eYWLZCls/BX3RtbCaly2db/iglPDSr89dy
         3vUbQXqsjnv0ir4Ybig8xjQm8VdBRsQYVQDbGy1zqVQ9ThmxiI7FGdbhEd8YSrOdhiZU
         FSouX07x6UQg5O6eoqeakdiQ4xJ8RbydrwhXPFSYgSPt523CIvApw91KwjJUL2OyCQHy
         K+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mFvMnjrU77HgMpRAg1eTYLQtly5wyhFPGsQhVSSbZ5w=;
        b=GZhOOJLWNtXSwP6+IOQPAmgEFZ/Gk1D1iZvbD8zSMNma/hz4tNNYMrx1lYqXNvgNdg
         CEwknAXY857GHm4TZzNrr0kGlefhjCbJHnVxNOCFPRQbmyNHrIUW7+mQO+tcswRNIsWX
         HuSNtL95QuYLfcVm84bDz0MBvDOFITHT0BFZ6GRrZ7W+cIJA75TWbSHKYqpe+zEA/0fi
         SXcGEtgWpzoC7n6UrIqdCbCGPR9gwLrQmFrcB2Y0nqDhqKcyrR4+WFZ2EuIhdOOO/9Gh
         7lBq7AB7CYkO47229kWMvhyV85rqs4XBtEnoxA54InLq1AvczMwb8v7dRjlgZSuPMVVQ
         WPsw==
X-Gm-Message-State: ANoB5pmOOKlIMwtQK7z6VJ6tdMl9ZZb4UQn3tOxVlPioeGaIuwMkOTcO
        /0aYIBimo2b9fuP9CS/njOOdhpuZL68=
X-Google-Smtp-Source: AA0mqf79z57qigftfqjOoAwDOx4hLTLhy5rle8a0vTN1wZ6IbqOJ6lc+iRHIpwb69JaoIziFNELYLBkrQDE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:4483:0:b0:6dc:ade6:e4a7 with SMTP id
 r125-20020a254483000000b006dcade6e4a7mr56531279yba.640.1669937225380; Thu, 01
 Dec 2022 15:27:05 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  1 Dec 2022 23:26:41 +0000
In-Reply-To: <20221201232655.290720-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221201232655.290720-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221201232655.290720-3-seanjc@google.com>
Subject: [PATCH 02/16] x86/reboot: Expose VMCS crash hooks if and only if
 KVM_INTEL is enabled
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Andrew Cooper <Andrew.Cooper3@citrix.com>
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

Expose the crash/reboot hooks used by KVM to do VMCLEAR+VMXOFF if and
only if there's a potential in-tree user, KVM_INTEL.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/reboot.h | 2 ++
 arch/x86/kernel/reboot.c      | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/reboot.h b/arch/x86/include/asm/reboot.h
index 2551baec927d..33c8e911e0de 100644
--- a/arch/x86/include/asm/reboot.h
+++ b/arch/x86/include/asm/reboot.h
@@ -25,8 +25,10 @@ void __noreturn machine_real_restart(unsigned int type);
 #define MRR_BIOS	0
 #define MRR_APM		1
 
+#if IS_ENABLED(CONFIG_KVM_INTEL)
 typedef void crash_vmclear_fn(void);
 extern crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
+#endif
 void cpu_emergency_disable_virtualization(void);
 
 typedef void (*nmi_shootdown_cb)(int, struct pt_regs*);
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 299b970e5f82..6c0b1634b884 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -787,6 +787,7 @@ void machine_crash_shutdown(struct pt_regs *regs)
 }
 #endif
 
+#if IS_ENABLED(CONFIG_KVM_INTEL)
 /*
  * This is used to VMCLEAR all VMCSs loaded on the
  * processor. And when loading kvm_intel module, the
@@ -807,6 +808,7 @@ static inline void cpu_crash_vmclear_loaded_vmcss(void)
 		do_vmclear_operation();
 	rcu_read_unlock();
 }
+#endif
 
 /* This is the CPU performing the emergency shutdown work. */
 int crashing_cpu = -1;
@@ -818,7 +820,9 @@ int crashing_cpu = -1;
  */
 void cpu_emergency_disable_virtualization(void)
 {
+#if IS_ENABLED(CONFIG_KVM_INTEL)
 	cpu_crash_vmclear_loaded_vmcss();
+#endif
 
 	cpu_emergency_vmxoff();
 	cpu_emergency_svm_disable();
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

