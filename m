Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BB35EEA37
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 01:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbiI1Xhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 19:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbiI1Xh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 19:37:27 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947F5F5974
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 16:37:06 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id g66-20020a636b45000000b0043a256d3639so8164967pgc.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 16:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date;
        bh=C5F/Oxrj/QY+Y5WS5RDePmofQ3U7kPV+RzOaucqwWdo=;
        b=kX81y2OmYgmpdTE1459Tlczk75TEKDFxBkJVeW0iAfDcW5eArglHzzmSvcQF44u5aG
         bIK8OG6sadvcY97Qsk02K5Vg0O/68uoyFhcrtc4B4+k0qG1EV5h6Kcljg5DiiSP7iHaT
         81nhQe+1jty/XsqqG9/zIlECdDSWNVsqATBXurLkbMsGtyOy16lZjrU652PtuOgiUafv
         M3Ama6QQJ+aBPmI0q8rwy2JgIzJvjrKoWpLW9thsW5Rea473nl9DA7//riN4T4m7zc33
         RXpyng5aYm1NmyQf+l+BYZtcRWrmKn1IHsfvTIkngF7RzWmZ/VqE0HKWJ3d9QMS3BLsf
         E7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date;
        bh=C5F/Oxrj/QY+Y5WS5RDePmofQ3U7kPV+RzOaucqwWdo=;
        b=LIYkr9Pn9qAOkkd6Ed3OAjF3rOsTRkaOug/mlK6/pCWu7rsxWIXJphrUgju8r4SNjD
         VqVshkoPNR+n96W6VNjodblginS40ns5NZ02l7m6CkSDjU+9h0rzPupJpRqJPg6S4FEP
         WP4rdgRZP6lpL4b9ci+YyY4LnhrgowoqCIf5Icb187x4AYpuIsOTwZu95MJWPvhYF+Bl
         P0VI+TqqGD1SX38mO6QlwDNrwKjfmeI8kv6jbnl7QpCpW88aaXnpjgwDQRBiG8KARp0K
         Jey0nbZNt5e9EppapPs4QhEJqqjGs2PCChqGOK9zdBcpA3/wmXM6O+/amWU6xWYhT/UP
         UnKQ==
X-Gm-Message-State: ACrzQf2qIkVPsMOd6APA+xOaWkaYv3CMy4o/RDTT4/MBYFELxMVbn3+/
        2fusnepHHw82Nxqe7E0N7H0NPhP8Bd0=
X-Google-Smtp-Source: AMsMyM7d4YrAazHKrdsb+/sfmf19I9lBmCAbfDiVsQW2GTrKszNHRKohe2n7YmE8+nBtYixQgjKlqriWSHg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:3b90:b0:202:80ac:467c with SMTP id
 pc16-20020a17090b3b9000b0020280ac467cmr12610232pjb.17.1664408225997; Wed, 28
 Sep 2022 16:37:05 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 28 Sep 2022 23:36:52 +0000
In-Reply-To: <20220928233652.783504-1-seanjc@google.com>
Mime-Version: 1.0
References: <20220928233652.783504-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220928233652.783504-8-seanjc@google.com>
Subject: [PATCH v2 7/7] Revert "KVM: selftests: Fix nested SVM tests when
 built with clang"
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Revert back to using memset() in generic_svm_setup() now that KVM
selftests override memset() and friends specifically to prevent the
compiler from generating fancy code and/or linking to the libc
implementation.

This reverts commit ed290e1c20da19fa100a3e0f421aa31b65984960.

Suggested-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/lib/x86_64/svm.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/svm.c b/tools/testing/selftests/kvm/lib/x86_64/svm.c
index 6d445886e16c..5495a92dfd5a 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/svm.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/svm.c
@@ -60,18 +60,6 @@ static void vmcb_set_seg(struct vmcb_seg *seg, u16 selector,
 	seg->base = base;
 }
 
-/*
- * Avoid using memset to clear the vmcb, since libc may not be
- * available in L1 (and, even if it is, features that libc memset may
- * want to use, like AVX, may not be enabled).
- */
-static void clear_vmcb(struct vmcb *vmcb)
-{
-	int n = sizeof(*vmcb) / sizeof(u32);
-
-	asm volatile ("rep stosl" : "+c"(n), "+D"(vmcb) : "a"(0) : "memory");
-}
-
 void generic_svm_setup(struct svm_test_data *svm, void *guest_rip, void *guest_rsp)
 {
 	struct vmcb *vmcb = svm->vmcb;
@@ -88,7 +76,7 @@ void generic_svm_setup(struct svm_test_data *svm, void *guest_rip, void *guest_r
 	wrmsr(MSR_EFER, efer | EFER_SVME);
 	wrmsr(MSR_VM_HSAVE_PA, svm->save_area_gpa);
 
-	clear_vmcb(vmcb);
+	memset(vmcb, 0, sizeof(*vmcb));
 	asm volatile ("vmsave %0\n\t" : : "a" (vmcb_gpa) : "memory");
 	vmcb_set_seg(&save->es, get_es(), 0, -1U, data_seg_attr);
 	vmcb_set_seg(&save->cs, get_cs(), 0, -1U, code_seg_attr);
-- 
2.37.3.998.g577e59143f-goog

