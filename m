Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8016B2009
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 10:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjCIJaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 04:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjCIJaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:30:09 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7919E526
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 01:30:08 -0800 (PST)
Received: from dggpeml500018.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PXP5W0pKBzrSFQ;
        Thu,  9 Mar 2023 17:29:19 +0800 (CST)
Received: from [10.67.111.186] (10.67.111.186) by
 dggpeml500018.china.huawei.com (7.185.36.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 9 Mar 2023 17:30:06 +0800
Message-ID: <6a45bb5c-d851-d48d-44b1-cf533293a6d8@huawei.com>
Date:   Thu, 9 Mar 2023 17:30:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v2] sched/fair: sanitize vruntime of entity being migrated
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <vschneid@redhat.com>, <rkagan@amazon.de>
References: <20230306132418.50389-1-zhangqiao22@huawei.com>
 <CAKfTPtAYpkQVDBR0mcymVgu7aYY5rN1svW713mGJxbewHGJRqQ@mail.gmail.com>
 <CAKfTPtAOFthDtQj=EGbTzwG6ZE7GPpp_3Xg9wVr_8epO+fiFjw@mail.gmail.com>
 <d4d849e3-ea4b-1f84-b287-513fb7bff415@huawei.com>
 <CAKfTPtAVrmPCwuJ55e6TLrVjQnsgDAdg2rGY_0DXcJGzBft15Q@mail.gmail.com>
 <ZAiFxWLSb9HDazSI@vingu-book>
 <07c692fd-fe59-1bd4-a6d0-e84bee6dbb3b@huawei.com>
 <5250a0fc-3470-b313-0810-5d7a68c7cf50@arm.com>
From:   Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <5250a0fc-3470-b313-0810-5d7a68c7cf50@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.186]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/3/9 17:09, Dietmar Eggemann 写道:
> On 09/03/2023 09:37, Zhang Qiao wrote:
>>
>> 在 2023/3/8 20:55, Vincent Guittot 写道:
>>> Le mercredi 08 mars 2023 à 09:01:05 (+0100), Vincent Guittot a écrit :
>>>> On Tue, 7 Mar 2023 at 14:41, Zhang Qiao <zhangqiao22@huawei.com> wrote:
> 
> [...]
> 
>>>>> 在 2023/3/7 18:26, Vincent Guittot 写道:
>>>>>> On Mon, 6 Mar 2023 at 14:53, Vincent Guittot <vincent.guittot@linaro.org> wrote:
>>>>>>>
>>>>>>> On Mon, 6 Mar 2023 at 13:57, Zhang Qiao <zhangqiao22@huawei.com> wrote:
> 
> [...]
> 
>>> +static inline bool migrate_long_sleeper(struct sched_entity *se)
>>> +{
>>> +       struct cfs_rq *cfs_rq;
>>> +       u64 sleep_time;
>>> +
>>> +       if (se->exec_start == 0)
>>
>> How about use `se->avg.last_update_time == 0` here?
> 
> IMHO, both checks are not needed here since we're still dealing with the
> originating CPU of the migration. Both of them are set to 0 only at the
> end of migrate_task_rq_fair().

Yes, if place_entity() don't call migrate_long_sleeper(), the check can remove.

> 
> 
>>> +               return false;
>>> +
>>> +       cfs_rq = cfs_rq_of(se);
>>> +       /*
>>> +        * If the entity slept for a long time, don't even try to normalize its
>>> +        * vruntime with the base as it may be too far off and might generate
>>> +        * wrong decision because of s64 overflow.
>>> +        * We estimate its sleep duration with the last update of se's pelt.
>>> +        * The last update happened before sleeping. The cfs' pelt is not
>>> +        * always updated when cfs is idle but this is not a problem because
>>> +        * its min_vruntime is not updated too, so the situation can't get
>>> +        * worse.
>>> +        */
>>> +       sleep_time = cfs_rq_last_update_time(cfs_rq) - se->avg.last_update_time;
> 
> Looks like this doesn't work for asymmetric CPU capacity systems since
> we specifically do a sync_entity_load_avg() in select_task_rq_fair()
> (find_energy_efficient_cpu() for EAS and select_idle_sibling() for CAS)
> to sync cfs_rq and se (including their last_update_time).
> 
> [...]
> 
> .
> 
