Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92430606961
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 22:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiJTUMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 16:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJTUMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 16:12:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715A317EF31;
        Thu, 20 Oct 2022 13:12:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 358DAB828B5;
        Thu, 20 Oct 2022 20:12:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDDD7C433C1;
        Thu, 20 Oct 2022 20:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666296737;
        bh=W4KCwra5v9uA4wyjd6DCEjQdx6UQ6XoKLtxXcQdURFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hz58T+dejJSggZscJtPWjSLesTvggYReaTS+8PY16cH0YJYSIBBPy9psfshW/i99Y
         QGcsLNoHaqwbvcKryVu2nrZAoHd+fYX2XL7WiZAe+99+WvN6YX5lhbrb6/JP2OeryR
         rDH3HspA49Z1bSyIOUXqC5gJPXtRafWdsSWdOlT31s7Ts5Wu2ohRFMx4l6J5VXx3TQ
         B2uTji5kxhTQGqm5Um8A+tG4fQ1h1JQ7H87u4vyYZNBHCLaWGWaaF93TsCIsrEuDMY
         im77ng3i5ikeVQRxfODPjbJbpaOzvuq0UdzQF62t7UZ+zD9RwOuhnE10JnMTOHRxkv
         YdDA5V74zFdfA==
Received: by pali.im (Postfix)
        id EF16680E; Thu, 20 Oct 2022 22:12:14 +0200 (CEST)
Date:   Thu, 20 Oct 2022 22:12:14 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 24/44] serial: mvebu-uart: Use uart_xmit_advance()
Message-ID: <20221020201214.pusagqobdbdpy6ek@pali>
References: <20221019091151.6692-1-ilpo.jarvinen@linux.intel.com>
 <20221019091151.6692-25-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221019091151.6692-25-ilpo.jarvinen@linux.intel.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 October 2022 12:11:31 Ilpo Järvinen wrote:
> Take advantage of the new uart_xmit_advance() helper.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Pali Rohár <pali@kernel.org>

> ---
>  drivers/tty/serial/mvebu-uart.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
> index ba16e1da6bd3..ba9a6206daae 100644
> --- a/drivers/tty/serial/mvebu-uart.c
> +++ b/drivers/tty/serial/mvebu-uart.c
> @@ -223,8 +223,7 @@ static void mvebu_uart_start_tx(struct uart_port *port)
>  
>  	if (IS_EXTENDED(port) && !uart_circ_empty(xmit)) {
>  		writel(xmit->buf[xmit->tail], port->membase + UART_TSH(port));
> -		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> -		port->icount.tx++;
> +		uart_xmit_advance(port, 1);
>  	}
>  
>  	ctl = readl(port->membase + UART_INTR(port));
> -- 
> 2.30.2
> 
