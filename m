Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502D07161B0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjE3NZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbjE3NZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:25:04 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA57D9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:25:03 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QVtRQ3yk7zTkDs;
        Tue, 30 May 2023 21:24:50 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 21:24:58 +0800
CC:     <yangyicong@hisilicon.com>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <tim.c.chen@linux.intel.com>,
        <yu.c.chen@intel.com>, <gautham.shenoy@amd.com>, <mgorman@suse.de>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <bristot@redhat.com>,
        <prime.zeng@huawei.com>, <jonathan.cameron@huawei.com>,
        <ego@linux.vnet.ibm.com>, <srikar@linux.vnet.ibm.com>,
        <linuxarm@huawei.com>, <21cnbao@gmail.com>,
        <kprateek.nayak@amd.com>, <wuyun.abel@bytedance.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH v8 1/2] sched: Add per_cpu cluster domain info and
 cpus_share_lowest_cache API
To:     Peter Zijlstra <peterz@infradead.org>
References: <20230530070253.33306-1-yangyicong@huawei.com>
 <20230530070253.33306-2-yangyicong@huawei.com>
 <20230530113820.GB156198@hirez.programming.kicks-ass.net>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <70bf599c-6338-f4b6-afe9-75ec97912b0a@huawei.com>
Date:   Tue, 30 May 2023 21:24:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20230530113820.GB156198@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/30 19:38, Peter Zijlstra wrote:
> On Tue, May 30, 2023 at 03:02:52PM +0800, Yicong Yang wrote:
>> From: Barry Song <song.bao.hua@hisilicon.com>
>>
>> Add per-cpu cluster domain info and cpus_share_lowest_cache() API.
> 
> Lowest cache is weird; that would be L1, but your implementation is for
> L2/L3.
> 

ok there seems a history about this naming.

In the first version we make it cpus_share_cluster(), since on non-cluster
machine it actually behaves as cpus_share_cache() so "cluster" maybe inaccurate.
Then we make it cpus_share_resources() [1]. Tim mentioned cpus_share_lowest_cache()
maybe more informative in [2] so we use it.

Since lowest cache may refer to L1 as mentioned, maybe we should use
cpus_share_resources() again to avoid confusion?

[1] https://lore.kernel.org/lkml/CAKfTPtBKLDyNPXg7uLbQ3jUnEwppfC+E29=oJ1tWzzqHsNpApw@mail.gmail.com/
[2] https://lore.kernel.org/lkml/05472b4ed10c694bce1a2b6dd4a0ef13ea337db3.camel@linux.intel.com/

Thanks,
Yicong
