Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0579C6B570E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjCKAsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjCKArl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:47:41 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5AC13E09F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:47:01 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id q9-20020a17090a9f4900b00237d026fc55so5074561pjv.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678495606;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=BZgH5Eee9L8XSMp14xmQcQyAmW1Ng+mM4Frav4M8BP8=;
        b=oDfm8RGtJfI416/t8hlaquI6QMoR4wxUzcfw6CKhAB2RBWVCL1SmwemdG8vpnF0CvJ
         fTTbQ0GLnEmQu0zQit5uGQpAoptSfwIFDikvaKmcaL6Va2UHNeAaiHC0Z4BcJmZOZfTO
         jhzLwFGgVX2F+/EsIT9Eq7SRgoWWEjvqKQaBuJxOT9dygHJr2lA8S02HV4MZyCISAYCf
         ur2XGdzNAYMdzrdlbqm+iIL4ORLD3I3vgYWnRSXVlYByRIOVpHdALznIuIol5S+BOmoJ
         Xc/oZ9OVUT9VFxlbC065IBwR1FtzkcBcdr99jtBgmkEU10VeljeEb/9awajBkPtOCoIZ
         u5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678495606;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BZgH5Eee9L8XSMp14xmQcQyAmW1Ng+mM4Frav4M8BP8=;
        b=FFAUozViXRLlfiF+VvMHzLGaSFrfQF6xxqZRZ9a7QSSF1lmqt4zJrOzMZrzFxkZQRo
         XBOfUvqkT+s5MOW1iejwpAwTnXwqtu2sbBFvprzSejDfHkLgIdFt9gsT1tqd0BLyTAsi
         5vZoIh5AZrCVWSAAV1xJVzjTwfqIyU71M45eiIUnmydsWdRgXJ+wLGMJ76TDB1FreNcd
         bE7BEwtJ5hgQlo5K21JGeQ/OPOAAi2OEzIZgCH+MN3NwNNwpsyS9M6qyA5GazKVDdDoh
         sUcWDlvYoS8hcgd0GZ5sP3xMMp8MpCSMuTY+/QnztLjtZzb60BfpHkctBvWK97gsv+k0
         YbPA==
X-Gm-Message-State: AO0yUKXcOnjsP/PJkxGpoKR51/3gVINXRmNF5X/N7l5c7NdBNxsEQj6O
        1XNa4wa4pYDd6iSLyqSP0oDExBHe0dw=
X-Google-Smtp-Source: AK7set867AijtX5RzA06gfubmn9RP+tWssyGJSUx8tZ1dOGPMWCKp7lIg0JZVqgZpd5zDJQme4rN9dz4xQ4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:a80c:0:b0:4fc:2369:811 with SMTP id
 o12-20020a63a80c000000b004fc23690811mr8981769pgf.6.1678495606218; Fri, 10 Mar
 2023 16:46:46 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Mar 2023 16:46:10 -0800
In-Reply-To: <20230311004618.920745-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230311004618.920745-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230311004618.920745-14-seanjc@google.com>
Subject: [PATCH v3 13/21] KVM: selftests: Drop now-redundant checks on
 PERF_CAPABILITIES writes
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>
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

Now that vcpu_set_msr() verifies the expected "read what was wrote"
semantics of all durable MSRs, including PERF_CAPABILITIES, drop the
now-redundant manual checks in the VMX PMU caps test.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
index 035470b38400..f7a27b5c949b 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
@@ -51,10 +51,7 @@ static void test_basic_perf_capabilities(union perf_capabilities host_cap)
 	struct kvm_vm *vm = vm_create_with_one_vcpu(&vcpu, NULL);
 
 	vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, 0);
-	ASSERT_EQ(vcpu_get_msr(vcpu, MSR_IA32_PERF_CAPABILITIES), 0);
-
 	vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, host_cap.capabilities);
-	ASSERT_EQ(vcpu_get_msr(vcpu, MSR_IA32_PERF_CAPABILITIES), host_cap.capabilities);
 
 	kvm_vm_free(vm);
 }
@@ -67,9 +64,6 @@ static void test_fungible_perf_capabilities(union perf_capabilities host_cap)
 	/* testcase 1, set capabilities when we have PDCM bit */
 	vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, PMU_CAP_FW_WRITES);
 
-	/* check capabilities can be retrieved with KVM_GET_MSR */
-	ASSERT_EQ(vcpu_get_msr(vcpu, MSR_IA32_PERF_CAPABILITIES), PMU_CAP_FW_WRITES);
-
 	/* check whatever we write with KVM_SET_MSR is _not_ modified */
 	vcpu_run(vcpu);
 	ASSERT_EQ(vcpu_get_msr(vcpu, MSR_IA32_PERF_CAPABILITIES), PMU_CAP_FW_WRITES);
-- 
2.40.0.rc1.284.g88254d51c5-goog

