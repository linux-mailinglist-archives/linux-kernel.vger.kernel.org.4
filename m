Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095D5660319
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 16:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbjAFP0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 10:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235050AbjAFP0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 10:26:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14FA5F46;
        Fri,  6 Jan 2023 07:26:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7EECCB81D9D;
        Fri,  6 Jan 2023 15:26:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8563C433D2;
        Fri,  6 Jan 2023 15:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673018759;
        bh=UQrBUx5gRtz1ipvUXMT2HCaI/siWBR2KN467L9f4LsE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pSix0cS4V5fmDqKl/JutLDVGFhiWubclswSrN6j6FiweSXJ7mhhsjdGHSgbFrAVQF
         ZpNSJiU2BA9R6MCE6a1+g9QVk+ucOvR6fG6JlpfYviy4XnFqn1Kbz1cgw5C9fWSKlC
         7P2gA/DvtqAgsAXt+CGS4sbU/JO12dZZCKN1Iv5o=
Date:   Fri, 6 Jan 2023 16:25:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Jim Lin <jilin@nvidia.com>, thierry.reding@gmail.com,
        mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v7 0/3] xhci: tegra: USB2 pad power controls
Message-ID: <Y7g9g0CbCc6b+3EN@kroah.com>
References: <20221111101813.32482-1-jilin@nvidia.com>
 <f2dbfe41-7164-dffa-8e9c-2d5b0f8fcae6@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2dbfe41-7164-dffa-8e9c-2d5b0f8fcae6@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 02:56:51PM +0000, Jon Hunter wrote:
> Hi Greg,
> 
> On 11/11/2022 10:18, Jim Lin wrote:
> > 1. Export symbol on xhci_hub_control
> > 2. Add hub_control to xhci_driver_overrides
> > 3. Program USB2 pad PD controls during port connect/disconnect, port
> > suspend/resume, and test mode, to reduce power consumption on
> > disconnect or suspend.
> > 
> > Patch
> > xhci: tegra: USB2 pad power controls
> > depends on
> > xhci: hub: export symbol on xhci_hub_control
> > xhci: Add hub_control to xhci_driver_overrides
> > 
> > Jim Lin (3):
> >    xhci: Add hub_control to xhci_driver_overrides
> >    xhci: hub: export symbol on xhci_hub_control
> >    xhci: tegra: USB2 pad power controls
> > 
> >   drivers/usb/host/xhci-hub.c   |   1 +
> >   drivers/usb/host/xhci-tegra.c | 125 ++++++++++++++++++++++++++++++++++
> >   drivers/usb/host/xhci.c       |   2 +
> >   drivers/usb/host/xhci.h       |   2 +
> >   4 files changed, 130 insertions(+)
> > 
> 
> 
> I have verified that this still applies cleanly on top of -next. Please let
> us know if this can be queued up for Linux v6.3?

Normally for xhci stuff I want it to go through Mathias for things that
are outside of just xhci-tegra.c.

thanks,

greg k-h
