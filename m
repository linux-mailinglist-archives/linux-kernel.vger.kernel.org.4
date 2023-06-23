Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DFA73B053
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 07:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjFWFuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 01:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjFWFts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 01:49:48 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECE12D6A;
        Thu, 22 Jun 2023 22:48:50 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QnR9q0Pyxz1GF3d;
        Fri, 23 Jun 2023 13:48:31 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 23 Jun 2023 13:48:39 +0800
Subject: Re: [PATCH 0/2] perf/core: deliver PERF_RECORD_COMM and
 PERF_RECORD_MMAP side-band events to all online cpus
To:     Adrian Hunter <adrian.hunter@intel.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <irogers@google.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230620155515.101222-1-yangjihong1@huawei.com>
 <f5b4e1e4-9966-c22a-1628-b3df37523841@intel.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <d6dc0437-854f-8dad-91fc-404138d171a4@huawei.com>
Date:   Fri, 23 Jun 2023 13:48:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <f5b4e1e4-9966-c22a-1628-b3df37523841@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/6/21 2:49, Adrian Hunter wrote:
> On 20/06/23 18:55, Yang Jihong wrote:
>> Tasks are migrated between cores due to scheduling.
>> If perf samples specified CPUs, PERF_RECORD_COMM and PERF_RECORD_MMAP
>> events need be deliver to all cores to avoids the problem that the comm
>> and symbols cannot be parsed due to task migration to the target core.
>>
>> The specific scenarios are as follows:
>>
>>           CPU0                                 CPU1
>>    perf record -C 0 start
>>                                taskA starts to be created and executed
>>                                  -> PERF_RECORD_COMM and PERF_RECORD_MMAP
>>                                     events only deliver to CPU1
>>                                ......
>>                                  |
>>                            migrate to CPU0
>>                                  |
>>    Running on CPU0    <----------/
>>    ...
>>
>>    perf record -C 0 stop
>>
>> Now perf samples the PC of taskA. However, perf does not record the
>> PERF_RECORD_COMM and PERF_RECORD_COMM events of taskA.
>> Therefore, the comm and symbols of taskA cannot be parsed.
> 
> perf record deals with this for PERF_RECORD_TEXT_POKE, by opening
> the corresponding "dummy" event on each CPU irrespective of whether
> the main events are on selected CPUs.  Refer
> evlist__add_dummy_on_all_cpus().
> 
> So this could be handled by perf record.

Okay, I'll take a look at it and use this solution to deal with it.

Thanks,
Yang
