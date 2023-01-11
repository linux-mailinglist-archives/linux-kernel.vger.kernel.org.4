Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8FE665811
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjAKJt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239134AbjAKJtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:49:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF89E24F
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:47:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E41061B60
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 09:47:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E447C433D2;
        Wed, 11 Jan 2023 09:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673430476;
        bh=NRZQ78SMvO0fRJpsqUuHZCOMRrujjtVMkMIae33/L1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M1QbBTa37RlMou78S+K3VcDcgcLRdcoTeeTxp7IqGeFX0g7bgepBOyD1rJ86KQcg/
         8V/wZ64xLZ0Sgy3Z3pcEHm+/3/QQNjgqQ719rbJtEhklnvOo51ssSA/IfM6Z2zuQih
         73IEbXo3no4D82CC8wJufVe61DCXO6IogEuy3tBE=
Date:   Wed, 11 Jan 2023 10:47:54 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Won Chung <wonchung@google.com>
Subject: Re: [PATCH 5/5] driver core: device_get_devnode() should take a
 const *
Message-ID: <Y76FypOBJchJEsWM@kroah.com>
References: <20221123122523.1332370-1-gregkh@linuxfoundation.org>
 <20221123122523.1332370-5-gregkh@linuxfoundation.org>
 <Y34h5QBMTxEn/lzC@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y34h5QBMTxEn/lzC@smile.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 03:36:37PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 23, 2022 at 01:25:23PM +0100, Greg Kroah-Hartman wrote:
> > device_get_devnode() should take a constant * to struct device as it
> > does not modify it in any way, so modify the function definition to do
> > this and move it out of device.h as it does not need to be exposed to
> > the whole kernel tree.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> (see one nit-pick below)
> 
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Won Chung <wonchung@google.com>
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/base/base.h    | 2 ++
> >  drivers/base/core.c    | 2 +-
> >  include/linux/device.h | 2 --
> >  3 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/base/base.h b/drivers/base/base.h
> > index 7d4803c03d3e..a8a119c36bdc 100644
> > --- a/drivers/base/base.h
> > +++ b/drivers/base/base.h
> > @@ -158,6 +158,8 @@ extern void device_block_probing(void);
> >  extern void device_unblock_probing(void);
> >  extern void deferred_probe_extend_timeout(void);
> >  extern void driver_deferred_probe_trigger(void);
> 
> I would put a blank line here if the below doesn't belong to the deferral probe
> routines.

This whole .h file needs to be cleaned up and made nicer (the externs
show it's age), so I'll just leave this as-is and when all of the rework
is done reorginize it.

thanks for the review!

greg k-h
