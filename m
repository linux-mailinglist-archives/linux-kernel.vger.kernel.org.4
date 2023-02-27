Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D76F6A4772
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjB0RA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjB0RAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:00:16 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70E7C1CACE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:00:13 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0BE7C14;
        Mon, 27 Feb 2023 09:00:55 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF8433F881;
        Mon, 27 Feb 2023 09:00:10 -0800 (PST)
Message-ID: <ccd80042-39ef-f9ea-c2cd-eac5bd0e8095@arm.com>
Date:   Mon, 27 Feb 2023 18:00:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3] sched/fair: sanitize vruntime of entity being placed
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Roman Kagan <rkagan@amazon.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <vschneid@redhat.com>,
        Zhang Qiao <zhangqiao22@huawei.com>,
        Ben Segall <bsegall@google.com>,
        Waiman Long <longman@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
References: <20230209193107.1432770-1-rkagan@amazon.de>
 <CAKfTPtB7ZDyCh0MiNQtyimVhYJ6E3C+2bTptj9CX3+mepH8YAQ@mail.gmail.com>
 <Y/T36NvaCxSfS8Z/@u40bc5e070a0153.ant.amazon.com>
 <CAKfTPtCDxdVEmPQf=6g7n7Y+bkozXAJT1NG92wDc_quNaDiHMg@mail.gmail.com>
 <Y/xtDWYTKLutOqrM@u40bc5e070a0153.ant.amazon.com>
 <CAKfTPtAq3yBYBxpR=RO8zxrQduOymqkdAEhigjfCuGfsY1uHsg@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <CAKfTPtAq3yBYBxpR=RO8zxrQduOymqkdAEhigjfCuGfsY1uHsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/2023 15:37, Vincent Guittot wrote:
> On Mon, 27 Feb 2023 at 09:43, Roman Kagan <rkagan@amazon.de> wrote:
>>
>> On Tue, Feb 21, 2023 at 06:26:11PM +0100, Vincent Guittot wrote:
>>> On Tue, 21 Feb 2023 at 17:57, Roman Kagan <rkagan@amazon.de> wrote:
>>>> What scares me, though, is that I've got a message from the test robot
>>>> that this commit drammatically affected hackbench results, see the quote
>>>> below.  I expected the commit not to affect any benchmarks.
>>>>
>>>> Any idea what could have caused this change?
>>>
>>> Hmm, It's most probably because se->exec_start is reset after a
>>> migration and the condition becomes true for newly migrated task
>>> whereas its vruntime should be after min_vruntime.
>>>
>>> We have missed this condition
>>
>> Makes sense to me.
>>
>> But what would then be the reliable way to detect a sched_entity which
>> has slept for long and risks overflowing in .vruntime comparison?
> 
> For now I don't have a better idea than adding the same check in
> migrate_task_rq_fair()

Don't we have the issue that we could have a non-up-to-date rq clock in
migrate? No rq lock held in `!task_on_rq_migrating(p)`.

Also deferring `se->exec_start = 0` from `migrate` into `enqueue ->
place entity` doesn't seem to work since the rq clocks of different CPUs
are not in sync.

