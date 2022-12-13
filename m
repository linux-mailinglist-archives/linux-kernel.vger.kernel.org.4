Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C1464AFD1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 07:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbiLMGX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 01:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234525AbiLMGXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 01:23:15 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820001EC5D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 22:23:12 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id v16-20020a17090a899000b00219b1f0ddebso1654545pjn.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 22:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=xpAFKvB8lvIQpaVxTS6tufVVMA31FNLaaXAC6TQTGY0=;
        b=oFGD4qRNRi6VXtY0kRe7eFrSaArJEW4f+KOHPxB3gKalas9/u/awxp+QVtZ9r1SbUQ
         9rbjEb04snoOV3Ev+Ujjtn0J8/qaA1dbERaKg0+gqnkuDLD+thmjG/uq7lIlIC2jlu5w
         keKmJRcSVKn3s8MrN6bx4OLfvRjhSB8UizV/T2TWovz2mI/AbzkePdSfgD7gTBk2EeoW
         P6nV934lstf8TrEpliFRBMLQtYCZGSkPRZ3XrHS0M9s8cQ3FnaIfDZQ3GirqdfUPBBPX
         dsc22tm77I5APAXxVR7jzWnqQ5AuhYyT6BsJzi9BBhCXSq55ZrN7Y0AgYMykha+PbVzU
         CFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xpAFKvB8lvIQpaVxTS6tufVVMA31FNLaaXAC6TQTGY0=;
        b=jutMGjaztmqWitqmKgLb5tDv9K4Katr8Jdi9o9BIOdBQiWz9GwEDGZnvz1+Vb8zj23
         vHyafV1wCR8Rz0w7kXXsBub2r9Tj95Uc9rrIJEzNoQV3hdq0ykmuNiBBhKjAliKtq4ni
         Znqk9ua5tOCo5ACLVSsnrrZyxav2F0BtjLAYjxnXPcCWqo5rHzNRBr7vyTaoIG4wrh9K
         +8O4SJ13brcud+aBYWCTvhme+wpicdaga3O/6NMZeO4+bU2MO+Bb6fJPwvtkXkW2gP2u
         ttv8gQKAwgAXL4/XrVYhgAFIOxDDbKWNAXIqtoppgU4SreL00Gxw20eqMBFbqfH23MB8
         Xacg==
X-Gm-Message-State: ANoB5pmzEpSkIjy5O/po2DEpdJoZlW8+/DjA0J5H4TuVyXlSrUcHOgc2
        dnM/zeO/f6tNG6clm1/pVUbSgUmDZSU=
X-Google-Smtp-Source: AA0mqf62cnnFK3ssRKlOJtxDrUhAR9tUtDBU7ZDQbMhF84FsNt/OaAsTeGtcWgVds6JcUuj8zKRqdFIaW6U=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a62:e402:0:b0:577:62a8:f7a1 with SMTP id
 r2-20020a62e402000000b0057762a8f7a1mr9037249pfh.2.1670912592063; Mon, 12 Dec
 2022 22:23:12 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 13 Dec 2022 06:23:04 +0000
In-Reply-To: <20221213062306.667649-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221213062306.667649-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221213062306.667649-3-seanjc@google.com>
Subject: [PATCH v2 2/4] KVM: nVMX: Don't stuff secondary execution control if
 it's not supported
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aaron Lewis <aaronlewis@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>
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

When stuffing the allowed secondary execution controls for nested VMX in
response to CPUID updates, don't set the allowed-1 bit for a feature that
isn't supported by KVM, i.e. isn't allowed by the canonical vmcs_config.

WARN if KVM attempts to manipulate a feature that isn't supported.  All
features that are currently stuffed are always advertised to L1 for
nested VMX if they are supported in KVM's base configuration, and no
additional features should ever be added to the CPUID-induced stuffing
(updating VMX MSRs in response to CPUID updates is a long-standing KVM
flaw that is slowly being fixed).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index fe5615fd8295..13d3f5eb4c32 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4459,6 +4459,16 @@ vmx_adjust_secondary_exec_control(struct vcpu_vmx *vmx, u32 *exec_control,
 	 * controls for features that are/aren't exposed to the guest.
 	 */
 	if (nested) {
+		/*
+		 * All features that got grandfathered into KVM's flawed CPUID-
+		 * induced manipulation of VMX MSRs are unconditionally exposed
+		 * to L1 if the feature is supported by KVM (for nested).  I.e.
+		 * KVM should never attempt to stuff a feature that isn't
+		 * already exposed to L1 for nested virtualization.
+		 */
+		if (WARN_ON_ONCE(!(vmcs_config.nested.secondary_ctls_high & control)))
+			enabled = false;
+
 		if (enabled)
 			vmx->nested.msrs.secondary_ctls_high |= control;
 		else
-- 
2.39.0.rc1.256.g54fd8350bd-goog

