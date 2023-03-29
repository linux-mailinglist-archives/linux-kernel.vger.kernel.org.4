Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E8F6CD984
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 14:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjC2MrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 08:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjC2MrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 08:47:02 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4ECA3ABE;
        Wed, 29 Mar 2023 05:46:57 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PmmWk11rvzKqFG;
        Wed, 29 Mar 2023 20:46:26 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 20:46:55 +0800
CC:     <yangyicong@hisilicon.com>, "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "james.clark@arm.com" <james.clark@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "21cnbao@gmail.com" <21cnbao@gmail.com>,
        "prime.zeng@hisilicon.com" <prime.zeng@hisilicon.com>,
        "shenyang39@huawei.com" <shenyang39@huawei.com>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCH] perf stat: Support per-cluster aggregation
To:     Namhyung Kim <namhyung@gmail.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>
References: <20230313085911.61359-1-yangyicong@huawei.com>
 <DM6PR11MB4107255E167D98A000DC49FBDC849@DM6PR11MB4107.namprd11.prod.outlook.com>
 <CAM9d7cgeLdBoniAz64YrzSYKw2Y4ivy5DhEzReEzhm41M-nvSQ@mail.gmail.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <6cd44ff7-d339-d9a4-a134-2b8b9b3dbbfa@huawei.com>
Date:   Wed, 29 Mar 2023 20:46:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <CAM9d7cgeLdBoniAz64YrzSYKw2Y4ivy5DhEzReEzhm41M-nvSQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

On 2023/3/29 14:47, Namhyung Kim wrote:
> Hello,
> 
> On Fri, Mar 24, 2023 at 11:09 AM Chen, Tim C <tim.c.chen@intel.com> wrote:
>>
>>>
>>> From: Yicong Yang <yangyicong@hisilicon.com>
>>>
>>> Some platforms have 'cluster' topology and CPUs in the cluster will share
>>> resources like L3 Cache Tag (for HiSilicon Kunpeng SoC) or L2 cache (for Intel
>>> Jacobsville). Currently parsing and building cluster topology have been
>>> supported since [1].
>>>
>>> perf stat has already supported aggregation for other topologies like die or
>>> socket, etc. It'll be useful to aggregate per-cluster to find problems like L3T
>>> bandwidth contention or imbalance.
>>>
>>> This patch adds support for "--per-cluster" option for per-cluster aggregation.
>>> Also update the docs and related test. The output will be like:
>>>
>>> [root@localhost tmp]# perf stat -a -e LLC-load --per-cluster -- sleep 5
>>>
>>> Performance counter stats for 'system wide':
>>>
>>> S56-D0-CLS158    4      1,321,521,570      LLC-load
>>> S56-D0-CLS594    4        794,211,453      LLC-load
>>> S56-D0-CLS1030    4             41,623      LLC-load
>>> S56-D0-CLS1466    4             41,646      LLC-load
>>> S56-D0-CLS1902    4             16,863      LLC-load
>>> S56-D0-CLS2338    4             15,721      LLC-load
>>> S56-D0-CLS2774    4             22,671      LLC-load
>>> [...]
>>
>> Overall it looks good.  You can add my reviewed-by.
>>
>> I wonder if we could enhance the help message
>> in perf stat to tell user to refer to
>> /sys/devices/system/cpu/cpuX/topology/*_id
>> to map relevant ids back to overall cpu topology.
>>
>> For example the above example, cluster S56-D0-CLS158  has
>> really heavy load. It took me  a while
>> going through the code to figure out how to find
>> the info that maps cluster id to cpu.
> 
> Maybe we could enhance the cpu filter to accept something
> like -C S56-D0-CLS158.
> 

you mean specified the CPUs by a topology ID like this S56-D0-CLS158
then we actually filtering the CPUs in the CLS 158?

> I also wonder what if it runs on an old kernel which doesn't
> have the cluster_id file.

It should work well but may not be proper for the cluster. There's
no die topology nor related sysfs attributes on arm64, but --per-die
works like:

[root@localhost perf]# perf stat -a -e cycles --per-die -- sleep 1

 Performance counter stats for 'system wide':

S56-D0         64         12,700,186      cycles
S7182-D0       64         20,297,320      cycles

       1.003638080 seconds time elapsed

On a legacy kernel without cluster sysfs attributes, the output will be
look like:

[root@localhost perf]# perf stat -a -e cycles --per-cluster -- sleep 1

 Performance counter stats for 'system wide':

S56-D0-CLS-1   64         12,634,251      cycles
S7182-D0-CLS-1   64         16,348,322      cycles

       1.003696680 seconds time elapsed

The patch just assign -1 to the cluster id. I'll modify this to keep consistence
with the output of --per-die. Thanks for catching this!

Thanks,
Yicong


