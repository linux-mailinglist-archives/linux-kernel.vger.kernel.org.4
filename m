Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476116EC4CF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 07:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjDXF0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 01:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjDXF0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 01:26:22 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D04F3AA1;
        Sun, 23 Apr 2023 22:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682313972; x=1713849972;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=A4rc31KYeVJBpHTLDvky7O/zbkWT4gnwpXpbYz/2HdE=;
  b=SmroYSRom92xOV1wkrkqs8SbTrC/VKRLjvz8YWEQsG9js2SEvWYX75JA
   xqG4g71x3ihnS5KECDf5e2BgYJm1fFAnpgdEeZ0wjydiS4UCLphP+laov
   vjtJwn6wR4XiSi7rTiV3bYDJIF0k3kCOQQraxHsbQlsReN0tdY2eKBEqt
   xWXQfYcVYhGWa8FZi9ReNbNyUFfF+ozukpBn7tTNcHaCD27ac/IEsiBLH
   2Iwwfi/j7hcbS8hVH9ZXsj2DDDu/y93DvIi4b2LXLtpUP//nTteWW+jLW
   2c4nU5WjG3GpyleL35TLj91p7dNuHnstMMCoXGDMPjyCAYUgsX9Dpfv0g
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="343844865"
X-IronPort-AV: E=Sophos;i="5.99,221,1677571200"; 
   d="scan'208";a="343844865"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 22:26:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="867353775"
X-IronPort-AV: E=Sophos;i="5.99,221,1677571200"; 
   d="scan'208";a="867353775"
Received: from faerberc-mobl2.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.58.217])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 22:26:06 -0700
Message-ID: <3a21fe26-9ff3-b04f-4913-84f0cf2b4100@intel.com>
Date:   Mon, 24 Apr 2023 08:26:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v5 3/3] perf: script: add new output field 'dsoff' to
 print dso offset
Content-Language: en-US
To:     Changbin Du <changbin.du@huawei.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hui Wang <hw.huiwang@huawei.com>
References: <20230418031825.1262579-1-changbin.du@huawei.com>
 <20230418031825.1262579-4-changbin.du@huawei.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230418031825.1262579-4-changbin.du@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/23 06:18, Changbin Du wrote:
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

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/Documentation/perf-script.txt |  2 +-
>  tools/perf/builtin-script.c              | 60 ++++++++++--------------
>  tools/perf/util/evsel_fprintf.c          | 16 +++----
>  tools/perf/util/evsel_fprintf.h          |  1 +
>  4 files changed, 32 insertions(+), 47 deletions(-)
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
> index 8fba247b798c..e7cb8d904eb5 100644
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
> @@ -574,6 +576,9 @@ static void set_print_ip_opts(struct perf_event_attr *attr)
>  	if (PRINT_FIELD(DSO))
>  		output[type].print_ip_opts |= EVSEL__PRINT_DSO;
>  
> +	if (PRINT_FIELD(DSOFF))
> +		output[type].print_ip_opts |= EVSEL__PRINT_DSOFF;
> +
>  	if (PRINT_FIELD(SYMOFFSET))
>  		output[type].print_ip_opts |= EVSEL__PRINT_SYMOFFSET;
>  
> @@ -627,6 +632,10 @@ static int perf_session__check_output_opt(struct perf_session *session)
>  		if (evsel == NULL)
>  			continue;
>  
> +		/* 'dsoff' implys 'dso' field */
> +		if (output[j].fields & PERF_OUTPUT_DSOFF)
> +			output[j].fields |= PERF_OUTPUT_DSO;
> +
>  		set_print_ip_opts(&evsel->core.attr);
>  		tod |= output[j].fields & PERF_OUTPUT_TOD;
>  	}
> @@ -929,18 +938,12 @@ static int perf_sample__fprintf_brstack(struct perf_sample *sample,
>  		}
>  
>  		printed += fprintf(fp, " 0x%"PRIx64, from);
> -		if (PRINT_FIELD(DSO)) {
> -			printed += fprintf(fp, "(");
> -			printed += map__fprintf_dsoname(alf.map, fp);
> -			printed += fprintf(fp, ")");
> -		}
> +		if (PRINT_FIELD(DSO))
> +			printed += map__fprintf_dsoname_dsoff(alf.map, PRINT_FIELD(DSOFF), alf.addr, fp);
>  
>  		printed += fprintf(fp, "/0x%"PRIx64, to);
> -		if (PRINT_FIELD(DSO)) {
> -			printed += fprintf(fp, "(");
> -			printed += map__fprintf_dsoname(alt.map, fp);
> -			printed += fprintf(fp, ")");
> -		}
> +		if (PRINT_FIELD(DSO))
> +			printed += map__fprintf_dsoname_dsoff(alt.map, PRINT_FIELD(DSOFF), alt.addr, fp);
>  
>  		printed += print_bstack_flags(fp, entries + i);
>  	}
> @@ -972,18 +975,12 @@ static int perf_sample__fprintf_brstacksym(struct perf_sample *sample,
>  		thread__find_symbol_fb(thread, sample->cpumode, to, &alt);
>  
>  		printed += symbol__fprintf_symname_offs(alf.sym, &alf, fp);
> -		if (PRINT_FIELD(DSO)) {
> -			printed += fprintf(fp, "(");
> -			printed += map__fprintf_dsoname(alf.map, fp);
> -			printed += fprintf(fp, ")");
> -		}
> +		if (PRINT_FIELD(DSO))
> +			printed += map__fprintf_dsoname_dsoff(alf.map, PRINT_FIELD(DSOFF), alf.addr, fp);
>  		printed += fprintf(fp, "%c", '/');
>  		printed += symbol__fprintf_symname_offs(alt.sym, &alt, fp);
> -		if (PRINT_FIELD(DSO)) {
> -			printed += fprintf(fp, "(");
> -			printed += map__fprintf_dsoname(alt.map, fp);
> -			printed += fprintf(fp, ")");
> -		}
> +		if (PRINT_FIELD(DSO))
> +			printed += map__fprintf_dsoname_dsoff(alt.map, PRINT_FIELD(DSOFF), alt.addr, fp);
>  		printed += print_bstack_flags(fp, entries + i);
>  	}
>  
> @@ -1019,17 +1016,11 @@ static int perf_sample__fprintf_brstackoff(struct perf_sample *sample,
>  			to = map__dso_map_ip(alt.map, to);
>  
>  		printed += fprintf(fp, " 0x%"PRIx64, from);
> -		if (PRINT_FIELD(DSO)) {
> -			printed += fprintf(fp, "(");
> -			printed += map__fprintf_dsoname(alf.map, fp);
> -			printed += fprintf(fp, ")");
> -		}
> +		if (PRINT_FIELD(DSO))
> +			printed += map__fprintf_dsoname_dsoff(alf.map, PRINT_FIELD(DSOFF), alf.addr, fp);
>  		printed += fprintf(fp, "/0x%"PRIx64, to);
> -		if (PRINT_FIELD(DSO)) {
> -			printed += fprintf(fp, "(");
> -			printed += map__fprintf_dsoname(alt.map, fp);
> -			printed += fprintf(fp, ")");
> -		}
> +		if (PRINT_FIELD(DSO))
> +			printed += map__fprintf_dsoname_dsoff(alt.map, PRINT_FIELD(DSOFF), alt.addr, fp);
>  		printed += print_bstack_flags(fp, entries + i);
>  	}
>  
> @@ -1394,11 +1385,8 @@ static int perf_sample__fprintf_addr(struct perf_sample *sample,
>  			printed += symbol__fprintf_symname(al.sym, fp);
>  	}
>  
> -	if (PRINT_FIELD(DSO)) {
> -		printed += fprintf(fp, " (");
> -		printed += map__fprintf_dsoname(al.map, fp);
> -		printed += fprintf(fp, ")");
> -	}
> +	if (PRINT_FIELD(DSO))
> +		printed += map__fprintf_dsoname_dsoff(al.map, PRINT_FIELD(DSOFF), al.addr, fp);
>  out:
>  	return printed;
>  }
> @@ -3877,7 +3865,7 @@ int cmd_script(int argc, const char **argv)
>  		     "comma separated output fields prepend with 'type:'. "
>  		     "+field to add and -field to remove."
>  		     "Valid types: hw,sw,trace,raw,synth. "
> -		     "Fields: comm,tid,pid,time,cpu,event,trace,ip,sym,dso,"
> +		     "Fields: comm,tid,pid,time,cpu,event,trace,ip,sym,dso,dsoff"
>  		     "addr,symoff,srcline,period,iregs,uregs,brstack,"
>  		     "brstacksym,flags,data_src,weight,bpf-output,brstackinsn,"
>  		     "brstackinsnlen,brstackoff,callindent,insn,insnlen,synth,"
> diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
> index cc80ec554c0a..79e42d66f55b 100644
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
> @@ -171,11 +172,8 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
>  				}
>  			}
>  
> -			if (print_dso && (!sym || !sym->inlined)) {
> -				printed += fprintf(fp, " (");
> -				printed += map__fprintf_dsoname(map, fp);
> -				printed += fprintf(fp, ")");
> -			}
> +			if (print_dso && (!sym || !sym->inlined))
> +				printed += map__fprintf_dsoname_dsoff(map, print_dsoff, addr, fp);
>  
>  			if (print_srcline)
>  				printed += map__fprintf_srcline(map, addr, "\n  ", fp);
> @@ -209,6 +207,7 @@ int sample__fprintf_sym(struct perf_sample *sample, struct addr_location *al,
>  	int print_ip = print_opts & EVSEL__PRINT_IP;
>  	int print_sym = print_opts & EVSEL__PRINT_SYM;
>  	int print_dso = print_opts & EVSEL__PRINT_DSO;
> +	int print_dsoff = print_opts & EVSEL__PRINT_DSOFF;
>  	int print_symoffset = print_opts & EVSEL__PRINT_SYMOFFSET;
>  	int print_srcline = print_opts & EVSEL__PRINT_SRCLINE;
>  	int print_unknown_as_addr = print_opts & EVSEL__PRINT_UNKNOWN_AS_ADDR;
> @@ -234,11 +233,8 @@ int sample__fprintf_sym(struct perf_sample *sample, struct addr_location *al,
>  			}
>  		}
>  
> -		if (print_dso) {
> -			printed += fprintf(fp, " (");
> -			printed += map__fprintf_dsoname(al->map, fp);
> -			printed += fprintf(fp, ")");
> -		}
> +		if (print_dso)
> +			printed += map__fprintf_dsoname_dsoff(al->map, print_dsoff, al->addr, fp);
>  
>  		if (print_srcline)
>  			printed += map__fprintf_srcline(al->map, al->addr, "\n  ", fp);
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

