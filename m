Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5067228C8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbjFEO2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbjFEO2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:28:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBF9E6;
        Mon,  5 Jun 2023 07:28:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5464612FF;
        Mon,  5 Jun 2023 14:28:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260EBC433EF;
        Mon,  5 Jun 2023 14:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685975280;
        bh=sAHQ5mF26HJdsfS/vx6CqVHxcZ7iU5btoMnHgF4+vMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RrGK/P10Rp6wTL0cQRYFCqMiylE0bizhJ5uU9xRcPVzXWbM7aOBL/shjMpyFVTfhQ
         vDfrch+9U+i6xjviKtQ57OR9g0Z7JCHspEuSUKpHNm8eENcxIvJEIpA5VKtomF04P6
         dJe+XBc2HA21rqfWIeIRGqPT+5lOcpjFJ0dObYpUKDAyQP40cQgJx4chFWnP70ticj
         Ouql7b7fju6VGGmuwU1hFsmOLbd0KdXkyI+IAiEaHAJ4086NWrgaFP/JBQQQBGVjln
         67ugTTotJTSxIjSBiTxoBhPDALAYmPVbzMw/IA+vbj+xtn7R70CinoDjeVgtmxOjl+
         Fmj+8mqa0UDqw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4503640692; Mon,  5 Jun 2023 11:27:57 -0300 (-03)
Date:   Mon, 5 Jun 2023 11:27:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     irogers@google.com, suzuki.poulose@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, john.g.garry@oracle.com, will@kernel.org,
        james.clark@arm.com, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, adrian.hunter@intel.com, kjain@linux.ibm.com,
        renyu.zj@linux.alibaba.com, kan.liang@linux.intel.com,
        zhengjun.xing@linux.intel.com, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, wangming01@loongson.cn,
        chenhuacai@kernel.org, sandipan.das@amd.com, 9erthalion6@gmail.com,
        seanjc@google.com, robh@kernel.org, tmricht@linux.ibm.com,
        tegongkang@gmail.com, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] perf test amd: Fix build failure with
 amd-ibs-via-core-pmu.c
Message-ID: <ZH3w7TWRQZsPqhB2@kernel.org>
References: <CAP-5=fUPZ7+nAcxBp5sFBfxzkOH8kzWkLV0uziHqxYC0cDbbDw@mail.gmail.com>
 <20230603044650.286-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230603044650.286-1-ravi.bangoria@amd.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Jun 03, 2023 at 10:16:50AM +0530, Ravi Bangoria escreveu:
> Since amd-ibs-via-core-pmu.c was applied via Peter's tree, some of
> the changes came via Arnaldo's tree did not reflect in this file,
> which is causing build failures.
> 
>   arch/x86/tests/amd-ibs-via-core-pmu.c:47:25: error: ‘pmus’ undeclared
>   (first use in this function)
>      47 |         if (list_empty(&pmus))
>         |                         ^~~~
>   arch/x86/tests/amd-ibs-via-core-pmu.c:48:17: error: implicit declaration
>   of function ‘perf_pmu__scan’; did you mean
>   perf_pmus__scan’? [-Werror=implicit-function-declaration]
>      48 |                 perf_pmu__scan(NULL);
>         |                 ^~~~~~~~~~~~~~
>         |                 perf_pmus__scan
>   arch/x86/tests/amd-ibs-via-core-pmu.c:50:19: error: implicit declaration
>   of function ‘perf_pmu__find’; did you mean
>   perf_pmus__find’? [-Werror=implicit-function-declaration]
>      50 |         ibs_pmu = perf_pmu__find("ibs_op");
>         |                   ^~~~~~~~~~~~~~
>         |                   perf_pmus__find
> 
> Fix those.
> 
> Fixes: 1eaf496ed386 ("perf pmu: Separate pmu and pmus")
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>

I wonder how to solve the various merge issues here:

1. this clashes with:

commit ae4aa00a1a9358e0007f6edc71b018a0b0d21190
Author: Ian Rogers <irogers@google.com>
Date:   Tue May 2 15:38:27 2023 -0700

    perf test: Move x86 hybrid tests to arch/x86

--------------

I tried cherry-picking the cset that introduces amd-ibs-via-core-pmu.c,
moved the test__hybrid lines a bit and then tried test merging the
result with tip/master, it works.

But then I tried applying this fix as a follow up cset, perf-tools-next
would have bisection history broken, but nah, but then I hit:

⬢[acme@toolbox perf-tools-next]$ git merge tip/master
Auto-merging tools/perf/arch/x86/include/arch-tests.h
Auto-merging tools/perf/arch/x86/tests/Build
Auto-merging tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c
CONFLICT (add/add): Merge conflict in tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c
Auto-merging tools/perf/arch/x86/tests/arch-tests.c
Automatic merge failed; fix conflicts and then commit the result.
⬢[acme@toolbox perf-tools-next]$ git diff
diff --cc tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c
index 78b1902f6f59d8ce,2902798ca5c1ed1c..0000000000000000
--- a/tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c
+++ b/tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c
@@@ -44,7 -44,10 +44,14 @@@ int test__amd_ibs_via_core_pmu(struct t
        int ret = TEST_OK;
        int fd, i;
  
++<<<<<<< HEAD
 +      ibs_pmu = perf_pmus__find("ibs_op");
++=======
+       if (list_empty(&pmus))
+               perf_pmu__scan(NULL);
+ 
+       ibs_pmu = perf_pmu__find("ibs_op");
++>>>>>>> tip/master
        if (!ibs_pmu)
                return TEST_SKIP;
  

How are things like this resolved in linux-next?

Removing this test from tip/master and I carry a fixed up
tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c introduction patch?

Cheers,

- Arnaldo

> ---
> v1->v2:
>   - Remove unnecessary perf_pmus__scan(NULL) as suggested by Ian.
> 
>  tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c b/tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c
> index 2902798ca5c1..78b1902f6f59 100644
> --- a/tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c
> +++ b/tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c
> @@ -44,10 +44,7 @@ int test__amd_ibs_via_core_pmu(struct test_suite *test __maybe_unused,
>  	int ret = TEST_OK;
>  	int fd, i;
>  
> -	if (list_empty(&pmus))
> -		perf_pmu__scan(NULL);
> -
> -	ibs_pmu = perf_pmu__find("ibs_op");
> +	ibs_pmu = perf_pmus__find("ibs_op");
>  	if (!ibs_pmu)
>  		return TEST_SKIP;
>  
> -- 
> 2.40.1
> 

-- 

- Arnaldo
