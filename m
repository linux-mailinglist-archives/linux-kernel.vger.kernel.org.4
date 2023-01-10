Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7D1664130
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238572AbjAJNFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238589AbjAJNEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:04:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432F553711
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:04:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5CC6B81630
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:04:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D5EC433EF;
        Tue, 10 Jan 2023 13:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673355884;
        bh=sq4luO18KS6qeTo937pzwHYkQqfrEPiAZtnuZkJU/eo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MNPUURujLa8gS0IEH8tzZbC+nxNGk8soXrBaNs5gXL5QVxsJukFWVBhIyPn74iFNC
         u9/W0auYvL82Q0r5+xzssTsqkbqc3+ARW4p6/DfaHr9egNV2kV6D9mcswwRIu8zSOK
         kOj18eQQdumguoLWY78Wglp4U6vtSRHAr3Tpr6rI=
Date:   Tue, 10 Jan 2023 14:04:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] driver core: bus.h: document bus notifiers better
Message-ID: <Y71iaLwVCbVEVUB1@kroah.com>
References: <20230110124256.1663859-1-gregkh@linuxfoundation.org>
 <CAJZ5v0g63jNzqsnvg_UC7aBhX9_aNT=s=K9JpU9x8UpfoJ=dXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g63jNzqsnvg_UC7aBhX9_aNT=s=K9JpU9x8UpfoJ=dXQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 01:52:24PM +0100, Rafael J. Wysocki wrote:
> On Tue, Jan 10, 2023 at 1:43 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > The bus notifier values are not documented all that well, so clean this
> > up and make a real enumerated type for them and document them much
> > better.
> >
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  include/linux/device/bus.h | 43 +++++++++++++++++++++++++-------------
> >  1 file changed, 29 insertions(+), 14 deletions(-)
> >
> > diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
> > index d529f644e92b..1e1a593348bc 100644
> > --- a/include/linux/device/bus.h
> > +++ b/include/linux/device/bus.h
> > @@ -257,21 +257,36 @@ extern int bus_register_notifier(struct bus_type *bus,
> >  extern int bus_unregister_notifier(struct bus_type *bus,
> >                                    struct notifier_block *nb);
> >
> > -/* All 4 notifers below get called with the target struct device *
> > - * as an argument. Note that those functions are likely to be called
> > - * with the device lock held in the core, so be careful.
> > +/**
> > + * enum bus_notifier_event: Bus Notifier events that have happened
> > + *
> > + * These are the value passed to a bus notifier when a specific event happens.
> > + *
> > + * Note that bus notifiers are likely to be called with the device lock already
> > + * held by the driver core, so be careful in any notifier callback as to what
> > + * you do with the device structure.
> > + *
> > + * All bus notifiers are called with the target struct device * as an argument.
> > + *
> > + * BUS_NOTIFY_ADD_DEVICE: device is added to this bus
> > + * BUS_NOTIFY_DEL_DEVICE: device is about to be removed from this bus
> > + * BUS_NOTIFY_REMOVED_DEVICE: device is successfully removed from this bus
> > + * BUS_NOTIFY_BIND_DRIVER: a driver is about to be bound to this device on this bus
> > + * BUS_NOTIFY_BOUND_DRIVER: a driver is successfully bound to this device on this bus
> > + * BUS_NOTIFY_UNBIND_DRIVER: a driver is about to be unbound from this device on this bus
> > + * BUS_NOTIFY_UNBOUND_DRIVER: a driver is successfully unbound from this device on this bus
> > + * BUS_NOTIFY_DRIVER_NOT_BOUND: a driver failed to be bound to this device on this bus
> >   */
> > -#define BUS_NOTIFY_ADD_DEVICE          0x00000001 /* device added */
> > -#define BUS_NOTIFY_DEL_DEVICE          0x00000002 /* device to be removed */
> > -#define BUS_NOTIFY_REMOVED_DEVICE      0x00000003 /* device removed */
> > -#define BUS_NOTIFY_BIND_DRIVER         0x00000004 /* driver about to be
> > -                                                     bound */
> > -#define BUS_NOTIFY_BOUND_DRIVER                0x00000005 /* driver bound to device */
> > -#define BUS_NOTIFY_UNBIND_DRIVER       0x00000006 /* driver about to be
> > -                                                     unbound */
> > -#define BUS_NOTIFY_UNBOUND_DRIVER      0x00000007 /* driver is unbound
> > -                                                     from the device */
> > -#define BUS_NOTIFY_DRIVER_NOT_BOUND    0x00000008 /* driver fails to be bound */
> > +enum bus_notifier_event {
> > +       BUS_NOTIFY_ADD_DEVICE =         0x00000001,
> > +       BUS_NOTIFY_DEL_DEVICE =         0x00000002,
> > +       BUS_NOTIFY_REMOVED_DEVICE =     0x00000003,
> > +       BUS_NOTIFY_BIND_DRIVER =        0x00000004,
> > +       BUS_NOTIFY_BOUND_DRIVER =       0x00000005,
> > +       BUS_NOTIFY_UNBIND_DRIVER =      0x00000006,
> > +       BUS_NOTIFY_UNBOUND_DRIVER =     0x00000007,
> > +       BUS_NOTIFY_DRIVER_NOT_BOUND =   0x00000008,
> 
> I'm wondering why the values are in hex (the 0x prefix doesn't matter
> for these numbers AFAICS) and what the initial zeros are for (AFAICS
> they don't matter either).

I have no idea why they are this way.  I'll go change them to just be
decimal, thanks!

greg k-h
