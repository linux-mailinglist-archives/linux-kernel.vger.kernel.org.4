Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC4C6E3F14
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 07:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjDQFmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 01:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjDQFmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 01:42:01 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7091935B3;
        Sun, 16 Apr 2023 22:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681710119; x=1713246119;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RJMiBHhWXS/CTaGMp1qpFdE1UFN+kNutJ+cfgf5SjVQ=;
  b=VF2guojU+QmqbxaXw0/Iv3OSmYpQut/RUMqFEl9+siOOdwzIqUnkJlZJ
   Nuke3q0c0hKFucy8SH+6bCFMiNGrnwpn9oeeqST2OlwdArZj8tpbuGNxU
   nEMVd1cnBzj0HS8iPGy66U+O4ODYEtJA3qO0llwXTMhzPItHtZ5zXRH8Y
   ePWdvRhXcpjUpDRPeyabyt0+i+4G/XSFfNlbr4lLB8PDij7SfWtuGh69W
   uXlATBUy2KpTWtFWOZhMbUaMUet4so6zVm1JreL3XpXvANiPoRa3vRyj2
   B7D7J+cSKwD7/zmLYD/YWF/UlTbUcP3n4/sJ9kVEmZpmxg1oFfXH4eLq1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="346654895"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="346654895"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 22:40:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="720997059"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="720997059"
Received: from fgarrona-mobl.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.212.228])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 22:40:41 -0700
Message-ID: <7f629f24-d98a-8a7d-e464-46b0237adf96@intel.com>
Date:   Mon, 17 Apr 2023 08:40:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v4 2/2] perf: script: add new output field 'dsoff' to
 print dso offset
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
References: <20230414032547.2767909-1-changbin.du@huawei.com>
 <20230414032547.2767909-3-changbin.du@huawei.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230414032547.2767909-3-changbin.du@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/23 06:25, Changbin Du wrote:
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

Looks good, but patches do not apply to:

	git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf-tools-next

Note the use of map__dso(map) now.

Also the repeated dso printing code:

	printed += fprintf(fp, "(");
	printed += map__fprintf_dsoname(map, fp);
	if (PRINT_FIELD(DSOFF) && map && map__dso(map))
		printed += fprintf(fp, "+0x%" PRIx64, alf.addr);
	printed += fprintf(fp, ")");

is begging to be replaced by a helper function e.g.

	if (PRINT_FIELD(DSO))
		map__fprintf_dsoname_dsoff(map, PRINT_FIELD(DSOFF), addr, fp);

Perhaps another patch for that.

Also see comment further below.

> ---
>  tools/perf/Documentation/perf-script.txt |  2 +-
>  tools/perf/builtin-script.c              | 25 +++++++++++++++++++++++-
>  tools/perf/util/evsel_fprintf.c          |  6 ++++++
>  tools/perf/util/evsel_fprintf.h          |  1 +
>  4 files changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
> index 68e37de5fae4..20a1558c555f 100644
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
> index 69394ac0a20d..95dd6d650c21 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -130,6 +130,7 @@ enum perf_output_field {
>  	PERF_OUTPUT_BRSTACKINSNLEN  = 1ULL << 36,
>  	PERF_OUTPUT_MACHINE_PID     = 1ULL << 37,
>  	PERF_OUTPUT_VCPU            = 1ULL << 38,
> +	PERF_OUTPUT_DSOFF           = 1ULL << 39,
>  };
>  
>  struct perf_script {
> @@ -171,6 +172,7 @@ struct output_option {
>  	{.str = "ip",    .field = PERF_OUTPUT_IP},
>  	{.str = "sym",   .field = PERF_OUTPUT_SYM},
>  	{.str = "dso",   .field = PERF_OUTPUT_DSO},
> +	{.str = "dsoff", .field = PERF_OUTPUT_DSOFF},
>  	{.str = "addr",  .field = PERF_OUTPUT_ADDR},
>  	{.str = "symoff", .field = PERF_OUTPUT_SYMOFFSET},
>  	{.str = "srcline", .field = PERF_OUTPUT_SRCLINE},
> @@ -559,6 +561,9 @@ static void set_print_ip_opts(struct perf_event_attr *attr)
>  	if (PRINT_FIELD(DSO))
>  		output[type].print_ip_opts |= EVSEL__PRINT_DSO;
>  
> +	if (PRINT_FIELD(DSOFF))
> +		output[type].print_ip_opts |= EVSEL__PRINT_DSOFF;
> +
>  	if (PRINT_FIELD(SYMOFFSET))
>  		output[type].print_ip_opts |= EVSEL__PRINT_SYMOFFSET;
>  
> @@ -612,6 +617,10 @@ static int perf_session__check_output_opt(struct perf_session *session)
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
> @@ -916,6 +925,8 @@ static int perf_sample__fprintf_brstack(struct perf_sample *sample,
>  		if (PRINT_FIELD(DSO)) {
>  			printed += fprintf(fp, "(");
>  			printed += map__fprintf_dsoname(alf.map, fp);
> +			if (PRINT_FIELD(DSOFF) && alf.map && alf.map->dso)
> +				printed += fprintf(fp, "+0x%lx", alf.addr);

Here and elsewhere, addr is a u64 so you
need to use PRIx64 e.g.

	printed += fprintf(fp, "+0x%" PRIx64, alf.addr);

>  			printed += fprintf(fp, ")");
>  		}
>  
> @@ -923,6 +934,8 @@ static int perf_sample__fprintf_brstack(struct perf_sample *sample,
>  		if (PRINT_FIELD(DSO)) {
>  			printed += fprintf(fp, "(");
>  			printed += map__fprintf_dsoname(alt.map, fp);
> +			if (PRINT_FIELD(DSOFF) && alt.map && alt.map->dso)
> +				printed += fprintf(fp, "+0x%lx", alt.addr);
>  			printed += fprintf(fp, ")");
>  		}
>  
> @@ -959,6 +972,8 @@ static int perf_sample__fprintf_brstacksym(struct perf_sample *sample,
>  		if (PRINT_FIELD(DSO)) {
>  			printed += fprintf(fp, "(");
>  			printed += map__fprintf_dsoname(alf.map, fp);
> +			if (PRINT_FIELD(DSOFF) && alf.map && alf.map->dso)
> +				printed += fprintf(fp, "+0x%lx", alf.addr);
>  			printed += fprintf(fp, ")");
>  		}
>  		printed += fprintf(fp, "%c", '/');
> @@ -966,6 +981,8 @@ static int perf_sample__fprintf_brstacksym(struct perf_sample *sample,
>  		if (PRINT_FIELD(DSO)) {
>  			printed += fprintf(fp, "(");
>  			printed += map__fprintf_dsoname(alt.map, fp);
> +			if (PRINT_FIELD(DSOFF) && alt.map && alt.map->dso)
> +				printed += fprintf(fp, "+0x%lx", alt.addr);
>  			printed += fprintf(fp, ")");
>  		}
>  		printed += print_bstack_flags(fp, entries + i);
> @@ -1006,12 +1023,16 @@ static int perf_sample__fprintf_brstackoff(struct perf_sample *sample,
>  		if (PRINT_FIELD(DSO)) {
>  			printed += fprintf(fp, "(");
>  			printed += map__fprintf_dsoname(alf.map, fp);
> +			if (PRINT_FIELD(DSOFF) && alf.map && alf.map->dso)
> +				printed += fprintf(fp, "+0x%lx", alf.addr);
>  			printed += fprintf(fp, ")");
>  		}
>  		printed += fprintf(fp, "/0x%"PRIx64, to);
>  		if (PRINT_FIELD(DSO)) {
>  			printed += fprintf(fp, "(");
>  			printed += map__fprintf_dsoname(alt.map, fp);
> +			if (PRINT_FIELD(DSOFF) && alt.map && alt.map->dso)
> +				printed += fprintf(fp, "+0x%lx", alt.addr);
>  			printed += fprintf(fp, ")");
>  		}
>  		printed += print_bstack_flags(fp, entries + i);
> @@ -1378,6 +1399,8 @@ static int perf_sample__fprintf_addr(struct perf_sample *sample,
>  	if (PRINT_FIELD(DSO)) {
>  		printed += fprintf(fp, " (");
>  		printed += map__fprintf_dsoname(al.map, fp);
> +		if (PRINT_FIELD(DSOFF) && al.map && al.map->dso)
> +			printed += fprintf(fp, "+0x%lx", al.addr);
>  		printed += fprintf(fp, ")");
>  	}
>  out:
> @@ -3851,7 +3874,7 @@ int cmd_script(int argc, const char **argv)
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

