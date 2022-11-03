Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D4A6189E1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 21:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiKCUrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 16:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiKCUrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 16:47:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E632099A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 13:47:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50D7761FEF
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 20:47:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0C2C433D6;
        Thu,  3 Nov 2022 20:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667508461;
        bh=oqB9T2bu1tM/srukG0Yi/N8D4Z0pS3imx2as+1NNehY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Ww4fEFfpAhBTyrYGbNJipbnAVNrWmEyw5LGHkqVF/hbZGJtCx4V2wac6lXFMlk1zI
         UCzMMLzbVUQq3bFjHOfr8+NT/LQ1jJv28Yk33Lm4zP96umAjoAn1OZzR3MQxNBIY3I
         U/sdQ4OQoZbQDPVV6FFNrQr45nYv+zYdNyZjLmLfZCclElVfHljxVQ9g3ck1hCCN8d
         bSGrjikr+F69GN8SvXSIKUtNGUaNupYRGAXtTYG5ZwQyTxECoTWtUufm6+82a6BKpk
         xKDgqAyCycgprFzvMbfe+7M+bIIngc5Ygwo9clgwHDW++F/NNwgcyCpta7EJQdql9U
         qSxtklgOIfYcQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5B9155C097E; Thu,  3 Nov 2022 13:47:41 -0700 (PDT)
Date:   Thu, 3 Nov 2022 13:47:41 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org, sboyd@kernel.org, corbet@lwn.net,
        Mark.Rutland@arm.com, maz@kernel.org, kernel-team@meta.com,
        neeraju@codeaurora.org, ak@linux.intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com, John Stultz <jstultz@google.com>
Subject: Re: [PATCH clocksource 1/2] clocksource: Add comments to classify
 bogus measurements
Message-ID: <20221103204741.GE5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221102184001.GA1306489@paulmck-ThinkPad-P17-Gen-1>
 <20221102184009.1306751-1-paulmck@kernel.org>
 <7339298b-1156-2d24-7dd9-e7fae690773c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7339298b-1156-2d24-7dd9-e7fae690773c@redhat.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 10:23:25PM -0400, Waiman Long wrote:
> On 11/2/22 14:40, Paul E. McKenney wrote:
> > An extremely busy system can delay the clocksource watchdog, so that
> > the corresponding too-long bogus-measurement error does not necessarily
> > imply an error in the system.  However, a too-short bogus-measurement
> > error likely indicates a bug in hardware, firmware or software.
> > 
> > Therefore, add comments clarifying these bogus-measurement pr_warn()s.
> > 
> > Reported-by: Feng Tang <feng.tang@intel.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: John Stultz <jstultz@google.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: Feng Tang <feng.tang@intel.com>
> > Cc: Waiman Long <longman@redhat.com>
> > ---
> >   kernel/time/clocksource.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> > index dcaf38c062161..3f5317faf891f 100644
> > --- a/kernel/time/clocksource.c
> > +++ b/kernel/time/clocksource.c
> > @@ -443,10 +443,12 @@ static void clocksource_watchdog(struct timer_list *unused)
> >   		/* Check for bogus measurements. */
> >   		wdi = jiffies_to_nsecs(WATCHDOG_INTERVAL);
> >   		if (wd_nsec < (wdi >> 2)) {
> > +			/* This usually indicates broken timer code or hardware. */
> >   			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced only %lld ns during %d-jiffy time interval, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
> >   			continue;
> >   		}
> >   		if (wd_nsec > (wdi << 2)) {
> > +			/* This can happen on busy systems, which can delay the watchdog. */
> >   			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced an excessive %lld ns during %d-jiffy time interval, probable CPU overutilization, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
> >   			continue;
> >   		}
> 
> Looks good.
> 
> Reviewed-by: Waiman Long <longman@redhat.com>

Applied, thank you!

							Thanx, Paul
