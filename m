Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C305BE78B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiITNun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiITNuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:50:39 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85131C938;
        Tue, 20 Sep 2022 06:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663681827; x=1695217827;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WoF6r5ZGB6LgvY0+cK9qehlp8Ly2mv+a6H//Hxs+g3M=;
  b=fq7dUJJUqW5yhn1Ki9UWV4NfKv51XNSqbPR5P9+mEbpMCldqB/ZJxSnc
   IBXOeTetAj6jOVZKTAFxB5O1XWVayi64KwPuVlaR4JMxLsXtIm865NOO2
   en+wH3dF1qTQbhzbD1qGNei1Q/UJKi7zSWsaGC6RpIjBsz5YOhG4xO5pH
   ri+nyGONSlS0SOKXPFCE0YTvuZpJDObEjXbdemo/XrpoK/RCt5i7MkK8c
   zVG21zvHhFvYq7sJ7JBkuI+j+l8xXBbuU6FTd2ygiJeetAh8+We44vuQ4
   q0XANKBEzcf9RiE3Z1+iOtOel1I+7yro2+EBDEkL3Uws+5m4CXrJ4il1T
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="282726920"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="282726920"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 06:50:27 -0700
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="744540582"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.58.32])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 06:50:24 -0700
Message-ID: <5116611b-2d91-a9fe-5760-65a9a9b50747@intel.com>
Date:   Tue, 20 Sep 2022 16:50:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 2/4] perf tools: Add perf_event__synthesize_{start,stop}()
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
References: <20220916175902.1155177-1-namhyung@kernel.org>
 <20220916175902.1155177-3-namhyung@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220916175902.1155177-3-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/22 20:59, Namhyung Kim wrote:
> These functions are to prepare and cleanup necessary work for synthesizing.
> It doesn't do anything yet but later patch will add it.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-inject.c        | 3 +++
>  tools/perf/builtin-record.c        | 3 +++
>  tools/perf/builtin-stat.c          | 2 ++
>  tools/perf/builtin-top.c           | 4 ++++
>  tools/perf/util/auxtrace.c         | 2 ++
>  tools/perf/util/synthetic-events.c | 8 ++++++++
>  tools/perf/util/synthetic-events.h | 3 +++
>  7 files changed, 25 insertions(+)
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index e254f18986f7..2e91a887919b 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -2368,9 +2368,12 @@ int cmd_inject(int argc, const char **argv)
>  	if (ret < 0)
>  		goto out_delete;
>  
> +	perf_event__synthesize_start();
> +
>  	ret = __cmd_inject(&inject);
>  
>  	guest_session__exit(&inject.guest_session);
> +	perf_event__synthesize_stop();

AFAICT perf inject synthesizes mmap events only for JIT and that is
open-coded in jitdump.c. i.e. perf_event__synthesize_start / stop
not needed

>  
>  out_delete:
>  	strlist__delete(inject.known_build_ids);
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 02e38f50a138..5b7b9ad2a280 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1966,6 +1966,8 @@ static int record__synthesize(struct record *rec, bool tail)
>  	if (rec->opts.tail_synthesize != tail)
>  		return 0;
>  
> +	perf_event__synthesize_start();

Perhaps also record__synthesize_workload() ?

> +
>  	if (data->is_pipe) {
>  		err = perf_event__synthesize_for_pipe(tool, session, data,
>  						      process_synthesized_event);
> @@ -2072,6 +2074,7 @@ static int record__synthesize(struct record *rec, bool tail)
>  	}
>  
>  out:
> +	perf_event__synthesize_stop();
>  	return err;
>  }
>  
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index e05fe72c1d87..f6f61e08f4c2 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -962,6 +962,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  		if (err < 0)
>  			return err;
>  
> +		perf_event__synthesize_start();
>  		err = perf_event__synthesize_stat_events(&stat_config, NULL, evsel_list,
>  							 process_synthesized_event, is_pipe);
>  		if (err < 0)
> @@ -2641,6 +2642,7 @@ int cmd_stat(int argc, const char **argv)
>  			perf_session__write_header(perf_stat.session, evsel_list, fd, true);
>  		}
>  
> +		perf_event__synthesize_stop();
>  		evlist__close(evsel_list);
>  		perf_session__delete(perf_stat.session);
>  	}
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index e89208b4ad4b..1eff894e6b5f 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1258,6 +1258,8 @@ static int __cmd_top(struct perf_top *top)
>  #endif
>  	}
>  
> +	perf_event__synthesize_start();
> +
>  	ret = perf_event__synthesize_bpf_events(top->session, perf_event__process,
>  						&top->session->machines.host,
>  						&top->record_opts);
> @@ -1273,6 +1275,8 @@ static int __cmd_top(struct perf_top *top)
>  				    top->evlist->core.threads, true, false,
>  				    top->nr_threads_synthesize);
>  
> +	perf_event__synthesize_stop();
> +
>  	if (top->nr_threads_synthesize > 1)
>  		perf_set_singlethreaded();
>  
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index b59c278fe9ed..1bfe076c22fb 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -1328,6 +1328,7 @@ int perf_event__process_auxtrace_info(struct perf_session *session,
>  	if (err)
>  		return err;
>  
> +	perf_event__synthesize_start();
>  	unleader_auxtrace(session);
>  
>  	return 0;
> @@ -2834,6 +2835,7 @@ void auxtrace__free(struct perf_session *session)
>  	if (!session->auxtrace)
>  		return;
>  
> +	perf_event__synthesize_stop();

auxtrace does not synthesize mmap events

>  	return session->auxtrace->free(session);
>  }
>  
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index 0ff57ca24577..9d4f5dacd154 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -47,6 +47,14 @@
>  
>  unsigned int proc_map_timeout = DEFAULT_PROC_MAP_PARSE_TIMEOUT;
>  
> +void perf_event__synthesize_start(void)
> +{
> +}
> +
> +void perf_event__synthesize_stop(void)
> +{
> +}
> +
>  int perf_tool__process_synth_event(struct perf_tool *tool,
>  				   union perf_event *event,
>  				   struct machine *machine,
> diff --git a/tools/perf/util/synthetic-events.h b/tools/perf/util/synthetic-events.h
> index 53737d1619a4..e4414616080c 100644
> --- a/tools/perf/util/synthetic-events.h
> +++ b/tools/perf/util/synthetic-events.h
> @@ -43,6 +43,9 @@ int parse_synth_opt(char *str);
>  typedef int (*perf_event__handler_t)(struct perf_tool *tool, union perf_event *event,
>  				     struct perf_sample *sample, struct machine *machine);
>  
> +void perf_event__synthesize_start(void);
> +void perf_event__synthesize_stop(void);
> +
>  int perf_event__synthesize_attrs(struct perf_tool *tool, struct evlist *evlist, perf_event__handler_t process);
>  int perf_event__synthesize_attr(struct perf_tool *tool, struct perf_event_attr *attr, u32 ids, u64 *id, perf_event__handler_t process);
>  int perf_event__synthesize_build_id(struct perf_tool *tool, struct dso *pos, u16 misc, perf_event__handler_t process, struct machine *machine);

