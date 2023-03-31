Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585AD6D1C50
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbjCaJ3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjCaJ2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:28:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5E7D1FD2C;
        Fri, 31 Mar 2023 02:28:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FE8E2F4;
        Fri, 31 Mar 2023 02:28:08 -0700 (PDT)
Received: from [192.168.1.158] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EC813F6C4;
        Fri, 31 Mar 2023 02:27:21 -0700 (PDT)
Message-ID: <8daa6988-a0ec-bd92-5a7b-0dca39fbc3b0@arm.com>
Date:   Fri, 31 Mar 2023 10:27:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 09/13] perf symbol: Add abi::__cxa_demangle C++
 demangling support
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Andres Freund <andres@anarazel.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
References: <20230311065753.3012826-1-irogers@google.com>
 <20230311065753.3012826-10-irogers@google.com>
 <f8298af8-4d29-5cbd-cb5f-d33b3fdd641c@arm.com>
 <CAP-5=fV3HPjXqHm1m-HB3rJU=emV16bUby1Xt-5x4+zjdPRnsg@mail.gmail.com>
 <CAP-5=fWYHyJbZicrsj6UnOBVTFX8NheL+GPGQbC8NMQv2G1WcA@mail.gmail.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <CAP-5=fWYHyJbZicrsj6UnOBVTFX8NheL+GPGQbC8NMQv2G1WcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/03/2023 20:03, Ian Rogers wrote:
> On Thu, Mar 30, 2023 at 9:50 AM Ian Rogers <irogers@google.com> wrote:
>>
>> On Thu, Mar 30, 2023 at 7:08 AM James Clark <james.clark@arm.com> wrote:
>>>
>>>
>>>
>>> On 11/03/2023 06:57, Ian Rogers wrote:
>>>> Refactor C++ demangling out of symbol-elf into its own files similar
>>>> to other languages. Add abi::__cxa_demangle support. As the other
>>>> demanglers are not shippable with distributions, this brings back C++
>>>> demangling in a common case. It isn't perfect as the support for
>>>> optionally demangling arguments and modifiers isn't present.
>>>>
>>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>>> ---
>>>>  tools/perf/Makefile.config       | 29 +++++++++---------
>>>>  tools/perf/util/Build            |  1 +
>>>>  tools/perf/util/demangle-cxx.cpp | 50 ++++++++++++++++++++++++++++++++
>>>>  tools/perf/util/demangle-cxx.h   | 16 ++++++++++
>>>>  tools/perf/util/symbol-elf.c     | 37 +++++------------------
>>>>  5 files changed, 88 insertions(+), 45 deletions(-)
>>>>  create mode 100644 tools/perf/util/demangle-cxx.cpp
>>>>  create mode 100644 tools/perf/util/demangle-cxx.h
>>>>
>>>> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
>>>> index 5756498248e0..fdeca45cf15f 100644
>>>> --- a/tools/perf/Makefile.config
>>>> +++ b/tools/perf/Makefile.config
>>>> @@ -906,6 +906,7 @@ ifdef BUILD_NONDISTRO
>>>>    endif
>>>>
>>>>    CFLAGS += -DHAVE_LIBBFD_SUPPORT
>>>> +  CXXFLAGS += -DHAVE_LIBBFD_SUPPORT
>>>>    ifeq ($(feature-libbfd-buildid), 1)
>>>>      CFLAGS += -DHAVE_LIBBFD_BUILDID_SUPPORT
>>>>    else
>>>> @@ -913,26 +914,24 @@ ifdef BUILD_NONDISTRO
>>>>    endif
>>>>  endif
>>>>
>>>> -ifdef NO_DEMANGLE
>>>> -  CFLAGS += -DNO_DEMANGLE
>>>> -else
>>>> +ifndef NO_DEMANGLE
>>>> +  $(call feature_check,cxa-demangle)
>>>> +  ifeq ($(feature-cxa-demangle), 1)
>>>> +    EXTLIBS += -lstdc++
>>>
>>> Hi Ian,
>>>
>>> I think cross compilation for arm on x86 isn't working after this change
>>> (at least on Ubuntu).
>>>
>>> Even with all of the arm64 libstdc++ stuff installed, you can only link
>>> to it using g++, but the perf build tries to link to it using gcc. Not
>>> sure it's some quirk with the search paths on Ubuntu or something else:
>>>
>>>   $ aarch64-linux-gnu-gcc -lstdc++
>>>
>>>    /usr/lib/gcc-cross/aarch64-linux-gnu/12/../../../../aarch64-linux-
>>> gnu/bin/ld: cannot find -lstdc++: No such file or directory
>>>   collect2: error: ld returned 1 exit status
>>>
>>> g++ gets further:
>>>
>>>   $ aarch64-linux-gnu-g++ -lstdc++
>>>
>>>   ...
>>>   (.text+0x20): undefined reference to `main'
>>> collect2: error: ld returned 1 exit status
>>>
>>> At the end of the perf build it looks like something similar is
>>> happening (with all the non interesting bits deleted):
>>>
>>>    $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -C tools/perf
>>> NO_BPF_SKEL=1 V=1
>>>
>>>   aarch64-linux-gnu-gcc ... -o perf
>>>
>>> /usr/lib/gcc-cross/aarch64-linux-gnu/12/../../../../aarch64-linux-gnu/bin/ld:
>>> cannot find -lstdc++: No such file or directory
>>>
>>> If I build with NO_DEMANGLE=1 then the build works, but I think it would
>>> at be best to autodetect rather than have to do this. Or maybe even link
>>> at the end with g++ if we're going to use libstdc++?
>>
>> Hi James,
>>
>> sorry for the problems you are having, I'll see if I can get a repo. I
>> did add a feature test with this change in the same set:
>> https://lore.kernel.org/lkml/20230311065753.3012826-9-irogers@google.com/
>> So it should be feature testing and only enabling when
>> HAVE_CXA_DEMANGLE_SUPPORT is present. Obviously something is up, so
>> I'll have a think about it.
>>
>> Thanks,
>> Ian
> 
> Sorry to say I couldn't repro on Debian:
> 
> $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -C tools/perf
> NO_LIBELF=1 NO_LIBTRACEEVENT=1

If you have NO_LIBELF=1 it sets NO_DEMANGLE=1 automatically so it skips
the c++ linking step. If you run with V=1 you can see that it doesn't
have -lstdc++ on the last link line.

But, having said that, I went to make a full reproducer in docker but it
actually worked. Turns out that the issue was on my end. I'd used
update-alternatives for a different compiler version and looks like I
had half of one gcc and half of another g++. Completely my fault, sorry
for the noise!

James
