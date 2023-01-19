Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA81674CA0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjATFhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjATFgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:36:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC52110276;
        Thu, 19 Jan 2023 21:33:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65B3CB82268;
        Thu, 19 Jan 2023 13:37:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D6EC433EF;
        Thu, 19 Jan 2023 13:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674135468;
        bh=sO75cV7afKYaRCZB2EF0QM3uKzcgi0tN7kGZsXY3dqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k7zzqJLN4b0SJLtEuq0d+WrSWejXA73Nx/iuuFKS9ftvinCN4cbyMwNDjn04POiGz
         zLDPaZqPrNvur38ttXU3yj2gZZqjkNyi0xO9b6Ugo/r+GfeONiVhG4yPmyL8G/lbrs
         mkg+aoki1ZSrnvaMwxx9ehbXgyIhady/thHEu6yc=
Date:   Thu, 19 Jan 2023 14:37:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Phil Elwell <phil@raspberrypi.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Umang Jain <umang.jain@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] Drop custom logging
Message-ID: <Y8lHqd9FlxiXTLuW@kroah.com>
References: <20230118115810.21979-1-umang.jain@ideasonboard.com>
 <b1a26368-3753-0d32-434b-e220dd9c06b4@i2se.com>
 <CAMEGJJ1=dix7gWvV3Jxef-M-ExFZRTASQCr+6sn_dGsEQ=deYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMEGJJ1=dix7gWvV3Jxef-M-ExFZRTASQCr+6sn_dGsEQ=deYQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 01:31:12PM +0000, Phil Elwell wrote:
> Hi all,
> 
> 
> On Wed, 18 Jan 2023 at 17:55, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> >
> > Hi Umang,
> >
> > [add Phil]
> >
> > Am 18.01.23 um 12:58 schrieb Umang Jain:
> > > Drop custom logging from the vchiq interface.
> > > Mostly of them are replaced with dev_dbg and friends
> > > and/or pr_info and friends.
> > >
> > > The debugfs log levels (in 4/4) are mapped to kernel
> > > logs levels (coming from include/linux/kern_levels.h)
> > > Would like some thoughts on it as I am not sure (hence
> > > marking this is RFC)
> > >
> > >  From drivers/staging/vc04_services/interface/TODO:
> > >
> > > """
> > > * Cleanup logging mechanism
> > >
> > > The driver should probably be using the standard kernel logging mechanisms
> > > such as dev_info, dev_dbg, and friends.
> >
> > i don't have any experience with vchiq logging/debug. So i'm not sure if
> > it's acceptable to lose the second log level dimension (like
> > vchiq_arm_log_level) completely. Complex drivers like brcmfmac have a
> > debug mask to avoid log spamming [1]. Maybe this is a compromise.
> >
> > Btw some loglevel locations has already been messed up during
> > refactoring :-(
> >
> > [1] - drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.h
> >
> > > """
> > >
> > > Umang Jain (4):
> > >    staging: vc04_services: vchiq_core: Drop custom logging
> > >    staging: vc04_services: vchiq_arm: Drop custom logging
> > >    staging: vc04_services: Drop custom logging
> > >    staging: vc04_services: Drop remnants of custom logging
> > >
> > >   .../interface/vchiq_arm/vchiq_arm.c           | 151 +++---
> > >   .../interface/vchiq_arm/vchiq_connected.c     |   5 +-
> > >   .../interface/vchiq_arm/vchiq_core.c          | 479 ++++++++----------
> > >   .../interface/vchiq_arm/vchiq_core.h          |  39 --
> > >   .../interface/vchiq_arm/vchiq_debugfs.c       |  26 +-
> > >   .../interface/vchiq_arm/vchiq_dev.c           |  78 ++-
> > >   6 files changed, 329 insertions(+), 449 deletions(-)
> > >
> 
> Thanks for the nudge - this patch set hasn't yet made its way through
> the sluggish rpi-kernel moderation.
> 
> I understand the desire to remove the custom logging. I don't welcome
> the loss of flexibility that comes with such a strategy

What "loss of flexibility"?  You now have access to the full dynamic
debugging facilities that all of the rest of the kernel has.  What is
lacking?

> , but I'm not
> going to argue about it. What's harder to understand is the state that
> this patchset leaves VCHIQ logging in. From what I can see, the
> per-service logging control has gone, but the code still contains
> macros that hint at something useful. Similarly, the debugfs support
> is completely vestigial, giving the appearance of control while
> actually achieving nothing.

The debugfs files should also be removed if they don't do anything
anymore.

thanks,

greg k-h
