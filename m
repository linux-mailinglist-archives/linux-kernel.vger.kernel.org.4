Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BDF5BE78A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiITNuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiITNuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:50:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0CB10DF95
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:50:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E95713D5;
        Tue, 20 Sep 2022 06:50:19 -0700 (PDT)
Received: from [10.1.38.12] (e121896.cambridge.arm.com [10.1.38.12])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98EFC3F73D;
        Tue, 20 Sep 2022 06:50:10 -0700 (PDT)
Message-ID: <7dbf6fc6-5cd5-4493-af55-6ebf6b97a019@arm.com>
Date:   Tue, 20 Sep 2022 14:50:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: coresight-etm4x-core.c:969:26: error:
 'ID_AA64DFR0_TRACEVER_SHIFT' undeclared
Content-Language: en-US
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        coresight@lists.linaro.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
References: <CA+G9fYtpNsjRzQdxFvLjVmG9XX95B6DtaviHq3oG6awGYTqGSw@mail.gmail.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <CA+G9fYtpNsjRzQdxFvLjVmG9XX95B6DtaviHq3oG6awGYTqGSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/09/2022 12:39, Naresh Kamboju wrote:
> Following build warnings / errors noticed while building arm64 coresight
> on linux next-20220919 and next-20220920.

Fix is here:
https://lists.linaro.org/archives/list/coresight@lists.linaro.org/thread/OS4F43WGOYGQUJHISR2PZQPE3FUQ7DXH/

> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> make --silent --keep-going --jobs=8
> O=/home/tuxbuild/.cache/tuxmake/builds/1/build
> CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- ARCH=arm64
> CROSS_COMPILE=aarch64-linux-gnu- 'CC=sccache aarch64-linux-gnu-gcc'
> 'HOSTCC=sccache gcc'
> 
> drivers/hwtracing/coresight/coresight-etm4x-core.c: In function
> 'cpu_supports_sysreg_trace':
> drivers/hwtracing/coresight/coresight-etm4x-core.c:969:26: error:
> 'ID_AA64DFR0_TRACEVER_SHIFT' undeclared (first use in this function);
> did you mean 'ID_AA64DFR0_EL1_TraceVer_SHIFT'?
>   969 |         return ((dfr0 >> ID_AA64DFR0_TRACEVER_SHIFT) & 0xfUL) > 0;
>       |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                          ID_AA64DFR0_EL1_TraceVer_SHIFT
> drivers/hwtracing/coresight/coresight-etm4x-core.c:969:26: note: each
> undeclared identifier is reported only once for each function it
> appears in
> drivers/hwtracing/coresight/coresight-etm4x-core.c: In function
> 'cpu_detect_trace_filtering':
> drivers/hwtracing/coresight/coresight-etm4x-core.c:1057:57: error:
> 'ID_AA64DFR0_TRACE_FILT_SHIFT' undeclared (first use in this
> function); did you mean 'ID_AA64PFR0_EL1_DIT_SHIFT'?
>  1057 |         if (!cpuid_feature_extract_unsigned_field(dfr0,
> ID_AA64DFR0_TRACE_FILT_SHIFT))
>       |
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |
> ID_AA64PFR0_EL1_DIT_SHIFT
> drivers/hwtracing/coresight/coresight-etm4x-core.c: In function
> 'cpu_supports_sysreg_trace':
> drivers/hwtracing/coresight/coresight-etm4x-core.c:970:1: error:
> control reaches end of non-void function [-Werror=return-type]
>   970 | }
>       | ^
> cc1: some warnings being treated as errors
> 
> Regressions found on arm64:
>    - build-clang-13-lkftconfig
>    - build-gcc-11-lkftconfig-devicetree
>    - build-gcc-11-lkftconfig-kunit
>    - build-gcc-11-lkftconfig-perf
>    - build-gcc-11-lkftconfig-64k_page_size
>    - build-gcc-11-lkftconfig-debug
>    - build-gcc-11-lkftconfig-libgpiod
>    - build-gcc-11-lkftconfig-debug-kmemleak
>    - build-clang-14-lkftconfig
>    - build-clang-nightly-lkftconfig
>    - build-gcc-11-lkftconfig
>    - build-gcc-11-lkftconfig-kasan
>    - build-clang-12-lkftconfig
>    - build-gcc-11-lkftconfig-kselftest-kernel
>    - build-gcc-11-lkftconfig-rcutorture
>    - build-gcc-11-lkftconfig-armv8_features
>    - build-gcc-11-lkftconfig-kselftest
> 
> Build: https://builds.tuxbuild.com/2F1cW8NpQ0Z6l9h9rfkZT5AXzqg/
> config: https://builds.tuxbuild.com/2F1cW8NpQ0Z6l9h9rfkZT5AXzqg/config
> 
> 
> --
> Linaro LKFT
> https://lkft.linaro.org
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
