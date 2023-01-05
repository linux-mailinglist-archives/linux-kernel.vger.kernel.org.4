Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C62365E89B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjAEKGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjAEKGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:06:07 -0500
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1AB2DC8;
        Thu,  5 Jan 2023 02:06:05 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VYvkzZr_1672913159;
Received: from 30.221.147.24(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VYvkzZr_1672913159)
          by smtp.aliyun-inc.com;
          Thu, 05 Jan 2023 18:06:01 +0800
Message-ID: <d4d132d9-1513-6a4e-981f-aa4bc4ebbcbb@linux.alibaba.com>
Date:   Thu, 5 Jan 2023 18:05:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH v5 1/6] perf vendor events arm64: Add topdown L1 metrics
 for neoverse-n2
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
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
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <7aa225df-af25-a6be-9bef-c965488ba43a@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.8 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/1/5 上午1:26, John Garry 写道:
> On 04/01/2023 05:05, Jing Zhang wrote:
>>
>>
>> 在 2023/1/3 下午7:52, John Garry 写道:
>>> On 03/01/2023 11:39, Jing Zhang wrote:
>>>> The formula of topdown L1 on neoverse-n2 is from ARM sbsa7.0 platform
>>>> design document [0], D37-38.
>>>
>>> I think that I mentioned this before - if the these metrics are coming from an sbsa doc, then they are standard. As such, we can make them "arch std events" and put them in a common json such as sbsa.json, so that other cores may reuse.
>>>
>>> You don't strictly have to do do this now, but it would be better.
>>>
>>
>> Hi John,
> 
> Hi Jing,
> 
>>
>> I would really like to do this, but as discussed earlier, slot is different on each architectures.
>> If I do not specify the value of the slot in sbsa.json, then in the json file of n2/v1, I need to
>> overwrite each topdown "MetricExpr". In other words, the metrics placed in the sbsa.json file only
>> reuse "BriefDescription", "MetricGroup" and "ScaleUnit". So I'm not sure if it's acceptable?
> 
> I don't see a lot of value in that really.
> 
> However, for this value of slot, isn't this discoverable from a system register per core? Quoting the sbsa: "The IMPLEMENTATION DEFINED constant SLOTS is discoverable from the system register PMMIR_EL1.SLOTS." Did you consider how this could be used?
> 


This may be a feasible idea. The value of slots comes from the register PMMIR_EL1, which I can read in
/sys/bus/event_source/device/armv8_pmuv3_*/caps/slots. But how do I replace the slots in MetricExpr with the
read slots values? Currently I understand that parameters in metricExpr only support events and constants.

