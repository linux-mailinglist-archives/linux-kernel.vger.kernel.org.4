Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886A96F1320
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 10:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345225AbjD1IRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 04:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjD1IRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 04:17:02 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28B51FE4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 01:16:57 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1psIjg-00085X-3P; Fri, 28 Apr 2023 09:41:44 +0200
Message-ID: <325ae81d-b3a5-71b3-39e9-96408968ab0b@leemhuis.info>
Date:   Fri, 28 Apr 2023 09:41:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, de-DE
To:     Shreeya Patel <shreeya.patel@collabora.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Bill Wendling <morbo@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        regressions@lists.linux.dev
References: <CAK7LNAT_cMLGLBz7ugaLpJD3QmZmY8FK56x9nihvWeYhJpi2ag@mail.gmail.com>
 <20220919170828.3718437-1-ndesaulniers@google.com>
 <597ef55f-e7c1-ab60-b4aa-0071ff4b5e0e@collabora.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [PATCH v4] Makefile.compiler: replace cc-ifversion with
 compiler-specific macros
In-Reply-To: <597ef55f-e7c1-ab60-b4aa-0071ff4b5e0e@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1682669817;5a5fd77a;
X-HE-SMSGID: 1psIjg-00085X-3P
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shreeya!

On 27.04.23 13:53, Shreeya Patel wrote:
> On 19/09/22 22:38, Nick Desaulniers wrote:
>> cc-ifversion is GCC specific. Replace it with compiler specific
>> variants. Update the users of cc-ifversion to use these new macros.
>>
>> Link: https://github.com/ClangBuiltLinux/linux/issues/350
>> Link:
>> https://lore.kernel.org/llvm/CAGG=3QWSAUakO42kubrCap8fp-gm1ERJJAYXTnP1iHk_wrH=BQ@mail.gmail.com/
>> Suggested-by: Bill Wendling <morbo@google.com>
>> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> KernelCI found this patch causes a regression in the
> baseline.logintest on qemu_arm-virt-gicv3-uefi [1],
> see the bisection report for more details [2].
> 
> Let me know if you have any questions.
> 
> [1] https://linux.kernelci.org/test/case/id/644596a0beca2ead032e8669/
> [2] https://groups.io/g/kernelci-results/message/40804> [...]
> #regzbot introduced: 88b61e3bff93

How much of this text is auto generated? I ask for two reasons:

* You made regzbot track this, which is great, but didn't specify a
title. That is fine in general, if the subject round about says what the
regression is about. But in this case it doesn't; hence it would be
great if you in the future could specify one through "#regzbot title:"
or adjust the mail's subject (I guess the former is what developers will
prefer).

* I'm not a developer that has to look into bugs like this, but from my
experience I expect a lot more developers are likely willing to look
into reports like this if you specified what the actual problem is --
ideally with the relevant error messages.

Side note: I for one still am unsure what this is actually about after
looking at the page you provided as [1] and clicking on a few links
there (which took me a few minutes, which I guess not everyone is
willing to invest). I noticed two kernel warning in the log (one from
"arch/arm/kernel/insn.c:48 __arm_gen_branch+0x88/0xa4", the other
"kernel/trace/ftrace.c:2176 ftrace_bug+0x340/0x3b4") and a complaint
UBSAN (btw: those newlines in the logs make things harder to read, at
least for me).

To check if those were old or new problems, I tired to go back in the
history and on page 9 found an entry for the last succeeding test. But
clicking on the logs got me a 404 :-/

Then I looked at the logs on [1] again and in the html view "Boot
result: FAIL". Is that the actual problem?

Ciao, Thorsten

P.S.: let me update the regzbot title while at it:

#regzbot title: kernelci: qemu_arm-virt-gicv3-uefi stopped booting

>> ---
>> Changes v3 -> v4:
>> * Split into its own patch again from series, as per Masahiro.
>> * Rebase on top of b0839b281c427e844143dba3893e25c83cdd6c17 and update
>>    clang -Wformat logic in scripts/Makefile.extrawarn, as per Masahiro.
>>
>>   Documentation/kbuild/makefiles.rst          | 29 ++++++++++++---------
>>   Makefile                                    |  6 ++---
>>   drivers/gpu/drm/amd/display/dc/dml/Makefile |  2 +-
>>   scripts/Makefile.compiler                   | 10 ++++---
>>   scripts/Makefile.extrawarn                  |  4 +--
>>   5 files changed, 29 insertions(+), 22 deletions(-)
>>
>> diff --git a/Documentation/kbuild/makefiles.rst
>> b/Documentation/kbuild/makefiles.rst
>> index 11a296e52d68..ee7e3ea1fbe1 100644
>> --- a/Documentation/kbuild/makefiles.rst
>> +++ b/Documentation/kbuild/makefiles.rst
>> @@ -682,22 +682,27 @@ more details, with real examples.
>>       In the above example, -Wno-unused-but-set-variable will be added to
>>       KBUILD_CFLAGS only if gcc really accepts it.
>>   -    cc-ifversion
>> -    cc-ifversion tests the version of $(CC) and equals the fourth
>> parameter
>> -    if version expression is true, or the fifth (if given) if the
>> version
>> -    expression is false.
>> +    gcc-min-version
>> +    gcc-min-version tests if the value of $(CONFIG_GCC_VERSION) is
>> greater than
>> +    or equal to the provided value and evaluates to y if so.
>>         Example::
>>   -        #fs/reiserfs/Makefile
>> -        ccflags-y := $(call cc-ifversion, -lt, 0402, -O1)
>> +        cflags-$(call gcc-min-version, 70100) := -foo
>>   -    In this example, ccflags-y will be assigned the value -O1 if the
>> -    $(CC) version is less than 4.2.
>> -    cc-ifversion takes all the shell operators:
>> -    -eq, -ne, -lt, -le, -gt, and -ge
>> -    The third parameter may be a text as in this example, but it may
>> also
>> -    be an expanded variable or a macro.
>> +    In this example, cflags-y will be assigned the value -foo if
>> $(CC) is gcc and
>> +    $(CONFIG_GCC_VERSION) is >= 7.1.
>> +
>> +    clang-min-version
>> +    clang-min-version tests if the value of $(CONFIG_CLANG_VERSION)
>> is greater
>> +    than or equal to the provided value and evaluates to y if so.
>> +
>> +    Example::
>> +
>> +        cflags-$(call clang-min-version, 110000) := -foo
>> +
>> +    In this example, cflags-y will be assigned the value -foo if
>> $(CC) is clang
>> +    and $(CONFIG_CLANG_VERSION) is >= 11.0.0.
>>         cc-cross-prefix
>>       cc-cross-prefix is used to check if there exists a $(CC) in path
>> with
>> diff --git a/Makefile b/Makefile
>> index 298f69060f10..411c8480b37e 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -790,7 +790,6 @@ KBUILD_CFLAGS += $(stackp-flags-y)
>>     KBUILD_CFLAGS-$(CONFIG_WERROR) += -Werror
>>   KBUILD_CFLAGS-$(CONFIG_CC_NO_ARRAY_BOUNDS) += -Wno-array-bounds
>> -KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
>>     ifdef CONFIG_CC_IS_CLANG
>>   KBUILD_CPPFLAGS += -Qunused-arguments
>> @@ -972,7 +971,6 @@ ifdef CONFIG_CC_IS_GCC
>>   KBUILD_CFLAGS += -Wno-maybe-uninitialized
>>   endif
>>   -ifdef CONFIG_CC_IS_GCC
>>   # The allocators already balk at large sizes, so silence the compiler
>>   # warnings for bounds checks involving those possible values. While
>>   # -Wno-alloc-size-larger-than would normally be used here, earlier
>> versions
>> @@ -984,8 +982,8 @@ ifdef CONFIG_CC_IS_GCC
>>   # ignored, continuing to default to PTRDIFF_MAX. So, left with no other
>>   # choice, we must perform a versioned check to disable this warning.
>>   # https://lore.kernel.org/lkml/20210824115859.187f272f@canb.auug.org.au
>> -KBUILD_CFLAGS += $(call cc-ifversion, -ge, 0901,
>> -Wno-alloc-size-larger-than)
>> -endif
>> +KBUILD_CFLAGS-$(call gcc-min-version, 90100) +=
>> -Wno-alloc-size-larger-than
>> +KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
>>     # disable invalid "can't wrap" optimizations for signed / pointers
>>   KBUILD_CFLAGS    += -fno-strict-overflow
>> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile
>> b/drivers/gpu/drm/amd/display/dc/dml/Makefile
>> index cb81ed2fbd53..d70838edba80 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
>> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
>> @@ -34,7 +34,7 @@ dml_ccflags := -mhard-float -maltivec
>>   endif
>>     ifdef CONFIG_CC_IS_GCC
>> -ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>> +ifneq ($(call gcc-min-version, 70100),y)
>>   IS_OLD_GCC = 1
>>   endif
>>   endif
>> diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
>> index 94d0d40cddb3..9d18fb91890e 100644
>> --- a/scripts/Makefile.compiler
>> +++ b/scripts/Makefile.compiler
>> @@ -61,9 +61,13 @@ cc-option-yn = $(call try-run,\
>>   cc-disable-warning = $(call try-run,\
>>       $(CC) -Werror $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -W$(strip
>> $(1)) -c -x c /dev/null -o "$$TMP",-Wno-$(strip $(1)))
>>   -# cc-ifversion
>> -# Usage:  EXTRA_CFLAGS += $(call cc-ifversion, -lt, 0402, -O1)
>> -cc-ifversion = $(shell [ $(CONFIG_GCC_VERSION)0 $(1) $(2)000 ] &&
>> echo $(3) || echo $(4))
>> +# gcc-min-version
>> +# Usage: cflags-$(call gcc-min-version, 70100) += -foo
>> +gcc-min-version = $(shell [ $(CONFIG_GCC_VERSION) -ge $(1) ] && echo y)
>> +
>> +# clang-min-version
>> +# Usage: cflags-$(call clang-min-version, 110000) += -foo
>> +clang-min-version = $(shell [ $(CONFIG_CLANG_VERSION) -ge $(1) ] &&
>> echo y)
>>     # ld-option
>>   # Usage: KBUILD_LDFLAGS += $(call ld-option, -X, -Y)
>> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
>> index 6ae482158bc4..5769c1939d40 100644
>> --- a/scripts/Makefile.extrawarn
>> +++ b/scripts/Makefile.extrawarn
>> @@ -48,7 +48,7 @@ else
>>   ifdef CONFIG_CC_IS_CLANG
>>   KBUILD_CFLAGS += -Wno-initializer-overrides
>>   # Clang before clang-16 would warn on default argument promotions.
>> -ifeq ($(shell [ $(CONFIG_CLANG_VERSION) -lt 160000 ] && echo y),y)
>> +ifneq ($(call clang-min-version, 160000),y)
>>   # Disable -Wformat
>>   KBUILD_CFLAGS += -Wno-format
>>   # Then re-enable flags that were part of the -Wformat group that aren't
>> @@ -56,7 +56,7 @@ KBUILD_CFLAGS += -Wno-format
>>   KBUILD_CFLAGS += -Wformat-extra-args -Wformat-invalid-specifier
>>   KBUILD_CFLAGS += -Wformat-zero-length -Wnonnull
>>   # Requires clang-12+.
>> -ifeq ($(shell [ $(CONFIG_CLANG_VERSION) -ge 120000 ] && echo y),y)
>> +ifeq ($(call clang-min-version, 120000),y)
>>   KBUILD_CFLAGS += -Wformat-insufficient-args
>>   endif
>>   endif
> 
> 
