Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA34622EA1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbiKIPEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbiKIPDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:03:55 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 78AFCFD17
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 07:03:53 -0800 (PST)
Received: (qmail 511314 invoked by uid 1000); 9 Nov 2022 10:03:52 -0500
Date:   Wed, 9 Nov 2022 10:03:52 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] USB: gadget: dummy_hcd: switch char * to u8 *
Message-ID: <Y2vBWJOgEBDn0NzU@rowland.harvard.edu>
References: <20221109084450.2181848-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109084450.2181848-1-gregkh@linuxfoundation.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 09:44:50AM +0100, Greg Kroah-Hartman wrote:
> The function handle_control_request() casts the urb buffer to a char *,
> and then treats it like a unsigned char buffer when assigning data to
> it.  On some architectures, "char" is really signed, so let's just
> properly set this pointer to a u8 to take away any potential problems as
> that's what is really wanted here.
> 
> Use put_unaligned_le16() to copy the full 16bits into the buffer,
> it's not a problem just yet as only 7 bits are being used here, but this
> protects us when/if the USB spec changes in the future to define more of
> these bits.
> 
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Jakob Koschel <jakobkoschel@gmail.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> v2: - use put_unaligned_le16() on Linus's recommendation as a simpler and
>       more obvious way to describe the data being copied here.
>     - update device: comment based on Alan's review
> 
>  drivers/usb/gadget/udc/dummy_hcd.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
> index 899ac9f9c279..7c59c20c8623 100644
> --- a/drivers/usb/gadget/udc/dummy_hcd.c
> +++ b/drivers/usb/gadget/udc/dummy_hcd.c
> @@ -1740,13 +1740,13 @@ static int handle_control_request(struct dummy_hcd *dum_hcd, struct urb *urb,
>  		if (setup->bRequestType == Dev_InRequest
>  				|| setup->bRequestType == Intf_InRequest
>  				|| setup->bRequestType == Ep_InRequest) {
> -			char *buf;
> +			u8 *buf;
>  			/*
> -			 * device: remote wakeup, selfpowered
> +			 * device: remote wakeup, selfpowered, LTM, U1, or U2
>  			 * interface: nothing
>  			 * endpoint: halt
>  			 */
> -			buf = (char *)urb->transfer_buffer;
> +			buf = urb->transfer_buffer;
>  			if (urb->transfer_buffer_length > 0) {
>  				if (setup->bRequestType == Ep_InRequest) {
>  					ep2 = find_endpoint(dum, w_index);
> @@ -1755,10 +1755,9 @@ static int handle_control_request(struct dummy_hcd *dum_hcd, struct urb *urb,
>  						break;
>  					}
>  					buf[0] = ep2->halted;
> -				} else if (setup->bRequestType ==
> -					   Dev_InRequest) {
> -					buf[0] = (u8)dum->devstatus;
> -				} else
> +				} else if (setup->bRequestType == Dev_InRequest)
> +					put_unaligned_le16(dum->devstatus, buf);

This is tempting but wrong.  At this point we haven't checked how big 
the transfer_buffer is; if it is only one byte long then this call will 
overflow the buffer.  Notice the "if" statement three lines below.

Alan Stern

> +				else
>  					buf[0] = 0;
>  			}
>  			if (urb->transfer_buffer_length > 1)
> -- 
> 2.38.1
> 
