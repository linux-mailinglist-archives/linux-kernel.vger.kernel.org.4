Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23406A8447
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjCBOgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjCBOgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:36:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571557AB0;
        Thu,  2 Mar 2023 06:36:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02B0EB8122A;
        Thu,  2 Mar 2023 14:36:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94852C433EF;
        Thu,  2 Mar 2023 14:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677767806;
        bh=lan48FmJFWW7E9wtA8COD7dMN7uAG9Gk4gihsgr4Fz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c284mA84jf8Pche/QH/i20zCnbXxsiXa2g9Hcp6rPFlUcWRj8IZ7ueZXWai0GD1zD
         UwcMJQYbk4QplwEZYP9Qjsz9jRENnbMfyPlq3WI4v1Rz7niH01MR3QidGy/h53iucT
         wTnvULD+l1Pj+Ds8YJgk2NyFsHJsDn9mkr/gyDT+CRMsDrj1Xg5nvT2d9whIGwgFHS
         pymFQrbMMRsi5ry885akQZ3LW+2DxMrzgKWt2qdgCGS3oAJp+WqVaWzgtzyKMHbpO+
         ezPtT3efSHGIXsBkR63AlxKuvyBmw3T0i+2JrMZqUoiLGrBuAeB4pS5rtgU7bu7nlH
         PIT4XfaqzBtSw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 367B54049F; Thu,  2 Mar 2023 11:36:44 -0300 (-03)
Date:   Thu, 2 Mar 2023 11:36:44 -0300
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
Subject: Re: [PATCH v1 06/10] perf evsel: Allow const evsel for certain
 accesses
Message-ID: <ZAC0fGpZpT+3lDVU@kernel.org>
References: <20230302041211.852330-1-irogers@google.com>
 <20230302041211.852330-7-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302041211.852330-7-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 01, 2023 at 08:12:07PM -0800, Ian Rogers escreveu:
> List sorting, added later to evlist, passes const elements requiring
> helper functions to also be const. Make the argument to
> evsel__find_pmu, evsel__is_aux_event and evsel__leader const.

But then you have to de-constify it at some point :-\

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/evsel.c  | 2 +-
>  tools/perf/util/evsel.h  | 6 +++---
>  tools/perf/util/pmu.c    | 6 +++---
>  tools/perf/util/python.c | 2 +-
>  4 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 51e8ce6edddc..2dc2c24252bb 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -3139,7 +3139,7 @@ bool evsel__is_hybrid(const struct evsel *evsel)
>  	return evsel->pmu_name && perf_pmu__is_hybrid(evsel->pmu_name);
>  }
>  
> -struct evsel *evsel__leader(struct evsel *evsel)
> +struct evsel *evsel__leader(const struct evsel *evsel)
>  {
>  	return container_of(evsel->core.leader, struct evsel, core);
>  }
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 814a49ebb7e3..676c499323e9 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -212,8 +212,8 @@ int evsel__object_config(size_t object_size,
>  			 int (*init)(struct evsel *evsel),
>  			 void (*fini)(struct evsel *evsel));
>  
> -struct perf_pmu *evsel__find_pmu(struct evsel *evsel);
> -bool evsel__is_aux_event(struct evsel *evsel);
> +struct perf_pmu *evsel__find_pmu(const struct evsel *evsel);
> +bool evsel__is_aux_event(const struct evsel *evsel);
>  
>  struct evsel *evsel__new_idx(struct perf_event_attr *attr, int idx);
>  
> @@ -505,7 +505,7 @@ int evsel__store_ids(struct evsel *evsel, struct evlist *evlist);
>  
>  void evsel__zero_per_pkg(struct evsel *evsel);
>  bool evsel__is_hybrid(const struct evsel *evsel);
> -struct evsel *evsel__leader(struct evsel *evsel);
> +struct evsel *evsel__leader(const struct evsel *evsel);
>  bool evsel__has_leader(struct evsel *evsel, struct evsel *leader);
>  bool evsel__is_leader(struct evsel *evsel);
>  void evsel__set_leader(struct evsel *evsel, struct evsel *leader);
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 43b6182d96b7..45d9b8e28e16 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -988,7 +988,7 @@ struct perf_pmu *perf_pmu__scan(struct perf_pmu *pmu)
>  	return NULL;
>  }
>  
> -struct perf_pmu *evsel__find_pmu(struct evsel *evsel)
> +struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
>  {
>  	struct perf_pmu *pmu = NULL;
>  
> @@ -1000,11 +1000,11 @@ struct perf_pmu *evsel__find_pmu(struct evsel *evsel)
>  			break;
>  	}
>  
> -	evsel->pmu = pmu;
> +	((struct evsel *)evsel)->pmu = pmu;

Hu

>  	return pmu;
>  }
>  
> -bool evsel__is_aux_event(struct evsel *evsel)
> +bool evsel__is_aux_event(const struct evsel *evsel)
>  {
>  	struct perf_pmu *pmu = evsel__find_pmu(evsel);
>  
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 42e8b813d010..ab48ffbb6448 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -83,7 +83,7 @@ const char *perf_env__arch(struct perf_env *env __maybe_unused)
>   * far, for the perf python binding known usecases, revisit if this become
>   * necessary.
>   */
> -struct perf_pmu *evsel__find_pmu(struct evsel *evsel __maybe_unused)
> +struct perf_pmu *evsel__find_pmu(const struct evsel *evsel __maybe_unused)
>  {
>  	return NULL;
>  }
> -- 
> 2.39.2.722.g9855ee24e9-goog
> 

-- 

- Arnaldo
