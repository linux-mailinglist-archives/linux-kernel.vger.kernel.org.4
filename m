Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BF267A733
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 00:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbjAXXtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 18:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbjAXXtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 18:49:25 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E01A518E0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 15:49:21 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id x12-20020a17090abc8c00b0022bfadb3a4dso149669pjr.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 15:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=etFpX/482XpVxpk8+X7x9LZK6GHklrmOWmBG2Y9l9JY=;
        b=PaPFcjkY84c1BKENp3ubJyva/NBLjPo7sEgZagcT9qRPJXepm8n4k89Wf8MPHqwKV2
         xL2OgFZmaF2JpR1nfmxlaWEWDb0SwBh4jQ84r9tWNS3F4rOTph2CtS2Ud0rtf2oY/pk+
         65GpkRiNS+I9N4JGjXmB5WmUJe4XN0xc9GAjoJiJNVAMjRnWDoc2gK7HW6T6w8zwXL3O
         553HY1KeSy3AINSbZpAOVOFSwHpc2Tin9dHIK7KsOMQXnKKLDahp8tBeTiCMoPoChrwY
         5GpuYETk271PwyEYZ7xzfyOBnY6mgTYC88yDxdYQTM2LFZt6YibyDdBDND7jAHi3UFpA
         p4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=etFpX/482XpVxpk8+X7x9LZK6GHklrmOWmBG2Y9l9JY=;
        b=N3zeGFocWjhtczuFdwKNzGUFNHUJG/VjAeG3ZJ915KNdtBE9Kqlgy5vvuaIQLX5/i1
         ag9NWSdLuwO26HvDqlbHg4yuD0TxVn6r0sj/K74F0DtR6Em/CByQCdmDGQkCxMIuG0Sy
         DagUYkjbPvQF1c8XA/UOzfT1KJwvhds18CJFbZLdO2uceZ2Z8igLn3GQOj75egKekGep
         GjhYsYy7FdxocS7ch+x+8m+QTcjM7n4gOjQiGg23eC8WrYdUL0wrDFSQ2OKpvfSUPqTI
         5Nmv0aUAUsq/w2zENF0drlnJ0C8x3uSwxftTsPO/dLMb5VLyjYEPTFu9f0Wv9WR4vPb8
         vNvg==
X-Gm-Message-State: AO0yUKXGSfATNSIv9E+DkbHe2O2U8jxIPm8fUHsz0BamL6oNhmPUKq1g
        /ocCtTQGjqfj9Tleo9DndXC5ebzQ5BE=
X-Google-Smtp-Source: AK7set8SaE2MZIRg9LgmCIwbSkWZ/LgOB2ipKmhXTLetCVx/z8v1pT85QcQW4E3nEHJMgo6DIweuCZPB1ls=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:131e:0:b0:4d9:ed5e:5e99 with SMTP id
 i30-20020a63131e000000b004d9ed5e5e99mr11422pgl.69.1674604161397; Tue, 24 Jan
 2023 15:49:21 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 24 Jan 2023 23:49:04 +0000
In-Reply-To: <20230124234905.3774678-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230124234905.3774678-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230124234905.3774678-6-seanjc@google.com>
Subject: [PATCH 5/6] KVM: x86/pmu: Don't tell userspace to save MSRs for
 non-existent fixed PMCs
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aaron Lewis <aaronlewis@google.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Like Xu <likexu@tencent.com>
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

From: Like Xu <likexu@tencent.com>

Limit the set of MSRs for fixed PMU counters based on the number of fixed
counters actually supported by the host so that userspace doesn't waste
time saving and restoring dummy values.

Signed-off-by: Like Xu <likexu@tencent.com>
[sean: split for !enable_pmu logic, drop min(), write changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/x86.c              | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index cd0151e6af62..adb92fc4d7c9 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -514,6 +514,7 @@ struct kvm_pmc {
 #define MSR_ARCH_PERFMON_PERFCTR_MAX	(MSR_ARCH_PERFMON_PERFCTR0 + KVM_INTEL_PMC_MAX_GENERIC - 1)
 #define MSR_ARCH_PERFMON_EVENTSEL_MAX	(MSR_ARCH_PERFMON_EVENTSEL0 + KVM_INTEL_PMC_MAX_GENERIC - 1)
 #define KVM_PMC_MAX_FIXED	3
+#define MSR_ARCH_PERFMON_FIXED_CTR_MAX	(MSR_ARCH_PERFMON_FIXED_CTR0 + KVM_PMC_MAX_FIXED - 1)
 #define KVM_AMD_PMC_MAX_GENERIC	6
 struct kvm_pmu {
 	unsigned nr_arch_gp_counters;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 25da2cc09e55..3c49c86b973d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7055,6 +7055,11 @@ static void kvm_probe_msr_to_save(u32 msr_index)
 		    kvm_pmu_cap.num_counters_gp)
 			return;
 		break;
+	case MSR_ARCH_PERFMON_FIXED_CTR0 ... MSR_ARCH_PERFMON_FIXED_CTR_MAX:
+		if (msr_index - MSR_ARCH_PERFMON_FIXED_CTR0 >=
+		    kvm_pmu_cap.num_counters_fixed)
+			return;
+		break;
 	case MSR_IA32_XFD:
 	case MSR_IA32_XFD_ERR:
 		if (!kvm_cpu_cap_has(X86_FEATURE_XFD))
-- 
2.39.1.456.gfc5497dd1b-goog

