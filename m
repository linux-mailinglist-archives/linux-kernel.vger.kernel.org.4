Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4A666BDBF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjAPMXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjAPMXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:23:10 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95401C311;
        Mon, 16 Jan 2023 04:23:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D0076CE0E92;
        Mon, 16 Jan 2023 12:23:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE94C433D2;
        Mon, 16 Jan 2023 12:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673871786;
        bh=JD4Qw+kGTk0vftDI4C/ZwHu7LD0az0ArFsgdGux842c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UDV2BYgRj4F1t3bjP3wvuSd0FfjtPMH92dqO+GS82leFLJzFff3c9x8cLPiCMHZbi
         t8Ve7YnuYNa0r/rplQK2iDeHGPeajwP3u6yrJcWS660c20lJJSu5uemMwAaVieyHY5
         ZV2otSM4QnGHnlLpdtTsri7enP6Jt1ZuN4Yd9DLU=
Date:   Mon, 16 Jan 2023 13:23:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Jim Lin <jilin@nvidia.com>, thierry.reding@gmail.com,
        mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v7 0/3] xhci: tegra: USB2 pad power controls
Message-ID: <Y8VBpxoI88ASPCaV@kroah.com>
References: <20221111101813.32482-1-jilin@nvidia.com>
 <f2dbfe41-7164-dffa-8e9c-2d5b0f8fcae6@nvidia.com>
 <Y7g9g0CbCc6b+3EN@kroah.com>
 <30fefd03-0ead-8980-ff5f-5e8a95e74c8a@linux.intel.com>
 <acf995cc-f3c2-c410-dc6b-b5d3b5cd0970@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acf995cc-f3c2-c410-dc6b-b5d3b5cd0970@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 11:50:19AM +0000, Jon Hunter wrote:
> 
> On 09/01/2023 08:28, Mathias Nyman wrote:
> > On 6.1.2023 17.25, Greg KH wrote:
> > > On Fri, Jan 06, 2023 at 02:56:51PM +0000, Jon Hunter wrote:
> > > > Hi Greg,
> > > > 
> > > > On 11/11/2022 10:18, Jim Lin wrote:
> > > > > 1. Export symbol on xhci_hub_control
> > > > > 2. Add hub_control to xhci_driver_overrides
> > > > > 3. Program USB2 pad PD controls during port connect/disconnect, port
> > > > > suspend/resume, and test mode, to reduce power consumption on
> > > > > disconnect or suspend.
> > > > > 
> > > > > Patch
> > > > > xhci: tegra: USB2 pad power controls
> > > > > depends on
> > > > > xhci: hub: export symbol on xhci_hub_control
> > > > > xhci: Add hub_control to xhci_driver_overrides
> > > > > 
> > > > > Jim Lin (3):
> > > > >     xhci: Add hub_control to xhci_driver_overrides
> > > > >     xhci: hub: export symbol on xhci_hub_control
> > > > >     xhci: tegra: USB2 pad power controls
> > > > > 
> > > > >    drivers/usb/host/xhci-hub.c   |   1 +
> > > > >    drivers/usb/host/xhci-tegra.c | 125
> > > > > ++++++++++++++++++++++++++++++++++
> > > > >    drivers/usb/host/xhci.c       |   2 +
> > > > >    drivers/usb/host/xhci.h       |   2 +
> > > > >    4 files changed, 130 insertions(+)
> > > > > 
> > > > 
> > > > 
> > > > I have verified that this still applies cleanly on top of -next.
> > > > Please let
> > > > us know if this can be queued up for Linux v6.3?
> > > 
> > > Normally for xhci stuff I want it to go through Mathias for things that
> > > are outside of just xhci-tegra.c.
> > 
> > Looks good to me, can be picked up directly
> > Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> > 
> > Or I can add this to the series going to usb-next if that is preferred.
> 
> 
> I did not see this in -next yet.
> 
> Mathias, are you able to pick this up?

I will when I catch up with linux-usb patches this week, sorry for the
delay, too many fires this early in the year...
