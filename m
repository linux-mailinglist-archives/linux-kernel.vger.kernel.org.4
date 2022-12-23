Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E89654CB9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 08:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbiLWHRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 02:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235811AbiLWHRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 02:17:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B57E30557
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 23:17:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EAB84B81DA4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 07:16:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E71CC433EF;
        Fri, 23 Dec 2022 07:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671779817;
        bh=X13lWuv2SlZa1/dgifDIEt9tgbR6cj4+B1AtJTkCbH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zMkkbxfdjmC18+D3blIixv9ETqfqt123pr0n/2EEaX0I0a0ClHtMAz1MehIN3aX1i
         uFtjCMRbo0duWc6bu6/F90Y7MifQHySEKYvKmvjfoJ/lm/SRxHjSW2RKIqunSTkex7
         1Ns3qEomgPpHOiSZTJXQPBFv9spVNSkrQocS//+A=
Date:   Fri, 23 Dec 2022 08:16:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [char-misc-next] mei: gsc_proxy: add gsc proxy driver
Message-ID: <Y6VV5d/V4MKDz2Te@kroah.com>
References: <20221222220214.3688774-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222220214.3688774-1-tomas.winkler@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 12:02:14AM +0200, Tomas Winkler wrote:
> From: Alexander Usyskin <alexander.usyskin@intel.com>
> 
> Add GSC proxy driver. It to allows messaging between GSC component
> on Intel on board graphics card and CSME device.
> GSC and MEI
> 
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
>  MAINTAINERS                                |   2 +-
>  drivers/misc/mei/Kconfig                   |   1 +
>  drivers/misc/mei/Makefile                  |   1 +
>  drivers/misc/mei/gsc_proxy/Kconfig         |  13 ++
>  drivers/misc/mei/gsc_proxy/Makefile        |   7 +
>  drivers/misc/mei/gsc_proxy/mei_gsc_proxy.c | 205 +++++++++++++++++++++

Why a whole new subdirectory for a tiny 200 line file?

> +static int mei_gsc_proxy_component_match(struct device *dev, int subcomponent, void *data)
> +{
> +	struct device *base = data;
> +
> +	if (!dev || !dev->driver ||
> +	    strcmp(dev->driver->name, "i915") ||

I thought I had objected to this "let's poke around in a driver name for
a magic value" logic in the past.  How do you know this is always going
to work?

> +	    subcomponent != I915_COMPONENT_GSC_PROXY)
> +		return 0;
> +
> +	base = base->parent;
> +	if (!base) /* mei device */
> +		return 0;

How can a device not have a parent?

> +
> +	base = base->parent; /* pci device */

You don't know this is a pci device :(

If it is, then pass in a REAL pci device structure please.

> +
> +	dev = dev->parent;
> +	return (base && dev && dev == base);

I do not understand this statement at all, what are you doing here?

confused,

greg k-h
