Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3766C6C109D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjCTLTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjCTLTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:19:01 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F2946B2;
        Mon, 20 Mar 2023 04:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679311137; x=1710847137;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=KTHqz8Jdwx1pkXHefyMyxAEW1J5geHO20yk3yCB275w=;
  b=kqS3Ibv6xFaIbJOg1NEbAnK12f/qDz8WVriI74IIuLi3EU+vGcLyqchb
   5teO+PCMwQdWLxSwxtNmYa4UrGgI1B+JsVBK1qiO6ZiwMxxSEsOjt+pzq
   SaZAZYpk8no/TAvp298rPYq5hgAqFRTdOM1HkXTv68tdgC6dZj+muxdyh
   J3JJO5jMhp+Q4GlOb3DoLjlp65rjWOZjdb2PhZGxNQRXrZ7jo9xzxA6/r
   ELQCiX7XoLzbgP190pDkdqBhjDvPZGhih4MamrGWyMkJ5TeQV4oSASbV+
   +h2F4KJoQvrf2rgYLlvgq2/HySguWD686rp5DZ2vyWqL0x7CYi3k0nXYC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="424910052"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="424910052"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 04:18:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="683418517"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="683418517"
Received: from spalihov-mobl2.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.34.182])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 04:18:47 -0700
Message-ID: <32654889-2e76-1a09-acef-e9b4378f855f@intel.com>
Date:   Mon, 20 Mar 2023 13:18:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v4 17/22] perf map: Changes to reference counting
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, Hao Luo <haoluo@google.com>
Cc:     Stephane Eranian <eranian@google.com>
References: <20230320033810.980165-1-irogers@google.com>
 <20230320033810.980165-18-irogers@google.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230320033810.980165-18-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/23 05:38, Ian Rogers wrote:
> When a pointer to a map exists do a get, when that pointer is
> overwritten or freed, put the map. This avoids issues with gets and
> puts being inconsistently used causing, use after puts, etc. For
> example, the map in struct addr_location is changed to hold a
> reference count.

I am not sure I understand the reason for that.  A thread's address
mappings are inherently transitory with respect to perf (MMAP) event
processing.  Holding on to a reference to a thread's map is not a
valid thing to do if more perf events can be processed in the meantime.
Reference counting seems to hide the problem in that case, since
the solution is: don't keep the reference.

>                  Reference count checking and address sanitizer were
> used to identify issues.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/code-reading.c       |  1 +
>  tools/perf/tests/hists_cumulate.c     | 10 ++++
>  tools/perf/tests/hists_filter.c       | 10 ++++
>  tools/perf/tests/hists_link.c         | 18 +++++-
>  tools/perf/tests/hists_output.c       | 10 ++++
>  tools/perf/tests/mmap-thread-lookup.c |  1 +
>  tools/perf/util/callchain.c           |  9 +--
>  tools/perf/util/event.c               |  8 ++-
>  tools/perf/util/hist.c                | 10 ++--
>  tools/perf/util/machine.c             | 79 ++++++++++++++++-----------
>  tools/perf/util/map.c                 |  2 +-
>  11 files changed, 114 insertions(+), 44 deletions(-)
> 
> diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
> index 1545fcaa95c6..efe026a35010 100644
> --- a/tools/perf/tests/code-reading.c
> +++ b/tools/perf/tests/code-reading.c
> @@ -366,6 +366,7 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
>  	}
>  	pr_debug("Bytes read match those read by objdump\n");
>  out:
> +	map__put(al.map);

Given that it is 'al' that is going away, wouldn't it be
more logical to have here:

	addr_location__exit(&al);

where:

void addr_location__exit(struct addr_location *al)
{
	if (al->map) {
		map__put(al->map);
		al->map = NULL;
	}
}


>  	return err;
>  }
>  
> diff --git a/tools/perf/tests/hists_cumulate.c b/tools/perf/tests/hists_cumulate.c
> index f00ec9abdbcd..8c0e3f334747 100644
> --- a/tools/perf/tests/hists_cumulate.c
> +++ b/tools/perf/tests/hists_cumulate.c
> @@ -112,6 +112,7 @@ static int add_hist_entries(struct hists *hists, struct machine *machine)
>  		}
>  
>  		fake_samples[i].thread = al.thread;
> +		map__put(fake_samples[i].map);
>  		fake_samples[i].map = al.map;
>  		fake_samples[i].sym = al.sym;
>  	}
> @@ -147,6 +148,14 @@ static void del_hist_entries(struct hists *hists)
>  	}
>  }
>  
> +static void put_fake_samples(void)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < ARRAY_SIZE(fake_samples); i++)
> +		map__put(fake_samples[i].map);
> +}
> +
>  typedef int (*test_fn_t)(struct evsel *, struct machine *);
>  
>  #define COMM(he)  (thread__comm_str(he->thread))
> @@ -733,6 +742,7 @@ static int test__hists_cumulate(struct test_suite *test __maybe_unused, int subt
>  	/* tear down everything */
>  	evlist__delete(evlist);
>  	machines__exit(&machines);
> +	put_fake_samples();
>  
>  	return err;
>  }
> diff --git a/tools/perf/tests/hists_filter.c b/tools/perf/tests/hists_filter.c
> index 7c552549f4a4..98eff5935a1c 100644
> --- a/tools/perf/tests/hists_filter.c
> +++ b/tools/perf/tests/hists_filter.c
> @@ -89,6 +89,7 @@ static int add_hist_entries(struct evlist *evlist,
>  			}
>  
>  			fake_samples[i].thread = al.thread;
> +			map__put(fake_samples[i].map);
>  			fake_samples[i].map = al.map;
>  			fake_samples[i].sym = al.sym;
>  		}
> @@ -101,6 +102,14 @@ static int add_hist_entries(struct evlist *evlist,
>  	return TEST_FAIL;
>  }
>  
> +static void put_fake_samples(void)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < ARRAY_SIZE(fake_samples); i++)
> +		map__put(fake_samples[i].map);
> +}
> +
>  static int test__hists_filter(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
>  {
>  	int err = TEST_FAIL;
> @@ -322,6 +331,7 @@ static int test__hists_filter(struct test_suite *test __maybe_unused, int subtes
>  	evlist__delete(evlist);
>  	reset_output_field();
>  	machines__exit(&machines);
> +	put_fake_samples();
>  
>  	return err;
>  }
> diff --git a/tools/perf/tests/hists_link.c b/tools/perf/tests/hists_link.c
> index e7e4ee57ce04..64ce8097889c 100644
> --- a/tools/perf/tests/hists_link.c
> +++ b/tools/perf/tests/hists_link.c
> @@ -6,6 +6,7 @@
>  #include "evsel.h"
>  #include "evlist.h"
>  #include "machine.h"
> +#include "map.h"
>  #include "parse-events.h"
>  #include "hists_common.h"
>  #include "util/mmap.h"
> @@ -94,6 +95,7 @@ static int add_hist_entries(struct evlist *evlist, struct machine *machine)
>  			}
>  
>  			fake_common_samples[k].thread = al.thread;
> +			map__put(fake_common_samples[k].map);
>  			fake_common_samples[k].map = al.map;
>  			fake_common_samples[k].sym = al.sym;
>  		}
> @@ -126,11 +128,24 @@ static int add_hist_entries(struct evlist *evlist, struct machine *machine)
>  	return -1;
>  }
>  
> +static void put_fake_samples(void)
> +{
> +	size_t i, j;
> +
> +	for (i = 0; i < ARRAY_SIZE(fake_common_samples); i++)
> +		map__put(fake_common_samples[i].map);
> +	for (i = 0; i < ARRAY_SIZE(fake_samples); i++) {
> +		for (j = 0; j < ARRAY_SIZE(fake_samples[0]); j++)
> +			map__put(fake_samples[i][j].map);
> +	}
> +}
> +
>  static int find_sample(struct sample *samples, size_t nr_samples,
>  		       struct thread *t, struct map *m, struct symbol *s)
>  {
>  	while (nr_samples--) {
> -		if (samples->thread == t && samples->map == m &&
> +		if (samples->thread == t &&
> +		    samples->map == m &&
>  		    samples->sym == s)
>  			return 1;
>  		samples++;
> @@ -336,6 +351,7 @@ static int test__hists_link(struct test_suite *test __maybe_unused, int subtest
>  	evlist__delete(evlist);
>  	reset_output_field();
>  	machines__exit(&machines);
> +	put_fake_samples();
>  
>  	return err;
>  }
> diff --git a/tools/perf/tests/hists_output.c b/tools/perf/tests/hists_output.c
> index 428d11a938f2..cebd5226bb12 100644
> --- a/tools/perf/tests/hists_output.c
> +++ b/tools/perf/tests/hists_output.c
> @@ -78,6 +78,7 @@ static int add_hist_entries(struct hists *hists, struct machine *machine)
>  		}
>  
>  		fake_samples[i].thread = al.thread;
> +		map__put(fake_samples[i].map);
>  		fake_samples[i].map = al.map;
>  		fake_samples[i].sym = al.sym;
>  	}
> @@ -113,6 +114,14 @@ static void del_hist_entries(struct hists *hists)
>  	}
>  }
>  
> +static void put_fake_samples(void)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < ARRAY_SIZE(fake_samples); i++)
> +		map__put(fake_samples[i].map);
> +}
> +
>  typedef int (*test_fn_t)(struct evsel *, struct machine *);
>  
>  #define COMM(he)  (thread__comm_str(he->thread))
> @@ -620,6 +629,7 @@ static int test__hists_output(struct test_suite *test __maybe_unused, int subtes
>  	/* tear down everything */
>  	evlist__delete(evlist);
>  	machines__exit(&machines);
> +	put_fake_samples();
>  
>  	return err;
>  }
> diff --git a/tools/perf/tests/mmap-thread-lookup.c b/tools/perf/tests/mmap-thread-lookup.c
> index 5cc4644e353d..898eda55b7a8 100644
> --- a/tools/perf/tests/mmap-thread-lookup.c
> +++ b/tools/perf/tests/mmap-thread-lookup.c
> @@ -203,6 +203,7 @@ static int mmap_events(synth_cb synth)
>  		}
>  
>  		pr_debug("map %p, addr %" PRIx64 "\n", al.map, map__start(al.map));
> +		map__put(al.map);
>  	}
>  
>  	machine__delete_threads(machine);
> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index 9e9c39dd9d2b..78dc7b6f7ff7 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -589,7 +589,7 @@ fill_node(struct callchain_node *node, struct callchain_cursor *cursor)
>  		}
>  		call->ip = cursor_node->ip;
>  		call->ms = cursor_node->ms;
> -		map__get(call->ms.map);
> +		call->ms.map = map__get(call->ms.map);
>  		call->srcline = cursor_node->srcline;
>  
>  		if (cursor_node->branch) {
> @@ -1067,7 +1067,7 @@ int callchain_cursor_append(struct callchain_cursor *cursor,
>  	node->ip = ip;
>  	map__zput(node->ms.map);
>  	node->ms = *ms;
> -	map__get(node->ms.map);
> +	node->ms.map = map__get(node->ms.map);
>  	node->branch = branch;
>  	node->nr_loop_iter = nr_loop_iter;
>  	node->iter_cycles = iter_cycles;
> @@ -1115,7 +1115,8 @@ int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *
>  	struct machine *machine = maps__machine(node->ms.maps);
>  
>  	al->maps = node->ms.maps;
> -	al->map = node->ms.map;
> +	map__put(al->map);
> +	al->map = map__get(node->ms.map);
>  	al->sym = node->ms.sym;
>  	al->srcline = node->srcline;
>  	al->addr = node->ip;
> @@ -1528,7 +1529,7 @@ int callchain_node__make_parent_list(struct callchain_node *node)
>  				goto out;
>  			*new = *chain;
>  			new->has_children = false;
> -			map__get(new->ms.map);
> +			new->ms.map = map__get(new->ms.map);
>  			list_add_tail(&new->list, &head);
>  		}
>  		parent = parent->parent;
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index 2712d1a8264e..8293c8a3406b 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -485,13 +485,14 @@ size_t perf_event__fprintf_text_poke(union perf_event *event, struct machine *ma
>  	if (machine) {
>  		struct addr_location al;
>  
> -		al.map = maps__find(machine__kernel_maps(machine), tp->addr);
> +		al.map = map__get(maps__find(machine__kernel_maps(machine), tp->addr));
>  		if (al.map && map__load(al.map) >= 0) {
>  			al.addr = map__map_ip(al.map, tp->addr);
>  			al.sym = map__find_symbol(al.map, al.addr);
>  			if (al.sym)
>  				ret += symbol__fprintf_symname_offs(al.sym, &al, fp);
>  		}
> +		map__put(al.map);
>  	}
>  	ret += fprintf(fp, " old len %u new len %u\n", tp->old_len, tp->new_len);
>  	old = true;
> @@ -582,6 +583,7 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
>  	al->filtered = 0;
>  
>  	if (machine == NULL) {
> +		map__put(al->map);

Often as not, addr_location is not initialized before a call
to thread__find_map(), so this is dereferencing an uninitialized
pointer in those cases.

>  		al->map = NULL;
>  		return NULL;
>  	}
> @@ -600,6 +602,7 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
>  		al->level = 'u';
>  	} else {
>  		al->level = 'H';
> +		map__put(al->map);

As above

>  		al->map = NULL;
>  
>  		if ((cpumode == PERF_RECORD_MISC_GUEST_USER ||
> @@ -614,7 +617,7 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
>  		return NULL;
>  	}
>  
> -	al->map = maps__find(maps, al->addr);
> +	al->map = map__get(maps__find(maps, al->addr));

The map__put() above suggest there should one here before
overwriting al->map?

In general, it looks like there are callers of thread__find_map()
that are not covered by this patch?

>  	if (al->map != NULL) {
>  		/*
>  		 * Kernel maps might be changed when loading symbols so loading
> @@ -773,6 +776,7 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
>   */
>  void addr_location__put(struct addr_location *al)
>  {
> +	map__zput(al->map);
>  	thread__zput(al->thread);
>  }
>  
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index fdf0562d2fd3..02b4bf31b1a7 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -450,7 +450,7 @@ static int hist_entry__init(struct hist_entry *he,
>  			memset(&he->stat, 0, sizeof(he->stat));
>  	}
>  
> -	map__get(he->ms.map);
> +	he->ms.map = map__get(he->ms.map);
>  
>  	if (he->branch_info) {
>  		/*
> @@ -465,13 +465,13 @@ static int hist_entry__init(struct hist_entry *he,
>  		memcpy(he->branch_info, template->branch_info,
>  		       sizeof(*he->branch_info));
>  
> -		map__get(he->branch_info->from.ms.map);
> -		map__get(he->branch_info->to.ms.map);
> +		he->branch_info->from.ms.map = map__get(he->branch_info->from.ms.map);
> +		he->branch_info->to.ms.map = map__get(he->branch_info->to.ms.map);
>  	}
>  
>  	if (he->mem_info) {
> -		map__get(he->mem_info->iaddr.ms.map);
> -		map__get(he->mem_info->daddr.ms.map);
> +		he->mem_info->iaddr.ms.map = map__get(he->mem_info->iaddr.ms.map);
> +		he->mem_info->daddr.ms.map = map__get(he->mem_info->daddr.ms.map);
>  	}
>  
>  	if (hist_entry__has_callchains(he) && symbol_conf.use_callchain)
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 916d98885128..502e97010a3c 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -880,21 +880,29 @@ static int machine__process_ksymbol_register(struct machine *machine,
>  	struct symbol *sym;
>  	struct dso *dso;
>  	struct map *map = maps__find(machine__kernel_maps(machine), event->ksymbol.addr);
> +	bool put_map = false;
> +	int err = 0;
>  
>  	if (!map) {
> -		int err;
> -
>  		dso = dso__new(event->ksymbol.name);
> -		if (dso) {
> -			dso->kernel = DSO_SPACE__KERNEL;
> -			map = map__new2(0, dso);
> -			dso__put(dso);
> -		}
>  
> -		if (!dso || !map) {
> -			return -ENOMEM;
> +		if (!dso) {
> +			err = -ENOMEM;
> +			goto out;
>  		}
> -
> +		dso->kernel = DSO_SPACE__KERNEL;
> +		map = map__new2(0, dso);
> +		dso__put(dso);
> +		if (!map) {
> +			err = -ENOMEM;
> +			goto out;
> +		}
> +		/*
> +		 * The inserted map has a get on it, we need to put to release
> +		 * the reference count here, but do it after all accesses are
> +		 * done.
> +		 */
> +		put_map = true;
>  		if (event->ksymbol.ksym_type == PERF_RECORD_KSYMBOL_TYPE_OOL) {
>  			dso->binary_type = DSO_BINARY_TYPE__OOL;
>  			dso->data.file_size = event->ksymbol.len;
> @@ -904,9 +912,10 @@ static int machine__process_ksymbol_register(struct machine *machine,
>  		map->start = event->ksymbol.addr;
>  		map->end = map__start(map) + event->ksymbol.len;
>  		err = maps__insert(machine__kernel_maps(machine), map);
> -		map__put(map);
> -		if (err)
> -			return err;
> +		if (err) {
> +			err = -ENOMEM;
> +			goto out;
> +		}
>  
>  		dso__set_loaded(dso);
>  
> @@ -921,10 +930,15 @@ static int machine__process_ksymbol_register(struct machine *machine,
>  	sym = symbol__new(map__map_ip(map, map__start(map)),
>  			  event->ksymbol.len,
>  			  0, 0, event->ksymbol.name);
> -	if (!sym)
> -		return -ENOMEM;
> +	if (!sym) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
>  	dso__insert_symbol(dso, sym);
> -	return 0;
> +out:
> +	if (put_map)
> +		map__put(map);
> +	return err;
>  }
>  
>  static int machine__process_ksymbol_unregister(struct machine *machine,
> @@ -1026,13 +1040,11 @@ static struct map *machine__addnew_module_map(struct machine *machine, u64 start
>  		goto out;
>  
>  	err = maps__insert(machine__kernel_maps(machine), map);
> -
> -	/* Put the map here because maps__insert already got it */
> -	map__put(map);
> -
>  	/* If maps__insert failed, return NULL. */
> -	if (err)
> +	if (err) {
> +		map__put(map);
>  		map = NULL;
> +	}
>  out:
>  	/* put the dso here, corresponding to  machine__findnew_module_dso */
>  	dso__put(dso);
> @@ -1324,6 +1336,7 @@ __machine__create_kernel_maps(struct machine *machine, struct dso *kernel)
>  	/* In case of renewal the kernel map, destroy previous one */
>  	machine__destroy_kernel_maps(machine);
>  
> +	map__put(machine->vmlinux_map);
>  	machine->vmlinux_map = map__new2(0, kernel);
>  	if (machine->vmlinux_map == NULL)
>  		return -ENOMEM;
> @@ -1612,7 +1625,7 @@ static int machine__create_module(void *arg, const char *name, u64 start,
>  	map->end = start + size;
>  
>  	dso__kernel_module_get_build_id(map__dso(map), machine->root_dir);
> -
> +	map__put(map);
>  	return 0;
>  }
>  
> @@ -1658,16 +1671,18 @@ static void machine__set_kernel_mmap(struct machine *machine,
>  static int machine__update_kernel_mmap(struct machine *machine,
>  				     u64 start, u64 end)
>  {
> -	struct map *map = machine__kernel_map(machine);
> +	struct map *orig, *updated;
>  	int err;
>  
> -	map__get(map);
> -	maps__remove(machine__kernel_maps(machine), map);
> +	orig = machine->vmlinux_map;
> +	updated = map__get(orig);
>  
> +	machine->vmlinux_map = updated;
>  	machine__set_kernel_mmap(machine, start, end);
> +	maps__remove(machine__kernel_maps(machine), orig);
> +	err = maps__insert(machine__kernel_maps(machine), updated);
> +	map__put(orig);
>  
> -	err = maps__insert(machine__kernel_maps(machine), map);
> -	map__put(map);
>  	return err;
>  }
>  
> @@ -2294,7 +2309,7 @@ static int add_callchain_ip(struct thread *thread,
>  {
>  	struct map_symbol ms;
>  	struct addr_location al;
> -	int nr_loop_iter = 0;
> +	int nr_loop_iter = 0, err;
>  	u64 iter_cycles = 0;
>  	const char *srcline = NULL;
>  
> @@ -2355,9 +2370,11 @@ static int add_callchain_ip(struct thread *thread,
>  	ms.map = al.map;
>  	ms.sym = al.sym;
>  	srcline = callchain_srcline(&ms, al.addr);
> -	return callchain_cursor_append(cursor, ip, &ms,
> -				       branch, flags, nr_loop_iter,
> -				       iter_cycles, branch_from, srcline);
> +	err = callchain_cursor_append(cursor, ip, &ms,
> +				      branch, flags, nr_loop_iter,
> +				      iter_cycles, branch_from, srcline);
> +	map__put(al.map);
> +	return err;
>  }
>  
>  struct branch_info *sample__resolve_bstack(struct perf_sample *sample,
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index 1fe367e2cf19..acbc37359e06 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -410,7 +410,7 @@ struct map *map__clone(struct map *from)
>  	map = memdup(from, size);
>  	if (map != NULL) {
>  		refcount_set(&map->refcnt, 1);
> -		dso__get(dso);
> +		map->dso = dso__get(dso);
>  	}
>  
>  	return map;

