Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FAF6DA475
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 23:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239003AbjDFVJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 17:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238341AbjDFVJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 17:09:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E2DA277;
        Thu,  6 Apr 2023 14:09:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7AC8646B6;
        Thu,  6 Apr 2023 21:09:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D06C433EF;
        Thu,  6 Apr 2023 21:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680815372;
        bh=V73X3zvMa9mX4eCZmR/vnJEvOTmLrZEgknm1JtpSEVs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N75fWbfkjf2gsk/xhd1aFBCHQuVhOAIpqMmBceeHsPiKJoWyfqBAUEmm49JSsazJ+
         u8z6pMW+oGkVtWRjhKyKKzWC/ex+NIRvJRBEUcGdZwurMaTcodHvs2Pr9yk4I9YG5C
         LkwzdIeVQ2VEB+KgXHVe64J2IwdZvZiZWYLYdAfEakD3lzI0zdKGJSXIYLC6GmEorV
         iGFcNlaEHEGATO5iRF7ghyW/CrhH1CsNbznnhES4c5MM7xFHta61N54+LJsm11Ld/4
         iIbfSZw5djNdFr8GSjgiycIa4MXvQKCNv1iVJR3gmDHvlEf5uXJyu/ucTpQTgI/77K
         tn2n9yfEV/8uw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 748954052D; Thu,  6 Apr 2023 18:09:29 -0300 (-03)
Date:   Thu, 6 Apr 2023 18:09:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        German Gomez <german.gomez@arm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] perf pmu: Fix a few potential fd leaks
Message-ID: <ZC81CTH/VayirB5z@kernel.org>
References: <20230406065224.2553640-1-irogers@google.com>
 <20230406065224.2553640-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406065224.2553640-2-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 05, 2023 at 11:52:24PM -0700, Ian Rogers escreveu:
> Ensure fd is closed on error paths.

Was this reported by Jiri?

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/pmu.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 96ef317bac41..9eedbfc9e863 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -494,9 +494,13 @@ static int pmu_aliases_parse(int dirfd, struct list_head *head)
>  			continue;
>  
>  		fd = openat(dirfd, name, O_RDONLY);
> +		if (fd == -1) {
> +			pr_debug("Cannot open %s\n", name);
> +			continue;
> +		}
>  		file = fdopen(fd, "r");
>  		if (!file) {
> -			pr_debug("Cannot open %s\n", name);
> +			close(fd);
>  			continue;
>  		}
>  
> @@ -1882,9 +1886,13 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
>  			continue;
>  
>  		fd = openat(caps_fd, name, O_RDONLY);
> +		if (fd == -1)
> +			continue;
>  		file = fdopen(fd, "r");
> -		if (!file)
> +		if (!file) {
> +			close(fd);
>  			continue;
> +		}
>  
>  		if (!fgets(value, sizeof(value), file) ||
>  		    (perf_pmu__new_caps(&pmu->caps, name, value) < 0)) {
> -- 
> 2.40.0.348.gf938b09366-goog
> 

-- 

- Arnaldo
