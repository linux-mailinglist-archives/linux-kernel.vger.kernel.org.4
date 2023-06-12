Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C38E72CF08
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 21:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237822AbjFLTL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 15:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbjFLTLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 15:11:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7085AD;
        Mon, 12 Jun 2023 12:11:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7743962D5E;
        Mon, 12 Jun 2023 19:11:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B5CC433EF;
        Mon, 12 Jun 2023 19:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686597081;
        bh=DQ/Od0CF4jpt4XMYdVtzce6cD5R6KE/yyJueAcvxr0g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ikk7aOHUu4MF6rf1YibiyOBhvmnyoEh3Dt0+t118OE/U5OKQ2kwprmq5K3ENj2Upc
         Bmead5WSXta2V1AatizLeLn8HkonVWhByupoixPHtTxxLc/uBbO5PypO8HYSqYBJpv
         NIXdXEab737AUD897jXpDBmLo45mxAXdVtRO0yaeAbiO5A3DiJ+UxEV1d3yHijqghf
         2cJB/6z9TvKofMYNTQv2yr9ui2k2nTkkznscv0Oe2ewqkzmLTMCxOa3owc06LjMq4H
         PdXWoQWGnvnLM51fBBgkzsbRfPHtNjN/3ERrF3P7iHMThKOskzvVz8sSiJDpPnqZzh
         s+tdEgldWvTzA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6210940692; Mon, 12 Jun 2023 16:11:19 -0300 (-03)
Date:   Mon, 12 Jun 2023 16:11:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Changbin Du <changbin.du@huawei.com>,
        Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Changbin Du <changbin.du@huawei.com>
Subject: Re: [PATCH v1 2/2] perf srcline: Make sentinel reading for binutils
 addr2line more robust
Message-ID: <ZIdt18EmHQBgiWXF@kernel.org>
References: <20230609235419.204624-1-irogers@google.com>
 <20230609235419.204624-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609235419.204624-2-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jun 09, 2023 at 04:54:19PM -0700, Ian Rogers escreveu:
> The addr2line process is sent an address then multiple function,
> filename:line "records" are read. To detect the end of output a ',' is
> sent and for llvm-addr2line a ',' is then read back showing the end of
> addrline's output. For binutils addr2line the ',' translates to
> address 0 and we expect the bogus filename marker "??:0" (see
> filename_split) to be sent from addr2line. For some kernels address 0
> may have a mapping and so a seemingly valid inline output is given and
> breaking the sentinel discovery:
> 
> ```
> $ addr2line -e vmlinux -f -i
> ,
> __per_cpu_start
> ./arch/x86/kernel/cpu/common.c:1850
> ```
> 
> To avoid this problem enable the address dumping for addr2line (the -a
> option). If an address of 0x0000000000000000 is read then this is the
> sentinel value working around the problem above. The filename_split
> still needs to check for "??:0" as bogus non-zero addresses also need
> handling.
> 
> Reported-by: Changbin Du <changbin.du@huawei.com>

Changbin,

	Did this fix the problem you reported? If so can I have your
Tested-by?

Thanks,

- Arnaldo

> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/srcline.c | 61 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 53 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
> index fc85cdd6c8f9..c99a001453b4 100644
> --- a/tools/perf/util/srcline.c
> +++ b/tools/perf/util/srcline.c
> @@ -406,7 +406,7 @@ static struct child_process *addr2line_subprocess_init(const char *addr2line_pat
>  	const char *argv[] = {
>  		addr2line_path ?: "addr2line",
>  		"-e", binary_path,
> -		"-i", "-f", NULL
> +		"-a", "-i", "-f", NULL
>  	};
>  	struct child_process *a2l = zalloc(sizeof(*a2l));
>  	int start_command_status = 0;
> @@ -461,10 +461,10 @@ static enum a2l_style addr2line_configure(struct child_process *a2l, const char
>  			style = LLVM;
>  			cached = true;
>  			lines = 1;
> -		} else if (ch == '?') {
> +		} else if (ch == '0') {
>  			style = GNU_BINUTILS;
>  			cached = true;
> -			lines = 2;
> +			lines = 3;
>  		} else {
>  			if (!symbol_conf.disable_add2line_warn) {
>  				char *output;
> @@ -516,20 +516,64 @@ static int read_addr2line_record(struct io *io,
>  	if (line_nr != NULL)
>  		*line_nr = 0;
>  
> +	/*
> +	 * Read the first line. Without an error this will be either an address
> +	 * like 0x1234 or for llvm-addr2line the sentinal ',' character.
> +	 */
>  	if (io__getline(io, &line, &line_len) < 0 || !line_len)
>  		goto error;
>  
> -	if (style == LLVM && line_len == 2 && line[0] == ',') {
> -		zfree(&line);
> -		return 0;
> +	if (style == LLVM) {
> +		if (line_len == 2 && line[0] == ',') {
> +			zfree(&line);
> +			return 0;
> +		}
> +	} else {
> +		int zero_count = 0, non_zero_count = 0;
> +
> +		/* The address should always start 0x. */
> +		if (line_len < 2 || line[0] != '0' || line[1] != 'x')
> +			goto error;
> +
> +		for (size_t i = 2; i < line_len; i++) {
> +			if (line[i] == '0')
> +				zero_count++;
> +			else
> +				non_zero_count++;
> +		}
> +		if (!non_zero_count) {
> +			int ch;
> +
> +			if (!zero_count) {
> +				/* Line was erroneous just '0x'. */
> +				goto error;
> +			}
> +			/*
> +			 * Line was 0x0..0, the sentinel for binutils. Remove
> +			 * the function and filename lines.
> +			 */
> +			zfree(&line);
> +			do {
> +				ch = io__get_char(io);
> +			} while (ch > 0 && ch != '\n');
> +			do {
> +				ch = io__get_char(io);
> +			} while (ch > 0 && ch != '\n');
> +			return 0;
> +		}
>  	}
>  
> +	/* Read the second function name line. */
> +	if (io__getline(io, &line, &line_len) < 0 || !line_len)
> +		goto error;
> +
>  	if (function != NULL)
>  		*function = strdup(strim(line));
>  
>  	zfree(&line);
>  	line_len = 0;
>  
> +	/* Read the third filename and line number line. */
>  	if (io__getline(io, &line, &line_len) < 0 || !line_len)
>  		goto error;
>  
> @@ -633,8 +677,9 @@ static int addr2line(const char *dso_name, u64 addr,
>  		goto out;
>  	case 0:
>  		/*
> -		 * The first record was invalid, so return failure, but first read another
> -		 * record, since we asked a junk question and have to clear the answer out.
> +		 * The first record was invalid, so return failure, but first
> +		 * read another record, since we sent a sentinel ',' for the
> +		 * sake of detected the last inlined function.
>  		 */
>  		switch (read_addr2line_record(&io, a2l_style, NULL, NULL, NULL)) {
>  		case -1:
> -- 
> 2.41.0.162.gfafddb0af9-goog
> 

-- 

- Arnaldo
