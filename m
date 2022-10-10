Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F1C5FA7DF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 00:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiJJWx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 18:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJJWxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 18:53:53 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83107A53E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 15:53:51 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3579d28ffd6so117625657b3.18
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 15:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=35T83bsZ4xGPTaOlyecWSoUgFUedgbH6BlUxlOUBlR8=;
        b=oTutQm7Zb4sdm6oN3sN1aqtG9kDMiU7ItlRnISemwBS9t48mFyaPD6rfBkSxPsg5MP
         v+uAW4w+skMr8tqJESJ8HFSR8MfGgIPd8LFPNMJW8vWFnhx2Vu0AUiVJam3kOfWdAVdf
         QZpdTCS1rI1IY6gKaQlNlbqZzj4wDR8spjrOjq2YOuKCOdC2R4Ooaevctw5xKr+0kawn
         BRzg1g45r2R3f/XcFo/pc4gVT9clpnMN7wC7ahzTdEV2M6iYIevOesE7ZfULdGUg5UYX
         Tru+SL61avsmaetlHsZJTD8pk4dUTVGIvTSIggYlVaNqRlZ1oyCGMUmT0PLUkvZt2x0O
         Gx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=35T83bsZ4xGPTaOlyecWSoUgFUedgbH6BlUxlOUBlR8=;
        b=TgQKyrT5DBWufqplc27TCIafoQmAezaqZ7LwQKLbgk+IKqCNwe4YjDu14DqD+EPFYC
         02KCYJQMUPjasZ3xn2NBOrN7pSPh0Q6co/5YAB/L9kY3ai5rHRL/hUkHZQAM2cANuhmr
         PKjnW9ydfz0bAHSyun6+1NWifizz5Zumsr6V+7COr+tSxiIitzBIrwe8yPNMsp58UIpR
         0PYV4cx/CfU4WUtf61Ch1t0XwQ9MERve6vXyMQ/5uDZ7MfxXmYPNF2KBrsRtrdDtcvBe
         /pz6lUK5N2IOyT4VQ4W2lwdOfkUNgQXbu5130LLsNelVNO6Lc/HuS6emZRLDTgxFlZkX
         9j4g==
X-Gm-Message-State: ACrzQf0ijvkCXkZzuOoEiKRy93vupY7l5rTeUnKH0XKiI/QY9Hgv0PRK
        s9ynfVOIhvbbIqWHPpMJ2g87Bnm8y7YpozEE4R4=
X-Google-Smtp-Source: AMsMyM6q9jQ47MmC0Y/IsHY+Z0OQ3TlY1am07kfC8geRQ5Kno2DnoQbRAI62yZ3QiVelIrmwkSBy+pufO7a+InhVzBI=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:0:100e:712:283b:bbf5:938:fb2d])
 (user=ndesaulniers job=sendgmr) by 2002:a25:9e83:0:b0:6be:ebbb:9d8b with SMTP
 id p3-20020a259e83000000b006beebbb9d8bmr20756154ybq.333.1665442431236; Mon,
 10 Oct 2022 15:53:51 -0700 (PDT)
Date:   Mon, 10 Oct 2022 15:53:42 -0700
In-Reply-To: <CAKwvOdnQ-tWa0oY0CKAwJD5WQDgVBvxDtf6=E3hS8Ytz5J1OKg@mail.gmail.com>
Mime-Version: 1.0
References: <CAKwvOdnQ-tWa0oY0CKAwJD5WQDgVBvxDtf6=E3hS8Ytz5J1OKg@mail.gmail.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=UIrHvErwpgNbhCkRZAYSX0CFd/XFEwqX3D0xqtqjNug=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1665442422; l=2033;
 i=ndesaulniers@google.com; s=20220923; h=from:subject; bh=rZfNaR/aBwwpz1oPD+ZP2XMfcjdSORrzwrlR54g5esk=;
 b=+6wxScJxIKR3muVDZdynqydUM7ayvYaD10gSryPI/aKJaULM14Ikux1pjsPpQqfnmjRkAmi1dbwX
 zuTFcpdnC/vxxB97Gl2PE6kLYI17zVZxk/7LEp0vT7OK1OoWAzaP
X-Mailer: git-send-email 2.38.0.rc2.412.g84df46c1b4-goog
Message-ID: <20221010225342.3903590-1-ndesaulniers@google.com>
Subject: [PATCH] ARM: NWFPE: avoid compiler-generated __aeabi_uldivmod
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     Tom Rix <trix@redhat.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Miguel Ojeda <ojeda@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Gary Guo <gary@garyguo.net>,
        Craig Topper <craig.topper@sifive.com>,
        Philip Reames <listmail@philipreames.com>, jh@jhauser.us,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
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

clang-15's ability to elide loops completely became more aggressive when
it can deduce how a variable is being updated in a loop. Counting down
one variable by an increment of another can be replaced by a modulo
operation.

For 64b variables on 32b ARM EABI targets, this can result in the
compiler generating calls to __aeabi_uldivmod, which it does for a do
while loop in float64_rem().

For the kernel, we'd generally prefer that developers not open code 64b
division via binary / operators and instead use the more explicit
helpers from div64.h. On arm-linux-gnuabi targets, failure to do so can
result in linkage failures due to undefined references to
__aeabi_uldivmod().

While developers can avoid open coding divisions on 64b variables, the
compiler doesn't know that the Linux kernel has a partial implementation
of a compiler runtime (--rtlib) to enforce this convention.

It's also undecidable for the compiler whether the code in question
would be faster to execute the loop vs elide it and do the 64b division.

While I actively avoid using the internal -mllvm command line flags, I
think we get better code than using barrier() here, which will force
reloads+spills in the loop for all toolchains.

Link: https://github.com/ClangBuiltLinux/linux/issues/1666
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/arm/nwfpe/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/nwfpe/Makefile b/arch/arm/nwfpe/Makefile
index 303400fa2cdf..2aec85ab1e8b 100644
--- a/arch/arm/nwfpe/Makefile
+++ b/arch/arm/nwfpe/Makefile
@@ -11,3 +11,9 @@ nwfpe-y				+= fpa11.o fpa11_cpdo.o fpa11_cpdt.o \
 				   entry.o
 
 nwfpe-$(CONFIG_FPE_NWFPE_XP)	+= extended_cpdo.o
+
+# Try really hard to avoid generating calls to __aeabi_uldivmod() from
+# float64_rem() due to loop elision.
+ifdef CONFIG_CC_IS_CLANG
+CFLAGS_softfloat.o	+= -mllvm -replexitval=never
+endif
-- 
2.38.0.rc2.412.g84df46c1b4-goog

