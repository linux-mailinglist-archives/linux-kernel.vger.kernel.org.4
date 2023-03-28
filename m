Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8884A6CCC77
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 23:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjC1V66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 17:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjC1V64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 17:58:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8729D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 14:58:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49CC761994
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 21:58:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87ED5C433EF;
        Tue, 28 Mar 2023 21:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680040734;
        bh=2RAWzcSgBiGvV8L32ZW2VloVewbCgl9iwe3g5D5AF4E=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ER8XzVh1SlWdDRdAFcJpSx3FC67zKWB7mhfg7Fh3lbcXixQJgjygF7fGRooT0GVIe
         jPZKD3FrbVpitW3Ns7yCHJYSEeNLTNqB9sDZDzSZQf1l6353SiteKwpZHzFx26irVm
         Hcprx5cTxhtJ65gvQ3AANmg4Mlic9nb70wVCqBw2JJjpipR95j/KzizXx+JjuFAbQv
         7ka48dsjMc1JFX3krl2qPht/EH5GBXt6giWfe6qNZvh16xXUX4jdaNnU7wWgdjSEa5
         zWXsSqN3ey5E9jzpqmC53xDMMDCaaZ+3ql6q8hlOk5jaqc6QnvjGDGXUdI0+QPn+R4
         mZ5Z1pAWFVSiQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1D9DE154047E; Tue, 28 Mar 2023 14:58:54 -0700 (PDT)
Date:   Tue, 28 Mar 2023 14:58:54 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: A couple of TSC questions
Message-ID: <aaf391d9-98e6-47d8-b402-c90b4a81ae9c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <b2f07f18-b60b-403b-90ff-937ea32963ee@paulmck-laptop>
 <ZBqOyLByOgvdAve3@feng-clx>
 <acda3fb5-373a-48b1-b78e-eea18da4ccb0@paulmck-laptop>
 <ZCD9SnZSUCkE9Ss+@feng-clx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCD9SnZSUCkE9Ss+@feng-clx>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 10:19:54AM +0800, Feng Tang wrote:
> On Fri, Mar 24, 2023 at 05:47:33PM -0700, Paul E. McKenney wrote:
> > On Wed, Mar 22, 2023 at 01:14:48PM +0800, Feng Tang wrote:
> > > Hi, Paul
> > > 
> > > On Tue, Mar 21, 2023 at 04:23:28PM -0700, Paul E. McKenney wrote:
> > > > Hello, Feng!
> > > > 
> > > > I hope that things are going well for you and yours!
> > > 
> > > Thanks!
> > > 
> > > > First, given that the kernel can now kick out HPET instea of TSC in
> > > > response to clock skew, does it make sense to permit recalibration of
> > > > the still used TSC against the marked-unstable HPET?
> > > 
> > > Yes, it makes sense to me. I don't know the detail of the case, if
> > > the TSC frequency comes from CPUID info, a recalibration against a
> > > third party HW timer like ACPI_PM should help here. 
> > > 
> > > A further thought is if there are really quite some case that the
> > > CPUID-provided TSC frequency info is not accurate, then we may need
> > > to enable the recalibration by default, and give a warning message
> > > when detecting any mismatch. 
> > 
> > Now that you mention it, it is quite hard to choose correctly within
> > the kernel.  To do it right seems to require that NTP information be
> > pushed into the kernel.
> 
> Yes, we need a 'always-right' reference, but the system have to has
> network access.
> 
> I know there have been many different problems related to TSC, but
> the real HW/FW related problems are only about the accuracy of
> TSC frequency's calibration/calculation.
> 
> Before commit b50db7095fe0 ("x86/tsc: Disable clocksource watchdog
> for TSC on qualified platorms"), if the TSC freq is calculated
> from CPUID or MSR, the HPET/ACPI_PM_TIMER can detect the possible
> calculation problem during clocksource watchdog check. For this
> case, we may need to force the recalibration by HPET/ACPI_PM_TIMER.

Agreed, one possible assumption is that TSC, HPET, and ACPI_PM_TIMER
are very unlikely to be in error in exactly the same way.

> > > > Second, we are very occasionally running into console messages like this:
> > > > 
> > > > Measured 2 cycles TSC warp between CPUs, turning off TSC clock.
> > > > 
> > > > This comes from check_tsc_sync_source() and indicates that one CPU's
> > > > TSC read produced a later time than a later read from some other CPU.
> > > > I am beginning to suspect that these can be caused by unscheduled delays
> > > > in the TSC synchronization code, but figured I should ask you if you have
> > > > ever seen these.  And of course, if so, what the usual causes might be.
> > > 
> > > I haven't seen this error myself or got similar reports. Usually it
> > > should be easy to detect once happened, as falling back to HPET
> > > will trigger obvious performance degradation.
> > 
> > And that is exactly what happened.  ;-)
> > 
> > > Could you give more detail about when and how it happens, and the
> > > HW info like how many sockets the platform has. 
> > 
> > We are in early days, so I am checking for other experiences.
> > 
> > > CC Thomas, Waiman, as they discussed simliar case here:
> > > https://lore.kernel.org/lkml/87h76ew3sb.ffs@tglx/T/#md4d0a88fb708391654e78312ffa75b481690699f
> > 
> > Fun!  ;-)

Waiman, do you recall what fraction of the benefit was provided by the
first patch, that is, the one that grouped the sync_lock, last_tsc,
max_warp, nr_warps, and random_warps global variables into a single
struct?

							Thanx, Paul
