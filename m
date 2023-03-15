Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58BC6BB99F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 17:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbjCOQYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 12:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbjCOQYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:24:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AE7233EA;
        Wed, 15 Mar 2023 09:24:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5943E61DF7;
        Wed, 15 Mar 2023 16:24:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F48DC433EF;
        Wed, 15 Mar 2023 16:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678897480;
        bh=E0REbR9FxcFN/4t/Gu9D1Nqe64f7ISCtiqVrnCEox6A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nDioRUxXUNocSp4YEO6OKKLKXgmJl4+XCFHXpidio0p3b45HAV4J5SGJ6poR/x1ID
         vdPVKQTSdOn65JccnKAq5Ogt57UhfWXFd4ib57TS0ksEtZ3mWSOvWHcf57C8ptJdkh
         kkexb2UnDw/nNYUwY2gBudpUjkf6xOM6ItpzxwJtlmwscKbjglxYdEpUotd4UqPNjX
         C8bWgpF4wDdxTeQLY66SMVZon9k65vGIoOAC02XSGvinzehYvkn5SCIwssT+yio9TQ
         KhwD7XtrvDex5DuCa6UQSekLzo6k572I3RkZx3EKskYKZjuUFAgcVGEz3jmTJsknA2
         Z4jHPm9QwVxAA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E4CB54049F; Wed, 15 Mar 2023 13:24:37 -0300 (-03)
Date:   Wed, 15 Mar 2023 13:24:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Song Liu <song@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>, Hao Luo <haoluo@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 02/10] perf bpf filter: Implement event sample filtering
Message-ID: <ZBHxRaP7BC+qDzJ/@kernel.org>
References: <20230314234237.3008956-1-namhyung@kernel.org>
 <20230314234237.3008956-3-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314234237.3008956-3-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 14, 2023 at 04:42:29PM -0700, Namhyung Kim escreveu:
> The BPF program will be attached to a perf_event and be triggered when
> it overflows.  It'd iterate the filters map and compare the sample
> value according to the expression.  If any of them fails, the sample
> would be dropped.
> 
> Also it needs to have the corresponding sample data for the expression
> so it compares data->sample_flags with the given value.  To access the
> sample data, it uses the bpf_cast_to_kern_ctx() kfunc which was added
> in v6.2 kernel.
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>


I'm noticing this while building on a debian:11 container:

  GENSKEL /tmp/build/perf/util/bpf_skel/bperf_leader.skel.h
  GENSKEL /tmp/build/perf/util/bpf_skel/bperf_follower.skel.h
  GENSKEL /tmp/build/perf/util/bpf_skel/func_latency.skel.h
  GENSKEL /tmp/build/perf/util/bpf_skel/bpf_prog_profiler.skel.h
  GENSKEL /tmp/build/perf/util/bpf_skel/kwork_trace.skel.h
  GENSKEL /tmp/build/perf/util/bpf_skel/sample_filter.skel.h
libbpf: failed to find BTF for extern 'bpf_cast_to_kern_ctx' [21] section: -2
Error: failed to open BPF object file: No such file or directory
make[2]: *** [Makefile.perf:1085: /tmp/build/perf/util/bpf_skel/sample_filter.skel.h] Error 254
make[2]: *** Deleting file '/tmp/build/perf/util/bpf_skel/sample_filter.skel.h'
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile.perf:236: sub-make] Error 2
make: *** [Makefile:70: all] Error 2
make: Leaving directory '/git/perf-6.3.0-rc1/tools/perf'
+ exit 1
[perfbuilder@five 11]$

- Arnaldo

> ---
>  tools/perf/Makefile.perf                     |   2 +-
>  tools/perf/util/bpf-filter.c                 |  64 ++++++++++
>  tools/perf/util/bpf-filter.h                 |  26 ++--
>  tools/perf/util/bpf_skel/sample-filter.h     |  24 ++++
>  tools/perf/util/bpf_skel/sample_filter.bpf.c | 126 +++++++++++++++++++
>  tools/perf/util/evsel.h                      |   7 +-
>  6 files changed, 236 insertions(+), 13 deletions(-)
>  create mode 100644 tools/perf/util/bpf_skel/sample-filter.h
>  create mode 100644 tools/perf/util/bpf_skel/sample_filter.bpf.c
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index dc9dda09b076..ed6b6a070f79 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -1050,7 +1050,7 @@ SKELETONS := $(SKEL_OUT)/bpf_prog_profiler.skel.h
>  SKELETONS += $(SKEL_OUT)/bperf_leader.skel.h $(SKEL_OUT)/bperf_follower.skel.h
>  SKELETONS += $(SKEL_OUT)/bperf_cgroup.skel.h $(SKEL_OUT)/func_latency.skel.h
>  SKELETONS += $(SKEL_OUT)/off_cpu.skel.h $(SKEL_OUT)/lock_contention.skel.h
> -SKELETONS += $(SKEL_OUT)/kwork_trace.skel.h
> +SKELETONS += $(SKEL_OUT)/kwork_trace.skel.h $(SKEL_OUT)/sample_filter.skel.h
>  
>  $(SKEL_TMP_OUT) $(LIBAPI_OUTPUT) $(LIBBPF_OUTPUT) $(LIBPERF_OUTPUT) $(LIBSUBCMD_OUTPUT) $(LIBSYMBOL_OUTPUT):
>  	$(Q)$(MKDIR) -p $@
> diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
> index c72e35d51240..f20e1bc03778 100644
> --- a/tools/perf/util/bpf-filter.c
> +++ b/tools/perf/util/bpf-filter.c
> @@ -1,10 +1,74 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  #include <stdlib.h>
>  
> +#include <bpf/bpf.h>
> +#include <linux/err.h>
> +#include <internal/xyarray.h>
> +
> +#include "util/debug.h"
> +#include "util/evsel.h"
> +
>  #include "util/bpf-filter.h"
>  #include "util/bpf-filter-flex.h"
>  #include "util/bpf-filter-bison.h"
>  
> +#include "bpf_skel/sample-filter.h"
> +#include "bpf_skel/sample_filter.skel.h"
> +
> +#define FD(e, x, y) (*(int *)xyarray__entry(e->core.fd, x, y))
> +
> +int perf_bpf_filter__prepare(struct evsel *evsel)
> +{
> +	int i, x, y, fd;
> +	struct sample_filter_bpf *skel;
> +	struct bpf_program *prog;
> +	struct bpf_link *link;
> +	struct perf_bpf_filter_expr *expr;
> +
> +	skel = sample_filter_bpf__open_and_load();
> +	if (!skel) {
> +		pr_err("Failed to load perf sample-filter BPF skeleton\n");
> +		return -1;
> +	}
> +
> +	i = 0;
> +	fd = bpf_map__fd(skel->maps.filters);
> +	list_for_each_entry(expr, &evsel->bpf_filters, list) {
> +		struct perf_bpf_filter_entry entry = {
> +			.op = expr->op,
> +			.flags = expr->sample_flags,
> +			.value = expr->val,
> +		};
> +		bpf_map_update_elem(fd, &i, &entry, BPF_ANY);
> +		i++;
> +	}
> +
> +	prog = skel->progs.perf_sample_filter;
> +	for (x = 0; x < xyarray__max_x(evsel->core.fd); x++) {
> +		for (y = 0; y < xyarray__max_y(evsel->core.fd); y++) {
> +			link = bpf_program__attach_perf_event(prog, FD(evsel, x, y));
> +			if (IS_ERR(link)) {
> +				pr_err("Failed to attach perf sample-filter program\n");
> +				return PTR_ERR(link);
> +			}
> +		}
> +	}
> +	evsel->bpf_skel = skel;
> +	return 0;
> +}
> +
> +int perf_bpf_filter__destroy(struct evsel *evsel)
> +{
> +	struct perf_bpf_filter_expr *expr, *tmp;
> +
> +	list_for_each_entry_safe(expr, tmp, &evsel->bpf_filters, list) {
> +		list_del(&expr->list);
> +		free(expr);
> +	}
> +	sample_filter_bpf__destroy(evsel->bpf_skel);
> +	return 0;
> +}
> +
>  struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(unsigned long sample_flags,
>  						       enum perf_bpf_filter_op op,
>  						       unsigned long val)
> diff --git a/tools/perf/util/bpf-filter.h b/tools/perf/util/bpf-filter.h
> index 93a0d3de038c..eb8e1ac43cdf 100644
> --- a/tools/perf/util/bpf-filter.h
> +++ b/tools/perf/util/bpf-filter.h
> @@ -4,15 +4,7 @@
>  
>  #include <linux/list.h>
>  
> -enum perf_bpf_filter_op {
> -	PBF_OP_EQ,
> -	PBF_OP_NEQ,
> -	PBF_OP_GT,
> -	PBF_OP_GE,
> -	PBF_OP_LT,
> -	PBF_OP_LE,
> -	PBF_OP_AND,
> -};
> +#include "bpf_skel/sample-filter.h"
>  
>  struct perf_bpf_filter_expr {
>  	struct list_head list;
> @@ -21,16 +13,30 @@ struct perf_bpf_filter_expr {
>  	unsigned long val;
>  };
>  
> +struct evsel;
> +
>  #ifdef HAVE_BPF_SKEL
>  struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(unsigned long sample_flags,
>  						       enum perf_bpf_filter_op op,
>  						       unsigned long val);
>  int perf_bpf_filter__parse(struct list_head *expr_head, const char *str);
> +int perf_bpf_filter__prepare(struct evsel *evsel);
> +int perf_bpf_filter__destroy(struct evsel *evsel);
> +
>  #else /* !HAVE_BPF_SKEL */
> +
>  static inline int perf_bpf_filter__parse(struct list_head *expr_head __maybe_unused,
>  					 const char *str __maybe_unused)
>  {
> -	return -ENOSYS;
> +	return -EOPNOTSUPP;
> +}
> +static inline int perf_bpf_filter__prepare(struct evsel *evsel __maybe_unused)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static inline int perf_bpf_filter__destroy(struct evsel *evsel __maybe_unused)
> +{
> +	return -EOPNOTSUPP;
>  }
>  #endif /* HAVE_BPF_SKEL*/
>  #endif /* PERF_UTIL_BPF_FILTER_H */
> diff --git a/tools/perf/util/bpf_skel/sample-filter.h b/tools/perf/util/bpf_skel/sample-filter.h
> new file mode 100644
> index 000000000000..862060bfda14
> --- /dev/null
> +++ b/tools/perf/util/bpf_skel/sample-filter.h
> @@ -0,0 +1,24 @@
> +#ifndef PERF_UTIL_BPF_SKEL_SAMPLE_FILTER_H
> +#define PERF_UTIL_BPF_SKEL_SAMPLE_FILTER_H
> +
> +#define MAX_FILTERS  32
> +
> +/* supported filter operations */
> +enum perf_bpf_filter_op {
> +	PBF_OP_EQ,
> +	PBF_OP_NEQ,
> +	PBF_OP_GT,
> +	PBF_OP_GE,
> +	PBF_OP_LT,
> +	PBF_OP_LE,
> +	PBF_OP_AND
> +};
> +
> +/* BPF map entry for filtering */
> +struct perf_bpf_filter_entry {
> +	enum perf_bpf_filter_op op;
> +	__u64 flags;
> +	__u64 value;
> +};
> +
> +#endif /* PERF_UTIL_BPF_SKEL_SAMPLE_FILTER_H */
> \ No newline at end of file
> diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
> new file mode 100644
> index 000000000000..c07256279c3e
> --- /dev/null
> +++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
> @@ -0,0 +1,126 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +// Copyright (c) 2023 Google
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_core_read.h>
> +
> +#include "sample-filter.h"
> +
> +/* BPF map that will be filled by user space */
> +struct filters {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__type(key, int);
> +	__type(value, struct perf_bpf_filter_entry);
> +	__uint(max_entries, MAX_FILTERS);
> +} filters SEC(".maps");
> +
> +int dropped;
> +
> +void *bpf_cast_to_kern_ctx(void *) __ksym;
> +
> +/* new kernel perf_sample_data definition */
> +struct perf_sample_data___new {
> +	__u64 sample_flags;
> +} __attribute__((preserve_access_index));
> +
> +/* helper function to return the given perf sample data */
> +static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
> +				    struct perf_bpf_filter_entry *entry)
> +{
> +	struct perf_sample_data___new *data = (void *)kctx->data;
> +
> +	if (!bpf_core_field_exists(data->sample_flags) ||
> +	    (data->sample_flags & entry->flags) == 0)
> +		return 0;
> +
> +	switch (entry->flags) {
> +	case PERF_SAMPLE_IP:
> +		return kctx->data->ip;
> +	case PERF_SAMPLE_ID:
> +		return kctx->data->id;
> +	case PERF_SAMPLE_TID:
> +		return kctx->data->tid_entry.tid;
> +	case PERF_SAMPLE_CPU:
> +		return kctx->data->cpu_entry.cpu;
> +	case PERF_SAMPLE_TIME:
> +		return kctx->data->time;
> +	case PERF_SAMPLE_ADDR:
> +		return kctx->data->addr;
> +	case PERF_SAMPLE_PERIOD:
> +		return kctx->data->period;
> +	case PERF_SAMPLE_TRANSACTION:
> +		return kctx->data->txn;
> +	case PERF_SAMPLE_WEIGHT:
> +		return kctx->data->weight.full;
> +	case PERF_SAMPLE_PHYS_ADDR:
> +		return kctx->data->phys_addr;
> +	case PERF_SAMPLE_CODE_PAGE_SIZE:
> +		return kctx->data->code_page_size;
> +	case PERF_SAMPLE_DATA_PAGE_SIZE:
> +		return kctx->data->data_page_size;
> +	default:
> +		break;
> +	}
> +	return 0;
> +}
> +
> +/* BPF program to be called from perf event overflow handler */
> +SEC("perf_event")
> +int perf_sample_filter(void *ctx)
> +{
> +	struct bpf_perf_event_data_kern *kctx;
> +	struct perf_bpf_filter_entry *entry;
> +	__u64 sample_data;
> +	int i;
> +
> +	kctx = bpf_cast_to_kern_ctx(ctx);
> +
> +	for (i = 0; i < MAX_FILTERS; i++) {
> +		int key = i; /* needed for verifier :( */
> +
> +		entry = bpf_map_lookup_elem(&filters, &key);
> +		if (entry == NULL)
> +			break;
> +		sample_data = perf_get_sample(kctx, entry);
> +
> +		switch (entry->op) {
> +		case PBF_OP_EQ:
> +			if (!(sample_data == entry->value))
> +				goto drop;
> +			break;
> +		case PBF_OP_NEQ:
> +			if (!(sample_data != entry->value))
> +				goto drop;
> +			break;
> +		case PBF_OP_GT:
> +			if (!(sample_data > entry->value))
> +				goto drop;
> +			break;
> +		case PBF_OP_GE:
> +			if (!(sample_data >= entry->value))
> +				goto drop;
> +			break;
> +		case PBF_OP_LT:
> +			if (!(sample_data < entry->value))
> +				goto drop;
> +			break;
> +		case PBF_OP_LE:
> +			if (!(sample_data <= entry->value))
> +				goto drop;
> +			break;
> +		case PBF_OP_AND:
> +			if (!(sample_data & entry->value))
> +				goto drop;
> +			break;
> +		}
> +	}
> +	/* generate sample data */
> +	return 1;
> +
> +drop:
> +	__sync_fetch_and_add(&dropped, 1);
> +	return 0;
> +}
> +
> +char LICENSE[] SEC("license") = "Dual BSD/GPL";
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index c272c06565c0..68072ec655ce 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -150,8 +150,10 @@ struct evsel {
>  	 */
>  	struct bpf_counter_ops	*bpf_counter_ops;
>  
> -	/* for perf-stat -b */
> -	struct list_head	bpf_counter_list;
> +	union {
> +		struct list_head	bpf_counter_list; /* for perf-stat -b */
> +		struct list_head	bpf_filters; /* for perf-record --filter */
> +	};
>  
>  	/* for perf-stat --use-bpf */
>  	int			bperf_leader_prog_fd;
> @@ -159,6 +161,7 @@ struct evsel {
>  	union {
>  		struct bperf_leader_bpf *leader_skel;
>  		struct bperf_follower_bpf *follower_skel;
> +		void *bpf_skel;
>  	};
>  	unsigned long		open_flags;
>  	int			precise_ip_original;
> -- 
> 2.40.0.rc1.284.g88254d51c5-goog
> 

-- 

- Arnaldo
