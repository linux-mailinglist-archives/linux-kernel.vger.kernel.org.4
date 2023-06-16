Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CD7732515
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 04:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240240AbjFPCPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 22:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjFPCPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 22:15:09 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBEC296A;
        Thu, 15 Jun 2023 19:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686881707; x=1718417707;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=i6dFmETFOd1K689FX6P/EGGimE+NEreeX3496pfSF/A=;
  b=LX5UWVqtBSVstS2/CVRitqeBvaLQMOlZV5l3ryiBofSIMJ8M04hRKlTH
   3i7Pe8MkFAMuVR65vDZBWxdqRcEhK/b/aW6slP8vIu2vko0v0aBv1BJKM
   ymJDG5Bpj4JE51MU/pa7YD5RnYxLxL8OpikbEtNpWujsMEgo9E01zUCm5
   hVZ0CCQUJz1TE9zWFANx4WlromfKCNhWhwVAfmq/89YTOVQSqTVJ3iOEn
   qNg7CV2mlSC2/R1rOoS2LbtDhYsmAYVG41/27XfXS1Cnny4i1k911eAU+
   pdwm2OBneSrBlQJDWBeTGL3jh4dS+ScaCENFMPhE4D14W/0Nx+qQDkU0E
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="343833538"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="343833538"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 19:15:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="706903939"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="706903939"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 15 Jun 2023 19:15:06 -0700
Received: from [10.209.76.72] (kliang2-mobl1.ccr.corp.intel.com [10.209.76.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id AE435580919;
        Thu, 15 Jun 2023 19:15:05 -0700 (PDT)
Message-ID: <70597602-99bd-f72c-1b89-334b5a9453d1@linux.intel.com>
Date:   Thu, 15 Jun 2023 22:15:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH V3 4/8] perf metrics: Sort the Default metricgroup
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, eranian@google.com, ahmad.yasin@intel.com
References: <20230615135315.3662428-1-kan.liang@linux.intel.com>
 <20230615135315.3662428-5-kan.liang@linux.intel.com>
 <CAP-5=fU9qZ8jb=etO0U3tpG3XuvZ_fX5CExVL_gQag55Q8bPfA@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fU9qZ8jb=etO0U3tpG3XuvZ_fX5CExVL_gQag55Q8bPfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-06-15 6:05 p.m., Ian Rogers wrote:
> On Thu, Jun 15, 2023 at 6:54 AM <kan.liang@linux.intel.com> wrote:
>>
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The new default mode will print the metrics as a metric group. The
>> metrics from the same metric group must be adjacent to each other in the
>> metric list. But the metric_list_cmp() sorts metrics by the number of
>> events.
>>
>> Add a new sort for the Default metricgroup, which sorts by
>> default_metricgroup_name and metric_name.
>>
>> Add is_default in the struct metric_event to indicate that it's from
>> the Default metricgroup.
>>
>> Store the displayed metricgroup name of the Default metricgroup into
>> the metric expr for output.
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>  tools/perf/util/metricgroup.c | 37 +++++++++++++++++++++++++++++++++++
>>  tools/perf/util/metricgroup.h |  3 +++
>>  2 files changed, 40 insertions(+)
>>
>> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
>> index 8b19644ade7d..e20adbdd5b56 100644
>> --- a/tools/perf/util/metricgroup.c
>> +++ b/tools/perf/util/metricgroup.c
>> @@ -79,6 +79,7 @@ static struct rb_node *metric_event_new(struct rblist *rblist __maybe_unused,
>>                 return NULL;
>>         memcpy(me, entry, sizeof(struct metric_event));
>>         me->evsel = ((struct metric_event *)entry)->evsel;
>> +       me->is_default = false;
>>         INIT_LIST_HEAD(&me->head);
>>         return &me->nd;
>>  }
>> @@ -1160,6 +1161,25 @@ static int metric_list_cmp(void *priv __maybe_unused, const struct list_head *l,
>>         return right_count - left_count;
>>  }
>>
>> +/**
>> + * default_metricgroup_cmp - Implements complex key for the Default metricgroup
>> + *                          that first sorts by default_metricgroup_name, then
>> + *                          metric_name.
>> + */
>> +static int default_metricgroup_cmp(void *priv __maybe_unused,
>> +                                  const struct list_head *l,
>> +                                  const struct list_head *r)
>> +{
>> +       const struct metric *left = container_of(l, struct metric, nd);
>> +       const struct metric *right = container_of(r, struct metric, nd);
>> +       int diff = strcmp(right->default_metricgroup_name, left->default_metricgroup_name);
>> +
>> +       if (diff)
>> +               return diff;
>> +
>> +       return strcmp(right->metric_name, left->metric_name);
>> +}
>> +
>>  struct metricgroup__add_metric_data {
>>         struct list_head *list;
>>         const char *pmu;
>> @@ -1515,6 +1535,7 @@ static int parse_groups(struct evlist *perf_evlist,
>>         LIST_HEAD(metric_list);
>>         struct metric *m;
>>         bool tool_events[PERF_TOOL_MAX] = {false};
>> +       bool is_default = !strcmp(str, "Default");
>>         int ret;
>>
>>         if (metric_events_list->nr_entries == 0)
>> @@ -1549,6 +1570,9 @@ static int parse_groups(struct evlist *perf_evlist,
>>                         goto out;
>>         }
>>
>> +       if (is_default)
>> +               list_sort(NULL, &metric_list, default_metricgroup_cmp);
>> +
>>         list_for_each_entry(m, &metric_list, nd) {
>>                 struct metric_event *me;
>>                 struct evsel **metric_events;
>> @@ -1637,6 +1661,19 @@ static int parse_groups(struct evlist *perf_evlist,
>>                 expr->metric_unit = m->metric_unit;
>>                 expr->metric_events = metric_events;
>>                 expr->runtime = m->pctx->sctx.runtime;
>> +               if (m->pmu && strcmp(m->pmu, "cpu")) {
> 
> This shouldn't compare with a PMU name like this. What happens for
> memory bandwidth which could be logically with a memory controller
> PMU?
> 
>> +                       char *name;
>> +
>> +                       if (asprintf(&name, "%s (%s)", m->default_metricgroup_name, m->pmu) < 0)
>> +                               expr->default_metricgroup_name = m->default_metricgroup_name;
> 
> Who owns the string in this case? Can't you end up with
> default_metricgroup_name pointing to a freed string? I think this
> feels a lot more like output code, so I'm unclear why we're setting it
> up in the metric.

Yes, we can decide when outputing the name. The below patch move it to
the output code. I will do the modification in V4.

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index acf86b15ee49..a6a5ed44a679 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1661,17 +1661,8 @@ static int parse_groups(struct evlist *perf_evlist,
 		expr->metric_unit = m->metric_unit;
 		expr->metric_events = metric_events;
 		expr->runtime = m->pctx->sctx.runtime;
-		if (m->pmu && strcmp(m->pmu, "cpu")) {
-			char *name;
-
-			if (asprintf(&name, "%s (%s)", m->default_metricgroup_name, m->pmu) < 0)
-				expr->default_metricgroup_name = m->default_metricgroup_name;
-			else
-				expr->default_metricgroup_name = name;
-		} else
-			expr->default_metricgroup_name = m->default_metricgroup_name;
-		if (is_default)
-			me->is_default = true;
+		expr->default_metricgroup_name = m->default_metricgroup_name;
+		me->is_default = is_default;
 		list_add(&expr->nd, &me->head);
 	}

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index b25974670d30..1440b0fc7d00 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -539,6 +539,42 @@ double test_generic_metric(struct metric_expr
*mexp, int aggr_idx)
 	return ratio;
 }

+static void perf_stat__print_metricgroup_header(struct perf_stat_config
*config,
+						struct evsel *evsel,
+						void *ctxp,
+						const char *name,
+						struct perf_stat_output_ctx *out)
+{
+	bool need_full_name = perf_pmus__num_core_pmus() > 1;
+	static const char *last_name;
+	static const char *last_pmu;
+	char full_name[64];
+
+	/*
+	 * A metricgroup may have several metric events,
+	 * e.g.,TopdownL1 on e-core of ADL.
+	 * The name has been output by the first metric
+	 * event. Only align with other metics from
+	 * different metric events.
+	 */
+	if (last_name && !strcmp(last_name, name)) {
+		if (!need_full_name || !strcmp(last_pmu, evsel->pmu_name)) {
+			out->print_metricgroup_header(config, ctxp, NULL);
+			return;
+		}
+	}
+
+	if (need_full_name)
+		scnprintf(full_name, sizeof(full_name), "%s (%s)", name,
evsel->pmu_name);
+	else
+		scnprintf(full_name, sizeof(full_name), "%s", name);
+
+	out->print_metricgroup_header(config, ctxp, full_name);
+
+	last_name = name;
+	last_pmu = evsel->pmu_name;
+}
+
 /**
  * perf_stat__print_shadow_stats_metricgroup - Print out metrics
associated with the evsel
  *					       For the non-default, all metrics associated
@@ -563,7 +599,6 @@ void
*perf_stat__print_shadow_stats_metricgroup(struct perf_stat_config *config,
 	void *ctxp = out->ctx;
 	bool header_printed = false;
 	const char *name = NULL;
-	static const char *last_name;

 	me = metricgroup__lookup(metric_events, evsel, false);
 	if (me == NULL)
@@ -588,20 +623,8 @@ void
*perf_stat__print_shadow_stats_metricgroup(struct perf_stat_config *config,
 			/* Only print the name of the metricgroup once */
 			if (!header_printed) {
 				header_printed = true;
-				if (!last_name || strcmp(last_name, name)) {
-					/* Print out the name for the new metricgroup. */
-					out->print_metricgroup_header(config, ctxp, name);
-					last_name = name;
-				} else if (!strcmp(last_name, name)) {
-					/*
-					 * A metricgroup may have several metric events,
-					 * e.g.,TopdownL1 on e-core of ADL.
-					 * The name has been output by the first metric
-					 * event. Only align with other metics from
-					 * different metric events.
-					 */
-					out->print_metricgroup_header(config, ctxp, NULL);
-				}
+				perf_stat__print_metricgroup_header(config, evsel, ctxp,
+								    name, out);
 			}
 		}



> 
>> +                       else {
>> +                               expr->default_metricgroup_name = strdup(name);
> 
> But name was just allocated, why strdup?
> 
> This is still leaking it is just the strdup now leaks and not the asprintf:
> ```
> ==2495793==ERROR: LeakSanitizer: detected memory leaks
> 
> Direct leak of 6199 byte(s) in 340 object(s) allocated from:
>    #0 0x7f175c27077b in __interceptor_strdup
> ../../../../src/libsanitizer/asan/asan_interceptors.cp
> p:439
>    #1 0x5596323b2a28 in parse_groups util/metricgroup.c:1670
>    #2 0x5596323b2f08 in metricgroup__parse_groups_test util/metricgroup.c:1721
>    #3 0x5596322992bf in test__parsing_callback tests/pmu-events.c:837
>    #4 0x559632658ac6 in pmu_metrics_table_for_each_metric
> /tmp/perf/pmu-events/pmu-events.c:61641
>    #5 0x5596326590fc in pmu_for_each_core_metric
> /tmp/perf/pmu-events/pmu-events.c:61742
>    #6 0x559632299b7c in test__parsing tests/pmu-events.c:898
>    #7 0x5596322663b0 in run_test tests/builtin-test.c:236
>    #8 0x559632266655 in test_and_print tests/builtin-test.c:265
>    #9 0x55963226766f in __cmd_test tests/builtin-test.c:436
>    #10 0x559632268953 in cmd_test tests/builtin-test.c:559
>    #11 0x5596322f5916 in run_builtin
> /home/irogers/kernel.org/tools/perf/perf.c:323
>    #12 0x5596322f5e87 in handle_internal_command
> /home/irogers/kernel.org/tools/perf/perf.c:377
>    #13 0x5596322f624f in run_argv /home/irogers/kernel.org/tools/perf/perf.c:421
>    #14 0x5596322f67b7 in main /home/irogers/kernel.org/tools/perf/perf.c:537
>    #15 0x7f175bebf189 in __libc_start_call_main
> ../sysdeps/nptl/libc_start_call_main.h:58
> 
> SUMMARY: AddressSanitizer: 6199 byte(s) leaked in 340 allocation(s).
> ```
> 
>> +                               free(name);
>> +                       }
>> +               } else
>> +                       expr->default_metricgroup_name = m->default_metricgroup_name;
> 
> Who owns the string in this case? Can't you end up with
> default_metricgroup_name pointing to a freed string?
> 
> I spent some time trying to rationalize this to add as a patch, but
> then the more I look at things like the strcmp with "cpu" my changes
> were going to modify behavior in a way that would need you to test and
> sign-off, so I'll hold back.

THe "cpu" check will be gone in v4.

> 
> To test with leak/address sanitizer use the tmp.perf-tools-next
> branch, I build with:
> $ make -C tools/perf O=/tmp/perf DEBUG=1 EXTRA_CFLAGS="-O0 -g
> -fno-omit-frame-pointer -DREFCNT_CHECKING=1 -fsanitize=address"
> NO_LIBTRACEEVENT=1
> but the only bit you really need is "-fsanitize=address" which both
> clang and gcc support.
> 
> Address sanitizer from apt-cache is:
> libasan6 - AddressSanitizer -- a fast memory error detector
> 
> Fedora and other distro.s have it too.
> 

I still cannot reproduce the memory leaks even with the above command.
I will remove the code in v4, so the memory leaks should be gone.

Thanks,
Kan

> 
>> +               if (is_default)
>> +                       me->is_default = true;
>>                 list_add(&expr->nd, &me->head);
>>         }
>>
>> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
>> index bf18274c15df..d5325c6ec8e1 100644
>> --- a/tools/perf/util/metricgroup.h
>> +++ b/tools/perf/util/metricgroup.h
>> @@ -22,6 +22,7 @@ struct cgroup;
>>  struct metric_event {
>>         struct rb_node nd;
>>         struct evsel *evsel;
>> +       bool is_default; /* the metric evsel from the Default metricgroup */
>>         struct list_head head; /* list of metric_expr */
>>  };
>>
>> @@ -55,6 +56,8 @@ struct metric_expr {
>>          * more human intelligible) and then add "MiB" afterward when displayed.
>>          */
>>         const char *metric_unit;
>> +       /** Displayed metricgroup name of the Default metricgroup */
>> +       const char *default_metricgroup_name;
>>         /** Null terminated array of events used by the metric. */
>>         struct evsel **metric_events;
>>         /** Null terminated array of referenced metrics. */
>> --
>> 2.35.1
>>
