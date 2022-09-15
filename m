Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86935B9FCF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 18:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiIOQpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 12:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiIOQpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 12:45:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 69AD43DBFB;
        Thu, 15 Sep 2022 09:45:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7ECFE1682;
        Thu, 15 Sep 2022 09:45:10 -0700 (PDT)
Received: from e126311.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE2063F73B;
        Thu, 15 Sep 2022 09:45:02 -0700 (PDT)
From:   Kajetan Puchalski <kajetan.puchalski@arm.com>
To:     rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, kajetan.puchalski@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/1] cpuidle: teo: Introduce optional util-awareness
Date:   Thu, 15 Sep 2022 17:44:10 +0100
Message-Id: <20220915164411.2496380-1-kajetan.puchalski@arm.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

At the moment, all the available idle governors operate mainly based on their own past performance
without taking into account any scheduling information. Especially on interactive systems, this
results in them frequently selecting a deeper idle state and then waking up before its target
residency is hit, thus leading to increased wakeup latency and lower performance with no power
saving. For 'menu' while web browsing on Android for instance, those types of wakeups ('too deep')
account for over 24% of all wakeups.

At the same time, on some platforms C0 can be power efficient enough to warrant wanting to prefer
it over C1. Sleeps that happened in C0 while they could have used C1 ('too shallow') only save
less power than they otherwise could have. Too deep sleeps, on the other hand, harm performance
and nullify the potential power saving from using C1 in the first place. While taking this into
account, it is clear that on balance it is preferable for an idle governor to have more too shallow
sleeps instead of more too deep sleeps.

Currently the best available governor under this metric is TEO which on average results in less than
half the percentage of too deep sleeps compared to 'menu', getting much better wakeup latencies and
increased performance in the process.

This proposed optional extension to TEO would specifically tune it for minimising too deep
sleeps and minimising latency to achieve better performance. To this end, before selecting the next
idle state it uses the avg_util signal of a CPU's runqueue in order to determine to what extent the
CPU is being utilized. This util value is then compared to a threshold defined as a percentage of
the cpu's capacity (capacity >> 6 ie. ~1.5% in the current implementation). If the util is above the
threshold, the governor directly selects the shallowest available idle state. If the util is below
the threshold, the governor defaults to the TEO metrics mechanism to try to select the deepest
available idle state based on the closest timer event and its own past correctness.

Effectively this functions like a governor that on the fly disables deeper idle states when there
are things happening on the cpu and then immediately reenables them as soon as the cpu isn't
being utilized anymore.

Initially I am sending this as a patch for TEO to visualize the proposed mechanism and simplify
the review process. An alternative way of implementing it while not interfering
with existing TEO code would be to fork TEO into a separate but mostly identical for the time being
governor (working name 'idleutil') and then implement util-awareness there, so that the two
approaches can coexist and both be available at runtime instead of relying on a compile-time option.
I am happy to send a patchset doing that if you think it's a cleaner approach than doing it this way.

This approach can outperform all the other currently available governors, at least on mobile device
workloads, which is why I think it is worth keeping as an option.

Additionally, in my view, the reason why it makes more sense to implement this type of mechanism
inside a governor rather than outside using something like QoS or some other way to disable certain
idle states on the fly are the governor's metrics. If we were disabling idle states and reenabling
them without the governor 'knowing' about it, the governor's metrics would end up being updated
based on state selections not caused by the governor itself. This could interfere with the
correctness of said metrics as that's not what they were designed for as far as I understand.
This approach skips metrics updates whenever a state was selected based on the util and not based
on the metrics.

There is no particular attachment or reliance on TEO for this mechanism, I simply chose to base
it on TEO because it performs the best out of all the available options and I didn't think there was
any point in reinventing the wheel on the side of computing governor metrics. If a
better approach comes along at some point, there's no reason why the same idle aware mechanism
couldn't be used with any other metrics algorithm. That would, however, require implemeting it as
a separate governor rather than a TEO add-on.

As for how the extension performs in practice, below I'll add some benchmark results I got while
testing this patchset.

Pixel 6 (Android 12, mainline kernel 5.18):

1. Geekbench 5 (latency-sensitive, heavy load test)

The values below are gmean values across 3 back to back iteration of Geekbench 5.
As GB5 is a heavy benchmark, after more than 3 iterations intense throttling kicks in on mobile devices
resulting in skewed benchmark scores, which makes it difficult to collect reliable results. The actual
values for all of the governors can change between runs as the benchmark might be affected by factors
other than just latency. Nevertheless, on the runs I've seen, util-aware TEO frequently achieved better
scores than all the other governors.

'shallow' is a trivial governor that only ever selects the shallowest available state, included here
for reference and to establish the lower bound of latency possible to achieve through cpuidle.

'gmean too deep %' and 'gmean too shallow %' are percentages of too deep and too shallow sleeps
computed using the new trace event - cpu_idle_miss. The percentage is obtained by counting the two
types of misses over the course of a run and then dividing them by the total number of wakeups.

| metric                                | menu           | teo               | shallow           | teo + util-aware  |
| ------------------------------------- | -------------  | ---------------   | ---------------   | ---------------   |
| gmean score                           | 2716.4 (0.0%)  | 2795 (+2.89%)     | 2780.5 (+2.36%)   | 2830.8 (+4.21%)   |
| gmean too deep %                      | 16.64%         | 9.61%             | 0%                | 4.19%             |
| gmean too shallow %                   | 2.66%          | 5.54%             | 31.47%            | 15.3%             |
| gmean task wakeup latency (gb5)       | 82.05μs (0.0%) | 73.97μs (-9.85%)  | 42.05μs (-48.76%) | 66.91μs (-18.45%) |
| gmean task wakeup latency (asynctask) | 75.66μs (0.0%) | 56.58μs (-25.22%) | 65.78μs (-13.06%) | 55.35μs (-26.84%) |

In case of this benchmark, the difference in latency does seem to translate into better scores.

Additionally, here's a set of runs of Geekbench done after holding the phone in
the fridge for exactly an hour each time in order to minimise the impact of thermal issues.

| metric                                | menu           | teo               | teo + util-aware  |
| ------------------------------------- | -------------  | ---------------   | ---------------   |
| gmean multicore score                 | 2792.1 (0.0%)  | 2845.2 (+1.9%)    | 2857.4 (+2.34%)   |
| gmean single-core score               | 1048.3 (0.0%)  | 1052.6 (+0.41%)   | 1055.3 (+0.67%)   |

2. PCMark Web Browsing (non latency-sensitive, normal usage test)

The table below contains gmean values across 20 back to back iterations of PCMark 2 Web Browsing.

| metric                    | menu           | teo               | shallow          | teo + util-aware  |
| ------------------------- | -------------  | ---------------   | ---------------  | ---------------   |
| gmean score               | 6283.0 (0.0%)  | 6262.9 (-0.32%)   | 6258.4 (-0.39%)  | 6323.7 (+0.65%)   |
| gmean too deep %          | 24.15%         | 10.32%            | 0%               | 3.2%              |
| gmean too shallow %       | 2.81%          | 7.68%             | 27.69%           | 17.189%           |
| gmean power usage [mW]    | 209.1 (0.0%)   | 187.8 (-10.17%)   | 205.5 (-1.71%)   | 205 (-1.96%)      |
| gmean task wakeup latency | 204.6μs (0.0%) | 184.39μs (-9.87%) | 95.55μs (-53.3%) | 95.98μs (-53.09%) |

As this is a web browsing benchmark, the task for which the wakeup latency was recorded was Chrome's
rendering task, ie CrRendererMain. The latency improvement for the actual benchmark task was very
similar.

In this case the large latency improvement does not translate into a notable increase in benchmark score as
this particular benchmark mainly responds to changes in operating frequency. Nevertheless, the small power
saving compared to menu with no decrease in benchmark score indicate that there are no regressions for this
type of workload while using this governor.

Note: The results above were as mentioned obtained on the 5.18 kernel. Results for Geekbench obtained after
backporting CFS patches from the most recent mainline can be found in the pdf linked below [1].
The results and improvements still hold up but the numbers change slightly. Additionally, the pdf contains
plots for all the relevant results obtained with this and other idle governors.

At the very least this approach seems promising so I wanted to discuss it in RFC form first.
Thank you for taking your time to read this!

--
Kajetan

[1] https://github.com/mrkajetanp/lisa-notebooks/blob/a2361a5b647629bfbfc676b942c8e6498fb9bd03/idle_util_aware.pdf


Kajetan Puchalski (1):
  cpuidle: teo: Introduce optional util-awareness

 drivers/cpuidle/Kconfig         | 12 +++++
 drivers/cpuidle/governors/teo.c | 86 +++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)

-- 
2.37.1

