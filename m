Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6760C6C89B9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 01:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjCYArj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 20:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCYArh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 20:47:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B9FC17C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 17:47:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F01C8B826AA
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 00:47:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945F4C433EF;
        Sat, 25 Mar 2023 00:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679705253;
        bh=32m0h5HreH9HP53eNp/CC/r0tIXZbo4QjcqJUxvANw8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WokIKGTnf1AmMrskPjm3U6/roQA0Nfjfls3TR69XlJxwYaa0hxdm5zyju3TwMm+iV
         KZCxq8jm+vcJMoT9TaFP1l5aPGbmXpvu4fI7UdyW2mGrKNCHmquhiVjaWjsTTCVFcQ
         KAoRsnmZD/qNHOJ0x0XsXuL/NZjcFiJJktRxGLfivgoSsqxjmU1zRzIy/a572GDiRV
         YD7dAjHQVu1ECdN0l77hU5k/X33fjogiqo/ksTftA10/M+tzDbn4HgdkirdVav9VCz
         NANEoobgcAX13Q8tym0RO2OWUBgdvMo/UbibFobPuTiuMD2Ymh/rTjtZyl9+uP6pwC
         Lu9cSXFwc0N+w==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 282A51540432; Fri, 24 Mar 2023 17:47:33 -0700 (PDT)
Date:   Fri, 24 Mar 2023 17:47:33 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: A couple of TSC questions
Message-ID: <acda3fb5-373a-48b1-b78e-eea18da4ccb0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <b2f07f18-b60b-403b-90ff-937ea32963ee@paulmck-laptop>
 <ZBqOyLByOgvdAve3@feng-clx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBqOyLByOgvdAve3@feng-clx>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 01:14:48PM +0800, Feng Tang wrote:
> Hi, Paul
> 
> On Tue, Mar 21, 2023 at 04:23:28PM -0700, Paul E. McKenney wrote:
> > Hello, Feng!
> > 
> > I hope that things are going well for you and yours!
> 
> Thanks!
> 
> > First, given that the kernel can now kick out HPET instea of TSC in
> > response to clock skew, does it make sense to permit recalibration of
> > the still used TSC against the marked-unstable HPET?
> 
> Yes, it makes sense to me. I don't know the detail of the case, if
> the TSC frequency comes from CPUID info, a recalibration against a
> third party HW timer like ACPI_PM should help here. 
> 
> A further thought is if there are really quite some case that the
> CPUID-provided TSC frequency info is not accurate, then we may need
> to enable the recalibration by default, and give a warning message
> when detecting any mismatch. 

Now that you mention it, it is quite hard to choose correctly within
the kernel.  To do it right seems to require that NTP information be
pushed into the kernel.

> > Second, we are very occasionally running into console messages like this:
> > 
> > Measured 2 cycles TSC warp between CPUs, turning off TSC clock.
> > 
> > This comes from check_tsc_sync_source() and indicates that one CPU's
> > TSC read produced a later time than a later read from some other CPU.
> > I am beginning to suspect that these can be caused by unscheduled delays
> > in the TSC synchronization code, but figured I should ask you if you have
> > ever seen these.  And of course, if so, what the usual causes might be.
> 
> I haven't seen this error myself or got similar reports. Usually it
> should be easy to detect once happened, as falling back to HPET
> will trigger obvious performance degradation.

And that is exactly what happened.  ;-)

> Could you give more detail about when and how it happens, and the
> HW info like how many sockets the platform has. 

We are in early days, so I am checking for other experiences.

> CC Thomas, Waiman, as they discussed simliar case here:
> https://lore.kernel.org/lkml/87h76ew3sb.ffs@tglx/T/#md4d0a88fb708391654e78312ffa75b481690699f

Fun!  ;-)

							Thanx, Paul
