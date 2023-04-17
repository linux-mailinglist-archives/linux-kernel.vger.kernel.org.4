Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815416E547B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 00:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjDQWAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 18:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDQWAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 18:00:16 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DF1E4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 15:00:12 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id c64-20020a254e43000000b00b92530ded91so2866779ybb.17
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 15:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681768812; x=1684360812;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZQrcPnaz6i7jaUL3dB9umNv7i0Yx1YEim5fldBHPBhY=;
        b=Ka3g0y8hwEbpgHuxcxJn9hTMwnb9D6QDRLuqh5D5ry8ZFrSUBp5Hi3M0RdOM7qC4G2
         8ZzTqA5lk5KEoSZqo1jGdvm72/o5cJWl2LXIgUdFrp5EkdbhF4CLqPPMFRbIMqmOl86L
         ycApduk0A3QoX39V+bmC2s0VR4a4lZigwZLfDTa6b680j7qhqlCam6PAJZSZUbwUgJgi
         B5l/h0mqvPOixUI2DSxYspMSz8uolBC+GF1snmju3gRAyR6+Oqo3fqeZO6trg7PG3QIa
         kSnc0fqLLN1c+Czwwr0E4zXca8cwUnfBrisSS3jQ9akhfJt4HrHvrcitCebHqLHx4OlM
         mTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681768812; x=1684360812;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZQrcPnaz6i7jaUL3dB9umNv7i0Yx1YEim5fldBHPBhY=;
        b=lMc7OMdMwvkFUlL5zisPRyWcFunzLKF3g8Hu33mjtKjDg0xSq8A9YwZWzBlfspgFA9
         jkPlcmobtbeHoUUSWN+q7ySVBvz4pgrcrMCVVMrCCtuULbwkGUwPzq/aaTeSKVsKNdfK
         JGG4uUVMyrTmfWctqXuWgQ3zAOc9EKl1p4DYiEmfcsmlJjyonY1z04kEIU2RlBnPaP51
         znwfzQ9gvJWjLmpHskgi0hfJYhglD1LTpHQ3yBRL34furNx/2Jge3AdjRiOQfFGWSDFO
         QNVGBrL0T4giebLWhIYBdoiLbpuQkAKSTZieA2l9atpC8l3Mv1jXGBgR0jocuQrlS9PX
         aiWg==
X-Gm-Message-State: AAQBX9eOqUf8khA8nyS1GuBB6mBMSgEbvSyreEwZLYHaIGMj+Q27aX2f
        kF27i8Lpb9yZYiIS5YKsabnWafj8sWtC2CgobTY=
X-Google-Smtp-Source: AKy350bXUufvEYS+NAQ3xLM7rU27TmtXGN6FPkU6ZedGZVjdPtlR1WAaSjVEZOTcOMtRZ5ULuB6mqQwyFUR5n/IbDJ0=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:e8f1:df30:2fb2:cf8a])
 (user=ndesaulniers job=sendgmr) by 2002:a05:690c:706:b0:545:5f92:f7ee with
 SMTP id bs6-20020a05690c070600b005455f92f7eemr10958911ywb.2.1681768811997;
 Mon, 17 Apr 2023 15:00:11 -0700 (PDT)
Date:   Mon, 17 Apr 2023 15:00:04 -0700
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGTBPWQC/22MwQoCIRRFf2V46ww1s5lZ9R8R8bSHSpOGTkIM/
 nvSutXlXO49GxTKgQrMwwaZaighxQ5yN4D1GB2xcO8MkssDV0KymG5lRft4MZxGoUeUxnCEvjd YiJmM0fr+iO9l6aUPZU358/NX0ePyT1UF40xp1JM58hMqc3YpuYX2Nj3h2lr7ApnvUaWoAAAA
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=UIrHvErwpgNbhCkRZAYSX0CFd/XFEwqX3D0xqtqjNug=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681768810; l=3659;
 i=ndesaulniers@google.com; s=20220923; h=from:subject:message-id;
 bh=uFHb2Ss6mf2TUD8KGl+f7c4yBc2F7Ouqeqyr+hQa2b8=; b=HUGT0zAYJrbcXxiYxtlHHTKQhZ9/JNtQICgwAtY0NthSfX4/eUxRXZtwpqj+Tk1G8a45U81lqTar
 vHycTN/yDftrKtJuCytb4bH3RtxkPLpdbRn6gMVCogqLN3fi6fvG
X-Mailer: b4 0.12.2
Message-ID: <20230412-no_stackp-v2-0-116f9fe4bbe7@google.com>
Subject: [PATCH v2 0/2] start_kernel: omit stack canary
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

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes in v2:
- Rebase to avoid conflicts with Josh's changes.
- Fix comment style as per Peter.
- Pick up tags.
- Link to v1: https://lore.kernel.org/r/20230412-no_stackp-v1-0-46a69b507a4b@google.com
(sorry for the spam with v2, mrincon is helping me get kinks worked out
with b4 and our corporate mailer)

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

