Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D273269159B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 01:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjBJAd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 19:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjBJAd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 19:33:26 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CD46E89B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 16:32:36 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id dt6-20020a17090afa4600b00230183006c3so1590069pjb.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 16:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=4YaSCxh91s2vz1Wx4zQx2zkw5Mb7VIy4t0nr1FfetkY=;
        b=Pb9YNrGhDlI/KkrCjvmq6aONc/k8rCIIOTcWwh32p6eVOtc2iLVErkwMmRxXmoJGWr
         4ovRCN8XSkgykLLXp0Nya9sUKwW/++zRSESKvzOrWF2AlS7ID5ZSoVelbRpB5nSBmrIy
         p885ziMNyde2KIuY0kcUsh7pg/ceJus5/PhPYdx275DUpIHm2+6ggVaYO3a0L+S43y3S
         090t7+Fw5NupHRJCmZXoF+mMaXk58RXbqONmq0KbDeRkBbfL1GgfWt6TDbfvti+uQruM
         pLCmoWg1VuLuY0SuX81xSlEyDi0RqmPmiq0CgfOHWiDT1U5snzXS/BwiyRg89eZbZwEc
         hJUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4YaSCxh91s2vz1Wx4zQx2zkw5Mb7VIy4t0nr1FfetkY=;
        b=ucA0eT4BEaQapKFYEwGGfRji7oAuUD/fC47yL8d8Tc1UOKwev9tneDBeZ1BrfcEzhZ
         o2xK/RFkiFYqmu57QCj17gJj92l9iAttyBJw9blo5WIsm7huio6UrCy/TlA82eofPFyb
         6MSkZESBH299UxsvxXbPkxUPv4EbRpF8F8vs2dK455XnbKOvP4hrivzzD79JumA3cBTa
         b/GDayxGXdqNsoruipy9ocsoKwv8SwGNLbmsBsBb6BZ+1Pv7n1BrERG+tG+p5uWjPunY
         R+epynaRZyTexXa/FdBeWgGWRRfB+HLb4Wvoc9hLsSfkOZKTT0mQdJDmpCyrOBoNaHZ8
         ileQ==
X-Gm-Message-State: AO0yUKWkTWgL3tXJde0Ee/oRbRAmwWWnYYrb8AVtawbwCXb9In6v2LT5
        heTVu7zM3/2ooVXHv9Vq4jlz3TvpQB8=
X-Google-Smtp-Source: AK7set9uyjb5MnG/k7yofyXGpLltrpGM7U4Uhuf+8OT8q+CXc3xORa++jsgQgEDOC3sNPp8HlPpWsq/17dc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a62:1c08:0:b0:590:762f:58bc with SMTP id
 c8-20020a621c08000000b00590762f58bcmr2799601pfc.50.1675989139088; Thu, 09 Feb
 2023 16:32:19 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Feb 2023 00:31:44 +0000
In-Reply-To: <20230210003148.2646712-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230210003148.2646712-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230210003148.2646712-18-seanjc@google.com>
Subject: [PATCH v2 17/21] KVM: selftests: Test post-KVM_RUN writes to PERF_CAPABILITIES
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Like Xu <like.xu.linux@gmail.com>
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

Now that KVM disallows changing PERF_CAPABILITIES after KVM_RUN, expand
the host side checks to verify KVM rejects any attempts to change bits
from userspace.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86_64/vmx_pmu_caps_test.c        | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
index 44fc6101a547..6fc86f5eba0b 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
@@ -85,6 +85,7 @@ static void test_guest_wrmsr_perf_capabilities(union perf_capabilities host_cap)
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 	struct ucall uc;
+	int r, i;
 
 	vm_init_descriptor_tables(vm);
 	vcpu_init_descriptor_tables(vcpu);
@@ -106,6 +107,18 @@ static void test_guest_wrmsr_perf_capabilities(union perf_capabilities host_cap)
 
 	ASSERT_EQ(vcpu_get_msr(vcpu, MSR_IA32_PERF_CAPABILITIES), host_cap.capabilities);
 
+	vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, host_cap.capabilities);
+
+	r = _vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, 0);
+	TEST_ASSERT(!r, "Post-KVM_RUN write '0' didn't fail");
+
+	for (i = 0; i < 64; i++) {
+		r = _vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES,
+				  host_cap.capabilities ^ BIT_ULL(i));
+		TEST_ASSERT(!r, "Post-KVM_RUN write '0x%llx'didn't fail",
+			    host_cap.capabilities ^ BIT_ULL(i));
+	}
+
 	kvm_vm_free(vm);
 }
 
-- 
2.39.1.581.gbfd45094c4-goog

