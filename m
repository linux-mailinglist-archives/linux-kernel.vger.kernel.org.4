Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CB36B1F7F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 10:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjCIJKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 04:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjCIJKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:10:05 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B91B76485A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 01:09:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD0E8C14;
        Thu,  9 Mar 2023 01:10:36 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68A9A3F5A1;
        Thu,  9 Mar 2023 01:09:51 -0800 (PST)
Message-ID: <5250a0fc-3470-b313-0810-5d7a68c7cf50@arm.com>
Date:   Thu, 9 Mar 2023 10:09:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] sched/fair: sanitize vruntime of entity being migrated
Content-Language: en-US
To:     Zhang Qiao <zhangqiao22@huawei.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, rkagan@amazon.de
References: <20230306132418.50389-1-zhangqiao22@huawei.com>
 <CAKfTPtAYpkQVDBR0mcymVgu7aYY5rN1svW713mGJxbewHGJRqQ@mail.gmail.com>
 <CAKfTPtAOFthDtQj=EGbTzwG6ZE7GPpp_3Xg9wVr_8epO+fiFjw@mail.gmail.com>
 <d4d849e3-ea4b-1f84-b287-513fb7bff415@huawei.com>
 <CAKfTPtAVrmPCwuJ55e6TLrVjQnsgDAdg2rGY_0DXcJGzBft15Q@mail.gmail.com>
 <ZAiFxWLSb9HDazSI@vingu-book>
 <07c692fd-fe59-1bd4-a6d0-e84bee6dbb3b@huawei.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <07c692fd-fe59-1bd4-a6d0-e84bee6dbb3b@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2023 09:37, Zhang Qiao wrote:
> 
> 在 2023/3/8 20:55, Vincent Guittot 写道:
>> Le mercredi 08 mars 2023 à 09:01:05 (+0100), Vincent Guittot a écrit :
>>> On Tue, 7 Mar 2023 at 14:41, Zhang Qiao <zhangqiao22@huawei.com> wrote:

[...]

>>>> 在 2023/3/7 18:26, Vincent Guittot 写道:
>>>>> On Mon, 6 Mar 2023 at 14:53, Vincent Guittot <vincent.guittot@linaro.org> wrote:
>>>>>>
>>>>>> On Mon, 6 Mar 2023 at 13:57, Zhang Qiao <zhangqiao22@huawei.com> wrote:

[...]

>> +static inline bool migrate_long_sleeper(struct sched_entity *se)
>> +{
>> +       struct cfs_rq *cfs_rq;
>> +       u64 sleep_time;
>> +
>> +       if (se->exec_start == 0)
> 
> How about use `se->avg.last_update_time == 0` here?

IMHO, both checks are not needed here since we're still dealing with the
originating CPU of the migration. Both of them are set to 0 only at the
end of migrate_task_rq_fair().


>> +               return false;
>> +
>> +       cfs_rq = cfs_rq_of(se);
>> +       /*
>> +        * If the entity slept for a long time, don't even try to normalize its
>> +        * vruntime with the base as it may be too far off and might generate
>> +        * wrong decision because of s64 overflow.
>> +        * We estimate its sleep duration with the last update of se's pelt.
>> +        * The last update happened before sleeping. The cfs' pelt is not
>> +        * always updated when cfs is idle but this is not a problem because
>> +        * its min_vruntime is not updated too, so the situation can't get
>> +        * worse.
>> +        */
>> +       sleep_time = cfs_rq_last_update_time(cfs_rq) - se->avg.last_update_time;

Looks like this doesn't work for asymmetric CPU capacity systems since
we specifically do a sync_entity_load_avg() in select_task_rq_fair()
(find_energy_efficient_cpu() for EAS and select_idle_sibling() for CAS)
to sync cfs_rq and se (including their last_update_time).

[...]
