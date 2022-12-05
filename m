Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F916431A5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 20:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbiLETQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 14:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbiLETO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 14:14:58 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6868C24098
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 11:14:57 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id pa16-20020a17090b265000b0020a71040b4cso9999752pjb.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 11:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qpcu40Z65aIWPgdWtWitreL8dzv6E0For4q80D5q0A8=;
        b=o1ZwNp+TVUnzwOTQGfvxg8k9vzOyRcmiMJdhNK+MvpT087QL7OKz9TGAaR9VPQgr6Q
         d3qZkATtZh409FvS8z+TQoDXmcZ5jU1obvmJKF9QKg8dSMzNSF2leoJ2J1Me+Ww7jUda
         0+MfTeK7DsCdc0KOGY0j4mwFFqSMywcMLAWMWtf3P28z3xHTGXRlImQNMkfRxSCpNjWc
         0oR5WxyNwY7agmii/hpOCX5tn4meZ5CZnON6BRn4+jhSAe1xSkGP212NKzUCtsD5/I8X
         apK5hk1UJJa2G42r28J2Cr6vwQ2RRJsTcvhIaI/JxX7Rfr4PCwzb4D4nQftwIcl74cN2
         5KJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qpcu40Z65aIWPgdWtWitreL8dzv6E0For4q80D5q0A8=;
        b=2Ia39Mm3gAPGErBewlIQdDMISUtpmm+3Wp1OlOxvH8XbVPHkb+qbE7vBPivVlk7j35
         tFlTd0bwvqBeeFm8et7R0c2T3HwgXuwRYE60feoxJcP+dPHuEZMGQWbZxn4tH3CZi2Mx
         DO+FNL8cLBpB4SbZCeFL6ITJ4E2xpnXJTlzTg/69tfK1aUhR/f4nUCdO69dkMKCIRufB
         wzscFGy7/juah50wW4iVnp0VjZ7s3Rggkn0NptcQenoJQhhTqIsQFadkJGuapGUKFmu3
         TBkKf/EvNbO4DSGk3Csw6KPzx+HIj8TkSpEYsL0DaGKqLtCkoMj2DNe4s4nSQ//KlYqQ
         bVQg==
X-Gm-Message-State: ANoB5plfWfzOZXy17ptyvjNl41UP/k/8rZUBSXLba347LtnIrk2J4Ykg
        MY5qneW+4dWnhijyc0LNKbqn3V0K0fYX
X-Google-Smtp-Source: AA0mqf6azcwmd1/8Be+Nf7xTNojIQkGJhX0Mxsqk6j9RQRBmUC00l7XgDClwdtlccGhkSwVMoClWuO/rEaz0
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a17:90a:43a4:b0:219:1d0a:34a6 with SMTP id
 r33-20020a17090a43a400b002191d0a34a6mr4722506pjg.1.1670267696658; Mon, 05 Dec
 2022 11:14:56 -0800 (PST)
Date:   Mon,  5 Dec 2022 11:14:27 -0800
In-Reply-To: <20221205191430.2455108-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20221205191430.2455108-1-vipinsh@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221205191430.2455108-11-vipinsh@google.com>
Subject: [Patch v3 10/13] KVM: selftests: Test Hyper-V extended hypercall enablement
From:   Vipin Sharma <vipinsh@google.com>
To:     seanjc@google.com, pbonzini@redhat.com, vkuznets@redhat.com,
        dmatlack@google.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vipin Sharma <vipinsh@google.com>
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
2.39.0.rc0.267.gcb52ba06e7-goog

