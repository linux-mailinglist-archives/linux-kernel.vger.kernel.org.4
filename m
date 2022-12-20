Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82494652998
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 00:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbiLTXGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 18:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiLTXGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 18:06:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D043BF;
        Tue, 20 Dec 2022 15:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=/lhPmtQgl/IJPDhv6NELGDuHRTBu3I0donBbwWDLdR0=; b=D0hceBkT1mABNuA0N726RESH8f
        7gs47AzhPRyEEjy3FokVywzS95ehk4c63TaIyJfuttSfJJRmrgLrnW3+p8GQD5Z8ljXYbuKPnuoCK
        Nvz8Z3zIB3dUVbygEvyiI9+sWoYRa+l16n6eplmcZfc+q8HlSwngOA5G5IHEEeW30rwkAO4jTY7fZ
        Rya+w2ZhdXTIcvfz+Y8fSmc+lLFlZF4Tx9oTgoinDQm2Z3qFV+IvBXOQjlWXgCi9HyYohUHT4q0tj
        Qpv+huA4Lri7C0GK/cQoIjuR9GzJZov7PIxbexSKiqEiN9AWGiyBKeiSnRbCyeU5R6PsMQds/WBg8
        tH5FAMjw==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p7lgT-005ep6-0H; Tue, 20 Dec 2022 23:06:05 +0000
Message-ID: <e436ead2-ce8e-6d66-a123-0a6a2d344ffb@infradead.org>
Date:   Tue, 20 Dec 2022 15:06:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] USB: Improve usb_fill_* documentation
Content-Language: en-US
To:     Ricardo Ribalda <ribalda@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Christoph Hellwig <hch@lst.de>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221220-usb-dmadoc-v1-0-28386d2eb6cd@chromium.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20221220-usb-dmadoc-v1-0-28386d2eb6cd@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/20/22 14:52, Ricardo Ribalda wrote:
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
> To: Alan Stern <stern@rowland.harvard.edu>
> To: Christoph Hellwig <hch@lst.de>
> To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  include/linux/usb.h | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/usb.h b/include/linux/usb.h
> index 7d5325d47c45..033ca69b563d 100644
> --- a/include/linux/usb.h
> +++ b/include/linux/usb.h
> @@ -1627,13 +1627,20 @@ struct urb {
>   * @dev: pointer to the struct usb_device for this urb.
>   * @pipe: the endpoint pipe
>   * @setup_packet: pointer to the setup_packet buffer
> - * @transfer_buffer: pointer to the transfer buffer
> + * @transfer_buffer: pointer to the transfer buffer. Must be suitable for DMA.
>   * @buffer_length: length of the transfer buffer
>   * @complete_fn: pointer to the usb_complete_t function
>   * @context: what to set the urb context to.
>   *
>   * Initializes a control urb with the proper information needed to submit
>   * it to a device.
> + *
> + * The transfer buffer might be filled via DMA. The simplest way to get
> + * a buffer that can be DMAed to, is allocatiing it via kmalloc() or

                                        allocating

> + * equivalent, even for very small buffers. If transfer_buffer is embedded
> + * in a bigger structure, there is a risk that the previous and following
> + * fields are left in a corrupted state by the DMA engine, if the platform
> + * is not cache coherent.
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
> + * a buffer that can be DMAed to, is allocatiing it via kmalloc() or

                                        allocating

> + * equivalent, even for very small buffers. If transfer_buffer is embedded
> + * in a bigger structure, there is a risk that the previous and following
> + * fields are left in a corrupted state by the DMA engine, if the platform
> + * is not cache coherent.
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
> + * a buffer that can be DMAed to, is allocatiing it via kmalloc() or

                                        allocating

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

Thanks.

-- 
~Randy
