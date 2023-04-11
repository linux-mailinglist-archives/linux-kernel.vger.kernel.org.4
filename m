Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6156DD666
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 11:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjDKJQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 05:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDKJP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 05:15:59 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C6E194;
        Tue, 11 Apr 2023 02:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681204558; x=1712740558;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rCgY2hqUMTlxHSZEcEyTur7wyD5ha6j9k2gnWyYc3qw=;
  b=ckXuhjo9JSyxIflqcABevE5MlHsm37IkVkpNOsaTYvqD5SS5N3wWRTjD
   gTuPBNLi5RhJ7zPiPt/qlruKlEpXqpZXETKotBMgyOSUwiLdBVO5DLGto
   704zQeWm7OB0mV+/JDsbmwhWy6GhHoUJ5eBzfnhTVx4Mmo96jpUXjD9OV
   qvXRnhw9DseUgcsz8jEuQsukcy8Oltmz4GtpeIny8KAr8RVg07R/PcCRJ
   CgAYBgIfMLclvgfTN1ctVQxiDEd1NJHVFlQvbc6dJGO/JhZpg/tsnUM4S
   ithLunNyoCbdF5Ercb6eBcmBYOSFHWhEIYp5CxYPwfUSBzhCwWv7S9Zpb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="345349943"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="345349943"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 02:15:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="688537476"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="688537476"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.44.57])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 02:15:54 -0700
Message-ID: <696dd16a-bd1a-1a55-4024-57c8bc899c31@intel.com>
Date:   Tue, 11 Apr 2023 12:15:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.1
Subject: Re: [PATCH v3 2/2] perf: script: add new output field 'dsoff' to
 print dso offset
Content-Language: en-US
To:     Changbin Du <changbin.du@huawei.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hui Wang <hw.huiwang@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
References: <20230410070858.4051548-1-changbin.du@huawei.com>
 <20230410070858.4051548-3-changbin.du@huawei.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230410070858.4051548-3-changbin.du@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/23 10:08, Changbin Du wrote:
> This adds a new 'dsoff' field to print dso offset for resolved symbols,
> and the offset is appended to dso name.
> 
> Default output:
> $ perf script
>        ls 2695501 3011030.487017:     500000 cycles:      152cc73ef4b5 get_common_indices.constprop.0+0x155 (/usr/lib/x86_64-linux-gnu/ld-2.31.so)
>        ls 2695501 3011030.487018:     500000 cycles:  ffffffff99045b3e [unknown] ([unknown])
>        ls 2695501 3011030.487018:     500000 cycles:  ffffffff9968e107 [unknown] ([unknown])
>        ls 2695501 3011030.487018:     500000 cycles:  ffffffffc1f54afb [unknown] ([unknown])
>        ls 2695501 3011030.487018:     500000 cycles:  ffffffff9968382f [unknown] ([unknown])
>        ls 2695501 3011030.487019:     500000 cycles:  ffffffff99e00094 [unknown] ([unknown])
>        ls 2695501 3011030.487019:     500000 cycles:      152cc718a8d0 __errno_location@plt+0x0 (/usr/lib/x86_64-linux-gnu/libselinux.so.1)
> 
> Display 'dsoff' field:
> $ perf script -F +dsoff
>        ls 2695501 3011030.487017:     500000 cycles:      152cc73ef4b5 get_common_indices.constprop.0+0x155 (/usr/lib/x86_64-linux-gnu/ld-2.31.so+0x1c4b5)
>        ls 2695501 3011030.487018:     500000 cycles:  ffffffff99045b3e [unknown] ([unknown])
>        ls 2695501 3011030.487018:     500000 cycles:  ffffffff9968e107 [unknown] ([unknown])
>        ls 2695501 3011030.487018:     500000 cycles:  ffffffffc1f54afb [unknown] ([unknown])
>        ls 2695501 3011030.487018:     500000 cycles:  ffffffff9968382f [unknown] ([unknown])
>        ls 2695501 3011030.487019:     500000 cycles:  ffffffff99e00094 [unknown] ([unknown])
>        ls 2695501 3011030.487019:     500000 cycles:      152cc718a8d0 __errno_location@plt+0x0 (/usr/lib/x86_64-linux-gnu/libselinux.so.1+0x68d0)
>        ls 2695501 3011030.487019:     500000 cycles:  ffffffff992a6db0 [unknown] ([unknown])
> 
> Signed-off-by: Changbin Du <changbin.du@huawei.com>
> ---
>  tools/perf/Documentation/perf-script.txt | 2 +-
>  tools/perf/builtin-script.c              | 9 ++++++++-
>  tools/perf/util/evsel_fprintf.c          | 6 ++++++
>  tools/perf/util/evsel_fprintf.h          | 1 +
>  4 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
> index 777a0d8ba7d1..ff9a52e44688 100644
> --- a/tools/perf/Documentation/perf-script.txt
> +++ b/tools/perf/Documentation/perf-script.txt
> @@ -130,7 +130,7 @@ OPTIONS
>  -F::
>  --fields::
>          Comma separated list of fields to print. Options are:
> -        comm, tid, pid, time, cpu, event, trace, ip, sym, dso, addr, symoff,
> +        comm, tid, pid, time, cpu, event, trace, ip, sym, dso, dsoff, addr, symoff,
>          srcline, period, iregs, uregs, brstack, brstacksym, flags, bpf-output,
>          brstackinsn, brstackinsnlen, brstackoff, callindent, insn, insnlen, synth,
>          phys_addr, metric, misc, srccode, ipc, data_page_size, code_page_size, ins_lat,
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index a792214d1af8..bdc5de94cf43 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -133,6 +133,7 @@ enum perf_output_field {
>  	PERF_OUTPUT_VCPU            = 1ULL << 38,
>  	PERF_OUTPUT_CGROUP          = 1ULL << 39,
>  	PERF_OUTPUT_RETIRE_LAT      = 1ULL << 40,
> +	PERF_OUTPUT_DSOFF           = 1ULL << 41,
>  };
>  
>  struct perf_script {
> @@ -174,6 +175,7 @@ struct output_option {
>  	{.str = "ip",    .field = PERF_OUTPUT_IP},
>  	{.str = "sym",   .field = PERF_OUTPUT_SYM},
>  	{.str = "dso",   .field = PERF_OUTPUT_DSO},
> +	{.str = "dsoff", .field = PERF_OUTPUT_DSOFF},
>  	{.str = "addr",  .field = PERF_OUTPUT_ADDR},
>  	{.str = "symoff", .field = PERF_OUTPUT_SYMOFFSET},
>  	{.str = "srcline", .field = PERF_OUTPUT_SRCLINE},
> @@ -574,6 +576,11 @@ static void set_print_ip_opts(struct perf_event_attr *attr)
>  	if (PRINT_FIELD(DSO))
>  		output[type].print_ip_opts |= EVSEL__PRINT_DSO;
>  
> +	if (PRINT_FIELD(DSOFF)) {
> +		/* 'dsoff' implys 'dso' field for printing */
> +		output[type].print_ip_opts |= EVSEL__PRINT_DSO | EVSEL__PRINT_DSOFF;
> +	}
> +
>  	if (PRINT_FIELD(SYMOFFSET))
>  		output[type].print_ip_opts |= EVSEL__PRINT_SYMOFFSET;
>  
> @@ -3881,7 +3888,7 @@ int cmd_script(int argc, const char **argv)
>  		     "comma separated output fields prepend with 'type:'. "
>  		     "+field to add and -field to remove."
>  		     "Valid types: hw,sw,trace,raw,synth. "
> -		     "Fields: comm,tid,pid,time,cpu,event,trace,ip,sym,dso,"
> +		     "Fields: comm,tid,pid,time,cpu,event,trace,ip,sym,dso,dsoff"
>  		     "addr,symoff,srcline,period,iregs,uregs,brstack,"
>  		     "brstacksym,flags,data_src,weight,bpf-output,brstackinsn,"
>  		     "brstackinsnlen,brstackoff,callindent,insn,insnlen,synth,"
> diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
> index 1fb8044d402e..ae8333772c76 100644
> --- a/tools/perf/util/evsel_fprintf.c
> +++ b/tools/perf/util/evsel_fprintf.c
> @@ -116,6 +116,7 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
>  	int print_ip = print_opts & EVSEL__PRINT_IP;
>  	int print_sym = print_opts & EVSEL__PRINT_SYM;
>  	int print_dso = print_opts & EVSEL__PRINT_DSO;
> +	int print_dsoff = print_opts & EVSEL__PRINT_DSOFF;
>  	int print_symoffset = print_opts & EVSEL__PRINT_SYMOFFSET;
>  	int print_oneline = print_opts & EVSEL__PRINT_ONELINE;
>  	int print_srcline = print_opts & EVSEL__PRINT_SRCLINE;
> @@ -174,6 +175,8 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
>  			if (print_dso && (!sym || !sym->inlined)) {
>  				printed += fprintf(fp, " (");
>  				printed += map__fprintf_dsoname(map, fp);
> +				if (print_dsoff && map && map->dso)
> +					printed += fprintf(fp, "+0x%lx", addr);
>  				printed += fprintf(fp, ")");
>  			}
>  
> @@ -209,6 +212,7 @@ int sample__fprintf_sym(struct perf_sample *sample, struct addr_location *al,
>  	int print_ip = print_opts & EVSEL__PRINT_IP;
>  	int print_sym = print_opts & EVSEL__PRINT_SYM;
>  	int print_dso = print_opts & EVSEL__PRINT_DSO;
> +	int print_dsoff = print_opts & EVSEL__PRINT_DSOFF;
>  	int print_symoffset = print_opts & EVSEL__PRINT_SYMOFFSET;
>  	int print_srcline = print_opts & EVSEL__PRINT_SRCLINE;
>  	int print_unknown_as_addr = print_opts & EVSEL__PRINT_UNKNOWN_AS_ADDR;
> @@ -237,6 +241,8 @@ int sample__fprintf_sym(struct perf_sample *sample, struct addr_location *al,
>  		if (print_dso) {
>  			printed += fprintf(fp, " (");
>  			printed += map__fprintf_dsoname(al->map, fp);
> +			if (print_dsoff && al->map && al->map->dso)
> +				printed += fprintf(fp, "+0x%lx", al->addr);

There are a lot of map__fprintf_dsoname() callers that should
also support "dsoff".  In fact, probably all of them except
perf_sample__fprintf_callindent().

>  			printed += fprintf(fp, ")");
>  		}
>  
> diff --git a/tools/perf/util/evsel_fprintf.h b/tools/perf/util/evsel_fprintf.h
> index 3093d096c29f..c8a9fac2f2dd 100644
> --- a/tools/perf/util/evsel_fprintf.h
> +++ b/tools/perf/util/evsel_fprintf.h
> @@ -26,6 +26,7 @@ int evsel__fprintf(struct evsel *evsel, struct perf_attr_details *details, FILE
>  #define EVSEL__PRINT_UNKNOWN_AS_ADDR	(1<<6)
>  #define EVSEL__PRINT_CALLCHAIN_ARROW	(1<<7)
>  #define EVSEL__PRINT_SKIP_IGNORED	(1<<8)
> +#define EVSEL__PRINT_DSOFF		(1<<9)
>  
>  struct addr_location;
>  struct perf_event_attr;

