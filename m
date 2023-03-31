Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724E36D1F67
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 13:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjCaLqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 07:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbjCaLqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 07:46:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55ADB1EA11;
        Fri, 31 Mar 2023 04:46:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5C6E62836;
        Fri, 31 Mar 2023 11:46:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C31C433D2;
        Fri, 31 Mar 2023 11:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680263199;
        bh=R9Yumhm1RMDdrtlrXq9zoIJGJBh/7IIt4c1jg6vLDdI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KHmvMrQUdq35+Ksi/AkM2SThIklUFlK5p9qKwCS61ubSQHKh4R6m0Z6OP4J/Lz5ZX
         p+QTPGGTULCt0NQj4CHMRSqV40/HeSdl3JBCZRlAyC4qvM7ogUxSrr4/W0Vvw3zaj0
         fXpcPNl09E3SLDnPykpwAVc2qSDS72iVmAj5CuFja6DzQ1wus+6KbIvFufwgZAK415
         LiG2GvefKZv5D604ixLQg2XD/gs9gHRyS3mfcQqyuQpvaAIpxiHmSS50GxdrKc7o+Q
         J7LkxA/ngsTV6QljR6XXhQy/U1MT4413HJ4k4DpsbbLIAEGwp/xuYoDlbNC+lPetWe
         x+4WTVELtTVeg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 51F8C4052D; Fri, 31 Mar 2023 08:46:36 -0300 (-03)
Date:   Fri, 31 Mar 2023 08:46:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v1 1/4] tools api: Add io__getline
Message-ID: <ZCbIHBDwcZ1IX8z8@kernel.org>
References: <20230331004844.1592789-1-irogers@google.com>
 <20230331004844.1592789-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331004844.1592789-2-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 30, 2023 at 05:48:41PM -0700, Ian Rogers escreveu:
> Reads a line to allocated memory up to a newline following the getline
> API.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/api/io.h        | 40 +++++++++++++++++++++++++++++++++++++++
>  tools/perf/tests/api-io.c | 36 +++++++++++++++++++++++++++++++++++
>  2 files changed, 76 insertions(+)
> 
> diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
> index 777c20f6b604..d874e8fa8b07 100644
> --- a/tools/lib/api/io.h
> +++ b/tools/lib/api/io.h
> @@ -7,7 +7,9 @@
>  #ifndef __API_IO__
>  #define __API_IO__
>  
> +#include <errno.h>
>  #include <stdlib.h>
> +#include <string.h>
>  #include <unistd.h>
>  
>  struct io {
> @@ -112,4 +114,42 @@ static inline int io__get_dec(struct io *io, __u64 *dec)
>  	}
>  }
>  
> +/* Read up to and including the first newline following the pattern of getline. */
> +static inline ssize_t io__getline(char **line_out, size_t *line_len_out, struct io *io)

Can we have io be the first arg? To be consistent with the other
functons here and elsewhere in perf.

- Arnaldo

> +{
> +	char buf[128];
> +	int buf_pos = 0;
> +	char *line = NULL;
> +	size_t line_len = 0;
> +	int ch = 0;
> +
> +	/* TODO: reuse previously allocated memory. */
> +	free(*line_out);
> +	while (ch != '\n') {
> +		ch = io__get_char(io);
> +
> +		if (ch < 0)
> +			break;
> +
> +		if (buf_pos == sizeof(buf)) {
> +			line = realloc(line, line_len + sizeof(buf));
> +			if (!line)
> +				return -ENOMEM;
> +			memcpy(&line[line_len], buf, sizeof(buf));
> +			line_len += sizeof(buf);
> +			buf_pos = 0;
> +		}
> +		buf[buf_pos++] = (char)ch;
> +	}
> +	line = realloc(line, line_len + buf_pos + 1);
> +	if (!line)
> +		return -ENOMEM;
> +	memcpy(&line[line_len], buf, buf_pos);
> +	line[line_len + buf_pos] = '\0';
> +	line_len += buf_pos;
> +	*line_out = line;
> +	*line_len_out = line_len;
> +	return line_len;
> +}
> +
>  #endif /* __API_IO__ */
> diff --git a/tools/perf/tests/api-io.c b/tools/perf/tests/api-io.c
> index e91cf2c127f1..0ff39cdfcb01 100644
> --- a/tools/perf/tests/api-io.c
> +++ b/tools/perf/tests/api-io.c
> @@ -289,6 +289,40 @@ static int test_get_dec(void)
>  	return ret;
>  }
>  
> +static int test_get_line(void)
> +{
> +	char path[PATH_MAX];
> +	struct io io;
> +	char test_string[1024];
> +	char *line = NULL;
> +	size_t i, line_len = 0;
> +	size_t buf_size = 128;
> +	int ret = 0;
> +
> +	for (i = 0; i < 512; i++)
> +		test_string[i] = 'a';
> +	test_string[512] = '\n';
> +	for (i = 513; i < 1023; i++)
> +		test_string[i] = 'b';
> +	test_string[1023] = '\0';
> +
> +	if (setup_test(path, test_string, buf_size, &io))
> +		return -1;
> +
> +	EXPECT_EQUAL((int)io__getline(&line, &line_len, &io), 513);
> +	EXPECT_EQUAL((int)strlen(line), 513);
> +	for (i = 0; i < 512; i++)
> +		EXPECT_EQUAL(line[i], 'a');
> +	EXPECT_EQUAL(line[512], '\n');
> +	EXPECT_EQUAL((int)io__getline(&line, &line_len, &io), 510);
> +	for (i = 0; i < 510; i++)
> +		EXPECT_EQUAL(line[i], 'b');
> +
> +	free(line);
> +	cleanup_test(path, &io);
> +	return ret;
> +}
> +
>  static int test__api_io(struct test_suite *test __maybe_unused,
>  			int subtest __maybe_unused)
>  {
> @@ -300,6 +334,8 @@ static int test__api_io(struct test_suite *test __maybe_unused,
>  		ret = TEST_FAIL;
>  	if (test_get_dec())
>  		ret = TEST_FAIL;
> +	if (test_get_line())
> +		ret = TEST_FAIL;
>  	return ret;
>  }
>  
> -- 
> 2.40.0.348.gf938b09366-goog
> 

-- 

- Arnaldo
