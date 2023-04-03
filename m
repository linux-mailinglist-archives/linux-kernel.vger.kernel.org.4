Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8736D3CE5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 07:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjDCF3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 01:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjDCF2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 01:28:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EEE3C11
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 22:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1680499714; i=efault@gmx.de;
        bh=X0m4oG7P+r66TTwWmjlCrqTEIHQMeCECbqJYnJoMyv8=;
        h=X-UI-Sender-Class:Subject:From:To:Date;
        b=Zu28eBpLAUmToNLv3jx5t7V2/VBr8itjKVhZ3VcwK8PPoOn47sBLV8xMekaRm+8kq
         FWZgheSBNuDYIQnK6Y/dB0J56mqs2cX1uasQmtUPddH04lG4xO5Xysf79nyHSlV6eG
         H1uvSoeven1kOzm6Dg5ZcBGk3OZilOw1XDJBuoDxpU32csGKoKNpSYkYZeFjajSI6L
         PI9c1qBNkPY8OczZgFqM6ZvEsQKoy081q2m1kvTjesnuyZzRgTv4h1gRUVOwI51IFC
         0ACbiyZP/zhiXzLX1CjJXKUzJOHcxdluFiKKs9kb/ptKNFTEkecQBKOf99ZKSA00eS
         d9J7++06ha0YA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.48.203]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mnpns-1qBNu423iM-00pJSo; Mon, 03
 Apr 2023 07:28:34 +0200
Message-ID: <731b3e6ac649f797417fd1e107223da73bb9e9d1.camel@gmx.de>
Subject: [hacklet] perf sched: Add report latency max/sum fields and body
 filter options
From:   Mike Galbraith <efault@gmx.de>
To:     lkml <linux-kernel@vger.kernel.org>
Date:   Mon, 03 Apr 2023 07:28:34 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eTsdQfC4tUsIMd2/EK2uNqrgBZcpt0ofe2SOcjPiULdK/MTpcFk
 ljbAVax21b3mY8srPtCYbM87lOIhOkMhGD56oiZthcZxsVZ7aa0FjxvxqmhBxafnnGAdmwT
 yjGfjcNqq26A69pLVPcwI/2xA3fofXNLeMYO9/3Z54U+F5a8UUzNjdtHKVTGPJzvdbDZZPU
 vngCISiAtZfEJG+wOl1tQ==
UI-OutboundReport: notjunk:1;M01:P0:oJ+FX/3uCcU=;ctvPEQ0F5tfUkiMQXTPi0pBbKaQ
 d7iD+ReM2FeXycgbD0MZTQLGebl6BmLScw3eRS+0Gf4d0tSKK3AvhYkrxfuNqD1HqaQVmiuBN
 3wPYgsBFh6IBFMABLVu7MQB/Dx57D/xRVhLFdrOGvQgHLhcuFFwcowA+cJ758EHmbq2qzmX25
 /fJN19NQIREjO5+7+Vyhpjv0JoWTda/hH1usAGR2BimuGTaW+sUPbb8NibpA1XuSPiCOCif2N
 POdNeBWgw59+l0klSg4T6I/mZc6wIjFnyH5dsyL/d5T+Astvr9LCR7E6ezFdmG5X53lcp7mE+
 9p3wqdLrLWXUdDHtnzklKtS6uP98XgistHHedSkdFZTZW0a+oebn80k5hwRrWjrop5UvexAKN
 WBScjO/rNl6cDHbDg8A7uCMpqlOGLc+m4xfllguq2qjTNZpUTheOYd1N86sgfNIIdCbnhi/Au
 dB+0/QnfrAgXu0dN6kfZSrsbc91ec4xMrOPSk5A9UlsZ+jEKGQJ5Uzv3Wq5vbfkQzhhvElI9w
 px8p6rb47Gp4gAlb4pl1IaRAYJhlqBCIFVUw/TnZyxTPXtNBAvKXFBR1aaN0Pm+iln+xtKMQe
 aoFO1PAaQjhG45ELc7smJvr6uTmjFGgs4mUdRf1ZnuJ0wMXS0Qye8DXNrGKW9Ik6D7UY0xrWB
 PvPWfiPO47VvdkwEsfoaPero1OjpTvt9r82veTt7Z854Qzv583FDlioAd6QGXOQwsGW2qUCIE
 zYWo8zLRRVvdzg9GrhyChUA1VHU80UgE66h8JUan7f+GmcTWKy5JUgDw/ZBQ1Mk+F/w8xwW02
 4EI3whoLWGsn9pmMvZzp3E4VFs9hLbhmaDCbISWakoAmHEWIgmRRlQvD0HTU3uiLf+0OcBS+J
 5Rg7zAGCAMeM5IvoDyOJSq52AtncZWuJdLjD7i5p1J7VS2sUnn2jkHm4Umj2BSOFNd6LPxh5/
 H1EV8z+96BBRcOnlkEfQ3/5+g68=
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dunno if anyone else will find this useful, but who knows.  After a
recent bout of repetitive perf sched data frobing, I felt motivated to
can and condense a few keystrokes.  It's dressed up a bit like a patch,
but that's to inspire future leaky self to recall its excuse for
existing, $subject is correctly speeled :)

Anyone trying it should dig up and apply the below first, as perf sched
is kinda busted without it.
[PATCH v4] perf sched: Fix sched latency analysis incorrect

perf sched: Add report latency max/sum fields and body filter options

When using perf sched lat, I almost always have to do some gymnastics to
concentrate the output, so I dug up a 2017 hacklet to tally wait time,
and added some basic conveniences to it.  'G' 'S' and 'T' are new, as
are the 'sum' sort key and associated output field.

The footer is always full report regardless of body trimming, and grew
max latency and latency tally fields.

 Usage: perf sched latency [<options>]

    -C, --CPU <n>         CPU to profile on
    -G, --greater <n>     only output entries with a ms field >=3D N ms
    -p, --pids            latency stats per pid instead of per comm
    -s, --sort <key[,key2...]>
                          sort by key(s): runtime, switch, avg, max or sum
    -S, --summary <n>     summarize the top N lines of sorted entries
    -T, --truncate        truncate the max delay start/end fields

That '-G' is meant as a simple noise filter. Say during a PornHub vs
Kbuild recording, you capture a bunch of tasks that weren't involved
enough in either competing activity to generate a 4 digit time tally,
with -G 1000, signal to noise improves.

Signed-off-by: Mike Galbraith <efault@gmx.de>
=2D--
 tools/perf/builtin-sched.c |   94 ++++++++++++++++++++++++++++++++++++---=
------
 1 file changed, 77 insertions(+), 17 deletions(-)

=2D-- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -188,6 +188,9 @@ struct perf_sched {
 	struct mutex	 start_work_mutex;
 	struct mutex	 work_done_wait_mutex;
 	int		 profile_cpu;
+	int		 lat_minimum;
+	int		 lat_summary;
+	bool		 lat_truncate;
 /*
  * Track the current task - that way we can know whether there's any
  * weird events, such as a task being switched away that is not current.
@@ -224,6 +227,8 @@ struct perf_sched {
 	u64		 run_avg;
 	u64		 all_runtime;
 	u64		 all_count;
+	u64		 all_lat;
+	u64		 max_lat;
 	u64		 cpu_last_switched[MAX_CPUS];
 	struct rb_root_cached atom_root, sorted_atom_root, merged_atom_root;
 	struct list_head sort_list, cmp_pid;
@@ -1341,11 +1346,12 @@ static int latency_migrate_task_event(st
 	return err;
 }

-static void output_lat_thread(struct perf_sched *sched, struct work_atoms=
 *work_list)
+static void output_lat_thread(struct perf_sched *sched, struct work_atoms=
 *work_list,
+			      bool summarize)
 {
 	int i;
 	int ret;
-	u64 avg;
+	u64 avg, min =3D sched->lat_minimum * NSEC_PER_MSEC;
 	char max_lat_start[32], max_lat_end[32];

 	if (!work_list->nb_atoms)
@@ -1358,6 +1364,18 @@ static void output_lat_thread(struct per

 	sched->all_runtime +=3D work_list->total_runtime;
 	sched->all_count   +=3D work_list->nb_atoms;
+	sched->all_lat +=3D work_list->total_lat;
+	if (sched->max_lat < work_list->max_lat)
+		sched->max_lat =3D work_list->max_lat;
+
+	/* Toss lines that don't meet the user's significance criteria. */
+	if (min > work_list->total_runtime && min > work_list->total_lat &&
+	    min > work_list->max_lat)
+		return;
+
+	/* We've reached the user's TLDNR threshold, so we're done. */
+	if (summarize && sched->lat_summary-- <=3D 0)
+		return;

 	if (work_list->num_merged > 1)
 		ret =3D printf("  %s:(%d) ", thread__comm_str(work_list->thread), work_=
list->num_merged);
@@ -1371,11 +1389,14 @@ static void output_lat_thread(struct per
 	timestamp__scnprintf_usec(work_list->max_lat_start, max_lat_start, sizeo=
f(max_lat_start));
 	timestamp__scnprintf_usec(work_list->max_lat_end, max_lat_end, sizeof(ma=
x_lat_end));

-	printf("|%11.3f ms |%9" PRIu64 " | avg:%8.3f ms | max:%8.3f ms | max sta=
rt: %12s s | max end: %12s s\n",
-	      (double)work_list->total_runtime / NSEC_PER_MSEC,
-		 work_list->nb_atoms, (double)avg / NSEC_PER_MSEC,
-		 (double)work_list->max_lat / NSEC_PER_MSEC,
-		 max_lat_start, max_lat_end);
+	printf("|%11.3f ms |%9" PRIu64 " | avg:%8.3f ms | max:%8.3f ms | sum:%9.=
3f ms |",
+	       (double)work_list->total_runtime / NSEC_PER_MSEC,
+	       work_list->nb_atoms, (double)avg / NSEC_PER_MSEC,
+	       (double)work_list->max_lat / NSEC_PER_MSEC,
+	       (double)work_list->total_lat / NSEC_PER_MSEC);
+	if (!sched->lat_truncate)
+		printf(" max start: %12s s | max end: %12s s |", max_lat_start, max_lat=
_end);
+	printf("\n");
 }

 static int pid_cmp(struct work_atoms *l, struct work_atoms *r)
@@ -1420,6 +1441,16 @@ static int max_cmp(struct work_atoms *l,
 	return 0;
 }

+static int sum_cmp(struct work_atoms *l, struct work_atoms *r)
+{
+	if (l->total_lat < r->total_lat)
+		return -1;
+	if (l->total_lat > r->total_lat)
+		return 1;
+
+	return 0;
+}
+
 static int switch_cmp(struct work_atoms *l, struct work_atoms *r)
 {
 	if (l->nb_atoms < r->nb_atoms)
@@ -1451,6 +1482,10 @@ static int sort_dimension__add(const cha
 		.name =3D "max",
 		.cmp  =3D max_cmp,
 	};
+	static struct sort_dimension sum_sort_dimension =3D {
+		.name =3D "sum",
+		.cmp  =3D sum_cmp,
+	};
 	static struct sort_dimension pid_sort_dimension =3D {
 		.name =3D "pid",
 		.cmp  =3D pid_cmp,
@@ -1467,6 +1502,7 @@ static int sort_dimension__add(const cha
 		&pid_sort_dimension,
 		&avg_sort_dimension,
 		&max_sort_dimension,
+		&sum_sort_dimension,
 		&switch_sort_dimension,
 		&runtime_sort_dimension,
 	};
@@ -3199,6 +3235,9 @@ static void perf_sched__merge_lat(struct
 static int perf_sched__lat(struct perf_sched *sched)
 {
 	struct rb_node *next;
+	bool summarize =3D sched->lat_summary > 0;
+	char buf[2][255];
+	int truncate;

 	setup_pager();

@@ -3208,26 +3247,38 @@ static int perf_sched__lat(struct perf_s
 	perf_sched__merge_lat(sched);
 	perf_sched__sort_lat(sched);

-	printf("\n -------------------------------------------------------------=
--------------------------------------------------------------------------=
----\n");
-	printf("  Task                  |   Runtime ms  | Switches | Avg delay m=
s    | Max delay ms    | Max delay start           | Max delay end        =
  |\n");
-	printf(" ---------------------------------------------------------------=
--------------------------------------------------------------------------=
--\n");
+
+	/* Header. */
+	strcpy(buf[0], "--------------------------------------------------------=
--------------------------------------------------");
+	strcpy(buf[1], " Task                  |   Runtime ms  | Switches | Avg =
delay ms    | Max delay ms    | Sum delay ms     |");
+	/* The last footer line is always a short line, so may need a trim. */
+	truncate =3D strlen(buf[0]);
+	if (!sched->lat_truncate) {
+		strcat(buf[0], "-----------------------------------------------------")=
;
+		strcat(buf[1], " Max delay start           | Max delay end           |"=
);
+	}
+	printf("\n %s\n %s\n %s\n", buf[0], buf[1], buf[0]);

 	next =3D rb_first_cached(&sched->sorted_atom_root);

+	/* Body. */
 	while (next) {
 		struct work_atoms *work_list;

 		work_list =3D rb_entry(next, struct work_atoms, node);
-		output_lat_thread(sched, work_list);
+		output_lat_thread(sched, work_list, summarize);
 		next =3D rb_next(next);
 		thread__zput(work_list->thread);
 	}

-	printf(" ---------------------------------------------------------------=
--------------------------------------------------\n");
-	printf("  TOTAL:                |%11.3f ms |%9" PRIu64 " |\n",
-		(double)sched->all_runtime / NSEC_PER_MSEC, sched->all_count);
-
-	printf(" ---------------------------------------------------\n");
+	/* Footer. */
+	sprintf(buf[1], " TOTAL:                |%11.3f ms |%9" PRIu64 " |      =
           |%13.3f ms |%14.3f ms |",
+		(double)sched->all_runtime / NSEC_PER_MSEC, sched->all_count,
+		(double)sched->max_lat / NSEC_PER_MSEC,
+		(double)sched->all_lat / NSEC_PER_MSEC);
+	printf(" %s\n %s\n", buf[0], buf[1]);
+	buf[0][truncate] =3D '\0';
+	printf(" %s\n", buf[0]);

 	print_bad_events(sched);
 	printf("\n");
@@ -3478,6 +3529,9 @@ int cmd_sched(int argc, const char **arg
 		.skip_merge           =3D 0,
 		.show_callchain	      =3D 1,
 		.max_stack            =3D 5,
+		.lat_summary          =3D 0,
+		.lat_minimum          =3D 0,
+		.lat_truncate         =3D false,
 	};
 	const struct option sched_options[] =3D {
 	OPT_STRING('i', "input", &input_name, "file",
@@ -3491,11 +3545,17 @@ int cmd_sched(int argc, const char **arg
 	};
 	const struct option latency_options[] =3D {
 	OPT_STRING('s', "sort", &sched.sort_order, "key[,key2...]",
-		   "sort by key(s): runtime, switch, avg, max"),
+		   "sort by key(s): runtime, switch, avg, max or sum"),
 	OPT_INTEGER('C', "CPU", &sched.profile_cpu,
 		    "CPU to profile on"),
 	OPT_BOOLEAN('p', "pids", &sched.skip_merge,
 		    "latency stats per pid instead of per comm"),
+	OPT_INTEGER('G', "greater", &sched.lat_minimum,
+		   "only output entries with a ms field >=3D N ms"),
+	OPT_INTEGER('S', "summary", &sched.lat_summary,
+		   "summarize the top N lines of sorted entries"),
+	OPT_BOOLEAN('T', "truncate", &sched.lat_truncate,
+		   "truncate the max delay start/end fields"),
 	OPT_PARENT(sched_options)
 	};
 	const struct option replay_options[] =3D {

