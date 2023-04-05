Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859216D8B30
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 01:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbjDEXqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 19:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbjDEXqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 19:46:04 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F53B7684
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 16:45:59 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id z16-20020a170902d55000b001a06f9b5e31so22169359plf.21
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 16:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680738359;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C3FiFSj2DW7QCcfEdHRl2FpbvkGFlMTLZXLRiPlpQOA=;
        b=kzWXb206+DPAGRlHNfajqdPAu56I4sQ/oSzZna3XW7CCIrbaRTz1FJ1k/xjq+NB5Bo
         399kCrZ2lNU26W3rApcqaM6JIjh8I4K47bNacsDM2bSQvC4SHSWlSRB88/PdnJfCF94p
         8blR3NdNXER1b/kBMmE0phFKwhFQDCSzQHoEP5o5Jz6xSxFvVuTMjq97m7b6GSnKhDw+
         LXOhZ3dj5ycdHzUcFFB6G6BPh0vuocE+1fxPtd3BmXi8GjGZDi4Jv3izx2paVkt5LHAa
         wbBMqakvOf4Ie1hb6cD0fTYIe4RevYB66RaIz3W//0RXGqm3PgjlcbE4qrYeNnCE5Q8B
         Yv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680738359;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C3FiFSj2DW7QCcfEdHRl2FpbvkGFlMTLZXLRiPlpQOA=;
        b=8Ecgs6IuXeCWDfjdRRBf6Vn6uHGV5KqHpHQT8XHlN0Khw1u50Va6iI085IreYOOFlC
         Y1mOfs6+EtCnpT5h4d+3OHemM1oFPk+mfJxDex+mmkOAy1jrwUi88hhFkpBlMY4CCxxD
         YxDpZ7fgVXox9UoceZjkPYwLmg6aUPrHwjrfDJf9+wSxJRw24mLCNanEg76nmfn6axH0
         ksYByejeylA/cXfq/rlguRHm9ZsnIKon4m8CMug/BK/5pTwZ5Q5n02qRG7lAl8giSTRS
         gCxQ7St4KdmWHIkjWB6TX7GWS72xwwFcyFg640t9iZIq42vZtLCGXodT4jUBs60B5nHG
         p0og==
X-Gm-Message-State: AAQBX9dtCv6JEVg7jeHU+5aDDL0fOLE8pvfLzm4d88rcSUj29EKWF4Pz
        ScrXTSRLm19BelzrQmIw4d+dvph1bMw=
X-Google-Smtp-Source: AKy350YKp2UCp0PHFbv2II78OIaWEueDMkGj0ycSIg/7gnLZ9lAUo9whG2vghjeYUv45/S5Jn0WA18C2s+o=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:d201:b0:240:d8d8:12c4 with SMTP id
 o1-20020a17090ad20100b00240d8d812c4mr2810027pju.3.1680738359091; Wed, 05 Apr
 2023 16:45:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  5 Apr 2023 16:45:54 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230405234556.696927-1-seanjc@google.com>
Subject: [PATCH 0/2] KVM: VMX: Fixes for faults on ENCLS emulation
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Binbin Wu <binbin.wu@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Found-by-inspection (when reviewing Binbin's patch) fixes for incorrect
emulation of faults when KVMintercepts and emulates (sort of) ENCLS.

Very much compile tested only.  Ideally, someone with SGX hardware can
confirm that these patches are correct, e.g. my assessment that KVM needs
to manually check CR0.PG is based purely of SDM pseudocode.

Sean Christopherson (2):
  KVM: VMX: Inject #GP on ENCLS if vCPU has paging disabled (CR0.PG==0)
  KVM: VMX: Inject #GP, not #UD, if SGX2 ENCLS leafs are unsupported

 arch/x86/kvm/vmx/sgx.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)


base-commit: 27d6845d258b67f4eb3debe062b7dacc67e0c393
-- 
2.40.0.348.gf938b09366-goog

