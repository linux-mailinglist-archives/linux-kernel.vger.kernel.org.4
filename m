Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543926374CA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 10:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiKXJIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 04:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiKXJIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 04:08:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFAA2F3B5;
        Thu, 24 Nov 2022 01:08:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A78A61F33;
        Thu, 24 Nov 2022 09:08:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25BDFC433D6;
        Thu, 24 Nov 2022 09:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669280883;
        bh=2WnIY4IxIYwOJ87ZP/pew3yEAv4AkAoneo9ZJ8qUM+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ctr1iFw3IgRvtx/aaNV5Q+LEj9D1ZrOfmtmowfonhUyQX6yIYjC/GyTZmm5RcmQ9F
         b2BAhbktTYDWN5jj0oMd73/uSarvbr+Hv/SMn4yiZWpw9v4vdHlllmpBA9e7FnXdWv
         2LnAcCXuOnpECfQ0rvV8MGg9W0rV+HCq5Bat5/4Y=
Date:   Thu, 24 Nov 2022 10:08:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Albert Wang <albertccwang@google.com>
Cc:     mathias.nyman@intel.com, badhri@google.com, howardyen@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 3/3] usb: host: add the xhci offload hooks
 implementations
Message-ID: <Y380cMKIUJfP7Ya3@kroah.com>
References: <20221110080006.3563429-1-albertccwang@google.com>
 <20221110080006.3563429-4-albertccwang@google.com>
 <Y2yzg2v2AL6MsKvy@kroah.com>
 <CANqn-rj++p_rSkZxa5rpRXQ-9or-_18VzaE_M1vjq4aVNsrAKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANqn-rj++p_rSkZxa5rpRXQ-9or-_18VzaE_M1vjq4aVNsrAKg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 02:47:22PM +0800, Albert Wang wrote:
> > > +/*
> > > + * This is the driver call to co-processor for offload operations.
> > > + */
> > > +int offload_driver_call(enum usb_offload_msg msg, void *ptr)
> > > +{
> > > +     enum usb_offload_msg offload_msg;
> > > +     void *argptr;
> > > +
> > > +     offload_msg = msg;
> > > +     argptr = ptr;
> >
> > Don't just silence compiler warnings for no reason.
> >
> > Again, this does not actually do anything at all.  So how can we accept
> > this code?
> >
> 
> This is the driver call to our co-processor which is a specific
> hardware, so I don't submit it
> and make it silent here.

"specific hardware" is what Linux is all about!  Please submit your
actual drivers for this hardware, otherwise there is no way we can even
review properly this type of code, let alone accept it.

You all know this in great detail, I've been saying this for many years
now.  It is very frustrating on my end to constantly have to reject this
type of change all the time.

What would you do if you were on the reviewer's side?  Would you accept
this type of submission after constantly saying "I will only accept this
if you do X" and you get another patch that does NOT do "X"?

> We define and use those hook apis in the common xhci driver to offload
> some memory
> manipulation to a co-processor. So these apis will be executed to
> allocate or free memory,
> like dcbaa, transfer ring, in the co-processor memory space when
> offlooffload_driver_callad enabled. The file,
> xhci-offload-impl.c, shows how we use those xHCI hook apis for the
> offload implementation.
> 
> Here is the flow diagram:
> xHCI common driver        xHCI offload implement driver
> co-processor driver
> hooks
>                     offload_driver_call()
> ----------------------------
> ----------------------------------------
> --------------------------------------------------------------
> offload_init                         usb_audio_offload_init
> offload_cleanup                 usb_audio_offload_cleanup
> is_offload_enabled             is_offload_enabled
> alloc_dcbaa                        alloc_dcbaa
>        offload_driver_call(SET_DCBAA_PTR, &dcbaa_ptr);
> 
>                        offload_driver_call(SETUP_DONE, NULL);
> free_dcbaa                         free_dcbaa
> alloc_transfer_ring             alloc_transfer_ring
>    offload_driver_call(SET_ISOC_TR_INFO, &tr_info);
> free_transfer_ring              free_transfer_ring
> usb_offload_skip_urb        offload_skip_urb


This does not make any sense, sorry.  Perhaps your lines got wrapped
incorrectly?

thanks,

greg k-h
