Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2EF7662A3A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 16:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236688AbjAIPjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 10:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237535AbjAIPjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:39:09 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B670261473;
        Mon,  9 Jan 2023 07:35:36 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB57C1042;
        Mon,  9 Jan 2023 07:35:43 -0800 (PST)
Received: from [10.57.37.91] (unknown [10.57.37.91])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 113593F587;
        Mon,  9 Jan 2023 07:34:58 -0800 (PST)
Message-ID: <ec5684cd-a527-4e13-2b05-31832d80535c@arm.com>
Date:   Mon, 9 Jan 2023 15:34:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5 1/6] perf vendor events arm64: Add topdown L1 metrics
 for neoverse-n2
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>
References: <1672745976-2800146-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1672745976-2800146-2-git-send-email-renyu.zj@linux.alibaba.com>
 <5c5716e5-b2ff-67cd-b608-4eeffa7e04bc@oracle.com>
 <1f3d53cb-4160-e29d-3934-d6a488d9fd49@linux.alibaba.com>
 <7aa225df-af25-a6be-9bef-c965488ba43a@oracle.com>
 <d4d132d9-1513-6a4e-981f-aa4bc4ebbcbb@linux.alibaba.com>
 <00bf227a-75ce-c63c-c740-89b8d2b27e1c@oracle.com>
 <CAP-5=fVGmjFOZqOk0E1bcqeTHcJhEmoA-vrKcHLOs4B_ythT1g@mail.gmail.com>
 <6971b848-2754-6909-d36b-ea80fe157e95@oracle.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <6971b848-2754-6909-d36b-ea80fe157e95@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/01/2023 10:14, John Garry wrote:
> On 05/01/2023 21:13, Ian Rogers wrote:
>>>> This may be a feasible idea. The value of slots comes from the
>>>> register PMMIR_EL1, which I can read in
>>>> /sys/bus/event_source/device/armv8_pmuv3_*/caps/slots. But how do I
>>>> replace the slots in MetricExpr with the
>>>> read slots values? Currently I understand that parameters in
>>>> metricExpr only support events and constants.
>>>>
>>> Maybe during runtime we could create a pseudo metric/event for SLOT.
>> For Intel we do this by just having a different constant for each
>> architecture. It is fairly easy to add a new "literal", so you could
>> add a #slots in expr__get_literal:
>> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/expr.c?h=perf*core*n407__;LyM!!ACWV5N9M2RV99hQ!IHcZFuFaLdQDQvVOnHVlbbME2S4aW8GohWUkydlejpi7ifFz61r7RutGXReRt0d88X_vDfkTySCiuD2PqOA$  Populating it would be the challenge 😄
> 
> Thanks for the pointer. I think that the challenge in populating it
> really comes down to whether we would really want to make this generic.
> 
> I suppose that for arm64 we could have a method which accesses this
> PMMIR_EL1 register, while for other archs we could have a weak function
> which just returns NAN. If other archs want to use this key expr, they
> can add their own method.
> 

I wonder if it would be worthwhile and even more generic to add some
sort of int containing file accessor construct. It could also have
support for a default value when the file doesn't exist. For example:

  "MetricExpr": "ITLB / {file://<pmu>/caps/slots(5)}"

It gets a bit fiddly because you might want to support absolute paths
and paths relative to whatever PMU is being used. But it could prevent
having to add some custom identifier and glue code for every possible
file that just has an integer in it.

It also wouldn't be possible to support the case where the file has
bitfields in it that need to be extracted, so maybe we shouldn't do it.

James

