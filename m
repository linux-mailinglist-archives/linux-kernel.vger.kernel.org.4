Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE37682A25
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 11:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjAaKOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 05:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjAaKOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:14:41 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4AD2386D;
        Tue, 31 Jan 2023 02:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675160080; x=1706696080;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nuYafO8zujKiFRDpdMj6I0Lu2+ld0/WjvR6y0Q7UeUY=;
  b=hFZKU0E+EQt/YGfmBhsybo2XLrCKPC9lUp/1Kx99TSSYvYMwdKx74chK
   G1WQzVBIfWkutHo8vYQ3+l0Im292C+FGPjZklAbBpbhk6FskGHaIgmqzV
   65EhVhTkYBjtkBxjwcHRxVL9xPoEdTx1LNF9eSHi0xzjVInehvhjkABUC
   qGjQ+W1HB6HgINtNgz5pUlwZACMW/a7dQ1hS5NZ0c4n/haWl47AE6cgdF
   AlvxSXrHcwFJjIqFuwmYNxjbEbTfhXFqsBmkzO0x6Apj9kzOiClJ9rGH6
   4cO/fRcmBHuLeBxCEtHh9Zwxrnv0RG6sTz+FqpHV66ydp0lUvjIWbwGYK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="327818491"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="327818491"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 02:14:39 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="641922201"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="641922201"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.47.218])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 02:14:33 -0800
Message-ID: <aaeb7dc0-59e9-cd42-cf5b-e6a08b38670a@intel.com>
Date:   Tue, 31 Jan 2023 12:14:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH 2/9] perf symbols: Add support for x86 .plt.sec
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20230127170222.9895-1-adrian.hunter@intel.com>
 <20230127170222.9895-3-adrian.hunter@intel.com>
 <CAM9d7chny89+rtP6orSJOKrAqb4GbzCG53KV4O1J9mhKvCcWnQ@mail.gmail.com>
 <5aeab2b5-7349-d220-652b-75360ef6d723@intel.com>
 <CAM9d7ch2T1B_A_meyZi5A+kpwmzCY-eAKuZv5OVYGonBrhXqgQ@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAM9d7ch2T1B_A_meyZi5A+kpwmzCY-eAKuZv5OVYGonBrhXqgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URI_NOVOWEL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/23 00:22, Namhyung Kim wrote:
> On Mon, Jan 30, 2023 at 10:35 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 30/01/23 19:34, Namhyung Kim wrote:
>>> Hi Adrian,
>>>
>>> On Fri, Jan 27, 2023 at 9:02 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>
>>>> The section .plt.sec was originally added for MPX and was first called
>>>> .plt.bnd. While MPX has been deprecated, .plt.sec is now also used for IBT.
>>>> On x86_64, IBT seems to be enabled by default, but can be switched off
>>>> using gcc option -fcf-protection=none. On 32-bit, option -z ibt will
>>>> enable IBT.
>>>>
>>>> With .plt.sec, calls are made into .plt.sec instead of .plt, so it
>>>> makes more sense to put the symbols there instead of .plt. A notable
>>>> difference is that .plt.sec does not have a header entry.
>>>>
>>>> For x86, when synthesizing symbols for plt, use offset and entry size of
>>>> .plt.sec instead of .plt when there is a .plt.sec section.
>>>>
>>>> Example on Ubuntu 22.04 gcc 11.3:
>>>>
>>>>   Before:
>>>>
>>>>     $ cat tstpltlib.c
>>>>     void fn1(void) {}
>>>>     void fn2(void) {}
>>>>     void fn3(void) {}
>>>>     void fn4(void) {}
>>>>     $ cat tstplt.c
>>>>     void fn1(void);
>>>>     void fn2(void);
>>>>     void fn3(void);
>>>>     void fn4(void);
>>>>
>>>>     int main()
>>>>     {
>>>>             fn4();
>>>>             fn1();
>>>>             fn2();
>>>>             fn3();
>>>>             return 0;
>>>>     }
>>>>     $ gcc --version
>>>>     gcc (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0
>>>>     Copyright (C) 2021 Free Software Foundation, Inc.
>>>>     This is free software; see the source for copying conditions.  There is NO
>>>>     warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>>>>     $ gcc -Wall -Wextra -shared -o libtstpltlib.so tstpltlib.c
>>>>     $ gcc -Wall -Wextra -o tstplt tstplt.c -L . -ltstpltlib -Wl,-rpath=$(pwd)
>>>>     $ readelf -SW tstplt | grep 'plt\|Name'
>>>>       [Nr] Name              Type            Address          Off    Size   ES Flg Lk Inf Al
>>>>       [11] .rela.plt         RELA            0000000000000698 000698 000060 18  AI  6  24  8
>>>>       [13] .plt              PROGBITS        0000000000001020 001020 000050 10  AX  0   0 16
>>>>       [14] .plt.got          PROGBITS        0000000000001070 001070 000010 10  AX  0   0 16
>>>>       [15] .plt.sec          PROGBITS        0000000000001080 001080 000040 10  AX  0   0 16
>>>
>>> On my machine, it's not enabled by default.  And it doesn't create .plt.sec
>>> even if I pass -fcf-protection=full option.
>>>
>>> $ gcc --version
>>> gcc (Debian 12.2.0-10) 12.2.0
>>> Copyright (C) 2022 Free Software Foundation, Inc.
>>> This is free software; see the source for copying conditions.  There is NO
>>> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>>>
>>> $ gcc -Wall -Wextra -shared -fcf-protection=full -o libtstplt.so tstpltlib.c
>>> $ gcc -Wall -Wextra -fcf-protection=full -o tstplt tstplt.c -L.
>>> -ltstpltlib -Wl,-rpath,$(pwd)
>>> $ readelf -SW tstplt | grep 'plt\|Name'
>>>    [Nr] Name              Type            Address          Off    Size
>>>   ES Flg Lk Inf Al
>>>    [11] .rela.plt         RELA            0000000000000688 000688
>>> 000060 18  AI  6  24  8
>>>    [13] .plt              PROGBITS        0000000000001020 001020
>>> 000050 10  AX  0   0 16
>>>    [14] .plt.got          PROGBITS        0000000000001070 001070
>>> 000008 08  AX  0   0  8
>>>    [24] .got.plt          PROGBITS        0000000000003fe8 002fe8
>>> 000038 08  WA  0   0  8
>>
>> That is interesting.  What does it say with -v i.e.
>>
>>         gcc -v -Wall -Wextra -o tstplt tstplt.c -L . -ltstpltlib -Wl,-rpath=$(pwd)
> 
> Using built-in specs.
> COLLECT_GCC=gcc
> COLLECT_LTO_WRAPPER=/usr/lib/gcc/x86_64-linux-gnu/12/lto-wrapper
> OFFLOAD_TARGET_NAMES=nvptx-none:amdgcn-amdhsa
> OFFLOAD_TARGET_DEFAULT=1
> Target: x86_64-linux-gnu
> Configured with: ../src/configure -v --with-pkgversion='Debian
> 12.2.0-10' --with-bugurl=file:///usr/share/doc/gcc-12/README.Bugs
> --enable-languages=c,ada,c++,go,d,fortran,objc,obj-c++,m2
> --prefix=/usr --with-gcc-major-version-only --program-suffix=-12
> --program-prefix=x86_64-linux-gnu- --enable-shared
> --enable-linker-build-id --libexecdir=/usr/lib
> --without-included-gettext --enable-threads=posix --libdir=/usr/lib
> --enable-nls --enable-clocale=gnu --enable-libstdcxx-debug
> --enable-libstdcxx-time=yes --with-default-libstdcxx-abi=new
> --enable-gnu-unique-object --disable-vtable-verify --enable-plugin
> --enable-default-pie --with-system-zlib
> --enable-libphobos-checking=release --with-target-system-zlib=auto
> --enable-objc-gc=auto --enable-multiarch --disable-werror --enable-cet
> --with-arch-32=i686 --with-abi=m64 --with-multilib-list=m32,m64,mx32
> --enable-multilib --with-tune=generic
> --enable-offload-targets=nvptx-none=/build/gcc-12-hWCYKv/gcc-12-12.2.0/debian/tmp-nvptx/usr,amdgcn-amdhsa=/build/gcc-12-hWCYKv/gcc-12-12.2.0/debian/tmp-gcn/usr
> --enable-offload-defaulted --without-cuda-driver
> --enable-checking=release --build=x86_64-linux-gnu
> --host=x86_64-linux-gnu --target=x86_64-linux-gnu
> Thread model: posix
> Supported LTO compression algorithms: zlib zstd
> gcc version 12.2.0 (Debian 12.2.0-10)
> COLLECT_GCC_OPTIONS='-Wall' '-Wextra' '-fcf-protection=full' '-v' '-o'
> 'tstplt' '-L.' '-mtune=generic' '-march=x86-64' '-dumpdir' 'tstplt-'
>  /usr/lib/gcc/x86_64-linux-gnu/12/cc1 -quiet -v -imultiarch
> x86_64-linux-gnu tstplt.c -quiet -dumpdir tstplt- -dumpbase tstplt.c
> -dumpbase-ext .c -mtune=generic -march=x86-64 -Wall -Wextra -version
> -fcf-protection=full -fasynchronous-unwind-tables -o /tmp/ccKPWeTD.s
> GNU C17 (Debian 12.2.0-10) version 12.2.0 (x86_64-linux-gnu)
>     compiled by GNU C version 12.2.0, GMP version 6.2.1, MPFR version
> 4.1.0, MPC version 1.2.1, isl version isl-0.25-GMP
> 
> GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
> ignoring nonexistent directory "/usr/local/include/x86_64-linux-gnu"
> ignoring nonexistent directory "/usr/lib/gcc/x86_64-linux-gnu/12/include-fixed"
> ignoring nonexistent directory
> "/usr/lib/gcc/x86_64-linux-gnu/12/../../../../x86_64-linux-gnu/include"
> #include "..." search starts here:
> #include <...> search starts here:
>  /usr/lib/gcc/x86_64-linux-gnu/12/include
>  /usr/local/include
>  /usr/include/x86_64-linux-gnu
>  /usr/include
> End of search list.
> GNU C17 (Debian 12.2.0-10) version 12.2.0 (x86_64-linux-gnu)
>     compiled by GNU C version 12.2.0, GMP version 6.2.1, MPFR version
> 4.1.0, MPC version 1.2.1, isl version isl-0.25-GMP
> 
> GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
> Compiler executable checksum: 0bf64a455b69fb48d1b44a013a099136
> COLLECT_GCC_OPTIONS='-Wall' '-Wextra' '-fcf-protection=full' '-v' '-o'
> 'tstplt' '-L.' '-mtune=generic' '-march=x86-64' '-dumpdir' 'tstplt-'
>  as -v --64 -o /tmp/cc0IMyNr.o /tmp/ccKPWeTD.s
> GNU assembler version 2.39.50 (x86_64-linux-gnu) using BFD version
> (GNU Binutils for Debian) 2.39.50.20221208
> COMPILER_PATH=/usr/lib/gcc/x86_64-linux-gnu/12/:/usr/lib/gcc/x86_64-linux-gnu/12/:/usr/lib/gcc/x86_64-linux-gnu/:/usr/lib/gcc/x86_64-linux-gnu/12/:/usr/lib/gcc/x86_64-linux-gnu/
> LIBRARY_PATH=/usr/lib/gcc/x86_64-linux-gnu/12/:/usr/lib/gcc/x86_64-linux-gnu/12/../../../x86_64-linux-gnu/:/usr/lib/gcc/x86_64-linux-gnu/12/../../../../lib/:/lib/x86_64-linux-gnu/:/lib/../lib/:/usr/lib/x86_64-linux-gnu/:/usr/lib/../lib/:/usr/lib/gcc/x86_64-linux-gnu/12/../../../:/lib/:/usr/lib/
> COLLECT_GCC_OPTIONS='-Wall' '-Wextra' '-fcf-protection=full' '-v' '-o'
> 'tstplt' '-L.' '-mtune=generic' '-march=x86-64' '-dumpdir' 'tstplt.'
>  /usr/lib/gcc/x86_64-linux-gnu/12/collect2 -plugin
> /usr/lib/gcc/x86_64-linux-gnu/12/liblto_plugin.so
> -plugin-opt=/usr/lib/gcc/x86_64-linux-gnu/12/lto-wrapper
> -plugin-opt=-fresolution=/tmp/ccU2c2jz.res
> -plugin-opt=-pass-through=-lgcc -plugin-opt=-pass-through=-lgcc_s
> -plugin-opt=-pass-through=-lc -plugin-opt=-pass-through=-lgcc
> -plugin-opt=-pass-through=-lgcc_s --build-id --eh-frame-hdr -m
> elf_x86_64 --hash-style=gnu --as-needed -dynamic-linker
> /lib64/ld-linux-x86-64.so.2 -pie -o tstplt
> /usr/lib/gcc/x86_64-linux-gnu/12/../../../x86_64-linux-gnu/Scrt1.o
> /usr/lib/gcc/x86_64-linux-gnu/12/../../../x86_64-linux-gnu/crti.o
> /usr/lib/gcc/x86_64-linux-gnu/12/crtbeginS.o -L.
> -L/usr/lib/gcc/x86_64-linux-gnu/12
> -L/usr/lib/gcc/x86_64-linux-gnu/12/../../../x86_64-linux-gnu
> -L/usr/lib/gcc/x86_64-linux-gnu/12/../../../../lib
> -L/lib/x86_64-linux-gnu -L/lib/../lib -L/usr/lib/x86_64-linux-gnu
> -L/usr/lib/../lib -L/usr/lib/gcc/x86_64-linux-gnu/12/../../..
> /tmp/cc0IMyNr.o -ltstpltlib -rpath=/home/namhyung/tmp/plt-test -lgcc
> --push-state --as-needed -lgcc_s --pop-state -lc -lgcc --push-state
> --as-needed -lgcc_s --pop-state
> /usr/lib/gcc/x86_64-linux-gnu/12/crtendS.o
> /usr/lib/gcc/x86_64-linux-gnu/12/../../../x86_64-linux-gnu/crtn.o
> COLLECT_GCC_OPTIONS='-Wall' '-Wextra' '-fcf-protection=full' '-v' '-o'
> 'tstplt' '-L.' '-mtune=generic' '-march=x86-64' '-dumpdir' 'tstplt.'
> 
> 
>>
>> And what is the distribution?
> 
> It's a Debian (Testing) with some customization.

Seems to need also options -z ibt and/or -z ibtplt

I will send a V2 with updated examples.

