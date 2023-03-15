Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60EA6BB4CD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbjCONgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbjCONgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:36:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 63F3C97B4B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:35:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D335B2F4;
        Wed, 15 Mar 2023 06:36:42 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 430583F8C6;
        Wed, 15 Mar 2023 06:35:57 -0700 (PDT)
Message-ID: <b2ded6d7-6516-d193-cb23-1609aa03d324@arm.com>
Date:   Wed, 15 Mar 2023 14:35:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] sched/fair: sanitize vruntime of entity being migrated
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Zhang Qiao <zhangqiao22@huawei.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        rkagan@amazon.de
References: <CAKfTPtAf5RrzZRSHtfK+r3QvnFQ-oM3+rJ-z5SB8T4+nUv1aQw@mail.gmail.com>
 <20230309142825.GB273121@hirez.programming.kicks-ass.net>
 <ZAnvCGdlOrWbIC/o@hirez.programming.kicks-ass.net>
 <CAKfTPtADUas2QHZCQyu0ad-JTKRQ=PcsB=o7+PuJNVxHwAzkCQ@mail.gmail.com>
 <ZAs+zV0o9ShO7nLT@vingu-book> <02a08042-e7c4-464d-bc20-9ec4ccdab1ff@arm.com>
 <8c093661-7431-00d8-d703-b8f7a7c8e747@arm.com>
 <CAKfTPtBw9SJxVBcN1qff7jRzE81kXSjbc-rXD6goEBFiXEwbyg@mail.gmail.com>
 <20230314120726.GG1845660@hirez.programming.kicks-ass.net>
 <CAKfTPtBHocw4N-YMHeqfMj78Ro=aF8sJPanxVCN=tM70hr6r8g@mail.gmail.com>
 <20230314171607.GN2017917@hirez.programming.kicks-ass.net>
 <CAKfTPtBurhAxcykDWQHoSZ0aiokgK4jhamdh-F29643cL1jVsw@mail.gmail.com>
 <CAKfTPtCra1QV32w1MZQY2SHVDv58m2MT2QwpHu0huJJ3B1wcCA@mail.gmail.com>
 <5527ad0e-0f6d-fb4c-7505-a1c80192ed3b@arm.com>
 <CAKfTPtDfnersgtWQy7Qxq1x1Y6BZP-6K95gcQB1Mi0RaU3TpYg@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <CAKfTPtDfnersgtWQy7Qxq1x1Y6BZP-6K95gcQB1Mi0RaU3TpYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/2023 11:21, Vincent Guittot wrote:
> On Wed, 15 Mar 2023 at 11:15, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 15/03/2023 09:42, Vincent Guittot wrote:
>>> On Wed, 15 Mar 2023 at 08:18, Vincent Guittot
>>> <vincent.guittot@linaro.org> wrote:
>>>>
>>>> On Tue, 14 Mar 2023 at 18:16, Peter Zijlstra <peterz@infradead.org> wrote:
>>>>>
>>>>> On Tue, Mar 14, 2023 at 02:24:37PM +0100, Vincent Guittot wrote:
>>>>>

[...]

>> Isn't there an issue with this approach on asymmetric CPU capacity systems?
>>
>> We do a sync_entity_load_avg() in select_task_rq_fair()
>> (find_energy_efficient_cpu() for EAS and select_idle_sibling() for CAS)
>> to sync cfs_rq and se.
> 
> ah yes, I forgot this point.
> That being said, is it a valid problem for EAS based system ? I mean
> we are trying to fix a vruntime comparison overflow that can happen
> with a very long sleeping task (around 200 days) while only a very low
> weight entity is always running  during those 200 days.

True. Definitively very unlikely. But it's not only EAS, any asymmetric
CPU capacity wakeup wouldn't have this check in this case.

This dependency between sync_entity_load_avg() and the overflow
detection would be very hard to spot though (in case
sync_entity_load_avg() would get introduced in more common wakeup paths
later).
