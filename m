Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7616F60115F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiJQOpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiJQOpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:45:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B8FA21E3A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 07:45:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A4ED113E;
        Mon, 17 Oct 2022 07:45:06 -0700 (PDT)
Received: from wubuntu (unknown [10.57.37.31])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53C5E3F792;
        Mon, 17 Oct 2022 07:44:57 -0700 (PDT)
Date:   Mon, 17 Oct 2022 15:44:55 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        John Dias <joaodias@google.com>,
        Connor O'Brien <connoro@google.com>,
        Rick Yiu <rickyiu@google.com>, John Kacur <jkacur@redhat.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>,
        "J . Avila" <elavila@google.com>
Subject: Re: [RFC PATCH v4 3/3] softirq: defer softirq processing to
 ksoftirqd if CPU is busy with RT
Message-ID: <20221017144455.ylmwlgrdoj3tdvbp@wubuntu>
References: <20221003232033.3404802-1-jstultz@google.com>
 <20221003232033.3404802-4-jstultz@google.com>
 <20221010160917.p2ftu3eezsrbfdfk@wubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221010160917.p2ftu3eezsrbfdfk@wubuntu>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/22 17:09, Qais Yousef wrote:
> Hi John
> 
> On 10/03/22 23:20, John Stultz wrote:
> > From: Pavankumar Kondeti <pkondeti@codeaurora.org>
> > 
> > Defer the softirq processing to ksoftirqd if a RT task is
> > running or queued on the current CPU. This complements the RT
> > task placement algorithm which tries to find a CPU that is not
> > currently busy with softirqs.
> > 
> > Currently NET_TX, NET_RX, BLOCK and IRQ_POLL softirqs are only
> > deferred as they can potentially run for long time.
> > 
> > Additionally, this patch stubs out ksoftirqd_running() logic,
> > in the CONFIG_RT_SOFTIRQ_OPTIMIZATION case, as deferring
> > potentially long-running softirqs will cause the logic to not
> > process shorter-running softirqs immediately. By stubbing it out
> > the potentially long running softirqs are deferred, but the
> > shorter running ones can still run immediately.
> 
> The cover letter didn't make it to my inbox (nor to others AFAICS from lore),
> so replying here.
> 
> The series looks good to me. It offers a compromise to avoid an existing
> conflict between RT and softirqs without disrupting much how both inherently
> work. I guess it's up to the maintainers to decide if this direction is
> acceptable or not.
> 
> I've seen Thomas had a comment on another softirq series (which attempts to
> throttle them ;-) by the way that is worth looking it:
> 
> 	https://lore.kernel.org/lkml/877d81jc13.ffs@tglx/
> 
> 
> Meanwhile, I did run a few tests on a test laptop that has 2 core SMT2 i7
> laptop (since I assume you tested on Android)
> 
> I set priority to 1 for all of these cyclic tests.
> 
> First I ran without applying your patch to fix the affinity problem in
> cyclictest:
> 
> I had a 1 hour run of 4 threads - 4 iperf threads and 4 dd threads are
> doing work in the background:
> 
>                    |     vanilla     | with softirq patches v4 |
> -------------------|-----------------|-------------------------|
> t0 max delay (us)  |      6728       |         2096            |
> t1 max delay (us)  |      2545       |         1990            |
> t2 max delay (us)  |      2282       |         2094            |
> t3 max delay (us)  |      6038       |         2162            |
> 
> Which shows max latency is improved a lot. Though because I missed applying
> your cyclictest patch, I believe this can be attributed only to patch 3 which
> defers the softirq if there's current task is an RT one.
> 
> 
> I applied your patch to cyclictest to NOT force affinity when specifying -t
> option.
> 
> 
> 
> Ran cyclictest for 4 hours, -t 3, 3 iperf threads and 3 dd threads running in
> the background:
> 
>                    |     vanilla     | with softirq patches v4 |
> -------------------|-----------------|-------------------------|
> t0 max delay (us)  |      2656       |         2164            |
> t1 max delay (us)  |      2773       |         1982            |
> t2 max delay (us)  |      2272       |         2278            |
> 
> I didn't hit a big max delay on this case. It shows things are better still.
> 
> 
> 
> Ran another cyclictest for 4 hours, -t 4, 4 iperf threads and 4 dd threads in
> the background:
> 
>                    |     vanilla     | with softirq patches v4 |
> -------------------|-----------------|-------------------------|
> t0 max delay (us)  |      4012       |         7074            |
> t1 max delay (us)  |      2460       |         9088            |
> t2 max delay (us)  |      3755       |         2784            |
> t3 max delay (us)  |      4392       |         2295            |
> 
> Here the results worryingly show that applying the patches make things much
> worse.
> 
> I still have to investigate why. I'll have another run to see if the results
> look different, then try to dig more.
> 
> All results are from the cyclictest json dump.

Actually scrap those results. I stupidly forgot to enable the
CONFIG_RT_SOFTIRQ_OPTIMIZATION..


I repeated the 4hours, 4-threads test 3 times:

                   |       vanilla      | with softirq patches v4  |
-------------------|--------------------|--------------------------|
                   |  #1  |  #2  |  #3  |   #1   |   #2   |   #3   |
-------------------|------|------|------|--------|--------|--------|
t0 max delay (us)  | 9594*| 2246 | 2317 |  2763  |  2274  |  2623  |
t1 max delay (us)  | 3236 | 2356 | 2816 |  2675  |  2962  |  2944  |
t2 max delay (us)  | 2271 | 2622 | 2829 |  2274  |  2848  |  2400  |
t3 max delay (us)  | 2216 | 6587*| 2724 |  2631  |  2753  |  3034  |

Worst case scenario is reduced to 3034us instead of 9594us.

I repeated the 1 hour 3 threads tests again too:

                   |       vanilla      | with softirq patches v4  |
-------------------|--------------------|--------------------------|
                   |  #1  |  #2  |  #3  |   #1   |   #2   |   #3   |
-------------------|_-----|------|------|--------|--------|--------|
t0 max delay (us)  |18059 | 2251 | 2365 |  2684  |  2779  |  2838  |
t1 max delay (us)  |16311 | 2261 | 2477 |  2963  |  3020  |  3226  |
t2 max delay (us)  | 8887 | 2259 | 2432 |  2904  |  2833  |  3016  |

Worst case scenario is 3226us for softirq compared to 18059 for vanilla 6.0.

This time I paid attention to the average as the best case number for vanilla
kernel is better:

                   |       vanilla      | with softirq patches v4  |
-------------------|--------------------|--------------------------|
                   |  #1  |  #2  |  #3  |   #1   |   #2   |   #3   |
-------------------|------|------|------|--------|--------|--------|
t0 avg delay (us)  |31.59 |22.94 |26.50 | 31.81  | 33.57  | 34.90  |
t1 avg delay (us)  |16.85 |16.32 |37.16 | 29.05  | 30.51  | 31.65  |
t2 avg delay (us)  |25.34 |32.12 |17.40 | 26.76  | 28.28  | 28.56  |

It shows that we largely hover around 30us with the patches compared to 16-26us
being more prevalent for vanilla kernels.

I am not sure I can draw a concrete conclusion from these numbers. It seems
I need to run longer than 4 hours to hit the worst case scenario every run on
the vanilla kernel. There's an indication that the worst case scenario is
harder to hit, and it looks there's a hit on the average delay.

I'm losing access to this system from today. I think I'll wait for more
feedback on this RFC; and do another round of testing for longer periods of
time once there's clearer sense this is indeed the direction we'll be going
for.

HTH.


Cheers

--
Qais Yousef
