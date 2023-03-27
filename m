Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E646C9A66
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 06:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjC0EEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 00:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbjC0EEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 00:04:39 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4944693;
        Sun, 26 Mar 2023 21:04:35 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PlJy92pjJznwPd;
        Mon, 27 Mar 2023 12:00:49 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 12:04:02 +0800
CC:     <yangyicong@hisilicon.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "21cnbao@gmail.com" <21cnbao@gmail.com>,
        "prime.zeng@hisilicon.com" <prime.zeng@hisilicon.com>,
        "shenyang39@huawei.com" <shenyang39@huawei.com>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCH] perf stat: Support per-cluster aggregation
To:     "Chen, Tim C" <tim.c.chen@intel.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "james.clark@arm.com" <james.clark@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230313085911.61359-1-yangyicong@huawei.com>
 <DM6PR11MB4107255E167D98A000DC49FBDC849@DM6PR11MB4107.namprd11.prod.outlook.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <150cb3ae-fbb3-e0e1-57af-6f5b28222fdb@huawei.com>
Date:   Mon, 27 Mar 2023 12:03:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB4107255E167D98A000DC49FBDC849@DM6PR11MB4107.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

Hi Tim,

On 2023/3/25 2:05, Chen, Tim C wrote:
>>
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> Some platforms have 'cluster' topology and CPUs in the cluster will share
>> resources like L3 Cache Tag (for HiSilicon Kunpeng SoC) or L2 cache (for Intel
>> Jacobsville). Currently parsing and building cluster topology have been
>> supported since [1].
>>
>> perf stat has already supported aggregation for other topologies like die or
>> socket, etc. It'll be useful to aggregate per-cluster to find problems like L3T
>> bandwidth contention or imbalance.
>>
>> This patch adds support for "--per-cluster" option for per-cluster aggregation.
>> Also update the docs and related test. The output will be like:
>>
>> [root@localhost tmp]# perf stat -a -e LLC-load --per-cluster -- sleep 5
>>
>> Performance counter stats for 'system wide':
>>
>> S56-D0-CLS158    4      1,321,521,570      LLC-load
>> S56-D0-CLS594    4        794,211,453      LLC-load
>> S56-D0-CLS1030    4             41,623      LLC-load
>> S56-D0-CLS1466    4             41,646      LLC-load
>> S56-D0-CLS1902    4             16,863      LLC-load
>> S56-D0-CLS2338    4             15,721      LLC-load
>> S56-D0-CLS2774    4             22,671      LLC-load
>> [...]
> 
> Overall it looks good.  You can add my reviewed-by.
> 

thanks.

> I wonder if we could enhance the help message 
> in perf stat to tell user to refer to 
> /sys/devices/system/cpu/cpuX/topology/*_id
> to map relevant ids back to overall cpu topology.
> 
> For example the above example, cluster S56-D0-CLS158  has
> really heavy load. It took me  a while
> going through the code to figure out how to find
> the info that maps cluster id to cpu.
> 

yes, indeed. Actually this is because my bios doesn't report a valid
ID for these topologies so the ACPI use the offset of the topology
node in the PPTT as a fallback. Other topologies also suffers the same:

On my machine:
[root@localhost debug]# perf stat --per-socket -e cycles -a -- sleep 1

 Performance counter stats for 'system wide':

S56      64         21,563,375      cycles
S7182    64         32,140,641      cycles

       1.008520310 seconds time elapsed

On x86:
root@ubuntu204:/home/yang/linux/tools/perf# ./perf stat -a --per-socket -e cycles -- sleep 1

 Performance counter stats for 'system wide':

S0       40        137,205,897      cycles
S1       40         67,720,731      cycles

       1.003546720 seconds time elapsed

Maybe I can try to add a separate patch for describing the source of the
topology ids in the perf manual.

Thanks,
Yicong

