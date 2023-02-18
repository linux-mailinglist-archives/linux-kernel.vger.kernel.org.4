Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25D669B63C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 00:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjBQXKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 18:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjBQXK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 18:10:28 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D463BDBD
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 15:10:26 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id h25-20020a62b419000000b005a8da78efedso1135315pfn.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 15:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWbAijAwjOs1dOASNMUKGHIOkb526nV9RcP7YkJB9Ns=;
        b=WhHQy36bpmRvJXBYVOfOAWwdwJHCwlyKTRyy3I0PVfsHbY+/Y+/43gczwooXHaglfE
         RMoe13lzB41Bc29GFrb7l2FyDu8zLjPhmAbrV1jsdRe4x5wJVoEJQOfImGiymH4zeVFw
         jvog5mS4J8+ZQexJmjMtjNI/4IWMz9h9Dpy3EmQUjkpjcYfMm390C3tJJ0dek6hXOiAL
         gtVvtyPMd5RUOZuLtiThHXjzz8GUkL4/LocBJIuta6EmrGw9dqoHbPMmflmVo6/ncGiY
         UfL5HAhZv8VhfBo1iVbbln8INLN2E9WEv+/i85QjfiGY0oVembM/ttVwgr7SjMOpObOf
         /52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CWbAijAwjOs1dOASNMUKGHIOkb526nV9RcP7YkJB9Ns=;
        b=jX5X2qNh3vO/tu3tXKHvhEayZ3S1StXvMA43RNx5U6RcpTQwh8amavBYIDlTzDngpB
         KeQx9EUmlblcRbqulpMwutxOmPG5rUKb/KNmUBmqteci863twmm6WHy/PFoLNo9duUUn
         jyFD31bvxB2hLeArPpv+YgL0UgiB0EjXMYQ+qUhncct0WccdhkPEe3Gy+JDUhdfyAyHz
         4tkcW5tg1Ud0DxFbMQBLk6XTUx8UA9pN3LoyZXkv4rIQXkDrhZxoLr70OU9+WQ/R4mYF
         FdZTW0JQNpIwL20DphswbLRH1FnmPPRREXzc08S3OGzFctbZQ80j0IS/prHsYrxfRRW7
         wkug==
X-Gm-Message-State: AO0yUKX9seqrz3ce2DLD1IxfgoMXh7sFu6ZsDNXYDZ+GUPPCWWaMHHsq
        PSiHkz7d/qXPQELMaHlkmcORfmYVCOo=
X-Google-Smtp-Source: AK7set8+Jdq9DKIQ/mIYsrcjrM+N87no5sGYiFT53l6t8k8fTX7ghhKbbkZap0/a8uCiC18CRNR8qIwcAnE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:130d:b0:199:db3:9bcc with SMTP id
 iy13-20020a170903130d00b001990db39bccmr352181plb.11.1676675426500; Fri, 17
 Feb 2023 15:10:26 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 17 Feb 2023 15:10:10 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230217231022.816138-1-seanjc@google.com>
Subject: [PATCH 00/12] KVM: x86: Add "governed" X86_FEATURE framework
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
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

Add a framework to manage and cache KVM-governed features, i.e. CPUID
based features that require explicit KVM enabling and/or need to be
queried semi-frequently by KVM.  The idea originally came up in the
context of the architectural LBRs series as a way to avoid querying
guest CPUID in hot paths without needing a dedicated flag, but as
evidenced by the shortlog, the most common usage is to handle the ever-
growing list of SVM features that are exposed to L1.

Note, I don't like the name "governed", but it was the least awful thing I
could come up with.  Suggestions most definitely welcome.

This series is lightly tested.  I am posting somewhat speculatively to get
early feedback on the idea.

Sean Christopherson (12):
  KVM: x86: Add a framework for enabling KVM-governed x86 features
  KVM: x86/mmu: Use KVM-governed feature framework to track "GBPAGES
    enabled"
  KVM: VMX: Recompute "XSAVES enabled" only after CPUID update
  KVM: VMX: Rename XSAVES control to follow KVM's preferred "ENABLE_XYZ"
  KVM: x86: Use KVM-governed feature framework to track "XSAVES enabled"
  KVM: nSVM: Use KVM-governed feature framework to track "NRIPS enabled"
  KVM: nSVM: Use KVM-governed feature framework to track "TSC scaling
    enabled"
  KVM: nSVM: Use KVM-governed feature framework to track "vVM{SAVE,LOAD}
    enabled"
  KVM: nSVM: Use KVM-governed feature framework to track "LBRv enabled"
  KVM: nSVM: Use KVM-governed feature framework to track "Pause Filter
    enabled"
  KVM: nSVM: Use KVM-governed feature framework to track "vGIF enabled"
  KVM: x86: Disallow guest CPUID lookups when IRQs are disabled

 arch/x86/include/asm/kvm_host.h  | 11 ++++++
 arch/x86/include/asm/vmx.h       |  2 +-
 arch/x86/kvm/cpuid.c             | 31 +++++++++++++++++
 arch/x86/kvm/cpuid.h             | 51 ++++++++++++++++++++++++++++
 arch/x86/kvm/governed_features.h | 19 +++++++++++
 arch/x86/kvm/mmu/mmu.c           | 20 ++---------
 arch/x86/kvm/svm/nested.c        | 48 ++++++++++++++++-----------
 arch/x86/kvm/svm/svm.c           | 57 +++++++++++++++++++++-----------
 arch/x86/kvm/svm/svm.h           | 13 ++------
 arch/x86/kvm/vmx/capabilities.h  |  2 +-
 arch/x86/kvm/vmx/hyperv.h        |  2 +-
 arch/x86/kvm/vmx/nested.c        |  6 ++--
 arch/x86/kvm/vmx/nested.h        |  2 +-
 arch/x86/kvm/vmx/vmx.c           | 48 +++++++++++++--------------
 arch/x86/kvm/vmx/vmx.h           |  2 +-
 arch/x86/kvm/x86.c               |  4 +--
 16 files changed, 217 insertions(+), 101 deletions(-)
 create mode 100644 arch/x86/kvm/governed_features.h


base-commit: 62ef199250cd46fb66fe98267137b7f64e0b41b4
-- 
2.39.2.637.g21b0678d19-goog

