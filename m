Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42495720CE0
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 03:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237113AbjFCBLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 21:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237093AbjFCBLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 21:11:19 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D4BE57
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 18:11:13 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-babb79a17b8so3467826276.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 18:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685754672; x=1688346672;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=TY+mHBGwLnRemiSJpkessBMR8rKQ3vloA3kicsPHpfA=;
        b=OnCY01X+GhNF4B2rPl8w92fKWWhN75yMAb8AqNhGWytXTk7TqUGYHT4OfJ96dUILgN
         E0bsOfYhf01+Inn8Hb6VeZ6WNJw2DFAiK2w3enJaLGHRu43Ky7Gx3hZn8pD39bwy0Gws
         Pad3T+POsq3NcQF2v5vfXQsnEM4TUIUlQkztXz65WFLxy4JlqanGy6UfX758JWeLDd4M
         KcaCut6eaMR2T4teMNKH2Z05voP9MFb0ztfhUx3byu1XA+0QDhHk70OGTH4ztvcGvRvU
         rLn4EKN+VlU6cICCZ1x7EZaZZD7BlmE2FecwXrKWJaYtOzJOWSJUNogS5FyzwctEfSC8
         u+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685754672; x=1688346672;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TY+mHBGwLnRemiSJpkessBMR8rKQ3vloA3kicsPHpfA=;
        b=LeOmIOon6x8Lc+IDaXb/mUvXTDv+kj/viTBiBUg46Rka6bkKm+yi+jt+IP/uxNmy4s
         qsFRW4FimMaZVE4bo+3ltmDFDq1hPllyRfnlk4ljXC7x1FuRc3gkX5yVY+M/PZW5XDQ6
         KzR0dG3XjZo569OM7vzd7tOBCzOCAhbksscNOfKHUSEwAZuM1ewb0ei6h9cuHCzynfD6
         Fm5tmQpgrCeF9JqTvMmg1r0Lgg4vIrzAWyqjeU7Dql5uEwQvdfpGZ2oQz01lmuJE9K+m
         opehf1QM8FKCTGWQIrOQTpbl1V0UNEBwidaGOUEtdXv5l2aPOnq0+g82S+uIPkM3Bd93
         +KkA==
X-Gm-Message-State: AC+VfDzNZyUBIPsvF2q+aBNyvuVS1YMXQnnB/+BvJr3sigyRWqkgyAJ+
        mXAgzOnpQywb4LbPbk3vJo6Z1WO2NZI=
X-Google-Smtp-Source: ACHHUZ71ab2vlYdbFm7muMp7lZeJGYFIK9nlaLC/YaAwP+jTh+T1gLgrwoU8lFKVlrgSzxu0x8mqtLJ90yw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1142:b0:bac:fd63:b567 with SMTP id
 p2-20020a056902114200b00bacfd63b567mr2769901ybu.4.1685754672783; Fri, 02 Jun
 2023 18:11:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  2 Jun 2023 18:10:52 -0700
In-Reply-To: <20230603011058.1038821-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230603011058.1038821-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
Message-ID: <20230603011058.1038821-7-seanjc@google.com>
Subject: [PATCH v7 06/12] KVM: x86: Explicitly zero cpuid "0xa" leaf when PMU
 is disabled
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Like Xu <like.xu.linux@gmail.com>,
        Like Xu <likexu@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Sandipan Das <sandipan.das@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Like Xu <likexu@tencent.com>

Add an explicit !enable_pmu check as relying on kvm_pmu_cap to be
zeroed isn't obvious. Although when !enable_pmu, KVM will have
zero-padded kvm_pmu_cap to do subsequent CPUID leaf assignments.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Like Xu <likexu@tencent.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 0c9660a07b23..61bc71882f07 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -948,7 +948,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		union cpuid10_eax eax;
 		union cpuid10_edx edx;
 
-		if (!static_cpu_has(X86_FEATURE_ARCH_PERFMON)) {
+		if (!enable_pmu || !static_cpu_has(X86_FEATURE_ARCH_PERFMON)) {
 			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
 			break;
 		}
-- 
2.41.0.rc2.161.g9c6817b8e7-goog

