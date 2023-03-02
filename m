Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24846A8439
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjCBOdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjCBOdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:33:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA343E614;
        Thu,  2 Mar 2023 06:33:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 029A4B80F52;
        Thu,  2 Mar 2023 14:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CDE3C433EF;
        Thu,  2 Mar 2023 14:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677767584;
        bh=1R2gSt+nHJNxrAQ3PyOhlKch6GMiz2DfejtQUqixaPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ASCdwM4PuschUkqdvQ0it4PpES09CnGya4rFsgoTJNaTEIWBxux68EQiTuE6TKokW
         czmxYks/qO6ITI2STNsm0aYJT1w86IttIZrCYcAT/NbxuSSb5JDls/DYHsH7XuyDwn
         hd41IqRr/5Hnv1dAqOB4ntkIJgIxvfoZ09K8NOD3zFp/6wyADpiNO08hxmWkX/J3bC
         Lb6DbLOhmI39wF6I4LoKmB+UcwoHAtil6FbsBP62ja1xbMNSgmTojsp9IFpYxQPcgW
         UWIWODgrLgQvGUSVW4gwitxJ1pF5dXlgv7EG6QiOitWuVUm4hG0y/XM+VRFItSGcTz
         /8Z7YlMAl/KjA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3E06F4049F; Thu,  2 Mar 2023 11:33:02 -0300 (-03)
Date:   Thu, 2 Mar 2023 11:33:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Qi Liu <liuqi115@huawei.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1 01/10] libperf evlist: Avoid a use of evsel idx
Message-ID: <ZACznqmwP2ySKwn9@kernel.org>
References: <20230302041211.852330-1-irogers@google.com>
 <20230302041211.852330-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302041211.852330-2-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 01, 2023 at 08:12:02PM -0800, Ian Rogers escreveu:
> Setting the leader iterates the list, so rather than use idx (which
> may be changed through list reordering) just count the elements and
> set afterwards.

Looks ok
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/perf/evlist.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index 61b637f29b82..2d6121e89ccb 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -687,15 +687,14 @@ perf_evlist__next_mmap(struct perf_evlist *evlist, struct perf_mmap *map,
>  
>  void __perf_evlist__set_leader(struct list_head *list, struct perf_evsel *leader)
>  {
> -	struct perf_evsel *first, *last, *evsel;
> -
> -	first = list_first_entry(list, struct perf_evsel, node);
> -	last = list_last_entry(list, struct perf_evsel, node);
> -
> -	leader->nr_members = last->idx - first->idx + 1;
> +	struct perf_evsel *evsel;
> +	int n = 0;
>  
> -	__perf_evlist__for_each_entry(list, evsel)
> +	__perf_evlist__for_each_entry(list, evsel) {
>  		evsel->leader = leader;
> +		n++;
> +	}
> +	leader->nr_members = n;
>  }
>  
>  void perf_evlist__set_leader(struct perf_evlist *evlist)
> -- 
> 2.39.2.722.g9855ee24e9-goog
> 

-- 

- Arnaldo
