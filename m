Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B970652B96
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 03:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbiLUCrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 21:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbiLUCra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 21:47:30 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id D9DD11D0EC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 18:47:28 -0800 (PST)
Received: (qmail 75129 invoked by uid 1000); 20 Dec 2022 21:47:28 -0500
Date:   Tue, 20 Dec 2022 21:47:28 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] USB: Improve usb_fill_* documentation
Message-ID: <Y6JzwChVdOIx1vPD@rowland.harvard.edu>
References: <20221220-usb-dmadoc-v2-0-4dd4f198113e@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220-usb-dmadoc-v2-0-4dd4f198113e@chromium.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 12:13:08AM +0100, Ricardo Ribalda wrote:
> Make the developer aware of the requirements of transfer buffer.
> 
> The buffer must be DMAble, if the developer uses an invalid buffer, data
> corruption might happen.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
> USB: Improve usb_fill_* documentation
> 
> After trying to "cleanup" the uvc code, I was patiently explained about
> the requirements of the urb transfer buffers.
> 
> Lets make this explicit, so other developers do not make the same mistake.
> 
> To: Randy Dunlap <rdunlap@infradead.org>
> To: Alan Stern <stern@rowland.harvard.edu>
> To: Christoph Hellwig <hch@lst.de>
> To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
> Changes in v2:
> - s/allocatiing/allocating/ Thanks Randy
> - Link to v1: https://lore.kernel.org/r/20221220-usb-dmadoc-v1-0-28386d2eb6cd@chromium.org
> ---
>  include/linux/usb.h | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/usb.h b/include/linux/usb.h
> index 7d5325d47c45..1144ef6e4151 100644
> --- a/include/linux/usb.h
> +++ b/include/linux/usb.h
> @@ -1627,13 +1627,20 @@ struct urb {
>   * @dev: pointer to the struct usb_device for this urb.
>   * @pipe: the endpoint pipe
>   * @setup_packet: pointer to the setup_packet buffer
> - * @transfer_buffer: pointer to the transfer buffer
> + * @transfer_buffer: pointer to the transfer buffer. Must be suitable for DMA.

For control URBs, the setup_packet must also be suitable for DMA.  It's 
a little less critical, though, because the setup_packet is only used 
for DMA out, never DMA in.

>   * @buffer_length: length of the transfer buffer
>   * @complete_fn: pointer to the usb_complete_t function
>   * @context: what to set the urb context to.
>   *
>   * Initializes a control urb with the proper information needed to submit
>   * it to a device.
> + *
> + * The transfer buffer might be filled via DMA.

"might" is too weak.  For nonzero-length IN transfers, the transfer 
buffer is certain to be filled via DMA (except for the very few cases of 
USB controller hardware using PIO instead of DMA).

> The simplest way to get
> + * a buffer that can be DMAed to, is allocating it via kmalloc() or
> + * equivalent, even for very small buffers. If transfer_buffer is embedded
> + * in a bigger structure, there is a risk that the previous and following
> + * fields are left in a corrupted state by the DMA engine, if the platform
> + * is not cache coherent.

There is also a risk that data read from the device is corrupted.  And 
accesses of the surrounding fields may well be slowed down because the 
DMA mapping evicts them from the cache.

>   */
>  static inline void usb_fill_control_urb(struct urb *urb,
>  					struct usb_device *dev,
> @@ -1658,13 +1665,20 @@ static inline void usb_fill_control_urb(struct urb *urb,
>   * @urb: pointer to the urb to initialize.
>   * @dev: pointer to the struct usb_device for this urb.
>   * @pipe: the endpoint pipe
> - * @transfer_buffer: pointer to the transfer buffer
> + * @transfer_buffer: pointer to the transfer buffer. Must be suitable for DMA.
>   * @buffer_length: length of the transfer buffer
>   * @complete_fn: pointer to the usb_complete_t function
>   * @context: what to set the urb context to.
>   *
>   * Initializes a bulk urb with the proper information needed to submit it
>   * to a device.
> + *
> + * The transfer buffer might be filled via DMA. The simplest way to get
> + * a buffer that can be DMAed to, is allocating it via kmalloc() or
> + * equivalent, even for very small buffers. If transfer_buffer is embedded
> + * in a bigger structure, there is a risk that the previous and following
> + * fields are left in a corrupted state by the DMA engine, if the platform
> + * is not cache coherent.

I see no point in repeating exactly the same text multiple times.  
Instead, just put a reference to the original occurrence of this 
warning.

Alan Stern

>   */
>  static inline void usb_fill_bulk_urb(struct urb *urb,
>  				     struct usb_device *dev,
> @@ -1687,7 +1701,7 @@ static inline void usb_fill_bulk_urb(struct urb *urb,
>   * @urb: pointer to the urb to initialize.
>   * @dev: pointer to the struct usb_device for this urb.
>   * @pipe: the endpoint pipe
> - * @transfer_buffer: pointer to the transfer buffer
> + * @transfer_buffer: pointer to the transfer buffer. Must be suitable for DMA.
>   * @buffer_length: length of the transfer buffer
>   * @complete_fn: pointer to the usb_complete_t function
>   * @context: what to set the urb context to.
> @@ -1697,6 +1711,13 @@ static inline void usb_fill_bulk_urb(struct urb *urb,
>   * Initializes a interrupt urb with the proper information needed to submit
>   * it to a device.
>   *
> + * The transfer buffer might be filled via DMA. The simplest way to get
> + * a buffer that can be DMAed to, is allocating it via kmalloc() or
> + * equivalent, even for very small buffers. If transfer_buffer is embedded
> + * in a bigger structure, there is a risk that the previous and following
> + * fields are left in a corrupted state by the DMA engine, if the platform
> + * is not cache coherent.
> + *
>   * Note that High Speed and SuperSpeed(+) interrupt endpoints use a logarithmic
>   * encoding of the endpoint interval, and express polling intervals in
>   * microframes (eight per millisecond) rather than in frames (one per
> 
> ---
> base-commit: b6bb9676f2165d518b35ba3bea5f1fcfc0d969bf
> change-id: 20221220-usb-dmadoc-29384acebd48
> 
> Best regards,
> -- 
> Ricardo Ribalda <ribalda@chromium.org>
