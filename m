Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42185F679E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 15:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJFNRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 09:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJFNRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 09:17:15 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545BBA8CFF
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 06:17:14 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id g1-20020a17090a708100b00203c1c66ae3so1719605pjk.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 06:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=02+l5Dup8iobjnpzNvILInltP6SSg7vn8eRfMH1tN68=;
        b=PlPVDGcgoKADttm3GBAKtN6r3dpMaHZPrp4uNihBXrRA0gX7+ZEGw2m30nEhgc4zen
         if27Aj8YByw5pmYjuAx94Fg5iwlYpb4ePY64yrl4l0HMOlc4IgLI/O18ZSATsalraXWG
         N3+zGQaQRlAFctoD02AGFDi+WYwm3RMSLzxRnpqkBoru5yOy8t5TTV55e/gQkeZ+2kIO
         UaHGpRtwu0+rKZ/rPvVQVftkRIy94OUP1HRgujdOWVvBOa8kCoJDMaaqSNgD9onZAsvU
         1pS64n9i93ikIpW6tE/1kchE1MGeD6tuOzPabnGj5mI9wHwQFIASc2a0z1MUwxLLiX8P
         iA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=02+l5Dup8iobjnpzNvILInltP6SSg7vn8eRfMH1tN68=;
        b=F6IPnq8QyHNPy3YAv7MbajhNvNNEpis80H2gA023nK3Fz1wpsGLDbQS5hKZ4EGbRmB
         jAlioM8DmdohI3ZuHZR78r03YBbAzUiKdRN1qXWvR5dbtlyt9B0yXx0mDouBU3z18mBq
         T9hkWWe7hU2eDYT36E1m6xqhAczbPAGhrXtOE4JHwoKprofGhKHRWNh3GpknBfHZiIpu
         jYt0eKPDAVwA4+NpEdI4NERXMj/6eZm8iofU5jOPm2oOZ9+MLZUXtGpWUrKTv0mzdeyo
         uX8ot8XoUE4d2SUoBom1yJfG2QO7DbE/dOCuD6JF6e30XAfqfX2wjNyYmBv1m/C3NKGP
         xiMQ==
X-Gm-Message-State: ACrzQf2ClQWRfNV8KSBVH3xpbpCHg1FkoxO3JVChnq8xs6pj2GB/c+MX
        0jo/+sF3hLXjUYlsLnPb9HjavA==
X-Google-Smtp-Source: AMsMyM7E2jdAua9PflCTdfw9BxHq/H4xgwm6PVffFkhcNWwdGQyWaKpIZMKrkYdrJttA4awLNL+C8w==
X-Received: by 2002:a17:902:ced2:b0:17f:5eb2:cd72 with SMTP id d18-20020a170902ced200b0017f5eb2cd72mr4865973plg.162.1665062233764;
        Thu, 06 Oct 2022 06:17:13 -0700 (PDT)
Received: from leoy-yangtze.lan (211-75-219-202.hinet-ip.hinet.net. [211.75.219.202])
        by smtp.gmail.com with ESMTPSA id c92-20020a17090a496500b0020a11217682sm2840215pjh.27.2022.10.06.06.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 06:17:11 -0700 (PDT)
Date:   Thu, 6 Oct 2022 21:17:05 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5] perf test: Introduce script for data symbol testing
Message-ID: <Yz7VUaXs0bhimqsP@leoy-yangtze.lan>
References: <20221006101039.47870-1-leo.yan@linaro.org>
 <Yz65kF01XYLayp9E@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz65kF01XYLayp9E@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 08:18:40AM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> Replaced the one I had merged with v5 and added this:
> 
> Committer testing:
> 
>   [root@quaco ~]# grep -m1 "model name" /proc/cpuinfo
>   model name    : Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz
>   [root@quaco ~]#
>   [root@quaco ~]# perf test -v "data symbol"
>   104: Test data symbol                                                :
>   --- start ---
>   test child forked, pid 192318
>   Compiling test program...
>   Recording workload...
>   [ perf record: Woken up 2 times to write data ]
>   [ perf record: Captured and wrote 0.389 MB /tmp/__perf_test.perf.data.LIuQl (5570 samples) ]
>   Cleaning up files...
>   test child finished with 0
>   ---- end ----
>   Test data symbol: Ok
>   [root@quaco ~]#
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> -------------
> 
> The verbose mode could show the 'perf report' output, I think, but this
> can be done later, if agreed.

Yeah, will add output logs for the test.

Thanks for picking up patch.  And thanks for Ravi's testing.

Thanks,
Leo
