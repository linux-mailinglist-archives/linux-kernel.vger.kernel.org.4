Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFB168641F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 11:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjBAKYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 05:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjBAKYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 05:24:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0F61BCF
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 02:24:17 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675247054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/4UEm05XueA6pWxRcOXdrL8zvf0PnlSmgk3ga9kmqQo=;
        b=XGaaTNZX297PFBDpNlBbvxeA3oWNrVjQtOvVcsUbR5f92zbefFEWi4K7obdeR1+3ks/3It
        Sb+/vdX12lNonq0Kkn2KsIp30oHyOcZkZlSzwwhtqQYersK4ogqq3uSeoVp8diysTQlSK2
        7zWXUAX+Mk0hZy9XbCRDVM0ZhcI2Wd84OgHcDu8T9TltK4sH6debcUoII4TMfyNnsqODWW
        IjTvT9WJi9GLAyePnvKkTIIsArIObFFD7l3d9K1fBRASDsmLSbqMHfKWgILLmrCeMZNkJP
        re2905VRwmeLp4qi/TaBQPT4EabieYTRb4CjwI1nbC48Yb60Zu8BG8HSrK/WHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675247054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/4UEm05XueA6pWxRcOXdrL8zvf0PnlSmgk3ga9kmqQo=;
        b=8Yfbbnq5Bb/tyKddoJ3PTySivsUVbUn9B2YMePncC8YdRc7a4pNMBeioThwQqLt1HQlyty
        YQ7/4A1s43YRBhAg==
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@meta.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Waiman Long <longman@redhat.com>, x86@kernel.org
Subject: Re: [PATCH v2 clocksource 6/7] clocksource: Verify HPET and PMTMR
 when TSC unverified
In-Reply-To: <20230125002730.1471349-6-paulmck@kernel.org>
References: <20230125002708.GA1471122@paulmck-ThinkPad-P17-Gen-1>
 <20230125002730.1471349-6-paulmck@kernel.org>
Date:   Wed, 01 Feb 2023 11:24:14 +0100
Message-ID: <87wn51znsh.ffs@tglx>
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

On Tue, Jan 24 2023 at 16:27, Paul E. McKenney wrote:
> On systems with two or fewer sockets, when the boot CPU has CONSTANT_TSC,
> NONSTOP_TSC, and TSC_ADJUST, clocksource watchdog verification of the
> TSC is disabled.  This works well much of the time, but there is the
> occasional production-level system that meets all of these criteria, but
> which still has a TSC that skews significantly from atomic-clock time.
> This is usually attributed to a firmware or hardware fault.  Yes, the
> various NTP daemons do express their opinions of userspace-to-atomic-clock
> time skew, but they put them in various places, depending on the daemon
> and distro in question.  It would therefore be good for the kernel to
> have some clue that there is a problem.
>
> The old behavior of marking the TSC unstable is a non-starter because a
> great many workloads simply cannot tolerate the overheads and latencies
> of the various non-TSC clocksources.  In addition, NTP-corrected systems
> sometimes can tolerate significant kernel-space time skew as long as
> the userspace time sources are within epsilon of atomic-clock time.
>
> Therefore, when watchdog verification of TSC is disabled, enable it for
> HPET and PMTMR (AKA ACPI PM timer).  This provides the needed in-kernel
> time-skew diagnostic without degrading the system's performance.

I'm more than unhappy about this. We finally have a point where the TSC
watchdog overhead can go away without adding TSC=reliable to the kernel
commandline.

Now you add an unconditionally enforce the watchdog again in a way which
even cannot be disabled on the kernel command line.

Patently bad idea, no cookies for you!

Thanks,

        tglx
