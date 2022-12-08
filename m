Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDA2647351
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiLHPjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLHPjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:39:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA36CDA;
        Thu,  8 Dec 2022 07:39:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81A87B82441;
        Thu,  8 Dec 2022 15:39:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3CDC433D7;
        Thu,  8 Dec 2022 15:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670513978;
        bh=nzRDvvl+MmQVatyQphm0CIllrR/QIod7Bmtfz2logaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OLSeNd3rPcIwmQI3KjKuRxTDTz9KHPVt1OgPgYcGSRLrqm6LPiHaU+hmsveVb3O4o
         63Vjd/0kPt2VyfE2c3Uv+9Gd/QwrYNXR0TYbt2Ico/cN/q1x5mwjJa0AYKdZvuEEVi
         SnDIZyrLdZCsecjDtPRYdhzUX0E5hKYduBPWmO5o=
Date:   Thu, 8 Dec 2022 16:39:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc:     felipe.balbi@linux.intel.com, sre@kernel.org, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, linux-usb@vger.kernel.org,
        tony@atomide.com
Subject: Re: [PATCH] usb: phy: add dedicated notifier for charger events
Message-ID: <Y5IFN9haCK71EMjI@kroah.com>
References: <1668430562-27114-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <Y3JpfDU7T2Ks/H4m@kroah.com>
 <ec4edd51-3915-a798-2310-8ceadcd8152f@gmail.com>
 <590de096-5843-eab2-a48c-ca2742cb329b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <590de096-5843-eab2-a48c-ca2742cb329b@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 09:11:58AM +0200, Ivaylo Dimitrov wrote:
> 
> 
> On 14.11.22 г. 18:46 ч., Ivaylo Dimitrov wrote:
> > Hi,
> > 
> > On 14.11.22 г. 18:14 ч., Greg KH wrote:
> > > On Mon, Nov 14, 2022 at 02:56:02PM +0200, Ivaylo Dimitrov wrote:
> > > > usb_phy::notifier is already used by various PHY drivers (including
> > > > phy_generic) to report VBUS status changes and its usage conflicts with
> > > > charger current limit changes reporting.
> > > 
> > > How exactly does it conflict?
> > > 
> > 
> > see below
> > 
> > > > Fix that by introducing a second notifier that is dedicated to
> > > > usb charger
> > > > notifications. Add usb_charger_XXX_notifier functions. Fix
> > > > charger drivers
> > > > that currently (ab)use usb_XXX_notifier() to use the new API.
> > > 
> > > Why not just set the notifier type to be a new one instead of adding a
> > > whole new notifier list?  Or use a real callback?  notifier lists are
> > > really horrid and should be avoided whenever possible.
> > > 
> > 
> > Not sure what you mean by "notifier type', but if that is that val
> > parameter of atomic_notifier_call_chain(), the way it is used by usb
> > charger FW:
> > 
> > https://elixir.bootlin.com/linux/latest/source/drivers/usb/phy/phy.c#L132
> > 
> > is not compatible with:
> > 
> > https://elixir.bootlin.com/linux/latest/source/drivers/usb/phy/phy-generic.c#L185
> > 
> > 
> > for example, IIUC.
> > 
> > The former wants to send max current as val, while latter sends event
> > type as val. Sure, I may create some kind of hack, like using the MSB to
> > denote charger events, but that doesn't feel right.
> > 
> > Or, shall I do something else and fix the usage all over the place?
> > Please elaborate.
> > 
> 
> Digging further into that, it seems phy-ab8500-usb.c is also using
> usb_phy::notifier in non-standard way, it sends events from
> ux500_musb_vbus_id_status instead of usb_phy_events. I don't know the
> history behind, but right now we have at least 3 incompatible usages of
> usb_phy::notifier:
> 
> 1. Most of the phy and charger drivers use usb_phy_events as notifier type
> 
> 2. phy-ab8500-usb.c uses ux500_musb_vbus_id_status as notifier type, I am
> not the only one to hit that it seems https://elixir.bootlin.com/linux/v6.1-rc5/source/drivers/power/supply/ab8500_charger.c#L3191
> 
> 3. USB charger framework uses max charging current as notifier type.
> 
> Moreover, a charger driver in a system that has gadget drivers support and
> phy that has extcon charger cable detection support and registers to phy
> notifier, will inevitably receive (1) and (3) types of notifications,
> without any way to distinguish I was able to find.

Can't they properly detect this based on the type of the notification
sent to them?  Why not just set that correctly?

> I don't really see how those can be merged to use one notifier only, without
> fixing most of USB phy and gadget drivers and half of charger drivers. Not
> that I like adding the second notifier, I just don;t see other way.

Fixing them all so that we don't have this mess and require
yet-another-notifier would be very good.  I know it's not your mess, but
I think it's the best long-term solution to it, don't you?

thanks,

greg k-h
