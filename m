Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC76E7191FF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 06:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjFAEux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 00:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjFAEuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 00:50:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45DCD1;
        Wed, 31 May 2023 21:50:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42ED561BAC;
        Thu,  1 Jun 2023 04:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8F4C433EF;
        Thu,  1 Jun 2023 04:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685595048;
        bh=RHVZH7WRu1nGQ/cR8ffq3B7RnxWE2PAELt/zag6MBoE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=agmyHnLHdmJkIAOnhwNfS41nr+evRYGn4k01SURML2zVwzGUXVjXIleakFvXhxf+y
         nkqresnTZYB9ZH8IVMjZk6Y2ZRIzrMvXeL4OeZ7Y2LRcbeH2FEj5+CjUTdpn72f7sM
         whBL9yXZrT27sr6pxp9k8Do8BG9n2/3x72Gg0UDf7HNp63bUMGWPeQvr4AUQ8pDENm
         PNgkzbZEd5qJgsSYaIBUUXP2Ba7DMHLfVuKrDaW2DpO3koV6Vk+7C+WK1tF16Tr8vC
         5CVh9RBecIFgCYj+Ag2yT/REWp1K/ZaUDRSE85foYp+WrOvVJCFB99wqd3zDybMOBL
         8Hc58XYjWcysA==
Date:   Thu, 1 Jun 2023 13:50:43 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Ross Zwisler <zwisler@chromium.org>,
        Leo Yan <leo.yan@linaro.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 11/16] perf probe: Dynamically allocate params memory
Message-Id: <20230601135043.2aa1cf09927b0f66befb11cf@kernel.org>
In-Reply-To: <20230526183401.2326121-12-irogers@google.com>
References: <20230526183401.2326121-1-irogers@google.com>
        <20230526183401.2326121-12-irogers@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 May 2023 11:33:56 -0700
Ian Rogers <irogers@google.com> wrote:

> Avoid 14,432 bytes in .bss by dynamically allocating params.
> 

Looks good to me. This may reduce memory consumption if we don't use
perf probe.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-probe.c | 133 ++++++++++++++++++++-----------------
>  1 file changed, 71 insertions(+), 62 deletions(-)
> 
> diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
> index 4df05b992093..019fef8da6a8 100644
> --- a/tools/perf/builtin-probe.c
> +++ b/tools/perf/builtin-probe.c
> @@ -47,29 +47,29 @@ static struct {
>  	char *target;
>  	struct strfilter *filter;
>  	struct nsinfo *nsi;
> -} params;
> +} *params;
>  
>  /* Parse an event definition. Note that any error must die. */
>  static int parse_probe_event(const char *str)
>  {
> -	struct perf_probe_event *pev = &params.events[params.nevents];
> +	struct perf_probe_event *pev = &params->events[params->nevents];
>  	int ret;
>  
> -	pr_debug("probe-definition(%d): %s\n", params.nevents, str);
> -	if (++params.nevents == MAX_PROBES) {
> +	pr_debug("probe-definition(%d): %s\n", params->nevents, str);
> +	if (++params->nevents == MAX_PROBES) {
>  		pr_err("Too many probes (> %d) were specified.", MAX_PROBES);
>  		return -1;
>  	}
>  
> -	pev->uprobes = params.uprobes;
> -	if (params.target) {
> -		pev->target = strdup(params.target);
> +	pev->uprobes = params->uprobes;
> +	if (params->target) {
> +		pev->target = strdup(params->target);
>  		if (!pev->target)
>  			return -ENOMEM;
> -		params.target_used = true;
> +		params->target_used = true;
>  	}
>  
> -	pev->nsi = nsinfo__get(params.nsi);
> +	pev->nsi = nsinfo__get(params->nsi);
>  
>  	/* Parse a perf-probe command into event */
>  	ret = parse_perf_probe_command(str, pev);
> @@ -84,12 +84,12 @@ static int params_add_filter(const char *str)
>  	int ret = 0;
>  
>  	pr_debug2("Add filter: %s\n", str);
> -	if (!params.filter) {
> -		params.filter = strfilter__new(str, &err);
> -		if (!params.filter)
> +	if (!params->filter) {
> +		params->filter = strfilter__new(str, &err);
> +		if (!params->filter)
>  			ret = err ? -EINVAL : -ENOMEM;
>  	} else
> -		ret = strfilter__or(params.filter, str, &err);
> +		ret = strfilter__or(params->filter, str, &err);
>  
>  	if (ret == -EINVAL) {
>  		pr_err("Filter parse error at %td.\n", err - str + 1);
> @@ -112,17 +112,17 @@ static int set_target(const char *ptr)
>  	 * TODO: Support relative path, and $PATH, $LD_LIBRARY_PATH,
>  	 * short module name.
>  	 */
> -	if (!params.target && ptr && *ptr == '/') {
> -		params.target = strdup(ptr);
> -		if (!params.target)
> +	if (!params->target && ptr && *ptr == '/') {
> +		params->target = strdup(ptr);
> +		if (!params->target)
>  			return -ENOMEM;
> -		params.target_used = false;
> +		params->target_used = false;
>  
>  		found = 1;
>  		buf = ptr + (strlen(ptr) - 3);
>  
>  		if (strcmp(buf, ".ko"))
> -			params.uprobes = true;
> +			params->uprobes = true;
>  
>  	}
>  
> @@ -172,15 +172,15 @@ static int opt_set_target(const struct option *opt, const char *str,
>  
>  	if  (str) {
>  		if (!strcmp(opt->long_name, "exec"))
> -			params.uprobes = true;
> +			params->uprobes = true;
>  		else if (!strcmp(opt->long_name, "module"))
> -			params.uprobes = false;
> +			params->uprobes = false;
>  		else
>  			return ret;
>  
>  		/* Expand given path to absolute path, except for modulename */
> -		if (params.uprobes || strchr(str, '/')) {
> -			tmp = nsinfo__realpath(str, params.nsi);
> +		if (params->uprobes || strchr(str, '/')) {
> +			tmp = nsinfo__realpath(str, params->nsi);
>  			if (!tmp) {
>  				pr_warning("Failed to get the absolute path of %s: %m\n", str);
>  				return ret;
> @@ -190,9 +190,9 @@ static int opt_set_target(const struct option *opt, const char *str,
>  			if (!tmp)
>  				return -ENOMEM;
>  		}
> -		free(params.target);
> -		params.target = tmp;
> -		params.target_used = false;
> +		free(params->target);
> +		params->target = tmp;
> +		params->target_used = false;
>  		ret = 0;
>  	}
>  
> @@ -217,7 +217,7 @@ static int opt_set_target_ns(const struct option *opt __maybe_unused,
>  		}
>  		nsip = nsinfo__new(ns_pid);
>  		if (nsip && nsinfo__need_setns(nsip))
> -			params.nsi = nsinfo__get(nsip);
> +			params->nsi = nsinfo__get(nsip);
>  		nsinfo__put(nsip);
>  
>  		ret = 0;
> @@ -238,14 +238,14 @@ static int opt_show_lines(const struct option *opt,
>  	if (!str)
>  		return 0;
>  
> -	if (params.command == 'L') {
> +	if (params->command == 'L') {
>  		pr_warning("Warning: more than one --line options are"
>  			   " detected. Only the first one is valid.\n");
>  		return 0;
>  	}
>  
> -	params.command = opt->short_name;
> -	ret = parse_line_range_desc(str, &params.line_range);
> +	params->command = opt->short_name;
> +	ret = parse_line_range_desc(str, &params->line_range);
>  
>  	return ret;
>  }
> @@ -253,7 +253,7 @@ static int opt_show_lines(const struct option *opt,
>  static int opt_show_vars(const struct option *opt,
>  			 const char *str, int unset __maybe_unused)
>  {
> -	struct perf_probe_event *pev = &params.events[params.nevents];
> +	struct perf_probe_event *pev = &params->events[params->nevents];
>  	int ret;
>  
>  	if (!str)
> @@ -264,7 +264,7 @@ static int opt_show_vars(const struct option *opt,
>  		pr_err("  Error: '--vars' doesn't accept arguments.\n");
>  		return -EINVAL;
>  	}
> -	params.command = opt->short_name;
> +	params->command = opt->short_name;
>  
>  	return ret;
>  }
> @@ -276,7 +276,7 @@ static int opt_add_probe_event(const struct option *opt,
>  			      const char *str, int unset __maybe_unused)
>  {
>  	if (str) {
> -		params.command = opt->short_name;
> +		params->command = opt->short_name;
>  		return parse_probe_event(str);
>  	}
>  
> @@ -287,7 +287,7 @@ static int opt_set_filter_with_command(const struct option *opt,
>  				       const char *str, int unset)
>  {
>  	if (!unset)
> -		params.command = opt->short_name;
> +		params->command = opt->short_name;
>  
>  	if (str)
>  		return params_add_filter(str);
> @@ -306,20 +306,29 @@ static int opt_set_filter(const struct option *opt __maybe_unused,
>  
>  static int init_params(void)
>  {
> -	return line_range__init(&params.line_range);
> +	int ret;
> +
> +	params = calloc(1, sizeof(*params));
> +	if (!params)
> +		return -ENOMEM;
> +
> +	ret = line_range__init(&params->line_range);
> +	if (ret)
> +		zfree(&params);
> +	return ret;
>  }
>  
>  static void cleanup_params(void)
>  {
>  	int i;
>  
> -	for (i = 0; i < params.nevents; i++)
> -		clear_perf_probe_event(params.events + i);
> -	line_range__clear(&params.line_range);
> -	free(params.target);
> -	strfilter__delete(params.filter);
> -	nsinfo__put(params.nsi);
> -	memset(&params, 0, sizeof(params));
> +	for (i = 0; i < params->nevents; i++)
> +		clear_perf_probe_event(params->events + i);
> +	line_range__clear(&params->line_range);
> +	free(params->target);
> +	strfilter__delete(params->filter);
> +	nsinfo__put(params->nsi);
> +	zfree(&params);
>  }
>  
>  static void pr_err_with_code(const char *msg, int err)
> @@ -346,7 +355,7 @@ static int perf_add_probe_events(struct perf_probe_event *pevs, int npevs)
>  	if (ret < 0)
>  		goto out_cleanup;
>  
> -	if (params.command == 'D') {	/* it shows definition */
> +	if (params->command == 'D') {	/* it shows definition */
>  		if (probe_conf.bootconfig)
>  			ret = show_bootconfig_events(pevs, npevs);
>  		else
> @@ -635,7 +644,7 @@ __cmd_probe(int argc, const char **argv)
>  			usage_with_options_msg(probe_usage, options,
>  				"'-' is not supported.\n");
>  		}
> -		if (params.command && params.command != 'a') {
> +		if (params->command && params->command != 'a') {
>  			usage_with_options_msg(probe_usage, options,
>  				"another command except --add is set.\n");
>  		}
> @@ -644,7 +653,7 @@ __cmd_probe(int argc, const char **argv)
>  			pr_err_with_code("  Error: Command Parse Error.", ret);
>  			return ret;
>  		}
> -		params.command = 'a';
> +		params->command = 'a';
>  	}
>  
>  	ret = symbol__validate_sym_arguments();
> @@ -664,54 +673,54 @@ __cmd_probe(int argc, const char **argv)
>  	 * nor change running kernel. So if user gives offline vmlinux,
>  	 * ignore its buildid.
>  	 */
> -	if (!strchr("lda", params.command) && symbol_conf.vmlinux_name)
> +	if (!strchr("lda", params->command) && symbol_conf.vmlinux_name)
>  		symbol_conf.ignore_vmlinux_buildid = true;
>  
> -	switch (params.command) {
> +	switch (params->command) {
>  	case 'l':
> -		if (params.uprobes) {
> +		if (params->uprobes) {
>  			pr_err("  Error: Don't use --list with --exec.\n");
>  			parse_options_usage(probe_usage, options, "l", true);
>  			parse_options_usage(NULL, options, "x", true);
>  			return -EINVAL;
>  		}
> -		ret = show_perf_probe_events(params.filter);
> +		ret = show_perf_probe_events(params->filter);
>  		if (ret < 0)
>  			pr_err_with_code("  Error: Failed to show event list.", ret);
>  		return ret;
>  	case 'F':
> -		ret = show_available_funcs(params.target, params.nsi,
> -					   params.filter, params.uprobes);
> +		ret = show_available_funcs(params->target, params->nsi,
> +					   params->filter, params->uprobes);
>  		if (ret < 0)
>  			pr_err_with_code("  Error: Failed to show functions.", ret);
>  		return ret;
>  #ifdef HAVE_DWARF_SUPPORT
>  	case 'L':
> -		ret = show_line_range(&params.line_range, params.target,
> -				      params.nsi, params.uprobes);
> +		ret = show_line_range(&params->line_range, params->target,
> +				      params->nsi, params->uprobes);
>  		if (ret < 0)
>  			pr_err_with_code("  Error: Failed to show lines.", ret);
>  		return ret;
>  	case 'V':
> -		if (!params.filter)
> -			params.filter = strfilter__new(DEFAULT_VAR_FILTER,
> +		if (!params->filter)
> +			params->filter = strfilter__new(DEFAULT_VAR_FILTER,
>  						       NULL);
>  
> -		ret = show_available_vars(params.events, params.nevents,
> -					  params.filter);
> +		ret = show_available_vars(params->events, params->nevents,
> +					  params->filter);
>  		if (ret < 0)
>  			pr_err_with_code("  Error: Failed to show vars.", ret);
>  		return ret;
>  #endif
>  	case 'd':
> -		ret = perf_del_probe_events(params.filter);
> +		ret = perf_del_probe_events(params->filter);
>  		if (ret < 0) {
>  			pr_err_with_code("  Error: Failed to delete events.", ret);
>  			return ret;
>  		}
>  		break;
>  	case 'D':
> -		if (probe_conf.bootconfig && params.uprobes) {
> +		if (probe_conf.bootconfig && params->uprobes) {
>  			pr_err("  Error: --bootconfig doesn't support uprobes.\n");
>  			return -EINVAL;
>  		}
> @@ -719,25 +728,25 @@ __cmd_probe(int argc, const char **argv)
>  	case 'a':
>  
>  		/* Ensure the last given target is used */
> -		if (params.target && !params.target_used) {
> +		if (params->target && !params->target_used) {
>  			pr_err("  Error: -x/-m must follow the probe definitions.\n");
>  			parse_options_usage(probe_usage, options, "m", true);
>  			parse_options_usage(NULL, options, "x", true);
>  			return -EINVAL;
>  		}
>  
> -		ret = perf_add_probe_events(params.events, params.nevents);
> +		ret = perf_add_probe_events(params->events, params->nevents);
>  		if (ret < 0) {
>  
>  			/*
>  			 * When perf_add_probe_events() fails it calls
>  			 * cleanup_perf_probe_events(pevs, npevs), i.e.
> -			 * cleanup_perf_probe_events(params.events, params.nevents), which
> +			 * cleanup_perf_probe_events(params->events, params->nevents), which
>  			 * will call clear_perf_probe_event(), so set nevents to zero
>  			 * to avoid cleanup_params() to call clear_perf_probe_event() again
>  			 * on the same pevs.
>  			 */
> -			params.nevents = 0;
> +			params->nevents = 0;
>  			pr_err_with_code("  Error: Failed to add events.", ret);
>  			return ret;
>  		}
> -- 
> 2.41.0.rc0.172.g3f132b7071-goog
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
