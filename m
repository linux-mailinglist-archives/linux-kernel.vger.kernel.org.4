Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242C66064D4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiJTPk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJTPkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:40:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C08A13ECEE
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:40:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 333B9B827CF
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 15:40:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0FEC433D6;
        Thu, 20 Oct 2022 15:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666280452;
        bh=8LfYTvcOE361XSrCDq1dHKnQsaqFwcRl7ob/DFKlE2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=skva0VPyG+mOfz8PBtYZK6FNMd7dA5GMQZti7ltVhJe8gM0bYm9NIqmNAgLzyVeoO
         TafGRASsEJxAtET3R4jugMq6Y1opguelmhCSyaE+VvU6monIK/I6JYVyMdsE7Z7rbf
         gSPhwH5QZud68pCXY5zh6ZXghxz74FceXbDhmgK8=
Date:   Thu, 20 Oct 2022 17:40:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Deepak R Varma <drv@mailo.com>
Cc:     Julia Lawall <julia.lawall@inria.fr>, outreachy@lists.linux.dev,
        pure.logic@nexus-software.ie, johan@kernel.org, elder@kernel.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: loopback: enclose macro statements in
 do-while loop
Message-ID: <Y1FsAZQqFdX12lgb@kroah.com>
References: <Y0wS4HQo9m/W/TrQ@debian-BULLSEYE-live-builder-AMD64>
 <alpine.DEB.2.22.394.2210161649400.2876@hadrien>
 <Y0wdDTUBrUT/cr9w@lion2204>
 <alpine.DEB.2.22.394.2210161709440.2876@hadrien>
 <Y0wi4itS3d8aExFc@debian-BULLSEYE-live-builder-AMD64>
 <Y0wmC2oi0TOpvpPM@kroah.com>
 <Y0woVSgGfUuvJUzY@debian-BULLSEYE-live-builder-AMD64>
 <Y1AXkRJRtmnEom5T@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1AXkRJRtmnEom5T@debian-BULLSEYE-live-builder-AMD64>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 08:58:17PM +0530, Deepak R Varma wrote:
> On Sun, Oct 16, 2022 at 11:50:45AM -0400, Deepak R Varma wrote:
> > On Sun, Oct 16, 2022 at 05:40:59PM +0200, Greg KH wrote:
> > > On Sun, Oct 16, 2022 at 11:27:30AM -0400, Deepak R Varma wrote:
> > > > On Sun, Oct 16, 2022 at 05:10:17PM +0200, Julia Lawall wrote:
> > > > >
> > > > >
> > > > > On Sun, 16 Oct 2022, Deepak R Varma wrote:
> > > > >
> > > > > > On Sun, Oct 16, 2022 at 04:51:09PM +0200, Julia Lawall wrote:
> > > > > > >
> > > > > > >
> > > > > > > On Sun, 16 Oct 2022, Deepak R Varma wrote:
> > > > > > >
> > > > > > > > Include multiple statements of macro definition inside do-while{0} loop
> > > > > > > > to avoid possible partial program execution. Issue reported by
> > > > > > > > checkpatch script:
> > > > > > > >
> > > > > > > > ERROR: Macros with multiple statements should be enclosed in a do - while loop
> > > > > > >
> > > > > > > I don't think this change will compile.  See if you can figure out why
> > > > > > > not.
> > > > > >
> > > > > > It did compile. I built the greybus driver and loaded it as well with the
> > > > > > modinfo tool. Can you please tell why you think it won't compile?
> > > > >
> > > > > Do you have a .o file for the .c file that you changed?
> > > >
> > > > I see many .o files and a greybus.ko as well, but not the loopback.o
> > > > Am I missing anything with my configuration? I did set Greybus Support to (M) in
> > > > the menuconfig.
> > >
> > > CONFIG_GREYBUS_LOOPBACK has to be enabled in order to build the
> > > drivers/staging/greybus/loopback.c file.
> > >
> > > A simple check would be to do:
> > > 	make drivers/staging/greybus/loopback.o
> > >
> > > does that work with your change?
> >
> > No, it did not. I understand why it did not. My apologies for not looking into
> > the build of loopback.o file when the greybus module was rebuilt.
> >
> > Please ignore my patch.
> 
> I just received a message from Kernel Test Robot that this patch failed to
> compile. I had requested to drop/ignore this patch. However, looks like it
> included in the staging-testing tree????

It just took a while to get to your patch, it picked it up off of the
mailing list, the change is not applied anywhere.

> Let me know anything required from me to fix the bot complaint. Thank you.

There's nothing to do as it's long-gone from my queue.

thanks,

greg k-h
