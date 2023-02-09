Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9471B68FCB8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 02:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjBIBs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 20:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjBIBsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 20:48:24 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C19222028;
        Wed,  8 Feb 2023 17:48:22 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id x4so720711ybp.1;
        Wed, 08 Feb 2023 17:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e2eEmhxMNjlImDmkNZfpy/YG5w92teD17wTvTpUhJoc=;
        b=XVSf2KxO2RZMtpqZ+Fbgl5+UHBCknVjkMtVbqo5RShM937ET4i8uLOiaDVZFGmjJ83
         Pj32CIQTsp5lNhIe8HBTqjxTBbgyAB0NHZA4/TELSdLIwaBdDqXJCuG4D+ZSDC7XmLV4
         9qF5QnRG8R1ZtOEybUT7csn2K2wRof4byWwku3LPc+65dukSjQQjPxRpv6IeqcfNzRHH
         n2NdH3O3Z+yo9CB+/avBdSu/NeFnmyA1O1IW2fsav+ULtYU8uwUlKoMfb0ZjbLhBEiS6
         KGYMPAC9Rk/DDCOaj3eTKrkSBveQWn4uvIsHQBt5OL0Yu7kvHNrZDd6bHbaTiRBsEKo7
         791Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e2eEmhxMNjlImDmkNZfpy/YG5w92teD17wTvTpUhJoc=;
        b=V8oLll9hFsfAgMBoD6u+k1jOpKfwrdHSAf3A5AIGjpBbU87U0HrhsVf5nsPj5aIPxc
         tX4NcBKogSAXc08DEaIFyCWZf49uAuMo1eA76kE/X4Yopnf3CkoNDS3vS6gh0J2X5CNk
         O6kCjzx0qW/t0C/NaxzuingfRU+wERAUriwAcnvBLS8bxgjkmnWqUT+ZDWfstbHfx99H
         q9HjHSYKGuTewlKxjteXiz9ppIfYcVot7jfyhevghT47eMVqkyYjvuDA2/2H+10eKQcZ
         k4nEEKpOhBQaSXzIB3S/Or5GGXPuT3SYcNxD0gWksUFO04QXfNED8XmPpk8NID86vpdL
         2b5A==
X-Gm-Message-State: AO0yUKXIPVJRS93O8tyrIbzgvyTYvA6gXZqGpdrnfQgZMIBdAQNruNew
        fTWy/Y45zQa/LMno12SCwoQ956452CMudwuBEVA=
X-Google-Smtp-Source: AK7set813S9mEMX5T44S/my3EAhl4gzA5Te5YzzmyG4mXLBmGz5PMf0sutArgv1QJ/PHfjLbtl9vpDKxtZx4VXxsLsc=
X-Received: by 2002:a25:9347:0:b0:855:d2c4:2119 with SMTP id
 g7-20020a259347000000b00855d2c42119mr1204689ybo.107.1675907301738; Wed, 08
 Feb 2023 17:48:21 -0800 (PST)
MIME-Version: 1.0
References: <20221219055431.22596-1-ashimida.1990@gmail.com>
In-Reply-To: <20221219055431.22596-1-ashimida.1990@gmail.com>
From:   Hongtao Liu <crazylht@gmail.com>
Date:   Thu, 9 Feb 2023 09:48:10 +0800
Message-ID: <CAMZc-bzmACcpSePKxuuA=ug2+yik+Zo3-mfqr2OyZ-n_nT=OnQ@mail.gmail.com>
Subject: Re: [RFC/RFT 0/3] Add compiler support for Control Flow Integrity
To:     Dan Li <ashimida.1990@gmail.com>
Cc:     gcc-patches@gcc.gnu.org,
        Richard Sandiford <richard.sandiford@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Marco Elver <elver@google.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Song Liu <song@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Yuntao Wang <ytcoode@gmail.com>,
        Changbin Du <changbin.du@intel.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 3:59 PM Dan Li via Gcc-patches
<gcc-patches@gcc.gnu.org> wrote:
>
> This series of patches is mainly used to support the control flow
> integrity protection of the linux kernel [1], which is similar to
> -fsanitize=kcfi in clang 16.0 [2,3].
>
> I hope that this feature will also support user-mode CFI in the
> future (at least for developers who can recompile the runtime),
> so I use -fsanitize=cfi as a compilation option here.
>
> Any suggestion please let me know :).
Do you have this series as a branch somewhere that we could also try for x86?

>
> Thanks, Dan.
>
> [1] https://lore.kernel.org/all/20220908215504.3686827-1-samitolvanen@google.com/
> [2] https://clang.llvm.org/docs/ControlFlowIntegrity.html
> [3] https://reviews.llvm.org/D119296
>
> Dan Li (3):
>   [PR102768] flag-types.h (enum sanitize_code): Extend sanitize_code to
>     64 bits to support more features
>   [PR102768] Support CFI: Add new pass for Control Flow Integrity
>   [PR102768] aarch64: Add support for Control Flow Integrity
>
> Signed-off-by: Dan Li <ashimida.1990@gmail.com>
>
> ---
>  gcc/Makefile.in                               |   1 +
>  gcc/asan.h                                    |   4 +-
>  gcc/c-family/c-attribs.cc                     |  10 +-
>  gcc/c-family/c-common.h                       |   2 +-
>  gcc/c/c-parser.cc                             |   4 +-
>  gcc/cgraphunit.cc                             |  34 +++
>  gcc/common.opt                                |   4 +-
>  gcc/config/aarch64/aarch64.cc                 | 106 ++++++++
>  gcc/cp/typeck.cc                              |   2 +-
>  gcc/doc/invoke.texi                           |  35 +++
>  gcc/doc/passes.texi                           |  10 +
>  gcc/doc/tm.texi                               |  27 +++
>  gcc/doc/tm.texi.in                            |   8 +
>  gcc/dwarf2asm.cc                              |   2 +-
>  gcc/flag-types.h                              |  67 ++---
>  gcc/opt-suggestions.cc                        |   2 +-
>  gcc/opts.cc                                   |  26 +-
>  gcc/opts.h                                    |   8 +-
>  gcc/output.h                                  |   3 +
>  gcc/passes.def                                |   1 +
>  gcc/target.def                                |  39 +++
>  .../aarch64/control_flow_integrity_1.c        |  14 ++
>  .../aarch64/control_flow_integrity_2.c        |  25 ++
>  .../aarch64/control_flow_integrity_3.c        |  23 ++
>  gcc/toplev.cc                                 |   4 +
>  gcc/tree-cfg.cc                               |   2 +-
>  gcc/tree-cfi.cc                               | 229 ++++++++++++++++++
>  gcc/tree-pass.h                               |   1 +
>  gcc/tree.cc                                   | 144 +++++++++++
>  gcc/tree.h                                    |   1 +
>  gcc/varasm.cc                                 |  29 +++
>  31 files changed, 803 insertions(+), 64 deletions(-)
>  create mode 100644 gcc/testsuite/gcc.target/aarch64/control_flow_integrity_1.c
>  create mode 100644 gcc/testsuite/gcc.target/aarch64/control_flow_integrity_2.c
>  create mode 100644 gcc/testsuite/gcc.target/aarch64/control_flow_integrity_3.c
>  create mode 100644 gcc/tree-cfi.cc
>
> --
> 2.17.1
>


--
BR,
Hongtao
