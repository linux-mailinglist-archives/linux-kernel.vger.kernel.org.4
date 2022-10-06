Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683175F5E07
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 02:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiJFAvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 20:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJFAv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 20:51:29 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9656C3FEEE
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 17:51:28 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id y16-20020a17090322d000b0017848b6f556so170359plg.19
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 17:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WnkFRYI3eJqIEc9TjrDzhbTyBFciEsjQYTxh7eIavg0=;
        b=sH4seICdCFuR5vlhMs0sCQYGy7u5dK5JGDCmFwh/JpdiSc8WWUpfRx1nNm5oBt3C5+
         Yp7nJisf2S3ZSVUNujpcHmlN0H/qbue9GIkju8L7alxEHjLlMTw5aHo3D3NQ36sK3wib
         h0CiAgf6aO+CJ7We7bUO5E3jyjYH5i5K5845D5u99VKiAmucf/pN3lmb52OmPAD1dIza
         7NZwIeDhWeG0tyYnbZmLA8KDix+pdb0GmEe/IckUmfKdM7Agm1TGsYlnhPixG0VMS3PP
         /4HGVoPMZh4pXgPKLPMC6K/seZlk8ufAzjmrFsD6txSkjGXQr13N03KkOrUHmC4XdWje
         Ay8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WnkFRYI3eJqIEc9TjrDzhbTyBFciEsjQYTxh7eIavg0=;
        b=XacZIjHOSBOG4M7whpFw6K65ralkoWwwVJqs+VhyFA6sgoblpvA/v0wRUSzno8SfW0
         6SEAJH37iAger3Upww0ywnz+fZG1TyY7ciJljFPpzLoHhTfXQBqr8rFMsLxRjASXR+Wx
         9ijr1GHWudQ8kp2oMO7bHDIGxLoFEnqO7DD1uRaEqGksSmfE0Gc7IBbiZWSVlHyP+vse
         A1CZQHHG3L9t50LvCL/T+ggiTVtuYZvFfB07S2vISPelynik3zjr4huo01Uu9LAkFlok
         K48l0BqYLzoAkMTtjmhXG8IVNoEBut7FOygaWwq9j4ZbUEbvBJRDg474OtPSyvBPerE7
         BW5Q==
X-Gm-Message-State: ACrzQf0pOQfb02eDshTy/gqND7KQleYdy4kGEffUPDTO1WqvHFW09fHf
        +J9ia7weXvjdx0TVl0kJ9GBunT9Drvs=
X-Google-Smtp-Source: AMsMyM5fZECI21o2xElw79wuYfAxdQeywyYdvqvBMHJXJ2cmGWzn2+4F0ruZ98Sl9cVbanZcYWqextjj4yQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:7589:b0:178:4ded:a90a with SMTP id
 j9-20020a170902758900b001784deda90amr2114400pll.74.1665017488198; Wed, 05 Oct
 2022 17:51:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  6 Oct 2022 00:51:13 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221006005125.680782-1-seanjc@google.com>
Subject: [PATCH 00/12] KVM: selftests: Add X86_PROPERTY_* magic
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
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

Extend the X86_FEATURE_* magic to multi-bit values, which I'm
calling "properties" (feel free to suggest a better name).  The basic
concept, and even the core code, is the same, the difference is really
just one bit versus many bits.

The main goal is to move away from open coding CPUID checks, which
almost always end up needing a comment to explain what all the magic
numbers mean.

Sean Christopherson (12):
  KVM: selftests: Add X86_FEATURE_PAE and use it calc "fallback"
    MAXPHYADDR
  KVM: selftests: Refactor X86_FEATURE_* framework to prep for
    X86_PROPERTY_*
  KVM: selftests: Add X86_PROPERTY_* framework to retrieve CPUID values
  KVM: selftests: Use X86_PROPERTY_MAX_KVM_LEAF in CPUID test
  KVM: selftests: Refactor kvm_cpuid_has() to prep for X86_PROPERTY_*
    support
  KVM: selftests: Add kvm_cpu_*() support for X86_PROPERTY_*
  KVM: selftests: Convert AMX test to use X86_PROPRETY_XXX
  KVM: selftests: Convert vmx_pmu_caps_test to use X86_PROPERTY_*
  KVM: selftest: Add PMU feature framework, use in PMU event filter test
  KVM: selftests: Add dedicated helpers for getting x86 Family and Model
  KVM: selftests: Add and use KVM helpers for x86 Family and Model
  KVM: selftest: Drop helpers for getting specific KVM supported CPUID
    entry

 .../selftests/kvm/include/x86_64/processor.h  | 279 ++++++++++++++----
 .../selftests/kvm/lib/x86_64/processor.c      |  60 ++--
 tools/testing/selftests/kvm/x86_64/amx_test.c | 105 ++-----
 .../testing/selftests/kvm/x86_64/cpuid_test.c |  11 +-
 .../kvm/x86_64/pmu_event_filter_test.c        |  74 ++---
 .../selftests/kvm/x86_64/vmx_pmu_caps_test.c  |  19 +-
 6 files changed, 304 insertions(+), 244 deletions(-)


base-commit: e18d6152ff0f41b7f01f9817372022df04e0d354
-- 
2.38.0.rc1.362.ged0d419d3c-goog

