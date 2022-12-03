Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B2264125F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 01:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbiLCAkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 19:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbiLCAkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 19:40:04 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566A41E702
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 16:37:49 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id o8-20020a170902d4c800b001898ea5e030so8022267plg.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 16:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5cHO8TZ/NgQcG2/A3zvYgffqJLlGYe3zpPYcN2k37Z8=;
        b=pJ5S5cEuTvr85SuayQOIMCDdKWDVpy5OfbTE8O7P7h6XgCY255xnijRFmkiZ6EEcfK
         0lvECxqT6/3GkdRxF/jHKq5xohT1ObE6VE0Eibrb61uGMu6SUgQDwJD5BuPCdzjGOn9q
         w8WhVgihJlIX8q2tXFA/U3boujzOhTlnSt7t24WoG1kH8y5WTsMub2143mrSyJaF1X6l
         mC5lwHiuvETDepkPUjzzNhWRnRMTvjaZGwHXXtOJReduP/6a2VVdSn9f2Ujf2Bk4ahPE
         Yy2xn+kT64NeaqpZCY6OxKsq6xl3GXNm/57OWtp2FfrcJS4USF+4PvWMehUxpEoBYyFU
         UI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5cHO8TZ/NgQcG2/A3zvYgffqJLlGYe3zpPYcN2k37Z8=;
        b=xQeu1zJSE1VNcz00gGtAvUws/bMC5kIPy3xxVOIxu8GWnGM23n1gXt1eU60h6N5Hhz
         DkvPzQtlNOUdGWLv/T4sW7bwdabjToKAx2RJoIYqj+fDJhUYGBj+IAcoAgTFvU+Q7ZiW
         gl3NqTLMImfUbOInOFIzchjCyhEnm9LWgwrWu5CKaXjMPlgAGpokVxQti2X+tFxOc7W4
         PRpzDn2UtoxxwFk8cQGpOl3s9/6fowAVHEhwUdMqXGeq/xDhkgvaEyMikdwNJ0KdcLkx
         etuWl8/TyFepmGIRaxNEAER5XKFfG1FB/x5o2100+oxOdKbfl9KitfNTJ0QCInO9AbA9
         1R6A==
X-Gm-Message-State: ANoB5pkypEU282zX7twDeAO1akr/VwvSJhxKBuFBy9ZEJiB9jNpq8zbQ
        FeJk0/C8x8qbUQOZe/V0n0biJY+GIc4=
X-Google-Smtp-Source: AA0mqf7/Ed+dwcaWqhy6TT5UzFpiCfj7GO7PwtVZkzR3c7Pc0vUlcNewIK1n6B82nA+cULogbBYGuW/XRTU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:4946:0:b0:477:7c87:1087 with SMTP id
 y6-20020a634946000000b004777c871087mr52392327pgk.452.1670027868906; Fri, 02
 Dec 2022 16:37:48 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat,  3 Dec 2022 00:37:42 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221203003745.1475584-1-seanjc@google.com>
Subject: [PATCH 0/3] x86/cpu: KVM: Make SGX and VMX depend on FEAT_CTL
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
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

"Officially" make SGX and VMX depend on X86_FEATURE_MSR_IA32_FEAT_CTL,
and drop manual checks on X86_FEATURE_MSR_IA32_FEAT_CTL when querying
VMX support.

To make dependencies on MSR_IA32_FEAT_CTL work as expected, process all
CPUID dependencies at the end of CPU indentification.  Because
MSR_IA32_FEAT_CTL is a synthetic flag, it is effectively off-by-default,
and thus may never be unset via clear_cpu_cap(), i.e. never triggers
processing of its dependents.

The obvious alternative would be to explicitly clear MSR_IA32_FEAT_CTL if
the MSR is unsupported, but that ends up being rather ugly as it would
require clearing the flag in default_init() to handle the scenario where
hardware supports the MSR, but the kernel was built without support for the
CPU vendor.  E.g. running on an Intel CPU with CPU_SUP_INTEL=n.  This edge
case is also why the existing manual checks in KVM are necessary; KVM_INTEL
effectively depends on any of CPU_SUP_{INTEL,CENATUR,ZHAOXIN}.

Processing all dependencies also seems like the correct thing to do across
the board, e.g. if the kernel ends up with more synthetic features with
dependents.

The placement of the call to apply_cpuid_deps() isn't super scientific.  I
placed it after, AFAICT, the overwhelming majority of cpu cap updates had
already been done, but before anything was likely to want the dependencies
to be processed.  Specifically, I couldn't find any set_cpu_caps() in the
machine check code, but there are definitely cpu_has() calls under
mcheck_cpu_init().

Last thought, patch 3 will conflict with at least one in-flight KVM series[*].
The conflict should be straightfoward to resolve, but at the same time this
is far from urgent, i.e. kicking this series down the road until KVM settles
down is totally ok.

[*] https://lore.kernel.org/all/20221130230934.1014142-1-seanjc@google.com

Sean Christopherson (3):
  x86/cpu: Process all CPUID dependencies after identifying CPU info
  x86/cpu: Mark SGX and VMX as being dependent on MSR_IA32_FEAT_CTL
  KVM: VMX: Drop manual checks on X86_FEATURE_MSR_IA32_FEAT_CTL

 arch/x86/include/asm/cpufeature.h |  1 +
 arch/x86/kernel/cpu/bugs.c        |  3 +--
 arch/x86/kernel/cpu/common.c      |  6 ++++++
 arch/x86/kernel/cpu/cpuid-deps.c  | 12 ++++++++++++
 arch/x86/kernel/cpu/feat_ctl.c    |  3 +--
 arch/x86/kvm/vmx/vmx.c            |  6 ++----
 6 files changed, 23 insertions(+), 8 deletions(-)


base-commit: d800169041c0e035160c8b81f30d4b7e8f8ef777
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

