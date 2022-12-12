Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DE464A746
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 19:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbiLLSi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 13:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbiLLShj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 13:37:39 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12324614F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:37:38 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id z12-20020a17090abd8c00b0021a0a65a7e2so453324pjr.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ocUPVz8ANM21EwPfg3tXA9E2skPDsvTTK6JWONirGoA=;
        b=JxzKtapsPiPTDLxMGnXHtcuPc/3a2vdU1jztHn7/Dbo+KqCwm5TEIWr5lEAvNGjzfP
         hLjnmKj0t9g7tdCps8hlYta2ObsB7zdCyrhLeJ00xOOG+f3aQR27mNlm1U3HSX0XUGEz
         6FSa0S53usUm4cJNpXeWRFAjeUVgdNqOLQWXT1IIYGq+V9XHak9G1cjMerDJebE/modI
         YJlo3+DiHIHH6/tv3KyYu6NMmZhHgEBL6ALxnbHWYdP2ZEHfQic4FHbScTFZAbSbSVUY
         /slW6dPoyl9+z5xhvIVM0k1nWXRsewQKV3dcz3Z50nU2K37JWITMTbmN/Fvbg7urK/FZ
         wIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ocUPVz8ANM21EwPfg3tXA9E2skPDsvTTK6JWONirGoA=;
        b=iHlk/5B+XxQTLRFjxjCNB2LhvZp2FWBa7xTF4efkZlCMai7CuBYLgCf/mctUTunqTm
         xP2g1OslDZSnhLiAI6iNR+GN/iODAz4O5aIEGbxDjLmaIgT35z0JQoe0GwfXl8ZZlwUJ
         LIO2lHbbyYbAWuhPdJw64hFYc2GbYDm/WTpnCV6pkqhzv8+zIpejsUffL9vk6yq2ALsM
         Tr2FNpq8pA0v8TkaHEavfj/gJIEFnhan1Ddg8pwrFIeVG07rNjtggTotxvjRvL45c2GH
         cSu+yV2CT7z3ne7tTM5UckHelOXEUZCcTMz5WZDVIfEL0AyiDN4eTlFT2ws7QAgqBQ5p
         9L2g==
X-Gm-Message-State: ANoB5pnlV50nVRVa8EELzdz3ec0CeAYiIPqr1ZZEpDNZtRiKrR4Tdutz
        MHjVLknY/RQaJauD0EWMk5R6EeedEqeL
X-Google-Smtp-Source: AA0mqf79uqNPfzIfWoUMpQcM4MXW7aQVy4foX+HZz7Lc/dkJOGMNXt5KpD404Edg4OCbwPrs1zHrO4U7azoo
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a62:b501:0:b0:563:771d:417f with SMTP id
 y1-20020a62b501000000b00563771d417fmr79842609pfe.45.1670870258540; Mon, 12
 Dec 2022 10:37:38 -0800 (PST)
Date:   Mon, 12 Dec 2022 10:37:16 -0800
In-Reply-To: <20221212183720.4062037-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20221212183720.4062037-1-vipinsh@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221212183720.4062037-10-vipinsh@google.com>
Subject: [Patch v4 09/13] KVM: x86: hyper-v: Add extended hypercall support in Hyper-v
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
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

---
 arch/x86/kvm/hyperv.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 2eb68533d188..e232ea578ba5 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -43,6 +43,24 @@
 
 #define KVM_HV_MAX_SPARSE_VCPU_SET_BITS DIV_ROUND_UP(KVM_MAX_VCPUS, HV_VCPUS_PER_SPARSE_BANK)
 
+/*
+ * As per Hyper-V TLFS, extended hypercalls start from 0x8001
+ * (HvExtCallQueryCapabilities). Response of this hypercalls is a 64 bit value
+ * where each bit tells which extended hypercall is available besides
+ * HvExtCallQueryCapabilities.
+ *
+ * 0x8001 - First extended hypercall, HvExtCallQueryCapabilities, no bit
+ * assigned.
+ *
+ * 0x8002 - Bit 0
+ * 0x8003 - Bit 1
+ * ..
+ * 0x8041 - Bit 63
+ *
+ * Therefore, HV_EXT_CALL_MAX = 0x8001 + 64
+ */
+#define HV_EXT_CALL_MAX (HV_EXT_CALL_QUERY_CAPABILITIES + 64)
+
 static void stimer_mark_pending(struct kvm_vcpu_hv_stimer *stimer,
 				bool vcpu_kick);
 
@@ -2429,6 +2447,9 @@ static bool hv_check_hypercall_access(struct kvm_vcpu_hv *hv_vcpu, u16 code)
 	case HVCALL_SEND_IPI:
 		return hv_vcpu->cpuid_cache.enlightenments_eax &
 			HV_X64_CLUSTER_IPI_RECOMMENDED;
+	case HV_EXT_CALL_QUERY_CAPABILITIES ... HV_EXT_CALL_MAX:
+		return hv_vcpu->cpuid_cache.features_ebx &
+				HV_ENABLE_EXTENDED_HYPERCALLS;
 	default:
 		break;
 	}
@@ -2582,6 +2603,12 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
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
@@ -2741,6 +2768,7 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 
 			ent->ebx |= HV_POST_MESSAGES;
 			ent->ebx |= HV_SIGNAL_EVENTS;
+			ent->ebx |= HV_ENABLE_EXTENDED_HYPERCALLS;
 
 			ent->edx |= HV_X64_HYPERCALL_XMM_INPUT_AVAILABLE;
 			ent->edx |= HV_FEATURE_FREQUENCY_MSRS_AVAILABLE;
-- 
2.39.0.rc1.256.g54fd8350bd-goog

