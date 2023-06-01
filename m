Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3732B7199AA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbjFAK1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbjFAK0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:26:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994F2E6F;
        Thu,  1 Jun 2023 03:25:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3224C60E9C;
        Thu,  1 Jun 2023 10:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158C2C433D2;
        Thu,  1 Jun 2023 10:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685615124;
        bh=MVjY6Lvr05SnVvdkaw/FELmaccjqgSRgM74IdOpoDGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wsqgoahs87B6Pl5vF7c58NFI+kiIRc+GY2M2BA+OwMiFKx05ZrqCWzC/NH1UgvOBm
         Ie/BdF0JjeccFePocMWgN8Q+sTHv/Gn1e7sKPksRagqYfWNpsSCOr2UoeBkePQJh4p
         fJqUKAj2q7+XEXECW1+Otg/aOD/0nIUBNdB+Z9lA=
Date:   Thu, 1 Jun 2023 11:25:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Conor Dooley <conor@kernel.org>, stable@vger.kernel.org,
        Pierre Gondois <pierre.gondois@arm.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:GENERIC ARCHITECTURE TOPOLOGY" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH stable 6.3 v2] arch_topology: Remove early cacheinfo
 error message if -ENOENT
Message-ID: <2023060131-letdown-cope-ddf7@gregkh>
References: <20230530201955.848176-1-florian.fainelli@broadcom.com>
 <20230530-basically-wildly-84415a94171d@spud>
 <72d84100-55cf-566d-8301-7147ce14b1e9@broadcom.com>
 <20230531085356.ru4fmtawyxo5cq5s@bogus>
 <7eae52f6-ca7e-5017-629e-43761d4eb5d7@broadcom.com>
 <20230531154338.x7rivfpxj2wtjpq6@bogus>
 <0f2e3a2b-477b-cbd7-e756-4b3f4df8e045@broadcom.com>
 <20230601063231.dyvrl37afhk65zit@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601063231.dyvrl37afhk65zit@bogus>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 07:32:31AM +0100, Sudeep Holla wrote:
> On Wed, May 31, 2023 at 12:52:22PM -0700, Florian Fainelli wrote:
> > 
> > 
> > On 5/31/2023 8:43 AM, Sudeep Holla wrote:
> > > On Wed, May 31, 2023 at 08:28:26AM -0700, Florian Fainelli wrote:
> > > > 
> > > > 
> > > > On 5/31/2023 1:53 AM, Sudeep Holla wrote:
> > > > > On Tue, May 30, 2023 at 03:42:45PM -0700, Florian Fainelli wrote:
> > > > > > Hi Conor,
> > > > > > 
> > > > > > On 5/30/23 14:39, Conor Dooley wrote:
> > > > > > > Yo Florian,
> > > > > > > 
> > > > > > > On Tue, May 30, 2023 at 01:19:55PM -0700, Florian Fainelli wrote:
> > > > > > > > From: Pierre Gondois <pierre.gondois@arm.com>
> > > > > > > > 
> > > > > > > > commit 3522340199cc060b70f0094e3039bdb43c3f6ee1 upstream
> > > > > > > > 
> > > > > > > > fetch_cache_info() tries to get the number of cache leaves/levels
> > > > > > > > for each CPU in order to pre-allocate memory for cacheinfo struct.
> > > > > > > > Allocating this memory later triggers a:
> > > > > > > >      'BUG: sleeping function called from invalid context'
> > > > > > > > in PREEMPT_RT kernels.
> > > > > > > > 
> > > > > > > > If there is no cache related information available in DT or ACPI,
> > > > > > > > fetch_cache_info() fails and an error message is printed:
> > > > > > > >      'Early cacheinfo failed, ret = ...'
> > > > > > > > 
> > > > > > > > Not having cache information should be a valid configuration.
> > > > > > > > Remove the error message if fetch_cache_info() fails with -ENOENT.
> > > > > > > > 
> > > > > > > > Suggested-by: Conor Dooley <conor.dooley@microchip.com>
> > > > > > > > Link: https://lore.kernel.org/all/20230404-hatred-swimmer-6fecdf33b57a@spud/
> > > > > > > > Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> > > > > > > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > > > > > > Link: https://lore.kernel.org/r/20230414081453.244787-4-pierre.gondois@arm.com
> > > > > > > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > > > > > > Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> > > > > > > 
> > > > > > > How come this now needs a backport? Did the rest of the series get
> > > > > > > backported, but not this one since it has no fixes tag?
> > > > > > 
> > > > > > Humm, indeed, this has been present in v6.3.2 since I requested it to be
> > > > > > included. The error that I saw this morning was not -ENOENT, but -EINVAL.
> > > > > > 
> > > > > > With those patches applied, no more -EINVAL:
> > > > > > 
> > > > > > cacheinfo: Allow early level detection when DT/ACPI info is missing/broken
> > > > > > cacheinfo: Add arm64 early level initializer implementation
> > > > > > cacheinfo: Add arch specific early level initializer
> > > > > > cacheinfo: Add use_arch[|_cache]_info field/function
> > > > > > 
> > > > > > I will submit those shortly unless we think they better not be in 6.3, in
> > > > > > which case it would be nice to silence those -EINVAL errors.
> > > > > 
> > > > > I prefer this option instead of back porting all the above 4 as there are
> > > > > some pending fixes for the issues found in those patches. I am fine if Greg
> > > > > is happy with the backport, so no strong rejection from my side :).
> > > > 
> > > > OK, so are you suggesting that we specific check for -EINVAL and -ENOENT
> > > > rather than take all of the 4 above patches,
> > > 
> > > Yes that is my preference ATM or if possible to wait until all the fixes
> > > are sorted for the bugs associated with above 4 commits [1] and [2].
> > > I have queued [1] but waiting for response/patch on [2] and hence not yet
> > > bothered Greg.
> > > 
> > > > if so, any preference on how to do it given the state of 6.3 stable?
> > > 
> > > I don't understand what exactly do you mean ?
> > 
> > Linux 6.3.y currently contains:
> > 
> > cacheinfo: Check sib_leaf in cache_leaves_are_shared()
> > cacheinfo: Check cache properties are present in DT
> > arch_topology: Remove early cacheinfo error message if -ENOENT
> > 
> > however my logs are full of:
> > 
> > [    0.001484] Early cacheinfo failed, ret = -22
> > 
> > reverting these 3 patches mentioned above does not eliminate the error.
> > 
> > What I am asking is if we need a targeted fix for 6.3 like this:
> >
> 
> I am fine with that. Please note Greg has now pulled the fixes I pointed.
> So I am fine if you want to backport the 4 patches discussed earlier as
> the stable will get the fixes soon which was my main concern earlier.
> 
> The other issue I pointed should also be resolved soon based on [1]

Ok, I don't know what to do here.  I think I'll take this simple patch,
and not the longer series as that seems to be too much for 6.3.y now,
especially as the fixes for it are not in Linus's tree yet.

If, after a bit, all of those need to go to 6.3.y, can someone please
send them here for inclusion?

thanks,

greg k-h
