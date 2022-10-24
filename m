Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3D5609B26
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 09:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiJXHR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 03:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiJXHRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 03:17:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11A95A2EA;
        Mon, 24 Oct 2022 00:17:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB3B6B80EAD;
        Mon, 24 Oct 2022 07:17:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2BBC433C1;
        Mon, 24 Oct 2022 07:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666595861;
        bh=kM1xMUTbyl3y160w/RVkDmDbg/102z61jhspTGGgtQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S/Db/nPA4SeUWmsSb/0kiCL14TtRdtd+ANynin/a3A5nsQAcFBUDMpyNd+/3kzito
         1hAZhYbd8vj5Be6C5WifpG2c/mCrubpLmbJpsyM5FI4wWPDPGRVkcPHvueR+MpntRy
         SAcWFv1zYqzps40ER/WRn0GWk7soPB8O/OoM/8WHZm2w+IvdU0o75twisH9s7oxswl
         g002yuZLVoK+X6TTr0S8DuVx/eH0x+pI2DUTJa3FAf7AMYHuCiEExvTXvG1fTjsyLL
         yGQB4xLRa4CAkOpPNH8/2o8J942/h4hCh6A8iqCxRU8oBNgD8d61LZ2048qCek+ej8
         Ca7nvQZwD48MA==
Date:   Mon, 24 Oct 2022 08:17:36 +0100
From:   Lee Jones <lee@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/1] usb: gadget: f_hid: Conduct proper refcounting on
 shared f_hidg pointer
Message-ID: <Y1Y8ENck93mRY9WK@google.com>
References: <20221017112737.230772-1-lee@kernel.org>
 <Y1PnoMvDmZMqXScw@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y1PnoMvDmZMqXScw@kroah.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Oct 2022, Greg Kroah-Hartman wrote:

> On Mon, Oct 17, 2022 at 12:27:37PM +0100, Lee Jones wrote:
> > A pointer to the main HID gadget struct (*f_hidg) is shared with the
> > character device handing (read() and write(), etc support) on open().
> > However external references are presently not tracked.  This could
> > easily lead to some unsavoury behaviour if gadget support is disabled
> > / disconnected.  Keeping track of the refcount ensures that resources
> > are only freed *after* they are no longer in use.
> > 
> > Cc: Felipe Balbi <balbi@kernel.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: linux-usb@vger.kernel.org
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > ---
> >  drivers/usb/gadget/function/f_hid.c | 37 +++++++++++++++++++++--------
> >  1 file changed, 27 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
> > index ca0a7d9eaa34e..79d4ee8a5647f 100644
> > --- a/drivers/usb/gadget/function/f_hid.c
> > +++ b/drivers/usb/gadget/function/f_hid.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/module.h>
> >  #include <linux/hid.h>
> >  #include <linux/idr.h>
> > +#include <linux/kref.h>
> >  #include <linux/cdev.h>
> >  #include <linux/mutex.h>
> >  #include <linux/poll.h>
> > @@ -77,6 +78,8 @@ struct f_hidg {
> >  
> >  	struct usb_ep			*in_ep;
> >  	struct usb_ep			*out_ep;
> > +
> > +	struct kref			refcount;
> >  };
> 
> While at first glance, it seems that f_hidg is not reference counted, it
> really is, with the embedded "struct cdev" a few lines above this.
> 
> That is the reference count that should control the lifecycle of this
> object, not another reference here in the "outer layer" structure.
> 
> But, the cdev api is tricky and messy and not really set up to control
> the lifecycle of objects it is embedded in.  There have been attempts in
> the past to handle this with things like the cdev_device_del() function,
> but that's not going to work here for you as you don't have a real
> struct device in f_hidg (heck, there's no device pointer in there, which
> is a different issue...)
> 
> But, you can just rip the cdev out, and make it a pointer to a cdev, and
> then you will have a better chance at getting the reference counting
> correct here.  Yes, that will be 3 different reference counted objects
> all interacting at once, but hopefully it's a bit more sane.  Try
> cleaning things up that way and allocate the cdev with a call to
> cdev_alloc() right before the cdev_init() call in this file, and then it
> might work better.

I'll look into it, thanks.

> Yeah, the cdev api is really messy, it's been on my todo list for 20+
> years now to clean it up :(
> 
> Also, one other thing, semi-related to this change:
> 
> > +static void hidg_free_resources(struct kref *ref)
> > +{
> > +	struct f_hidg *hidg = container_of(ref, struct f_hidg, refcount);
> > +	struct f_hid_opts *opts = container_of(hidg->func.fi, struct f_hid_opts, func_inst);
> > +
> > +	mutex_lock(&opts->lock);
> > +	kfree(hidg->report_desc);
> > +	kfree(hidg->set_report_buf);
> > +	kfree(hidg);
> > +	--opts->refcnt;
> 
> That's not a real reference count :(
> 
> Moving that to a kref would also be good.  Or it might just be able to
> be dropped entirely, I don't really understand what it's attempting to
> reference count at all here.

From my, perhaps limited, understanding, refcnt is not being used as a
reference counter.  Instead it's being used as a sort of mutual
exclusion replacement?  The Ops check refcnt before doing anything
useful and if it's found to be >0, they return -EBUSY.

-- 
Lee Jones [李琼斯]
