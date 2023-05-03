Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597956F6154
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 00:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjECWdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 18:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjECWdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 18:33:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F87076AB
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 15:33:46 -0700 (PDT)
Received: from [IPV6:2405:201:0:21ea:73f6:2283:f432:3936] (unknown [IPv6:2405:201:0:21ea:73f6:2283:f432:3936])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3BF6F6603266;
        Wed,  3 May 2023 23:33:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683153225;
        bh=4WkOogTtJrD3+NR/Nk5nJVdPCkSkmcAn8cr7Oj4EQjk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PALAqmPPGz5psOkI/ERWub7qRGcnPL2b7cOJg8cqyqyjfARzeU6ALwkPz4w5B4Iu4
         /RQ6MlzYONC/IYs5eIZ+FFelrjTL+4V0n23zcELZavCzWegJa+akrf4G5/YhwIDOpz
         DaZUUwPz5+kMHX3/hq0BiPVrd3SnNgYvnTRZEgTjosv7zZOLpBvJaVZKMvlz1CuKbz
         gsP+Wqofwa3pmKu17Ti/8Ts0frSZUQZxQkmIjGOGF6e1jyQ01tNgDRPdlxHOOrWGpJ
         e+XbqNmDykPKA18iquB20b5OL7vLqyM1idwjJoKv110Iyb0Ez0eyNu5DWrC25qBoER
         NPHU4IlIlPulA==
Message-ID: <17c91d37-7d9c-0df4-2438-2b30ca0b5777@collabora.com>
Date:   Thu, 4 May 2023 04:03:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4] Makefile.compiler: replace cc-ifversion with
 compiler-specific macros
Content-Language: en-US
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Bill Wendling <morbo@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        regressions@lists.linux.dev,
        "gustavo.padovan@collabora.com" <gustavo.padovan@collabora.com>,
        Guillaume Charles Tucker <guillaume.tucker@collabora.com>,
        denys.f@collabora.com, ricardo.canuelo@collabora.com,
        kernelci@lists.linux.dev
References: <CAK7LNAT_cMLGLBz7ugaLpJD3QmZmY8FK56x9nihvWeYhJpi2ag@mail.gmail.com>
 <20220919170828.3718437-1-ndesaulniers@google.com>
 <597ef55f-e7c1-ab60-b4aa-0071ff4b5e0e@collabora.com>
 <CAKwvOdmSrAxx-YY1Na3BSdYuxXCPKK+F0K5V6i+adTn_bVJEsw@mail.gmail.com>
 <89961dfc-d40f-78e4-5d34-b86b7d152182@collabora.com>
 <CAKwvOd=4hBcU4fAkddU0b-GOZc9FzTZoj3PFW6ZZrX0jS8x+bg@mail.gmail.com>
From:   Shreeya Patel <shreeya.patel@collabora.com>
In-Reply-To: <CAKwvOd=4hBcU4fAkddU0b-GOZc9FzTZoj3PFW6ZZrX0jS8x+bg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/05/23 02:45, Nick Desaulniers wrote:
> On Wed, May 3, 2023 at 2:02 PM Shreeya Patel
> <shreeya.patel@collabora.com> wrote:
>> Hi Nick,
>>
>> On 28/04/23 22:57, Nick Desaulniers wrote:
>>> On Thu, Apr 27, 2023 at 4:54 AM Shreeya Patel
>>> <shreeya.patel@collabora.com> wrote:
>>>> Hi Nick,
>>>>
>>>> On 19/09/22 22:38, Nick Desaulniers wrote:
>>>>> cc-ifversion is GCC specific. Replace it with compiler specific
>>>>> variants. Update the users of cc-ifversion to use these new macros.
>>>>>
>>>>> Link: https://github.com/ClangBuiltLinux/linux/issues/350
>>>>> Link: https://lore.kernel.org/llvm/CAGG=3QWSAUakO42kubrCap8fp-gm1ERJJAYXTnP1iHk_wrH=BQ@mail.gmail.com/
>>>>> Suggested-by: Bill Wendling <morbo@google.com>
>>>>> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>>>>> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>>>> KernelCI found this patch causes a regression in the
>>>> baseline.logintest on qemu_arm-virt-gicv3-uefi [1],
>>>> see the bisection report for more details [2].
>>>>
>>>> Let me know if you have any questions.
>>>>
>>>>
>>>> [1] https://linux.kernelci.org/test/case/id/644596a0beca2ead032e8669/
>>> Hi Shreeya,
>>> Thanks for the report.
>>>
>>> When I click the above link, then click `multi_v7_defconfig+debug` to
>>> get the config necessary to reproduce, I get an HTTP 404.
>>> https://storage.kernelci.org/mainline/master/v6.3/arm/multi_v7_defconfig+debug/gcc-10/kernel.config
>>>
>>> Same for zImage
>>> https://storage.kernelci.org/mainline/master/v6.3/arm/multi_v7_defconfig+debug/gcc-10/zImage
>> Apologies for the broken links. We will try to fix the important ones if
>> we can but in the meantime,
>> following is the correct link that you can refer.
>>
>> config :-
>> https://storage.kernelci.org/mainline/master/v6.3/arm/multi_v7_defconfig+debug/gcc-10/config/kernel.config
>>
>> zImage :-
>> https://storage.kernelci.org/mainline/master/v6.3/arm/multi_v7_defconfig+debug/gcc-10/kernel/zImage
>>
>> If you notice, they are present under the kernel directory and same way
>> you can find links for other kernel
>> builds if you'd like to check them out.
>>
>>> If I click on the log
>>> https://storage.kernelci.org/mainline/master/v6.3/arm/multi_v7_defconfig+debug/gcc-10/lab-collabora/baseline-qemu_arm-virt-gicv3-uefi.txt
>>> It looks like the machine powered up, then powered off. Is the test
>>> actually failing?
>> I recommend checking the html logs from the kernelci dashboard.
>> Also, FYI baseline.login test failure means that the device failed to
>> boot which I think is causing by the issues that you pointed out.
>>
>> <3>[    0.417001][    T1] UBSAN: array-index-out-of-bounds in
>> ../arch/arm/mach-sunxi/mc_smp.c:811:29
>>
>> And potentially another issue with ftrace
>>
>> <4>[    0.000000][    T0] WARNING: CPU: 0 PID: 0 at
>> kernel/trace/ftrace.c:2176 ftrace_bug+0x340/0x3b4
>>
>>
>> Let me know if you need more information from my side to reproduce this
>> on your end.
>>
>>
>> Thanks,
>> Shreeya Patel
> Hi Shreeya,
> I may need your help to reproduce the failure.
>
> $ wget https://storage.kernelci.org/mainline/master/v6.3/arm/multi_v7_defconfig+debug/gcc-10/config/kernel.config
> -O .config
> $ ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make -j128 olddefconfig all -s
> <launch qemu>
> / # mount -t proc /proc
> / # cat /proc/version
> Linux version 6.3.0 (root@61385772abae) (arm-linux-gnueabihf-gcc
> (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian)
> 2.35.2) #2 SMP Wed May  3 21:10:27 UTC 2023
>
> I was able to boot the resulting kernel to a command line.  Perhaps
> there's something about the userspace image that tickles this? Can you
> supply the rootfs that's used in testing?


Following is the link to the rootfs for a different kernel build which 
has the same test case failing.
http://storage.kernelci.org/images/rootfs/buildroot/buildroot-baseline/20230414.0/armel/rootfs.cpio.gz 


Lava job :-
https://lava.collabora.dev/scheduler/job/10135631

You can usually get the rootfs link and many more information through 
the "definition" present on Lava job dashboard.

Kernelci test id for the above job :-
https://linux.kernelci.org/test/case/id/64497865a4bab57def2e85e8/


Thanks,
Shreeya Patel

>>> I was able to boot ARCH=arm defconfig with CC=arm-linux-gnueabihf-gcc
>>> (Debian 10.2.1-6) in QEMU just fine.  So I'm going to need some more
>>> information to help reproduce what specifically is failing.
>>>
>>> Linux version 6.3.0 (root@61385772abae) (arm-linux-gnueabihf-gcc
>>> (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian)
>>> 2.35.2) #1 SMP Fri Apr 28 17:19:59 UTC 2023
>>>
>>> ---
>>>
>>> It does look like UBSAN is flagging an array OOB:
>>>
>>> <3>[    0.417001][    T1] UBSAN: array-index-out-of-bounds in
>>> ../arch/arm/mach-sunxi/mc_smp.c:811:29
>>>
>>> And potentially another issue with ftrace
>>>
>>> <4>[    0.000000][    T0] WARNING: CPU: 0 PID: 0 at
>>> kernel/trace/ftrace.c:2176 ftrace_bug+0x340/0x3b4
>>>
>>>
>>>
>>>> [2] https://groups.io/g/kernelci-results/message/40804
>>>>
>>>>
>>>> Thanks,
>>>> Shreeya Patel
>>>>
>>>> #regzbot introduced: 88b61e3bff93
>>>>
>>>>> ---
>>>>> Changes v3 -> v4:
>>>>> * Split into its own patch again from series, as per Masahiro.
>>>>> * Rebase on top of b0839b281c427e844143dba3893e25c83cdd6c17 and update
>>>>>      clang -Wformat logic in scripts/Makefile.extrawarn, as per Masahiro.
>>>>>
>>>>>     Documentation/kbuild/makefiles.rst          | 29 ++++++++++++---------
>>>>>     Makefile                                    |  6 ++---
>>>>>     drivers/gpu/drm/amd/display/dc/dml/Makefile |  2 +-
>>>>>     scripts/Makefile.compiler                   | 10 ++++---
>>>>>     scripts/Makefile.extrawarn                  |  4 +--
>>>>>     5 files changed, 29 insertions(+), 22 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
>>>>> index 11a296e52d68..ee7e3ea1fbe1 100644
>>>>> --- a/Documentation/kbuild/makefiles.rst
>>>>> +++ b/Documentation/kbuild/makefiles.rst
>>>>> @@ -682,22 +682,27 @@ more details, with real examples.
>>>>>         In the above example, -Wno-unused-but-set-variable will be added to
>>>>>         KBUILD_CFLAGS only if gcc really accepts it.
>>>>>
>>>>> -    cc-ifversion
>>>>> -     cc-ifversion tests the version of $(CC) and equals the fourth parameter
>>>>> -     if version expression is true, or the fifth (if given) if the version
>>>>> -     expression is false.
>>>>> +    gcc-min-version
>>>>> +     gcc-min-version tests if the value of $(CONFIG_GCC_VERSION) is greater than
>>>>> +     or equal to the provided value and evaluates to y if so.
>>>>>
>>>>>         Example::
>>>>>
>>>>> -             #fs/reiserfs/Makefile
>>>>> -             ccflags-y := $(call cc-ifversion, -lt, 0402, -O1)
>>>>> +             cflags-$(call gcc-min-version, 70100) := -foo
>>>>>
>>>>> -     In this example, ccflags-y will be assigned the value -O1 if the
>>>>> -     $(CC) version is less than 4.2.
>>>>> -     cc-ifversion takes all the shell operators:
>>>>> -     -eq, -ne, -lt, -le, -gt, and -ge
>>>>> -     The third parameter may be a text as in this example, but it may also
>>>>> -     be an expanded variable or a macro.
>>>>> +     In this example, cflags-y will be assigned the value -foo if $(CC) is gcc and
>>>>> +     $(CONFIG_GCC_VERSION) is >= 7.1.
>>>>> +
>>>>> +    clang-min-version
>>>>> +     clang-min-version tests if the value of $(CONFIG_CLANG_VERSION) is greater
>>>>> +     than or equal to the provided value and evaluates to y if so.
>>>>> +
>>>>> +     Example::
>>>>> +
>>>>> +             cflags-$(call clang-min-version, 110000) := -foo
>>>>> +
>>>>> +     In this example, cflags-y will be assigned the value -foo if $(CC) is clang
>>>>> +     and $(CONFIG_CLANG_VERSION) is >= 11.0.0.
>>>>>
>>>>>         cc-cross-prefix
>>>>>         cc-cross-prefix is used to check if there exists a $(CC) in path with
>>>>> diff --git a/Makefile b/Makefile
>>>>> index 298f69060f10..411c8480b37e 100644
>>>>> --- a/Makefile
>>>>> +++ b/Makefile
>>>>> @@ -790,7 +790,6 @@ KBUILD_CFLAGS += $(stackp-flags-y)
>>>>>
>>>>>     KBUILD_CFLAGS-$(CONFIG_WERROR) += -Werror
>>>>>     KBUILD_CFLAGS-$(CONFIG_CC_NO_ARRAY_BOUNDS) += -Wno-array-bounds
>>>>> -KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
>>>>>
>>>>>     ifdef CONFIG_CC_IS_CLANG
>>>>>     KBUILD_CPPFLAGS += -Qunused-arguments
>>>>> @@ -972,7 +971,6 @@ ifdef CONFIG_CC_IS_GCC
>>>>>     KBUILD_CFLAGS += -Wno-maybe-uninitialized
>>>>>     endif
>>>>>
>>>>> -ifdef CONFIG_CC_IS_GCC
>>>>>     # The allocators already balk at large sizes, so silence the compiler
>>>>>     # warnings for bounds checks involving those possible values. While
>>>>>     # -Wno-alloc-size-larger-than would normally be used here, earlier versions
>>>>> @@ -984,8 +982,8 @@ ifdef CONFIG_CC_IS_GCC
>>>>>     # ignored, continuing to default to PTRDIFF_MAX. So, left with no other
>>>>>     # choice, we must perform a versioned check to disable this warning.
>>>>>     # https://lore.kernel.org/lkml/20210824115859.187f272f@canb.auug.org.au
>>>>> -KBUILD_CFLAGS += $(call cc-ifversion, -ge, 0901, -Wno-alloc-size-larger-than)
>>>>> -endif
>>>>> +KBUILD_CFLAGS-$(call gcc-min-version, 90100) += -Wno-alloc-size-larger-than
>>>>> +KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
>>>>>
>>>>>     # disable invalid "can't wrap" optimizations for signed / pointers
>>>>>     KBUILD_CFLAGS       += -fno-strict-overflow
>>>>> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
>>>>> index cb81ed2fbd53..d70838edba80 100644
>>>>> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
>>>>> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
>>>>> @@ -34,7 +34,7 @@ dml_ccflags := -mhard-float -maltivec
>>>>>     endif
>>>>>
>>>>>     ifdef CONFIG_CC_IS_GCC
>>>>> -ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>>>>> +ifneq ($(call gcc-min-version, 70100),y)
>>>>>     IS_OLD_GCC = 1
>>>>>     endif
>>>>>     endif
>>>>> diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
>>>>> index 94d0d40cddb3..9d18fb91890e 100644
>>>>> --- a/scripts/Makefile.compiler
>>>>> +++ b/scripts/Makefile.compiler
>>>>> @@ -61,9 +61,13 @@ cc-option-yn = $(call try-run,\
>>>>>     cc-disable-warning = $(call try-run,\
>>>>>         $(CC) -Werror $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -W$(strip $(1)) -c -x c /dev/null -o "$$TMP",-Wno-$(strip $(1)))
>>>>>
>>>>> -# cc-ifversion
>>>>> -# Usage:  EXTRA_CFLAGS += $(call cc-ifversion, -lt, 0402, -O1)
>>>>> -cc-ifversion = $(shell [ $(CONFIG_GCC_VERSION)0 $(1) $(2)000 ] && echo $(3) || echo $(4))
>>>>> +# gcc-min-version
>>>>> +# Usage: cflags-$(call gcc-min-version, 70100) += -foo
>>>>> +gcc-min-version = $(shell [ $(CONFIG_GCC_VERSION) -ge $(1) ] && echo y)
>>>>> +
>>>>> +# clang-min-version
>>>>> +# Usage: cflags-$(call clang-min-version, 110000) += -foo
>>>>> +clang-min-version = $(shell [ $(CONFIG_CLANG_VERSION) -ge $(1) ] && echo y)
>>>>>
>>>>>     # ld-option
>>>>>     # Usage: KBUILD_LDFLAGS += $(call ld-option, -X, -Y)
>>>>> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
>>>>> index 6ae482158bc4..5769c1939d40 100644
>>>>> --- a/scripts/Makefile.extrawarn
>>>>> +++ b/scripts/Makefile.extrawarn
>>>>> @@ -48,7 +48,7 @@ else
>>>>>     ifdef CONFIG_CC_IS_CLANG
>>>>>     KBUILD_CFLAGS += -Wno-initializer-overrides
>>>>>     # Clang before clang-16 would warn on default argument promotions.
>>>>> -ifeq ($(shell [ $(CONFIG_CLANG_VERSION) -lt 160000 ] && echo y),y)
>>>>> +ifneq ($(call clang-min-version, 160000),y)
>>>>>     # Disable -Wformat
>>>>>     KBUILD_CFLAGS += -Wno-format
>>>>>     # Then re-enable flags that were part of the -Wformat group that aren't
>>>>> @@ -56,7 +56,7 @@ KBUILD_CFLAGS += -Wno-format
>>>>>     KBUILD_CFLAGS += -Wformat-extra-args -Wformat-invalid-specifier
>>>>>     KBUILD_CFLAGS += -Wformat-zero-length -Wnonnull
>>>>>     # Requires clang-12+.
>>>>> -ifeq ($(shell [ $(CONFIG_CLANG_VERSION) -ge 120000 ] && echo y),y)
>>>>> +ifeq ($(call clang-min-version, 120000),y)
>>>>>     KBUILD_CFLAGS += -Wformat-insufficient-args
>>>>>     endif
>>>>>     endif
>>>
>
>
