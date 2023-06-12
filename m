Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4418F72CA09
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237007AbjFLP1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbjFLP1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:27:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F36EE7B;
        Mon, 12 Jun 2023 08:27:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBEA61FB;
        Mon, 12 Jun 2023 08:28:06 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DF2D3F5A1;
        Mon, 12 Jun 2023 08:27:19 -0700 (PDT)
Message-ID: <a24634f7-be80-6ca2-9df7-1624fe11c281@arm.com>
Date:   Mon, 12 Jun 2023 16:27:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC] Adding support for setting the affinity of the recording
 process
Content-Language: en-US
To:     Yang Jihong <yangjihong1@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <159de73b-fdd6-6df8-4f77-73c628fe641f@huawei.com>
From:   James Clark <james.clark@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
In-Reply-To: <159de73b-fdd6-6df8-4f77-73c628fe641f@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/06/2023 11:26, Yang Jihong wrote:
> Hello everyone,
> 
> Currently, perf-record supports profiling an existing process, thread,
> or a specified command.
> 
> Sometimes we may need to set CPU affinity of the target process before
> recording:
> 
>   # taskset -pc <cpus> <pid>
>   # perf record -p <pid> -- sleep 10
> 
> or:
> 
>   # perf record -- `taskset -c <cpus> COMMAND`
> 
> I'm thinking about getting perf to support setting the affinity of the
> recording process, for example:
> 
> 1. set the CPU affinity of the <pid1> process to <cpus1>, <pid2> process
> to <cpus2>,  and record:
> 
>   # perf record -p <pid1>/<cpus1>:<pid2>/<cpus2> -- sleep 10
> 

I'm not sure if this is necessary. You can already do this with taskset
when you launch the processes or for existing ones.

> and
> 
> 2. set CPU affinity of the COMMAND and record:
> 
>   # perf record --taskset-command <cpus> COMMAND
> 
> In doing so, perf, as an observer, actually changes some of the
> properties of the target process, which may be contrary to the purpose
> of perf tool.
> 
> 
> Will we consider accepting this approach?
> 

For #2 I do this sometimes, but I prefix the perf command with taskset
because otherwise there is a small time between when taskset does its
thing and launching the child process that it runs in the wrong place.

Then one issue with the above method is that perf itself gets pinned to
those CPUs as well. I suppose that could influence your application but
I've never had an issue with it.

If you really can't live with perf also being pinned to those CPUs I
would say it makes sense to add options for #2. Otherwise I would just
run everything under taskset and no changes are needed.

I think you would still need to have perf itself pinned to the CPUs just
before it does the fork and exec, and then after that it can undo its
pinning. Otherwise you'd still get that small time running on the wrong
cores.

James

> Thanks,
> Yang.
