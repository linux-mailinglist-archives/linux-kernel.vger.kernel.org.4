Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F266B7FD5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 18:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjCMR6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 13:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCMR63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 13:58:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D1F1CF45;
        Mon, 13 Mar 2023 10:58:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0752611DA;
        Mon, 13 Mar 2023 17:58:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF52C433D2;
        Mon, 13 Mar 2023 17:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678730305;
        bh=R/CebLcuOYIfi6x1vLEG3j/yHBC7GgWxI/SYarquQus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LH3JvtinkJ1j4GUObgdL7Upg9la09ptXBp3ufoB6TvF4MtA8uc8T/r/9d8kyc1mFL
         1z1Vm8lD0lh+jIajBWC0NYvJj97QqHTagnC5X3QGVALu5n9TqBQbjZGmuM7g+KBVhf
         8E9iqFGrfN+FTvqzIAz9GoWTn4KWVdpv9K6jY0FzXVMj0bvlN25rDGlMftEBqny3ar
         0OpyZfn19uogCz0ijMZBAVkJCKKDf2bss8h7IAdE6+RyzyYCX/nr8e1GWyezBchUDO
         VnyxX8MwWtKizX4/GKOYdOU6QUc3v8MJAh7QztxOeY2GhJ90xeZVR9e5iF11FOINIO
         p4P52qnPDCpFw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2C6974049F; Mon, 13 Mar 2023 14:58:22 -0300 (-03)
Date:   Mon, 13 Mar 2023 14:58:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.g.garry@oracle.com>,
        James Clark <james.clark@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 04/16] perf kvm: Use subtraction for comparison metrics
Message-ID: <ZA9kPg7JDzkxAStz@kernel.org>
References: <20230313114018.543254-1-leo.yan@linaro.org>
 <20230313114018.543254-5-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230313114018.543254-5-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 13, 2023 at 07:40:06PM +0800, Leo Yan escreveu:
> Currently the metrics comparison uses greater operator (>), it returns
> the boolean value (0 or 1).
> 
> This patch changes to use subtraction as comparison result, which can
> be used by histograms sorting.  Since the subtraction result is u64
> type, we change the function return type from int to int64_t to avoid
> overflow.

Not building at his point in the series:

  LD      /tmp/build/perf-tools-next/util/perf-in.o
builtin-kvm.c:80:18: error: initialization of ‘int (*)(struct kvm_event *, struct kvm_event *, int)’ from incompatible pointer type ‘int64_t (*)(struct kvm_event *, struct kvm_event *, int)’ {aka ‘long int (*)(struct kvm_event *, struct kvm_event *, int)’} [-Werror=incompatible-pointer-types]
   80 |         { #name, cmp_event_ ## compare_key }
      |                  ^~~~~~~~~~
builtin-kvm.c:83:9: note: in expansion of macro ‘DEF_SORT_NAME_KEY’
   83 |         DEF_SORT_NAME_KEY(sample, count),
      |         ^~~~~~~~~~~~~~~~~
builtin-kvm.c:80:18: note: (near initialization for ‘keys[0].key’)
   80 |         { #name, cmp_event_ ## compare_key }
      |                  ^~~~~~~~~~
builtin-kvm.c:83:9: note: in expansion of macro ‘DEF_SORT_NAME_KEY’
   83 |         DEF_SORT_NAME_KEY(sample, count),
      |         ^~~~~~~~~~~~~~~~~
builtin-kvm.c:80:18: error: initialization of ‘int (*)(struct kvm_event *, struct kvm_event *, int)’ from incompatible pointer type ‘int64_t (*)(struct kvm_event *, struct kvm_event *, int)’ {aka ‘long int (*)(struct kvm_event *, struct kvm_event *, int)’} [-Werror=incompatible-pointer-types]
   80 |         { #name, cmp_event_ ## compare_key }
      |                  ^~~~~~~~~~
builtin-kvm.c:84:9: note: in expansion of macro ‘DEF_SORT_NAME_KEY’
   84 |         DEF_SORT_NAME_KEY(time, mean),
      |         ^~~~~~~~~~~~~~~~~
builtin-kvm.c:80:18: note: (near initialization for ‘keys[1].key’)
   80 |         { #name, cmp_event_ ## compare_key }
      |                  ^~~~~~~~~~
builtin-kvm.c:84:9: note: in expansion of macro ‘DEF_SORT_NAME_KEY’
   84 |         DEF_SORT_NAME_KEY(time, mean),
      |         ^~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[3]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:97: /tmp/build/perf-tools-next/builtin-kvm.o] Error 1
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [Makefile.perf:673: /tmp/build/perf-tools-next/perf-in.o] Error 2
make[2]: *** Waiting for unfinished jobs....
  CC      /tmp/build/perf-tools-next/pmu-events/pmu-events.o
  LD      /tmp/build/perf-tools-next/pmu-events/pmu-events-in.o
make[1]: *** [Makefile.perf:236: sub-make] Error 2
make: *** [Makefile:113: install-bin] Error 2
make: Leaving directory '/var/home/acme/git/perf-tools-next/tools/perf'

 Performance counter stats for 'make -k BUILD_BPF_SKEL=1 CORESIGHT=1 O=/tmp/build/perf-tools-next -C tools/perf install-bin':

       46519453561      cycles:u
       73484239007      instructions:u                   #    1.58  insn per cycle

      10.053592077 seconds time elapsed

      10.925077000 seconds user
       8.045887000 seconds sys


⬢[acme@toolbox perf-tools-next]$ git log --oneline -4
40843f667620dcf3 (HEAD) perf kvm: Use subtraction for comparison metrics
c6a5a089864171f2 perf kvm: Move up metrics helpers
1d75bc17ffc933aa perf kvm: Add pointer to 'perf_kvm_stat' in kvm event
4568393639938020 perf kvm: Refactor overall statistics
⬢[acme@toolbox perf-tools-next]$

⬢[acme@toolbox perf-tools-next]$ gcc --version
gcc (GCC) 12.2.1 20221121 (Red Hat 12.2.1-4)
 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/builtin-kvm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index 62c097a37da9..4e9519390da6 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
> @@ -63,10 +63,10 @@ static u64 get_event_ ##func(struct kvm_event *event, int vcpu)		\
>  
>  #define COMPARE_EVENT_KEY(func, field)					\
>  GET_EVENT_KEY(func, field)						\
> -static int cmp_event_ ## func(struct kvm_event *one,			\
> +static int64_t cmp_event_ ## func(struct kvm_event *one,		\
>  			      struct kvm_event *two, int vcpu)		\
>  {									\
> -	return get_event_ ##func(one, vcpu) >				\
> +	return get_event_ ##func(one, vcpu) -				\
>  	       get_event_ ##func(two, vcpu);				\
>  }
>  
> @@ -523,7 +523,7 @@ static void insert_to_result(struct rb_root *result, struct kvm_event *event,
>  		p = container_of(*rb, struct kvm_event, rb);
>  		parent = *rb;
>  
> -		if (bigger(event, p, vcpu))
> +		if (bigger(event, p, vcpu) > 0)
>  			rb = &(*rb)->rb_left;
>  		else
>  			rb = &(*rb)->rb_right;
> -- 
> 2.34.1
> 

-- 

- Arnaldo
