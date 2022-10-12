Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC7B5FC225
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 10:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiJLIlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 04:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJLIlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 04:41:10 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94E7B40ED;
        Wed, 12 Oct 2022 01:41:06 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j7so25181128wrr.3;
        Wed, 12 Oct 2022 01:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P3SyMQAtY4XkiggBe5s7cBMrLKlW6KTBeHIRyD52N1E=;
        b=J4YLawnWLBu3dTeMLagd3RBceRTfB7xDwCBHYyl6yz9pP+vLRa30gf8gpU+PS8xSQ5
         X/iONYxYwNa+jeIHRXt5MWub+PCF6k3I+U1hwNALNTidlc2p0PLY4Y0L3Gf7Fwb+ziZ/
         ylAFdaA8xkXny67V5gnOW5rXPylzubuKi/85aHfVGWFbhmuI76bY+HG/E6jWMc7OgUvv
         8iP+hKmIh/U0TR84JR0l2TCPnsnFDFkGb07dtfzx77uN/JH9ZrDxY2NnjvsLyQFAnsmA
         zDWRXZFlvBnn4TnUF4UXn3kKdtVypTevivXjwJwl+W4XCljA0VdJPEvDPS/1tAx3W7GP
         fM3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P3SyMQAtY4XkiggBe5s7cBMrLKlW6KTBeHIRyD52N1E=;
        b=MUzxiock5bodqOlzBrvBS4jJKfdVscJzkUXvjjtTfPs4aBJf9060qWB2SQYCOPyHnw
         GcFPHcoClCLbbwJ49xTliurU7WWY4ZMWQ9E3MTJzzN7lBonNEhAP3vnKHP7w6CM9v6+N
         hOKVhOD+O++kfl9NtUSZ3SVLB8TLSe6KpZRw1ZksHQQ2cYvhsuCQu6s5A7gc+o8nxUN1
         1orD6kQhw09wukPf6D3RqGRsy23BEUD+11d2ytW16aARP4XaZozf+9aT22+iRdDRRXdx
         Irmg1u7PENwKvyhfm2KDhYh3ZSCqW9wLgbThDjJFRW8AGUX9GWSruumNAk/ZeFiR7tqn
         IYaw==
X-Gm-Message-State: ACrzQf2ghyy/79WIiDTBBdrbQNdiLXs/TMyoSSX0EVbHPYdOAn/q0npd
        q8y+f+9cAO7k18eVtnqAuhw=
X-Google-Smtp-Source: AMsMyM5RXDpqJNBcU23Om7JRXK4S8QwPcZCb4Pd3RHpwo0CSacWn8PHxNh8LYXOqRylAnzi5AGoeVg==
X-Received: by 2002:a5d:6901:0:b0:22f:b097:7de6 with SMTP id t1-20020a5d6901000000b0022fb0977de6mr12776666wru.373.1665564064989;
        Wed, 12 Oct 2022 01:41:04 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id d17-20020a5d6dd1000000b0022cd6e852a2sm16094363wrz.45.2022.10.12.01.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 01:41:04 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 12 Oct 2022 10:41:02 +0200
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: Re: [PATCH 19/19] perf stat: Remove unused perf_counts.aggr field
Message-ID: <Y0Z9nsgz7A5nWRN2@krava>
References: <20221010053600.272854-1-namhyung@kernel.org>
 <20221010053600.272854-20-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221010053600.272854-20-namhyung@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 09, 2022 at 10:36:00PM -0700, Namhyung Kim wrote:
> The aggr field in the struct perf_counts is to keep the aggregated value
> in the AGGR_GLOBAL for the old code.  But it's not used anymore.
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/counts.c |  1 -
>  tools/perf/util/counts.h |  1 -
>  tools/perf/util/stat.c   | 35 ++---------------------------------
>  3 files changed, 2 insertions(+), 35 deletions(-)
>=20
> diff --git a/tools/perf/util/counts.c b/tools/perf/util/counts.c
> index 7a447d918458..11cd85b278a6 100644
> --- a/tools/perf/util/counts.c
> +++ b/tools/perf/util/counts.c
> @@ -48,7 +48,6 @@ void perf_counts__reset(struct perf_counts *counts)
>  {
>  	xyarray__reset(counts->loaded);
>  	xyarray__reset(counts->values);
> -	memset(&counts->aggr, 0, sizeof(struct perf_counts_values));
>  }
> =20
>  void evsel__reset_counts(struct evsel *evsel)
> diff --git a/tools/perf/util/counts.h b/tools/perf/util/counts.h
> index 5de275194f2b..42760242e0df 100644
> --- a/tools/perf/util/counts.h
> +++ b/tools/perf/util/counts.h
> @@ -11,7 +11,6 @@ struct evsel;
> =20
>  struct perf_counts {
>  	s8			  scaled;
> -	struct perf_counts_values aggr;
>  	struct xyarray		  *values;
>  	struct xyarray		  *loaded;
>  };
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 1652586a4925..0dccfa273fa7 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -307,8 +307,6 @@ static void evsel__copy_prev_raw_counts(struct evsel =
*evsel)
>  				*perf_counts(evsel->prev_raw_counts, idx, thread);
>  		}
>  	}
> -
> -	evsel->counts->aggr =3D evsel->prev_raw_counts->aggr;
>  }
> =20
>  void evlist__copy_prev_raw_counts(struct evlist *evlist)
> @@ -319,26 +317,6 @@ void evlist__copy_prev_raw_counts(struct evlist *evl=
ist)
>  		evsel__copy_prev_raw_counts(evsel);
>  }
> =20
> -void evlist__save_aggr_prev_raw_counts(struct evlist *evlist)
> -{
> -	struct evsel *evsel;
> -
> -	/*
> -	 * To collect the overall statistics for interval mode,
> -	 * we copy the counts from evsel->prev_raw_counts to
> -	 * evsel->counts. The perf_stat_process_counter creates
> -	 * aggr values from per cpu values, but the per cpu values
> -	 * are 0 for AGGR_GLOBAL. So we use a trick that saves the
> -	 * previous aggr value to the first member of perf_counts,
> -	 * then aggr calculation in process_counter_values can work
> -	 * correctly.
> -	 */
> -	evlist__for_each_entry(evlist, evsel) {
> -		*perf_counts(evsel->prev_raw_counts, 0, 0) =3D
> -			evsel->prev_raw_counts->aggr;
> -	}
> -}
> -
>  static size_t pkg_id_hash(const void *__key, void *ctx __maybe_unused)
>  {
>  	uint64_t *key =3D (uint64_t *) __key;
> @@ -422,7 +400,6 @@ process_counter_values(struct perf_stat_config *confi=
g, struct evsel *evsel,
>  		       int cpu_map_idx, int thread,
>  		       struct perf_counts_values *count)
>  {
> -	struct perf_counts_values *aggr =3D &evsel->counts->aggr;
>  	struct perf_stat_evsel *ps =3D evsel->stats;
>  	static struct perf_counts_values zero;
>  	bool skip =3D false;
> @@ -491,12 +468,6 @@ process_counter_values(struct perf_stat_config *conf=
ig, struct evsel *evsel,
>  		}
>  	}
> =20
> -	if (config->aggr_mode =3D=3D AGGR_GLOBAL) {
> -		aggr->val +=3D count->val;
> -		aggr->ena +=3D count->ena;
> -		aggr->run +=3D count->run;
> -	}
> -
>  	return 0;
>  }
> =20
> @@ -521,13 +492,10 @@ static int process_counter_maps(struct perf_stat_co=
nfig *config,
>  int perf_stat_process_counter(struct perf_stat_config *config,
>  			      struct evsel *counter)
>  {
> -	struct perf_counts_values *aggr =3D &counter->counts->aggr;
>  	struct perf_stat_evsel *ps =3D counter->stats;
> -	u64 *count =3D counter->counts->aggr.values;
> +	u64 *count;
>  	int ret;
> =20
> -	aggr->val =3D aggr->ena =3D aggr->run =3D 0;
> -
>  	if (counter->per_pkg)
>  		evsel__zero_per_pkg(counter);
> =20
> @@ -538,6 +506,7 @@ int perf_stat_process_counter(struct perf_stat_config=
 *config,
>  	if (config->aggr_mode !=3D AGGR_GLOBAL)
>  		return 0;
> =20
> +	count =3D ps->aggr[0].counts.values;
>  	update_stats(&ps->res_stats, *count);

hi,
for some reason 'count' could be NULL, I'm getting crash in here:

	$ ./perf stat record -o krava.data true=20
	...

	$ gdb ./perf

	(gdb) r stat report -i krava.data
	Starting program: /home/jolsa/kernel/linux-perf/tools/perf/perf stat repor=
t -i krava.data
	[Thread debugging using libthread_db enabled]
	Using host libthread_db library "/lib64/libthread_db.so.1".

	Program received signal SIGSEGV, Segmentation fault.
	0x00000000005ae90b in perf_stat_process_counter (config=3D0xe18d60 <stat_c=
onfig>, counter=3D0xecfd00) at util/stat.c:510
	510             update_stats(&ps->res_stats, *count);
	Missing separate debuginfos, use: dnf debuginfo-install bzip2-libs-1.0.8-1=
1.fc36.x86_64 cyrus-sasl-lib-2.1.27-18.fc36.x86_64 elfutils-debuginfod-clie=
nt-0.187-4.fc36.x86_64 elfutils-libelf-0.187-4.fc36.x86_64 elfutils-libs-0.=
187-4.fc36.x86_64 glibc-2.35-15.fc36.x86_64 glibc-2.35-17.fc36.x86_64 keyut=
ils-libs-1.6.1-4.fc36.x86_64 krb5-libs-1.19.2-11.fc36.x86_64 libbrotli-1.0.=
9-7.fc36.x86_64 libcap-2.48-4.fc36.x86_64 libcom_err-1.46.5-2.fc36.x86_64 l=
ibcurl-7.82.0-8.fc36.x86_64 libevent-2.1.12-6.fc36.x86_64 libgcc-12.2.1-2.f=
c36.x86_64 libidn2-2.3.3-1.fc36.x86_64 libnghttp2-1.46.0-2.fc36.x86_64 libp=
sl-0.21.1-5.fc36.x86_64 libselinux-3.3-4.fc36.x86_64 libssh-0.9.6-4.fc36.x8=
6_64 libunistring-1.0-1.fc36.x86_64 libunwind-1.6.2-2.fc36.x86_64 libxcrypt=
-4.4.28-1.fc36.x86_64 libzstd-1.5.2-2.fc36.x86_64 numactl-libs-2.0.14-5.fc3=
6.x86_64 openldap-2.6.3-1.fc36.x86_64 openssl-libs-3.0.5-1.fc36.x86_64 perl=
-libs-5.34.1-486.fc36.x86_64 python3-libs-3.10.7-1.fc36.x86_64 slang-2.3.2-=
11.fc36.x86_64 xz-libs-5.2.5-9.fc36.x86_64 zlib-1.2.11-33.fc36.x86_64
	(gdb) bt
	#0  0x00000000005ae90b in perf_stat_process_counter (config=3D0xe18d60 <st=
at_config>, counter=3D0xecfd00) at util/stat.c:510
	#1  0x000000000043b716 in process_counters () at builtin-stat.c:485
	#2  0x000000000043f2bf in process_stat_round_event (session=3D0xec84f0, ev=
ent=3D0x7ffff7ffaba8) at builtin-stat.c:2099
	#3  0x000000000056c7b6 in perf_session__process_user_event (session=3D0xec=
84f0, event=3D0x7ffff7ffaba8, file_offset=3D2984, file_path=3D0xecf220 "kra=
va.data")
	    at util/session.c:1714
	#4  0x000000000056cea5 in perf_session__process_event (session=3D0xec84f0,=
 event=3D0x7ffff7ffaba8, file_offset=3D2984, file_path=3D0xecf220 "krava.da=
ta")
	    at util/session.c:1857
	#5  0x000000000056e4fa in process_simple (session=3D0xec84f0, event=3D0x7f=
fff7ffaba8, file_offset=3D2984, file_path=3D0xecf220 "krava.data") at util/=
session.c:2432
	#6  0x000000000056e1b9 in reader__read_event (rd=3D0x7fffffffb6c0, session=
=3D0xec84f0, prog=3D0x7fffffffb690) at util/session.c:2361
	#7  0x000000000056e3ae in reader__process_events (rd=3D0x7fffffffb6c0, ses=
sion=3D0xec84f0, prog=3D0x7fffffffb690) at util/session.c:2410
	#8  0x000000000056e652 in __perf_session__process_events (session=3D0xec84=
f0) at util/session.c:2457
	#9  0x000000000056eff8 in perf_session__process_events (session=3D0xec84f0=
) at util/session.c:2623
	#10 0x000000000043fa53 in __cmd_report (argc=3D0, argv=3D0x7fffffffdf70) a=
t builtin-stat.c:2265
	#11 0x000000000043fd94 in cmd_stat (argc=3D3, argv=3D0x7fffffffdf70) at bu=
iltin-stat.c:2346
	#12 0x00000000004ef495 in run_builtin (p=3D0xe2f930 <commands+336>, argc=
=3D4, argv=3D0x7fffffffdf70) at perf.c:322
	#13 0x00000000004ef709 in handle_internal_command (argc=3D4, argv=3D0x7fff=
ffffdf70) at perf.c:376
	#14 0x00000000004ef858 in run_argv (argcp=3D0x7fffffffdd9c, argv=3D0x7ffff=
fffdd90) at perf.c:420
	#15 0x00000000004efc1f in main (argc=3D4, argv=3D0x7fffffffdf70) at perf.c=
:550
	(gdb) p count
	$1 =3D (u64 *) 0x0

jirka

> =20
>  	if (verbose > 0) {
> --=20
> 2.38.0.rc1.362.ged0d419d3c-goog
>=20
