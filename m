Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4FB60BF95
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 02:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiJYAcL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Oct 2022 20:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiJYAbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 20:31:53 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D5D4814EE;
        Mon, 24 Oct 2022 15:55:35 -0700 (PDT)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 29OLxHwv016050;
        Mon, 24 Oct 2022 16:59:18 -0500
Message-ID: <661b43881b7f8764919847f29c0daf1866441090.camel@kernel.crashing.org>
Subject: Re: [PATCH] usb: gadget: aspeed: fix buffer overflow
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Lei YU <yulei.sh@bytedance.com>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Henry Tian <tianxiaofeng@bytedance.com>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Tue, 25 Oct 2022 08:59:17 +1100
In-Reply-To: <20221024094853.2877441-1-yulei.sh@bytedance.com>
References: <20221024094853.2877441-1-yulei.sh@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-10-24 at 09:48 +0000, Lei YU wrote:
> From: Henry Tian <tianxiaofeng@bytedance.com>

I wrote that driver, please CC me on further patches to it (thanks Joel
for the heads up).

> In ast_vhub_epn_handle_ack() when the received data length exceeds the
> buffer, it does not check the case and just copies to req.buf and cause
> a buffer overflow, kernel oops on this case.

 .../...

Thanks ! Seems like a legit bug, however:

> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/epn.c b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
> index b5252880b389..56e55472daa1 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/epn.c
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
> @@ -84,6 +84,7 @@ static void ast_vhub_epn_handle_ack(struct ast_vhub_ep *ep)
>  {
>         struct ast_vhub_req *req;
>         unsigned int len;
> +       int status = 0;
>         u32 stat;
>  
>         /* Read EP status */
> @@ -119,9 +120,15 @@ static void ast_vhub_epn_handle_ack(struct ast_vhub_ep *ep)
>         len = VHUB_EP_DMA_TX_SIZE(stat);
>  
>         /* If not using DMA, copy data out if needed */
> -       if (!req->req.dma && !ep->epn.is_in && len)
> -               memcpy(req->req.buf + req->req.actual, ep->buf, len);
> -
> +       if (!req->req.dma && !ep->epn.is_in && len) {
> +               if (req->req.actual + len > req->req.length) {
> +                       req->last_desc = 1;
> +                       status = -EOVERFLOW;
> +                       goto done;

Should we stall as well ? Should we continue receiving and just dropping the data until we have
a small packet ? Otherwise the EP could get out of sync for subsequent ones...

Additionally, I'm curious, why in this specific case is the device sending more data than
the buffer can hold ? The MTU change should have resulted in buffers being re-allocated no ?
Or did you change the MTU on the remote and not on the local device ?

Cheers,
Ben.
