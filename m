Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A113D622AFF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiKILzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiKILzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:55:13 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F201B1DF14;
        Wed,  9 Nov 2022 03:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667994912; x=1699530912;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7MoJf6hwU/jiZpPsHcDpL18qbN8uRxN5JFzI/TAVayo=;
  b=he4neB0pCjBcjmR6/6dK4lvhIcapUWnXS+QXOkd3pvro2c+408rL+WgA
   YnL6htWbEQ7MtDR1VqTFyy3VlnrB9TL3Lj4f0lcVv7DjCoO0q6rR9zxFH
   dHMPIoXJCGO5f/ZJnixA33NNUI0KxekURgy+PWoJ41jZiyl4+hN47fXCC
   P2JgwvkoT6nJrr+cvHctDrBbOugwbNERnolBCa30JAbolGcHhxiCPFqqO
   u8jfaAuuW70o4BQWIu8ERYQslvYlJlgyumj7KJyfohz+wN031yH3bfy+Z
   849TQS1e2gvKsKYHV4rTa3jbCW83wLTXvMobOeQOhwKrrKaqj4MNXGENL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="375234356"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="375234356"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 03:55:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="614663390"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="614663390"
Received: from jsanche3-mobl1.ger.corp.intel.com ([10.251.219.48])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 03:55:10 -0800
Date:   Wed, 9 Nov 2022 13:55:07 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     delisun <delisun@pateo.com.cn>
cc:     linux@armlinux.org.uk,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: pl011: Do not clear RX FIFO & RX interrupt in
 unthrottle.
In-Reply-To: <20221109105822.332011-1-delisun@pateo.com.cn>
Message-ID: <b4de808e-333-e1f9-b047-1ecadb29838e@linux.intel.com>
References: <20221109105822.332011-1-delisun@pateo.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Nov 2022, delisun wrote:

> Clearing the RX FIFO will cause data loss.
> Copy the pl011_enabl_interrupts implementation, and remove the clear
> interrupt and FIFO part of the code.
> 

You should add Fixes tag.

-- 
 i.


> Signed-off-by: delisun <delisun@pateo.com.cn>
> ---
>  drivers/tty/serial/amba-pl011.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 5cdced39eafd..08034e5dcec0 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -1828,8 +1828,17 @@ static void pl011_enable_interrupts(struct uart_amba_port *uap)
>  static void pl011_unthrottle_rx(struct uart_port *port)
>  {
>  	struct uart_amba_port *uap = container_of(port, struct uart_amba_port, port);
> +	unsigned long flags;
>  
> -	pl011_enable_interrupts(uap);
> +	spin_lock_irqsave(&uap->port.lock, flags);
> +
> +	uap->im = UART011_RTIM;
> +	if (!pl011_dma_rx_running(uap))
> +		uap->im |= UART011_RXIM;
> +
> +	pl011_write(uap->im, uap, REG_IMSC);
> +
> +	spin_unlock_irqrestore(&uap->port.lock, flags);

