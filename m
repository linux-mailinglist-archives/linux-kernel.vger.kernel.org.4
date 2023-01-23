Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422756783F6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 19:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbjAWSCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 13:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbjAWSCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:02:41 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42474301B2;
        Mon, 23 Jan 2023 10:02:40 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4E4DC14;
        Mon, 23 Jan 2023 10:03:21 -0800 (PST)
Received: from [10.57.75.85] (unknown [10.57.75.85])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8362B3F71E;
        Mon, 23 Jan 2023 10:02:37 -0800 (PST)
Message-ID: <0a5019bd-8666-45b1-bcaa-e3bacc869bc8@arm.com>
Date:   Mon, 23 Jan 2023 18:02:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] perf: cs-etm: Improve missing sink warning message
To:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, acme@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
References: <20230123161114.261255-1-james.clark@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230123161114.261255-1-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2023 16:11, James Clark wrote:
> Make the sink error message more similar to the event error message that
> reminds about missing kernel support. The available sinks are also
> determined by the hardware so mention that too.
> 
> Also, usually it's not necessary to specify the sink, so add that as a
> hint.
> 
> Now the error for a made up sink looks like this:
> 
>    $ perf record -e cs_etm/@abc/
>    Couldn't find sink "abc" on event cs_etm/@abc/.
>    Missing kernel or device support? Errno: 2 (No such file or directory)
> 
>    Hint: An appropriate sink will picked automatically if none is specified.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>   tools/perf/arch/arm/util/cs-etm.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index 481e170cd3f1..c6195a7a3cbf 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -283,7 +283,9 @@ static int cs_etm_set_sink_attr(struct perf_pmu *pmu,
>   
>   		ret = perf_pmu__scan_file(pmu, path, "%x", &hash);
>   		if (ret != 1) {
> -			pr_err("failed to set sink \"%s\" on event %s with %d (%s)\n",
> +			pr_err("Couldn't find sink \"%s\" on event %s\n"

Could this be tied to "errno == ENOENT" ?  Otherwise, this could be 
guiding the user to wrong direction.

> +			       "Missing kernel or device support? errno: %d (%s)\n\n"
> +			       "Hint: An appropriate sink will picked automatically if one isn't specified.\n",

minor nit: "... sink will *be* picked.." ?

Otherwise, looks good to me.

Suzuki

>   			       sink, evsel__name(evsel), errno,
>   			       str_error_r(errno, msg, sizeof(msg)));
>   			return ret;
> 
> base-commit: 5670ebf54bd26482f57a094c53bdc562c106e0a9

