Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BBD720CE6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 03:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237235AbjFCBL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 21:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237164AbjFCBLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 21:11:30 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B503D10CE
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 18:11:19 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-65297b2ccc6so1715082b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 18:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685754678; x=1688346678;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=srE51TmJQHtlw1biDESTiNR2nLQR2FcTNrE5RKigF3Q=;
        b=iio8BhYA5NHbSfjdHUMcPlrVK7oQLcO4eGZLyOfc9szChSEAewXzlRkxlo6w57iyet
         wu5ivizMYbpgkF0Z92y/70R+NB/lkt7sFiS6Omn7QaF5OnZ0vKcC2jcCEql+cR3vVQUq
         M1Mo1Uo/qFycQHiFv8ySrIUZ+3v4wnEbJidQGRZHsAEC8HvRMzjjXc6CN+OtlNnmvYF6
         wtRDG8Y4fV09qD/3TBzaMflqxFtro8Y3fu55v1mMHFkI41qukIc3Hn++yI/cCoM0vTk9
         N06XlVY3EgZdG0QpeQX9FO83+rK7sM5Y0YhYd0KZaNegp5H/PoF6tfh1rovjzArgRvr3
         O6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685754678; x=1688346678;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=srE51TmJQHtlw1biDESTiNR2nLQR2FcTNrE5RKigF3Q=;
        b=UStFoSMvHmyNLp5pWc6yklyZQvPcEIoFd+6rqyuwipOzSBulF7P8tz8nKyczZ/8QXL
         PT6tWEIwZkZG6b67CEb7Iop64zxmP4Sn8tOWa0BWofeGtmbuPlmasxw6m9QbDK245Z/A
         MAsQAvh4VdB2UbBYkQZ1ziX9nbyv5QB2QVHOqnbfWmoGv6fsnEqFEt1pnSfTUPy2HyJ5
         0vIuo4S/km0DG+bQPeHgQbs9au0YRaNXIlkYSSnxeqdzSe1bvEN/iJO5j1OFxaJ4W/Qs
         0cX1HXyNvBSluwmozKMuRl3rv/RZY3S+lbtxHj9oViJ4yD55+VoFf7yuLBbVQSpA/Qqb
         0PBA==
X-Gm-Message-State: AC+VfDxkVjkLm0QnPaZcghfrU5tgQ22wgEKQ9zuyv095j96F+3j4wzMf
        gn6zsEGYYNT6phkOLQb/2T82EwJUL+o=
X-Google-Smtp-Source: ACHHUZ6rk8V5LUzWINE9mTURsU/+yccuxSJPXW34KbNxljXjIHJQrfw7zZ5SU0Zy0xRrptKnhFRdv3Gk7kg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:9a3:b0:653:b76d:4d52 with SMTP id
 u35-20020a056a0009a300b00653b76d4d52mr729527pfg.2.1685754678499; Fri, 02 Jun
 2023 18:11:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  2 Jun 2023 18:10:55 -0700
In-Reply-To: <20230603011058.1038821-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230603011058.1038821-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
Message-ID: <20230603011058.1038821-10-seanjc@google.com>
Subject: [PATCH v7 09/12] KVM: x86/pmu: Constrain the num of guest counters
 with kvm_pmu_cap
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Like Xu <likexu@tencent.com>

Cap the number of general purpose counters enumerated on AMD to what KVM
actually supports, i.e. don't allow userspace to coerce KVM into thinking
there are more counters than actually exist, e.g. by enumerating
X86_FEATURE_PERFCTR_CORE in guest CPUID when its not supported.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Like Xu <likexu@tencent.com>
[sean: massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/pmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index e5c69062a909..c03958063a76 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -170,6 +170,9 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
 	else
 		pmu->nr_arch_gp_counters = AMD64_NUM_COUNTERS;
 
+	pmu->nr_arch_gp_counters = min_t(unsigned int, pmu->nr_arch_gp_counters,
+					 kvm_pmu_cap.num_counters_gp);
+
 	pmu->counter_bitmask[KVM_PMC_GP] = ((u64)1 << 48) - 1;
 	pmu->reserved_bits = 0xfffffff000280000ull;
 	pmu->raw_event_mask = AMD64_RAW_EVENT_MASK;
-- 
2.41.0.rc2.161.g9c6817b8e7-goog

