Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7155EA7F8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbiIZOIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbiIZOIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:08:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 58DB18E985
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 05:19:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56C71ED1;
        Mon, 26 Sep 2022 05:13:39 -0700 (PDT)
Received: from [10.34.100.114] (pierre123.nice.arm.com [10.34.100.114])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA4553F73B;
        Mon, 26 Sep 2022 05:13:28 -0700 (PDT)
Message-ID: <dbde69d9-07f6-e08a-632b-de0c0f154325@arm.com>
Date:   Mon, 26 Sep 2022 14:13:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] sched/fair: Check if prev_cpu has highest spare cap
 in feec()
Content-Language: en-US
To:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     qperret@google.com, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
References: <20220819153320.291720-1-pierre.gondois@arm.com>
 <20220819153320.291720-2-pierre.gondois@arm.com>
 <42b2c57d-33d4-dc41-efc4-682aa02f9429@arm.com>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <42b2c57d-33d4-dc41-efc4-682aa02f9429@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peter,

The second patch:
  -[PATCH 2/2] sched/fair: Use IRQ scaling for all sched classes
must be dropped, cf. Vincent Guittot's review, but I believe this patch
should be ok to take if there is no other comment,

Regards,
Pierre

On 8/29/22 07:13, Dietmar Eggemann wrote:
> On 19/08/2022 17:33, Pierre Gondois wrote:
>> When evaluating the CPU candidates in the perf domain (pd) containing
>> the previously used CPU (prev_cpu), find_energy_efficient_cpu()
>> evaluates the energy of the pd:
>> - without the task (base_energy)
>> - with the task placed on prev_cpu (if the task fits)
>> - with the task placed on the CPU with the highest spare capacity,
>>    prev_cpu being excluded from this set
>>
>> If prev_cpu is already the CPU with the highest spare capacity,
>> max_spare_cap_cpu will be the CPU with the second highest spare
>> capacity.
>>
>> On an Arm64 Juno-r2, with a workload of 10 tasks at a 10% duty cycle,
>> when prev_cpu and max_spare_cap_cpu are both valid candidates,
>> prev_spare_cap > max_spare_cap at ~82%.
>> Thus the energy of the pd when placing the task on max_spare_cap_cpu
>> is computed with no possible positive outcome 82% most of the time.
>>
>> Do not consider max_spare_cap_cpu as a valid candidate if
>> prev_spare_cap > max_spare_cap.
>>
>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> 
> LGTM. When I ran the workload I see this happening in 50%-90% of the EAS
> wakeups. This should prevent one needless compute_energy() call out of 7
> on a typical 3-gear system like 2x2x4 in these cases.
> 
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> 
> [...]
