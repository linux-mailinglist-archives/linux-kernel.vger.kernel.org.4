Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D386C4DD1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjCVOdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjCVOdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:33:38 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFDE2203A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:33:09 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id ml17-20020a17090b361100b0023f9e99ab95so4338810pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679495587;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=mgjRw2vqD776E+w9tuKRfXvdxK+3w2cB2jqd6fV4eR0=;
        b=FxiRswSYb1AXIBDrqHHb62YcKg8xEq7PkbC7KXQ7NdhkfeEZgZkBHFtRMe84W7vbi/
         c9yBkEX6F18CjW3HPfDWUj1sLu8tNsHSVW04tKegTIAyJPII8StZnlEb+Ze7hyDRzATQ
         BTC2i1j8vwKuJcvQzUnavrvLcnDoqVNaJVT4tw8gSdj36UuPOGf/o6OCInPoAPIUOXEG
         iQP5UMebXnVilFniWBBqMzZxsinYhckqC5FB9agMR2ZWhPIo5YsTjuSykkkUzyLT1NJn
         HGXMOnsJLUYBw/MBpU0vxAWU2MXhb1PnuhDNRC0APHyRywsrSga0bVAdmbHrMOH0pUbz
         tYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679495587;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mgjRw2vqD776E+w9tuKRfXvdxK+3w2cB2jqd6fV4eR0=;
        b=zrYYmIBV+SGkQGTmW+vus17kfaq4GzSgRWOFbSfBlT6/qE984wVwW/z2cWYfnwrfdu
         X6eyR1Hnk/VkFuheOo3IVTbY2TptmJ5AQXbqIIcuYk3HdhzK6qO6x8qQ6p8AR60crT4K
         17AWV9FCIvJZLt+IGOWvM4xQAXBs+1NTDgBcp8X/MeXoQgw6Qytie5EzhyKEhg5jmccf
         K02lRQ6+QvlUzWXMOIDG821B9qRmSfoGIrMFf4DunahtUfL73t79gpu711+PPUQCHD+m
         KFEuHFbSP8047osU2WxeKOOD0u3w1le38cZdF1c91MGCGkuoxIuCYRToPuiFkmPFRzHo
         RrSw==
X-Gm-Message-State: AO0yUKXlyWYY+CL1Xw9sLava2cxtsJgxJCR/v2LJ7WkkKuncxO2Igk1U
        kA5coesyqVX4OoivD5RducLTLsdNOlU=
X-Google-Smtp-Source: AK7set/zopb4UnnO6BE7QGEU6opvZkEXwgsUFVCTUnw7s/gBLPACnvgnwmcq+NghzPXsWXnQf1j9QVq7x70=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:5082:0:b0:503:916f:3c99 with SMTP id
 r2-20020a655082000000b00503916f3c99mr833196pgp.10.1679495586826; Wed, 22 Mar
 2023 07:33:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 22 Mar 2023 07:33:00 -0700
In-Reply-To: <20230322143300.2209476-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230322143300.2209476-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <20230322143300.2209476-3-seanjc@google.com>
Subject: [PATCH 2/2] KVM: nVMX: Do not report error code when synthesizing
 VM-Exit from Real Mode
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxim Levitsky <mlevitsk@redhat.com>
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

Don't report an error code to L1 when synthesizing a nested VM-Exit and
L2 is in Real Mode.  Per Intel's SDM, regarding the error code valid bit:

  This bit is always 0 if the VM exit occurred while the logical processor
  was in real-address mode (CR0.PE=0).

The bug was introduced by a recent fix for AMD's Paged Real Mode, which
moved the error code suppression from the common "queue exception" path
to the "inject exception" path, but missed VMX's "synthesize VM-Exit"
path.

Fixes: b97f07458373 ("KVM: x86: determine if an exception has an error code only when injecting it.")
Cc: stable@vger.kernel.org
Cc: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 7c4f5ca405c7..14be92b3f34c 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3868,7 +3868,12 @@ static void nested_vmx_inject_exception_vmexit(struct kvm_vcpu *vcpu)
 		exit_qual = 0;
 	}
 
-	if (ex->has_error_code) {
+	/*
+	 * Unlike AMD's Paged Real Mode, which reports an error code on #PF
+	 * VM-Exits even if the CPU is in Real Mode, Intel VMX never sets the
+	 * "has error code" flags on VM-Exit if the CPU is in Real Mode.
+	 */
+	if (ex->has_error_code && is_protmode(vcpu)) {
 		/*
 		 * Intel CPUs do not generate error codes with bits 31:16 set,
 		 * and more importantly VMX disallows setting bits 31:16 in the
-- 
2.40.0.rc2.332.ga46443480c-goog

