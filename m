Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F788696D3D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 19:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbjBNSqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 13:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbjBNSqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 13:46:32 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010A63018B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 10:46:28 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id i14-20020a17090aee8e00b00233f1a535e0so2692751pjz.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 10:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=7uxY5HEkDwcZZuAHavQWO22Vrq80QNHmWiRNorTGn5M=;
        b=k6jyHH/fo402XGiKzCkPmNeQxvWT/0j/dzTZ3oRJINHoyfJjHfah2NgP/YbXYVBSMS
         r4rrwYLddzVocM0gztsCewVyiyPhV6bpdtxJId4hmcPrCqpo+MD82WyjmVOa1r0hF+CT
         SFmTR7MX6CWLebu8+IrY9TauVnMb7u/FQo6tNfKEZar9wtt8PjAm6E+nQ0BIiBUakE4x
         K4+A+tXmINfBvTS6yDjgHeb993ZzPFb+Zs8rCUYRl05n6uylqcERYPRrBGuTabqiP4HZ
         AVOHw3689Megm8h2j9fsXtg8yJfvPT1IKVPil1j0oG9ESksT7qLq6VTjgzh+zo4LY8e2
         WPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7uxY5HEkDwcZZuAHavQWO22Vrq80QNHmWiRNorTGn5M=;
        b=0GvfJMwy3l45ZV5OpU7/zTP0ll4+zNgaWxh9CI0Ayq8a7qPq70kToyH9BatZjAis4x
         0t0Q7HyFb4AzbMxItR7EkvLnI1UghaHQ9KOkK5sCvSC/+3maq3RYmsiJAHI7b3rPcvDr
         DEZZNaYcC1VHbQpRb+vcfrsF/O8TYaBdf9f5+5o1YgqNhtKwjioqFeBUMCyxtGHie0G9
         PlP+DoCRPZuEx2/oj0oE3hncHY0gmfCPnNxn3RsZ6bvmIsnfE4nbOSKSWPkhqCHPsN//
         tLY3PLQPfHN5yqf8So0h4z8WOVe1FBHH3QMVQ/MvNwVsEvx9kEuzf4CI6N1FcemhBOkl
         GgYA==
X-Gm-Message-State: AO0yUKX30ejFRHt2nnF6nBlfI2eQu1Xs/8rfVKdWwQgkgNI5ciKTW/Ci
        dl0KePcj9bsv9tXdFgrGPTHuN+YSG7Gy
X-Google-Smtp-Source: AK7set+NnusIEZKiPfoYABOZJdE9wp2ItLIFuMmQ30K7vI1Ff5Ug1HI4/A/3gL2fmhdtCIQKOA6ETq4gKJIo
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a17:90a:c7:b0:234:5380:7f80 with SMTP id
 v7-20020a17090a00c700b0023453807f80mr778pjd.1.1676400388078; Tue, 14 Feb 2023
 10:46:28 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Tue, 14 Feb 2023 18:46:04 +0000
In-Reply-To: <20230214184606.510551-1-mizhang@google.com>
Mime-Version: 1.0
References: <20230214184606.510551-1-mizhang@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230214184606.510551-6-mizhang@google.com>
Subject: [PATCH v2 5/7] KVM: selftests: Fix the checks to XFD_ERR using and operation
From:   Mingwei Zhang <mizhang@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
        Jim Mattson <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>
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

Fix the checks to XFD_ERR using logical AND operation because XFD_ERR might
contain more information in the future. According Intel SDM Vol 1. 13.14:

"Specifically, the MSR is loaded with the logical AND of the IA32_XFD MSR
and the bitmap corresponding to the state component(s) required by the
faulting instruction."

So fix the check by using AND instead of '=='.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 tools/testing/selftests/kvm/x86_64/amx_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
index 44c907215343..bd8bd9936f8e 100644
--- a/tools/testing/selftests/kvm/x86_64/amx_test.c
+++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
@@ -216,10 +216,10 @@ void guest_nm_handler(struct ex_regs *regs)
 	/* Check if #NM is triggered by XFEATURE_MASK_XTILEDATA */
 	GUEST_SYNC(7);
 	GUEST_ASSERT((get_cr0() & X86_CR0_TS) == 0);
-	GUEST_ASSERT(rdmsr(MSR_IA32_XFD_ERR) == XFEATURE_MASK_XTILEDATA);
+	GUEST_ASSERT(rdmsr(MSR_IA32_XFD_ERR) & XFEATURE_MASK_XTILEDATA);
 	GUEST_ASSERT(rdmsr(MSR_IA32_XFD) & XFEATURE_MASK_XTILEDATA);
 	GUEST_SYNC(8);
-	GUEST_ASSERT(rdmsr(MSR_IA32_XFD_ERR) == XFEATURE_MASK_XTILEDATA);
+	GUEST_ASSERT(rdmsr(MSR_IA32_XFD_ERR) & XFEATURE_MASK_XTILEDATA);
 	GUEST_ASSERT(rdmsr(MSR_IA32_XFD) & XFEATURE_MASK_XTILEDATA);
 	/* Clear xfd_err */
 	wrmsr(MSR_IA32_XFD_ERR, 0);
-- 
2.39.1.581.gbfd45094c4-goog

