Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F7069E4D7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 17:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbjBUQiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 11:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234853AbjBUQhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 11:37:43 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DC22A6E0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 08:37:31 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id a23-20020a62bd17000000b0058db55a8d7aso2191386pff.21
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 08:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1676997451;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=6eya8RvAso0oVSkPG+SqCdov6cQuqd8KcPbcmXzNxTo=;
        b=TVd18GDSarLsA2/lPOgVrYfYPYZtvFYr4jPuI+f6by2zc3e5pGx1TLe7+8F/v5CLcD
         C+ZUrDVI4U1jkWxXvQCJTohZULj91OSBWXga7XMNHoIQ3y9p1MLfmHOOfYPQREsSOSVx
         g2LY0iK/jP8K4IOeK/N+J+awTSjk0wSuqNeNvwP34Qzf7NDM+YArW/aoRPdbQATy4QU1
         iVfIDNRyN55PI5w/GyAPsWGgV/GAQlDYeyBx5D/HeDQ9QmeP44S8Gix/v/R9ZkOr8sJU
         QoVSUyIk00vSaTEyVgZc4PCsBDX7yXWROpx9vZXMV81E9I5nSvgGpWREuTz/5ZJP9+KS
         vIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676997451;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6eya8RvAso0oVSkPG+SqCdov6cQuqd8KcPbcmXzNxTo=;
        b=GBPQgzphgi14AnEwlWZp1BgaUpGYY2/+LqQv2j5mbHBtiEF0fp+wGCEi3qKGp+EVF2
         giYo+DFSTyBk/yeq6WEL3as6j3WIJzMyfY3wR/v7y67iS+DpcLIiCIlMTOt7YqN1/OiN
         hXzZkG+7c4j8LzJnQcHl0m0rV7iVfJMyQKxo+uPQaeLEaA+lvW5tveZwSgSzDmjctbG4
         od8zkHciqaM6qhzGn/29/8uquirew9vSGcBe1OQfudfgCVl5YIakCNax7Fhod0steTF3
         wuQXh28EczZqzvNNF6TxnJU4B0w7l2/01cDM4ictMqGd1yABu2eqZVDuRkA3gsQ+qUrF
         XPvQ==
X-Gm-Message-State: AO0yUKVp63UJaLjoVMqWhEyW/gfXyi8DO3RTq2fsYN+uVrB4/1X1qehX
        5ReHEn0Q3xLyYNdts+IPvgik/TJtrjrd
X-Google-Smtp-Source: AK7set9GqgvFSkGmlkChA0S8+JUftH2z6x67/RS3rMWptrG7AL4MP9X7ck4FrIKaNCD4eHIBUs6gU2jSXexQ
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a62:c143:0:b0:593:d4cb:dba2 with SMTP id
 i64-20020a62c143000000b00593d4cbdba2mr655957pfg.13.1676997451249; Tue, 21 Feb
 2023 08:37:31 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Tue, 21 Feb 2023 16:36:50 +0000
In-Reply-To: <20230221163655.920289-1-mizhang@google.com>
Mime-Version: 1.0
References: <20230221163655.920289-1-mizhang@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230221163655.920289-9-mizhang@google.com>
Subject: [PATCH v3 08/13] KVM: selftests: x86: Repeat the checking of xheader
 when IA32_XFD[XTILEDATA] is set in amx_test
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

Repeat the checking of AMX component in xheader after XSAVEC when
IA32_XFD[XTILEDATA] is set. This check calibrates the functionality scope
of IA32_XFD: it does not intercept the XSAVE state management. Regardless
of the values in IA32_XFD, AMX component state will still be managed by
XSAVE* and XRSTOR* as long as the corresponding bits are set XCR0.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 tools/testing/selftests/kvm/x86_64/amx_test.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
index 62fff3363b3b..724e991ba814 100644
--- a/tools/testing/selftests/kvm/x86_64/amx_test.c
+++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
@@ -201,6 +201,16 @@ static void __attribute__((__flatten__)) guest_code(struct tile_config *amx_cfg,
 
 	/* xfd=0x40000, disable amx tiledata */
 	wrmsr(MSR_IA32_XFD, XFEATURE_MASK_XTILEDATA);
+
+	/*
+	 * XTILEDATA is cleared in xstate_bv but set in xcomp_bv, this property
+	 * remains the same even when amx tiledata is disabled by IA32_XFD.
+	 */
+	xstate->header.xstate_bv = XFEATURE_MASK_XTILEDATA;
+	__xsavec(xstate, XFEATURE_MASK_XTILEDATA);
+	GUEST_ASSERT(!(xstate->header.xstate_bv & XFEATURE_MASK_XTILEDATA));
+	GUEST_ASSERT((xstate->header.xcomp_bv & XFEATURE_MASK_XTILEDATA));
+
 	GUEST_SYNC(6);
 	GUEST_ASSERT(rdmsr(MSR_IA32_XFD) == XFEATURE_MASK_XTILEDATA);
 	set_tilecfg(amx_cfg);
-- 
2.39.2.637.g21b0678d19-goog

