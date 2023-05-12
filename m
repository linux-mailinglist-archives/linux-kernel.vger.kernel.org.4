Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E8A700AED
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 17:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241664AbjELPA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 11:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241581AbjELPAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 11:00:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC15106D8
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 08:00:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07CE765765
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 15:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578F4C433EF;
        Fri, 12 May 2023 15:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683903623;
        bh=UoKuHtR2zuyhdc4m74j2RrwL7ta0qNtOKzLYO/kUwlo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OCEGMZ05vb1KpdVRCHMpOMNXSep+RzW+Q7i8zUFMR9rcazp7j66lUf0LAOltb1MDf
         Bj21vSQpWgcdJXuHO/phJ0hT0/pnCXzI/g7pCYX2qCttAxAIDwdz5fNdpgrGqwVzLc
         zd9++AXd22tuB74rm07eVmM4WMl7GWMmXEgu8qhoqO36sO7Z54fW0mkxn5+P8jDHJc
         p/ZXqq+weemUImmxD1G1PzPGm27E1TOa0Ko1DpL0IijvzjPls4TTheBKUvtknHRmVJ
         yvTRlWtA2IkA/N5tNSaGdLfbv8rqwkY7s6TsQCHkGpDGjL+EyZxdONrPjFkDyefmeF
         xGgKnyidUAdwg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pxUGK-0001Tb-18; Fri, 12 May 2023 17:00:52 +0200
Date:   Fri, 12 May 2023 17:00:52 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] driver core: Call pm_runtime_put_sync() only after
 device_remove()
Message-ID: <ZF5UpOzmvXLX-056@hovoldconsulting.com>
References: <20230511073428.10264-1-u.kleine-koenig@pengutronix.de>
 <CAJZ5v0gNPt=rq+pQtmoGL5nxzDQboOK4d6h7=NoY=LueVhZjAQ@mail.gmail.com>
 <20230511103923.hvibdyo5ges4bab2@pengutronix.de>
 <ZFzWCey825wSlr2v@hovoldconsulting.com>
 <CAJZ5v0jvJT4JkHtO3RCUEzkfawxLCwR=QO2Y2CsL=cYN9s4hXw@mail.gmail.com>
 <ZF3tUQFTeILXV_VT@hovoldconsulting.com>
 <CAJZ5v0gRcaL5y4nyDcFYfnH8sNYOHSHZN1qwcv+Z7yu4jhSiMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gRcaL5y4nyDcFYfnH8sNYOHSHZN1qwcv+Z7yu4jhSiMA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 04:04:59PM +0200, Rafael J. Wysocki wrote:
> On Fri, May 12, 2023 at 9:39 AM Johan Hovold <johan@kernel.org> wrote:
> >
> > On Thu, May 11, 2023 at 04:44:25PM +0200, Rafael J. Wysocki wrote:
> > > On Thu, May 11, 2023 at 1:48 PM Johan Hovold <johan@kernel.org> wrote:
> >
> > > > No, this seems like very bad idea and even violates the documentation
> > > > which clearly states that the usage counter is balanced before calling
> > > > remove() so that drivers can use pm_runtime_suspend() to put devices
> > > > into suspended state.
> > >
> > > I missed that, sorry.
> > >
> > > > There's is really no good reason to even try to change as this is in no
> > > > way a fast path.
> > >
> > > Still, I think that while the "put" part needs to be done before
> > > device_remove(), the actual state change can be carried out later.
> > >
> > > So something like
> > >
> > >     pm_runtime_put_noidle(dev);
> > >
> > >     device_remove(dev);
> > >
> > >     pm_runtime_suspend(dev);
> > >
> > > would generally work, wouldn't it?
> >
> > No, as drivers typically disable runtime pm in their remove callbacks,
> 
> What exactly do you mean by "typically"?  None of the PCI drivers
> should do that, for instance.

I had platform drivers in mind, but so do i2c drivers for example.

> > that pm_runtime_suspend() would amount to a no-op (and calling the
> > driver pm ops post unbind and the driver having freed its data would
> > not work either).
> 
> Well, not really.
> 
> There are drivers and there are bus types/PM domains.  Drivers need
> not disable PM-runtime in their "remove" callbacks if they know that
> the bus type/PM domain will take care of handling PM-runtime properly
> after the driver's remove callback has run and the bus type/PM domain
> may very well want its PM-runtime suspend callback to run then (for
> example, to remove power from the unused device).  Arguably it can
> invoke runtime_suspend() from its "remove" callback, so it's not like
> this is a big deal, but IMO it helps if the most general case is
> considered.

My point was that hundreds of drivers do and for these this call becomes
a no-op. Same for buses that disable runtime pm at remove.

> Anyway, the question here really is: Does it make sense to carry out a
> runtime suspend immediately before device_remove()?  Honestly, I'm not
> sure about that.

I'd say it doesn't really matter as driver unbind is not a common
operation and drivers using autosuspend would generally not be affected
either.

You can try to rework this, but clearly it needs more thought than
simply moving the put sync and some drivers may also be relying on the
current behaviour.

A quick grep reveals a few which would be left active if you change
pm_runtime_put_sync() to pm_runtime_put_noidle(), even if that could be
fixed driver by driver of course.

Johan
