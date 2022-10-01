Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1628D5F17BC
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 02:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbiJAA7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 20:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbiJAA7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 20:59:37 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528391AF92B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 17:59:26 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id p24-20020a63f458000000b0043cd718c49dso3721000pgk.15
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 17:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date;
        bh=eHH9N5KGHEqvEJkVzA/2lRA7fGLp5p5N5cp+MpeWrmU=;
        b=oES2VGRX/fcHEWvWSMYz/FdTQ0OKgPYd4v+iN4OFWl1IvhmYESW3NBjbNFaIdJ/bc0
         epzv5I5/opNN4plUCwp/qYOtZv1DfDMXAZxiZyRZhrM7APaIVeu9uz5PhZzZiCld620J
         eyD8edykEHEnVYOFR8IuQaIveJekH4MhThfWDLI0ic9yXoOAHw233lq/UhVlKdQLCn/K
         mwqm0aU5pMBfaWIQjD8u6tcGNVwl+KBwWFIEh9j4+F06yIQZ0DhcO49ZsIOMeYMSt+9M
         59SWBXBkw97W1ZYknJpjSCFRrGzI2F0iek+X/4zV9nIcUaidiL1ZOqlNGALmqxy930Ky
         uieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date;
        bh=eHH9N5KGHEqvEJkVzA/2lRA7fGLp5p5N5cp+MpeWrmU=;
        b=7SWPF6FKQ989ztobxYNr3gIchRGTywc1qw4ymntMtHddHpORHOo/gaR9qhAAKWnaZm
         NxBwhWcK4E+Rg3rNEHUnQzmumTOrN43hRX09cGyHl9pJNyv3TUGSGFuHAjNplR1WX9vi
         1b6FEchnjbW3LhFBHUeVnYTSQQjTda63HJ7kV1RKXNO4BafmuxnNAs3Y/+gpGtEUAdoA
         0ACOJb4ELqDf11VdGUyMU0HCcZYwsE+X+EwIdVYHKLWfiuudechuKC6TD91YJfNSmvCW
         PGE9GstwhILEFjB6CtJqfbRgkA1i06yLhZXylVZwlFnwXfxK2ek95t9kAE0IAAUKB1uL
         xPFQ==
X-Gm-Message-State: ACrzQf0wucI9La8OU4491ZIigPFTTkZvXM3+Lw/pwSHJEqKxC8PNrUwJ
        apDcOAbYrZZk5YR7vnODhzGuSWgt/Nk=
X-Google-Smtp-Source: AMsMyM6DwQfJMtryfb4tmACAzG5TUNWBuDoHaHgLRZczqgpN6QW9JK4bBXHGK5ix9mIsnS/ZONNBqmP68/w=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d4d2:b0:17d:d70:8045 with SMTP id
 o18-20020a170902d4d200b0017d0d708045mr3380998plg.73.1664585965378; Fri, 30
 Sep 2022 17:59:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat,  1 Oct 2022 00:58:47 +0000
In-Reply-To: <20221001005915.2041642-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221001005915.2041642-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221001005915.2041642-5-seanjc@google.com>
Subject: [PATCH v4 04/32] KVM: SVM: Process ICR on AVIC IPI delivery failure
 due to invalid target
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Li RongQing <lirongqing@baidu.com>
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

Emulate ICR writes on AVIC IPI failures due to invalid targets using the
same logic as failures due to invalid types.  AVIC acceleration fails if
_any_ of the targets are invalid, and crucially VM-Exits before sending
IPIs to targets that _are_ valid.  In logical mode, the destination is a
bitmap, i.e. a single IPI can target multiple logical IDs.  Doing nothing
causes KVM to drop IPIs if at least one target is valid and at least one
target is invalid.

Fixes: 18f40c53e10f ("svm: Add VMEXIT handlers for AVIC")
Cc: stable@vger.kernel.org
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 712330b80891..3b2c88b168ba 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -502,14 +502,18 @@ int avic_incomplete_ipi_interception(struct kvm_vcpu *vcpu)
 	trace_kvm_avic_incomplete_ipi(vcpu->vcpu_id, icrh, icrl, id, index);
 
 	switch (id) {
+	case AVIC_IPI_FAILURE_INVALID_TARGET:
 	case AVIC_IPI_FAILURE_INVALID_INT_TYPE:
 		/*
 		 * Emulate IPIs that are not handled by AVIC hardware, which
-		 * only virtualizes Fixed, Edge-Triggered INTRs.  The exit is
-		 * a trap, e.g. ICR holds the correct value and RIP has been
-		 * advanced, KVM is responsible only for emulating the IPI.
-		 * Sadly, hardware may sometimes leave the BUSY flag set, in
-		 * which case KVM needs to emulate the ICR write as well in
+		 * only virtualizes Fixed, Edge-Triggered INTRs, and falls over
+		 * if _any_ targets are invalid, e.g. if the logical mode mask
+		 * is a superset of running vCPUs.
+		 *
+		 * The exit is a trap, e.g. ICR holds the correct value and RIP
+		 * has been advanced, KVM is responsible only for emulating the
+		 * IPI.  Sadly, hardware may sometimes leave the BUSY flag set,
+		 * in which case KVM needs to emulate the ICR write as well in
 		 * order to clear the BUSY flag.
 		 */
 		if (icrl & APIC_ICR_BUSY)
@@ -525,8 +529,6 @@ int avic_incomplete_ipi_interception(struct kvm_vcpu *vcpu)
 		 */
 		avic_kick_target_vcpus(vcpu->kvm, apic, icrl, icrh, index);
 		break;
-	case AVIC_IPI_FAILURE_INVALID_TARGET:
-		break;
 	case AVIC_IPI_FAILURE_INVALID_BACKING_PAGE:
 		WARN_ONCE(1, "Invalid backing page\n");
 		break;
-- 
2.38.0.rc1.362.ged0d419d3c-goog

