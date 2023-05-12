Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDAAD7012B5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 01:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241494AbjELXvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 19:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241229AbjELXvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 19:51:23 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80493D2E2
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:50:47 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-52c6c5dc988so5385956a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683935447; x=1686527447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=lyO1h6O2hb1pX3gn73w8KZmEZqmVC2QRk75jhJzJfVE=;
        b=wYkLcQKCZAyiB+e+wRWpBW2sIHjDWES7SvFhMvvMkN06r8GJlzTrfxA4MZ7jTRcfER
         c/Wu+zs1epFfWscax+7n5JjFNFNjbpf7P3l5WaZVpw1BuCcD1uchmQZUNlq5qjybJOVu
         9GLMHNfZUgePcRtV97872noY/g9bokUnvt5KgW805N/ymGUTa79KMO4dkXik1Is2h8so
         cl6Oq6CWj5W7cw1SgoCtW4pmgGHhj7f70oQId5TEdEDIzXoumgvytWGMlB6wVA/EDBQa
         Bwex+LWzuVC6lJAzrVfsEN6/ElMdSdDEA0Y8Kx7ByzyCKklfW8gkn9FZEWZAfq5g7LJ8
         KKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683935447; x=1686527447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lyO1h6O2hb1pX3gn73w8KZmEZqmVC2QRk75jhJzJfVE=;
        b=Q3+sTEqJPFO9AJKz0rv6DxtyssbyENTflyfPTXc1IZZcwQKKo9vuerQw8DlP/pJGRy
         q7R5daG1BqkCmfRqzYch8t/pXLF7Jhjy4p60gqs7Eu0Z/fb28Ir5EqrM0MBdsnMvbkS9
         N8T83mPHJKMGmrkB31wX9BLMpFlGDgZyTRuOsnryk0zc/fD45cx0JoT8sh1V4iyiykcg
         Qb/ZqYw2ri0Wek0WyatWn2e0Gr2qzpYSbJlAqQh7nQMtg0Rh0ZKkPXqyQYLF4Bi6CSY4
         S+if7ubRcRowlKcvhMv3mZcnKAV+BDyOlMIU4quSN9XFc7oIpM5mMJZNHWG9CdOdqGUz
         HRIg==
X-Gm-Message-State: AC+VfDwaP9x+uyREAM+agVgJo0UjWgq+YkcBZ1vwzpNnO2mFx4KOVzpM
        XGN9X62v6tEcJ3waoi10rN6zbzVLiu8=
X-Google-Smtp-Source: ACHHUZ6pQB3SGwwZM/VN0XltNzg7WZNvA7eV4Dzb40H6hnaJ0k54EUK2xrUWfHHCqVRIGMwVF3mIjLXXV38=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:5f54:0:b0:51b:3c11:fb17 with SMTP id
 t81-20020a635f54000000b0051b3c11fb17mr684496pgb.12.1683935446804; Fri, 12 May
 2023 16:50:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 12 May 2023 16:50:17 -0700
In-Reply-To: <20230512235026.808058-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230512235026.808058-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230512235026.808058-10-seanjc@google.com>
Subject: [PATCH v3 09/18] x86/virt: KVM: Open code cpu_has_vmx() in KVM VMX
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

Fold the raw CPUID check for VMX into kvm_is_vmx_supported(), its sole
user.  Keep the check even though KVM also checks X86_FEATURE_VMX, as the
intent is to provide a unique error message if VMX is unsupported by
hardware, whereas X86_FEATURE_VMX may be clear due to firmware and/or
kernel actions.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/virtext.h | 10 ----------
 arch/x86/kvm/vmx/vmx.c         |  2 +-
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
index aaed66249ccf..b1171a5ad452 100644
--- a/arch/x86/include/asm/virtext.h
+++ b/arch/x86/include/asm/virtext.h
@@ -22,14 +22,6 @@
 /*
  * VMX functions:
  */
-
-static inline int cpu_has_vmx(void)
-{
-	unsigned long ecx = cpuid_ecx(1);
-	return test_bit(5, &ecx); /* CPUID.1:ECX.VMX[bit 5] -> VT */
-}
-
-
 /**
  * cpu_vmxoff() - Disable VMX on the current CPU
  *
@@ -61,8 +53,6 @@ static inline int cpu_vmx_enabled(void)
 }
 
 /** Disable VMX if it is enabled on the current CPU
- *
- * You shouldn't call this if cpu_has_vmx() returns 0.
  */
 static inline void __cpu_emergency_vmxoff(void)
 {
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 76cdb189f1b5..f44f93772b4f 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2721,7 +2721,7 @@ static bool kvm_is_vmx_supported(void)
 {
 	int cpu = raw_smp_processor_id();
 
-	if (!cpu_has_vmx()) {
+	if (!(cpuid_ecx(1) & feature_bit(VMX))) {
 		pr_err("VMX not supported by CPU %d\n", cpu);
 		return false;
 	}
-- 
2.40.1.606.ga4b1b128d6-goog

