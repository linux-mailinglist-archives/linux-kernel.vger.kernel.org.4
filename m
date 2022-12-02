Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5248763FDC9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 02:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbiLBBog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 20:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbiLBBod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 20:44:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38031D3A08
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 17:44:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD788B81FBE
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 01:44:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9650DC433D7;
        Fri,  2 Dec 2022 01:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669945468;
        bh=y0AQIJyZEpduIRQzPozvj89JC9kYy8+pdYH8NShL/DA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=DR1RzFaAZPIVoaQ7UgJlluI13vgL3IXK6lAAYEb3T99z2ocEtGs7dg+ycl0pLVAJ2
         v4fIFzjKZpJ9E/9932PA+gCRE+PvWtUQWelFd5YjUtiPu5JiIWk/M0NmJR5liZlZtc
         6gUXUzxNy1V+JTPQL6w0LURS0+RmVvk9lDi/Lz3LAP5DhJMFELFfSdCsRhvikYpykS
         yTKNTbbQOsH90bRO/3Y9Dstdga5uRlzKwdQd5FvVxRJ1IyaH4to1Ys4F4P/Vo3I9Mj
         glytruHeehobQUBeGRhvspeEJeuHJqeks0usLFLdqALmvURNee/VIEjbq+ictW/0fk
         9Hfj8ALOebujg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 18FF85C05F8; Thu,  1 Dec 2022 17:44:28 -0800 (PST)
Date:   Thu, 1 Dec 2022 17:44:28 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@meta.com, ak@linux.intel.com,
        zhengjun.xing@intel.com, Chris Mason <clm@meta.com>,
        John Stultz <jstultz@google.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH clocksource 1/3] clocksource: Reject bogus watchdog
 clocksource measurements
Message-ID: <20221202014428.GN4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221129192915.GD4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4az+FT5YjpAWjZc@feng-clx>
 <20221130041206.GK4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4bg1H/HLRLfucNO@feng-clx>
 <20221130051600.GL4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4brjD/xUDlzJ4v7@feng-clx>
 <20221130055024.GM4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4bxZCEAmPnALsRV@feng-clx>
 <20221201172405.GI4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4lQdKaKh2P7eLBG@feng-clx>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y4lQdKaKh2P7eLBG@feng-clx>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 09:10:12AM +0800, Feng Tang wrote:
> On Thu, Dec 01, 2022 at 09:24:05AM -0800, Paul E. McKenney wrote:
> > On Wed, Nov 30, 2022 at 02:00:04PM +0800, Feng Tang wrote:
> > > On Tue, Nov 29, 2022 at 09:50:24PM -0800, Paul E. McKenney wrote:
> > > [...]
> > > > >  
> > > > > Great! As both HPET and PM_TIMER get the same calibration 1975.000 MHz,
> > > > > and it matches the 40ms drift per second you mentioned earlier, this
> > > > > seems like the CPUID(0x15) gave the wrong frequence number.
> > > > > 
> > > > > Or unlikely, HPET and PM_TIMER are driven by the same circuit source,
> > > > > which has deviation.
> > > > > 
> > > > > Either way, I think the HW/FW could have some problem.
> > > > 
> > > > And this time with your printk()s:
> > > > 
> > > > [    0.000000] tsc: using CPUID[0x15] crystal_khz= 24000 kHz ebx=158 eax=2
> > > > [    0.000000] tsc: Detected 1900.000 MHz processor
> > > > [    0.000000] tsc: Detected 1896.000 MHz TSC
> > > > [    5.268858] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
> > > > [   25.706231] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x36a8d32ce31, max_idle_ns: 881590731004 ns
> > > > [   32.223011] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
> > > > [   57.823933] clocksource: Switched to clocksource tsc-early
> > > > [   58.144840] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> > > > [   63.613713] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x36a8d32ce31, max_idle_ns: 881590731004 ns
> > > > [   63.637323] clocksource: Switched to clocksource tsc
> > > > [   64.673579] tsc: Warning: TSC freq calibrated by CPUID/MSR differs from what is calibrated by HW timer, please check with vendor!!
> > > > [   64.703719] tsc: Previous calibrated TSC freq:        1896.000 MHz
> > > > [   64.716816] tsc: TSC freq recalibrated by [PM_TIMER]:         1974.999 MHz
> > > 
> > > This confirms the tsc frequency is calculated from CPUID(0x15).
> > > 
> > > > What would be good next steps to check up on the hardware and firmware?
> > > 
> > > Maybe raise it to vendor? I have no idea how to check thos black boxes :)
> > 
> > Done, but no high hopes here.  (What, me cynical?  Better believe it!!!)
> > 
> > > > (My next step involves a pillow, but will follow up tomorrow morning
> > > > Pacific Time.)
> > >  
> > > Really thanks for checking this through late night!
> > 
> > No problem, and I guess it is instead the day after tomorrow, but
> > I thought you might be interested in chronyd's opinion:
> > 
> > [root@rtptest1029.snc8 ~]# cat /var/lib/chrony/drift
> >         40001.074911             0.002098
> > 
> > In contrast, on my Fedora laptop:
> > 
> > $ sudo cat /var/lib/chrony/drift
> >             2.074313             0.186606
> > 
> > I am (perhaps incorrectly) taking this to indicate that TSC is in fact
> > drifting with respect to standard time.
>  
> This info is very useful! It further confirms the CPUID(0x15) gave
> the wrong frequency info. 

So the TSC is just doing what it is told.  ;-)

This indicates a firmware problem?

> Also I don't think TSC itself is drifting, and the drift some from
> the wrong match calculation(1896 MHz), if we give it the correct
> number (likely 1975 MHz here), there shouldn't be big chrony drift
> like your Fedora laptop.

Resetting so that the clocksource watchdog once again gets rid of TSC,
but leaving nohpet:

[    0.000000] tsc: using CPUID[0x15] crystal_khz= 24000 kHz ebx=158 eax=2
[    0.000000] tsc: Detected 1900.000 MHz processor
[    0.000000] tsc: Detected 1896.000 MHz TSC
[    5.287750] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[   17.963947] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x36a8d32ce31, max_idle_ns: 881590731004 ns
[   19.996287] clocksource: timekeeping watchdog on CPU3: Marking clocksource 'tsc-early' as unstable because the skew is too large:
[   20.040287] clocksource:                       'refined-jiffies' wd_nsec: 503923392 wd_now: fffb73f8 wd_last: fffb7200 mask: ffffffff
[   20.067286] clocksource:                       'tsc-early' cs_nsec: 588021368 cs_now: 581c1eb378 cs_last: 57d9aad9e8 mask: ffffffffffffffff
 [   20.096286] clocksource:                       No current clocksource.
 [   20.111286] tsc: Marking TSC unstable due to clocksource watchdog
 [   24.582541] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
 [   49.739301] clocksource: Switched to clocksource refined-jiffies
 [   50.046356] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
 [   50.066475] clocksource: Switched to clocksource acpi_pm

# cat /var/lib/chrony/drift 
            1.372570             0.020049

I interpret this to mean that acpi_pm (and thus from prior observations,
HPET as well) are counting at the correct rate.

							Thanx, Paul
