Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF4263B510
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 23:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbiK1W54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 17:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbiK1W5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 17:57:45 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A27C1D331
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 14:57:45 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id pi2-20020a17090b1e4200b0021834843687so12942610pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 14:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=xELzf4EoZMDlLUFpchpTMdst44hVrjj4VfJq2w9Ep4g=;
        b=tfGq1I9Ag4TRomwGArbD/e7Y8OTucyzeGIBpiuBA8HCvwovRyzZMr0jL1essdKJxRl
         AsLiTHBqMnFPfYFL6W6Gg7mrjwghkx+mm5CkL9sermoxxif5geNncKOnzhv9WJMna7+6
         EPztlMnA0Oomg6EENpjW8lYY6HTV4pMsV6RsBaky6LIIuYQSC81VQlR7T/MBuaYTWxpQ
         f5UDgsfX+NOHM+75d9ZexrzlpgZuMggqW0WB5v/Wh074p4fD/QcK7Gu/EJn7qY53pFPB
         GawhLmEMkaB82ICjvMdzs3LpOgwabZXU5VPUQVxNfTlONzJDpAGPE3cFsxOXcyO0tlwn
         4clQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xELzf4EoZMDlLUFpchpTMdst44hVrjj4VfJq2w9Ep4g=;
        b=VjX9hLOnbfhY5H2/SLVONYdDelavIfJMYRCPPpG0c1qMAYAWwSWTiZbTU/e9GUV7Hm
         scuCMFDtVbYJipaxRBv+1Ou1E5MwnRvwSARiVcSM/JgAGDQjA8nVtg5evaJao42K3Bcc
         w38Ju87ae5QcDCV9912UOliTf4XZET+W6/c0dt5yBg0ZKXnEj82eFN4K0n65ucQcud+c
         tPklcmcXOBLFFnyhdfewEJnj24VKGZnlKUgSl1p7y6ixW3HFT8ImUhWwVmXsP236mCMK
         yGrE7Lv6NQ3Q05Za5wTGoVXhCO9dGFu73/vDxvUi7aYW3ZPKmga7A8XjF9D78LPaTy1n
         FEtg==
X-Gm-Message-State: ANoB5pmt/K3wJNoMHxfR4ermMNd+Ks8/eoEnwdiX50N+6p9LbYG+nAzb
        OGokGIsNE8Eo7NZLJb5Izcq69FHxnjQ=
X-Google-Smtp-Source: AA0mqf7XlYSOiBUAPxiV1JPp5qojEVpBxwXB4xMCDPs7V/2pUAuGBNrlhEa8A1+VJ8AZPriNzHDsDb7tf1Y=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:820c:b0:189:505b:73dd with SMTP id
 x12-20020a170902820c00b00189505b73ddmr26974391pln.143.1669676264666; Mon, 28
 Nov 2022 14:57:44 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Mon, 28 Nov 2022 22:57:34 +0000
In-Reply-To: <20221128225735.3291648-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221128225735.3291648-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221128225735.3291648-4-seanjc@google.com>
Subject: [PATCH v2 3/4] KVM: selftests: Disallow "get supported CPUID" before REQ_XCOMP_GUEST_PERM
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lei Wang <lei4.wang@intel.com>,
        Sean Christopherson <seanjc@google.com>
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

Disallow using kvm_get_supported_cpuid() and thus caching KVM's supported
CPUID info before enabling XSAVE-managed features that are off-by-default
and must be enabled by ARCH_REQ_XCOMP_GUEST_PERM.  Caching the supported
CPUID before all XSAVE features are enabled can result in false negatives
due to testing features that were cached before they were enabled.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/lib/x86_64/processor.c       | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 23067465c035..1d3829e652e6 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -601,21 +601,24 @@ void vcpu_arch_free(struct kvm_vcpu *vcpu)
 		free(vcpu->cpuid);
 }
 
+/* Do not use kvm_supported_cpuid directly except for validity checks. */
+static void *kvm_supported_cpuid;
+
 const struct kvm_cpuid2 *kvm_get_supported_cpuid(void)
 {
-	static struct kvm_cpuid2 *cpuid;
 	int kvm_fd;
 
-	if (cpuid)
-		return cpuid;
+	if (kvm_supported_cpuid)
+		return kvm_supported_cpuid;
 
-	cpuid = allocate_kvm_cpuid2(MAX_NR_CPUID_ENTRIES);
+	kvm_supported_cpuid = allocate_kvm_cpuid2(MAX_NR_CPUID_ENTRIES);
 	kvm_fd = open_kvm_dev_path_or_exit();
 
-	kvm_ioctl(kvm_fd, KVM_GET_SUPPORTED_CPUID, cpuid);
+	kvm_ioctl(kvm_fd, KVM_GET_SUPPORTED_CPUID,
+		  (struct kvm_cpuid2 *)kvm_supported_cpuid);
 
 	close(kvm_fd);
-	return cpuid;
+	return kvm_supported_cpuid;
 }
 
 static uint32_t __kvm_cpu_has(const struct kvm_cpuid2 *cpuid,
@@ -684,6 +687,9 @@ void __vm_xsave_require_permission(int bit, const char *name)
 		.addr = (unsigned long) &bitmask
 	};
 
+	TEST_ASSERT(!kvm_supported_cpuid,
+		    "kvm_get_supported_cpuid() cannot be used before ARCH_REQ_XCOMP_GUEST_PERM");
+
 	kvm_fd = open_kvm_dev_path_or_exit();
 	rc = __kvm_ioctl(kvm_fd, KVM_GET_DEVICE_ATTR, &attr);
 	close(kvm_fd);
-- 
2.38.1.584.g0f3c55d4c2-goog

