Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BD5660B4C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 02:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236819AbjAGBKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 20:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjAGBKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 20:10:37 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242FF84BFC
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 17:10:34 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id y19-20020a056a00191300b0058217bbc6ceso1588118pfi.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 17:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=mibFabzzccOWFHvZzF9gZjAvnGdqXXCNlOd7ibqPXMo=;
        b=Ac3GJ2XIaMCOKz2fcIHHYQLW4or003PbEuf++u+IVgYr2HL+LiuZcIIM1SXtpitPrh
         /xQQvLFf/T6VMH7a+N7WDihvBlECtJGztYHKh0+bsf7ZWzhNBdBn2CWi8hf0lDSBa2T2
         zlTWlUuhoIFGr+FQuypFSa50VeHC34+hU4r3D+g1nbraUxMx5A/eIrrs8KdjzDSHklXx
         7Il1KDBtRt9fUCrLZ7D3XL5akPfN5IlAOgpkrfNSVbdEXeR35X7oPoetzr8d0TJrDQfx
         aqQ52f6PFyGbUYLMD7hKoDGVUpFt1y3gHe3Wp3IvDOLC8A2A1LKB0ihM/K2j4SYqkm4s
         +2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mibFabzzccOWFHvZzF9gZjAvnGdqXXCNlOd7ibqPXMo=;
        b=Dr1AB0D2iERyANH9zRC+uuC9mcI6nPbruqdnLUBOry1bL+oRPk1alGL9+hHGHmivx4
         npbkFesddR9iCos0wi4Espyd1vkn2I+fuaw4R1oElbQSBeGz4ugqLPpO8V7tRL5eVG8m
         Lyb1q0MadWVlpaPLNGwBqRBvVHr4p9wVGErIGXaQB0GCaY2LfGWjmkdyKghY1PW9kjr2
         EZBydiGIbWDzo1x8A3jlTQG8/g5j1H6zx/4deVjpiaclUMHjthU28kQ6QxESNiIL4p10
         VI48Lv0TMq13N4HMGRTE857bq4/FKutK0sheYYFIOIUiwyJSEWcCeu+cQamgxbfCSMgT
         zk2Q==
X-Gm-Message-State: AFqh2krgk9gL/03Kf+WnZbmeVXYAEPkgp0A0g6LXBNbZYDv9IIFSts26
        2/RFXtpvh8EFmMaKQM3TvYWsXnzLhWg=
X-Google-Smtp-Source: AMrXdXtb521S+skxNdLCASba5/s6+7XUmXir8cXXJat7hoNvT81DlgQ+AnnER0uVGwjLdN/JINI3h82Kr/w=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:dacb:b0:192:e0b2:2358 with SMTP id
 q11-20020a170902dacb00b00192e0b22358mr1216401plx.164.1673053833715; Fri, 06
 Jan 2023 17:10:33 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat,  7 Jan 2023 01:10:22 +0000
In-Reply-To: <20230107011025.565472-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230107011025.565472-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230107011025.565472-4-seanjc@google.com>
Subject: [PATCH 3/6] KVM: x86: Mark x2APIC DFR reg as non-existent for x2APIC
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Orr <marcorr@google.com>, Ben Gardon <bgardon@google.com>,
        Venkatesh Srinivas <venkateshs@chromium.org>
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

Mark APIC_DFR as being invalid/non-existent in x2APIC mode instead of
handling it as a one-off check in kvm_x2apic_msr_read().  This will allow
reusing "valid_reg_mask" to generate VMX's interception bitmaps for
x2APIC.  Handling DFR in the common read path may also fix the Hyper-V
PV MSR interface, if that can coexist with x2APIC.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index bf53e4752f30..c49b13418638 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1541,7 +1541,6 @@ static int kvm_lapic_reg_read(struct kvm_lapic *apic, u32 offset, int len,
 		APIC_REG_MASK(APIC_TASKPRI) |
 		APIC_REG_MASK(APIC_PROCPRI) |
 		APIC_REG_MASK(APIC_LDR) |
-		APIC_REG_MASK(APIC_DFR) |
 		APIC_REG_MASK(APIC_SPIV) |
 		APIC_REGS_MASK(APIC_ISR, APIC_ISR_NR) |
 		APIC_REGS_MASK(APIC_TMR, APIC_ISR_NR) |
@@ -1562,12 +1561,13 @@ static int kvm_lapic_reg_read(struct kvm_lapic *apic, u32 offset, int len,
 		valid_reg_mask |= APIC_REG_MASK(APIC_LVTCMCI);
 
 	/*
-	 * ARBPRI and ICR2 are not valid in x2APIC mode.  WARN if KVM reads ICR
-	 * in x2APIC mode as it's an 8-byte register in x2APIC and needs to be
-	 * manually handled by the caller.
+	 * ARBPRI, DFR, and ICR2 are not valid in x2APIC mode.  WARN if KVM
+	 * reads ICR in x2APIC mode as it's an 8-byte register in x2APIC and
+	 * needs to be manually handled by the caller.
 	 */
 	if (!apic_x2apic_mode(apic))
 		valid_reg_mask |= APIC_REG_MASK(APIC_ARBPRI) |
+				  APIC_REG_MASK(APIC_DFR) |
 				  APIC_REG_MASK(APIC_ICR2);
 	else
 		WARN_ON_ONCE(offset == APIC_ICR);
@@ -3141,9 +3141,6 @@ int kvm_x2apic_msr_read(struct kvm_vcpu *vcpu, u32 msr, u64 *data)
 	if (!lapic_in_kernel(vcpu) || !apic_x2apic_mode(apic))
 		return 1;
 
-	if (reg == APIC_DFR)
-		return 1;
-
 	return kvm_lapic_msr_read(apic, reg, data);
 }
 
-- 
2.39.0.314.g84b9a713c41-goog

