Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F62969E4D9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 17:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbjBUQiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 11:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbjBUQht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 11:37:49 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DF12D14E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 08:37:33 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id q15-20020a63d60f000000b00502e1c551aaso265915pgg.21
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 08:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=iiRrB1La2XaBQ8X9jljAYPafLfxRlgHLwbfoJQq6vJc=;
        b=fAH3hCUl7uqbwUtd34iFW4FxURELK93IK/02Vx0KEZ+6k0X581BSlqbabdxNOqoBgo
         meEl6t2ZiDTIdhAK579ZxSCzIGixUue+EXZ/tFu3HlVbvdHU3QCq9IeS3SSra0MJxJ7i
         nbq8TQ51m3339oT33ydPu9XaJMCzD1QjV689OxEdbjY4FRc7QacllNDSkJuhhi5eFXoL
         TcOKXj4ubRAQ5sUHN9Y8qlxN5G8h5tss7+dpwoJDOirM9qLKmpDmS1YaqKN3XDYNUPCz
         zOiltEGWXv2rsSRM7wh4fzWdgxRKe5qA04L0Htv1bI7O/TZF70MfnASoGoq6SDuVhfq9
         FSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iiRrB1La2XaBQ8X9jljAYPafLfxRlgHLwbfoJQq6vJc=;
        b=DSXuOjbfRV4OxrVl5bY5NRiWWXx7/ZIRJEi0Ck7ThUP8EAuLs8Ytyxbj1NiJF83Hj2
         qiBYJZO3ws/a/CpS1dU71SorTWi4j7IEDP530diLCCY5VNV89uFIkFwCHX1BG53P9ibg
         77gwWtWMDEW7UgrynPJZiMflqVNn+FMAHRePvE0rLCU0q1jfPx62UI30WIvJNk9rMu4N
         8xubFRAce5oFsZjte0KH/GGdzEpaH2BGNqIAIPAEXDjtZUwIxQWOMO2VxKLC9sDQaQYZ
         4O1ADnIXoyKYpomQGsJQ58wljpnkH/Z++6Qrx4mRAaJKgJ1SyyvD5gTbQvS1oFj9lbVT
         onYA==
X-Gm-Message-State: AO0yUKXLSMpA/9cjxsjY7tSHhwmsq5f2tPA3Q4glp4Oiajk2imEqQlk8
        qre3lJ0tPZVFrwZAxUcg4UBZ8EgilVfy
X-Google-Smtp-Source: AK7set+yc+UPbgHRSjGfHtztbpCerRitgUNtWXsAYPaaIY95QIVoKUQZahzKckS3seET9A2paVtccvS0Jy9Q
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a63:7a56:0:b0:4fb:b88f:e98a with SMTP id
 j22-20020a637a56000000b004fbb88fe98amr733518pgn.7.1676997453182; Tue, 21 Feb
 2023 08:37:33 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Tue, 21 Feb 2023 16:36:51 +0000
In-Reply-To: <20230221163655.920289-1-mizhang@google.com>
Mime-Version: 1.0
References: <20230221163655.920289-1-mizhang@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230221163655.920289-10-mizhang@google.com>
Subject: [PATCH v3 09/13] KVM: selftests: x86: Assert that XTILE is XSAVE-enabled
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

Assert that XTILE is XSAVE-enabled. check_xsave_supports_xtile() doesn't
actually check anything since its return value is not used. Add the
intended assert.

Opportunistically, move the assert to a more appropriate location:
immediately after XSETBV and remove check_xsave_supports_xtile().

Fixes: 5dc19f1c7dd3 ("KVM: selftests: Convert AMX test to use X86_PROPRETY_XXX")
Signed-off-by: Aaron Lewis <aaronlewis@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 tools/testing/selftests/kvm/x86_64/amx_test.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
index 724e991ba814..d1fbf8936192 100644
--- a/tools/testing/selftests/kvm/x86_64/amx_test.c
+++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
@@ -115,11 +115,6 @@ static inline void check_cpuid_xsave(void)
 	GUEST_ASSERT(this_cpu_has(X86_FEATURE_OSXSAVE));
 }
 
-static bool check_xsave_supports_xtile(void)
-{
-	return __xgetbv(0) & XFEATURE_MASK_XTILE;
-}
-
 static void check_xtile_info(void)
 {
 	GUEST_ASSERT(this_cpu_has_p(X86_PROPERTY_XSTATE_MAX_SIZE_XCR0));
@@ -166,6 +161,7 @@ static void init_regs(void)
 	xcr0 = __xgetbv(0);
 	xcr0 |= XFEATURE_MASK_XTILE;
 	__xsetbv(0x0, xcr0);
+	GUEST_ASSERT(__xgetbv(0) & XFEATURE_MASK_XTILE);
 }
 
 static void __attribute__((__flatten__)) guest_code(struct tile_config *amx_cfg,
@@ -174,7 +170,6 @@ static void __attribute__((__flatten__)) guest_code(struct tile_config *amx_cfg,
 {
 	init_regs();
 	check_cpuid_xsave();
-	check_xsave_supports_xtile();
 	check_xtile_info();
 	GUEST_SYNC(1);
 
-- 
2.39.2.637.g21b0678d19-goog

