Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E2F64108C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 23:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbiLBWYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 17:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234571AbiLBWYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 17:24:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799D0EBCA5
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 14:24:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01DE8623C5
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 22:24:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB44C433D6;
        Fri,  2 Dec 2022 22:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670019843;
        bh=6vBEnTUlLi54SVdyAB1C2xUb5cuk6um7Bso76J6z5N4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Ry7osoGZcgWHihFYfGOrTC9BQUoZ/OTTq0L6VSZNJBPyBmVa4UdYLxpIdb6GalshX
         /6Ud4yRYH5Fn0AjP40CE4xrBH0J3+hn1iIqp3t2ki7zlpTlFFobP/ujB4O/btY7N4+
         O00E1mHcewfLh+dMTMXueWllw7lvwMLkY1Et/a4ml7rFQdHXTJUiBenhVWuorynJmD
         cx9woVMgF952WMVmFaBLAu4Fuv3jSSNNKlJNSYTqV1pCON/X8XDX8g9XYp8TcYeVEB
         nSqjCYtNvU9uZG9D2hO6SeRow7bNHYvOnItrb8Qs1Xy4uxp0mrHcSILbd374vY1ziH
         0PTdKeP1Ar5aw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F36915C095D; Fri,  2 Dec 2022 14:24:02 -0800 (PST)
Date:   Fri, 2 Dec 2022 14:24:02 -0800
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
Message-ID: <20221202222402.GI4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221130041206.GK4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4bg1H/HLRLfucNO@feng-clx>
 <20221130051600.GL4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4brjD/xUDlzJ4v7@feng-clx>
 <20221130055024.GM4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4bxZCEAmPnALsRV@feng-clx>
 <20221201172405.GI4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4lQdKaKh2P7eLBG@feng-clx>
 <20221202014428.GN4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4lc04C6KqYUG5lf@feng-clx>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y4lc04C6KqYUG5lf@feng-clx>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 10:02:59AM +0800, Feng Tang wrote:
> On Thu, Dec 01, 2022 at 05:44:28PM -0800, Paul E. McKenney wrote:
> > On Fri, Dec 02, 2022 at 09:10:12AM +0800, Feng Tang wrote:
> > > On Thu, Dec 01, 2022 at 09:24:05AM -0800, Paul E. McKenney wrote:
> > > > On Wed, Nov 30, 2022 at 02:00:04PM +0800, Feng Tang wrote:
> > > > > On Tue, Nov 29, 2022 at 09:50:24PM -0800, Paul E. McKenney wrote:
> > > > > [...]
> > > > > > >  
> > > > > > > Great! As both HPET and PM_TIMER get the same calibration 1975.000 MHz,
> > > > > > > and it matches the 40ms drift per second you mentioned earlier, this
> > > > > > > seems like the CPUID(0x15) gave the wrong frequence number.
> > > > > > > 
> > > > > > > Or unlikely, HPET and PM_TIMER are driven by the same circuit source,
> > > > > > > which has deviation.
> > > > > > > 
> > > > > > > Either way, I think the HW/FW could have some problem.
> > > > > > 
> > > > > > And this time with your printk()s:
> > > > > > 
> > > > > > [    0.000000] tsc: using CPUID[0x15] crystal_khz= 24000 kHz ebx=158 eax=2
> > > > > > [    0.000000] tsc: Detected 1900.000 MHz processor
> > > > > > [    0.000000] tsc: Detected 1896.000 MHz TSC
> > > > > > [    5.268858] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
> > > > > > [   25.706231] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x36a8d32ce31, max_idle_ns: 881590731004 ns
> > > > > > [   32.223011] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
> > > > > > [   57.823933] clocksource: Switched to clocksource tsc-early
> > > > > > [   58.144840] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> > > > > > [   63.613713] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x36a8d32ce31, max_idle_ns: 881590731004 ns
> > > > > > [   63.637323] clocksource: Switched to clocksource tsc
> > > > > > [   64.673579] tsc: Warning: TSC freq calibrated by CPUID/MSR differs from what is calibrated by HW timer, please check with vendor!!
> > > > > > [   64.703719] tsc: Previous calibrated TSC freq:        1896.000 MHz
> > > > > > [   64.716816] tsc: TSC freq recalibrated by [PM_TIMER]:         1974.999 MHz
> > > > > 
> > > > > This confirms the tsc frequency is calculated from CPUID(0x15).
> > > > > 
> > > > > > What would be good next steps to check up on the hardware and firmware?
> > > > > 
> > > > > Maybe raise it to vendor? I have no idea how to check thos black boxes :)
> > > > 
> > > > Done, but no high hopes here.  (What, me cynical?  Better believe it!!!)
> > > > 
> > > > > > (My next step involves a pillow, but will follow up tomorrow morning
> > > > > > Pacific Time.)
> > > > >  
> > > > > Really thanks for checking this through late night!
> > > > 
> > > > No problem, and I guess it is instead the day after tomorrow, but
> > > > I thought you might be interested in chronyd's opinion:
> > > > 
> > > > [root@rtptest1029.snc8 ~]# cat /var/lib/chrony/drift
> > > >         40001.074911             0.002098
> > > > 
> > > > In contrast, on my Fedora laptop:
> > > > 
> > > > $ sudo cat /var/lib/chrony/drift
> > > >             2.074313             0.186606
> > > > 
> > > > I am (perhaps incorrectly) taking this to indicate that TSC is in fact
> > > > drifting with respect to standard time.
> > >  
> > > This info is very useful! It further confirms the CPUID(0x15) gave
> > > the wrong frequency info. 
> > 
> > So the TSC is just doing what it is told.  ;-)
> > 
> > This indicates a firmware problem?
> > 
> > > Also I don't think TSC itself is drifting, and the drift some from
> > > the wrong match calculation(1896 MHz), if we give it the correct
> > > number (likely 1975 MHz here), there shouldn't be big chrony drift
> > > like your Fedora laptop.
> > 
> > Resetting so that the clocksource watchdog once again gets rid of TSC,
> > but leaving nohpet:
> > 
> > [    0.000000] tsc: using CPUID[0x15] crystal_khz= 24000 kHz ebx=158 eax=2
> > [    0.000000] tsc: Detected 1900.000 MHz processor
> > [    0.000000] tsc: Detected 1896.000 MHz TSC
> > [    5.287750] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
> > [   17.963947] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x36a8d32ce31, max_idle_ns: 881590731004 ns
> > [   19.996287] clocksource: timekeeping watchdog on CPU3: Marking clocksource 'tsc-early' as unstable because the skew is too large:
> > [   20.040287] clocksource:                       'refined-jiffies' wd_nsec: 503923392 wd_now: fffb73f8 wd_last: fffb7200 mask: ffffffff
> > [   20.067286] clocksource:                       'tsc-early' cs_nsec: 588021368 cs_now: 581c1eb378 cs_last: 57d9aad9e8 mask: ffffffffffffffff
> >  [   20.096286] clocksource:                       No current clocksource.
> >  [   20.111286] tsc: Marking TSC unstable due to clocksource watchdog
> >  [   24.582541] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
> >  [   49.739301] clocksource: Switched to clocksource refined-jiffies
> >  [   50.046356] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> >  [   50.066475] clocksource: Switched to clocksource acpi_pm
> > 
> > # cat /var/lib/chrony/drift 
> >             1.372570             0.020049
> > 
> > I interpret this to mean that acpi_pm (and thus from prior observations,
> > HPET as well) are counting at the correct rate.
> 
> Correct. And this is a good news! that 1975 MHz seems to be the right
> number.
> 
> Could you try below patch, it should override the CPUID calculation
> and forced to use HW timer calibrated number:
> 
> ---
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index a78e73da4a74..68a2fea4961d 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -1417,7 +1417,8 @@ static int __init init_tsc_clocksource(void)
>  	 * When TSC frequency is known (retrieved via MSR or CPUID), we skip
>  	 * the refined calibration and directly register it as a clocksource.
>  	 */
> -	if (boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ)) {
> +//	if (boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ)) {
> +	if (false) {
>  		if (boot_cpu_has(X86_FEATURE_ART))
>  			art_related_clocksource = &clocksource_tsc;
>  		clocksource_register_khz(&clocksource_tsc, tsc_khz);
> ---
> 
> And together with b50db7095fe0 "x86/tsc: Disable clocksource watchdog
> for TSC on qualified platorms". I assume this will tell TSC to use
> 1975 MHZ as its frequency.

This did not change things, but when I hardcoded tsc_khz to 1975, the
clocksource watchdog no longer disables TSC and chrony shows drifts of
less than 2.0.  (As opposed to about 40,000 without the hardcoding.)

So yes, forcing 1975 makes TSC work nicely.  Yay!  ;-)

							Thanx, Paul
