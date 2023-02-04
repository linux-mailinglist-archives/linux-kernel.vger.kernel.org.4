Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE06C68A78D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 02:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbjBDB1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 20:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjBDB1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 20:27:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D584C3B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 17:27:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FA3A6204D
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 01:27:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60FAAC433D2;
        Sat,  4 Feb 2023 01:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675474030;
        bh=hNCmysCgqu/TyZDoy3Kn7Tw6PoeZsCMjuBkqlxbX56w=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mx5q5VhpNO7xfGsWDdp9MDfK69OkJxgduiuJXpo/pmBUEQaYL86iX1HmtX31fx+97
         UEtFgUM6J/TqhCv6C2u+yM7Ll3AziWzEWm5qGgJm6D459/uFeubafniJo/sMyf+sX5
         VDr6cKVozK+SV/uiLHx6XSgjmXrnF8rdmzpgn5slCiZy7l2VtCk6TYlJ8ho0dVjEh1
         Duhz05aJlftPa1kavBZCDqM75cUIKXtGZqjKOC6M6YPZPGbb3t+Xa+dFafMIPdzK1+
         PZWurH+6PWl1BTePwhSr2JgvlPc3qrm1eTAAEQpBqsMiHELEd6fVil/4GHlQ6fzH0w
         GnoF6/Z4tfc5Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0FDCD5C18FC; Fri,  3 Feb 2023 17:27:10 -0800 (PST)
Date:   Fri, 3 Feb 2023 17:27:10 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org, sboyd@kernel.org, corbet@lwn.net,
        Mark.Rutland@arm.com, maz@kernel.org, kernel-team@meta.com,
        neeraju@codeaurora.org, ak@linux.intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org
Subject: Re: [PATCH v2 clocksource 6/7] clocksource: Verify HPET and PMTMR
 when TSC unverified
Message-ID: <20230204012710.GR2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230125002708.GA1471122@paulmck-ThinkPad-P17-Gen-1>
 <20230125002730.1471349-6-paulmck@kernel.org>
 <87wn51znsh.ffs@tglx>
 <15e8c929-845e-ef65-dc04-a51f071dd256@redhat.com>
 <20230201195517.GM2948950@paulmck-ThinkPad-P17-Gen-1>
 <39752908-cc10-d63f-d02e-381693060af8@redhat.com>
 <87h6w4zeh8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6w4zeh8.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 08:57:39AM +0100, Thomas Gleixner wrote:
> On Wed, Feb 01 2023 at 22:40, Waiman Long wrote:
> > On 2/1/23 14:55, Paul E. McKenney wrote:
> >>>>> Therefore, when watchdog verification of TSC is disabled, enable it for
> >>>>> HPET and PMTMR (AKA ACPI PM timer).  This provides the needed in-kernel
> >>>>> time-skew diagnostic without degrading the system's performance.
> >>>> I'm more than unhappy about this. We finally have a point where the TSC
> >>>> watchdog overhead can go away without adding TSC=reliable to the kernel
> >>>> commandline.
> >>>>
> >>>> Now you add an unconditionally enforce the watchdog again in a way which
> >>>> even cannot be disabled on the kernel command line.
> >>>>
> >>>> Patently bad idea, no cookies for you!
> >>> I have a similar concern about this patch as well. That is why I was
> >>> suggesting to have this enabled for a limited time after boot for sanity
> >>> checking purpose only.
> >> Fair enough!
> >>
> >> If the watchdog checking of HPET and/or PMTMR against TSC only happens
> >> only when the sysadm asks for it, would you still want to have the ability
> >> to enable such watchdog checking at boot time, and then to disable it
> >> once the system had been running for some limited time?
> >
> > Yes, being optional is another way to avoid the overhead for the 
> > majority of users. The paranoids can turn it on if they want to.
> 
> Yes, opt-in is good enough.

I have added this commit to my clocksource branch:

2ff7dacc88b0 clocksource: Enable TSC watchdog checking of HPET and PMTMR only when requested

It is passing my internal tests, and if it does fine for a couple of
days in -next, I will send an updated pull request.

							Thanx, Paul

------------------------------------------------------------------------

The full clocksource branch:

beaa1ffe551c3 clocksource: Print clocksource name when clocksource is tested unstable
c37e85c135cea clocksource: Loosen clocksource watchdog constraints
f092eb34b3304 clocksource: Improve read-back-delay message
dd029269947a3 clocksource: Improve "skew is too large" messages
b7082cdfc464b clocksource: Suspend the watchdog temporarily when high read latency detected
a7ec817d55421 x86/tsc: Add option to force frequency recalibration with HW timer
efc8b329c7fdc clocksource: Verify HPET and PMTMR when TSC unverified
2ff7dacc88b0c clocksource: Enable TSC watchdog checking of HPET and PMTMR only when requested
