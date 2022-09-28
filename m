Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7895EEA2E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 01:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbiI1XhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 19:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbiI1XhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 19:37:00 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A01CEFF6F
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 16:36:59 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id l72-20020a63914b000000b00434ac6f8214so8169981pge.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 16:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date;
        bh=1HjnVybSCmk8PN3Kx7J1WICZYKcCSPZ9vUMHNLgvNs0=;
        b=IusJICLcxEmdez2ty2Vz8B77a5JP1QBAG0cdW/ocVron3SMKgcwJgtG928TMMmumMe
         jXbX3CojoE1ImjmaPw/GIui5hJPueMiC5uSUfsucbk50zJvddSpaE9pDWnzHcPIJOiO/
         83zZjEE+4Aqrzz2xpavzNJDV2tNQX1AOHnC7FKCGFEJzJEC8UUpOSXAgCvNDEBWqkEzl
         GHBtOz/fgSW6UYpDPU16t/Rb9aPN5s/8vITkg1otK4GGW8pmB+qG3y9u+RSyluMEjXHY
         3YRB7h7YoLGmjdscr8v2LgJOTNThjYczBQoNvapq86atBPNdj+sqHLNoFUWN6G6MF5jK
         EQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date;
        bh=1HjnVybSCmk8PN3Kx7J1WICZYKcCSPZ9vUMHNLgvNs0=;
        b=Xv+JNeIzVsHu67TgSgnjj0Y33kf6YceuzALTG5kqQ3DvO4Jro9/rk9A+UXnQIDMcuN
         FaynyFHSNA8c8cwRk9Wgt7khT0JWa+HwfPbQSPN64EOtL4DGkU6oMuVEZshOtOj/4m58
         WS67SCZzkAvAe5z8WjGB701kwQn4c+3w09uXWAo40wXCqvWT2xgSwEfyCisMaUXI8h5C
         2ZFDjNnV++9K+nCAV/EauodYpue8pZHYkRW76CVEYFh9nd/5w3HUOfOFUC3jeZsvS6Lf
         flNO4LT8C/XHOmSGKEZBbORds3anq4onFUT84S/xSbiHHbInbMtIHkGgGfHjIau1CsY4
         aaxQ==
X-Gm-Message-State: ACrzQf2BWf1ImSDORvNaifktlSLJ/QCWH4/6dmIy8efDrmIuCu7LMmrB
        DUzUpFiog2wepRCrHc8sDqsByao/nlw=
X-Google-Smtp-Source: AMsMyM7c7CTUEAxcZIKJ3TaSJNeOpA/iJXEXySd+W0B9c+KaHrVi1iKNFO6imibHN2j7A4a4Txc/dgLEciw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:aa7:88c7:0:b0:542:3229:8d0f with SMTP id
 k7-20020aa788c7000000b0054232298d0fmr220106pff.74.1664408219026; Wed, 28 Sep
 2022 16:36:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 28 Sep 2022 23:36:48 +0000
In-Reply-To: <20220928233652.783504-1-seanjc@google.com>
Mime-Version: 1.0
References: <20220928233652.783504-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220928233652.783504-4-seanjc@google.com>
Subject: [PATCH v2 3/7] KVM: selftests: Remove unnecessary register shuffling
 in fix_hypercall_test
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Tom Rix <trix@redhat.com>, kvm@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Jones <andrew.jones@linux.dev>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Jim Mattson <jmattson@google.com>
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

Use input constraints to load RAX and RBX when testing that KVM correctly
does/doesn't patch the "wrong" hypercall.  There's no need to manually
load RAX and RBX, and no reason to clobber them either (KVM is not
supposed to modify anything other than RAX).

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
---
 .../selftests/kvm/x86_64/fix_hypercall_test.c | 22 +++++++------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c b/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
index e0004bd26536..6864eb0d5d14 100644
--- a/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
+++ b/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
@@ -30,14 +30,11 @@ static uint64_t svm_do_sched_yield(uint8_t apic_id)
 {
 	uint64_t ret;
 
-	asm volatile("mov %1, %%rax\n\t"
-		     "mov %2, %%rbx\n\t"
-		     "svm_hypercall_insn:\n\t"
+	asm volatile("svm_hypercall_insn:\n\t"
 		     "vmmcall\n\t"
-		     "mov %%rax, %0\n\t"
-		     : "=r"(ret)
-		     : "r"((uint64_t)KVM_HC_SCHED_YIELD), "r"((uint64_t)apic_id)
-		     : "rax", "rbx", "memory");
+		     : "=a"(ret)
+		     : "a"((uint64_t)KVM_HC_SCHED_YIELD), "b"((uint64_t)apic_id)
+		     : "memory");
 
 	return ret;
 }
@@ -47,14 +44,11 @@ static uint64_t vmx_do_sched_yield(uint8_t apic_id)
 {
 	uint64_t ret;
 
-	asm volatile("mov %1, %%rax\n\t"
-		     "mov %2, %%rbx\n\t"
-		     "vmx_hypercall_insn:\n\t"
+	asm volatile("vmx_hypercall_insn:\n\t"
 		     "vmcall\n\t"
-		     "mov %%rax, %0\n\t"
-		     : "=r"(ret)
-		     : "r"((uint64_t)KVM_HC_SCHED_YIELD), "r"((uint64_t)apic_id)
-		     : "rax", "rbx", "memory");
+		     : "=a"(ret)
+		     : "a"((uint64_t)KVM_HC_SCHED_YIELD), "b"((uint64_t)apic_id)
+		     : "memory");
 
 	return ret;
 }
-- 
2.37.3.998.g577e59143f-goog

