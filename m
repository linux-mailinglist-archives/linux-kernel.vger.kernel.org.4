Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B7C6D3F03
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 10:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjDCIcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 04:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbjDCIca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:32:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7C9524D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 01:32:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 978A161633
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 08:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF8EC433D2;
        Mon,  3 Apr 2023 08:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680510743;
        bh=sU8bXmwTk2RS7zLLyrZOKwV1vzQHYYZlV0f4wQU4Xlw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L2iHxjeXsyhhjl8NfcneqxqreyNX/YJG3n6ZKYkdI8krSIXnbid0bvcqEzfhLGg+o
         0SBmWLr99z6jmj6CB9W250CRT7Nx9KP6GzLK6zekiGxnszAk8ci0REw+tFb9WE5cvU
         zerdv1w0s/oUvZfHIKxIyF6vDojEeu4Zn0b1+olbPeuJG3ClB3buf1Xb9YiIoZBodD
         mIbocCyHLXXzy+iT1afB185ehB6wh2XwApO0wxoOeij98cHGyIFgDwYReZr21rTG2k
         pZGxw6HF/cvBpGfhDvlWJw7nfLwVXQCkEs+EMSIBo1ZJcv3YRKi9hDmGA3W7NzFqcb
         J3oyI1vgxuyRg==
Date:   Mon, 3 Apr 2023 10:32:18 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: gic700 shareability question
Message-ID: <ZCqPEjxDmI0/kruD@lpieralisi>
References: <DU0PR04MB9417388F9BDD73080294FA8E88889@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <868rfdw797.wl-maz@kernel.org>
 <DU0PR04MB9417FCF524FA0BB9808B4E8088929@DU0PR04MB9417.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB9417FCF524FA0BB9808B4E8088929@DU0PR04MB9417.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 01:36:31AM +0000, Peng Fan wrote:
> Hi Marc,
> 
> > Subject: Re: gic700 shareability question
> > 
> > + Lorenzo
> > 
> > On Tue, 28 Mar 2023 13:48:19 +0100,
> > Peng Fan <peng.fan@nxp.com> wrote:
> > >
> > > Hi Marc,
> > >
> > > We have an SoC that use GIC-700, but not support shareability,
> > 
> > Define this. The IP does support shareability, but your integration doesn't?
> > 
> > > Currently I just hack the code as below. Do you think it is feasible
> > > to add firmware bindings such that these can be used to define the
> > > correct shareability/cacheability instead of relying on the
> > > programmability of the CBASER register?
> > >
> > > Saying with "broken-shareability", we just clear all the shareability
> > > settings.
> > 
> > This is the same thing as the Rockchip crap, so you are in good company.
> > 
> > I've repeatedly stated that this needs to be handled:
> > 
> > - either by describing the full system topology and describe what is
> >   in the same inner-shareable domain as the CPUs, which needs to
> >   encompass both DT and ACPI (starting with DT seems reasonable),
> > 
> 
> We will give a look on this. But honestly not have a good idea on how.

It is a longer term fix for the issue, we are looking into this.

> > - or as a SoC specific erratum, but not as a general "sh*t happened"
> >   property.
> 
> I will ask the hardware team to create an errata.
> > 
> > AFAIK, Lorenzo is looking into this.
> 
> Lorenzo, are you working on this? 

Yes it is being worked on, that does not prevent though an errata
workaround to be applied, firmware bindings definitions can take
a while to sort out.

Lorenzo
