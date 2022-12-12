Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A26B64A73F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 19:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbiLLSij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 13:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbiLLShm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 13:37:42 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955BE29F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:37:40 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id u15-20020a170902e5cf00b001899d29276eso11124618plf.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AQIHU7oFJzfN/dD6MjFy5Gqv9IoHRNmGXG4ddL/MsoE=;
        b=WZDTp5uHSLJqlVqV7BsnAygUubdknMcQxot4GSHCGt3kDvVaGTS5iwHIZaa+KHHOD+
         E0fScrJ9kFGJ5yGajKLeL7D6jiQSjkKICmzpbB2fxH+8MZpRY0Ho4p5Bn5WuRqgekZZC
         G1eeE7pEdWgfx2P7ylueHxelrEwP5Gog/R8nKds+Zi7kKsHWpPMxUYEXgC9zSRSSru8q
         Q92QHA+M3D0svZUKyV6pK6QnTRdKWicJuMh6rqM0/7nWtkw0QA+rk7a8HtRtoN9ucGKv
         wEtbnGLTRRBnOrWXjAJfnlerqZHWtJeEGj80PqCqsmPT8Lsz49gv6vS17ePpQoa6VAJn
         Dv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AQIHU7oFJzfN/dD6MjFy5Gqv9IoHRNmGXG4ddL/MsoE=;
        b=YouNuG4N585EDcVouTWXLo574VnnX3y3WFGwXsVyqdC8zSvQsX2yiYuds+dFBhXMCD
         2RNX3ojvTzfcxLr6Jhxzr3HBydqdjbv2ueGhfyd5PpwIOOi95+eq/Z0oX2A9G0HePhvR
         fhQGI367h9oqwWsDfUotLqHrLGeDo5XTg8hoOmswTwlrj4hLn5NFd2fSiAQ92R1Qdwpw
         vqhl5YueQ/odTCRDqGJ7Yq67oOeaydoKc2oTlpVGg+uhBwDnWkv3GxEF0oqNR0e7+DZT
         7CMnIlVCZGoDm/tdPwga07hty/7PAuv1LZLr74YaOAsUCv4/Z+L02N1khG0PBFUTAckr
         jiGw==
X-Gm-Message-State: ANoB5pnPvahPxrhOe/vusbw/4H6a0TZcbSaX3bY0p7TE6arwui7lJNIt
        ScQMAjjvgjzs2FAqDJBekvGCl04k9PpA
X-Google-Smtp-Source: AA0mqf4cERvubxOpWA/x9PbxZimApwZ4/pDD7woS2SB2MbN7JS4TAWw2g2l3Tw7Rx4PtfCZ8UOmBXnYatQ88
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a17:90a:fa46:b0:200:1df3:a7a9 with SMTP id
 dt6-20020a17090afa4600b002001df3a7a9mr108504791pjb.202.1670870260194; Mon, 12
 Dec 2022 10:37:40 -0800 (PST)
Date:   Mon, 12 Dec 2022 10:37:17 -0800
In-Reply-To: <20221212183720.4062037-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20221212183720.4062037-1-vipinsh@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221212183720.4062037-11-vipinsh@google.com>
Subject: [Patch v4 10/13] KVM: selftests: Test Hyper-V extended hypercall enablement
From:   Vipin Sharma <vipinsh@google.com>
To:     seanjc@google.com, pbonzini@redhat.com, vkuznets@redhat.com,
        dmatlack@google.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vipin Sharma <vipinsh@google.com>
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

Test Hyper-V extended hypercall, HV_EXT_CALL_QUERY_CAPABILITIES
(0x8001), access denied and invalid parameter
cases.

Access is denied if CPUID.0x40000003.EBX BIT(20) is not set.
Invalid parameter if call has fast bit set.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 tools/testing/selftests/kvm/include/x86_64/hyperv.h  | 5 +++++
 tools/testing/selftests/kvm/x86_64/hyperv_features.c | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/hyperv.h b/tools/testing/selftests/kvm/include/x86_64/hyperv.h
index 28eb99046475..fa65b908b13e 100644
--- a/tools/testing/selftests/kvm/include/x86_64/hyperv.h
+++ b/tools/testing/selftests/kvm/include/x86_64/hyperv.h
@@ -137,6 +137,8 @@
 	KVM_X86_CPU_FEATURE(HYPERV_CPUID_FEATURES, 0, EBX, 11)
 #define HV_CPU_MANAGEMENT			\
 	KVM_X86_CPU_FEATURE(HYPERV_CPUID_FEATURES, 0, EBX, 12)
+#define HV_ENABLE_EXTENDED_HYPERCALLS		\
+	KVM_X86_CPU_FEATURE(HYPERV_CPUID_FEATURES, 0, EBX, 20)
 #define HV_ISOLATION				\
 	KVM_X86_CPU_FEATURE(HYPERV_CPUID_FEATURES, 0, EBX, 22)
 
@@ -213,6 +215,9 @@
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
 
+/* Extended hypercalls */
+#define HV_EXT_CALL_QUERY_CAPABILITIES		0x8001
+
 #define HV_FLUSH_ALL_PROCESSORS			BIT(0)
 #define HV_FLUSH_ALL_VIRTUAL_ADDRESS_SPACES	BIT(1)
 #define HV_FLUSH_NON_GLOBAL_MAPPINGS_ONLY	BIT(2)
diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_features.c b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
index 258267df8e2a..c5e3b39edd07 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_features.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
@@ -649,6 +649,15 @@ static void guest_test_hcalls_access(void)
 			hcall->expect = HV_STATUS_SUCCESS;
 			break;
 		case 19:
+			hcall->control = HV_EXT_CALL_QUERY_CAPABILITIES;
+			hcall->expect = HV_STATUS_ACCESS_DENIED;
+			break;
+		case 20:
+			vcpu_set_cpuid_feature(vcpu, HV_ENABLE_EXTENDED_HYPERCALLS);
+			hcall->control = HV_EXT_CALL_QUERY_CAPABILITIES | HV_HYPERCALL_FAST_BIT;
+			hcall->expect = HV_STATUS_INVALID_PARAMETER;
+			break;
+		case 21:
 			kvm_vm_free(vm);
 			return;
 		}
-- 
2.39.0.rc1.256.g54fd8350bd-goog

