Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8166695E3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 12:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241391AbjAMLvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 06:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240780AbjAMLux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:50:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1630551F2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 03:43:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78ED8B8211E
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:43:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54970C433D2;
        Fri, 13 Jan 2023 11:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673610227;
        bh=wMssYn7a9UicKw1I/2Ox0QJc2HeVwUhGPo7mUEOU6tM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EQiiWpjNymDmNMqgeJYaid300et/7cY/IHiSF+89ch+vhTvy6UjETVxfHYc6wmVsD
         RvpLuzcU0jIUIKjYI6IxVae17+n5bia6EKDxA5hegt5glV4ACWV6wyoKC0gRPJQkmj
         61hy6+Fz9TRPFurp8Q15grlGdaSTOZrkPtCCkgqA=
Date:   Fri, 13 Jan 2023 12:43:39 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] platform: Provide a remove callback that returns no value
Message-ID: <Y8FD66QlLFYiGR6+@kroah.com>
References: <20221209150914.3557650-1-u.kleine-koenig@pengutronix.de>
 <Y5NSevR9kb1UPvtQ@kroah.com>
 <20221209155207.pyugk2dhpyht5gph@pengutronix.de>
 <Y5NfLponxRO7j6nd@kroah.com>
 <20230112082029.aadce6dd35y3inaf@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230112082029.aadce6dd35y3inaf@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 09:20:29AM +0100, Uwe Kleine-König wrote:
> Hello Greg,
> 
> On Fri, Dec 09, 2022 at 05:15:42PM +0100, Greg Kroah-Hartman wrote:
> > On Fri, Dec 09, 2022 at 04:52:07PM +0100, Uwe Kleine-König wrote:
> > > On Fri, Dec 09, 2022 at 04:21:30PM +0100, Greg Kroah-Hartman wrote:
> > > > On Fri, Dec 09, 2022 at 04:09:14PM +0100, Uwe Kleine-König wrote:
> > > > > struct platform_driver::remove returning an integer made driver authors
> > > > > expect that returning an error code was proper error handling. However
> > > > > the driver core ignores the error and continues to remove the device
> > > > > because there is nothing the core could do anyhow and reentering the
> > > > > remove callback again is only calling for trouble.
> > > > > 
> > > > > So this is an source for errors typically yielding resource leaks in the
> > > > > error path.
> > > > > 
> > > > > As there are too many platform drivers to neatly convert them all to
> > > > > return void in a single go, do it in several steps after this patch:
> > > > > 
> > > > >  a) Convert all drivers to implement .remove_new() returning void instead
> > > > >     of .remove() returning int;
> > > > >  b) Change struct platform_driver::remove() to return void and so make
> > > > >     it identical to .remove_new();
> > > > >  c) Change all drivers back to .remove() now with the better prototype;
> > > > 
> > > > Change c) seems like it will be just as much work as a), right?
> > > 
> > > Yeah, but c) should be trivially doable per subsystem using coccinelle.
> > > So my plan is to do a) per subsystem with one patch per driver and c)
> > > with one patch per subsystem.
> > > 
> > > > Who is going to do the work of the conversion to this new prototype?
> > > > I'll be glad to take this, but I don't want to see a half-finished
> > > > conversion happen and us stuck with a "new" and "old" call, as that
> > > > would just be a mess.
> > > 
> > > The idea is that this becomes my new pet project once 
> > > https://lore.kernel.org/lkml/20221118224540.619276-1-uwe@kleine-koenig.org
> > > is complete. :-)
> > > 
> > > I intend to work on that once the patch under discussion is included in
> > > an -rc1.
> > 
> > Ok, I'll wait to queue this up to my tree until after 6.2-rc1 is out,
> > thanks.
> 
> We're at v6.2-rc3 now. Is this patch still in your queue and you didn't
> come around yet to apply it, or did it fell through the cracks?

My queue is huge right now.

I'll work on this "soon".  Do you want this on a tag that others can
pull into their trees, or just in my normal driver-core-next branch?
Either is fine for me.

thanks,

greg k-h
