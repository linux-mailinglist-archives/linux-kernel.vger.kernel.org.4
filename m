Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2B16248F8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiKJSCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiKJSCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:02:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAE051C1F;
        Thu, 10 Nov 2022 10:02:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5B3961535;
        Thu, 10 Nov 2022 18:01:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997D2C43470;
        Thu, 10 Nov 2022 18:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668103319;
        bh=M5rLoXR2mfR5eibPRb489KjTPMmgEjz5/iycQIHsWR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pGzEw2+yOnxRsIIVA0+iBwtr3LOMH7Q83xpdEZPvMwb1jfwyh4KKnez8yDjPMqQMh
         +pmbSydihJ6VKMiHhcG64h8pLMZbNwXY8I+3SPhUg2hdNOY1mbAFyZZk2dIcphSIFZ
         ATfk2JhyEXa7bauWGczy1IMALyOiyacgtPz86sIg=
Date:   Thu, 10 Nov 2022 19:01:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, saravanak@google.com, geert+renesas@glider.be,
        krzysztof.kozlowski@linaro.org, robh@kernel.org
Subject: Re: [PATCH RESEND v4 0/2] drivers: bus: Add Freescale i.MX8qxp pixel
 link MSI bus support
Message-ID: <Y208lGQ7aFXsRDO6@kroah.com>
References: <20221017074039.4181843-1-victor.liu@nxp.com>
 <55b3aaac5085761c2ac274f9faabd252acdd8418.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55b3aaac5085761c2ac274f9faabd252acdd8418.camel@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 04:30:57PM +0800, Liu Ying wrote:
> On Mon, 2022-10-17 at 15:40 +0800, Liu Ying wrote:
> > Hi,
> > 
> > This series aims to add Freescale i.MX8qxp pixel link MSI bus support
> > by using the existing simple-pm-bus driver. A power domain and two input
> > clocks need to be enabled before the MSI bus accesses it's child devices,
> > which matches what a simple power-managed bus is(See simple-pm-bus.yaml).
> > 
> > Patch 1 enables/disables functional clock(s) as a bulk in the
> > simple-pm-bus driver when the simple-pm-bus is being power managed,
> > since the MSI bus takes the two input clocks as functional clocks.
> > 
> > Patch 2 adds dt-bindings for the MSI bus.
> > 
> > v3->v4:
> > * Drop patch 1 in v3, because simple-bus/simple-mfd devices probed by the
> >   simple-pm-bus driver should not be child nodes of simple-pm-bus at all,
> >   as simple-bus/simple-mfd's child devices PM operations cannot be propagated
> >   to simple-pm-bus. Those simple-bus/simple-mfd devices needs dedicated drivers.
> > * Drop unnecessary 'bus == NULL' check from simple_pm_bus_runtime_{suspend,resume}.
> >   for patch 1 in v4. (Geert)
> > * Add Geert's R-b tag on patch 1 in v4.
> > * Add child nodes in the example MSI bus node of the MSI bus dt-binding. (Krzysztof)
> > * Resend v4 to imply this series is based on v6.0-rc1 so that there are not any
> >   dependencies for the MSI bus dt-binding. (Rob)
> > * Resend v4 based on v6.1-rc1. (Greg)
> > * Add Rob's R-b tag on patch 2 in v4.
> > 
> > v2->v3:
> > * Add a pattern property to allow child nodes in the MSI bus dt-binding. (Rob)
> > 
> > v1->v2:
> > Address Krzysztof's comments on patch 3:
> > * Add a select to explicitly select the MSI bus dt-binding.
> > * List 'simple-pm-bus' explicitly as one item of compatible strings.
> > * Require compatible and reg properties.
> > * Put reg property just after compatible property in example.
> > 
> > Liu Ying (2):
> >   drivers: bus: simple-pm-bus: Use clocks
> >   dt-bindings: bus: Add Freescale i.MX8qxp pixel link MSI bus binding
> > 
> >  .../bus/fsl,imx8qxp-pixel-link-msi-bus.yaml   | 232 ++++++++++++++++++
> >  drivers/bus/simple-pm-bus.c                   |  48 ++++
> >  2 files changed, 280 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml
> 
> Gentle ping...
> 
> If there is no more comments on this series, can someone pick it up
> please?

I'll take it, thanks.

greg k-h
