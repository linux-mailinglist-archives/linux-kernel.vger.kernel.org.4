Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52081747CC9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjGEGGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjGEGGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:06:37 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4921700;
        Tue,  4 Jul 2023 23:06:27 -0700 (PDT)
X-GND-Sasl: herve.codina@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1688537186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O0C66mVI1nkOIpn+KxsHOUvDqjbprbMxbnSqsj7WItk=;
        b=HMzIJ0wIJQCx++SRoTVQ8bottUooWGrkC8U7ZbdBDWg4B+tUqyPdud6JH9otkTYx2SY5fR
        t1NQSyOEzJPRQQZvqLzSHQMzV+R/uoM4OOVbiiKYOkZ/nGpqrrmZVCcj4fbt4TjJ1AnkvT
        IrqpE/3YkiwUoF1JTiKaeXmwNTXWWbT0bIbEihf02ULF0r0KLhbj264ppLD/bndnr2ZLTR
        M4k/4p2K+3qLySn9vZ8R2zqGUElPkVybtLGVxq6YpF1ppekDo8CePFROKUoz5/SgrN3VnL
        pCnV4fnpHLFG4+CF5XYs+C8FMJdP4mepqUQJL1K5TwJf8dW+aTf7pPrk9vPIyw==
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C88C824000A;
        Wed,  5 Jul 2023 06:06:25 +0000 (UTC)
Date:   Wed, 5 Jul 2023 08:06:25 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Yu Hao <yhao016@ucr.edu>
Cc:     chunfeng.yun@mediatek.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: mtu3: Fix possible use-before-initialization bug
Message-ID: <20230705080625.02b2bac5@bootlin.com>
In-Reply-To: <CA+UBctDxfb6+70+hzuXJ-gwb65E0uoNzXYEhpJT92sXr2CE7OA@mail.gmail.com>
References: <CA+UBctDxfb6+70+hzuXJ-gwb65E0uoNzXYEhpJT92sXr2CE7OA@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yu,

On Tue, 4 Jul 2023 16:25:50 -0700
Yu Hao <yhao016@ucr.edu> wrote:

> The struct usb_ctrlrequest setup should be initialized in the function
> ep0_read_setup(mtu, &setup). However, inside that function,
> the variable count could be 0 and the struct usb_ctrlrequest setup
> is not initialized. But there is a read for setup.bRequestType.
> 
> Signed-off-by: Yu Hao <yhao016@ucr.edu>
> ---
>  drivers/usb/mtu3/mtu3_gadget_ep0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/mtu3/mtu3_gadget_ep0.c
> b/drivers/usb/mtu3/mtu3_gadget_ep0.c
> index e4fd1bb14a55..67034fa515d0 100644
> --- a/drivers/usb/mtu3/mtu3_gadget_ep0.c
> +++ b/drivers/usb/mtu3/mtu3_gadget_ep0.c
> @@ -638,7 +638,7 @@ static int ep0_handle_setup(struct mtu3 *mtu)
>  __releases(mtu->lock)
>  __acquires(mtu->lock)
>  {
> -   struct usb_ctrlrequest setup;
> +   struct usb_ctrlrequest setup = {};
>     struct mtu3_request *mreq;
>     int handled = 0;
> 

Looks strange to me because, if ep0_read_setup() cannot read the setup data
why don't we simply abort the operation ?

With setup = {}, the following test is true:
  if ((setup.bRequestType & USB_TYPE_MASK) == USB_TYPE_STANDARD)
	handled = handle_standard_request(mtu, &setup);

handle_standard_request() is called and supposes an USB_REQ_GET_STATUS
(0x00) request:
   case USB_REQ_GET_STATUS:
	handled = ep0_get_status(mtu, setup);
	break;

Then ep0_get_status() supposes USB_RECIP_DEVICE (0x00) and performs some
operation sending the data related to the GET_STATUS.

All of these are not correct as the setup data that triggered this sequence
was never received.
Aborting the operation if ep0_read_setup() cannot read the setup data seems
better to me.

Best regards,
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
