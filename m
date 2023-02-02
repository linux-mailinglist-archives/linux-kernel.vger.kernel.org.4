Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE196872F8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 02:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjBBB0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 20:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBBB0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 20:26:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CAD6A708;
        Wed,  1 Feb 2023 17:26:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6C50B8239F;
        Thu,  2 Feb 2023 01:26:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CCFCC433D2;
        Thu,  2 Feb 2023 01:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675301185;
        bh=GjlSobq/0GLs0kIZ/OZh8aH3S8Ty/OXrrUrXTz8KksA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZeCvZd9REBiD84Q5ZNaFE5kPtPAMz5l5l2td0C4D154tkyrzguI1h0IfRbUdqo9wc
         DbYaR16ilYBEgKZvfGDoTrNl1zVvNAscEqFPvs1q24LAti4uCD1wLQCjDMcfAOIRlg
         0CnRDo1pey/b7jQFHml7LUifX3B8Fz5y6TloGy7EXWMnaccDWm3PDG3ZQB/RZoNNrq
         UenRrRkcR9WYE10T1jJD6GyKTJqO17gJNhNylBjcsT1eg9fnx3mXfCN2/tqtuYGLkz
         gEvtlLgkJQM+OuahD3ukr6siy4qS8oATZ6o3qT4sspbj4TE0F9KlCRFYughC5i6tAy
         ZGJoitbxg+rlA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AE73E405BE; Wed,  1 Feb 2023 22:26:22 -0300 (-03)
Date:   Wed, 1 Feb 2023 22:26:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2] perf script: Add 'cgroup' field for output
Message-ID: <Y9sRPi3hr/tvpyaM@kernel.org>
References: <20230126213610.3381147-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126213610.3381147-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 26, 2023 at 01:36:10PM -0800, Namhyung Kim escreveu:
> There's no field for the cgroup, let's add one.  To do that, users need to
> specify --all-cgroup option for perf record to capture the cgroup info.
> 
>   $ perf record --all-cgroups -- true
> 
>   $ perf script -F comm,pid,cgroup
>             true 337112  /user.slice/user-657345.slice/user@657345.service/...
>             true 337112  /user.slice/user-657345.slice/user@657345.service/...
>             true 337112  /user.slice/user-657345.slice/user@657345.service/...
>             true 337112  /user.slice/user-657345.slice/user@657345.service/...
> 
> If it's recorded without the --all-cgroups, it'd complain.
> 
>   $ perf script -F comm,pid,cgroup
>   Samples for 'cycles:u' event do not have CGROUP attribute set. Cannot print 'cgroup' field.
>   Hint: run 'perf record --all-cgroups ...'

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/Documentation/perf-script.txt |  5 ++++-
>  tools/perf/builtin-script.c              | 22 +++++++++++++++++++++-
>  2 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
> index 8d77182fbf31..a2ebadc9d948 100644
> --- a/tools/perf/Documentation/perf-script.txt
> +++ b/tools/perf/Documentation/perf-script.txt
> @@ -134,7 +134,7 @@ OPTIONS
>          srcline, period, iregs, uregs, brstack, brstacksym, flags, bpf-output,
>          brstackinsn, brstackinsnlen, brstackoff, callindent, insn, insnlen, synth,
>          phys_addr, metric, misc, srccode, ipc, data_page_size, code_page_size, ins_lat,
> -        machine_pid, vcpu.
> +        machine_pid, vcpu, cgroup.
>          Field list can be prepended with the type, trace, sw or hw,
>          to indicate to which event type the field list applies.
>          e.g., -F sw:comm,tid,time,ip,sym  and -F trace:time,cpu,trace
> @@ -231,6 +231,9 @@ OPTIONS
>  	perf inject to insert a perf.data file recorded inside a virtual machine into
>  	a perf.data file recorded on the host at the same time.
>  
> +	The cgroup fields requires sample having the cgroup id which is saved
> +	when "--all-cgroups" option is passed to 'perf record'.
> +
>  	Finally, a user may not set fields to none for all event types.
>  	i.e., -F "" is not allowed.
>  
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 69394ac0a20d..731821fd0d3e 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -59,6 +59,7 @@
>  #include "util/dlfilter.h"
>  #include "util/record.h"
>  #include "util/util.h"
> +#include "util/cgroup.h"
>  #include "perf.h"
>  
>  #include <linux/ctype.h>
> @@ -130,6 +131,7 @@ enum perf_output_field {
>  	PERF_OUTPUT_BRSTACKINSNLEN  = 1ULL << 36,
>  	PERF_OUTPUT_MACHINE_PID     = 1ULL << 37,
>  	PERF_OUTPUT_VCPU            = 1ULL << 38,
> +	PERF_OUTPUT_CGROUP          = 1ULL << 39,
>  };
>  
>  struct perf_script {
> @@ -200,6 +202,7 @@ struct output_option {
>  	{.str = "brstackinsnlen", .field = PERF_OUTPUT_BRSTACKINSNLEN},
>  	{.str = "machine_pid", .field = PERF_OUTPUT_MACHINE_PID},
>  	{.str = "vcpu", .field = PERF_OUTPUT_VCPU},
> +	{.str = "cgroup", .field = PERF_OUTPUT_CGROUP},
>  };
>  
>  enum {
> @@ -542,6 +545,12 @@ static int evsel__check_attr(struct evsel *evsel, struct perf_session *session)
>  	    evsel__check_stype(evsel, PERF_SAMPLE_WEIGHT_STRUCT, "WEIGHT_STRUCT", PERF_OUTPUT_INS_LAT))
>  		return -EINVAL;
>  
> +	if (PRINT_FIELD(CGROUP) &&
> +	    evsel__check_stype(evsel, PERF_SAMPLE_CGROUP, "CGROUP", PERF_OUTPUT_CGROUP)) {
> +		pr_err("Hint: run 'perf record --all-cgroups ...'\n");
> +		return -EINVAL;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -2220,6 +2229,17 @@ static void process_event(struct perf_script *script,
>  	if (PRINT_FIELD(CODE_PAGE_SIZE))
>  		fprintf(fp, " %s", get_page_size_name(sample->code_page_size, str));
>  
> +	if (PRINT_FIELD(CGROUP)) {
> +		const char *cgrp_name;
> +		struct cgroup *cgrp = cgroup__find(machine->env,
> +						   sample->cgroup);
> +		if (cgrp != NULL)
> +			cgrp_name = cgrp->name;
> +		else
> +			cgrp_name = "unknown";
> +		fprintf(fp, " %s", cgrp_name);
> +	}
> +
>  	perf_sample__fprintf_ipc(sample, attr, fp);
>  
>  	fprintf(fp, "\n");
> @@ -3856,7 +3876,7 @@ int cmd_script(int argc, const char **argv)
>  		     "brstacksym,flags,data_src,weight,bpf-output,brstackinsn,"
>  		     "brstackinsnlen,brstackoff,callindent,insn,insnlen,synth,"
>  		     "phys_addr,metric,misc,srccode,ipc,tod,data_page_size,"
> -		     "code_page_size,ins_lat",
> +		     "code_page_size,ins_lat,machine_pid,vcpu,cgroup",
>  		     parse_output_fields),
>  	OPT_BOOLEAN('a', "all-cpus", &system_wide,
>  		    "system-wide collection from all CPUs"),
> -- 
> 2.39.1.456.gfc5497dd1b-goog
> 

-- 

- Arnaldo
