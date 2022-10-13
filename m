Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FE95FD900
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 14:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiJMMOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 08:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiJMMNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 08:13:50 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E833FAA79
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 05:13:48 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id k19-20020a056a00135300b0054096343fc6so1129718pfu.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 05:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W0XCXGnUdg2SY4SlBEuTZRqi3g7wdYiLHgqiL1Ekay4=;
        b=qfuhOnPKPiE9nOPmxpWDofvLE1v/HBJRVx5sRm7TU0Tq9N/cBxEHqYygbL24hz9fwH
         vaOHCNa0EkhEx5ahAJ0RSJX2N+1c3KnE5h5zZ0eT0owPqCHiM63pOMCY+oIa1VF/Prvg
         QHR/8vheeM6Vg+Ntpf1Dpc9PNamQMsjGygzXafnJ6oe6s67Qy5ed/c3Fb4tNRLru8kL5
         5yPBFzhj+1Ls4aQOVOFNT9pALR7PyYRRzfKVXgCssZv4ppXlDZhtpvNXRoq+GoLXnkB9
         thINxy5uzUKts0Rh/R+JS8TmGC8I+tx+X04TDfIbYMWfeWXvEn9qjct8JFigQFqXRSrC
         E/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W0XCXGnUdg2SY4SlBEuTZRqi3g7wdYiLHgqiL1Ekay4=;
        b=MuVl6KMhDWxL/ElGoCzvElFWR5x5m1CXn5laTEkyp3RESw2uS5mV5n9Bnjhcnd9cX+
         eEYUA1HbfkQfsjyg9vo+iIojJaFrMNoItKMXEvduzX8SdstCPAmRNwkER2nBunlE5wb7
         Yfc1Xm7HaME1qEsDid8c0/usbNiCk1G2j0gdNiP0OknnNKcrBR33+xQQt0EXuk9jdAZT
         d64rASnn1cpMX+gNy7nhbXCPg+9n+PH5clbNljw536je42FTzX28DGKNH5d/W/z4l353
         3V+YVR+16mSwFAmM1Kkoys02jhLPyucqCUVwvB3OYGW6KTvtDo342LsWhtgx/8EQMana
         WH/Q==
X-Gm-Message-State: ACrzQf202+M6iu6wP+C6s0cnHWfwks8KsbZpUmShzhMltydg7ifAVw9E
        qMbTRx1AExCYNFThTfR4eyg381ZQSphoT/ea
X-Google-Smtp-Source: AMsMyM4CXgKQYiXi35Q2EyafFwGegezMKHTZjMpyuh0AJSxFNytMm4d9sz4PBEryRifR8rV4nONSmN41UZA2tgNr
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a17:902:f708:b0:178:9b70:310b with SMTP
 id h8-20020a170902f70800b001789b70310bmr33951512plo.65.1665663227656; Thu, 13
 Oct 2022 05:13:47 -0700 (PDT)
Date:   Thu, 13 Oct 2022 12:13:17 +0000
In-Reply-To: <20221013121319.994170-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20221013121319.994170-1-vannapurve@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221013121319.994170-3-vannapurve@google.com>
Subject: [V3 PATCH 2/4] KVM: selftests: Add arch specific initialization
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, shuah@kernel.org, bgardon@google.com,
        seanjc@google.com, oupton@google.com, peterx@redhat.com,
        vkuznets@redhat.com, dmatlack@google.com,
        Vishal Annapurve <vannapurve@google.com>
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

Introduce arch specific API: kvm_selftest_arch_init to allow each arch to
handle initialization before running any selftest logic.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 .../selftests/kvm/include/kvm_util_base.h      |  5 +++++
 .../selftests/kvm/lib/aarch64/processor.c      | 18 +++++++++---------
 tools/testing/selftests/kvm/lib/kvm_util.c     |  6 ++++++
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index e42a09cd24a0..eec0e4898efe 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -838,4 +838,9 @@ static inline int __vm_disable_nx_huge_pages(struct kvm_vm *vm)
 	return __vm_enable_cap(vm, KVM_CAP_VM_DISABLE_NX_HUGE_PAGES, 0);
 }
 
+/*
+ * API to execute architecture specific setup before executing main().
+ */
+void kvm_selftest_arch_init(void);
+
 #endif /* SELFTEST_KVM_UTIL_BASE_H */
diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
index 6f5551368944..0de4aabc0c76 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
@@ -495,15 +495,6 @@ void aarch64_get_supported_page_sizes(uint32_t ipa,
 	close(kvm_fd);
 }
 
-/*
- * arm64 doesn't have a true default mode, so start by computing the
- * available IPA space and page sizes early.
- */
-void __attribute__((constructor)) init_guest_modes(void)
-{
-       guest_modes_append_default();
-}
-
 void smccc_hvc(uint32_t function_id, uint64_t arg0, uint64_t arg1,
 	       uint64_t arg2, uint64_t arg3, uint64_t arg4, uint64_t arg5,
 	       uint64_t arg6, struct arm_smccc_res *res)
@@ -528,3 +519,12 @@ void smccc_hvc(uint32_t function_id, uint64_t arg0, uint64_t arg1,
 		       [arg4] "r"(arg4), [arg5] "r"(arg5), [arg6] "r"(arg6)
 		     : "x0", "x1", "x2", "x3", "x4", "x5", "x6", "x7");
 }
+
+void kvm_selftest_arch_init(void)
+{
+	/*
+	 * arm64 doesn't have a true default mode, so start by computing the
+	 * available IPA space and page sizes early.
+	 */
+	guest_modes_append_default();
+}
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 37d7d144c74e..deb4c731b9fa 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -2022,8 +2022,14 @@ void __vm_get_stat(struct kvm_vm *vm, const char *stat_name, uint64_t *data,
 	}
 }
 
+__weak void kvm_selftest_arch_init(void)
+{
+}
+
 void __attribute((constructor)) kvm_selftest_init(void)
 {
 	/* Tell stdout not to buffer its content. */
 	setbuf(stdout, NULL);
+
+	kvm_selftest_arch_init();
 }
-- 
2.38.0.rc1.362.ged0d419d3c-goog

