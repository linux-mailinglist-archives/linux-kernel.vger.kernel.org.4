Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B057686F5E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 20:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjBATzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 14:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjBATzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 14:55:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4186A69
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 11:55:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76E4A6193E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 19:55:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4155C433EF;
        Wed,  1 Feb 2023 19:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675281317;
        bh=QxXci6Pv1JuFQB9GEySZcwQxg5O2A+bBlWC757f4rWM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kltuceZ0pOFPl6Y8bXVzGUppqG0OauVGRM8W1VJEIAiKDgAbyfcy1PeGo5Cbvh6W3
         pYRIzY+6+HOPvfdyCz+kNs3q2MunOKVXlhkVJMoRPY2EXrV+ci0gva/a9kn4DkTXVV
         ZXO5RNu7hnN1TyiWVTgEWMSWa5YewrC5q8Dp0J9zLnR2d2VatW4KQPDLVvzMbTqCG/
         rdi22D5aF/rS/OJTDefaZfb7JkWxB51MQk0wUabPGnJaBXsTapI4Nsyu/dZgsmubgI
         YUPWnnh7sOqlUUdYlnK2ShCLQj/yt/bF/bhQy4W1I98W0fLQ9uSbyC7xIV5VuEriV4
         ZFZwsG1w9ifmg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6F5975C06D0; Wed,  1 Feb 2023 11:55:17 -0800 (PST)
Date:   Wed, 1 Feb 2023 11:55:17 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
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
Message-ID: <20230201195517.GM2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230125002708.GA1471122@paulmck-ThinkPad-P17-Gen-1>
 <20230125002730.1471349-6-paulmck@kernel.org>
 <87wn51znsh.ffs@tglx>
 <15e8c929-845e-ef65-dc04-a51f071dd256@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15e8c929-845e-ef65-dc04-a51f071dd256@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 02:26:29PM -0500, Waiman Long wrote:
> On 2/1/23 05:24, Thomas Gleixner wrote:
> > Paul!
> > 
> > On Tue, Jan 24 2023 at 16:27, Paul E. McKenney wrote:
> > > On systems with two or fewer sockets, when the boot CPU has CONSTANT_TSC,
> > > NONSTOP_TSC, and TSC_ADJUST, clocksource watchdog verification of the
> > > TSC is disabled.  This works well much of the time, but there is the
> > > occasional production-level system that meets all of these criteria, but
> > > which still has a TSC that skews significantly from atomic-clock time.
> > > This is usually attributed to a firmware or hardware fault.  Yes, the
> > > various NTP daemons do express their opinions of userspace-to-atomic-clock
> > > time skew, but they put them in various places, depending on the daemon
> > > and distro in question.  It would therefore be good for the kernel to
> > > have some clue that there is a problem.
> > > 
> > > The old behavior of marking the TSC unstable is a non-starter because a
> > > great many workloads simply cannot tolerate the overheads and latencies
> > > of the various non-TSC clocksources.  In addition, NTP-corrected systems
> > > sometimes can tolerate significant kernel-space time skew as long as
> > > the userspace time sources are within epsilon of atomic-clock time.
> > > 
> > > Therefore, when watchdog verification of TSC is disabled, enable it for
> > > HPET and PMTMR (AKA ACPI PM timer).  This provides the needed in-kernel
> > > time-skew diagnostic without degrading the system's performance.
> > I'm more than unhappy about this. We finally have a point where the TSC
> > watchdog overhead can go away without adding TSC=reliable to the kernel
> > commandline.
> > 
> > Now you add an unconditionally enforce the watchdog again in a way which
> > even cannot be disabled on the kernel command line.
> > 
> > Patently bad idea, no cookies for you!
> 
> I have a similar concern about this patch as well. That is why I was
> suggesting to have this enabled for a limited time after boot for sanity
> checking purpose only.

Fair enough!

If the watchdog checking of HPET and/or PMTMR against TSC only happens
only when the sysadm asks for it, would you still want to have the ability
to enable such watchdog checking at boot time, and then to disable it
once the system had been running for some limited time?

							Thanx, Paul
