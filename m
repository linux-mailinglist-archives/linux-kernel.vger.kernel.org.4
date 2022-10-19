Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E59604320
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbiJSL0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbiJSLZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:25:55 -0400
Received: from out199-4.us.a.mail.aliyun.com (out199-4.us.a.mail.aliyun.com [47.90.199.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138F11669A3;
        Wed, 19 Oct 2022 03:57:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VSaOjhM_1666176554;
Received: from 30.97.48.52(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VSaOjhM_1666176554)
          by smtp.aliyun-inc.com;
          Wed, 19 Oct 2022 18:49:15 +0800
Message-ID: <5ec4a475-b800-7ef9-8edc-605d4d17bbaa@linux.alibaba.com>
Date:   Wed, 19 Oct 2022 18:49:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 33/44] serial: sprd: Use uart_xmit_advance()
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20221019091151.6692-1-ilpo.jarvinen@linux.intel.com>
 <20221019091151.6692-34-ilpo.jarvinen@linux.intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20221019091151.6692-34-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/19/2022 5:11 PM, Ilpo Järvinen wrote:
> Take advantage of the new uart_xmit_advance() helper.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

LGTM. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   drivers/tty/serial/sprd_serial.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
> index 342a87967631..eae700809342 100644
> --- a/drivers/tty/serial/sprd_serial.c
> +++ b/drivers/tty/serial/sprd_serial.c
> @@ -206,7 +206,6 @@ static void sprd_stop_tx_dma(struct uart_port *port)
>   {
>   	struct sprd_uart_port *sp =
>   		container_of(port, struct sprd_uart_port, port);
> -	struct circ_buf *xmit = &port->state->xmit;
>   	struct dma_tx_state state;
>   	u32 trans_len;
>   
> @@ -215,8 +214,7 @@ static void sprd_stop_tx_dma(struct uart_port *port)
>   	dmaengine_tx_status(sp->tx_dma.chn, sp->tx_dma.cookie, &state);
>   	if (state.residue) {
>   		trans_len = state.residue - sp->tx_dma.phys_addr;
> -		xmit->tail = (xmit->tail + trans_len) & (UART_XMIT_SIZE - 1);
> -		port->icount.tx += trans_len;
> +		uart_xmit_advance(port, trans_len);
>   		dma_unmap_single(port->dev, sp->tx_dma.phys_addr,
>   				 sp->tx_dma.trans_len, DMA_TO_DEVICE);
>   	}
> @@ -253,8 +251,7 @@ static void sprd_complete_tx_dma(void *data)
>   	dma_unmap_single(port->dev, sp->tx_dma.phys_addr,
>   			 sp->tx_dma.trans_len, DMA_TO_DEVICE);
>   
> -	xmit->tail = (xmit->tail + sp->tx_dma.trans_len) & (UART_XMIT_SIZE - 1);
> -	port->icount.tx += sp->tx_dma.trans_len;
> +	uart_xmit_advance(port, sp->tx_dma.trans_len);
>   
>   	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
>   		uart_write_wakeup(port);
