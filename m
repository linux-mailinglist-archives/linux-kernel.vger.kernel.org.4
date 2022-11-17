Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720A662E77D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241046AbiKQV7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241034AbiKQV62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:58:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D79B72137
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:57:37 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668722255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H9wRa3+GgKpIPdNjGF7czujjEWj4rhvBPlhM04JuIGc=;
        b=GPjEw4ohnKxxTXMP0QjYmPRAi1tg3AqjLKZhdQlipua+zmyga4zkcEZRpAFamqacqtrdM3
        Pg6wLCxaySUywhXyIeME7F0WxchY2oqxwFS1MD4kQru7guXvPd4FXx/ksbKT/7LgHEhCDS
        XBRJQa+MGdkCBConzPG2o6j1ED7jyOudF0LH3ztrTaADQtDwos9ajxqZBzFkvEhZS8jjIJ
        ceXilqFbxGxOUauIXLF5Pop5OrFQaGOTMgwNmluyG9TVltuRpVIzEf4HWUz2WvKZsIbDc7
        YtMK25WGFnUvsKpt//iI9gIJ91kdCGQFWJu42HwUBVHRdZ5JepSJbPE9v6zOfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668722255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H9wRa3+GgKpIPdNjGF7czujjEWj4rhvBPlhM04JuIGc=;
        b=uich/CXUIOK8gag1wFkTT2aKcnGbePGvFDrHwURV1DTLHev9M3wLvcmhLD3pWJDuWy5e82
        r4CttknM+Lxpv3BA==
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@meta.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Chris Mason <clm@meta.com>, John Stultz <jstultz@google.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH clocksource 1/3] clocksource: Reject bogus watchdog
 clocksource measurements
In-Reply-To: <20221114232827.835599-1-paulmck@kernel.org>
References: <20221114232807.GA834337@paulmck-ThinkPad-P17-Gen-1>
 <20221114232827.835599-1-paulmck@kernel.org>
Date:   Thu, 17 Nov 2022 22:57:34 +0100
Message-ID: <87mt8pkzw1.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul!

On Mon, Nov 14 2022 at 15:28, Paul E. McKenney wrote:
>  
> +		/* Check for bogus measurements. */
> +		wdi = jiffies_to_nsecs(WATCHDOG_INTERVAL);
> +		if (wd_nsec < (wdi >> 2)) {
> +			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced only %lld ns during %d-jiffy time interval, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
> +			continue;
> +		}
> +		if (wd_nsec > (wdi << 2)) {
> +			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced an excessive %lld ns during %d-jiffy time interval, probable CPU overutilization, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
> +			continue;
> +		}

This is really getting ridiculous.

The clocksource watchdog is supposed to run periodically with period =
WATCHDOG_INTERVAL.

That periodic schedule depends on the clocksource which is monitored. If
the clocksource runs fast the period is shortened and if it runs slow is
prolonged.

Now you add checks:

 1) If the period observed by the watchdog clocksource is less than 1/4
    of the expected period, everything is fine.

 2) If the period observed by the watchdog clocksource is greater than 4
    times the expected period, everything is fine.

IOW, you are preventing detection of one class of problems which caused
us to implement the watchdog clocksource in the first place.

You are preventing it by making the watchdog decision circular dependent
on the clocksource it is supposed to watch. IOW, you put a fox in charge
of the henhouse. That's a really brilliant plan.

But what's worse is the constant stream of heuristics which make the
clocksource watchdog "work" under workloads which are simply impossible
to be handled by its current implementation.

If I look at the full set of them by now, I'm pretty sure that a real
TSC fail would not be noticed anymore because there are more exceptions
and excuses why a particular measurement it bogus or invalid or
whatever.

I didn't do a full analysis yet, but I have a hard time to convince
myself that - assumed we add this gem - the watchdog will be anything
else than a useless waste of CPU cycles as there is always one of the
heuristics declaring that everything is fine along with incomprehensible
messages in dmesg which will create more confusion to most people than
being helpful.

This is hunting us for 20+ years now and why do we still need this? I'm
pretty sure that farcebook does not run their server farms on 20 years
old silicon.

That means even the largest customers have not been able to convince the
CPU manufactures to fix this idiocy by now, right? Either that or they
did not even try because it's simpler to "fix" it in software.

That's the only two explanations I have for the constant stream of
voodoo logic. Both are just a proof for my claim that this industry just
"works" by chance.

Can we stop this pretty please and either come up with something
fundamentally different or just admit defeat and remove the whole thing?

Thanks,

        tglx

