Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03490627C73
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbiKNLiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235639AbiKNLiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:38:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90BC11443
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:38:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75BA161048
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:38:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FEC1C433D7;
        Mon, 14 Nov 2022 11:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668425890;
        bh=Z+bQZioyJXaginZRSeTk5K2a/lFHqc09bOXXYShBvpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mgzbNdxm7HEvd+lc8OCJAdhj8bz6aGoAsp8DmcCrWYG3UnYfbLVMGV7QKaIAnDGoy
         lmCGDWI/n33qh+/VPVm8vIyJPl7v5Pj0nVnVjCdLW0iL20iiZGlbctK19gmith8FNl
         cUgXCgXsy3fLboJEvsnMNIUln2oXE0oXSczI0FVA=
Date:   Mon, 14 Nov 2022 12:38:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>,
        Peter Robinson <pbrobinson@redhat.com>,
        Steev Klimaszewski <steev@kali.org>,
        Rob Herring <robh@kernel.org>,
        Sergio Lopez Pascual <slp@redhat.com>,
        Enric Balletbo i Serra <eballetbo@redhat.com>,
        John Stultz <jstultz@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] driver core: Disable driver deferred probe timeout by
 default
Message-ID: <Y3IonmwrJ3aqDbAw@kroah.com>
References: <20221114104333.3695531-1-javierm@redhat.com>
 <Y3IeUADalX6WDnuO@kroah.com>
 <354820e8-939c-781a-0d76-c1574c43b7f3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <354820e8-939c-781a-0d76-c1574c43b7f3@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 12:13:15PM +0100, Javier Martinez Canillas wrote:
> Hello Greg,
> 
> Thanks a lot for your feedback.
> 
> On 11/14/22 11:54, Greg Kroah-Hartman wrote:
> 
> [...]
> 
> >>
> >> This default value of 0 was reverted again by commit f516d01b9df2 ("Revert
> >> "driver core: Set default deferred_probe_timeout back to 0."") and set to
> >> 10 seconds instead. Which was still less than the 30 seconds that was set
> >> at some point to allow systems with drivers built as modules and loaded by
> >> user-land to probe drivers that were previously deferred.
> >>
> >> The 10 seconds timeout isn't enough for the mentioned systems, for example
> >> general purpose distributions attempt to build all the possible drivers as
> >> a module to keep the Linux kernel image small. But that means that in very
> >> likely that the probe deferral mechanism will timeout and drivers won't be
> >> probed correctly.
> > 
> > What specific "mentioned systems" have deferred probe drivers that are
> 
> The "mentioned systems" are the ones mentioned in the paragraph above:
> 
> "to allow systems with drivers built as modules and loaded by user-land to
> probe drivers that were previously deferred."
> 
> I even gave an example about general purpose distributions that build as
> much as possible as a module. What more info do you think that is missing?

Exact systems that this is failing on would be great to have.

> > failing on the current value?  What drivers are causing the long delay
> > here?  No one should be having to wait 10 seconds for a deferred delay
> > on a real system as that feels really wrong.
> >
> 
> Not really, it depends if the drivers are built-in, built as modules, in
> the initramfs or in the rootfs. A 10 seconds might not be enough if these
> modules are in the root partition and need to wait for this to be mounted
> and udev to load the modules, etc.

How does it take 10 seconds to load the initramfs for a system that
requires deferred probe devices?  What typs of hardware is this?

> Also, it may even be that the module alias is not correct and then users
> have to load them by explicitly have /etc/modules-load.d/ configs and so
> on.

Then that's a totally different issue and the module alias needs to be
fixed and is not relevant here.

> > Why not fix the drivers that are causing this delay and maybe move them
> > to be async so as to not slow down the whole boot process?
> >
> 
> Yes, these drivers could be fixed to report a proper module alias or the
> dependencies can be built-in or added to the initramfs and that does not
> change the fact that by default the kernel shouldn't make assumptions
> about when is safe to just timeout instead of -EPROBE_DEFER.

Please let me know which drivers these are that are causing problems so
we can fix them.

> Because with modules the kernel has no way to know when all the modules
> have been already been loaded by user-space or more drivers are going to
> be registered in the future.

Of course that is true, so we guess, and so far, 10 seconds is a good
enough guess for normal systems out there that use deferred probe.  What
exact system and drivers do not work with this today?

> Also, that's how probe deferral always worked since the mechanism was
> introduced. It's just recently that the behavior was changed to timeout.
> 
> A nice feature of the probe deferral mechanism is that it was simple and
> reliable. Adding a timeout makes it non-deterministic and more fragile IMO.

deferred probe was never simple or reliable or determinisitic.  It was a
hack we had to implement to handle complex hardware situations and
loadable drivers.  Let's not try to paper over driver bugs here by
making the timeout "forever" but rather fix the root problem in the
broken drivers.

So, what drivers do we need to fix up?

thanks,

greg k-h
