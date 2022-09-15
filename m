Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFAF5B9179
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 02:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiIOAFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 20:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiIOAFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 20:05:16 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768F012D25
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 17:05:07 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id a16-20020a170902ecd000b001782ec09870so7399755plh.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 17:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=EMYMZKY/iGQIa3JbZzMfxs2+dRoXVRV6AgQCLEGivNg=;
        b=SKQoQmMvyzj6768UP8KES0UGW6Xnv8ko48tcNOa6IbyMbxEl0YhsbKvyqMLfnSaKfl
         deamK916iD3NTrVLtCTkm12Mv7J4/xB1kIrgbMi9hhIffdeFRoCzrWSIQYxOSIrpdqDy
         FAFvWUQ75HUlqniZBOVcm6JWob7h/iMO5UG3XpEMd6rsI9Ys+aKQn5rIo/oz57fi8U5q
         7baFSeo3wuk/mDAvJr83FVxbC3b9OrDhqZ/d+A21HRcKBJ2Cp+Xi4YswGI6HDC1XEvrJ
         kC0iT1x24CvvdmzG1pH8lV3gvkiYgvegubznE1s69M3M7DSi2owSwCB7NxRTWudJzuEA
         CCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=EMYMZKY/iGQIa3JbZzMfxs2+dRoXVRV6AgQCLEGivNg=;
        b=maKESA9JtcADkEsOvL2Svi/u0oWamB1HesRN9p8R/uBK2R5WEchxc0Z1eN1zngAOWe
         T3ufwv3RGg7CPHROc8pczAkQHQAdIg3UBoGiI3A8T0HwLAkxPjCNikJ8K8OAtyj1O8b5
         BX1tUTszWCgWZV6KoPMHkvvWfJzqMfMOvg+MaHkcbCa2cQ1TdlWbHBccI0JUMyMy5w4E
         va7gJp56Ic/tTtU9MjwnEKYGaYpVeYc2IGIL7tV7US13OfcdNeHaSdhZB4FnDMvBU45l
         m5NAneyur6ihzfVEyCh/tIPJrEBIUS0+YFmr/zottDmE3p8U9ZzByM+0lv3aevhN2L5P
         BU7Q==
X-Gm-Message-State: ACgBeo2iFKY/WnSXcCwqNCfdEZQBx7obuSBTMUR10wRaCAGO5LjkZ1OT
        ibBwnSoEEdFRGelb7uUQpNiMO4rexY7gAHeR
X-Google-Smtp-Source: AA6agR7/1ZFORcwZpWMCn29kzEp4zuJU5BpWSxKndEtwG7dvrtDU8Qy27Oa7QgaBUKG4z97q+TmmbVu7qdC22psN
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a63:8843:0:b0:439:3c8e:c2c0 with SMTP
 id l64-20020a638843000000b004393c8ec2c0mr9651931pgd.404.1663200307191; Wed,
 14 Sep 2022 17:05:07 -0700 (PDT)
Date:   Thu, 15 Sep 2022 00:04:47 +0000
In-Reply-To: <20220915000448.1674802-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20220915000448.1674802-1-vannapurve@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220915000448.1674802-8-vannapurve@google.com>
Subject: [V2 PATCH 7/8] Kvm: selftests: x86: Execute cpu specific vmcall instruction
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the vmcall instruction invocation to happen according to the cpu
type.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 tools/testing/selftests/kvm/include/x86_64/processor.h    | 8 ++++++++
 tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c | 2 +-
 .../selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c    | 2 +-
 tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c  | 2 +-
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 18a8a6a2b786..74893a7a80f8 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -833,6 +833,14 @@ void vm_set_page_table_entry(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
 uint64_t kvm_hypercall(uint64_t nr, uint64_t a0, uint64_t a1, uint64_t a2,
 		       uint64_t a3);
 
+/*
+ * Execute vmcall instruction.
+ */
+static inline void vmcall(void)
+{
+	kvm_hypercall(0, 0, 0, 0, 0);
+}
+
 void nested_guest_vmcall(void);
 
 void __vm_xsave_require_permission(int bit, const char *name);
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c b/tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c
index 5abecf06329e..8180711c8684 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c
@@ -31,7 +31,7 @@
 static void l2_guest_code(void)
 {
 	/* Exit to L1 */
-	__asm__ __volatile__("vmcall");
+	vmcall();
 }
 
 static void l1_guest_code(struct vmx_pages *vmx_pages, unsigned long high_gpa)
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c b/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c
index 465a9434d61c..37da9d01d5d6 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c
@@ -76,7 +76,7 @@ static void l2_guest_code(void)
 	check_tsc_freq(UCHECK_L2);
 
 	/* exit to L1 */
-	__asm__ __volatile__("vmcall");
+	vmcall();
 }
 
 static void l1_guest_code(struct vmx_pages *vmx_pages)
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c b/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
index 5943187e8594..00192f564d9b 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
@@ -74,7 +74,7 @@ static void l2_guest_code(void)
 	check_ia32_tsc_adjust(-2 * TSC_ADJUST_VALUE);
 
 	/* Exit to L1 */
-	__asm__ __volatile__("vmcall");
+	vmcall();
 }
 
 static void l1_guest_code(struct vmx_pages *vmx_pages)
-- 
2.37.2.789.g6183377224-goog

