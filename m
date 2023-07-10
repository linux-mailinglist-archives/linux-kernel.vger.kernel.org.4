Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BEB74CCE1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 08:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjGJG06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 02:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjGJG0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 02:26:13 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED13D1BF;
        Sun,  9 Jul 2023 23:26:01 -0700 (PDT)
X-GND-Sasl: herve.codina@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1688970360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=17ZTBQO+oBIkGul7D/WlB+X7l0VA0KwA6SIv/f89u7w=;
        b=pIXKjmxfNRP61MN4/M43OLwfOt2eCDwrovK9XTBHcMsO31DUfzfvU6suXBII6V3BYD44tR
        1mHUSXcarif+DmleFeC9TIxyD7nNl1T41VZjSwY7CXiuBrPAlN5Hh2AZurhW0lfoaIyaG5
        1xj9DgiPLk6f94v/WTAJotVjCsOM/bLTjoFOkYdiI7MGQh0PG2TadiZdbDX2vvcGjEVoMy
        Y6ydVdRi0Wl/yf0D0ZYMmrGNKOvbYzS6k7Hs5BRQ+B9VLx7sKjZaYgHKg7rFl3+2dErdzm
        67ihNd2LivbVVOQPKvRAjm1saYUzLjcHXhq8Y0FLBarhLR+/fRYqKqDr5sOzuA==
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D7416C0005;
        Mon, 10 Jul 2023 06:25:58 +0000 (UTC)
Date:   Mon, 10 Jul 2023 08:25:58 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Yu Hao <yhao016@ucr.edu>
Cc:     chunfeng.yun@mediatek.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: mtu3: Fix possible use-before-initialization bug
Message-ID: <20230710082558.2f82d607@bootlin.com>
In-Reply-To: <CA+UBctBqtSvyBWf9ZwKbecTrh9_6sCDm_TyU-ncb+6h5y19K5g@mail.gmail.com>
References: <CA+UBctDxfb6+70+hzuXJ-gwb65E0uoNzXYEhpJT92sXr2CE7OA@mail.gmail.com>
        <20230705080625.02b2bac5@bootlin.com>
        <CA+UBctBqtSvyBWf9ZwKbecTrh9_6sCDm_TyU-ncb+6h5y19K5g@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yu,

On Sun, 9 Jul 2023 17:48:15 -0700
Yu Hao <yhao016@ucr.edu> wrote:

> Hi Hervé,
> 
> Thanks for the comments. How about this patch?
> ---
>  drivers/usb/mtu3/mtu3_gadget_ep0.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/mtu3/mtu3_gadget_ep0.c
> b/drivers/usb/mtu3/mtu3_gadget_ep0.c
> index e4fd1bb14a55..af2884943c2a 100644
> --- a/drivers/usb/mtu3/mtu3_gadget_ep0.c
> +++ b/drivers/usb/mtu3/mtu3_gadget_ep0.c
> @@ -600,7 +600,7 @@ static void ep0_tx_state(struct mtu3 *mtu)
>         mtu3_readl(mtu->mac_base, U3D_EP0CSR));
>  }
> 
> -static void ep0_read_setup(struct mtu3 *mtu, struct usb_ctrlrequest *setup)
> +static int ep0_read_setup(struct mtu3 *mtu, struct usb_ctrlrequest *setup)
>  {
>     struct mtu3_request *mreq;
>     u32 count;
> @@ -608,6 +608,8 @@ static void ep0_read_setup(struct mtu3 *mtu,
> struct usb_ctrlrequest *setup)
> 
>     csr = mtu3_readl(mtu->mac_base, U3D_EP0CSR) & EP0_W1C_BITS;
>     count = mtu3_readl(mtu->mac_base, U3D_RXCOUNT0);
> +   if (count == 0)
> +       return -EINVAL;

'count' should be tested against sizeof(*setup). Indeed, we need to have a
setup data packet in the fifo.

What do you think about:
if (count < sizef(*setup))
	return -EINVAL;

> 
>     ep0_read_fifo(mtu->ep0, (u8 *)setup, count);
> 
> @@ -642,7 +644,8 @@ __acquires(mtu->lock)
>     struct mtu3_request *mreq;
>     int handled = 0;
> 
> -   ep0_read_setup(mtu, &setup);
> +   if (ep0_read_setup(mtu, &setup))
> +       return -EINVAL;

Forward the error code to the caller ?

ret = ep0_read_setup(mtu, &setup)
if (ret < 0)
	return ret;


>     trace_mtu3_handle_setup(&setup);
> 
>     if ((setup.bRequestType & USB_TYPE_MASK) == USB_TYPE_STANDARD)
> @@ -764,7 +767,9 @@ irqreturn_t mtu3_ep0_isr(struct mtu3 *mtu)
>             break;
>         }
> 
> -       ep0_handle_setup(mtu);
> +       if (ep0_handle_setup(mtu))
> +           break;
> +

Ok

>         ret = IRQ_HANDLED;
>         break;
>     default:

Be careful, your patch is wrongly indented.
tabs replaced by 4 spaces. You need to keep tabs.

Regards,
Hervé Codina

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
