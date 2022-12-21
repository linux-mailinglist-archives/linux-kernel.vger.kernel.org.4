Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74946653532
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 18:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbiLUR3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 12:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234732AbiLUR20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 12:28:26 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 503E61AA27
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 09:28:21 -0800 (PST)
Received: (qmail 94764 invoked by uid 1000); 21 Dec 2022 12:28:20 -0500
Date:   Wed, 21 Dec 2022 12:28:20 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] USB: Improve usb_fill_* documentation
Message-ID: <Y6NCNLq3V4IqHp9E@rowland.harvard.edu>
References: <20221220-usb-dmadoc-v3-0-6009f4d27631@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220-usb-dmadoc-v3-0-6009f4d27631@chromium.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 11:15:14AM +0100, Ricardo Ribalda wrote:
> Document the transfer buffer requirement. That is, the buffer must be
> DMAble - otherwise data corruption might occur.
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
> USB: Improve usb_fill_* documentation
> 
> After trying to "cleanup" the uvc code, I was patiently explained about
> the requirements of the urb transfer buffers.
> 
> Lets make this explicit, so other developers do not make the same mistake.
> 
> To: Bagas Sanjaya <bagasdotme@gmail.com>
> To: Randy Dunlap <rdunlap@infradead.org>
> To: Alan Stern <stern@rowland.harvard.edu>
> To: Christoph Hellwig <hch@lst.de>
> To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
> Changes in v3:
> - Improve commit message. Thanks Bagas!
> - Improve field description. Thanks Alan!
> - Link to v2: https://lore.kernel.org/r/20221220-usb-dmadoc-v2-0-4dd4f198113e@chromium.org
> 
> Changes in v2:
> - s/allocatiing/allocating/ Thanks Randy
> - Link to v1: https://lore.kernel.org/r/20221220-usb-dmadoc-v1-0-28386d2eb6cd@chromium.org
> ---
>  include/linux/usb.h | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/usb.h b/include/linux/usb.h
> index 7d5325d47c45..06cde9ddca97 100644
> --- a/include/linux/usb.h
> +++ b/include/linux/usb.h
> @@ -1626,14 +1626,25 @@ struct urb {
>   * @urb: pointer to the urb to initialize.
>   * @dev: pointer to the struct usb_device for this urb.
>   * @pipe: the endpoint pipe
> - * @setup_packet: pointer to the setup_packet buffer
> - * @transfer_buffer: pointer to the transfer buffer
> + * @setup_packet: pointer to the setup_packet buffer. The buffer must be
> + *	suitable for DMA.
> + * @transfer_buffer: pointer to the transfer buffer. The buffer must be
> + *	suitable for DMA.
>   * @buffer_length: length of the transfer buffer
>   * @complete_fn: pointer to the usb_complete_t function
>   * @context: what to set the urb context to.
>   *
>   * Initializes a control urb with the proper information needed to submit
>   * it to a device.
> + *
> + * The transfer buffer and the setup_packet buffer will most likely be filled
> + * via DMA.

No, no!  The setup_packet buffer will never be filled via DMA -- it is 
_read_ via DMA.

The transfer buffer may be filled via DMA; it depends on the direction 
of the transfer.  For OUT transfers, the buffer is read via DMA; for IN 
transfers it is filled via DMA.

> The simplest way to get a buffer that can be DMAed to is
> + * allocating it via kmalloc() or equivalent, even for very small buffers.
> + * If the buffers are embedded in a bigger structure, there is a risk that
> + * the buffer itself, the previous field and/or the next field are corrupted
> + * due to cache incoherencies; or slowed down if they are evicted from the
> + * cache.
> + *
>   */
>  static inline void usb_fill_control_urb(struct urb *urb,
>  					struct usb_device *dev,
> @@ -1658,13 +1669,17 @@ static inline void usb_fill_control_urb(struct urb *urb,
>   * @urb: pointer to the urb to initialize.
>   * @dev: pointer to the struct usb_device for this urb.
>   * @pipe: the endpoint pipe
> - * @transfer_buffer: pointer to the transfer buffer
> + * @transfer_buffer: pointer to the transfer buffer. The buffer must be
> + *	suitable for DMA.
>   * @buffer_length: length of the transfer buffer
>   * @complete_fn: pointer to the usb_complete_t function
>   * @context: what to set the urb context to.
>   *
>   * Initializes a bulk urb with the proper information needed to submit it
>   * to a device.
> + *
> + * Please refer to usb_fill_control_urb() for a description of the
> + * requirements for transfer_buffer.

_This_ right here is the kerneldoc for usb_fill_control_urb()!  You 
should have written "Please refer to the kerneldoc for struct urb".

>   */
>  static inline void usb_fill_bulk_urb(struct urb *urb,
>  				     struct usb_device *dev,
> @@ -1687,7 +1702,8 @@ static inline void usb_fill_bulk_urb(struct urb *urb,
>   * @urb: pointer to the urb to initialize.
>   * @dev: pointer to the struct usb_device for this urb.
>   * @pipe: the endpoint pipe
> - * @transfer_buffer: pointer to the transfer buffer
> + * @transfer_buffer: pointer to the transfer buffer. The buffer must be
> + *	suitable for DMA.
>   * @buffer_length: length of the transfer buffer
>   * @complete_fn: pointer to the usb_complete_t function
>   * @context: what to set the urb context to.
> @@ -1697,6 +1713,9 @@ static inline void usb_fill_bulk_urb(struct urb *urb,
>   * Initializes a interrupt urb with the proper information needed to submit
>   * it to a device.
>   *
> + * Please refer to usb_fill_control_urb() for a description of the
> + * requirements for transfer_buffer.

Similar to the above.

> + *
>   * Note that High Speed and SuperSpeed(+) interrupt endpoints use a logarithmic
>   * encoding of the endpoint interval, and express polling intervals in
>   * microframes (eight per millisecond) rather than in frames (one per

Why didn't you also make the same change to usb_fill_int_urb()?

Alan Stern

> 
> ---
> base-commit: b6bb9676f2165d518b35ba3bea5f1fcfc0d969bf
> change-id: 20221220-usb-dmadoc-29384acebd48
> 
> Best regards,
> -- 
> Ricardo Ribalda <ribalda@chromium.org>
