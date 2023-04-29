Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49CE6F21ED
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 03:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347229AbjD2BU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 21:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347049AbjD2BUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 21:20:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538DA2703;
        Fri, 28 Apr 2023 18:20:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C825963EBB;
        Sat, 29 Apr 2023 01:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B3AC433D2;
        Sat, 29 Apr 2023 01:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682731223;
        bh=cXEGEEEjMxbFbsEVKrFzprQpsYPuj0Im0jVmqU+ky8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gf6hQXOsmuRCR+NLHGaOlXpluylAcEdO15qBnEFTfaXM49L4WQIQ3EmK3I+8UzYM6
         snhSBPSGClVOEZQE6OmsZzSGPw66xEko3t2O16gs9VtEV7qEByYeFOkaU9XcEA3oi8
         /tt9S/VV3gQYr5QVWvL+ADILOBJmpgbTnL+B2UTO31D6oHdywRKsssLo0loHPirWRu
         GhSBb2PO0S+5w6Rf32lJuwYZ22gbkuGZF+cvFzVLko3a4fb/PUVFfxRM3K8pQqD62d
         NT8BpS8ILOEX0Sst091w7+kH2a7SzssLH0yd9GtvB8bconb//2px+IxoAFINTfXz16
         YKCKwIOzGWgxA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B3C4E403B5; Fri, 28 Apr 2023 22:20:20 -0300 (-03)
Date:   Fri, 28 Apr 2023 22:20:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/43] perf stat: Avoid segv on counter->name
Message-ID: <ZExw1OCyQJ4Fc2lD@kernel.org>
References: <20230428073809.1803624-1-irogers@google.com>
 <20230428073809.1803624-10-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428073809.1803624-10-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Apr 28, 2023 at 12:37:35AM -0700, Ian Rogers escreveu:
> Switch to use evsel__name that doesn't return NULL for hardware and
> similar events.
> 
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

> ---
>  tools/perf/util/stat-display.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index df6337f2480b..7aa7e16fa7c4 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -748,7 +748,7 @@ static void uniquify_event_name(struct evsel *counter)
>  	int ret = 0;
>  
>  	if (counter->uniquified_name || counter->use_config_name ||
> -	    !counter->pmu_name || !strncmp(counter->name, counter->pmu_name,
> +	    !counter->pmu_name || !strncmp(evsel__name(counter), counter->pmu_name,
>  					   strlen(counter->pmu_name)))
>  		return;
>  
> -- 
> 2.40.1.495.gc816e09b53d-goog
> 

-- 

- Arnaldo
