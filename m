Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEE96D71C0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 02:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236464AbjDEA7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 20:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236441AbjDEA7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 20:59:17 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209CF1BEA
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 17:59:16 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id m12-20020a62f20c000000b0062612a76a08so15330951pfh.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 17:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680656355;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=PLGWC8bjiCbqzAe+2LaZO4qsM4GvEpJuy8h3g8GekVY=;
        b=gVF/Uw+gSqX3uWJdb16W3jVtNtrHQr6D5L84MS4xLmhm6IUvTa+93i6w1I25DZf4jn
         Dd1bzqEFttWNNPRb2DarphJkl8zKFFr8zKOA40L4od5qv9oEiDk6r831QpejBKnHq82l
         QYDAmQMYSzK6Lsq3wcLlP9WOuQ7+7wabq1HlZ0KW799j4S/VLiKMFNovN864xvln0wsK
         zbj9mWBagl/UDX0m4r9S1vwH1AESsE7ei8c2dOcn16xkglwtPbFQu+18tgu1fsvxVtO7
         2pTCFma2FYLBy6j4N/P0bLvYFixRklR/5aUe3TcS4tttEcpVZUXYMwkjQd4DH/EW1NSA
         6A+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680656355;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PLGWC8bjiCbqzAe+2LaZO4qsM4GvEpJuy8h3g8GekVY=;
        b=3wVAgyJuqG+jIuTxKssxjjf14FNoScjr4bj6ZywZY/kVk3aYVmHMts0utgUsXbIsvm
         zutmfbxhJHZufFdrDkWaYNsi7h/iGK9Qp3W4796sG8WyFA4J3N4rJbUba/N3qh/d8RRn
         ZdsqLjyBv1W7a6YvoQK8dquNNel9oL5KjdO7gLAtClUdUI9dBqH10WZ109UnR34PWW/U
         PK/+OYhnIGHAMHTTkljBblQXp04ovRPWWAi2H6o9iudFvW6XMkG4idiPs9SLoWvfEOig
         SWkt0yF98ZKy9cktBnGKdlRQYrlWG81MWUALwWAQDg50DFqEkAuYYX0qGmhBTO0ourAq
         NI4g==
X-Gm-Message-State: AAQBX9cHALs2Y5Tx40rn2X/bMD0xrbghcXXlqHjtV8QNTdO28anwAfHb
        v9m+QxhQpHA/xcgSFZ5abPmohBNhPwQ=
X-Google-Smtp-Source: AKy350ZaLTwZZ7Nu7h7VHdQNkGWLwPnrq0b5Kmy2qcCwu1Og97TzlIePBRKM/OfG8sO3ljemnfl/inAcYkE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:4c1f:0:b0:4fb:1f2a:e6c6 with SMTP id
 z31-20020a634c1f000000b004fb1f2ae6c6mr1346195pga.2.1680656355579; Tue, 04 Apr
 2023 17:59:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  4 Apr 2023 17:59:09 -0700
In-Reply-To: <20230405005911.423699-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230405005911.423699-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230405005911.423699-2-seanjc@google.com>
Subject: [PATCH 1/3] KVM: VMX: Don't rely _only_ on CPUID to enforce XCR0
 restrictions for ECREATE
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
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

Explicitly check the vCPU's supported XCR0 when determining whether or not
the XFRM for ECREATE is valid.  Checking CPUID works because KVM updates
guest CPUID.0x12.1 to restrict the leaf to a subset of the guest's allowed
XCR0, but that is rather subtle and KVM should not modify guest CPUID
except for modeling true runtime behavior (allowed XFRM is most definitely
not "runtime" behavior).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/sgx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/sgx.c b/arch/x86/kvm/vmx/sgx.c
index aa53c98034bf..362a31b19b0e 100644
--- a/arch/x86/kvm/vmx/sgx.c
+++ b/arch/x86/kvm/vmx/sgx.c
@@ -175,7 +175,8 @@ static int __handle_encls_ecreate(struct kvm_vcpu *vcpu,
 	    (u32)attributes & ~sgx_12_1->eax ||
 	    (u32)(attributes >> 32) & ~sgx_12_1->ebx ||
 	    (u32)xfrm & ~sgx_12_1->ecx ||
-	    (u32)(xfrm >> 32) & ~sgx_12_1->edx) {
+	    (u32)(xfrm >> 32) & ~sgx_12_1->edx ||
+	    xfrm & ~vcpu->arch.guest_supported_xcr0) {
 		kvm_inject_gp(vcpu, 0);
 		return 1;
 	}
-- 
2.40.0.348.gf938b09366-goog

