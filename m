Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92AD66BF7AE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 05:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjCREQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 00:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCREQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 00:16:19 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B252BF01
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 21:16:18 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-541942bfdccso66408287b3.14
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 21:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679112977;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=39Fefym6R4RrQjQOXnUkj5Wbs7EvPing/MjHK7t/Lyw=;
        b=lSAzuBmFZ+h8hiSzVh0biFlm455SUKogAcvaf1DponXDVrVupq8TYodfl/wuKq3+lG
         StIer+QGQznxUabXcz2df43r3hGbTAZmZFmuhtEuptxU9lRGI2GQfhVMjBHn7E6oe9rY
         EIEg8HGk++eNcDMhd150EGX8kmfrSXpRDtZ1Jmj+5TpUC1UhlNjrE5Qm5qB076rcW5nX
         b0mnyKdlSuPrmiRCFOmpwbvvLCp+sq/Z0vpQkfDRC0evcIRZsN6hp5UqmpznRXafyYp7
         1YcVKN2gtFUK/BfZcoLNkgVX91sNHKGVoiuKcaydIFpibjnyQfWUE+qS+w6SRTh1CNuN
         gAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679112977;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=39Fefym6R4RrQjQOXnUkj5Wbs7EvPing/MjHK7t/Lyw=;
        b=X5F+9VY2xwi3uGAF3pd/MBuw2iz3cehcAx6jSCkRJ2WzEytWz0dhfJxnPaNx9WLxZe
         +aUyNfqiW1OkCpONo/rEUnadVHkHVF3fhRclEdSSpZHbPeFezlFWdq040OZtJvsPCmps
         3TVijwgUP6OHTxbX3LN1KHuDhYg/dzLSvc5SbI5hUu8wTRg5Uz0uYgtMVLdzOys/zjZG
         wYtgJjMSigFB0QC5GpPrQ4SmYTzCcSTfBl6sf082cpL8RNYNs5k6ADf8dpDZ9c/z7UG+
         KDL3enW3dawRW4j26XP/IdWGAQ0hmyDZSzc1Lsim0H+MIAtuUuKmIPf2Cb8DZOPOL6ED
         5CsQ==
X-Gm-Message-State: AO0yUKV0n/kpX0CTLICHLdevD/7K1+K24k6baP+CdWLk/P+9qrqDp5fv
        VTjkXs1TBkKFcLQVCMKha9qPcj4eipspRg==
X-Google-Smtp-Source: AK7set8R2hY7ySptFbksr8tOnpVYxuTWiaaKxkqJCvC0czQRuIKj/2zJ7wSxtFdQ8Yte+Avdjdb73Hxrct/0kw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a81:af4d:0:b0:544:b7ff:b0df with SMTP id
 x13-20020a81af4d000000b00544b7ffb0dfmr3997390ywj.2.1679112977179; Fri, 17 Mar
 2023 21:16:17 -0700 (PDT)
Date:   Sat, 18 Mar 2023 12:15:54 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230318041555.4192172-1-davidgow@google.com>
Subject: [PATCH] arch:um: Only disable SSE on clang to work around old GCC bugs
From:   David Gow <davidgow@google.com>
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        SeongJae Park <sj@kernel.org>
Cc:     David Gow <davidgow@google.com>, linux-um@lists.infradead.org,
        x86@kernel.org, llvm@lists.linux.dev,
        rust-for-linux@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of the Rust support for UML, we disable SSE (and similar flags)
to match the normal x86 builds. This both makes sense (we ideally want a
similar configuration to x86), and works around a crash bug with SSE
generation under Rust with LLVM.

However, this breaks compiling stdlib.h under gcc < 11, as the x86_64
ABI requires floating-point return values be stored in an SSE register.
gcc 11 fixes this by only doing register allocation when a function is
actually used, and since we never use atof(), it shouldn't be a problem:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99652

Nevertheless, only disable SSE on clang setups, as that's a simple way
of working around everyone's bugs.

Fixes: 884981867947 ("rust: arch/um: Disable FP/SIMD instruction to match x86")
Reported-by: Roberto Sassu <roberto.sassu@huaweicloud.com>
Link: https://lore.kernel.org/linux-um/6df2ecef9011d85654a82acd607fdcbc93ad593c.camel@huaweicloud.com/
Tested-by: Roberto Sassu <roberto.sassu@huaweicloud.com>
Tested-by: SeongJae Park <sj@kernel.org>
Signed-off-by: David Gow <davidgow@google.com>
---
 arch/x86/Makefile.um | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/Makefile.um b/arch/x86/Makefile.um
index b70559b821df..2106a2bd152b 100644
--- a/arch/x86/Makefile.um
+++ b/arch/x86/Makefile.um
@@ -3,9 +3,14 @@ core-y += arch/x86/crypto/
 
 #
 # Disable SSE and other FP/SIMD instructions to match normal x86
+# This is required to work around issues in older LLVM versions, but breaks
+# GCC versions < 11. See:
+# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99652
 #
+ifeq ($(CONFIG_CC_IS_CLANG),y)
 KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx
 KBUILD_RUSTFLAGS += -Ctarget-feature=-sse,-sse2,-sse3,-ssse3,-sse4.1,-sse4.2,-avx,-avx2
+endif
 
 ifeq ($(CONFIG_X86_32),y)
 START := 0x8048000
-- 
2.40.0.rc1.284.g88254d51c5-goog

