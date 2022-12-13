Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A247964B5D6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 14:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235215AbiLMNN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 08:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234624AbiLMNNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 08:13:50 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8001F635;
        Tue, 13 Dec 2022 05:13:49 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDD6056017928;
        Tue, 13 Dec 2022 13:13:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=viiIwFX8wj5VdwFsbkcZl9kNCr2kWeQfUK0ZFqAXI4c=;
 b=E2TOo1R/xczFH2rwMfnvESxJDr2gUpWoCZVSqx+5GPbqqHsbR0ECLGH8vDD8xP95KrAk
 cbgtBEpS0ger+dM9IuzUG6/jP4smUq7woKMyPQE511xR8eQ18JwD7DiOqW7l7omJHQgy
 9xqxUXef4uc39gxMdirkBLsXdj11D92Hn+UqUi/d2XNOnE7mlFJYVrc2Sw2ZUMVdvTcK
 H9iNkV5Y0h/ZtPthfe4Lj1neSS+e0e6IOvrXT9MwAx1SPak3qRyzOMgoTnXD3ee5Oxq3
 EMgvFrEE4TwyoX7UfY9Ik+xgaOmYZGZTHSIe+Bm2LUmWCF918OAezYtSxoTtnhj7HX40 Lw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3merajjj4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 13:13:26 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BDD6SuL022139;
        Tue, 13 Dec 2022 13:13:26 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3merajjj37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 13:13:26 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BD4cPxU030800;
        Tue, 13 Dec 2022 13:13:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3mchr5v72e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 13:13:23 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BDDDLbj45875690
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 13:13:21 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2916F20043;
        Tue, 13 Dec 2022 13:13:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F399D20040;
        Tue, 13 Dec 2022 13:13:20 +0000 (GMT)
Received: from [9.152.212.244] (unknown [9.152.212.244])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 13 Dec 2022 13:13:20 +0000 (GMT)
Message-ID: <990b0e9d-93fa-464e-c72f-ce51cf4dff83@linux.ibm.com>
Date:   Tue, 13 Dec 2022 14:13:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] perf stat: Do not delay the workload with --delay
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Kevin Nomura <nomurak@google.com>
References: <20221212230820.901382-1-namhyung@kernel.org>
Content-Language: en-US
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20221212230820.901382-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: If96xoHZi7NIi1GdrRPjZ1gaIrYoa6m-
X-Proofpoint-GUID: LvqRGN9ZCr2XcdukIknxQtbWKbtzLWcd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 bulkscore=0 malwarescore=0
 clxscore=1011 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2212130115
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/22 00:08, Namhyung Kim wrote:
> The -D/--delay option is to delay the measure after the program starts.
> But the current code goes to sleep before starting the program so the
> program is delayed too.  This is not the intention, let's fix it.
> 
> Before:
> 
>   $ time sudo ./perf stat -a -e cycles -D 3000 sleep 4
>   Events disabled
>   Events enabled
> 
>    Performance counter stats for 'system wide':
> 
>        4,326,949,337      cycles
> 
>          4.007494118 seconds time elapsed
> 
>   real	0m7.474s
>   user	0m0.356s
>   sys	0m0.120s
> 
> It ran the workload for 4 seconds and gave the 3 second delay.  So it
> should skip the first 3 second and measure the last 1 second only.  But
> as you can see, it delays 3 seconds and ran the workload after that for
> 4 seconds.  So the total time (real) was 7 seconds.
> 
> After:
> 
>   $ time sudo ./perf stat -a -e cycles -D 3000 sleep 4
>   Events disabled
>   Events enabled
> 
>    Performance counter stats for 'system wide':
> 
>        1,063,551,013      cycles
> 
>          1.002769510 seconds time elapsed
> 
>   real	0m4.484s
>   user	0m0.385s
>   sys	0m0.086s
> 
> The bug was introduced when it changed enablement of system-wide events
> with a command line workload.  But it should've considered the initial
> delay case.  The code was reworked since then (in bb8bc52e7578) so I'm
> afraid it won't be applied cleanly.
> 
> Fixes: d0a0a511493d ("perf stat: Fix forked applications enablement of counters")
> Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>
> Cc: Thomas Richter <tmricht@linux.ibm.com>
> Reported-by: Kevin Nomura <nomurak@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-stat.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index d040fbcdcc5a..b39bf785a16e 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -540,26 +540,14 @@ static int enable_counters(void)
>  			return err;
>  	}
>  
> -	if (stat_config.initial_delay < 0) {
> -		pr_info(EVLIST_DISABLED_MSG);
> -		return 0;
> -	}
> -
> -	if (stat_config.initial_delay > 0) {
> -		pr_info(EVLIST_DISABLED_MSG);
> -		usleep(stat_config.initial_delay * USEC_PER_MSEC);
> -	}
> -
>  	/*
>  	 * We need to enable counters only if:
>  	 * - we don't have tracee (attaching to task or cpu)
>  	 * - we have initial delay configured
>  	 */
> -	if (!target__none(&target) || stat_config.initial_delay) {
> +	if (!target__none(&target)) {
>  		if (!all_counters_use_bpf)
>  			evlist__enable(evsel_list);
> -		if (stat_config.initial_delay > 0)
> -			pr_info(EVLIST_ENABLED_MSG);
>  	}
>  	return 0;
>  }
> @@ -930,14 +918,27 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  			return err;
>  	}
>  
> -	err = enable_counters();
> -	if (err)
> -		return -1;
> +	if (stat_config.initial_delay) {
> +		pr_info(EVLIST_DISABLED_MSG);
> +	} else {
> +		err = enable_counters();
> +		if (err)
> +			return -1;
> +	}
>  
>  	/* Exec the command, if any */
>  	if (forks)
>  		evlist__start_workload(evsel_list);
>  
> +	if (stat_config.initial_delay > 0) {
> +		usleep(stat_config.initial_delay * USEC_PER_MSEC);
> +		err = enable_counters();
> +		if (err)
> +			return -1;
> +
> +		pr_info(EVLIST_ENABLED_MSG);
> +	}
> +
>  	t0 = rdclock();
>  	clock_gettime(CLOCK_MONOTONIC, &ref_time);
>  

Tested successfully on s390

Acked-by: Thomas Richter <tmricht@linux.ibm.com>
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

