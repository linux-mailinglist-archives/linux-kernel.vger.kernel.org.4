Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F0E624288
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 13:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiKJMqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 07:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiKJMp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 07:45:59 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D3ED364A25
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 04:45:56 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43E241FB;
        Thu, 10 Nov 2022 04:46:02 -0800 (PST)
Received: from e126311.manchester.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01CEE3F703;
        Thu, 10 Nov 2022 04:45:52 -0800 (PST)
Date:   Thu, 10 Nov 2022 12:45:18 +0000
From:   Kajetan Puchalski <kajetan.puchalski@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jian-Min Liu <jian-min.liu@mediatek.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Qais Yousef <qais.yousef@arm.com>,
        linux-kernel@vger.kernel.org,
        Jonathan JMChen <jonathan.jmchen@mediatek.com>
Subject: Re: [RFC PATCH 0/1] sched/pelt: Change PELT halflife at runtime
Message-ID: <Y2zyXtWQwaAZLHWj@e126311.manchester.arm.com>
References: <20220829055450.1703092-1-dietmar.eggemann@arm.com>
 <0f82011994be68502fd9833e499749866539c3df.camel@mediatek.com>
 <YzVpqweg21yIn30A@hirez.programming.kicks-ass.net>
 <YzV9Gejo/+DL3UjK@e126311.manchester.arm.com>
 <YzV/yT6OYMgaq0kD@hirez.programming.kicks-ass.net>
 <YzWuq5ShtJC6KWqe@e126311.manchester.arm.com>
 <Y2kLA8x40IiBEPYg@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2kLA8x40IiBEPYg@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Would something terrible like the below help some?
> 
> If not, I suppose it could be modified to take the current state as
> history. But basically it runs a faster pelt sum along side the regular
> signal just for ramping up the frequency.

As Dietmar mentioned in the other email, there seems to be an issue with
how the patch computes 'runtime'. Nevertheless I tested it just to see
what would happen so here are the results if you're interested.

Here's a comparison of Jankbench results on a normal system vs pelt_4 vs
performance cpufreq governor vs your pelt_rampup patch.

Max frame duration (ms)

+-----------------------+-----------+------------+
|        kernel         | iteration |   value    |
+-----------------------+-----------+------------+
|       menu            |    10     | 142.973401 |
|   menu_pelt_4         |    10     | 85.271279  |
|   menu_pelt_rampup    |    10     | 61.494636  |
|   menu_performance    |    10     | 40.930829  |
+-----------------------+-----------+------------+

Power usage [mW]

+--------------+-----------------------+-------+-----------+
|  chan_name   |        kernel         | value | perc_diff |
+--------------+-----------------------+-------+-----------+
| total_power  |       menu            | 144.6 |   0.0%    |
| total_power  |   menu_pelt_4         | 158.5 |   9.63%   |
| total_power  |   menu_pelt_rampup    | 272.1 |  88.23%   |
| total_power  |   menu_performance    | 485.6 |  235.9%   |
+--------------+-----------------------+-------+-----------+


Mean frame duration (ms)

+---------------+-----------------------+-------+-----------+
|   variable    |        kernel         | value | perc_diff |
+---------------+-----------------------+-------+-----------+
| mean_duration |       menu            | 13.9  |   0.0%    |
| mean_duration |   menu_pelt_4         | 14.5  |   4.74%   |
| mean_duration |   menu_pelt_rampup    |  8.3  |  -40.31%  |
| mean_duration |   menu_performance    |  4.4  |  -68.13%  |
+---------------+-----------------------+-------+-----------+

Jank percentage

+-----------+-----------------------+-------+-----------+
| variable  |        kernel         | value | perc_diff |
+-----------+-----------------------+-------+-----------+
| jank_perc |       menu            |  1.5  |   0.0%    |
| jank_perc |   menu_pelt_4         |  2.0  |  30.08%   |
| jank_perc |   menu_pelt_rampup    |  0.1  |  -93.09%  |
| jank_perc |   menu_performance    |  0.1  |  -96.29%  |
+-----------+-----------------------+-------+-----------+

[...]

Some variant of this that's tunable at runtime could be workable for the
purposes described before. At least this further proves that it's manipulating
frequency that's responsible for the results here.

---
Kajetan
