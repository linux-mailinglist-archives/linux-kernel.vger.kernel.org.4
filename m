Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7071B6D6C08
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbjDDS3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236432AbjDDS3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:29:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD418A66;
        Tue,  4 Apr 2023 11:26:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CD5363551;
        Tue,  4 Apr 2023 18:26:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7DBC433D2;
        Tue,  4 Apr 2023 18:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680632759;
        bh=AERzV+I0kHCiQYU5gW6WzqRfRD82762Wm/mkt70YhEw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aYaeXoSUft0lZ4hauu2QMhqSKx7/WztqSy8guwEuqUUUwDn9rISfpGHcsZCmco5TH
         e0pI6kB196vhPfK1NtukpQdxaAklgn9Dlcji9DTFm+b4d2Qb1C5vEKRmz3rOJ2NkUa
         xqogHb/OY7XDN1bLA6buoVAoKfbFDS87fnnfcplg=
Date:   Tue, 4 Apr 2023 20:25:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Cc:     heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: intel_pmc_mux: Expose IOM port status to
 debugfs
Message-ID: <2023040455-varmint-pagan-95d4@gregkh>
References: <20230330104821.773053-1-rajat.khandelwal@linux.intel.com>
 <ZCVsH2KkfcMA86hJ@kroah.com>
 <c82c6577-a363-241b-ffd6-f5c4c9ed838d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c82c6577-a363-241b-ffd6-f5c4c9ed838d@linux.intel.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 10:48:38PM +0530, Rajat Khandelwal wrote:
> Hi,
> 
> On 3/30/2023 4:31 PM, Greg KH wrote:
> > On Thu, Mar 30, 2023 at 04:18:21PM +0530, Rajat Khandelwal wrote:
> > > IOM status has a crucial role during debugging to check the
> > > current state of the type-C port.
> > > There are ways to fetch the status, but all those require the
> > > IOM port status offset, which could change with platform.
> > > 
> > > Make a debugfs directory for intel_pmc_mux and expose the status
> > > under it per port basis.
> > > 
> > > Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
> > > Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > ---
> > >   drivers/usb/typec/mux/intel_pmc_mux.c | 44 +++++++++++++++++++++++++++
> > >   1 file changed, 44 insertions(+)
> > > 
> > > diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
> > > index 34e4188a40ff..c99d20888f5d 100644
> > > --- a/drivers/usb/typec/mux/intel_pmc_mux.c
> > > +++ b/drivers/usb/typec/mux/intel_pmc_mux.c
> > > @@ -15,6 +15,7 @@
> > >   #include <linux/usb/typec_mux.h>
> > >   #include <linux/usb/typec_dp.h>
> > >   #include <linux/usb/typec_tbt.h>
> > > +#include <linux/debugfs.h>
> > >   #include <asm/intel_scu_ipc.h>
> > > @@ -145,6 +146,8 @@ struct pmc_usb {
> > >   	u32 iom_port_status_offset;
> > >   };
> > > +static struct dentry *pmc_mux_debugfs_root;
> > Why not just look up the dentry and delete it when you want it with a
> > call to debugfs_lookup_and_remove() instead?  That way you don't have to
> > keep it around (hint, pass it back from your call to
> > pmc_mux_debugfs_init() or better yet, don't even have a
> > pmc_mux_debugfs_init() function as it only contains one line and is
> > only called in one place.
> > 
> > This will save you the storage space of this variable if debugfs is not
> > enabled in your kernel.  A small amount, yes, but it's nicer, right?
> 
> I see. Yes, though a small amount, you're anyways right.
> 
> 1. Though a single-line function, I explicitly defined it to make it more readable.
> ATM, maintaining a small different framework within the file for another function
> (debugfs) somehow presents a more 'organized' code to me, if that makes sense? :)

You are wrapping an abstraction in an abstraction, i.e. piling on layers
where they are not needed at all.  That's not normal for kernel code.

If I am reading the code, and see that function call, I then have to go
and find it and then see that it is making a debugfs call.  When
instead, if you just had the debugfs call, when reading the code, you
would instantly know what is happening and can keep on going in your
reading.

> 2. About the suggestion of not keeping the debugfs_root static throughout the
> execution, I can change it as per your suggestion, but I'd like to keep it this
> way, if that's ok? This way, it would fit nice in the future if more variables
> are to be added.

We write code for what we have today.  If it needs to change in the
future, great, we will change it then.  So no need to worry about that.

Anyway, your call, but I think you can make the code overall smaller
and simpler with my suggestions, but hey, try it out and prove me wrong!

thanks,

greg k-h
