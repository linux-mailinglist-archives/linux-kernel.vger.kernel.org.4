Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F61A6426F6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 11:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiLEKwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 05:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiLEKwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 05:52:34 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE16D14D00;
        Mon,  5 Dec 2022 02:52:31 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B58xmL8002737;
        Mon, 5 Dec 2022 10:52:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type : subject :
 from : in-reply-to : date : cc : message-id : references : to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=imOFTlk9ng8LITWfvTK2IjMq0gdjK4WAHHoi9BFWgyw=;
 b=BsiwH0NFUBwU8szli3/QTuqcVbCEiF6W4bOfOE0kAh8sXAYPBO2Kp7lscxPG6+Krje7Y
 ChM0SKFwDN76gvQNdlNFvX99Ws0kMHaTgYbN97gopFa+xgtg91ud1oFNijYfg/OEa+C3
 F50IBWqwSowsu5yZGr2RjsFwTV5qcdJXW7dNb0LWyv0XBx39TH4xW1Vexm2p82i92tA7
 ADt7HjwHCCJAUSRDnxar9AjzAwQMWJxV4/6YAdpPihK5DjGd6gqw9tFFKVaLzY/bRGnX
 pWX7nA7xj233ciBjz56AB6R6ocEMw1UaJyEWd30lK0OdrVwaiX6dMSEEnskXszS/QOXD cg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m8ga703rw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Dec 2022 10:52:09 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2B59Tv38002292;
        Mon, 5 Dec 2022 10:52:09 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m8ga703qw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Dec 2022 10:52:08 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2B5ApqZX007538;
        Mon, 5 Dec 2022 10:52:06 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3m7x3a2px6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Dec 2022 10:52:06 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2B5Aq4q965667504
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Dec 2022 10:52:04 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 509AFA405F;
        Mon,  5 Dec 2022 10:52:04 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07B78A4054;
        Mon,  5 Dec 2022 10:52:01 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.70.158])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  5 Dec 2022 10:52:00 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Subject: Re: [PATCH 18/20] perf stat: Display event stats using aggr counts
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20221018020227.85905-19-namhyung@kernel.org>
Date:   Mon, 5 Dec 2022 16:21:58 +0530
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Message-Id: <153310C5-413D-4079-9970-EDCEE2DF3340@linux.vnet.ibm.com>
References: <20221018020227.85905-1-namhyung@kernel.org>
 <20221018020227.85905-19-namhyung@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: F5rvoLXZzDyh2rD3ctwsHDGbNlUtgL4N
X-Proofpoint-ORIG-GUID: wlDNIZ1AxHAXPPGAHCmMoTO3ibfIf2Aw
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212050084
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 18-Oct-2022, at 7:32 AM, Namhyung Kim <namhyung@kernel.org> wrote:
>=20
> Now aggr counts are ready for use.  Convert the display routines to use
> the aggr counts and update the shadow stat with them.  It doesn't need
> to aggregate counts or collect aliases anymore during the display.  Get
> rid of now unused struct perf_aggr_thread_value.
>=20
> Note that there's a difference in the display order among the aggr mode.
> For per-core/die/socket/node aggregation, it shows relevant events in
> the same unit together, whereas global/thread/no aggregation it shows
> the same events for different units together.  So it still uses separate
> codes to display them due to the ordering.
>=20
> One more thing to note is that it breaks per-core event display for now.
> The next patch will fix it to have identical output as of now.
>=20
> Acked-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
> tools/perf/util/stat-display.c | 421 ++++-----------------------------
> tools/perf/util/stat.c         |   5 -
> tools/perf/util/stat.h         |   9 -
> 3 files changed, 49 insertions(+), 386 deletions(-)
>=20
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-displa=
y.c
> index 4113aa86772f..bfae2784609c 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -442,31 +442,6 @@ static void print_metric_header(struct perf_stat_con=
fig *config,
> 		fprintf(os->fh, "%*s ", config->metric_only_len, unit);
> }
>=20
> -static int first_shadow_map_idx(struct perf_stat_config *config,
> -				struct evsel *evsel, const struct aggr_cpu_id *id)
> -{
> -	struct perf_cpu_map *cpus =3D evsel__cpus(evsel);
> -	struct perf_cpu cpu;
> -	int idx;
> -
> -	if (config->aggr_mode =3D=3D AGGR_NONE)
> -		return perf_cpu_map__idx(cpus, id->cpu);
> -
> -	if (config->aggr_mode =3D=3D AGGR_THREAD)
> -		return id->thread_idx;
> -
> -	if (!config->aggr_get_id)
> -		return 0;
> -
> -	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
> -		struct aggr_cpu_id cpu_id =3D config->aggr_get_id(config, cpu);
> -
> -		if (aggr_cpu_id__equal(&cpu_id, id))
> -			return idx;
> -	}
> -	return 0;
> -}
> -
> static void abs_printout(struct perf_stat_config *config,
> 			 struct aggr_cpu_id id, int nr, struct evsel *evsel, double avg)
> {
> @@ -537,7 +512,7 @@ static bool is_mixed_hw_group(struct evsel *counter)
> static void printout(struct perf_stat_config *config, struct aggr_cpu_id =
id, int nr,
> 		     struct evsel *counter, double uval,
> 		     char *prefix, u64 run, u64 ena, double noise,
> -		     struct runtime_stat *st)
> +		     struct runtime_stat *st, int map_idx)
> {
> 	struct perf_stat_output_ctx out;
> 	struct outstate os =3D {
> @@ -648,8 +623,7 @@ static void printout(struct perf_stat_config *config,=
 struct aggr_cpu_id id, int
> 		print_running(config, run, ena);
> 	}
>=20
> -	perf_stat__print_shadow_stats(config, counter, uval,
> -				first_shadow_map_idx(config, counter, &id),
> +	perf_stat__print_shadow_stats(config, counter, uval, map_idx,
> 				&out, &config->metric_events, st);
> 	if (!config->csv_output && !config->metric_only && !config->json_output)=
 {
> 		print_noise(config, counter, noise);
> @@ -657,34 +631,6 @@ static void printout(struct perf_stat_config *config=
, struct aggr_cpu_id id, int
> 	}
> }
>=20
> -static void aggr_update_shadow(struct perf_stat_config *config,
> -			       struct evlist *evlist)
> -{
> -	int idx, s;
> -	struct perf_cpu cpu;
> -	struct aggr_cpu_id s2, id;
> -	u64 val;
> -	struct evsel *counter;
> -	struct perf_cpu_map *cpus;
> -
> -	for (s =3D 0; s < config->aggr_map->nr; s++) {
> -		id =3D config->aggr_map->map[s];
> -		evlist__for_each_entry(evlist, counter) {
> -			cpus =3D evsel__cpus(counter);
> -			val =3D 0;
> -			perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
> -				s2 =3D config->aggr_get_id(config, cpu);
> -				if (!aggr_cpu_id__equal(&s2, &id))
> -					continue;
> -				val +=3D perf_counts(counter->counts, idx, 0)->val;
> -			}
> -			perf_stat__update_shadow_stats(counter, val,
> -					first_shadow_map_idx(config, counter, &id),
> -					&rt_stat);
> -		}
> -	}
> -}
> -
> static void uniquify_event_name(struct evsel *counter)
> {
> 	char *new_name;
> @@ -721,137 +667,51 @@ static void uniquify_event_name(struct evsel *coun=
ter)
> 	counter->uniquified_name =3D true;
> }
>=20
> -static void collect_all_aliases(struct perf_stat_config *config, struct =
evsel *counter,
> -			    void (*cb)(struct perf_stat_config *config, struct evsel *counter=
, void *data,
> -				       bool first),
> -			    void *data)
> +static bool hybrid_uniquify(struct evsel *evsel, struct perf_stat_config=
 *config)
> {
> -	struct evlist *evlist =3D counter->evlist;
> -	struct evsel *alias;
> -
> -	alias =3D list_prepare_entry(counter, &(evlist->core.entries), core.nod=
e);
> -	list_for_each_entry_continue (alias, &evlist->core.entries, core.node) {
> -		/* Merge events with the same name, etc. but on different PMUs. */
> -		if (!strcmp(evsel__name(alias), evsel__name(counter)) &&
> -			alias->scale =3D=3D counter->scale &&
> -			alias->cgrp =3D=3D counter->cgrp &&
> -			!strcmp(alias->unit, counter->unit) &&
> -			evsel__is_clock(alias) =3D=3D evsel__is_clock(counter) &&
> -			strcmp(alias->pmu_name, counter->pmu_name)) {
> -			alias->merged_stat =3D true;
> -			cb(config, alias, data, false);
> -		}
> -	}
> +	return evsel__is_hybrid(evsel) && !config->hybrid_merge;
> }
>=20
> -static bool hybrid_merge(struct evsel *counter, struct perf_stat_config =
*config,
> -			 bool check)
> +static void uniquify_counter(struct perf_stat_config *config, struct evs=
el *counter)
> {
> -	if (evsel__is_hybrid(counter)) {
> -		if (check)
> -			return config->hybrid_merge;
> -		else
> -			return !config->hybrid_merge;
> -	}
> -
> -	return false;
> -}
> -
> -static bool collect_data(struct perf_stat_config *config, struct evsel *=
counter,
> -			    void (*cb)(struct perf_stat_config *config, struct evsel *counter=
, void *data,
> -				       bool first),
> -			    void *data)
> -{
> -	if (counter->merged_stat)
> -		return false;
> -	cb(config, counter, data, true);
> -	if (config->no_merge || hybrid_merge(counter, config, false))
> +	if (config->no_merge || hybrid_uniquify(counter, config))
> 		uniquify_event_name(counter);
> -	else if (counter->auto_merge_stats || hybrid_merge(counter, config, tru=
e))
> -		collect_all_aliases(config, counter, cb, data);
> -	return true;
> -}
> -
> -struct aggr_data {
> -	u64 ena, run, val;
> -	struct aggr_cpu_id id;
> -	int nr;
> -	int cpu_map_idx;
> -};
> -
> -static void aggr_cb(struct perf_stat_config *config,
> -		    struct evsel *counter, void *data, bool first)
> -{
> -	struct aggr_data *ad =3D data;
> -	int idx;
> -	struct perf_cpu cpu;
> -	struct perf_cpu_map *cpus;
> -	struct aggr_cpu_id s2;
> -
> -	cpus =3D evsel__cpus(counter);
> -	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
> -		struct perf_counts_values *counts;
> -
> -		s2 =3D config->aggr_get_id(config, cpu);
> -		if (!aggr_cpu_id__equal(&s2, &ad->id))
> -			continue;
> -		if (first)
> -			ad->nr++;
> -		counts =3D perf_counts(counter->counts, idx, 0);
> -		/*
> -		 * When any result is bad, make them all to give
> -		 * consistent output in interval mode.
> -		 */
> -		if (counts->ena =3D=3D 0 || counts->run =3D=3D 0 ||
> -		    counter->counts->scaled =3D=3D -1) {
> -			ad->ena =3D 0;
> -			ad->run =3D 0;
> -			break;
> -		}
> -		ad->val +=3D counts->val;
> -		ad->ena +=3D counts->ena;
> -		ad->run +=3D counts->run;
> -	}
> }
>=20
> static void print_counter_aggrdata(struct perf_stat_config *config,
> 				   struct evsel *counter, int s,
> 				   char *prefix, bool metric_only,
> -				   bool *first, struct perf_cpu cpu)
> +				   bool *first)
> {
> -	struct aggr_data ad;
> 	FILE *output =3D config->output;
> 	u64 ena, run, val;
> -	int nr;
> -	struct aggr_cpu_id id;
> 	double uval;
> +	struct perf_stat_evsel *ps =3D counter->stats;
> +	struct perf_stat_aggr *aggr =3D &ps->aggr[s];
> +	struct aggr_cpu_id id =3D config->aggr_map->map[s];
> +	double avg =3D aggr->counts.val;
>=20
> -	ad.id =3D id =3D config->aggr_map->map[s];
> -	ad.val =3D ad.ena =3D ad.run =3D 0;
> -	ad.nr =3D 0;
> -	if (!collect_data(config, counter, aggr_cb, &ad))
> +	if (counter->supported && aggr->nr =3D=3D 0)
> 		return;

Hi Namhyung,

Observed one issue with this change in tmp.perf/core branch of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/acme/linux.git
Patch link: https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/=
commit/?h=3Dtmp.perf/core&id=3D91f85f98da7ab8c32105f42dd03884c01ec4498f

If we have multiple events in a group and if all events in that group can't=
 go in at once, the group will fail to schedule.
The perf stat result used to have status of all events in group.=20

Example result from powerpc:
	# perf stat -e '{r1001e,r401e0,r4c010}' <workload>
	Performance counter stats for 'workload=E2=80=99:

	     <not counted>      r1001e=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
	     <not counted>      r401e0=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
	   <not supported>      r4c010=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20

But after this change, it shows only the event which broke the constraint.

	# ./perf stat -e '{r1001e,r401e0,r4c010}' <workload>
	Performance counter stats for 'workload=E2=80=99:
	<not supported>      r4c010=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20

The new condition added by the patch is:

	if (counter->supported && aggr->nr =3D=3D 0)
	                return;


The first two events r1001e and r401e0 are good to go in this group, hence
counter->supported  is true where as aggr->nr is zero since this group is
not scheduled. Since counter->supported is false for third event which
broke the group constraint, the condition won't return and hence only prints
this event in output.

Namhyung, is there any scenario because of which this condition was added ?
If not I would go ahead and sent a fix patch to remove this check.

Thanks
Athira

>=20
> -	if (perf_pmu__has_hybrid() && ad.ena =3D=3D 0)
> -		return;
> +	uniquify_counter(config, counter);
> +
> +	val =3D aggr->counts.val;
> +	ena =3D aggr->counts.ena;
> +	run =3D aggr->counts.run;
>=20
> -	nr =3D ad.nr;
> -	ena =3D ad.ena;
> -	run =3D ad.run;
> -	val =3D ad.val;
> 	if (*first && metric_only) {
> 		*first =3D false;
> -		aggr_printout(config, counter, id, nr);
> +		aggr_printout(config, counter, id, aggr->nr);
> 	}
> 	if (prefix && !metric_only)
> 		fprintf(output, "%s", prefix);
>=20
> 	uval =3D val * counter->scale;
> -	if (cpu.cpu !=3D -1)
> -		id =3D aggr_cpu_id__cpu(cpu, /*data=3D*/NULL);
>=20
> -	printout(config, id, nr, counter, uval,
> -		 prefix, run, ena, 1.0, &rt_stat);
> +	printout(config, id, aggr->nr, counter, uval,
> +		 prefix, run, ena, avg, &rt_stat, s);
> +
> 	if (!metric_only)
> 		fputc('\n', output);
> }
> @@ -869,8 +729,6 @@ static void print_aggr(struct perf_stat_config *confi=
g,
> 	if (!config->aggr_map || !config->aggr_get_id)
> 		return;
>=20
> -	aggr_update_shadow(config, evlist);
> -
> 	/*
> 	 * With metric_only everything is on a single line.
> 	 * Without each counter has its own line.
> @@ -881,188 +739,36 @@ static void print_aggr(struct perf_stat_config *co=
nfig,
>=20
> 		first =3D true;
> 		evlist__for_each_entry(evlist, counter) {
> +			if (counter->merged_stat)
> +				continue;
> +
> 			print_counter_aggrdata(config, counter, s,
> -					prefix, metric_only,
> -					&first, (struct perf_cpu){ .cpu =3D -1 });
> +					       prefix, metric_only,
> +					       &first);
> 		}
> 		if (metric_only)
> 			fputc('\n', output);
> 	}
> }
>=20
> -static int cmp_val(const void *a, const void *b)
> -{
> -	return ((struct perf_aggr_thread_value *)b)->val -
> -		((struct perf_aggr_thread_value *)a)->val;
> -}
> -
> -static struct perf_aggr_thread_value *sort_aggr_thread(
> -					struct evsel *counter,
> -					int *ret,
> -					struct target *_target)
> -{
> -	int nthreads =3D perf_thread_map__nr(counter->core.threads);
> -	int i =3D 0;
> -	double uval;
> -	struct perf_aggr_thread_value *buf;
> -
> -	buf =3D calloc(nthreads, sizeof(struct perf_aggr_thread_value));
> -	if (!buf)
> -		return NULL;
> -
> -	for (int thread =3D 0; thread < nthreads; thread++) {
> -		int idx;
> -		u64 ena =3D 0, run =3D 0, val =3D 0;
> -
> -		perf_cpu_map__for_each_idx(idx, evsel__cpus(counter)) {
> -			struct perf_counts_values *counts =3D
> -				perf_counts(counter->counts, idx, thread);
> -
> -			val +=3D counts->val;
> -			ena +=3D counts->ena;
> -			run +=3D counts->run;
> -		}
> -
> -		uval =3D val * counter->scale;
> -
> -		/*
> -		 * Skip value 0 when enabling --per-thread globally,
> -		 * otherwise too many 0 output.
> -		 */
> -		if (uval =3D=3D 0.0 && target__has_per_thread(_target))
> -			continue;
> -
> -		buf[i].counter =3D counter;
> -		buf[i].id =3D aggr_cpu_id__empty();
> -		buf[i].id.thread_idx =3D thread;
> -		buf[i].uval =3D uval;
> -		buf[i].val =3D val;
> -		buf[i].run =3D run;
> -		buf[i].ena =3D ena;
> -		i++;
> -	}
> -
> -	qsort(buf, i, sizeof(struct perf_aggr_thread_value), cmp_val);
> -
> -	if (ret)
> -		*ret =3D i;
> -
> -	return buf;
> -}
> -
> -static void print_aggr_thread(struct perf_stat_config *config,
> -			      struct target *_target,
> -			      struct evsel *counter, char *prefix)
> -{
> -	FILE *output =3D config->output;
> -	int thread, sorted_threads;
> -	struct aggr_cpu_id id;
> -	struct perf_aggr_thread_value *buf;
> -
> -	buf =3D sort_aggr_thread(counter, &sorted_threads, _target);
> -	if (!buf) {
> -		perror("cannot sort aggr thread");
> -		return;
> -	}
> -
> -	for (thread =3D 0; thread < sorted_threads; thread++) {
> -		if (prefix)
> -			fprintf(output, "%s", prefix);
> -
> -		id =3D buf[thread].id;
> -		printout(config, id, 0, buf[thread].counter, buf[thread].uval,
> -			 prefix, buf[thread].run, buf[thread].ena, 1.0,
> -			 &rt_stat);
> -		fputc('\n', output);
> -	}
> -
> -	free(buf);
> -}
> -
> -struct caggr_data {
> -	double avg, avg_enabled, avg_running;
> -};
> -
> -static void counter_aggr_cb(struct perf_stat_config *config __maybe_unus=
ed,
> -			    struct evsel *counter, void *data,
> -			    bool first __maybe_unused)
> -{
> -	struct caggr_data *cd =3D data;
> -	struct perf_counts_values *aggr =3D &counter->counts->aggr;
> -
> -	cd->avg +=3D aggr->val;
> -	cd->avg_enabled +=3D aggr->ena;
> -	cd->avg_running +=3D aggr->run;
> -}
> -
> -/*
> - * Print out the results of a single counter:
> - * aggregated counts in system-wide mode
> - */
> -static void print_counter_aggr(struct perf_stat_config *config,
> -			       struct evsel *counter, char *prefix)
> -{
> -	bool metric_only =3D config->metric_only;
> -	FILE *output =3D config->output;
> -	double uval;
> -	struct caggr_data cd =3D { .avg =3D 0.0 };
> -
> -	if (!collect_data(config, counter, counter_aggr_cb, &cd))
> -		return;
> -
> -	if (prefix && !metric_only)
> -		fprintf(output, "%s", prefix);
> -
> -	uval =3D cd.avg * counter->scale;
> -	printout(config, aggr_cpu_id__empty(), 0, counter, uval, prefix, cd.avg=
_running,
> -		 cd.avg_enabled, cd.avg, &rt_stat);
> -	if (!metric_only)
> -		fprintf(output, "\n");
> -}
> -
> -static void counter_cb(struct perf_stat_config *config __maybe_unused,
> -		       struct evsel *counter, void *data,
> -		       bool first __maybe_unused)
> -{
> -	struct aggr_data *ad =3D data;
> -
> -	ad->val +=3D perf_counts(counter->counts, ad->cpu_map_idx, 0)->val;
> -	ad->ena +=3D perf_counts(counter->counts, ad->cpu_map_idx, 0)->ena;
> -	ad->run +=3D perf_counts(counter->counts, ad->cpu_map_idx, 0)->run;
> -}
> -
> -/*
> - * Print out the results of a single counter:
> - * does not use aggregated count in system-wide
> - */
> static void print_counter(struct perf_stat_config *config,
> 			  struct evsel *counter, char *prefix)
> {
> -	FILE *output =3D config->output;
> -	u64 ena, run, val;
> -	double uval;
> -	int idx;
> -	struct perf_cpu cpu;
> -	struct aggr_cpu_id id;
> -
> -	perf_cpu_map__for_each_cpu(cpu, idx, evsel__cpus(counter)) {
> -		struct aggr_data ad =3D { .cpu_map_idx =3D idx };
> -
> -		if (!collect_data(config, counter, counter_cb, &ad))
> -			return;
> -		val =3D ad.val;
> -		ena =3D ad.ena;
> -		run =3D ad.run;
> +	bool metric_only =3D config->metric_only;
> +	bool first =3D false;
> +	int s;
>=20
> -		if (prefix)
> -			fprintf(output, "%s", prefix);
> +	/* AGGR_THREAD doesn't have config->aggr_get_id */
> +	if (!config->aggr_map)
> +		return;
>=20
> -		uval =3D val * counter->scale;
> -		id =3D aggr_cpu_id__cpu(cpu, /*data=3D*/NULL);
> -		printout(config, id, 0, counter, uval, prefix,
> -			 run, ena, 1.0, &rt_stat);
> +	if (counter->merged_stat)
> +		return;
>=20
> -		fputc('\n', output);
> +	for (s =3D 0; s < config->aggr_map->nr; s++) {
> +		print_counter_aggrdata(config, counter, s,
> +				       prefix, metric_only,
> +				       &first);
> 	}
> }
>=20
> @@ -1081,6 +787,7 @@ static void print_no_aggr_metric(struct perf_stat_co=
nfig *config,
> 			u64 ena, run, val;
> 			double uval;
> 			struct aggr_cpu_id id;
> +			struct perf_stat_evsel *ps =3D counter->stats;
> 			int counter_idx =3D perf_cpu_map__idx(evsel__cpus(counter), cpu);
>=20
> 			if (counter_idx < 0)
> @@ -1093,13 +800,13 @@ static void print_no_aggr_metric(struct perf_stat_=
config *config,
> 				aggr_printout(config, counter, id, 0);
> 				first =3D false;
> 			}
> -			val =3D perf_counts(counter->counts, counter_idx, 0)->val;
> -			ena =3D perf_counts(counter->counts, counter_idx, 0)->ena;
> -			run =3D perf_counts(counter->counts, counter_idx, 0)->run;
> +			val =3D ps->aggr[counter_idx].counts.val;
> +			ena =3D ps->aggr[counter_idx].counts.ena;
> +			run =3D ps->aggr[counter_idx].counts.run;
>=20
> 			uval =3D val * counter->scale;
> 			printout(config, id, 0, counter, uval, prefix,
> -				 run, ena, 1.0, &rt_stat);
> +				 run, ena, 1.0, &rt_stat, counter_idx);
> 		}
> 		if (!first)
> 			fputc('\n', config->output);
> @@ -1135,8 +842,8 @@ static void print_metric_headers(struct perf_stat_co=
nfig *config,
> 	};
> 	bool first =3D true;
>=20
> -		if (config->json_output && !config->interval)
> -			fprintf(config->output, "{");
> +	if (config->json_output && !config->interval)
> +		fprintf(config->output, "{");
>=20
> 	if (prefix && !config->json_output)
> 		fprintf(config->output, "%s", prefix);
> @@ -1379,31 +1086,6 @@ static void print_footer(struct perf_stat_config *=
config)
> 			"the same PMU. Try reorganizing the group.\n");
> }
>=20
> -static void print_percore_thread(struct perf_stat_config *config,
> -				 struct evsel *counter, char *prefix)
> -{
> -	int s;
> -	struct aggr_cpu_id s2, id;
> -	struct perf_cpu_map *cpus;
> -	bool first =3D true;
> -	int idx;
> -	struct perf_cpu cpu;
> -
> -	cpus =3D evsel__cpus(counter);
> -	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
> -		s2 =3D config->aggr_get_id(config, cpu);
> -		for (s =3D 0; s < config->aggr_map->nr; s++) {
> -			id =3D config->aggr_map->map[s];
> -			if (aggr_cpu_id__equal(&s2, &id))
> -				break;
> -		}
> -
> -		print_counter_aggrdata(config, counter, s,
> -				       prefix, false,
> -				       &first, cpu);
> -	}
> -}
> -
> static void print_percore(struct perf_stat_config *config,
> 			  struct evsel *counter, char *prefix)
> {
> @@ -1416,15 +1098,14 @@ static void print_percore(struct perf_stat_config=
 *config,
> 		return;
>=20
> 	if (config->percore_show_thread)
> -		return print_percore_thread(config, counter, prefix);
> +		return print_counter(config, counter, prefix);
>=20
> 	for (s =3D 0; s < config->aggr_map->nr; s++) {
> 		if (prefix && metric_only)
> 			fprintf(output, "%s", prefix);
>=20
> 		print_counter_aggrdata(config, counter, s,
> -				prefix, metric_only,
> -				&first, (struct perf_cpu){ .cpu =3D -1 });
> +				       prefix, metric_only, &first);
> 	}
>=20
> 	if (metric_only)
> @@ -1469,17 +1150,13 @@ void evlist__print_counters(struct evlist *evlist=
, struct perf_stat_config *conf
> 		print_aggr(config, evlist, prefix);
> 		break;
> 	case AGGR_THREAD:
> -		evlist__for_each_entry(evlist, counter) {
> -			print_aggr_thread(config, _target, counter, prefix);
> -		}
> -		break;
> 	case AGGR_GLOBAL:
> 		if (config->iostat_run)
> 			iostat_print_counters(evlist, config, ts, prefix =3D buf,
> -					      print_counter_aggr);
> +					      print_counter);
> 		else {
> 			evlist__for_each_entry(evlist, counter) {
> -				print_counter_aggr(config, counter, prefix);
> +				print_counter(config, counter, prefix);
> 			}
> 			if (metric_only)
> 				fputc('\n', config->output);
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index c0955a0427ab..0316557adce9 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -565,11 +565,6 @@ int perf_stat_process_counter(struct perf_stat_confi=
g *config,
> 			evsel__name(counter), count[0], count[1], count[2]);
> 	}
>=20
> -	/*
> -	 * Save the full runtime - to allow normalization during printout:
> -	 */
> -	perf_stat__update_shadow_stats(counter, *count, 0, &rt_stat);
> -
> 	return 0;
> }
>=20
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index 3d413ba8c68a..382a1ab92ce1 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -224,15 +224,6 @@ static inline void update_rusage_stats(struct rusage=
_stats *ru_stats, struct rus
> struct evsel;
> struct evlist;
>=20
> -struct perf_aggr_thread_value {
> -	struct evsel *counter;
> -	struct aggr_cpu_id id;
> -	double uval;
> -	u64 val;
> -	u64 run;
> -	u64 ena;
> -};
> -
> bool __perf_stat_evsel__is(struct evsel *evsel, enum perf_stat_evsel_id i=
d);
>=20
> #define perf_stat_evsel__is(evsel, id) \
> --=20
> 2.38.0.413.g74048e4d9e-goog
>=20

