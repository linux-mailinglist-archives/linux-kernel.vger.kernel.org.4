Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421116629CD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 16:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjAIPXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 10:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjAIPWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:22:34 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F31A315F08;
        Mon,  9 Jan 2023 07:22:15 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B25D91042;
        Mon,  9 Jan 2023 07:22:57 -0800 (PST)
Received: from [10.57.37.91] (unknown [10.57.37.91])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E24A03F587;
        Mon,  9 Jan 2023 07:22:13 -0800 (PST)
Message-ID: <563924f6-190a-6a2a-b6ee-e77759e74c4d@arm.com>
Date:   Mon, 9 Jan 2023 15:22:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] perf kmem: Support field "node" in
 evsel__process_alloc_event()
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>
References: <20230108062400.250690-1-leo.yan@linaro.org>
 <20230108062400.250690-2-leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20230108062400.250690-2-leo.yan@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/01/2023 06:24, Leo Yan wrote:
> Commit 11e9734bcb6a ("mm/slab_common: unify NUMA and UMA version of
> tracepoints") adds the field "node" into the tracepoints 'kmalloc' and
> 'kmem_cache_alloc', so this patch modifies the event process function to
> support the field "node".
> 
> If field "node" is existed by checking function evsel__field(), it stats
> the cross allocation.
> 
> When the "node" value is NUMA_NO_NODE (-1), it means the memory can be
> allocated from any memory node, in this case, we don't account it as a
> cross allocation.
> 
> After support the field "node" in evsel__process_alloc_event(),
> evsel__process_alloc_node_event() is duplicate with the previous one,
> so removes evsel__process_alloc_node_event().
> 
> Reported-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Fixes: 11e9734bcb6a ("mm/slab_common: unify NUMA and UMA version of tracepoints")
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/builtin-kmem.c | 36 ++++++++++++++++++++++++------------
>  1 file changed, 24 insertions(+), 12 deletions(-)
> 

Reviewed-by: James Clark <james.clark@arm.com>
