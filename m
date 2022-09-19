Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5B05BC4DD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiISJAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiISJAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:00:09 -0400
X-Greylist: delayed 301 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 19 Sep 2022 02:00:04 PDT
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C482BC8E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 02:00:04 -0700 (PDT)
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <glk-linux-kernel-4@m.gmane-mx.org>)
        id 1oaCYO-0005pe-SN
        for linux-kernel@vger.kernel.org; Mon, 19 Sep 2022 10:55:00 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   timj <timj@gnu.org>
Subject: Re: [PATCH v4 4/8] sched/core: Add permission checks for setting the
 latency_nice value
Date:   Mon, 19 Sep 2022 10:52:28 +0200
Message-ID: <5c060322-b132-c9b6-1253-6657ad08a63d@gnu.org>
References: <20220916080305.29574-1-vincent.guittot@linaro.org>
 <20220916080305.29574-5-vincent.guittot@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc:     qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com
Content-Language: en-US
In-Reply-To: <20220916080305.29574-5-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

great to see work on improving low latency scenarios.

There is an entire class of low latency audio applications that seems
to be underrepresented in the current low latency use case descriptions.
Experiencing audio drop outs (clicks or gaps) is generally perceived
to be much more disruptive than graphics glitches like missing a frame
deadline. That's why audio programs and devices with huge buffers put
so much emphasis on avoiding drop outs however possible.

Now, video players and tools like mpg123 are well served with increased
audio buffer sizes to avoid drop outs. But the story is different with
MIDI synthesizers (hit a piano key and expect immediate onset -
especially drum synthesizers) or audio filters that implement realtime
auto-tuning or short delay effects. Here, useful applications require
IO latency guarantees significantly below 10ms. A useful setup would be
e.g. 48kHz sampling frequency and an audio buffer of two fragments with
128 samples each. Simplified, that provides a combined IO latency of
2 * 128 / 48000 = 5.33ms if the audio application can rely on scheduling
deadlines of 1 * 128 / 48000 = 2.6ms.

So far, low latency applications have to jump through a number of hoops
to roughly achieve such deadlines, ranging from requiring suid-
installations for SCHED_DEADLINE (rarely used in practice), needing 
CAP_SYS_NICE, requiring a Jackd distro or depending on RtKit with all 
its shortcomings [1].
I.e. there's a plethora of user space workarounds that have piled up
over the decades, because regular user applications lack a simple way
to tell the kernel one of:

+1) I'm interested in throughput and don't care about latency: make -j
  0) I'm fine with latency handling defaults: bash, X11
-1) I'm depending on low latency scheduling much more than throughput:
       audio-filter, synthesizer

The emphasis here is on *USER* applications, not programs run by root.
As you write in [PATCH v4 5/8]: "We don't want to provide more CPU
bandwidth to a thread but reorder the scheduling to run latency
sensitive task first whenever possible" and as outlined in the
presentation "Latency_nice - Implementation and Use-case for Scheduler
Optimization" by Shah et al [2], changing latency nice will not result
in taking over the CPU or extending the possibility for DoS attacks.

So what I'm getting at with this lengthy use case description is that
it is vitally important for low latency audio applications without
elevated privileges to be able to request low latency scheduling.
I.e. please remove the check for !capable(CAP_SYS_NICE) to request low
latency scheduling from the patch set, so audio applications can simply
use their time slices (and nothing more) at the *right* time and have a
way to tell the kernel about it without requiring root or daemons to
relay the message. Conversely, idle tasks or make -j also don't need
root to enjoy up to 100% of idle CPU time.

[1] https://github.com/heftig/rtkit/issues/25
[2] https://static.lwn.net/images/conf/2020/ospm/latency-nice-slides.pdf

On 16.09.22 10:03, Vincent Guittot wrote:
> From: Parth Shah <parth@linux.ibm.com>
> 
> Since the latency_nice uses the similar infrastructure as NICE, use the
> already existing CAP_SYS_NICE security checks for the latency_nice. This
> should return -EPERM for the non-root user when trying to set the task
> latency_nice value to any lower than the current value.
> 
> Signed-off-by: Parth Shah <parth@linux.ibm.com>
> [rebase]
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>   kernel/sched/core.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 2015e7d1f8b2..3c79c5419d1b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7444,6 +7444,10 @@ static int __sched_setscheduler(struct task_struct *p,
>   			return -EINVAL;
>   		if (attr->sched_latency_nice < MIN_LATENCY_NICE)
>   			return -EINVAL;
> +		/* Use the same security checks as NICE */
> +		if (attr->sched_latency_nice < p->latency_nice &&
> +		    !capable(CAP_SYS_NICE))
> +			return -EPERM;
>   	}
>   
>   	if (pi)


