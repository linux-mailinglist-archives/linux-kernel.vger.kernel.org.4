Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF1569E4E0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 17:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234944AbjBUQiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 11:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234841AbjBUQiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 11:38:02 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0398E2DE60
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 08:37:37 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id k24-20020aa790d8000000b005a8ad1228d4so2339032pfk.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 08:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=iGUJ74hklZ9IC2JyxMgKiaxBDpYa7dvkgnZvEvOVY64=;
        b=rLLClLSLRO2Tp90/r7PQXQ0zXhJU4bH3YbgREwBPeec4T+BSaGhme3PS6pRryZIl2I
         3Vx6/7T14jB9wybO+c1oOfMR7bCqjQQ/VnYnqMjA6woidQlCuLjLIdfMuBQdNW48M941
         Ri2FghSa86fAhOxHk5FbQr06jmgvgYyjPOrcT1UStStg1SBpOofv9Yg9vgeVv+T0o5XV
         u1OEO1L0WyfNDRkM9ADA7YHu99CylDNoC72jQ2FPD4hpuo8q+nPo7sttGxOYOMxUEcy9
         3sXqIBJywR+kvP6c1+AAe5h7SsBxplT6ztBAGAMYaw4kKN6FKiGbS9msYuRp8SiysKQo
         dDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iGUJ74hklZ9IC2JyxMgKiaxBDpYa7dvkgnZvEvOVY64=;
        b=qWHle1nN+mUGxKfTExL+Ib3pxhV449hDFruo3oRRjOYV5pFNw+Nh4/yoO8TriFIkD1
         pru0u8hqSdOtLwoFc2niNQCVGMlGzKxr+neEyp6ctNsdYJGRf6mDFa5Fyacki3YJYoDN
         6i1FXS05FqQ5Pjq7cziKzxZdcJXM8D8xxnub9WcC9snasCDO11/H8ouEiEYESb6OAB+B
         1BzDq6QkeRqz4zIPo0lHotLlx53xI3wkxBn/gHrfTcrqYeQnM+p4sBdm23cVpjCIyMDR
         Y1klX1Kze5bebv3kmW3WvQ4y/xG1+wWS2ZPyiB5/mtwuQchEvNKGVKG/3G9uedpOLYTb
         DgDw==
X-Gm-Message-State: AO0yUKWc0dWoYpitWjM9jL11jQVYUaMVEKOs8tKfAAvlH2cjfwHXYuuO
        TyMs8oXPI1lgD4pWfjo2Z3bQ6AK1ENWg
X-Google-Smtp-Source: AK7set+m1UL4EQdVkgxFOWJtVr69/x8dmtIcB6yIkcdQ2Uw9+EflID8jEffCwLg3f81uwnaUjq48GPyiEo04
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a17:903:2651:b0:19b:8cbb:30fe with SMTP id
 je17-20020a170903265100b0019b8cbb30femr708263plb.13.1676997457301; Tue, 21
 Feb 2023 08:37:37 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Tue, 21 Feb 2023 16:36:53 +0000
In-Reply-To: <20230221163655.920289-1-mizhang@google.com>
Mime-Version: 1.0
References: <20230221163655.920289-1-mizhang@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230221163655.920289-12-mizhang@google.com>
Subject: [PATCH v3 11/13] KVM: selftests: x86: Remove redundant check that
 XSAVE is supported
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaron Lewis <aaronlewis@google.com>

In amx_test, userspace requires that XSAVE is supported before running
the test, then the guest checks that it is supported after enabling
AMX.  Remove the redundant check in the guest that XSAVE is supported.

Opportunistically, move the check that OSXSAVE is set to immediately
after the guest sets it, rather than in a separate helper.

Signed-off-by: Aaron Lewis <aaronlewis@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 tools/testing/selftests/kvm/x86_64/amx_test.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
index 1a1565126255..deacd21cf744 100644
--- a/tools/testing/selftests/kvm/x86_64/amx_test.c
+++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
@@ -109,12 +109,6 @@ static inline void __xsavec(struct xstate *xstate, uint64_t rfbm)
 		     : "memory");
 }
 
-static inline void check_cpuid_xsave(void)
-{
-	GUEST_ASSERT(this_cpu_has(X86_FEATURE_XSAVE));
-	GUEST_ASSERT(this_cpu_has(X86_FEATURE_OSXSAVE));
-}
-
 static void check_xtile_info(void)
 {
 	GUEST_ASSERT(this_cpu_has_p(X86_PROPERTY_XSTATE_MAX_SIZE_XCR0));
@@ -157,6 +151,7 @@ static void init_regs(void)
 	cr4 = get_cr4();
 	cr4 |= X86_CR4_OSXSAVE;
 	set_cr4(cr4);
+	GUEST_ASSERT(this_cpu_has(X86_FEATURE_OSXSAVE));
 
 	xcr0 = __xgetbv(0);
 	xcr0 |= XFEATURE_MASK_XTILE;
@@ -169,7 +164,6 @@ static void __attribute__((__flatten__)) guest_code(struct tile_config *amx_cfg,
 						    struct xstate *xstate)
 {
 	init_regs();
-	check_cpuid_xsave();
 	check_xtile_info();
 	GUEST_SYNC(1);
 
-- 
2.39.2.637.g21b0678d19-goog

