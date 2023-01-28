Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F3667F2D4
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 01:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjA1AOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 19:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjA1AOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 19:14:31 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762717B415
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 16:14:30 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id s76-20020a632c4f000000b0049ceb0f185eso2770791pgs.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 16:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iwlcdlJJgNxaN7KocVWCGFnG+kPyVohvYqXCxDe6XuM=;
        b=mAL/PvUSfxHJU7ATYhzNLnuzW9F2kvWTQEwpOIpDfhAtTqnD/Pf4LqrF1myJH6GbBy
         eusgGt0Ee3nfpYFyW192VjAIVORMH3fs8qyByuFvzuNOfXnEtSib4PPJwhx+HZG97I7H
         cDZWggsyLo6Mo7kYzLT9W3/nWwppkUzs+TJGyCD/codVSyeZSKidETC/2gT97QYHj8sp
         MFLgn+miHvKc/XlYJjx9jLWR5TZ0WN9HitIfRptRCn7bTSi5yQ04SZObOBn+/S4Jp0BX
         ZJ0Q/36NLzBcIwmcaR0fdKg4//N6w+zVi8xeasf0322d03ieBSz74NTJoD+rbuCFZhTq
         /gjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iwlcdlJJgNxaN7KocVWCGFnG+kPyVohvYqXCxDe6XuM=;
        b=KuqUYS/jHCu1jyb17EGAZmJ6G0xGkc7tvNHr4Q6JSEVsIuGccW2p2WZzwkvFvCmWme
         URLHn3gvzl9juX+bxfQF89yRl4IMZsTesrP+hCeALlQGYePFBOe5zaktF1fTIZXxP1T8
         n+RI/hNX/ZRX+Z0BS1kOOqvs3bPi1iYkeLtMAWveiG7EnKOQ3tMlLouiiKDfAAbIcQ+5
         6cpnUWGR7QQQfhyHwfnukMfoSDbzMo6XUCe/S2Bu68E0QgQ7Lv8AmFYmyYucvxKzlDmf
         2DBEmhRJJMPpaoG6NF1D73sQ+D/VUTkuk9Sbqtqm4UkzNdosR6RXRyHgWJO2YjSFnei2
         OsQw==
X-Gm-Message-State: AO0yUKXIvBXAqmzhDpaOavRchHZijRCtHZo2ATpK2tP7oOdo8JQxtOgs
        Uuu86BOsseHUz0sK5QFFZkwh64/OoXw=
X-Google-Smtp-Source: AK7set/Son7/82cuGTzehMpialLra+Qlm9kv4QQ9rdurmaMqqFqZ63fIiMIjFT3QWkGpkmoJAsMbmJfsZ1U=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1990:b0:593:909f:ed45 with SMTP id
 d16-20020a056a00199000b00593909fed45mr181136pfl.0.1674864869971; Fri, 27 Jan
 2023 16:14:29 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat, 28 Jan 2023 00:14:27 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230128001427.2548858-1-seanjc@google.com>
Subject: [PATCH] KVM: x86/pmu: Disallow legacy LBRs if architectural LBRs are available
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Weijiang <weijiang.yang@intel.com>,
        Like Xu <like.xu.linux@gmail.com>
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

Disallow enabling LBR support if the CPU supports architectural LBRs.
Traditional LBR support is absent on CPU models that have architectural
LBRs, and KVM doesn't yet support arch LBRs, i.e. KVM will pass through
non-existent MSRs if userspace enables LBRs for the guest.

Cc: stable@vger.kernel.org
Cc: Yang Weijiang <weijiang.yang@intel.com>
Cc: Like Xu <like.xu.linux@gmail.com>
Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

Am I missing something that would prevent this scenario?

 arch/x86/kvm/vmx/vmx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 8f0f67c75f35..77ee6b4a5ec4 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7761,9 +7761,11 @@ static u64 vmx_get_perf_capabilities(void)
 	if (boot_cpu_has(X86_FEATURE_PDCM))
 		rdmsrl(MSR_IA32_PERF_CAPABILITIES, host_perf_cap);
 
-	x86_perf_get_lbr(&lbr);
-	if (lbr.nr)
-		perf_cap |= host_perf_cap & PMU_CAP_LBR_FMT;
+	if (!cpu_feature_enabled(X86_FEATURE_ARCH_LBR)) {
+		x86_perf_get_lbr(&lbr);
+		if (lbr.nr)
+			perf_cap |= host_perf_cap & PMU_CAP_LBR_FMT;
+	}
 
 	if (vmx_pebs_supported()) {
 		perf_cap |= host_perf_cap & PERF_CAP_PEBS_MASK;

base-commit: 2de154f541fc5b9f2aed3fe06e218130718ce320
-- 
2.39.1.456.gfc5497dd1b-goog

