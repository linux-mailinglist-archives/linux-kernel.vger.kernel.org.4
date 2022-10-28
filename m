Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B128D610EAF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 12:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiJ1KiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 06:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiJ1Khr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 06:37:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718341C73D8;
        Fri, 28 Oct 2022 03:37:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E38462765;
        Fri, 28 Oct 2022 10:37:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2487FC433C1;
        Fri, 28 Oct 2022 10:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666953438;
        bh=DswN2BfuKinwRunqzOR2Ky9Gy/j+dcMTsxu/K35r21o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gwacUfVNSHnrmULCjz/faapZJe0gYTC5HfgjqJLdAJMfPFCPBavC1/TpIJSxVyUzu
         k70f5jkQ69xx7+V6TlkrjNEHzbG/PFa7LFFzWJwWq8F5dpRySPr3FuMp17s59P/FsR
         Fmja8faMy+OerMbRFghlOe1kMUNDb3CuYF7WR6ek=
Date:   Fri, 28 Oct 2022 12:37:15 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jim Lin <jilin@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v5 1/3] xhci: hub: export symbol on xhci_hub_control
Message-ID: <Y1uw2zp/XnUdgEwJ@kroah.com>
References: <20221027133127.27592-1-jilin@nvidia.com>
 <20221027133127.27592-2-jilin@nvidia.com>
 <Y1qOhjOXM4sQW+a/@kroah.com>
 <3c3b175d2031b8e440bfdef9b4c23c0272a5f607.camel@nvidia.com>
 <Y1txBtRZAJ5vpItj@kroah.com>
 <Y1ul9zU2wmbJo3x7@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1ul9zU2wmbJo3x7@orome>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 11:50:47AM +0200, Thierry Reding wrote:
> On Fri, Oct 28, 2022 at 08:04:54AM +0200, gregkh@linuxfoundation.org wrote:
> > On Fri, Oct 28, 2022 at 05:36:41AM +0000, Jim Lin wrote:
> > > On Thu, 2022-10-27 at 15:58 +0200, Greg KH wrote:
> > > > External email: Use caution opening links or attachments
> > > > 
> > > > 
> > > > On Thu, Oct 27, 2022 at 09:31:25PM +0800, Jim Lin wrote:
> > > > > Add EXPORT_SYMBOL_GPL on xhci_hub_control() for other driver module
> > > > > to invoke and avoid linking error.
> > > > 
> > > > What other driver module?
> > > > 
> > > > There is no user here :(
> > > > 
> > > > confused,
> > > > 
> > > 
> > > In arch/arm/configs/multi_v7_defconfig
> > > It defines
> > > CONFIG_USB_XHCI_TEGRA=m
> > > 
> > > If I don't add EXPORT_SYMBOL_GPL on xhci_hub_control()
> > > , I will get compile/linking error like
> > > 
> > > ERROR: modpost: "xhci_hub_control" [drivers/usb/host/xhci-tegra.ko]
> > > undefined!
> > > 
> > > if patch
> > > "[PATCH v5,3/3] xhci: tegra: USB2 pad power controls"
> > > 
> > > https://patchwork.kernel.org/project/linux-usb/patch/20221027133127.27592-4-jilin@nvidia.com/
> > > is added in xhci-tegra.c to invoke xhci_hub_control()
> > > 
> > > Should I integrate this patch with [PATCH v5,3/3] as one?
> > 
> > Yes, do not add something that is not needed for that specific commit,
> > otherwise it causes reviewers to be confused.
> 
> Other subsystem maintainers prefer core changes to be split from driver
> changes, so this type of split is commonly encountered elsewhere.
> 
> Obviously, since this is your turf you get to make the rules. I'm just
> trying to say that this kind of advice can be confusing for contributors
> because when they then sent driver and code changes mixed for their next
> submission, the subsystem maintainer might tell them otherwise.

Sure, but if you do split it up like this, DOCUMENT WHY THE EXPORT IS
NEEDED.  That didn't happen here so I had no idea why this was even an
issue.

And yes, I am very sensitive to this, we have had LOTS of people trying
to export xhci symbols in the past few years for no in-kernel users,
despite us constantly telling them that this is not allowed.  It
happened again, just yesterday:
	https://lore.kernel.org/r/20221027004050.4192111-1-albertccwang@google.com

And at first glance, I assumed this was much the same as there was no
description of why this was needed at all.

thanks,

greg k-h
