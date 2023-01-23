Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE11A67794D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 11:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjAWKhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 05:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjAWKhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 05:37:45 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86F4146B7;
        Mon, 23 Jan 2023 02:37:43 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3F57AD7;
        Mon, 23 Jan 2023 02:38:24 -0800 (PST)
Received: from [10.57.49.17] (unknown [10.57.49.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BDB83F71A;
        Mon, 23 Jan 2023 02:37:39 -0800 (PST)
Message-ID: <ec7502e6-b406-3997-c2a5-24f98e5c4854@arm.com>
Date:   Mon, 23 Jan 2023 10:37:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5 8/8] perf: cs-etm: Ensure that Coresight timestamps
 don't go backwards
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, tanmay@marvell.com,
        leo.yan@linaro.org, mike.leach@linaro.org, sgoutham@marvell.com,
        gcherian@marvell.com, lcherian@marvell.com, bbhushan2@marvell.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230120143702.4035046-1-james.clark@arm.com>
 <20230120143702.4035046-9-james.clark@arm.com> <Y8rLfroSyYzgr5z9@kernel.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <Y8rLfroSyYzgr5z9@kernel.org>
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



On 20/01/2023 17:12, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jan 20, 2023 at 02:37:01PM +0000, James Clark escreveu:
>> There are some edge cases around estimated timestamps that can result
>> in them going backwards.
>>
>> One is that after a discontinuity, the last used timestamp is set to 0.
>> The duration of the next range is then subtracted which could result in
>> an earlier timestamp than the last instruction. Fix this by not
>> resetting the last timestamp used on a discontinuity, and make sure that
>> new estimated timestamps are clamped to be later than that.
>>
>> Another case is that estimated timestamps could compound over time to
>> end up being more than the next real timestamp in the trace. Fix this by
>> clamping the estimates in cs_etm_decoder__do_soft_timestamp() to be no
>> later than it.
>>
>> cs_etm_decoder__do_soft_timestamp() also updated next_cs_timestamp,
>> which meant that the next real timestamp was lost and not stored
>> anywhere. Fix that by only updating cs_timestamp for estimates and keep
>> next_cs_timestamp untouched.
>>
>> Finally, use next_cs_timestamp to signify if a timestamp has been
>> received previously. Because cs_timestamp has the first range
>> subtracted, it could technically go to 0 which would break the logic.
>>
>> Testing
>> =======
>>
>> It can be verified that timestamps don't go backwards when tracing on a
>> single core with the following commands. Across multiple cores it's
>> expected that timestamps are interleaved:
>>
>>  $ perf record -e cs_etm/@tmc_etr0/k -C 4 taskset -c 4 sleep 1
>>  $ perf script --itrace=i1ns --ns -Fcomm,tid,pid,time,cpu,event,ip,sym,addr,symoff,flags,callindent > itrace
>>  $ sed 's/://g' itrace | awk -F ' ' ' { print $4 } ' | awk '{ if ($1 < prev) { print "line:" NR " " $0 } {prev=$1}}'
> 
> Trying:
> 
> root@roc-rk3399-pc:~# uname -a
> Linux roc-rk3399-pc 6.1.0-rc5-00123-g4dd7ff4a0311 #2 SMP PREEMPT Wed Nov 16 19:55:11 UTC 2022 aarch64 aarch64 aarch64 GNU/Linux
> root@roc-rk3399-pc:~#
> root@roc-rk3399-pc:~# perf record -e cs_etm/@tmc_etr0/k -C 4 taskset -c 4 sleep 1
> failed to set sink "tmc_etr0" on event cs_etm/@tmc_etr0/k with 2 (No such file or directory)
> root@roc-rk3399-pc:~#
> 
> We could have a better message at some point, right? :-)
> > Something like:
> 
> root@roc-rk3399-pc:~# perf record -e cs_etm/@tmc_etr0/k -C 4 taskset -c 4 sleep 1
> This system lacks the CoreSight component.
> root@roc-rk3399-pc:~#

Should be possible, I'm having a look now
