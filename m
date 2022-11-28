Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A749F63B511
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 23:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbiK1W57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 17:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbiK1W5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 17:57:50 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B555824BFD
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 14:57:46 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id a33-20020a630b61000000b00429d91cc649so7508806pgl.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 14:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=mddWw5jKkHynMjtMRFmmyuPdlM0MlcX7j/7PK75k6Fw=;
        b=A8Bw/jcyude8mvJeyhvG0HWYCaDtNd8TCZ6n1g+c8b3ghSqGvHqMqrYXPH8VP556mb
         E6r9KGnHMz46viuiQHZd+W+VUVk/Ed97KOP9/S0l3TWyM/dw+1zfeUHsANfc4GpLfWLm
         bLl5tgvc0l+h44FLiGvDF3XQAsJAmXvBVTXukyk7Cvwed/c65p4SSpM2kKuf055xHzZW
         Mecs//0a0jHnt2Z8GkK9RDlsCCK1jYdU0VWPCOu1uZlJRbFewEiBv9o+Bdf1uXK8PfgV
         hy7SINcNdFlAwW7KTa7jBLGDMc/un7zWUtmtuO0kzdE6zMdmoaAXWOjRzR/quqs/yXF/
         t4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mddWw5jKkHynMjtMRFmmyuPdlM0MlcX7j/7PK75k6Fw=;
        b=PXbCOeQ/E3+UiAcQimqp1leM4LMkLtprvHci3bEiWCMvPUkIF7KTGe7/Xwi2VZlD/L
         Q7ssfZoVannhAB2GwNx9JjNkhnzyOj3Hr4d0dnaE/9O4nm1Gv9LXvvAXbN33eVpKEEb6
         z2YN943OgHQI8+clWZZ2mHK3M6gNNV4KxEepqT5NAzdbL6MhBXaGKCnoveEsPKT30oSX
         5EMns/oDbzzz5snOI4jg2+nGtlg7PWbz7L8bCGoYixIVNOACeUySCna+qhPTuWx+ctu0
         YpLaQNVWgNewFm0Gta1AlZ3xef1XZL+29aqn2t8Qnc//DDQeqq19H5agO/62jP/623Ir
         97zw==
X-Gm-Message-State: ANoB5pkDvShVIGjroe6cewhwn8ElhhgVJknUKgT61sez/Kt5AB/8/jAi
        DDArq/f0MrP9J7CobcCyIZmydCJBUy4=
X-Google-Smtp-Source: AA0mqf75QNoz0uFUxUkbOt2QBaSZk0y7e+IggdUQyFCPqIir30jBIikAqa5KY0RwSyhBWysxfyKExE86MiU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:3c04:b0:218:4b47:9c29 with SMTP id
 pb4-20020a17090b3c0400b002184b479c29mr55128611pjb.54.1669676266304; Mon, 28
 Nov 2022 14:57:46 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Mon, 28 Nov 2022 22:57:35 +0000
In-Reply-To: <20221128225735.3291648-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221128225735.3291648-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221128225735.3291648-5-seanjc@google.com>
Subject: [PATCH v2 4/4] KVM: selftests: Do kvm_cpu_has() checks before
 creating VM+vCPU
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lei Wang <lei4.wang@intel.com>,
        Sean Christopherson <seanjc@google.com>
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

Move the AMX test's kvm_cpu_has() checks before creating the VM+vCPU,
there are no dependencies between the two operations.  Opportunistically
add a comment to call out that enabling off-by-default XSAVE-managed
features must be done before KVM_GET_SUPPORTED_CPUID is cached.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86_64/amx_test.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
index 1256c7faadd3..bd72c6eb3b67 100644
--- a/tools/testing/selftests/kvm/x86_64/amx_test.c
+++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
@@ -249,17 +249,21 @@ int main(int argc, char *argv[])
 	u32 amx_offset;
 	int stage, ret;
 
+	/*
+	 * Note, all off-by-default features must be enabled before anything
+	 * caches KVM_GET_SUPPORTED_CPUID, e.g. before using kvm_cpu_has().
+	 */
 	vm_xsave_require_permission(XSTATE_XTILE_DATA_BIT);
 
-	/* Create VM */
-	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
-
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_XFD));
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_XSAVE));
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_AMX_TILE));
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_XTILECFG));
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_XTILEDATA));
 
+	/* Create VM */
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+
 	TEST_ASSERT(kvm_cpu_has_p(X86_PROPERTY_XSTATE_MAX_SIZE),
 		    "KVM should enumerate max XSAVE size when XSAVE is supported");
 	xsave_restore_size = kvm_cpu_property(X86_PROPERTY_XSTATE_MAX_SIZE);
-- 
2.38.1.584.g0f3c55d4c2-goog

