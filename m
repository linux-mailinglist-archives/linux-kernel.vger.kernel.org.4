Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D365F5D74
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 02:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiJFADc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 20:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiJFADW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 20:03:22 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD3732BB9
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 17:03:21 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 203-20020a6300d4000000b0043fc5adabc8so146580pga.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 17:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuL2WMiGYze3NRMdfPj3MoHFJUJYGCMiGE6H5e3qchw=;
        b=mWjjFMysPgnbZbFgdefAEx2kRBsVhavP43kyucIJt8jdHM/sTIeM8/nrm27y0nTdpB
         3KDpayu47Wl4wb7uRxPiI/OAtjMEWyffz852gWqdUiLHcxh2AXto+H/RgzVO4IrGT2BB
         PeQmdoOnJ8aUJB3yLZPh50+fJ/HuPUqFZ5KX/+Rfen6BaSt0tvzit14GTnDeiDixYb8F
         VoFb6shWMcdqhPS0xIAn/zPp+hwC+WrcYpT6YYhP2sOc63LLXlvfVVv4NackFLRO128z
         TBX2F7JtCKwCMC9bq2SMY56QED0Lo4G+whthTouWif9FedYgR85/xWrzizJkZRkjmYn4
         tA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZuL2WMiGYze3NRMdfPj3MoHFJUJYGCMiGE6H5e3qchw=;
        b=i8dkIzXZwzBDUqmijwC0SQauqRidSyxz7YZU/6Dqv0rI99B8Zsl57XsSwI9sN9Z2tw
         X78B3Szg/zuIo3qqK0r0oOFpNMiwQuodGi0hIACs21C6zKFpHIfAH5PLkl+QFMgkzmrT
         VpX44UIQ9GWl5G6EEGBJ4+xTRqkvwCiFrGLRc3nQZHTJG23Pu7rEL1klLUqjqI8P8ffi
         JnT9mA3dN67Ts3VTaiTjfds0kIh8zjCT53NdFmmpMwtyg++Wvwvs70k91le9qDdIpQew
         rxINYfSXxYPI8Pn6TzbyMxcHYFzKPDXdlgCXVz6HwXDGaBzv/4mCy+7wB7zJHf7pgdHZ
         oXrQ==
X-Gm-Message-State: ACrzQf36MfuX1PEj3JbT0m1IjJZv6I/dNVs3qg/F8vENep/WlZCunMTL
        vgbCgpOoxcdpyItB50BiqWNUCxdvYg8=
X-Google-Smtp-Source: AMsMyM4kcuwbKLEWnGSBZIg5beqUVqfaQqN51gbsFgZ4VCZpviwVuV9lXyFgLBijtS+5dTsgFqY8DdCH3U0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2409:b0:54e:a3ad:d32d with SMTP id
 z9-20020a056a00240900b0054ea3add32dmr1929000pfh.70.1665014601268; Wed, 05 Oct
 2022 17:03:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  6 Oct 2022 00:03:08 +0000
In-Reply-To: <20221006000314.73240-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221006000314.73240-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221006000314.73240-3-seanjc@google.com>
Subject: [PATCH v5 2/8] KVM: VMX: Advertise PMU LBRs if and only if perf
 supports LBRs
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Like Xu <like.xu.linux@gmail.com>
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

Advertise LBR support to userspace via MSR_IA32_PERF_CAPABILITIES if and
only if perf fully supports LBRs.  Perf may disable LBRs (by zeroing the
number of LBRs) even on platforms the allegedly support LBRs, e.g. if
probing any LBR MSRs during setup fails.

Fixes: be635e34c284 ("KVM: vmx/pmu: Expose LBR_FMT in the MSR_IA32_PERF_CAPABILITIES")
Reported-by: Like Xu <like.xu.linux@gmail.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/capabilities.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
index 87c4e46daf37..a6689bf06542 100644
--- a/arch/x86/kvm/vmx/capabilities.h
+++ b/arch/x86/kvm/vmx/capabilities.h
@@ -400,6 +400,7 @@ static inline bool vmx_pebs_supported(void)
 static inline u64 vmx_get_perf_capabilities(void)
 {
 	u64 perf_cap = PMU_CAP_FW_WRITES;
+	struct x86_pmu_lbr lbr;
 	u64 host_perf_cap = 0;
 
 	if (!enable_pmu)
@@ -408,7 +409,9 @@ static inline u64 vmx_get_perf_capabilities(void)
 	if (boot_cpu_has(X86_FEATURE_PDCM))
 		rdmsrl(MSR_IA32_PERF_CAPABILITIES, host_perf_cap);
 
-	perf_cap |= host_perf_cap & PMU_CAP_LBR_FMT;
+	x86_perf_get_lbr(&lbr);
+	if (lbr.nr)
+		perf_cap |= host_perf_cap & PMU_CAP_LBR_FMT;
 
 	if (vmx_pebs_supported()) {
 		perf_cap |= host_perf_cap & PERF_CAP_PEBS_MASK;
-- 
2.38.0.rc1.362.ged0d419d3c-goog

