Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02292718693
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbjEaPnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjEaPno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:43:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C38238E;
        Wed, 31 May 2023 08:43:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D70CA1042;
        Wed, 31 May 2023 08:44:27 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D52D3F663;
        Wed, 31 May 2023 08:43:41 -0700 (PDT)
Date:   Wed, 31 May 2023 16:43:38 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     Conor Dooley <conor@kernel.org>, stable@vger.kernel.org,
        Pierre Gondois <pierre.gondois@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:GENERIC ARCHITECTURE TOPOLOGY" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH stable 6.3 v2] arch_topology: Remove early cacheinfo
 error message if -ENOENT
Message-ID: <20230531154338.x7rivfpxj2wtjpq6@bogus>
References: <20230530201955.848176-1-florian.fainelli@broadcom.com>
 <20230530-basically-wildly-84415a94171d@spud>
 <72d84100-55cf-566d-8301-7147ce14b1e9@broadcom.com>
 <20230531085356.ru4fmtawyxo5cq5s@bogus>
 <7eae52f6-ca7e-5017-629e-43761d4eb5d7@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7eae52f6-ca7e-5017-629e-43761d4eb5d7@broadcom.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 08:28:26AM -0700, Florian Fainelli wrote:
> 
> 
> On 5/31/2023 1:53 AM, Sudeep Holla wrote:
> > On Tue, May 30, 2023 at 03:42:45PM -0700, Florian Fainelli wrote:
> > > Hi Conor,
> > > 
> > > On 5/30/23 14:39, Conor Dooley wrote:
> > > > Yo Florian,
> > > > 
> > > > On Tue, May 30, 2023 at 01:19:55PM -0700, Florian Fainelli wrote:
> > > > > From: Pierre Gondois <pierre.gondois@arm.com>
> > > > > 
> > > > > commit 3522340199cc060b70f0094e3039bdb43c3f6ee1 upstream
> > > > > 
> > > > > fetch_cache_info() tries to get the number of cache leaves/levels
> > > > > for each CPU in order to pre-allocate memory for cacheinfo struct.
> > > > > Allocating this memory later triggers a:
> > > > >     'BUG: sleeping function called from invalid context'
> > > > > in PREEMPT_RT kernels.
> > > > > 
> > > > > If there is no cache related information available in DT or ACPI,
> > > > > fetch_cache_info() fails and an error message is printed:
> > > > >     'Early cacheinfo failed, ret = ...'
> > > > > 
> > > > > Not having cache information should be a valid configuration.
> > > > > Remove the error message if fetch_cache_info() fails with -ENOENT.
> > > > > 
> > > > > Suggested-by: Conor Dooley <conor.dooley@microchip.com>
> > > > > Link: https://lore.kernel.org/all/20230404-hatred-swimmer-6fecdf33b57a@spud/
> > > > > Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> > > > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > > > Link: https://lore.kernel.org/r/20230414081453.244787-4-pierre.gondois@arm.com
> > > > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > > > Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> > > > 
> > > > How come this now needs a backport? Did the rest of the series get
> > > > backported, but not this one since it has no fixes tag?
> > > 
> > > Humm, indeed, this has been present in v6.3.2 since I requested it to be
> > > included. The error that I saw this morning was not -ENOENT, but -EINVAL.
> > > 
> > > With those patches applied, no more -EINVAL:
> > > 
> > > cacheinfo: Allow early level detection when DT/ACPI info is missing/broken
> > > cacheinfo: Add arm64 early level initializer implementation
> > > cacheinfo: Add arch specific early level initializer
> > > cacheinfo: Add use_arch[|_cache]_info field/function
> > > 
> > > I will submit those shortly unless we think they better not be in 6.3, in
> > > which case it would be nice to silence those -EINVAL errors.
> > 
> > I prefer this option instead of back porting all the above 4 as there are
> > some pending fixes for the issues found in those patches. I am fine if Greg
> > is happy with the backport, so no strong rejection from my side :).
> 
> OK, so are you suggesting that we specific check for -EINVAL and -ENOENT
> rather than take all of the 4 above patches,

Yes that is my preference ATM or if possible to wait until all the fixes
are sorted for the bugs associated with above 4 commits [1] and [2].
I have queued [1] but waiting for response/patch on [2] and hence not yet
bothered Greg.

> if so, any preference on how to do it given the state of 6.3 stable?

I don't understand what exactly do you mean ?

--
Regards,
Sudeep

[1] https://lore.kernel.org/all/20230508084115.1157-1-kprateek.nayak@amd.com
[2] https://lore.kernel.org/all/20230518012703.GA19967@ranerica-svr.sc.intel.com
