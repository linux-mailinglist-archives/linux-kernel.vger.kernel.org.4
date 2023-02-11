Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1EA1692C1A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 01:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjBKAfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 19:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBKAfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 19:35:38 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2659A1ADC5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 16:35:38 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id nn5-20020a17090b38c500b0023391b53fd5so1967248pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 16:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kx7i8JKzvZYRlaJwr/BZyRfMLt7H5oqW+SIrl30Jzpk=;
        b=HtlUvAlewBQgavZZheWnkdoCCzuAYbogFesYIG8C3zqmL/1Sruqpqwnc5kiWtAk0q1
         YhwDbhMWEqnuBBkr7D9zPgdTratdd4/eCOgnkt5IRgarN6qCAthL1vLb49mSqqSlaFmD
         oscifg8ZoFvN35nQfTRTgW+zfg5ucuFlDcwV/9gr/1zHtk0B7w8pBKDVJBWDi5O2EpGG
         +N2EEN1j5m7HDZ7qymrxhcYyTaCB4C8d31eFAZrWv/ZJ/k5r/LV72RgBcI/ZW2Wdc3BL
         iAb2E0OCOjE5mzOoGr2C8ka/76Q5yiPw3ijRigR9cBdTHj5Hi4d8LV28go+MlmKVuOtr
         8yIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kx7i8JKzvZYRlaJwr/BZyRfMLt7H5oqW+SIrl30Jzpk=;
        b=mCO6rvPLq7ZkRvBIWxByO4I1IuqKpPrCjV/h5MT+gtPQXfO8DCVw2Dxibsi98jGSuB
         v2SD3cCZ4XM2X2O3bhFR20YY487adenHNaR2aXcegSGCIsWpuUJKP3RBaFPY0GtuUqVl
         ysu2Xg+qWctrYEj7CvTUr98HoMCELqMUq4Ln4xLvw3lPdPOMm1myrkAMd/we2cvk2JMy
         mZ3AiSnkOeA79O99gZUvKRnXOVTWe8YtRTTyXlHnFPebluhu2yp70YGsheBGmvLLuCh2
         +7xS8nWEluVQKCQ/LVj3aiW3Vu9mIJjkbVOxMUF15zwdL+CKAd/POQjbp2owkebwwW4p
         DlLQ==
X-Gm-Message-State: AO0yUKUNaH8WfwaVVRT30B/jGm3iKsONhA1NiZ+07d7v7AEuguVHCQa+
        b9TvS/u/F2WAdOEqHRSXo+Cnn0CR50Y=
X-Google-Smtp-Source: AK7set+dejn0fTtjUrqtyBolrO1cB2OmasrvwQWwe+JyZjPZlrre7OEm8UZY00AeSueFpBmpZAxAyZYsF9Y=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d2c3:b0:199:3a88:9a18 with SMTP id
 n3-20020a170902d2c300b001993a889a18mr3380694plc.10.1676075737537; Fri, 10 Feb
 2023 16:35:37 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat, 11 Feb 2023 00:35:31 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230211003534.564198-1-seanjc@google.com>
Subject: [PATCH v2 0/3] KVM: VMX: Stub out enable_evmcs static key
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
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

Stub out and rename the eVMCS static key when CONFIG_HYPERV=n.  gcc (as of
gcc-12) isn't clever enough to elide the nop placeholder when there's no
code guarded by a static branch.  With gcc-12, because of the vast number
of VMCS accesses, eliminating the nops reduces the size of kvm-intel.ko by
~7.5% (200KiB).

Please holler if you would rather patch 3 be squashed into patch 2, i.e.
add the wrapper and rename the key in one go.  I split them because the
combined changelog was getting into "here's a list of changes" territory.

Patch 1 is tangentially related cleanup.

Applies on `git@github.com:kvm-x86/linux.git vmx`.

v2:
 - Collect reviews. [Vitaly]
 - Rename wrapper. [Vitaly, Paolo]
 - Rename key too.

v1: https://lore.kernel.org/all/20230208205430.1424667-1-seanjc@google.com

Sean Christopherson (3):
  KVM: nVMX: Move EVMCS1_SUPPORT_* macros to hyperv.c
  KVM: VMX: Stub out enable_evmcs static key for CONFIG_HYPERV=n
  KVM: VMX: Rename "KVM is using eVMCS" static key to match its wrapper

 arch/x86/kvm/vmx/hyperv.c  | 107 +++++++++++++++++++++++++++++++++-
 arch/x86/kvm/vmx/hyperv.h  | 115 +++----------------------------------
 arch/x86/kvm/vmx/vmx.c     |  17 +++---
 arch/x86/kvm/vmx/vmx_ops.h |  22 +++----
 4 files changed, 133 insertions(+), 128 deletions(-)


base-commit: 93827a0a36396f2fd6368a54a020f420c8916e9b
-- 
2.39.1.581.gbfd45094c4-goog

