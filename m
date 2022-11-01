Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F7F614491
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 07:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiKAGQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 02:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiKAGQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 02:16:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5541181C;
        Mon, 31 Oct 2022 23:16:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 087936152C;
        Tue,  1 Nov 2022 06:16:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F7FC433D6;
        Tue,  1 Nov 2022 06:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667283365;
        bh=lufWgB5um/sNxdP6lEFeAgabE+Ij9VKyh7YPrmjuB8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MtcAPHXiZE9DrpUM8sWJXgElbCJyOW7RBR/YzbJH7BGRjqgMovwlXf7J4vUaj17Nx
         ZLmjVXm/Q56VbOHelTHfQEPaNdJoevkZvWX/1qbL+tMBgAziCbgC64XperIBtdK1GW
         6UTTXJHmOuB4jjgwi05F3Z4azz3RLSkOco63bzXA=
Date:   Tue, 1 Nov 2022 07:16:54 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Starke, Daniel" <daniel.starke@siemens.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] tty: n_gsm: add parameter negotiation support
Message-ID: <Y2C51txUYBGv53j+@kroah.com>
References: <20221024130114.2070-1-daniel.starke@siemens.com>
 <20221024130114.2070-3-daniel.starke@siemens.com>
 <Y1fQ3G1W8PUIrod9@kroah.com>
 <DB9PR10MB5881479C5BE3D2A97A7D354CE0379@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9PR10MB5881479C5BE3D2A97A7D354CE0379@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 01:26:50PM +0000, Starke, Daniel wrote:
> Thank you for your review.
> 
> > > +		pr_err("%s: unsupported frame type %d\n", __func__,
> > > +		       dlci->ftype);
> >
> > This needs to be dev_err(), right?
> 
> There is no place within this driver that uses dev_*() at the moment except
> for the timeout function of the network stack (gsm_mux_net_tx_timeout()).
> I do not mind either way, but I would prefer a consistent variant within
> this driver. Therefore, I suggest switching from pr_*() to dev_*() in a
> separate patch.

Yes, that's a good idea.

> > And why is it not just dev_dbg()/
> 
> I used pr_err() instead of pr_dbg() due to the fact that this mismatch will
> most likely make it impossible to use the n_gsm driver with the connected
> device as it stands. I am okay to replace it with pr_info() though.
> 
> > > +		pr_err("%s: unsupported adaption %d\n", __func__,
> > > +		       dlci->adaption);
> >
> > Again, dev_dbg()?
> >
> > Do not yet userspace, or external devices, spam kernel logs with
> > messages.
> 
> These are related to the user API. Therefore, I do not mind changing these
> to debug level.

Please do, userspace should not be able to spam kernel logs, bad things
can happen if that is possible.

> > And never use __func__ in a dev_dbg() call, it's there automatically.
> 
> I could not find a hint that __func__ is included in dev_dbg(). What is
> included is the subsystem name and the device name but not the function
> name within the driver according to include/linux/dev_printk.h. Other
> device drivers like usb/dwc2/core.c also include __func__ here. But it
> appears to be possible to automate this by re-defining dev_fmt().

You can dynamically add the function location at runtime when using
pr_dbg() or dev_dbg(), see the documentation.  So any addition of
__func__ in a string for those calls is just wrong and should be
removed.

Can you fix this up to not spam the log for errors (move to debug
level), and resend the updated series?

thanks,

greg k-h
