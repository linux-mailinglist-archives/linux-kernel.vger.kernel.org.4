Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD62C6D7138
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 02:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236489AbjDEAYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 20:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjDEAYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 20:24:04 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED56B44A2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 17:24:02 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id s4-20020a170902ea0400b001a1f4137086so20132723plg.14
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 17:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680654242;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p87TlfEWUQUWF/U6DKpIAcvgJ6qE5zvfkuSSXmWeaSM=;
        b=iGqgYLSCPieJJI3XpFkdhzJOZrloI3O0PZsey+G/ubf6sgL9079NDhuP9xRnCNF3Zw
         eqA58CZM0rrY63n6tsHxR+L2MpO4Wt0ziwh1mEDuGD2r9MAyuq30e/sHfqh//gBc49RW
         nFQDxf2nD1iVfByt5Ny71yg+0oimnHgyst5nXM/F0ByU0yVR/8M1kb3V4vSxlDyu2VuX
         fK/KJXrEybkQfW3x3UU6Ivny6UdWA4nUGA5V9j5z/sAnF+mzZtvSrZ6+PWhBiDxcRlHA
         RoMHP9dstV9Qa1DQDLhyhLpR5bE7vJI3gaeNbVtZO5+VXB5n1slWlZ2g07y2BlvfgkR9
         DdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680654242;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p87TlfEWUQUWF/U6DKpIAcvgJ6qE5zvfkuSSXmWeaSM=;
        b=pYy4Ju/zmvWMD77CRzbgHxcnLQ4w+X8H9lHWwI4lCMRqk7IoeCn4ecX2mO7a8OxyHp
         Ku6hXkJa2/LTdhEy3ebe7aDsDhee3Y0SckMNOTAoABYgauj5tu9ENpgIQHUKhPO+/rXt
         6o5uqsYc24AKpfjZng4y6JMQHIFPPeEbX4gaCfJa5GSuL9BRcZjey0tn48wnTGZfI8Fi
         HGjbM23xEd/tv+m7JTkF9dvmGfkKltR7VE9shZO7ynPc0kLpL0NEwX9TyI1HHOJn0hSm
         O73pIl2FG1Xy/6iNirwCaCLTYhgnk5+U09uPyB7pO8xVXT+cH+mrZyoTeLZ+8CLfvkVx
         Hpow==
X-Gm-Message-State: AAQBX9cX5bdcV94kW7cYxeh+RPO9O6mqhejWvLeql90DeYueRIgujNi/
        3HTbmWiSJkj2PclvLVJpB8FcKk3yA6A=
X-Google-Smtp-Source: AKy350YfAHD0tGEP8NKG3E+4x7j1V06lXO30sgxfIPzVVsRfGUHjdjyLPeoT5bsFgHDUQTvimcRQdy1nhBM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:4591:b0:234:acfd:c8da with SMTP id
 v17-20020a17090a459100b00234acfdc8damr1587177pjg.2.1680654242457; Tue, 04 Apr
 2023 17:24:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  4 Apr 2023 17:23:59 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230405002359.418138-1-seanjc@google.com>
Subject: [PATCH] KVM: nVMX: Emulate NOPs in L2, and PAUSE if it's not intercepted
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathias Krause <minipli@grsecurity.net>
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

Extend VMX's nested intercept logic for emulated instructions to handle
"pause" interception, in quotes because KVM's emulator doesn't filter out
NOPs when checking for nested intercepts.  Failure to allow emulation of
NOPs results in KVM injecting a #UD into L2 on any NOP that collides with
the emulator's definition of PAUSE, i.e. on all single-byte NOPs.

For PAUSE itself, honor L1's PAUSE-exiting control, but ignore PLE to
avoid unnecessarily injecting a #UD into L2.  Per the SDM, the first
execution of PAUSE after VM-Entry is treated as the beginning of a new
loop, i.e. will never trigger a PLE VM-Exit, and so L1 can't expect any
given execution of PAUSE to deterministically exit.

  ... the processor considers this execution to be the first execution of
  PAUSE in a loop. (It also does so for the first execution of PAUSE at
  CPL 0 after VM entry.)

All that said, the PLE side of things is currently a moot point, as KVM
doesn't expose PLE to L1.

Note, vmx_check_intercept() is still wildly broken when L1 wants to
intercept an instruction, as KVM injects a #UD instead of synthesizing a
nested VM-Exit.  That issue extends far beyond NOP/PAUSE and needs far
more effort to fix, i.e. is a problem for the future.

Fixes: 07721feee46b ("KVM: nVMX: Don't emulate instructions in guest mode")
Cc: Mathias Krause <minipli@grsecurity.net>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 9ae4044f076f..1e560457bf9a 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7898,6 +7898,21 @@ static int vmx_check_intercept(struct kvm_vcpu *vcpu,
 		/* FIXME: produce nested vmexit and return X86EMUL_INTERCEPTED.  */
 		break;
 
+	case x86_intercept_pause:
+		/*
+		 * PAUSE is a single-byte NOP with a REPE prefix, i.e. collides
+		 * with vanilla NOPs in the emulator.  Apply the interception
+		 * check only to actual PAUSE instructions.  Don't check
+		 * PAUSE-loop-exiting, software can't expect a given PAUSE to
+		 * exit, i.e. KVM is within its rights to allow L2 to execute
+		 * the PAUSE.
+		 */
+		if ((info->rep_prefix != REPE_PREFIX) ||
+		    !nested_cpu_has2(vmcs12, CPU_BASED_PAUSE_EXITING))
+			return X86EMUL_CONTINUE;
+
+		break;
+
 	/* TODO: check more intercepts... */
 	default:
 		break;

base-commit: 27d6845d258b67f4eb3debe062b7dacc67e0c393
-- 
2.40.0.348.gf938b09366-goog

