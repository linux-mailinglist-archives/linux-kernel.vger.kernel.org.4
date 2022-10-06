Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C0A5F5D7F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 02:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiJFAEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 20:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiJFAEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 20:04:01 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3F387088
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 17:03:31 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id i5-20020a170902c94500b0017c602e7f76so99443pla.22
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 17:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=YG4VlFLS486HR6XzTWZkeVrEikhzGg3oNMrJdR09xN0=;
        b=SH/m0hye551j67TpeTG6UDh5pXgMwDYYEnADzE2VuZ/b0h5xJTZIFXFQfrUcz+GaBQ
         8IvfIWHd9N4aVrxw/FwvJHFG+ppWqdYUfPE4SsloicHC9tVPMl+9sv3szHZNeWm7ttha
         +JQZ9+vTMCBsM7iSbFcZ6yaX/sQuprgHUqH1aK9+CuP0Qqq9KMT80txUpy4raFdzOBs1
         +lNiIG479aHHd+4OsZH4zeziTA3Rpi43hD0ylG9e/JP2vWkcaw9Pc2FqY/f/TBRtdJMC
         u1rUD2ti+37tzBCErE5ZBF6DydlE2GRp31nLL1kS9vKF5GTW+M1JTyQ0MYftCdHV6EjV
         boQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YG4VlFLS486HR6XzTWZkeVrEikhzGg3oNMrJdR09xN0=;
        b=uaahS1UXUdPTwmJ8AO9gN3fkBmz5xcsy6tAUn2+b61PK9UPvPUy/8pXtzXHRmlDj6E
         rMpBckZYurfzqYMHh7fULxTwAnqHk8znIfG+clSswlUatRpQU0bo6RQTxTk3HDUB7hvr
         Wu9NiaQCW7jzGZ4gcULZYtrsGHB87msuLzrzEkTNQgSwN2roLaBGLvgM8WwIW6vXa+0f
         ZB36sfRojqLHfXurCv4VocqtTfeBCiDME3qvNMwCtqvMo5LcfyuC2YvmY4y8C2WCUuja
         NklfDDfFNm9vjkU1SFvfa72XR464it+5XiV/9omSh/776tn5efEMNfCy4qG332QPiSss
         ii9w==
X-Gm-Message-State: ACrzQf0Adb2gWwaWVzqeD3BbsH85avIisEoIDQGex1EIYDJOZBLFq7hP
        a2DV+jOAFjL//02bQ+YU9ipLlxdnGBs=
X-Google-Smtp-Source: AMsMyM5ri2aBfQ5w9YqA3ahxTnjdm1oMk3Qr0A+RS8JT6NaMggeExdrUcGVCtoFNOX7TgNWElm4jFLYfsoY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:c986:b0:205:f08c:a82b with SMTP id
 w6-20020a17090ac98600b00205f08ca82bmr146218pjt.1.1665014611232; Wed, 05 Oct
 2022 17:03:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  6 Oct 2022 00:03:14 +0000
In-Reply-To: <20221006000314.73240-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221006000314.73240-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221006000314.73240-9-seanjc@google.com>
Subject: [PATCH v5 8/8] KVM: x86: Directly query supported PERF_CAPABILITIES
 for WRMSR checks
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

Use kvm_caps.supported_perf_cap directly instead of bouncing through
kvm_get_msr_feature() when checking the incoming value for writes to
PERF_CAPABILITIES.

Note, kvm_get_msr_feature() is guaranteed to succeed when getting
PERF_CAPABILITIES, i.e. dropping that check is a nop.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 9443ddb358e6..3afe5f4b1a40 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3568,20 +3568,15 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			return 1;
 		vcpu->arch.arch_capabilities = data;
 		break;
-	case MSR_IA32_PERF_CAPABILITIES: {
-		struct kvm_msr_entry msr_ent = {.index = msr, .data = 0};
-
+	case MSR_IA32_PERF_CAPABILITIES:
 		if (!msr_info->host_initiated)
 			return 1;
-		if (kvm_get_msr_feature(&msr_ent))
-			return 1;
-		if (data & ~msr_ent.data)
+		if (data & ~kvm_caps.supported_perf_cap)
 			return 1;
 
 		vcpu->arch.perf_capabilities = data;
 		kvm_pmu_refresh(vcpu);
 		return 0;
-	}
 	case MSR_EFER:
 		return set_efer(vcpu, msr_info);
 	case MSR_K7_HWCR:
-- 
2.38.0.rc1.362.ged0d419d3c-goog

