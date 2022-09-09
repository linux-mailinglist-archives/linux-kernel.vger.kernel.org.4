Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA35D5B38DA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 15:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiIINXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiIINXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:23:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F54C10B578;
        Fri,  9 Sep 2022 06:23:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D246561FE4;
        Fri,  9 Sep 2022 13:23:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C240C43142;
        Fri,  9 Sep 2022 13:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662729784;
        bh=Wk0bJyJfH/o7KA0o1KB3udTJXEgUndQ3l/7kpVZGGXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CIHFhOb91bNGL4jXREjW5SAvMLo2tjvzE0L4Jbv+m+n21Eu0thmTMJ32wsDd0bxWS
         TfFo7qVcVFRJinDcdIy56QcROZ8o5w/HidlGqB4P+kdqHTguCqec6Jx+E1Hw8vYxq7
         E5tUK/pEh9U+8P6Ef3MaBtcDDFS9rZLB55xsHAyuKAvjxK84jPFhqkGp3etF7ppoQd
         tTersIwy7UZtQv0aURTrcrRCUGE0gisr9McdLNf7XBJsV/dvs19o1eF8/RHkW5GR92
         Tu3vDEQ79Oh9c2ZRa/dEwrYZOsXOqsOiJdb8VCC0oyvUl/cAmfBLDI361TNOOQfK8I
         Xh6VsMt0jkXEA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6F2D6404A1; Fri,  9 Sep 2022 10:23:01 -0300 (-03)
Date:   Fri, 9 Sep 2022 10:23:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Marco Elver <elver@google.com>,
        Song Liu <song@kernel.org>
Subject: Re: [PATCH v3] perf test: Skip sigtrap test on old kernels
Message-ID: <Yxs+NVE+6sQkIhEo@kernel.org>
References: <20220908230150.4105955-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908230150.4105955-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 08, 2022 at 04:01:50PM -0700, Namhyung Kim escreveu:
> If it runs on an old kernel, perf_event_open would fail because of the
> new fields sigtrap and sig_data.  Just skipping the test could miss an
> actual bug in the kernel.
> 
> Let's check BTF (when we have libbpf) if it has the sigtrap field in the
> perf_event_attr.  Otherwise, we can check it with a minimal event config.

Thanks, applied.

- Arnaldo

 
> Cc: Marco Elver <elver@google.com>
> Acked-by: Song Liu <song@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/sigtrap.c | 65 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 64 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/sigtrap.c b/tools/perf/tests/sigtrap.c
> index e32ece90e164..1de7478ec189 100644
> --- a/tools/perf/tests/sigtrap.c
> +++ b/tools/perf/tests/sigtrap.c
> @@ -54,6 +54,63 @@ static struct perf_event_attr make_event_attr(void)
>  	return attr;
>  }
>  
> +#ifdef HAVE_BPF_SKEL
> +#include <bpf/btf.h>
> +
> +static bool attr_has_sigtrap(void)
> +{
> +	bool ret = false;
> +	struct btf *btf;
> +	const struct btf_type *t;
> +	const struct btf_member *m;
> +	const char *name;
> +	int i, id;
> +
> +	btf = btf__load_vmlinux_btf();
> +	if (btf == NULL) {
> +		/* should be an old kernel */
> +		return false;
> +	}
> +
> +	id = btf__find_by_name_kind(btf, "perf_event_attr", BTF_KIND_STRUCT);
> +	if (id < 0)
> +		goto out;
> +
> +	t = btf__type_by_id(btf, id);
> +	for (i = 0, m = btf_members(t); i < btf_vlen(t); i++, m++) {
> +		name = btf__name_by_offset(btf, m->name_off);
> +		if (!strcmp(name, "sigtrap")) {
> +			ret = true;
> +			break;
> +		}
> +	}
> +out:
> +	btf__free(btf);
> +	return ret;
> +}
> +#else  /* !HAVE_BPF_SKEL */
> +static bool attr_has_sigtrap(void)
> +{
> +	struct perf_event_attr attr = {
> +		.type		= PERF_TYPE_SOFTWARE,
> +		.config		= PERF_COUNT_SW_DUMMY,
> +		.size		= sizeof(attr),
> +		.remove_on_exec = 1, /* Required by sigtrap. */
> +		.sigtrap	= 1, /* Request synchronous SIGTRAP on event. */
> +	};
> +	int fd;
> +	bool ret = false;
> +
> +	fd = sys_perf_event_open(&attr, 0, -1, -1, perf_event_open_cloexec_flag());
> +	if (fd >= 0) {
> +		ret = true;
> +		close(fd);
> +	}
> +
> +	return ret;
> +}
> +#endif  /* HAVE_BPF_SKEL */
> +
>  static void
>  sigtrap_handler(int signum __maybe_unused, siginfo_t *info, void *ucontext __maybe_unused)
>  {
> @@ -139,7 +196,13 @@ static int test__sigtrap(struct test_suite *test __maybe_unused, int subtest __m
>  
>  	fd = sys_perf_event_open(&attr, 0, -1, -1, perf_event_open_cloexec_flag());
>  	if (fd < 0) {
> -		pr_debug("FAILED sys_perf_event_open(): %s\n", str_error_r(errno, sbuf, sizeof(sbuf)));
> +		if (attr_has_sigtrap()) {
> +			pr_debug("FAILED sys_perf_event_open(): %s\n",
> +				 str_error_r(errno, sbuf, sizeof(sbuf)));
> +		} else {
> +			pr_debug("perf_event_attr doesn't have sigtrap\n");
> +			ret = TEST_SKIP;
> +		}
>  		goto out_restore_sigaction;
>  	}
>  
> -- 
> 2.37.2.789.g6183377224-goog

-- 

- Arnaldo
