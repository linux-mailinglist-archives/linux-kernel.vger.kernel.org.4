Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3182563FC0A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 00:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbiLAX2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 18:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbiLAX2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 18:28:19 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1CFCE42A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 15:27:24 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id pq17-20020a17090b3d9100b0020a4c65c3a9so2979944pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 15:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=V7jdLGRYb4fYAe8gIednP3AKBH7dhOuHWBQtK2IRaKg=;
        b=KrMJ/BgpveA+ly1uPiZ5pmidqkhZDKpo9w6VWcD7XE8wIMwUuj1AJO76QyHhE2cKtS
         fXybiajbUEedKZgAFffo2ZyWwqwKal5Dnjj7p8KuOscMWR6HqsJPbrVng9W73l8xn/JC
         ZL9LolusjV6VhRGkyJCW+JVCE84j6ZEov6ayjdEu0Vrl9FkK9P2cBQJpoT5E6Gg6gCj+
         2GofqL0ci/dwuU7kkQjlqIrBEMIdnnA7PYjgGDlItNlYmOKBYD6mX0OvSsazv2Tk+KWk
         uedUB3yAu9UsKRydgGMByIJR44IN6hPSNidlDqpGjlWz4XY4+r4ez9xqiCX/DBRay83y
         IIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V7jdLGRYb4fYAe8gIednP3AKBH7dhOuHWBQtK2IRaKg=;
        b=7psv2eJPmUclubX+AlwbM97QrIAF1BQaRMPXto/pUfidaH4g4Uj3dRM/AMI+FIRhYF
         E4BMzcHDxNX/Krd1M2m1O9ydjsWuuGufBoBJhlDHVfWvLYNQyAWTfyoQkr3Wc2iOotsC
         hTM05D/rum1MG/UXBq055qYSdMgU+bItyLJY/zJpdxy1PiZvb5y4JXXXO5CEkNtP2MMl
         5tuRmgQIORlnnxHlsmlc/n7TcJQMVe/rAJ3xo1LHO+Ghzh7Nd9XZ1sUhWCPFx65zpdwQ
         ssdnDJxrxOnHVnHlidrtOiJIsDiE+vG2DXhr08LwVUxI3B9RoExNssTJD6WmtOo3QRiO
         NQJA==
X-Gm-Message-State: ANoB5pl3xmS54OIxBXxhee52KsIAYhiUFHukpFJiNPV6zT+gQDxifKcy
        4VzF0QrXjFvlnrI6CNoN34RrHKUcuFs=
X-Google-Smtp-Source: AA0mqf5OFUH4655YN7eGM/9Hpu4YrVFA8Z2vIAGHjTZvYAFUwFrrMer4WU/8uTn6DvxYUwdjKm0nDRy8wCw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:aa7:9ec2:0:b0:575:d302:7443 with SMTP id
 r2-20020aa79ec2000000b00575d3027443mr10995163pfq.76.1669937244071; Thu, 01
 Dec 2022 15:27:24 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  1 Dec 2022 23:26:52 +0000
In-Reply-To: <20221201232655.290720-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221201232655.290720-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221201232655.290720-14-seanjc@google.com>
Subject: [PATCH 13/16] x86/virt: KVM: Open code cpu_has_svm() into kvm_is_svm_supported()
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fold the guts of cpu_has_svm() into kvm_is_svm_supported(), its sole
remaining user.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/virtext.h | 28 ----------------------------
 arch/x86/kvm/svm/svm.c         | 11 ++++++++---
 2 files changed, 8 insertions(+), 31 deletions(-)

diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
index eddc0eeb836f..683d20411335 100644
--- a/arch/x86/include/asm/virtext.h
+++ b/arch/x86/include/asm/virtext.h
@@ -22,35 +22,7 @@
 /*
  * SVM functions:
  */
-
-/** Check if the CPU has SVM support
- *
- * You can use the 'msg' arg to get a message describing the problem,
- * if the function returns zero. Simply pass NULL if you are not interested
- * on the messages; gcc should take care of not generating code for
- * the messages on this case.
- */
-static inline int cpu_has_svm(const char **msg)
-{
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
-	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON) {
-		if (msg)
-			*msg = "not amd or hygon";
-		return 0;
-	}
-
-	if (!boot_cpu_has(X86_FEATURE_SVM)) {
-		if (msg)
-			*msg = "svm not available";
-		return 0;
-	}
-	return 1;
-}
-
-
 /** Disable SVM on the current CPU
- *
- * You should call this only if cpu_has_svm() returned true.
  */
 static inline void cpu_svm_disable(void)
 {
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index d56d5fe42262..ba281651dee4 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -523,11 +523,16 @@ static void svm_init_osvw(struct kvm_vcpu *vcpu)
 static bool kvm_is_svm_supported(void)
 {
 	int cpu = raw_smp_processor_id();
-	const char *msg;
 	u64 vm_cr;
 
-	if (!cpu_has_svm(&msg)) {
-		pr_err("SVM not supported by CPU %d, %s\n", cpu, msg);
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON) {
+		pr_err("CPU %d isn't AMD or Hygon\n", cpu);
+		return false;
+	}
+
+	if (!boot_cpu_has(X86_FEATURE_SVM)) {
+		pr_err("SVM not supported by CPU %d\n", cpu);
 		return false;
 	}
 
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

