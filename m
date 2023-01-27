Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB43867E98D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbjA0Pe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbjA0Pex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:34:53 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C49C80003;
        Fri, 27 Jan 2023 07:34:52 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FB132B;
        Fri, 27 Jan 2023 07:35:34 -0800 (PST)
Received: from [10.57.48.133] (unknown [10.57.48.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94B4B3F64C;
        Fri, 27 Jan 2023 07:34:50 -0800 (PST)
Message-ID: <a1f864b8-d0c1-79d9-f976-64ebec9f3714@arm.com>
Date:   Fri, 27 Jan 2023 15:34:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/4] perf session: Avoid calling lseek(2) for pipe
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
References: <20230127001951.3432374-1-namhyung@kernel.org>
 <20230127001951.3432374-4-namhyung@kernel.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20230127001951.3432374-4-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/01/2023 00:19, Namhyung Kim wrote:
> We should not call lseek(2) for pipes as it won't work.  And we already
> in the proper place to read the data for AUXTRACE.  Add the comment like
> in the PERF_RECORD_HEADER_TRACING_DATA.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/session.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 7c021c6cedb9..fdfe772f2699 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1699,8 +1699,13 @@ static s64 perf_session__process_user_event(struct perf_session *session,
>  	case PERF_RECORD_AUXTRACE_INFO:
>  		return tool->auxtrace_info(session, event);
>  	case PERF_RECORD_AUXTRACE:
> -		/* setup for reading amidst mmap */
> -		lseek(fd, file_offset + event->header.size, SEEK_SET);
> +		/*
> +		 * Setup for reading amidst mmap, but only when we
> +		 * are in 'file' mode.  The 'pipe' fd is in proper
> +		 * place already.
> +		 */
> +		if (!perf_data__is_pipe(session->data))
> +			lseek(fd, file_offset + event->header.size, SEEK_SET);

I'm not sure if it means anything, but Arm SPE works both with and
without this change, although I did have to skip the build-id inject part:

  perf record -o- -e arm_spe// stress -c 1 -t 1 | \
    perf report -i- --itrace=i1000


>  		return tool->auxtrace(session, event);
>  	case PERF_RECORD_AUXTRACE_ERROR:
>  		perf_session__auxtrace_error_inc(session, event);
