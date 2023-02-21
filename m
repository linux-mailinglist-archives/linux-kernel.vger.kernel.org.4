Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3755569E4D3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 17:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbjBUQh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 11:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234779AbjBUQhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 11:37:35 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EE32CFD7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 08:37:30 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id a23-20020a63d417000000b004f2f2dafb21so1406658pgh.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 08:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=w2vMSj1pqCX3K6DVzozBWZ+Uf2g2Y7SPE2PRI36z9us=;
        b=DajTbx4B7dtFVQSGSpYck2dVAgO/b8AL4deOPuANwJ64sRfLWumNJeJtLq/ZJhv1cd
         yZWJoeLFSSuBT/rlTQHY7vzTP4QT3n/5udfMxWhlVkEWx4t5gCEsKVk8sNPlw4dDbHA0
         Ursp80w7OYSX68Zf6OoswIr88aR9PE0Qfsr7QHn9+wrdLLSluIsk6n9xW0rfPs7VeskL
         pq8Vr+ypMELlFgBAowcAcH2M9km1WyH9jA/iXN8M1XBA/G0Z/B319HA3S0cOzj7+0iIe
         USKzDbX8ParyU9iv0Dge7ttZs31dbK/DxHkLUDoeCXa+esdohVJqyFf9LjHvGXXzV6JK
         ac9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w2vMSj1pqCX3K6DVzozBWZ+Uf2g2Y7SPE2PRI36z9us=;
        b=wdvHsquNdVWSortZ2QlVBHa4a3cT0JFK1Iui5Qd6PuOvHJruIdY0PRt3stOOIEpzhX
         x4lJWJKnkbQwNPsihRZMedY0D4ZcscgdYIkwpGxAY4KvmQdPk3i7UyFrJdlnio1Br0NL
         yyeG29e97NUFHtZqkLkZEZMoEyNj1v2VjfMcznPyD9gNJr7DpmqU3rZ3yxqXDCc6Lc42
         1MnlIahpHylDEB8zAJYlVboAP7cXvQLj92hr49QDyiNjwzgvT3ZptfMwgVdKXesgWygG
         1Nd6mrv1/NuaSgpPbce2Dp0pX8pjum6Xl/6Xnk4TaVWED1FXK1xnWqkpG2GJyX8VpQMF
         pepQ==
X-Gm-Message-State: AO0yUKVbDxn9gROMgZMYMRNzA98esiA4OfCJzxy0xQ3+/5Fy+ePq+wZS
        +xSeSZyW3kz64Q5pEg/G5YUpTt1B1D5i
X-Google-Smtp-Source: AK7set8qAXOR2/Hd1KkJ1/GP+RXMvy0M0Bdho4jquC9vVEHvs+inVCvxtWU0xDTeZGKfNFydgvkLwrV+5g1l
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a17:902:f811:b0:19a:f153:b73e with SMTP id
 ix17-20020a170902f81100b0019af153b73emr729491plb.4.1676997449336; Tue, 21 Feb
 2023 08:37:29 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Tue, 21 Feb 2023 16:36:49 +0000
In-Reply-To: <20230221163655.920289-1-mizhang@google.com>
Mime-Version: 1.0
References: <20230221163655.920289-1-mizhang@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230221163655.920289-8-mizhang@google.com>
Subject: [PATCH v3 07/13] KVM: selftests: x86: Fix the checks to XFD_ERR using
 and operation
From:   Mingwei Zhang <mizhang@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Mingwei Zhang <mizhang@google.com>,
        Jim Mattson <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Chao Gao <chao.gao@intel.com>
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
index 296c954dfd6d..62fff3363b3b 100644
--- a/tools/testing/selftests/kvm/x86_64/amx_test.c
+++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
@@ -217,10 +217,10 @@ void guest_nm_handler(struct ex_regs *regs)
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
2.39.2.637.g21b0678d19-goog

