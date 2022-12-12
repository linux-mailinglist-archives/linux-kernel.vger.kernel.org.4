Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5DB649D7F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 12:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbiLLLX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 06:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbiLLLX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 06:23:29 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB5126F2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 03:22:51 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NVzfT28ljzJpK8;
        Mon, 12 Dec 2022 19:19:13 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 12 Dec 2022 19:22:49 +0800
CC:     <yangyicong@hisilicon.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        <linux-kernel@vger.kernel.org>, Josh Don <joshdon@google.com>
Subject: Re: [PATCH v3 1/2] sched/fair: Introduce short duration task check
To:     Chen Yu <yu.c.chen@intel.com>
References: <Y4r/iuqyLG4MOK4d@chenyu5-mobl1>
 <3A5DA66F-4330-4FC4-9229-998CF98F663E@joelfernandes.org>
 <Y42uH5fglluWYOm7@chenyu5-mobl1>
 <CAKfTPtA61DDk-VbNDvAycp8Et5fTwaOS=Q3559rBF7QDHDpJfQ@mail.gmail.com>
 <CABk29Nuc+VVOpAwFsbBo+OppayszebT29Hadc8qK-xeyZpY6NQ@mail.gmail.com>
 <Y5CiN010QAwklahh@chenyu5-mobl1>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <e0b20fe3-6528-41ca-f53f-d78e76cd122a@huawei.com>
Date:   Mon, 12 Dec 2022 19:22:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <Y5CiN010QAwklahh@chenyu5-mobl1>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/7 22:24, Chen Yu wrote:
> Hi Josh,
> On 2022-12-06 at 18:23:47 -0800, Josh Don wrote:
>>> We don't want to add more dedicated knobs. So using
>>> sysctl_sched_min_granularity as you are doing in this patch looks ok
>>
>> If not a knob, then maybe at least a smaller hardcoded value? Several
>> milliseconds seems like too long for this optimization; the
>> opportunity cost of not doing the idle search likely doesn't make
>> sense if the waker is going to be active for several additional
>> milliseconds. I would have guessed something on the order of 100us.
>>
>> Chen, what is the run duration of tasks in your ping pong example?
> OK, I'll measure the duration of all the tests and summarize the data later.
> 

If we decide to use sysctl_sched_min_granularity as the threshold of a short
task, can we also export p->se.dur_avg (somewhere like /proc/[pid]/sched)?
It may be helpful to choose a proper value for sysctl_sched_min_granularity.

Thanks.
