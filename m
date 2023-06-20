Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C518737469
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 20:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjFTSgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 14:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjFTSgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:36:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AB0DC;
        Tue, 20 Jun 2023 11:36:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 341E1613F8;
        Tue, 20 Jun 2023 18:36:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C69C433C8;
        Tue, 20 Jun 2023 18:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687286173;
        bh=sX2sSKMvZDgXiv/6djBL9peXikyWYOXmqDdJtUv/Rog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T7P6o2NTmIK/dfUJ2MlqFSWk/HD8zh5kKq3V59rbEkm2W8iBi4+KzYOqRgEsG1c5J
         Flu1mqP3J/LZuS8od7PS1Rtww2CS7zqpGXwaUGIk5R28w7H0jA5RUWiUC1ryGnCobY
         QMcza8/waYE7Agv47F27XZUL4+izLIzqvieGqV7c=
Date:   Tue, 20 Jun 2023 20:36:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Umang Jain <umang.jain@ideasonboard.com>,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefan.wahren@i2se.com,
        f.fainelli@gmail.com, athierry@redhat.com, error27@gmail.com,
        dave.stevenson@raspberrypi.com, kieran.bingham@ideasonboard.com
Subject: Re: [PATCH v7 1/5] staging: vc04_services: vchiq_arm: Add new bus
 type and device type
Message-ID: <2023062030-flattop-jury-e10c@gregkh>
References: <20230620134152.383569-1-umang.jain@ideasonboard.com>
 <20230620134152.383569-2-umang.jain@ideasonboard.com>
 <2023062022-whimsical-hasty-b012@gregkh>
 <20230620182054.GA14686@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620182054.GA14686@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 09:20:54PM +0300, Laurent Pinchart wrote:
> On Tue, Jun 20, 2023 at 04:17:05PM +0200, Greg KH wrote:
> > On Tue, Jun 20, 2023 at 07:11:48PM +0530, Umang Jain wrote:
> > > The devices that the vchiq interface registers (bcm2835-audio,
> > > bcm2835-camera) are implemented and exposed by the VC04 firmware.
> > > The device tree describes the VC04 itself with the resources required
> > > to communicate with it through a mailbox interface. However, the
> > > vchiq interface registers these devices as platform devices. This
> > > also means the specific drivers for these devices are getting
> > > registered as platform drivers. This is not correct and a blatant
> > > abuse of platform device/driver.
> > > 
> > > Add a new bus type, vchiq_bus_type and device type (struct vchiq_device)
> > > which will be used to migrate child devices that the vchiq interfaces
> > > creates/registers from the platform device/driver.
> > > 
> > > Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> > > ---
> > >  drivers/staging/vc04_services/Makefile        |  1 +
> > >  .../interface/vchiq_arm/vchiq_device.c        | 78 +++++++++++++++++++
> > >  .../interface/vchiq_arm/vchiq_device.h        | 43 ++++++++++
> > >  3 files changed, 122 insertions(+)
> > >  create mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
> > >  create mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.h
> > > 
> > > diff --git a/drivers/staging/vc04_services/Makefile b/drivers/staging/vc04_services/Makefile
> > > index 44794bdf6173..2d071e55e175 100644
> > > --- a/drivers/staging/vc04_services/Makefile
> > > +++ b/drivers/staging/vc04_services/Makefile
> > > @@ -5,6 +5,7 @@ vchiq-objs := \
> > >     interface/vchiq_arm/vchiq_core.o  \
> > >     interface/vchiq_arm/vchiq_arm.o \
> > >     interface/vchiq_arm/vchiq_debugfs.o \
> > > +   interface/vchiq_arm/vchiq_device.o \
> > >     interface/vchiq_arm/vchiq_connected.o \
> > >  
> > >  ifdef CONFIG_VCHIQ_CDEV
> > > diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
> > > new file mode 100644
> > > index 000000000000..e16279a25126
> > > --- /dev/null
> > > +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
> > > @@ -0,0 +1,78 @@
> > > +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> > 
> > Code that directly interacts with the driver core can, for obvious
> > reasons, not be BSD-3 licensed, sorry.
> > 
> > Also, why is any of this dual licensed?  What good is any of that?  In
> > order for me to accept new dual-licensed code, it needs to be documented
> > in the changelog very very well as to exactly why this is required, as
> > the legal issues involved in maintaining dual-licensed code like this is
> > tricky and easy to get wrong (as proven here already in this patch...)
> 
> The whole vchiq_arm layer is dual licensed GPL-2.0 + BSD-3. I assume
> this is why Umang used the same licensing terms. We can use GPL-2.0 only
> if this patch qualifies as original work and not derived work of the
> existing code.

This is most certainly original work, not related to the original code
here, and can never work in a BSD-3 licensed environment.

thanks,

greg k-h
