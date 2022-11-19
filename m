Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710FA6308CD
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 02:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbiKSBxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 20:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbiKSBwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 20:52:42 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D32C4B63
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 17:34:55 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id my9-20020a17090b4c8900b002130d29fd7cso7638361pjb.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 17:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ainK2RDn+jZipfmA59p8DPXtbCjd5fvmnXnNzM45Lqs=;
        b=ElbaUsSFUGAHxw9FaGIh9WqW076YqYTniSp+9sLgIbyAZGXc9q18pS+d+PVOfEWLyg
         Kx/QdBqkeFSoCaN0e1TOjAh4OmvJCcZTfbRkoIs9Pa9Ier3h3eU6dfc5nhMeLRYb7If1
         R8gMGaRsYzdOWxgY6umO5g2RAl06ZRzk4tCJFWsOlqsTdFgeOz+FKVhUFHG0gjETIWMB
         SJsXPpuWt8ijNGjeVGXQ26qTfp0uSqxFA3Tr0kPraQUGqTQxkgiCsPpjq4Ug8UUJokHo
         3S2V7A4WGHkj82py+dbabm8Ds9t2svz5QsJ1xSBiuk9loWQwWH1Z8uCRnLa36e7zSQDg
         hRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ainK2RDn+jZipfmA59p8DPXtbCjd5fvmnXnNzM45Lqs=;
        b=W/QB5Lerbme1hi+vCgI83I/dxj63cNwkYJdcTZUWSkWqknb7k7vLyoeNvg7+nuOvhS
         E9OEPYSd7sIPQ4RWOuUu1G5eG0T2zKUOE7+PnG1gPmCOdzPxtvLLpggBp7cHNiuJqc0s
         zfYM5niXHIW2cBU90fvt1KqKnJx8YnDRm82mz3vF4WOW4/ccNcbNJ4EW35FC6lRkyBFR
         Se9RK6uYxBip4yIOmHnrYQuYsVrBvIndKgETCawxjfxAGl1txb0551zhsRTiDFxjNM8v
         SNNPDuaXGW/JZ6KQX6IdRjE/Dt6GmAroLmme3+NutZAVJWRikP05x4AIv1nJ3/1wKDW5
         +Hjg==
X-Gm-Message-State: ANoB5pmBA6/JozLO8bNvpjx1qeKnPKkDUdkpztIYtdGt9MrEUnvtrskF
        61YI/N8JVnRhO+/1RfiMQ88eHTULDiM=
X-Google-Smtp-Source: AA0mqf6tFBmKyZhX4sewzWE/FLSMviulSVp5ypejrlokkSGEnAY1MSlwDguv1kCBOyWnNtV82VmzeHcBdl4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ca14:b0:187:3fc8:986e with SMTP id
 w20-20020a170902ca1400b001873fc8986emr2206032pld.4.1668821695384; Fri, 18 Nov
 2022 17:34:55 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat, 19 Nov 2022 01:34:42 +0000
In-Reply-To: <20221119013450.2643007-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221119013450.2643007-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221119013450.2643007-2-seanjc@google.com>
Subject: [PATCH 1/9] KVM: selftests: Add rdmsr_from_l2() implementation in
 Hyper-V eVMCS test
From:   Sean Christopherson <seanjc@google.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>
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

Add rdmsr_from_l2() in hyperv_evmcs.c, it got left unintentionally omitted
when applying code review feeback on the fly.  Intentionally duplicate
the code that's in hyperv_svm_test.c, the helper really should not exist
(L1 shouldn't clobber GPRs) and will hopefully be removed sooner than
later.  Until that happens, deter other tests from using the somewhat
misleading helper (it doesn't actually read L2's MSR value).

Link: https://lore.kernel.org/all/Y2FFNO3Bu9Z3LtCW@google.com
Fixes: 860e80157068 ("KVM: selftests: Introduce rdmsr_from_l2() and use it for MSR-Bitmap tests")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86_64/hyperv_evmcs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_evmcs.c b/tools/testing/selftests/kvm/x86_64/hyperv_evmcs.c
index d418954590b1..ea58e5b436e8 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_evmcs.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_evmcs.c
@@ -31,6 +31,15 @@ static void guest_nmi_handler(struct ex_regs *regs)
 {
 }
 
+/* Exit to L1 from L2 with RDMSR instruction */
+static inline void rdmsr_from_l2(uint32_t msr)
+{
+	/* Currently, L1 doesn't preserve GPRs during vmexits. */
+	__asm__ __volatile__ ("rdmsr" : : "c"(msr) :
+			      "rax", "rbx", "rdx", "rsi", "rdi", "r8", "r9",
+			      "r10", "r11", "r12", "r13", "r14", "r15");
+}
+
 void l2_guest_code(void)
 {
 	u64 unused;
-- 
2.38.1.584.g0f3c55d4c2-goog

