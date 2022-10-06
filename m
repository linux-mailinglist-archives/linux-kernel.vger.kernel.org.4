Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480185F5E1B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 02:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiJFAwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 20:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiJFAwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 20:52:02 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9615E667
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 17:51:49 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id m3-20020a170902bb8300b0017f7e7e4385so171215pls.20
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 17:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=pK5NCdlEIadGhwKNUMKI42SH4o68o3CwPkF8AVdNldE=;
        b=Cwb9U7wY0s//mF0o6CjO2bcOQ3EKdPE19pazk4DtB5cSJETIS9Z3ZS/S3P7RNFOo/X
         VmPyeGDRT2HP4HwT7n4D9LrPUL+SwcAwcVuPNJc+3x5cgzGQ9mbf5MN+cMLTS8XbckRw
         8i9VuWtVxWaSKDLfdeVUvEc0Sl0vnPGV6lSMv3jK7p+PL+o1zanBIcPxUxMAGmHREJKe
         yaTv/CCbWxplsF53f3E56Gd18SsoxloWSx5GoJf6mkwymth3qoYZtDcSE/98HO7RQaNL
         6ILyUfD0wBZFjnhLj5j511dVyT1DbVebRK5e3mOcSidqjN2yYBGqJc0YPGFxAn94Uc6t
         pYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pK5NCdlEIadGhwKNUMKI42SH4o68o3CwPkF8AVdNldE=;
        b=GzYkoA0G/JIANh6bGCX6LfIdR6tjT3KQYaN32PvfE81nSf5gnwag+nP464fO6Jpey3
         ytWk0fsvfEmmxEIEk091VnpwxUVhZLVKWd7hambOTLo9JPjWAkBb2jZhdu3CgX5KIlUs
         K0iCae7pQ40L1GVgycJ/TOgjD5bJXXvGPVQlltCzpkuLKwKsjWSMPtLI0mvnqr/Xvc3N
         MJl+Bf+DnC+DdXz80pSi7STMQHKWLFoa6ogNVPScFmKKKRocpOxvPMU/s1kjuyM4BM9t
         2u+JVLghWdRnRRkWhp967UePePQB3VZv0rQiq5r0YVAnGTnpe8okZYcuhzALL3rKb8br
         KuQw==
X-Gm-Message-State: ACrzQf0JiOUt7MRAY9h7fRKWRL/PpSRg4FVA2H2QnNcrvzxbzqQ9esxz
        +bc1Ug57UGZlVrH0GLE+dM0kNbf5Mi8=
X-Google-Smtp-Source: AMsMyM7B15qZMOTQaFApR/Oh9GbMqhWSCTCp5AxQySKKihYYxfaL6THBrWo6nM0d7Tm2gyjb+sQ9fQx9oWU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:e83:b0:561:54d5:a9c5 with SMTP id
 bo3-20020a056a000e8300b0056154d5a9c5mr2426885pfb.73.1665017508605; Wed, 05
 Oct 2022 17:51:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  6 Oct 2022 00:51:25 +0000
In-Reply-To: <20221006005125.680782-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221006005125.680782-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221006005125.680782-13-seanjc@google.com>
Subject: [PATCH 12/12] KVM: selftest: Drop helpers for getting specific KVM
 supported CPUID entry
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
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

Drop kvm_get_supported_cpuid_entry() and its inner helper now that all
known usage can use X86_FEATURE_*, X86_PROPERTY_*, X86_PMU_FEATURE_*, or
the dedicated Family/Model helpers.  Providing "raw" access to CPUID
leafs is undesirable as it encourages open coding CPUID checks, which is
often error prone and not self-documenting.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/include/x86_64/processor.h  | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 021c5f375158..9c4e1be21bd5 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -896,17 +896,6 @@ static inline void vcpu_clear_cpuid_feature(struct kvm_vcpu *vcpu,
 	vcpu_set_or_clear_cpuid_feature(vcpu, feature, false);
 }
 
-static inline const struct kvm_cpuid_entry2 *__kvm_get_supported_cpuid_entry(uint32_t function,
-									     uint32_t index)
-{
-	return get_cpuid_entry(kvm_get_supported_cpuid(), function, index);
-}
-
-static inline const struct kvm_cpuid_entry2 *kvm_get_supported_cpuid_entry(uint32_t function)
-{
-	return __kvm_get_supported_cpuid_entry(function, 0);
-}
-
 uint64_t vcpu_get_msr(struct kvm_vcpu *vcpu, uint64_t msr_index);
 int _vcpu_set_msr(struct kvm_vcpu *vcpu, uint64_t msr_index, uint64_t msr_value);
 
-- 
2.38.0.rc1.362.ged0d419d3c-goog

