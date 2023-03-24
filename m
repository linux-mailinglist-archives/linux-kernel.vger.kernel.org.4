Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B3C6C75EE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 03:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjCXCek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 22:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCXCei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 22:34:38 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05ED11025B;
        Thu, 23 Mar 2023 19:34:35 -0700 (PDT)
Received: from dggpeml500019.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PjR6P3t9Fz17Mnv;
        Fri, 24 Mar 2023 10:31:25 +0800 (CST)
Received: from [10.67.101.98] (10.67.101.98) by dggpeml500019.china.huawei.com
 (7.185.36.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 24 Mar
 2023 10:34:33 +0800
Message-ID: <039a2fc2-48e2-fe3b-73c1-f7f658c7f22f@hisilicon.com>
Date:   Fri, 24 Mar 2023 10:34:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH] perf stat: Support per-cluster aggregation
To:     Yicong Yang <yangyicong@huawei.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <peterz@infradead.org>, <mingo@redhat.com>,
        <james.clark@arm.com>, <alexander.shishkin@linux.intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <Jonathan.Cameron@huawei.com>, <21cnbao@gmail.com>,
        <tim.c.chen@intel.com>, <prime.zeng@hisilicon.com>,
        <shenyang39@huawei.com>, <linuxarm@huawei.com>,
        <yangyicong@hisilicon.com>
References: <20230313085911.61359-1-yangyicong@huawei.com>
From:   Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20230313085911.61359-1-yangyicong@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.101.98]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/03/2023 16:59, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
>
> Some platforms have 'cluster' topology and CPUs in the cluster will
> share resources like L3 Cache Tag (for HiSilicon Kunpeng SoC) or L2
> cache (for Intel Jacobsville). Currently parsing and building cluster
> topology have been supported since [1].
>
> perf stat has already supported aggregation for other topologies like
> die or socket, etc. It'll be useful to aggregate per-cluster to find
> problems like L3T bandwidth contention or imbalance.
>
> This patch adds support for "--per-cluster" option for per-cluster
> aggregation. Also update the docs and related test. The output will
> be like:
>
> [root@localhost tmp]# perf stat -a -e LLC-load --per-cluster -- sleep 5
>
>   Performance counter stats for 'system wide':
>
> S56-D0-CLS158    4      1,321,521,570      LLC-load
> S56-D0-CLS594    4        794,211,453      LLC-load
> S56-D0-CLS1030    4             41,623      LLC-load
> S56-D0-CLS1466    4             41,646      LLC-load
> S56-D0-CLS1902    4             16,863      LLC-load
> S56-D0-CLS2338    4             15,721      LLC-load
> S56-D0-CLS2774    4             22,671      LLC-load
> [...]
>
> [1] commit c5e22feffdd7 ("topology: Represent clusters of CPUs within a die")
>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

An end user may have to check sysfs to figure out what CPUs those 
cluster IDs account for.

Any better method to show the mapping between CPUs and cluster IDs?

Perhaps adding a conditional cluster id (when there are clusters) in the 
"--per-core" output may help.

Apart form that, this works well on my aarch64.

Tested-by: Jie Zhan <zhanjie9@hisilicon.com>


