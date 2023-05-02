Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B784E6F4062
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 11:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbjEBJsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 05:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjEBJsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 05:48:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06214C29
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 02:48:48 -0700 (PDT)
Received: from [IPV6:2405:201:0:21ea:73f6:2283:f432:3936] (unknown [IPv6:2405:201:0:21ea:73f6:2283:f432:3936])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8C9AA66029AB;
        Tue,  2 May 2023 10:48:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683020927;
        bh=BTDP5HQlkjzIWb3E0kJ/uZm+RAC0iF2hvRKA0Tg7Bn0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PWvIxPMjXhzU3qoNaB3i1oE/ZQ9YV4vibOjIaRY4pw/dcd3S1e3c2jvAf5J+6ZZiy
         zK5t2UyNs8SWVt07L3g6O1TO41J1HkI3g7cC/BHclvKCTmr+EJlDESje9Oyw4fniVz
         gUL9Tyy1pmehNS8gUjzagLwuieX66RRcGHAUy+pPsVZQMhQ6qZq9cDPNRyqryIeuNf
         F+qnJ2tM+NSVh/I7oOiQM3v1o9KtxYdgAKwsUHWh/k/SM457ZNAv9FXZ0vpW42v3wD
         M/u8BbZEPH+sQI450thEGix9czWItzeXo7AphxYUjTW1ASqzP5tV9Wri+qUz+L1Ml4
         NUi5mRhReHwbA==
Message-ID: <1209349b-9634-c1ca-d2ee-182e8dec2de5@collabora.com>
Date:   Tue, 2 May 2023 15:18:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4] Makefile.compiler: replace cc-ifversion with
 compiler-specific macros
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Bill Wendling <morbo@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        regressions@lists.linux.dev, kernelci@lists.linux.dev,
        "gustavo.padovan@collabora.com" <gustavo.padovan@collabora.com>,
        Guillaume Charles Tucker <guillaume.tucker@collabora.com>,
        ricardo.canuelo@collabora.com, denys.f@collabora.com
References: <CAK7LNAT_cMLGLBz7ugaLpJD3QmZmY8FK56x9nihvWeYhJpi2ag@mail.gmail.com>
 <20220919170828.3718437-1-ndesaulniers@google.com>
 <597ef55f-e7c1-ab60-b4aa-0071ff4b5e0e@collabora.com>
 <325ae81d-b3a5-71b3-39e9-96408968ab0b@leemhuis.info>
Content-Language: en-US
From:   Shreeya Patel <shreeya.patel@collabora.com>
In-Reply-To: <325ae81d-b3a5-71b3-39e9-96408968ab0b@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thorsten,

On 28/04/23 13:11, Thorsten Leemhuis wrote:
> Hi Shreeya!
>
> On 27.04.23 13:53, Shreeya Patel wrote:
>> On 19/09/22 22:38, Nick Desaulniers wrote:
>>> cc-ifversion is GCC specific. Replace it with compiler specific
>>> variants. Update the users of cc-ifversion to use these new macros.
>>>
>>> Link: https://github.com/ClangBuiltLinux/linux/issues/350
>>> Link:
>>> https://lore.kernel.org/llvm/CAGG=3QWSAUakO42kubrCap8fp-gm1ERJJAYXTnP1iHk_wrH=BQ@mail.gmail.com/
>>> Suggested-by: Bill Wendling <morbo@google.com>
>>> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>>> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>> KernelCI found this patch causes a regression in the
>> baseline.logintest on qemu_arm-virt-gicv3-uefi [1],
>> see the bisection report for more details [2].
>>
>> Let me know if you have any questions.
>>
>> [1] https://linux.kernelci.org/test/case/id/644596a0beca2ead032e8669/
>> [2] https://groups.io/g/kernelci-results/message/40804> [...]
>> #regzbot introduced: 88b61e3bff93
> How much of this text is auto generated? I ask for two reasons:

None of this text is auto generated yet but we plan to do it soon once
we think the format of the reporting email is good enough for people to 
understand
and look into it. Which is why your comments are really helpful here.


>
> * You made regzbot track this, which is great, but didn't specify a
> title. That is fine in general, if the subject round about says what the
> regression is about. But in this case it doesn't; hence it would be
> great if you in the future could specify one through "#regzbot title:"
> or adjust the mail's subject (I guess the former is what developers will
> prefer).


Noted. If I think the title is not very explanatory then I'll change it 
to reflect the problem in future.


> * I'm not a developer that has to look into bugs like this, but from my
> experience I expect a lot more developers are likely willing to look
> into reports like this if you specified what the actual problem is --
> ideally with the relevant error messages.
>
> Side note: I for one still am unsure what this is actually about after
> looking at the page you provided as [1] and clicking on a few links
> there (which took me a few minutes, which I guess not everyone is
> willing to invest). I noticed two kernel warning in the log (one from
> "arch/arm/kernel/insn.c:48 __arm_gen_branch+0x88/0xa4", the other
> "kernel/trace/ftrace.c:2176 ftrace_bug+0x340/0x3b4") and a complaint
> UBSAN (btw: those newlines in the logs make things harder to read, at
> least for me).

For this particular regression, it is possible that the following kernel 
warnings/errors could be the reason of failure.


   572 20:30:46.811318  <3>[    0.417001][    T1] UBSAN: 
array-index-out-of-bounds in ../arch/arm/mach-sunxi/mc_smp.c:811:29
   574 20:30:46.812203  <3>[    0.417963][    T1] index 2 is out of 
range for type 'sunxi_mc_smp_data [2]'


and

   426 20:30:44.726421  <4>[    0.000000][    T0] WARNING: CPU: 0 PID: 0 
at kernel/trace/ftrace.c:2176 ftrace_bug+0x340/0x3b4
   428 20:30:44.727284  <4>[    0.000000][    T0] Modules linked in:
   430 20:30:44.728487  <4>[    0.000000][    T0] CPU: 0 PID: 0 Comm: 
swapper Tainted: G        W          6.3.0 #1
.........

I understand that it might be more helpful to atleast put little more 
information about what is causing the regression here.
I'll provide some more details in future for it to be easy for 
developers to look into it.

> To check if those were old or new problems, I tired to go back in the
> history and on page 9 found an entry for the last succeeding test. But
> clicking on the logs got me a 404 :-/
>
> Then I looked at the logs on [1] again and in the html view "Boot
> result: FAIL". Is that the actual problem?

Unfortunately, we do have some broken links in the current KernelCI 
dashboard but the KernelCI team
is working on a new API and database interface which will fix these issues.
It might not be worth to spend time to fix issues on the current 
dashboard since the process for getting the archived
logs is not very straightforward.

What I can do from my side is to attach logs of the working kernel if I 
can get them through LAVA.
But one thing to note is that even LAVA stores limited logs and we won't 
be able to provide them always like in this case
since the regression has been happening from a long time.

Thanks for your input though, we will work on it and get a better format 
ready for reporting the regressions.


Thanks,
Shreeya Patel

>
> Ciao, Thorsten
>
> P.S.: let me update the regzbot title while at it:
>
> #regzbot title: kernelci: qemu_arm-virt-gicv3-uefi stopped booting
>
>>> ---
>>> Changes v3 -> v4:
>>> * Split into its own patch again from series, as per Masahiro.
>>> * Rebase on top of b0839b281c427e844143dba3893e25c83cdd6c17 and update
>>>     clang -Wformat logic in scripts/Makefile.extrawarn, as per Masahiro.
>>>
>>>    Documentation/kbuild/makefiles.rst          | 29 ++++++++++++---------
>>>    Makefile                                    |  6 ++---
>>>    drivers/gpu/drm/amd/display/dc/dml/Makefile |  2 +-
>>>    scripts/Makefile.compiler                   | 10 ++++---
>>>    scripts/Makefile.extrawarn                  |  4 +--
>>>    5 files changed, 29 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/Documentation/kbuild/makefiles.rst
>>> b/Documentation/kbuild/makefiles.rst
>>> index 11a296e52d68..ee7e3ea1fbe1 100644
>>> --- a/Documentation/kbuild/makefiles.rst
>>> +++ b/Documentation/kbuild/makefiles.rst
>>> @@ -682,22 +682,27 @@ more details, with real examples.
>>>        In the above example, -Wno-unused-but-set-variable will be added to
>>>        KBUILD_CFLAGS only if gcc really accepts it.
>>>    -    cc-ifversion
>>> -    cc-ifversion tests the version of $(CC) and equals the fourth
>>> parameter
>>> -    if version expression is true, or the fifth (if given) if the
>>> version
>>> -    expression is false.
>>> +    gcc-min-version
>>> +    gcc-min-version tests if the value of $(CONFIG_GCC_VERSION) is
>>> greater than
>>> +    or equal to the provided value and evaluates to y if so.
>>>          Example::
>>>    -        #fs/reiserfs/Makefile
>>> -        ccflags-y := $(call cc-ifversion, -lt, 0402, -O1)
>>> +        cflags-$(call gcc-min-version, 70100) := -foo
>>>    -    In this example, ccflags-y will be assigned the value -O1 if the
>>> -    $(CC) version is less than 4.2.
>>> -    cc-ifversion takes all the shell operators:
>>> -    -eq, -ne, -lt, -le, -gt, and -ge
>>> -    The third parameter may be a text as in this example, but it may
>>> also
>>> -    be an expanded variable or a macro.
>>> +    In this example, cflags-y will be assigned the value -foo if
>>> $(CC) is gcc and
>>> +    $(CONFIG_GCC_VERSION) is >= 7.1.
>>> +
>>> +    clang-min-version
>>> +    clang-min-version tests if the value of $(CONFIG_CLANG_VERSION)
>>> is greater
>>> +    than or equal to the provided value and evaluates to y if so.
>>> +
>>> +    Example::
>>> +
>>> +        cflags-$(call clang-min-version, 110000) := -foo
>>> +
>>> +    In this example, cflags-y will be assigned the value -foo if
>>> $(CC) is clang
>>> +    and $(CONFIG_CLANG_VERSION) is >= 11.0.0.
>>>          cc-cross-prefix
>>>        cc-cross-prefix is used to check if there exists a $(CC) in path
>>> with
>>> diff --git a/Makefile b/Makefile
>>> index 298f69060f10..411c8480b37e 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -790,7 +790,6 @@ KBUILD_CFLAGS += $(stackp-flags-y)
>>>      KBUILD_CFLAGS-$(CONFIG_WERROR) += -Werror
>>>    KBUILD_CFLAGS-$(CONFIG_CC_NO_ARRAY_BOUNDS) += -Wno-array-bounds
>>> -KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
>>>      ifdef CONFIG_CC_IS_CLANG
>>>    KBUILD_CPPFLAGS += -Qunused-arguments
>>> @@ -972,7 +971,6 @@ ifdef CONFIG_CC_IS_GCC
>>>    KBUILD_CFLAGS += -Wno-maybe-uninitialized
>>>    endif
>>>    -ifdef CONFIG_CC_IS_GCC
>>>    # The allocators already balk at large sizes, so silence the compiler
>>>    # warnings for bounds checks involving those possible values. While
>>>    # -Wno-alloc-size-larger-than would normally be used here, earlier
>>> versions
>>> @@ -984,8 +982,8 @@ ifdef CONFIG_CC_IS_GCC
>>>    # ignored, continuing to default to PTRDIFF_MAX. So, left with no other
>>>    # choice, we must perform a versioned check to disable this warning.
>>>    # https://lore.kernel.org/lkml/20210824115859.187f272f@canb.auug.org.au
>>> -KBUILD_CFLAGS += $(call cc-ifversion, -ge, 0901,
>>> -Wno-alloc-size-larger-than)
>>> -endif
>>> +KBUILD_CFLAGS-$(call gcc-min-version, 90100) +=
>>> -Wno-alloc-size-larger-than
>>> +KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
>>>      # disable invalid "can't wrap" optimizations for signed / pointers
>>>    KBUILD_CFLAGS    += -fno-strict-overflow
>>> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile
>>> b/drivers/gpu/drm/amd/display/dc/dml/Makefile
>>> index cb81ed2fbd53..d70838edba80 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
>>> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
>>> @@ -34,7 +34,7 @@ dml_ccflags := -mhard-float -maltivec
>>>    endif
>>>      ifdef CONFIG_CC_IS_GCC
>>> -ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>>> +ifneq ($(call gcc-min-version, 70100),y)
>>>    IS_OLD_GCC = 1
>>>    endif
>>>    endif
>>> diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
>>> index 94d0d40cddb3..9d18fb91890e 100644
>>> --- a/scripts/Makefile.compiler
>>> +++ b/scripts/Makefile.compiler
>>> @@ -61,9 +61,13 @@ cc-option-yn = $(call try-run,\
>>>    cc-disable-warning = $(call try-run,\
>>>        $(CC) -Werror $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -W$(strip
>>> $(1)) -c -x c /dev/null -o "$$TMP",-Wno-$(strip $(1)))
>>>    -# cc-ifversion
>>> -# Usage:  EXTRA_CFLAGS += $(call cc-ifversion, -lt, 0402, -O1)
>>> -cc-ifversion = $(shell [ $(CONFIG_GCC_VERSION)0 $(1) $(2)000 ] &&
>>> echo $(3) || echo $(4))
>>> +# gcc-min-version
>>> +# Usage: cflags-$(call gcc-min-version, 70100) += -foo
>>> +gcc-min-version = $(shell [ $(CONFIG_GCC_VERSION) -ge $(1) ] && echo y)
>>> +
>>> +# clang-min-version
>>> +# Usage: cflags-$(call clang-min-version, 110000) += -foo
>>> +clang-min-version = $(shell [ $(CONFIG_CLANG_VERSION) -ge $(1) ] &&
>>> echo y)
>>>      # ld-option
>>>    # Usage: KBUILD_LDFLAGS += $(call ld-option, -X, -Y)
>>> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
>>> index 6ae482158bc4..5769c1939d40 100644
>>> --- a/scripts/Makefile.extrawarn
>>> +++ b/scripts/Makefile.extrawarn
>>> @@ -48,7 +48,7 @@ else
>>>    ifdef CONFIG_CC_IS_CLANG
>>>    KBUILD_CFLAGS += -Wno-initializer-overrides
>>>    # Clang before clang-16 would warn on default argument promotions.
>>> -ifeq ($(shell [ $(CONFIG_CLANG_VERSION) -lt 160000 ] && echo y),y)
>>> +ifneq ($(call clang-min-version, 160000),y)
>>>    # Disable -Wformat
>>>    KBUILD_CFLAGS += -Wno-format
>>>    # Then re-enable flags that were part of the -Wformat group that aren't
>>> @@ -56,7 +56,7 @@ KBUILD_CFLAGS += -Wno-format
>>>    KBUILD_CFLAGS += -Wformat-extra-args -Wformat-invalid-specifier
>>>    KBUILD_CFLAGS += -Wformat-zero-length -Wnonnull
>>>    # Requires clang-12+.
>>> -ifeq ($(shell [ $(CONFIG_CLANG_VERSION) -ge 120000 ] && echo y),y)
>>> +ifeq ($(call clang-min-version, 120000),y)
>>>    KBUILD_CFLAGS += -Wformat-insufficient-args
>>>    endif
>>>    endif
>>
