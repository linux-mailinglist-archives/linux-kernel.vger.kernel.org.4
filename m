Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1AB6FFD51
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 01:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238254AbjEKXd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 19:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238825AbjEKXdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 19:33:55 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345766187
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 16:33:54 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-24de504c5fcso9128750a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 16:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683848033; x=1686440033;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWBa5UoNl959/fV09Pu2tQXDoTjc4KZDmFHiJRopDL8=;
        b=IDnQrsrVcjYEgvoHxnfgRTapyxsu8w0NdrB4rUL1b0X1vV/hwMOYnkBr98M1YCSAbc
         mdWL0Nfd4/7ddmPD4LQl8srniCaShM9ZJcTQWIvBvqZ87qaSlHqXyy9T70o872CUAjsO
         ayrEwV8rD+TXu2SnxzA65lP1+Jc3+kKVyJlo7jbVJP5K6XLaBZ0D5kR78gKqGtrpedZP
         B6C7lOsHW0dmU4y+o8Ts4pzC3dx9i7Ifb1U7zCL41DAweyQo4DuAWp1rIr2w9EUoyJQu
         CWUVhp/xFkEgtPlxPwZKvPy5c5NzkdZ1mYEov12uWvFDD0l45Cf5xFuTwTtZhEmIXF9u
         ik+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683848033; x=1686440033;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xWBa5UoNl959/fV09Pu2tQXDoTjc4KZDmFHiJRopDL8=;
        b=fznmcKYS+34tfyK50d/gAYLSpDLjf0MNjGhSYR9yufbuHc+hCZrTOdmsfZMUtJM2UC
         3lMa1omqJfW/bN2Zg1TZq4meo06eIb3my6o+2evoY9ogODXD91xl0s1JUP0AWymqfFbW
         9CTYrFHvWZ2ToPOUbX/QNJQNQECgw8/ZffECuk+jY0opG8z4yrYbrsllmej/6SXx6GUt
         KGbRj3jQpEC/0KgYz+VPXOxFOBcfO9l6Ef7hF5cE5OYRS7IBxaDBlJ+4c+FmuOOK2oXi
         oUaHXEkQ/OoElLndcYJu/AVQ/aBw2u7adA6i3rb+OF4m1XtPQLqsgMf1ULyAAGyolRik
         Y/ag==
X-Gm-Message-State: AC+VfDxbMjPiCO+aqPEQYtmZ86Db2tj3jqQOzsPfMlMJlfSkjLrTofcP
        6q64aWqaz6KTseqCOwJAHoAHXdYbZxg=
X-Google-Smtp-Source: ACHHUZ5jkLZhJlMIBlkVleQh4+VT4w/pturzHjqMGhXBEJ+8dgpy1rNQlhH4iMyoa6tLhG6gM17t9oAzV70=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:458f:b0:250:5385:26a9 with SMTP id
 v15-20020a17090a458f00b00250538526a9mr5989051pjg.1.1683848033787; Thu, 11 May
 2023 16:33:53 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 11 May 2023 16:33:43 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230511233351.635053-1-seanjc@google.com>
Subject: [PATCH v2 0/8] KVM: x86: Clean up MSR PAT handling
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai Huang <kai.huang@intel.com>,
        Wenyao Hai <haiwenyao@uniontech.com>,
        Ke Guo <guoke@uniontech.com>
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

Clean up KVM's handling of MSR PAT.  The PAT is currently lumped in with
MTRRs, and while the PAT does affect memtypes, it's not an MTRR and is
exempted from KVM's kludgy attempts to play nice with UC memory for guests
with passthrough devices that have non-coherent DMA (KVM does NOT set
"ignore guest PAT" in this case, and so the guest PAT is virtualized by
hardware, not emulated by KVM).

v2:
 - Move common bits of write path to kvm_set_msr_common(). [Kai]
 - Reword changelogs to call out that KVM enables hardware virtualization
   of guest PAT when the guest has non-coherent DMA. [Kai]
 - Clean up more open coded references to MTRR MSRs. [Yan]
 - Squash away the standalone WARN patch. [Kai]

v1: https://lore.kernel.org/all/20230503182852.3431281-1-seanjc@google.com

Ke Guo (1):
  KVM: SVM: Use kvm_pat_valid() directly instead of kvm_mtrr_valid()

Sean Christopherson (6):
  KVM: x86: Add helper to query if variable MTRR MSR is base (versus
    mask)
  KVM: x86: Add helper to get variable MTRR range from MSR index
  KVM: x86: Use MTRR macros to define possible MTRR MSR ranges
  KVM: x86: Move PAT MSR handling out of mtrr.c
  KVM: x86: Make kvm_mtrr_valid() static now that there are no external
    users
  KVM: x86: Move common handling of PAT MSR writes to
    kvm_set_msr_common()

Wenyao Hai (1):
  KVM: VMX: Open code writing vCPU's PAT in VMX's MSR handler

 arch/x86/kvm/mtrr.c    | 64 ++++++++++++++++++++----------------------
 arch/x86/kvm/svm/svm.c |  7 +++--
 arch/x86/kvm/vmx/vmx.c | 11 +++-----
 arch/x86/kvm/x86.c     | 17 ++++++++---
 arch/x86/kvm/x86.h     |  1 -
 5 files changed, 52 insertions(+), 48 deletions(-)


base-commit: 5c291b93e5d665380dbecc6944973583f9565ee5
-- 
2.40.1.606.ga4b1b128d6-goog

