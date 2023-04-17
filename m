Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7E66E5427
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 23:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjDQVyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 17:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjDQVyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 17:54:14 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01795213D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 14:54:12 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54faf2e22afso135282157b3.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 14:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681768452; x=1684360452;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2duZpU/eZSHwLEuEsM1wPgBeCX6HIty9VCVJmbcQV60=;
        b=EGPv0nIKb92KJl2AeUoGYOvzu2GzLLkcrRkOqzZbkVTtocbB74qlqJ1si4fSVdh/h+
         1J5kC1OZoYxKKorE1TvmyuyYBmzeGVTS4Fqrd3BtAb7FqvjxPGnK2sgvyvSFSxYctW2h
         ANHO92O27UNVNjVIDuooFZIj03mkP23njYnSNkTyXI4OYYSghFk+g5v4guojvm9AkkRG
         0hBsdKIQHGu0jMOPX1Ho4to0yX+YJ70q01re5chTK8WY/tYSx8+LPWfP0k9KGqwSKLnM
         /yige6n1AY44bbJsZoeyYWuytUiCjKDj9xuuznDt4TGhHV5eT7XUfdKdUigFxU7r4q7B
         Txiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681768452; x=1684360452;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2duZpU/eZSHwLEuEsM1wPgBeCX6HIty9VCVJmbcQV60=;
        b=TlwZTSRshmBSzoeCbBDXx9wZgYV8u6XnYhpp5S304/1WHiUQ4bg+6GsAR4yJaqjjr7
         aevDqddoCC51AX7Z94rzGWyPT4a1g5XPKtvsPNWKqlpfrE6IV7RY6CU3QS1SPGUqs481
         0TWM9VQuPQt0fjtEVzHzf3XjFb0HEsoH2XbVdBwwT4QuxcwUIV5ZsrSSpqdgQX9wfYAm
         luwv4jX6b46s0VNZPqIomMfSQR9MwtS8xAyr3iI6Y6zTrpKI59I0rHHg9hsI0U1jemqC
         C7ksv4oa7gDFcNkWIroE7ceREYFHc2L+0BSvkjipllFqxzKTWKvrtTod2GyiQS96P/SW
         ME7A==
X-Gm-Message-State: AAQBX9dmFYxZENh87jS/DA9whv0sg4ndLiS/RPYRRSN+3nGtDNkI5VwM
        OCsO/XFRVK1JGPhyFhyB+4pRp1gdMm08tfJxlZA=
X-Google-Smtp-Source: AKy350bIM/+HmY5iRKBfThLeZwd20fzSuyCq4zowHtLOJDiE6fNyk+ekeEHxUCL4XgtTzddlr5PgLT1dEC9CUhSq70o=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:e8f1:df30:2fb2:cf8a])
 (user=ndesaulniers job=sendgmr) by 2002:a25:d2d4:0:b0:b95:31a3:9d89 with SMTP
 id j203-20020a25d2d4000000b00b9531a39d89mr196920ybg.2.1681768452185; Mon, 17
 Apr 2023 14:54:12 -0700 (PDT)
Date:   Mon, 17 Apr 2023 14:54:06 -0700
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAP6/PWQC/w3LQQqAIBBA0avErBPUIqzLxGhDSjKFU22ku+fyw
 f8VhEoigaWrUOhNkk5uMH0HISLvpNLWDFbbQY/GKj5XuTEcl8LZmcmh9V4jtN6jkPIFOcR28JP z9/3pKfYIYAAAAA==
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=UIrHvErwpgNbhCkRZAYSX0CFd/XFEwqX3D0xqtqjNug=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681768450; l=3460;
 i=ndesaulniers@google.com; s=20220923; h=from:subject:message-id;
 bh=L+SfgiE84uBc6ASyb4ccLntQBYnB84v4M07YkhSItYs=; b=4kZW7sG9q2UtgI9ubA8EgzqIsMnQxqatdhYmJO4idn8myvviWXNOOFewD85rUB0y0u81BbCMNooI
 zCEPcp69Dm/hm+rT4UXEpfh4JM2fH/b2vuzJmV5MKfrL0u0Jpfvi
X-Mailer: b4 0.12.2
Message-ID: <20230412-no_stackp-v1-0-86d2034a4d06@google.com>
Subject: [PATCH 0/2] start_kernel: omit stack canary
From:   ndesaulniers@google.com
To:     "Borislav Petkov (AMD)" <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A security research paper was recently published detailing Catch Handler
Oriented Programming (CHOP) attacks.
https://download.vusec.net/papers/chop_ndss23.pdf
The TL;DR being that C++ structured exception handling runtimes are
attractive gadgets for Jump Oriented Programming (JOP) attacks.

In response to this, a mitigation was developed under embargo in
clang-16 to check the stack canary before calling noreturn functions.
https://bugs.chromium.org/p/llvm/issues/detail?id=30

This started causing boot failures in Android kernel trees downstream of
stable linux-4.14.y that had proto-LTO support, as reported by Nathan
Chancellor.
https://github.com/ClangBuiltLinux/linux/issues/1815

Josh Poimboeuf recently sent a series to explicitly annotate more
functions as noreturn. Nathan noticed the series, and tested it finding
that it now caused boot failures with clang-16+ on mainline (raising the
visibility and urgency of the issue).
https://lore.kernel.org/cover.1680912057.git.jpoimboe@kernel.org/
V2 of this series is rebased on tip/objtool/core @
88b478ee5c7b080b70c68d6e9b3da6c2b518ceb0 now that that series has been
picked up.

Once the embargo was lifted, I asked questions such as "what does C++
structured exception handling have to do with C code" and "surely GCC
didn't ship the same mitigation for C code (narrator: 'They did not:
https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=a25982ada523689c8745d7fb4b1b93c8f5dab2e7')?"

I now have a patch out for LLVM to undo this mess (or at least limit it
to C++ functions that may throw, similar to GCC's mitigation); it hasn't
landed yet but we're close to consensus and I expect it to land
imminently.
https://reviews.llvm.org/D147975

Remember this thread?  (Pepperidge farms remembers...)
https://lore.kernel.org/all/20200314164451.346497-1-slyfox@gentoo.org/

That reminded me that years ago we discussed a function attribute for
no_stack_protector.
https://lore.kernel.org/all/20200316130414.GC12561@hirez.programming.kicks-ass.net/

GCC didn't have one at the time, it now does. In addition to the LLVM
fix, I'd like to introduce this in the kernel so that we might start
using it in additional places:
* https://lore.kernel.org/linux-pm/20200915172658.1432732-1-rkir@google.com/
* https://lore.kernel.org/lkml/20200918201436.2932360-30-samitolvanen@google.com/
And eventually remove the final macro expansion site of
prevent_tail_call_optimization.

With the LLVM fix, this series isn't required, but I'd like to start
paving the way to use these function attributes since I think they are a
sweet spot in terms of granularity (as opposed to trying to move
start_kernel to its own TU compiled with -fno-stack-protector).

Changes V1 -> V2:
* Rebase to avoid conflicts with Josh's changes.
* Fix comment style as per Peter.
* Pick up tags.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Nick Desaulniers (2):
      start_kernel: add no_stack_protector fn attr
      start_kernel: omit prevent_tail_call_optimization for newer toolchains

 arch/powerpc/kernel/smp.c           |  1 +
 include/linux/compiler_attributes.h | 12 ++++++++++++
 init/main.c                         |  9 ++++++++-
 3 files changed, 21 insertions(+), 1 deletion(-)
---
base-commit: 88b478ee5c7b080b70c68d6e9b3da6c2b518ceb0
change-id: 20230412-no_stackp-a98168a2bb0a

Best regards,
-- 
Nick Desaulniers <ndesaulniers@google.com>

