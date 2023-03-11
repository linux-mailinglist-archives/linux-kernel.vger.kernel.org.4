Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B818B6B5707
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjCKAsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjCKArW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:47:22 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5D4141609
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:46:50 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id l10-20020a17090270ca00b0019caa6e6bd1so3629934plt.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678495604;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=k4NjhMvOz8i60KQi141LzevW2pwEgTqlrWyWCj3rgJ8=;
        b=q5q2rp0XdgbYt+cOilERZrXszKOvS2r8jQDmCDCMfL70G4frpG5F55N+ggVBRg0IMz
         g0bJG22iYxgecggNlGgCI+tsoYEdA+BBqB/koX3AsNH0e48OitM+Fm2RCOknRkMk0GhS
         UTQ174IH0V+jzvsk+pkE0BW7461LDpIuzqzw5Ae6aJRzhabml5Xx60zne5mq089L6JRd
         nhicKGGuOhPUODOCbYnLtWouPP6YpoPvr0gxC8BYM/YeLUjTf5gHkBcOD2NkFgBxI1ek
         W7FGXfMTDas+NtLIjnN02R0mDqFC1C2TxasL/D8CHVcUvQnfRXBP/2rlN4ZHZXCP/BKp
         ruQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678495604;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k4NjhMvOz8i60KQi141LzevW2pwEgTqlrWyWCj3rgJ8=;
        b=zK86fg19AflIL4vw/c9RA3lnbozT31835B0jg0a6/l+yTvTSK2w4odUvv/pDUEpqXt
         ik1uArQW0xpX609l4mVVdXDHa0/rLwXe6ZJzw58t8W7M8mCsKAKT15BxVjMrtwbJQpCw
         PWFun7bNuTvIikn9hNbfgrKI+C5k9P3fFTAG+ZtE22M9GSXGB/V+YOnRl7In9QdoN/b5
         Caahw7TbX0lhX4dnobyHWAVPApJV3IcSxJvB3dj3fevafrEXWv2p9JHfgrgH6X30ke1J
         6fmKWDDXYjhBdxdvFbNaHsPqY+YWW4SWfEM0d1Co/G9LLkSVGFzeyXdXhBIXYxcbAFuG
         wxYg==
X-Gm-Message-State: AO0yUKUgUULxpLVMYfwzxqUr9/hzT44ZE4vKMIxnrSgv11X6wMRSjzE5
        yCJEYxwhu2r4Qm2ewBT4AC4Svj97ly4=
X-Google-Smtp-Source: AK7set/S9AhDw3GSh/Df5C1jvHWEN75uHrpzD2xoHdS6qef32PvUE3aUMhP9PUs2c56XZDxqYmPk/72jR3g=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:744a:0:b0:4fc:27c2:840d with SMTP id
 e10-20020a63744a000000b004fc27c2840dmr8922435pgn.12.1678495604462; Fri, 10
 Mar 2023 16:46:44 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Mar 2023 16:46:09 -0800
In-Reply-To: <20230311004618.920745-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230311004618.920745-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230311004618.920745-13-seanjc@google.com>
Subject: [PATCH v3 12/21] KVM: selftests: Verify KVM preserves userspace
 writes to "durable" MSRs
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assert that KVM provides "read what you wrote" semantics for all "durable"
MSRs (for lack of a better name).  The extra coverage is cheap from a
runtime performance perspective, and verifying the behavior in the common
helper avoids gratuitous copy+paste in individual tests.

Note, this affects all tests that set MSRs from userspace!

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/x86_64/processor.h    | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 26c8e202a956..52260f6c2465 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -945,12 +945,27 @@ do {										\
 	}									\
 } while (0)
 
+/*
+ * Returns true if KVM should return the last written value when reading an MSR
+ * from userspace, e.g. the MSR isn't a command MSR, doesn't emulate state that
+ * is changing, etc.  This is NOT an exhaustive list!  The intent is to filter
+ * out MSRs that are not durable _and_ that a selftest wants to write.
+ */
+static inline bool is_durable_msr(uint32_t msr)
+{
+	return msr != MSR_IA32_TSC;
+}
+
 #define vcpu_set_msr(vcpu, msr, val)							\
 do {											\
-	uint64_t v = val;								\
+	uint64_t r, v = val;								\
 											\
 	TEST_ASSERT_MSR(_vcpu_set_msr(vcpu, msr, v) == 1,				\
 			"KVM_SET_MSRS failed on %s, value = 0x%lx", msr, #msr, v);	\
+	if (!is_durable_msr(msr))							\
+		break;									\
+	r = vcpu_get_msr(vcpu, msr);							\
+	TEST_ASSERT_MSR(r == v, "Set %s to '0x%lx', got back '0x%lx'", msr, #msr, v, r);\
 } while (0)
 
 void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits);
-- 
2.40.0.rc1.284.g88254d51c5-goog

