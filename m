Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466DD673E8F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjASQVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjASQUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:20:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C9B8B310
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 08:20:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3888D61C7A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 16:20:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E406C433EF;
        Thu, 19 Jan 2023 16:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674145240;
        bh=sdmA22LowoabqFgg/n5kNnyh/+sK4rIh16rQ7LzY/qg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B7MeP0ZSKk8WMgyOcebkPQVspyaLlA6veo3pWWczOhW+pwRm3LaBx8JpiZjCYXEih
         wyCUDq/4mnIGMx3uB8k40OHoWhXHRU/qRVus3Bz3hZpJmtteFNTE0fIiZ6+trzyaop
         34PJDLrMj11CVhr+Y58UeFmz+aMwu9qnecywoGzs=
Date:   Thu, 19 Jan 2023 17:20:38 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Usyskin, Alexander" <alexander.usyskin@intel.com>
Cc:     "Winkler, Tomas" <tomas.winkler@intel.com>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [char-misc-next] mei: gsc_proxy: add gsc proxy driver
Message-ID: <Y8lt1gmo9smOMXD7@kroah.com>
References: <20221222220214.3688774-1-tomas.winkler@intel.com>
 <Y6VV5d/V4MKDz2Te@kroah.com>
 <CY5PR11MB6366515D2A965EEDEC77AF63EDF29@CY5PR11MB6366.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY5PR11MB6366515D2A965EEDEC77AF63EDF29@CY5PR11MB6366.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 11:46:36AM +0000, Usyskin, Alexander wrote:
> > 
> > Why a whole new subdirectory for a tiny 200 line file?
> > 
> All drivers for devices on mei bus have private subdirectory.
> This one just modelled on the existing examples.
> If you say that this is not a good thing - can put it in the main mei directory.

Put it in the main mei directory, no need to split things up for no good
reason.

> > > +static int mei_gsc_proxy_component_match(struct device *dev, int
> > subcomponent, void *data)
> > > +{
> > > +	struct device *base = data;
> > > +
> > > +	if (!dev || !dev->driver ||
> > > +	    strcmp(dev->driver->name, "i915") ||
> > 
> > I thought I had objected to this "let's poke around in a driver name for
> > a magic value" logic in the past.  How do you know this is always going
> > to work?
> 
> All components that serve Intel graphics integrated into PCH should check
> in their match that calling device is graphic card sitting on the same PCH.

And by looking at the driver name?  That does not work, sorry.  Get
access to the driver pointer please, that's the only way you know for
sure, right?  And even then you shouldn't be messing with things in a
device you have no control over (i.e. a driver pointer or name.)

> The code below checks that i915 pci device and mei pci device (grandparent of our device on mei bus)
> are children of the same parent, but there is no way to know if caller
> is, indeed, graphic device. Easiest way is to check well-known device river name.

Again, that's a big abuse of the driver model, please do not do that.

You need to rely on the fact that you will NOT be called unless your
parent is of the correct type.  That's all, no fancy layering violations
please.


> All i915 components doing this comparison.
> This is a simplified scheme of relations between devices here:
>            /--- MEI PCI --- MEI --- GSC_PROXY
> PCH ---
>            \--- GRAPHIC PCI --- I915
> > 
> > > +	    subcomponent != I915_COMPONENT_GSC_PROXY)
> > > +		return 0;
> > > +
> > > +	base = base->parent;
> > > +	if (!base) /* mei device */
> > > +		return 0;
> > 
> > How can a device not have a parent?
> 
> This one should be proxy device on mei bus, so parent should be there always, can drop this check.
> 
> > 
> > > +
> > > +	base = base->parent; /* pci device */
> > 
> > You don't know this is a pci device :(
> 
> This is more, like, note to explain on what level in above scheme we are now.
> It should be mei pci device for match to succeed.

Again, you can't know this and you should never poke around like this.
You don't control the parent of anything (hint, you just saved a
reference counted pointer without grabbing a reference count...)

Please don't abuse the driver model like this, it will cause long-term
problems for keeping this code alive and working properly.

thanks,

greg k-h
