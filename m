Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDEA672578
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjARRtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjARRsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:48:53 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DF3C5A801
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:48:43 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94B1B2B;
        Wed, 18 Jan 2023 09:49:25 -0800 (PST)
Received: from [10.1.196.21] (e125579.cambridge.arm.com [10.1.196.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9038F3F445;
        Wed, 18 Jan 2023 09:48:40 -0800 (PST)
Message-ID: <c56855a7-14fd-4737-fc8b-8ea21487c5f6@arm.com>
Date:   Wed, 18 Jan 2023 17:48:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC PATCH v4 1/2] sched/fair: Introduce short duration task
 check
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Chen Yu <yu.c.chen@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>, linux-kernel@vger.kernel.org
References: <cover.1671158588.git.yu.c.chen@intel.com>
 <ec049fd9b635f76a9e1d1ad380fd9184ebeeca53.1671158588.git.yu.c.chen@intel.com>
 <82689dd6-9db1-dd00-069b-73a637a21126@arm.com>
 <Y8Un9nmJauxpuSVE@hirez.programming.kicks-ass.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <Y8Un9nmJauxpuSVE@hirez.programming.kicks-ass.net>
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

On 16/01/2023 10:33, Peter Zijlstra wrote:
> On Thu, Jan 05, 2023 at 12:33:16PM +0100, Dietmar Eggemann wrote:
>> On 16/12/2022 07:11, Chen Yu wrote:

[...]

> You were thinking of the dynamic PELT window size thread? (which is what
> I had to think of when I looked at this).

Yes, indeed.

> I think we can still do that with this prev_sum_exec_runtime_vol (can't
> say I love the name though). At any point (assuming we update
> sum_exec_runtime) sum_exec_runtime - prev_sum_exec_runtime_vol is the
> duration of the current activation.

I ran Jankbench with your UTIL_EST_FASTER patch and:

    runtime = curr->se.sum_exec_runtime -
              curr->se.prev_sum_exec_runtime_vol

plus:

    runtime >>= 10

before doing:

    util_est_fast = faster_est_approx(runtime * 2)
                                              ^^^ (boost)

on a Pixel6 and the results look promising:

Max frame duration (ms)

+-------------------+-----------+------------+
|      wa_path      | iteration |   value    |
+-------------------+-----------+------------+
|        base       |    10     | 147.571352 |
|    pelt-hl-m2     |    10     | 119.416351 |
|    pelt-hl-m4     |    10     | 96.473412  |
|  util_est_faster  |    10     | 84.834999  |
+-------------------+-----------+------------+

Mean frame duration (average case)

+---------------+-------------------+-------+-----------+
|   variable    |      kernel       | value | perc_diff |
+---------------+-------------------+-------+-----------+
| mean_duration |        base       | 14.7  |   0.0%    |
| mean_duration |    pelt-hl-m2     | 13.6  |   -7.5%   |
| mean_duration |    pelt-hl-m4     | 13.0  |  -11.68%  |
| mean_duration |  util_est_faster  | 12.6  |  -14.01%  |
+---------------+-------------------+-------+-----------+

Jank percentage

+-----------+-------------------+-------+-----------+
| variable  |      kernel       | value | perc_diff |
+-----------+-------------------+-------+-----------+
| jank_perc |        base       |  1.8  |   0.0%    |
| jank_perc |    pelt-hl-m2     |  1.8  |  -4.91%   |
| jank_perc |    pelt-hl-m4     |  1.2  |  -36.61%  |
| jank_perc |  util_est_faster  |  0.8  |  -57.8%   |
+-----------+-------------------+-------+-----------+

Power usage [mW]

+--------------+-------------------+-------+-----------+
|  chan_name   |      kernel       | value | perc_diff |
+--------------+-------------------+-------+-----------+
| total_power  |        base       | 144.4 |   0.0%    |
| total_power  |    pelt-hl-m2     | 141.6 |  -1.97%   |
| total_power  |    pelt-hl-m4     | 163.2 |  12.99%   |
| total_power  |  util_est_faster  | 150.9 |   4.45%   |
+--------------+-------------------+-------+-----------+

At first glance it looks promising! Have to do more testing to
understand the behaviour fully.
