Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE72464AF99
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 07:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbiLMGJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 01:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbiLMGJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 01:09:18 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774EC1A3A0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 22:09:17 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id b6-20020a17090acc0600b0021a1a90a3e0so1358922pju.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 22:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=00eaw7kjaxrGW1SYs5Ps4MIsZuAaNvLwF151/5eMIQ0=;
        b=ZiDwtQduj6UUgneRNrcM2q4j5Rp8B7OEOpXLD8GMpb8pIJEX/XAi9SMo2TYub345DW
         EbeUkka48R8J9ziaRCV5GAJWNfzM8FlId8NpQhRKtNjKur9X6xkKjiGm4PmLQcqztGg8
         rAqNrgOqEmIFy+LQKqNqLzal1HIx3PgINz1ARCBOHbJRreasrZZDqm4SR2ltzSqfLZ01
         bM0+juSyLOsF9jU1ZRpZxsQmpud770K0vDljEu/QJHKEJBeeV2uXh+oKPqYwcc1sbrTI
         XRTJ0wZN+z6HGSGSzVi7ueYdoACrEhAhBfPBUzvzur6HUhN1ycPY45dAD0VCc92EK2/D
         wZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=00eaw7kjaxrGW1SYs5Ps4MIsZuAaNvLwF151/5eMIQ0=;
        b=i1Lmk2iCFWsb6PwZb6E3WTQ1FoOO+2CbH+jdJrURXEiI4dpp6N6jTf/Mwqi+U0uvUY
         1kz9JG1yLc2HyK1epDSeYp4OW8UJR1jaeF3nDqsjAr5yhM5DBsyk81l2puvWv0811/MC
         ScpPvfQq4mJvk42r+Qp7puVT1RJBIPV5sCzun6vq/SM1sSQAKeUTQem7QscRcPMW6je4
         21kLA19gkdKgDGRsM+Vonv05nwctYU0QzvF5ogwX/3rgTG55qIBj0TeWG9kDTGRv5lbS
         itoX88EufXmmmIIXxksOdWMf5CRcXZjNXubUuvaWxuwUUOKbdW010rBsczfKihR6l7Gv
         u6JQ==
X-Gm-Message-State: ANoB5pmbNz1khqb9FrS1I1ye+znnOF6pMPRELOLYZzjtqblMnsme9wH5
        2Z9ikq/tOUUrqudhkuktMadn6iYCM4Y=
X-Google-Smtp-Source: AA0mqf4N/hxZfxxmDQuwGXbm2CwczaKa4zvapR7+bpfyj468j/z2um9wZ+7zNjRSYncTuQ3SPdq/aXWiU24=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1010:b0:219:1d0a:34a6 with SMTP id
 gm16-20020a17090b101000b002191d0a34a6mr22501pjb.1.1670911756751; Mon, 12 Dec
 2022 22:09:16 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 13 Dec 2022 06:09:05 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221213060912.654668-1-seanjc@google.com>
Subject: [PATCH 0/7] KVM: VMX: Handle NMI VM-Exits in noinstr section
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
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

Move NMI VM-Exit handling into vmx_vcpu_enter_exit() to fix a (mostly
benign?) bug where NMIs can be unblocked prior to servicing the NMI that
triggered the VM-Exit, e.g. if instrumentation triggers a fault and thus
an IRET.  I deliberately didn't tag any of these for stable@ as the odds
of me screwing something up or of a backport going sideways seems higher
than out-of-order NMIs causing major problems.

The bulk of this series is just getting various helpers/paths ready for
noinstr usage.

I kept the use of a direct call to a dedicated entry point for NMIs
(doubled down really).  AFAICT, there are no issues with the direct call
in the current code, and I don't know enough about FRED to know if using
INT $2 would be better or worse, i.e. less churn seemed like the way to
go.  And if reverting to INT $2 in the future is desirable, splitting NMI
and IRQ handling makes it quite easy to do so as all the relevant code
that needs to be ripped out is isolated.

Sean Christopherson (7):
  KVM: x86: Make vmx_get_exit_qual() and vmx_get_intr_info()
    noinstr-friendly
  KVM: VMX: Allow VM-Fail path of VMREAD helper to be instrumented
  KVM: VMX: Always inline eVMCS read/write helpers
  KVM: VMX: Always inline to_vmx() and to_kvm_vmx()
  x86/entry: KVM: Use dedicated VMX NMI entry for 32-bit kernels too
  KVM: VMX: Provide separate subroutines for invoking NMI vs. IRQ
    handlers
  KVM: VMX: Handle NMI VM-Exits in noinstr region

 arch/x86/include/asm/idtentry.h | 16 +++-----
 arch/x86/kernel/nmi.c           |  8 ++--
 arch/x86/kvm/kvm_cache_regs.h   | 12 ++++++
 arch/x86/kvm/vmx/hyperv.h       | 20 ++++-----
 arch/x86/kvm/vmx/vmcs.h         |  4 +-
 arch/x86/kvm/vmx/vmenter.S      | 72 ++++++++++++++++++---------------
 arch/x86/kvm/vmx/vmx.c          | 55 +++++++++++++------------
 arch/x86/kvm/vmx/vmx.h          | 18 ++++-----
 arch/x86/kvm/vmx/vmx_ops.h      |  2 +
 arch/x86/kvm/x86.h              |  6 +--
 10 files changed, 117 insertions(+), 96 deletions(-)


base-commit: 208f1c64e255fe3a29083880818e010ebdf585c6
-- 
2.39.0.rc1.256.g54fd8350bd-goog

