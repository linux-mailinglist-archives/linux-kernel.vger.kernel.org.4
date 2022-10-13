Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824FA5FE390
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 22:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiJMUyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 16:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiJMUyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 16:54:09 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62AD175795
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 13:54:08 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id q10-20020a17090a304a00b0020b1d5f6975so2986856pjl.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 13:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GoFfFfDn3VQkpPm7uWehivLwKK9ykq+Mq5wgEF+ifbk=;
        b=Tp9qi0TuTxLiRmZJ73P8Jqkz5cFz3/ZraH6x6b8QsdXVOf6tJ4xob/q5yBhG3kqenY
         c/Dxlz2HSmhD+1ISeYTEjlw0e6LHvjCtbcKXEZ0jJrz0wqdDEmmC7GhKf9xSa0FDHnhZ
         OMZ02jj3XG8hcZuSleqn7zMtYT729WnP6KvFJNtEuaE9FYt71fAwfUBYrSLcHMcjWjNa
         LavgOyN5QbdnTuat00mf9C9ytjJ0hyHpsvkrms7qL2Zw1oBd3ICaYyB4LC+Aq+VZiJxG
         dRMYW7nYNzhs2zEI1HKxloCJDfo1c2nkExyMYAgo2iJ1rysvwEVQ0PB6ZIzjjuIRy+oe
         Eqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GoFfFfDn3VQkpPm7uWehivLwKK9ykq+Mq5wgEF+ifbk=;
        b=ir/IWWGSa6wmjZQ6SyRba+xWqCr4Zu2VKn8ZW6ehJ0APzHXndlfL0c84wrDb+/YdCq
         8xmAGHhS5Anwac2IsmlEeQ07vzcfD6xC1iMFBC8F6yy4iVU8TNVtjMvAqWvSYXaiJUNp
         tK4pNK8PSi/IpDImlm85ixJaoC9m9E8772gMJW0B50DW5Ok5UfXLaiYtMve7rIYSOWSF
         WnyZrH4+OF6Dsz8UK9XGh+aLllXXZjCrnRfIOkD1Kv7JtbqR3l/fhumev0MbrHdKdDyw
         6ZFO8Ki2wEf3kuZ6ccWzFKf7SYF2aK8rQ3/wj/BS1ypWRNXYvlb82c9Fa7ezlNJ7L4nf
         LekQ==
X-Gm-Message-State: ACrzQf0zHOIV8qF+ylsFdmRR9PFWjvrRVpSym3UdtmCP2JjnC94qhV+I
        tv5OF3D1yypxfe08KYCqenylw2pZrz/z+Lv9JGaYjg==
X-Google-Smtp-Source: AMsMyM66I+rqXcc4prQlLIG+LwbinW4pY3ihokxrORiav1V7qXz9FmyouE/WnDWoPn8qucVCvDJ2Ko9xoTY3Yt42WV8=
X-Received: by 2002:a17:902:b218:b0:184:710c:8c52 with SMTP id
 t24-20020a170902b21800b00184710c8c52mr1632657plr.95.1665694448056; Thu, 13
 Oct 2022 13:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <20221007203236.1750890-1-ndesaulniers@google.com>
 <Y0htZDJoTuQegVQR@dev-arch.thelio-3990X> <20221013204151.skzateatn2keencb@google.com>
In-Reply-To: <20221013204151.skzateatn2keencb@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 13 Oct 2022 13:53:56 -0700
Message-ID: <CAKwvOdmoXLvfgEWx740mw+Uqy3nfPM=a7ywVeOJ5XivGT=yRog@mail.gmail.com>
Subject: Re: [PATCH] kbuild: add -fno-discard-value-names to cmd_cc_ll_c
To:     Fangrui Song <maskray@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Tom Rix <trix@redhat.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 1:41 PM Fangrui Song <maskray@google.com> wrote:
>
> On 2022-10-13, Nathan Chancellor wrote:
> >On Fri, Oct 07, 2022 at 01:32:36PM -0700, Nick Desaulniers wrote:
> >> When debugging LLVM IR, it can be handy for clang to not discard value
> >> names used for local variables and parameters. Compare the generated IR.
> >>
> >> Implicit Default (-fdiscard-value-names):
> >>   define i32 @core_sys_select(i32 %0, ptr %1, ptr %2, ptr %3, ptr %4) {
> >>     %6 = alloca i64
> >>     %7 = alloca %struct.poll_wqueues
> >>     %8 = alloca [64 x i32]
> >>
> >> Explicit -fno-discard-value-names:
> >>   define i32 @core_sys_select(i32 %n, ptr %inp, ptr %outp, ptr %exp,
> >>                               ptr %end_time) {
> >>     %expire.i = alloca i64
> >>     %table.i = alloca %struct.poll_wqueues
> >>     %stack_fds = alloca [64 x i32]
> >>
> >> The rule for generating human readable LLVM IR (.ll) is only useful as a
> >> debugging feature:
> >>
> >> $ make LLVM=1 fs/select.ll
> >>
> >> Clang defaults to -fdiscard-value-names to save memory when generating
> >> LLVM IR. For debugging purposes, the improvement in readability at a
> >> cost of more verbose IR is a cost we're happy to pay.
>
> A LLVM_ENABLE_ASSEERTIONS=off build of Clang defaults to -fdiscard-value-names.
>
> A LLVM_ENABLE_ASSEERTIONS=on build of Clang defaults to -fno-discard-value-names.
>
> See clang/lib/Driver/ToolChains/Clang.cpp:5030

Thanks!

I thought I recalled this; I was literally just rereading through
https://github.com/ClangBuiltLinux/linux/issues/1467#issuecomment-1046071624
again to understand.

That would be useful to include in the commit message, and is more
precise than "Clang defaults to -fdiscard-value-names to save memory
when generating LLVM IR."  Masahiro, would you mind including or
replacing that, or shall I send a v2?

I was surprised to find later in the day that I was running an
assertions-disabled (ie. release) build of clang, which I almost never
do!  Non-llvm-developers are more likely to be using release builds
than assertions-enabled builds of llvm, so this patch still very much
has merit.

>
> >> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> >
> >Thanks for the patch!
> >
> >Link: https://github.com/ClangBuiltLinux/linux/issues/1467
> >Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>
> Reviewed-by: Fangrui Song <maskray@google.com>
>
> >> ---
> >>  scripts/Makefile.build | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> >> index 27be77c0d6d8..d0e4f476dfee 100644
> >> --- a/scripts/Makefile.build
> >> +++ b/scripts/Makefile.build
> >> @@ -140,7 +140,7 @@ $(obj)/%.symtypes : $(src)/%.c FORCE
> >>  # LLVM assembly
> >>  # Generate .ll files from .c
> >>  quiet_cmd_cc_ll_c = CC $(quiet_modtag)  $@
> >> -      cmd_cc_ll_c = $(CC) $(c_flags) -emit-llvm -S -o $@ $<
> >> +      cmd_cc_ll_c = $(CC) $(c_flags) -emit-llvm -S -fno-discard-value-names -o $@ $<
> >>
> >>  $(obj)/%.ll: $(src)/%.c FORCE
> >>      $(call if_changed_dep,cc_ll_c)
> >>
> >> base-commit: 93ed07a23fd08b8613f64cf0a15d7fbdaca010fd
> >> --
> >> 2.38.0.rc2.412.g84df46c1b4-goog
> >>
> >



-- 
Thanks,
~Nick Desaulniers
