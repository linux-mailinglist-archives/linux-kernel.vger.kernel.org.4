Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317DC7331F6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 15:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345588AbjFPNNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 09:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345557AbjFPNN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:13:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB2B3A92;
        Fri, 16 Jun 2023 06:13:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 732D263C50;
        Fri, 16 Jun 2023 13:13:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800B0C433C8;
        Fri, 16 Jun 2023 13:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686921199;
        bh=mQm8hu9ITzU2NnF6fwNpK5hC+oeccBOVUYKjkOQl508=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ACaJscHfqIULZp47slEzmb9Dku3lxAQzfhrqTCEzB3OaGvVZ8QubRrlnMHMJ/D177
         ziiM2D08uxue+nX1YDXdgPjKiaxya3utOZd5TuaNucfNEW2VjwlJFe5ti6N2cM5rkW
         wyFh5fMBAAQn6b0gciExzqnOLnIZwxzv599bF/kqIDdA/FQdjr7W7ypn6ZPdUSX5LL
         4jXUvy9DiWh7WjWlKG4UTa7h2mdOw1au654inCAoRBIDYdOF/UB9NsKt9ftec9idB8
         3kzrPLljxydEpRqzhrY3827HCH9LIa1Ox/CJ91KoyM9vkWlXGXAU+0ZMRQwFZBhn66
         j6kMyW2l500zw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B91E240692; Fri, 16 Jun 2023 10:13:16 -0300 (-03)
Date:   Fri, 16 Jun 2023 10:13:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, sumanthk@linux.ibm.com, hca@linux.ibm.com,
        svens@linux.ibm.com, gor@linux.ibm.com
Subject: Re: [PATCH] perf test: fix failing test cases on linux-next for s390
Message-ID: <ZIxf7A1jPiDUUdDt@kernel.org>
References: <20230616081437.1932003-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616081437.1932003-1-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jun 16, 2023 at 10:14:37AM +0200, Thomas Richter escreveu:
> In linux-next tree the many test cases fail on s390x when running the
> perf test suite, sometime the perf tool dumps core.
> 
> Output before:
>   6.1: Test event parsing                               : FAILED!
>  10.3: Parsing of PMU event table metrics               : FAILED!
>  10.4: Parsing of PMU event table metrics with fake PMUs: FAILED!
>  17: Setup struct perf_event_attr                       : FAILED!
>  24: Number of exit events of a simple workload         : FAILED!
>  26: Object code reading                                : FAILED!
>  28: Use a dummy software event to keep tracking        : FAILED!
>  35: Track with sched_switch                            : FAILED!
>  42.3: BPF prologue generation                          : FAILED!
>  66: Parse and process metrics                          : FAILED!
>  68: Event expansion for cgroups                        : FAILED!
>  69.2: Perf time to TSC                                 : FAILED!
>  74: build id cache operations                          : FAILED!
>  86: Zstd perf.data compression/decompression           : FAILED!
>  87: perf record tests                                  : FAILED!
> 106: Test java symbol                                   : FAILED!
> 
> The reason for all these failure is a missing PMU. On s390x
> the PMU is named cpum_cf which is not detected as core PMU.
> A similar patch was added before, see
> commit 9bacbced0e32 ("perf list: Add s390 support for detailed PMU event description")
> which got lost during the recent reworks. Add it again.
> 
> Output after:
>  10.2: PMU event map aliases                            : FAILED!
>  42.3: BPF prologue generation                          : FAILED!
> 
> Most test cases now work and there is not core dump anymore.

So you're not fixing 'perf test', that is just what detects the problem,
the part being fixed is the PMU code, so I'm rewriting the patch subject
to:

[PATCH] perf pmu: Fix core PMU detection on s/390

Have you bisected the problem to the first patch where this problem
appears?

- Arnaldo
 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Cc: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index fe64ad292d36..6142e4710a2f 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1419,7 +1419,7 @@ void perf_pmu__del_formats(struct list_head *formats)
>  
>  bool is_pmu_core(const char *name)
>  {
> -	return !strcmp(name, "cpu") || is_sysfs_pmu_core(name);
> +	return !strcmp(name, "cpu") || !strcmp(name, "cpum_cf") || is_sysfs_pmu_core(name);
>  }
>  
>  bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu)
> -- 
> 2.39.2
> 

-- 

- Arnaldo
