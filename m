Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93816ED2B8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 18:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjDXQne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 12:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjDXQnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 12:43:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5F3944B1;
        Mon, 24 Apr 2023 09:43:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D72F4B3;
        Mon, 24 Apr 2023 09:44:15 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABED23F5A1;
        Mon, 24 Apr 2023 09:43:28 -0700 (PDT)
Message-ID: <f2ff24cb-5d62-6366-81dc-d51a79062570@arm.com>
Date:   Mon, 24 Apr 2023 17:43:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/7] perf tools: Add util function for overriding user set
 config values
Content-Language: en-US
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     denik@google.com, Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, coresight@lists.linaro.org,
        shy828301@gmail.com
References: <20230424134748.228137-1-james.clark@arm.com>
 <20230424134748.228137-3-james.clark@arm.com>
 <a7940a4a-fc62-17ca-834b-73628a54cc2a@intel.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <a7940a4a-fc62-17ca-834b-73628a54cc2a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/04/2023 16:36, Adrian Hunter wrote:
> On 24/04/23 16:47, James Clark wrote:
>> There is some duplicated code to only override config values if they
>> haven't already been set by the user so make a util function for this.
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
> 
> One minor comment, nevertheless:
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> 

Thanks for the review

>> ---
>>  tools/perf/arch/arm64/util/arm-spe.c | 26 ++-----------------------
>>  tools/perf/arch/x86/util/intel-pt.c  | 22 ++-------------------
>>  tools/perf/util/evsel.c              | 29 ++++++++++++++++++++++++++++
>>  tools/perf/util/evsel.h              |  3 +++
>>  4 files changed, 36 insertions(+), 44 deletions(-)
>>
[...]
>>  	}
>>  }
>> +
>> +/*
>> + * Set @config_name to @val as long as the user hasn't already set or cleared it
>> + * by passing a config term on the command line.
>> + *
>> + * @val is the value to put into the bits specified by @config_name rather than
>> + * the bit pattern. It is shifted into position by this function, so to set
>> + * something to true, pass 1 for val rather than a pre shifted value.
>> + */
>> +#define field_prep(_mask, _val) (((_val) << (ffsll(_mask) - 1)) & (_mask))
> 
> I notice there is already tools/include/linux/bitfield.h
> so may FIELD_PREP from there could be used?

I tried that first, but it seems like quite a lot of effort went into it
to make it work on const only values so it doesn't work here. There is
this [1] change to make a non const one but it doesn't look like it went
anywhere:

[1]:
https://patchwork.kernel.org/project/linux-omap/patch/3a54a6703879d10f08cf0275a2a69297ebd2b1d4.1637592133.git.geert+renesas@glider.be/#24610749

