Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FE16C9B53
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 08:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjC0GVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 02:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjC0GVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 02:21:01 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF38FD;
        Sun, 26 Mar 2023 23:21:00 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PlN2b5k0kzrX5n;
        Mon, 27 Mar 2023 14:19:51 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 14:20:57 +0800
CC:     <yangyicong@hisilicon.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <peterz@infradead.org>, <mingo@redhat.com>,
        <james.clark@arm.com>, <alexander.shishkin@linux.intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <21cnbao@gmail.com>, <tim.c.chen@intel.com>,
        <prime.zeng@hisilicon.com>, <shenyang39@huawei.com>,
        <linuxarm@huawei.com>
Subject: Re: [PATCH] perf stat: Support per-cluster aggregation
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jie Zhan <zhanjie9@hisilicon.com>
References: <20230313085911.61359-1-yangyicong@huawei.com>
 <039a2fc2-48e2-fe3b-73c1-f7f658c7f22f@hisilicon.com>
 <20230324122422.00006a2b@Huawei.com> <20230324123031.0000013c@Huawei.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <4c9b7281-a4d3-5327-bc27-173af69219a4@huawei.com>
Date:   Mon, 27 Mar 2023 14:20:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20230324123031.0000013c@Huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jie and Jonathan,

On 2023/3/24 20:30, Jonathan Cameron wrote:
> On Fri, 24 Mar 2023 12:24:22 +0000
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
>> On Fri, 24 Mar 2023 10:34:33 +0800
>> Jie Zhan <zhanjie9@hisilicon.com> wrote:
>>
>>> On 13/03/2023 16:59, Yicong Yang wrote:  
>>>> From: Yicong Yang <yangyicong@hisilicon.com>
>>>>
>>>> Some platforms have 'cluster' topology and CPUs in the cluster will
>>>> share resources like L3 Cache Tag (for HiSilicon Kunpeng SoC) or L2
>>>> cache (for Intel Jacobsville). Currently parsing and building cluster
>>>> topology have been supported since [1].
>>>>
>>>> perf stat has already supported aggregation for other topologies like
>>>> die or socket, etc. It'll be useful to aggregate per-cluster to find
>>>> problems like L3T bandwidth contention or imbalance.
>>>>
>>>> This patch adds support for "--per-cluster" option for per-cluster
>>>> aggregation. Also update the docs and related test. The output will
>>>> be like:
>>>>
>>>> [root@localhost tmp]# perf stat -a -e LLC-load --per-cluster -- sleep 5
>>>>
>>>>   Performance counter stats for 'system wide':
>>>>
>>>> S56-D0-CLS158    4      1,321,521,570      LLC-load
>>>> S56-D0-CLS594    4        794,211,453      LLC-load
>>>> S56-D0-CLS1030    4             41,623      LLC-load
>>>> S56-D0-CLS1466    4             41,646      LLC-load
>>>> S56-D0-CLS1902    4             16,863      LLC-load
>>>> S56-D0-CLS2338    4             15,721      LLC-load
>>>> S56-D0-CLS2774    4             22,671      LLC-load
>>>> [...]
>>>>
>>>> [1] commit c5e22feffdd7 ("topology: Represent clusters of CPUs within a die")
>>>>
>>>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>    
>>>
>>> An end user may have to check sysfs to figure out what CPUs those 
>>> cluster IDs account for.
>>>
>>> Any better method to show the mapping between CPUs and cluster IDs?  
>>
>> The cluster code is capable of using the ACPI_PPTT_ACPI_PROCESSOR_ID field
>> if valid for the cluster level of PPTT.
>>
>> The numbers in the example above look like offsets into the PPTT table
>> so I think the PPTT table is missing that information.
>>

Yes it is, the PPTT doesn't give a valid ID on my machine, for cluster and other
topologies. It's not a problem of this patch.

>> Whilst not a great description anyway (it's just an index), the UUID
>> that would be in there can convey more info on which cluster this is.
>>
>>
>>>
>>> Perhaps adding a conditional cluster id (when there are clusters) in the 
>>> "--per-core" output may help.  
>>
>> That's an interesting idea.  You'd want to include the other levels
>> if doing that.  So whenever you do a --per-xxx it also provides the
>> cluster / die / node / socket etc as relevant 'above' the level of xxx
>> Fun is that node and die can flip which would make this tricky to do.
> 
> Ignore me on this.  I'd not looked at the patch closely when I wrote
> this.  Clearly a lot of this information is already provided - the
> suggestion was to consider adding cluster to that mix which makes
> sense to me.
> 

In the early version of this patch I added the cluster info in the "--per-core"
output as "Sxxx-Dxxx-CLSxxx-Cxxx". But I decide to keep it as is to not break
the existed tools/scripts using --per-core outputs. Maybe we can add it later
if there's requirement.

Thanks,
Yicong

