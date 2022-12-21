Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3D0652F3E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 11:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbiLUKTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 05:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiLUKTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 05:19:33 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7455BFF0;
        Wed, 21 Dec 2022 02:19:32 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7BD9BFB;
        Wed, 21 Dec 2022 11:19:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671617970;
        bh=4tVRLsFsteeUnfyjwQCv+uDaxwbCBf1JSypzdiC6Kno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oS4pimTQRQ2Ifs+muPC7s4eP0zqks1fjoa5KFiN5jWAYE2xvrLMWCK4LCnzbX0QrX
         7oWQnhU8k148KYMJzfPAuRAXqbsLF0Y2Q+rWbvZWvHKH+/XGoCXxyB3ycgg8FhwhkS
         QET0xRHCM2pE6a29q8LFDGojTtzuhUH9cTCIgZMA=
Date:   Wed, 21 Dec 2022 12:19:25 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] USB: Improve usb_fill_* documentation
Message-ID: <Y6LdrdQ0CDRqkTfh@pendragon.ideasonboard.com>
References: <20221220-usb-dmadoc-v3-0-6009f4d27631@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221220-usb-dmadoc-v3-0-6009f4d27631@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

Thank you for the patch.

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
> + * via DMA. The simplest way to get a buffer that can be DMAed to is
> + * allocating it via kmalloc() or equivalent, even for very small buffers.
> + * If the buffers are embedded in a bigger structure, there is a risk that
> + * the buffer itself, the previous field and/or the next field are corrupted

s/field/fields/g

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

I would drop "please". Same below.

With or without those changes,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> + * requirements for transfer_buffer.
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
> + *
>   * Note that High Speed and SuperSpeed(+) interrupt endpoints use a logarithmic
>   * encoding of the endpoint interval, and express polling intervals in
>   * microframes (eight per millisecond) rather than in frames (one per
> 
> ---
> base-commit: b6bb9676f2165d518b35ba3bea5f1fcfc0d969bf
> change-id: 20221220-usb-dmadoc-29384acebd48

-- 
Regards,

Laurent Pinchart
