Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68704686F2E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 20:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjBATrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 14:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjBATr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 14:47:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3842C841A1;
        Wed,  1 Feb 2023 11:47:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E29F5B8228F;
        Wed,  1 Feb 2023 19:47:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C89C433D2;
        Wed,  1 Feb 2023 19:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675280835;
        bh=A9tTG8dWtmVDJMbXWhKt0soYbv6crDy7nFqy+MC4d2k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kYyDEcOIYUjcY88IYKRyJ3v0ffkxC6DFXM6AOwI/RNsVCxS8ZVdc+hWO33907UT3q
         9aHeIdmineumpKvWWoJWqkSsy1kh/2l5XfRRyyFPP3hYPPA+5TcsQV/BMCWl7gCLMF
         EcPAQDIhcnGzYXwKo5gmC2+DKybMMVeiCssPK3OQ=
Date:   Wed, 1 Feb 2023 20:47:12 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH] maple: remove unneeded maple_bus_uevent() callback.
Message-ID: <Y9rBwMf6p6QmkVPp@kroah.com>
References: <20230201125642.624255-1-gregkh@linuxfoundation.org>
 <2f10003fcf3671ccdd285952ba76153f5c2d5307.camel@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f10003fcf3671ccdd285952ba76153f5c2d5307.camel@physik.fu-berlin.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 08:05:21PM +0100, John Paul Adrian Glaubitz wrote:
> Hi Greg!
> 
> On Wed, 2023-02-01 at 13:56 +0100, Greg Kroah-Hartman wrote:
> > The driver core recently changed the uevent bus callback to take a const
> > pointer, and the maple_bus_uevent() was not correctly fixed up.  Instead
> > of fixing the function parameter types, just remove the callback
> > entirely as it does not do anything, so it is not necessary.
> > 
> > Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> > Cc: Rich Felker <dalias@libc.org>
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Fixes: 2a81ada32f0e ("driver core: make struct bus_type.uevent() take a const *")
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> > sh maintainers, I'll take this through my tree as that's where the
> > offending commit is that causes the build breakage.
> > 
> >  drivers/sh/maple/maple.c | 7 -------
> >  1 file changed, 7 deletions(-)
> > 
> > diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
> > index e24e220e56ee..e05473c5c267 100644
> > --- a/drivers/sh/maple/maple.c
> > +++ b/drivers/sh/maple/maple.c
> > @@ -760,12 +760,6 @@ static int maple_match_bus_driver(struct device *devptr,
> >  	return 0;
> >  }
> >  
> > -static int maple_bus_uevent(struct device *dev,
> > -			    struct kobj_uevent_env *env)
> > -{
> > -	return 0;
> > -}
> > -
> >  static void maple_bus_release(struct device *dev)
> >  {
> >  }
> > @@ -782,7 +776,6 @@ static struct maple_driver maple_unsupported_device = {
> >  struct bus_type maple_bus_type = {
> >  	.name = "maple",
> >  	.match = maple_match_bus_driver,
> > -	.uevent = maple_bus_uevent,
> >  };
> >  EXPORT_SYMBOL_GPL(maple_bus_type);
> 
> Through which tree is this supposed to be picked up?

As the comment below the --- line said above:

	sh maintainers, I'll take this through my tree as that's where the
	offending commit is that causes the build breakage.

So I took it :)

thanks,

greg k-h
