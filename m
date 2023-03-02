Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0BB6A8440
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjCBOfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjCBOe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:34:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837DD1284B;
        Thu,  2 Mar 2023 06:34:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E7D5615D2;
        Thu,  2 Mar 2023 14:34:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445C1C433EF;
        Thu,  2 Mar 2023 14:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677767677;
        bh=am2Pms4fC7Mb/X3wlNdEKvPjV1B08gkpE6ryQz2S3CI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HQUUGL8ZdCd64toSBpMY2gXtz8rhPG6UFK7zTU8cYXcH9s9YF+v4BXfjWioHvIX1E
         uOm+1ZHKl86gMFbEWwIB7ACztp+OTESh4ehQQVJG9RcJr65CTfd1ABjn/Klj6w9caa
         8b8KNS+NR/tGSqOLFz4cSZCLB7x1JIq/TFei3K/fG1hTR9zqKgUmUOh3Xqy5WN/Vrs
         WMW9KESdw1YHg4yAED+v9myP13HpO5kMW71zHMwCW7Hhu2qDodrMREWiXKivR1YnIg
         uwdY4n8xVNNQHmeALGTBPBdgjtnQQQq4KYCRbXF7MkukijPVdfB+j+BRb9HkdN5/Gj
         irAaQ8DOAEB2A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5111E4049F; Thu,  2 Mar 2023 11:34:35 -0300 (-03)
Date:   Thu, 2 Mar 2023 11:34:35 -0300
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
Subject: Re: [PATCH v1 04/10] perf stat: Modify the group test
Message-ID: <ZACz+ypWOFxtsu92@kernel.org>
References: <20230302041211.852330-1-irogers@google.com>
 <20230302041211.852330-5-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302041211.852330-5-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 01, 2023 at 08:12:05PM -0800, Ian Rogers escreveu:
> Previously nr_members would be 0 for an event with no group. The
> previous change made that count 1, the event is its own leader without
> a group. Make the find_stat logic consistent with this, an improvement
> suggested by Namhyung Kim.

Is this the only place where this change in behaviour needs to be taken
into account?

- Arnaldo
 
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/stat-shadow.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> index ef85f1ae1ab2..eeccab6751d7 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -163,7 +163,7 @@ static double find_stat(const struct evsel *evsel, int aggr_idx, enum stat_type
>  			continue;
>  
>  		/* Ignore evsels that are part of different groups. */
> -		if (evsel->core.leader->nr_members &&
> +		if (evsel->core.leader->nr_members > 1 &&
>  		    evsel->core.leader != cur->core.leader)
>  			continue;
>  		/* Ignore evsels with mismatched modifiers. */
> -- 
> 2.39.2.722.g9855ee24e9-goog
> 

-- 

- Arnaldo
