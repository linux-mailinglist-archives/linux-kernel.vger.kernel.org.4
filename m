Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1D96330CA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 00:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbiKUXkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 18:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbiKUXkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 18:40:35 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D78C67FA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 15:40:34 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id z9-20020a17090ab10900b00218c5bdfd55so1235559pjq.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 15:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z3BKge990LyaSwx4wBUBWy5aVHpLudxzVwQwi9XYB0g=;
        b=jejR1zqGTm3dW3QnYjQ3stJgSkQwyk45fdJuAXR+mlc/EtaBUVJ/llafE6+cFBnjhR
         gb5+Y+ofuU5bgN086X2Y6sIIsf+08i/4KWnFWz2o5AF09bQNKqMbk+B9Ev5VG9E4MFFR
         gpdztt5bqgzFeM3lBR6me5ILDFZtcRj8/SK44uw9KX2NY+kdcix/qULt1MPmIQMBaZUJ
         +awOfs35tkJLYy5GGmRdTQCkfhG5eq23FOl5VP3Ku3/V4BX7SkzDgryyR78IrdzgY/hj
         VuWxOXc6wLRI6B8OKVP2QQoxzQvW9h9BY//w9elN5JKHNjpPslVJtUUA38LPZkTtywNZ
         ziXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z3BKge990LyaSwx4wBUBWy5aVHpLudxzVwQwi9XYB0g=;
        b=0RGG7ajck+RMqu5Sl5/VT713NyibuaQSDyCWWu1wx3XJqUYePAdwxJI17Rtb2Mqbdr
         Sjh7rQDINlJdjTTnGyTUuPcQ7f8XL05jWJyllq0n7l8su3d7lvjSAYGs2R1M21wSsdGL
         pOjiaMNnNIalHhNk8nFPGOcEMEo6nh31+fg9KCU55+zhx4DR4PPApJEt+1QoNYk89Ayy
         qgK+RDtSWCPKBBldudJ7XMiJVXyMp/7BQd83TAOVOZXKHP/RL9sle6w8nm2bD+b4NBdq
         J7U/96o7GddyTK8mVBfsjjDAZawBcn+zxgMtT8HY27LHcgb5U9iqEoVPVjQUZOuxjqHV
         ty0A==
X-Gm-Message-State: ANoB5pkUJ63YBNZKM5yA55x1KRo5TI1bOojU+mkmy2gIsM6Y7+/suec4
        jEMJfZeeyV7Tb8Ajf6oMzmSfvoUTCamj
X-Google-Smtp-Source: AA0mqf560FfwKRo/El9wKD5TLR7c3aQTKLxTu6//nXLjZR0yM/gTALRyfZ56v/G796Kaz90Vauyzaox7SCMy
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a05:6a00:1624:b0:573:993b:ea6d with SMTP
 id e4-20020a056a00162400b00573993bea6dmr2912163pfc.10.1669074034514; Mon, 21
 Nov 2022 15:40:34 -0800 (PST)
Date:   Mon, 21 Nov 2022 15:40:23 -0800
In-Reply-To: <20221121234026.3037083-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20221121234026.3037083-1-vipinsh@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221121234026.3037083-4-vipinsh@google.com>
Subject: [PATCH v2 3/6] KVM: selftests: Test Hyper-V extended hypercall enablement
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
 tools/testing/selftests/kvm/include/x86_64/hyperv.h  | 4 ++++
 tools/testing/selftests/kvm/x86_64/hyperv_features.c | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/hyperv.h b/tools/testing/selftests/kvm/include/x86_64/hyperv.h
index 9218bb5f44bf..8813c1bb74a0 100644
--- a/tools/testing/selftests/kvm/include/x86_64/hyperv.h
+++ b/tools/testing/selftests/kvm/include/x86_64/hyperv.h
@@ -112,6 +112,7 @@
 #define HV_ACCESS_STATS				BIT(8)
 #define HV_DEBUGGING				BIT(11)
 #define HV_CPU_MANAGEMENT			BIT(12)
+#define HV_ENABLE_EXTENDED_HYPERCALLS		BIT(20)
 #define HV_ISOLATION				BIT(22)
 
 /* HYPERV_CPUID_FEATURES.EDX */
@@ -166,6 +167,9 @@
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
 
+/* Extended hypercalls */
+#define HV_EXT_CALL_QUERY_CAPABILITIES		0x8001
+
 #define HV_FLUSH_ALL_PROCESSORS			BIT(0)
 #define HV_FLUSH_ALL_VIRTUAL_ADDRESS_SPACES	BIT(1)
 #define HV_FLUSH_NON_GLOBAL_MAPPINGS_ONLY	BIT(2)
diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_features.c b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
index 3163c3e8db0a..a5a3146fc299 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_features.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
@@ -583,6 +583,15 @@ static void guest_test_hcalls_access(void)
 			hcall->expect = HV_STATUS_SUCCESS;
 			break;
 		case 19:
+			hcall->control = HV_EXT_CALL_QUERY_CAPABILITIES;
+			hcall->expect = HV_STATUS_ACCESS_DENIED;
+			break;
+		case 20:
+			feat->ebx |= HV_ENABLE_EXTENDED_HYPERCALLS;
+			hcall->control = HV_EXT_CALL_QUERY_CAPABILITIES | HV_HYPERCALL_FAST_BIT;
+			hcall->expect = HV_STATUS_INVALID_PARAMETER;
+			break;
+		case 21:
 			kvm_vm_free(vm);
 			return;
 		}
-- 
2.38.1.584.g0f3c55d4c2-goog

