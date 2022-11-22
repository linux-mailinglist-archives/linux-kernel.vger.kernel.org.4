Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C658F6330C5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 00:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbiKUXkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 18:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbiKUXkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 18:40:33 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AD0C67CC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 15:40:33 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id a6-20020a170902ecc600b00186f035ed74so10352548plh.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 15:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5FAc41uak7V4S0p5RiUjDgCWZhDYnRWzhKZhqfKXil4=;
        b=XMdnfb0YgLN7WmgPCdeAVpGm2ClvIvjJ7QxQ4eKpOA9UmZvTDEV7sXbb8WlNxP0Wom
         lJ6Y5VhzeK7P3uuJVTpdy3ew+u1lcDGR9FuWNQY57OMQv0yg3RSpnIBn4VsGXGSj19Z8
         EryEezWhhawqfPZZQV9u3MzQk/vWrnhK/kKSA3+1fIXHlk+YyxxpNybwNd1ORC5H5x83
         TY3aGzsDFrcKZIsz8PBJaCY6cGuDre2ztFUqEla8/NpXchcxzBFw4QshSDpS4m2WPwuZ
         camofsf4qtNCeA0oUQwKErEsPig0ICFhAPTs1tOZemy5jYcHx31tcV72dvNO++xhZ/tH
         I+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5FAc41uak7V4S0p5RiUjDgCWZhDYnRWzhKZhqfKXil4=;
        b=JSWQwpbnd98ROVNlJqcMgqccB1ulG84zl6lcuk9c+0LKAPsw+oB+aCsB8kYx2ApKxm
         sUAVf58XwG+cZSt+w1y772wsGnlKdCEbKBO2A2HXWG/my6Vp9B52TeXqIyp76FGFmoKH
         f+GHkwvsHoI92l3trQiXCkY0YVKHQQg5t55t+mQWAVWG3BspWMBKRohLpyxanPmU0Jl8
         a3YcRKh1PtLLWIapGfnpZAcMldr2Jb8fD7hHqfAKHFVx6t1Jw11bc5ZQvPUi9GK6whiK
         UHF0joP+PoxjyEBD9T55xo/hlEGrU73ntBGsMhlNmGKBPQZYgxKzmCT3WVxu46TvxYe2
         1K5g==
X-Gm-Message-State: ANoB5plkjgCqVJnljsrO2E0a1VJf/cFXHM4AeFbmEKoL2ofuse9ygZKk
        opp/GZ3mPAdnwHSqi4UiGiHsn42pPziI
X-Google-Smtp-Source: AA0mqf6/0cj3G02GDWiZDiOMf+eg0GQ8KHBBOi7Qvz1ACUOpHEC1N+Le/vUSyAKY5SEpykgbmIa5lX3reMTK
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a62:5b43:0:b0:573:6cfc:2210 with SMTP id
 p64-20020a625b43000000b005736cfc2210mr3423492pfb.55.1669074032803; Mon, 21
 Nov 2022 15:40:32 -0800 (PST)
Date:   Mon, 21 Nov 2022 15:40:22 -0800
In-Reply-To: <20221121234026.3037083-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20221121234026.3037083-1-vipinsh@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221121234026.3037083-3-vipinsh@google.com>
Subject: [PATCH v2 2/6] KVM: x86: hyper-v: Add extended hypercall support in Hyper-v
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

Add support for extended hypercall in Hyper-v. Hyper-v TLFS 6.0b
describes hypercalls above call code 0x8000 as extended hypercalls.

A Hyper-v hypervisor's guest VM finds availability of extended
hypercalls via CPUID.0x40000003.EBX BIT(20). If the bit is set then the
guest can call extended hypercalls.

All extended hypercalls will exit to userspace by default. This allows
for easy support of future hypercalls without being dependent on KVM
releases.

If there will be need to process the hypercall in KVM instead of
userspace then KVM can create a capability which userspace can query to
know which hypercalls can be handled by the KVM and enable handling
of those hypercalls.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 arch/x86/kvm/hyperv.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 0b6964ed2e66..8551ef495cc9 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -43,6 +43,12 @@
 
 #define KVM_HV_MAX_SPARSE_VCPU_SET_BITS DIV_ROUND_UP(KVM_MAX_VCPUS, HV_VCPUS_PER_SPARSE_BANK)
 
+/*
+ * The TLFS carves out 64 possible extended hypercalls, numbered sequentially
+ * after the base capabilities extended hypercall.
+ */
+#define HV_EXT_CALL_MAX (HV_EXT_CALL_QUERY_CAPABILITIES + 64)
+
 static void stimer_mark_pending(struct kvm_vcpu_hv_stimer *stimer,
 				bool vcpu_kick);
 
@@ -2411,6 +2417,9 @@ static bool hv_check_hypercall_access(struct kvm_vcpu_hv *hv_vcpu, u16 code)
 	case HVCALL_SEND_IPI:
 		return hv_vcpu->cpuid_cache.enlightenments_eax &
 			HV_X64_CLUSTER_IPI_RECOMMENDED;
+	case HV_EXT_CALL_QUERY_CAPABILITIES ... HV_EXT_CALL_MAX:
+		return hv_vcpu->cpuid_cache.features_ebx &
+				HV_ENABLE_EXTENDED_HYPERCALLS;
 	default:
 		break;
 	}
@@ -2564,6 +2573,12 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 		}
 		goto hypercall_userspace_exit;
 	}
+	case HV_EXT_CALL_QUERY_CAPABILITIES ... HV_EXT_CALL_MAX:
+		if (unlikely(hc.fast)) {
+			ret = HV_STATUS_INVALID_PARAMETER;
+			break;
+		}
+		goto hypercall_userspace_exit;
 	default:
 		ret = HV_STATUS_INVALID_HYPERCALL_CODE;
 		break;
@@ -2722,6 +2737,7 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 
 			ent->ebx |= HV_POST_MESSAGES;
 			ent->ebx |= HV_SIGNAL_EVENTS;
+			ent->ebx |= HV_ENABLE_EXTENDED_HYPERCALLS;
 
 			ent->edx |= HV_X64_HYPERCALL_XMM_INPUT_AVAILABLE;
 			ent->edx |= HV_FEATURE_FREQUENCY_MSRS_AVAILABLE;
-- 
2.38.1.584.g0f3c55d4c2-goog

