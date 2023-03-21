Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118F76C2EEF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 11:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjCUK3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 06:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjCUK30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:29:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA9B0CC29
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 03:29:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58615AD7;
        Tue, 21 Mar 2023 03:30:00 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BECEE3F766;
        Tue, 21 Mar 2023 03:29:14 -0700 (PDT)
Message-ID: <7bba69e0-5261-9921-16b7-c8592b5d213b@arm.com>
Date:   Tue, 21 Mar 2023 11:29:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] sched/fair: sanitize vruntime of entity being migrated
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org,
        zhangqiao22@huawei.com
References: <20230317160810.107988-1-vincent.guittot@linaro.org>
 <20230321100206.GE2234901@hirez.programming.kicks-ass.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230321100206.GE2234901@hirez.programming.kicks-ass.net>
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

On 21/03/2023 11:02, Peter Zijlstra wrote:
> On Fri, Mar 17, 2023 at 05:08:10PM +0100, Vincent Guittot wrote:
>> Commit 829c1651e9c4 ("sched/fair: sanitize vruntime of entity being placed")
>> fixes an overflowing bug, but ignore a case that se->exec_start is reset
>> after a migration.
>>
>> For fixing this case, we delay the reset of se->exec_start after
>> placing the entity which se->exec_start to detect long sleeping task.
>>
>> In order to take into account a possible divergence between the clock_task
>> of 2 rqs, we increase the threshold to around 104 days.
>>
>>
>> Fixes: 829c1651e9c4 ("sched/fair: sanitize vruntime of entity being placed")
>> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>> ---
> 
> Blergh, this just isn't going to be nice. I'll go queue this for
> sched/urgent and then we can forget about this for a little while.
> 
> Thanks!

Don't we miss setting `se->exec_start = 0` for fair task in
move_queued_task()? ( ... and __migrate_swap_task())

https://lkml.kernel.org/r/df2cccda-1550-b06b-aa74-e0f054e9fb9d@arm.com

