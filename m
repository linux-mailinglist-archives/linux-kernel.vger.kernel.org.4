Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE537285E3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbjFHQ6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236366AbjFHQ6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:58:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6112707
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 09:58:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E03861990
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 16:58:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB66C433EF;
        Thu,  8 Jun 2023 16:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686243492;
        bh=oj4OkO1uA/76/SEcvbW6HdQWPxsH0HxZxvg2WCw5dks=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FS10IUMFO/YtyKLse8z3r7zC6RFCM51NhCMcyD48BoYLmDZI4UxMnDePGQ1aWkXOZ
         XzoExPDiNg8JVM9R/q7kHh2KV1Ta/N3C01zxqm5cIIm6lGeqgesmZbarSHgHzx2mRH
         Yv1Pvxofj/47HNiWZOehnSpKRGdr4dko0Ywo5/ZTB4cvvN4XCzlR/PZ4htK+iWAZnd
         uxWhkQasLkxjjbXP4wZHW49Jc45a/soIbPwIe3ni9Vf5TEaAiMUnrIACL2UgbnIb7k
         AU9jmpiSLkeFbwTCBhygikkyIWbXrEzPN9D1W71S8Fw3HXwo/3/i1NR+fDkCjn6oud
         xogESA+xsHn5A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5E70ACE14DD; Thu,  8 Jun 2023 09:58:12 -0700 (PDT)
Date:   Thu, 8 Jun 2023 09:58:12 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, rui.zhang@intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] x86/tsc: Make recalibration default on for
 TSC_KNOWN_FREQ cases
Message-ID: <db8d4046-4056-43c1-b73d-f2502ae69198@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230522033018.1276836-1-feng.tang@intel.com>
 <87h6s4ye9b.ffs@tglx>
 <934e9008-36db-492b-b744-9d68183c6d32@paulmck-laptop>
 <73283eba-14b8-2da1-6109-c183586fe5b7@intel.com>
 <2c5a8c69-21d0-4b1a-ad1b-6072228e2b43@paulmck-laptop>
 <ZH00rXjK+H1BTBrQ@feng-clx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH00rXjK+H1BTBrQ@feng-clx>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 09:04:45AM +0800, Feng Tang wrote:
> On Fri, Jun 02, 2023 at 12:08:10PM -0700, Paul E. McKenney wrote:
> > On Fri, Jun 02, 2023 at 11:36:54AM -0700, Dave Hansen wrote:
> > > On 6/2/23 11:29, Paul E. McKenney wrote:
> > > >>> One downside is, many VMs also has X86_FEATURE_TSC_KNOWN_FREQ set,
> > > >>> and they will also do this recalibration.
> > > >> It's also pointless for those SoCs which lack legacy hardware.
> > > >>
> > > >> So why do you force this on everyone?
> > > > Just for the record, this patch could be helpful in allowing victims
> > > > of TSC mis-synchronization to more easily provide a more complete bug
> > > > report to the firmware people.  There is of course no point if there is
> > > > already a fix available.
> > > > 
> > > > But it is not all that hard to work around not having this patch upstream.
> > > > This can be hand-applied as needed, NTP drift rates can be pressed
> > > > into service for those of us having atomic clocks near all our servers,
> > > > or the firmware guys can be tasked with figuring it out.
> > > > 
> > > > So this patch would be nice to have, but we could live without it.
> > > 
> > > Is this the kind of thing we could relegate to a kernel unit test?  Like
> > > make the recalibration logic _available_, but don't have it affect the
> > > rest of the system.
> > > 
> > > I love patching my kernel as much as the next guy.  But, you know what I
> > > *don't* love?  Explaining how to patch kernels to other people. ;)
> > 
> > One could argue that we already have the TSC equivalent of a kernel unit
> > test with the tsc=recalibrate kernel boot parameter.
> > 
> > So, would it make sense to have something like tsc=recalibrate (already
> > present) in the guise of something like hpet=recalibrate and/or
> > pmtmr=recalibrate in order to allow people to opt into recalibrating
> > whatever timer is marked unstable?
>  
> This kind of hint parsing should be in tsc.c, so some name like
> 'tsc_recal=hpet/pmtmr' ?  
> 
> As hpet and pmtimer are the only 2 choices and hpet is the default
> one, if people want to use pmtimer, they can use combined parameter 
> "tsc=recalibrate nohpet".

Or something like "tsc=recalibrateother"?

I am not all that worried about what the boot parameters look like,
as long as we have a way of telling the kernel to recalibrate whatever
clocksource just got marked unstable.  ;-)

> Also, thanks for sharing your thoughts form a victim's viewpoint
> in the other mail! :)

Glad it helped!  ;-)

							Thanx, Paul
