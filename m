Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B246AB43F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 02:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjCFBOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 20:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCFBOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 20:14:20 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C71B86BE;
        Sun,  5 Mar 2023 17:14:19 -0800 (PST)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PVLDs1NylzrSQ3;
        Mon,  6 Mar 2023 09:13:33 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 09:14:16 +0800
Subject: Re: [PATCH RESEND v3] perf/core: Fix hardlockup failure caused by
 perf throttle
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <eranian@google.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230227023508.102230-1-yangjihong1@huawei.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <12782722-103e-88a9-df3e-6815b4734bc3@huawei.com>
Date:   Mon, 6 Mar 2023 09:14:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20230227023508.102230-1-yangjihong1@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

PING.

Thanks,
Yang.

On 2023/2/27 10:35, Yang Jihong wrote:
> commit e050e3f0a71bf ("perf: Fix broken interrupt rate throttling")
> introduces a change in throttling threshold judgment. Before this,
> compare hwc->interrupts and max_samples_per_tick, then increase
> hwc->interrupts by 1, but this commit reverses order of these two
> behaviors, causing the semantics of max_samples_per_tick to change.
> In literal sense of "max_samples_per_tick", if hwc->interrupts ==
> max_samples_per_tick, it should not be throttled, therefore, the judgment
> condition should be changed to "hwc->interrupts > max_samples_per_tick".
> 
> In fact, this may cause the hardlockup to fail, The minimum value of
> max_samples_per_tick may be 1, in this case, the return value of
> __perf_event_account_interrupt function is 1.
> As a result, nmi_watchdog gets throttled, which would stop PMU (Use x86
> architecture as an example, see x86_pmu_handle_irq).
> 
> Fixes: e050e3f0a71b ("perf: Fix broken interrupt rate throttling")
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
> 
> Changes since v2:
>    - Add fixed commit.
> 
> Changes since v1:
>    - Modify commit title.
> 
>   kernel/events/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index f79fd8b87f75..0540a8653906 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9434,7 +9434,7 @@ __perf_event_account_interrupt(struct perf_event *event, int throttle)
>   	} else {
>   		hwc->interrupts++;
>   		if (unlikely(throttle
> -			     && hwc->interrupts >= max_samples_per_tick)) {
> +			     && hwc->interrupts > max_samples_per_tick)) {
>   			__this_cpu_inc(perf_throttled_count);
>   			tick_dep_set_cpu(smp_processor_id(), TICK_DEP_BIT_PERF_EVENTS);
>   			hwc->interrupts = MAX_INTERRUPTS;
> 
