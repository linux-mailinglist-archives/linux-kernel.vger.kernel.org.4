Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A229623FB6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 11:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiKJKY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 05:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKJKYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 05:24:51 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDCD663C9;
        Thu, 10 Nov 2022 02:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668075891; x=1699611891;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=iKkVMv/MthNvqNe7p7oH2Gt1AWFJXR5YZeKyC5YXt/g=;
  b=G8uPkYNToj9VAsd5EalBT0E+bQu01yO33Jp1v1vrV0/mxrHJwYuA16Nd
   lcNn79tzByVT/1I1PvUKs7BQDMKLgtuMLPPm7+mDiLgyIkiA8dACkp9mR
   F8Z4bKQrFonRJu15g1WhDbL+C7UJDG5Nveofncf92pm+zCnIDztrrXjyi
   g/Tg4Ei+jb7GWsHgFKTjxOLiRDgtkOw4JQKzjzw3g9LZzOKT1ayXsJt8/
   9J0eODbCsFaTyTJd5zJMdu/JLPeFtG+bPq6MJLLtYMMWrzyKaykyH0u04
   Mzc5M7aPJgfJZrZp6QC5cjiyKEudi58IFzOW1FsKq1PAqcawgMfSuBBIE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="290993879"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; 
   d="scan'208";a="290993879"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 02:24:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="631608328"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; 
   d="scan'208";a="631608328"
Received: from albertmo-mobl2.ger.corp.intel.com ([10.249.43.248])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 02:24:48 -0800
Date:   Thu, 10 Nov 2022 12:24:41 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     delisun <delisun@pateo.com.cn>
cc:     linux@armlinux.org.uk,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: pl011: Do not clear RX FIFO & RX interrupt in
 unthrottle.
In-Reply-To: <20221110020108.7700-1-delisun@pateo.com.cn>
Message-ID: <ef8361c6-fce6-b874-ff1e-d81dd63dac14@linux.intel.com>
References: <20221110020108.7700-1-delisun@pateo.com.cn>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-726188043-1668075890=:1867"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-726188043-1668075890=:1867
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Thu, 10 Nov 2022, delisun wrote:

> Clearing the RX FIFO will cause data loss.
> Copy the pl011_enabl_interrupts implementation, and remove the clear
> interrupt and FIFO part of the code.
> 
> Fixes: 211565b10099 ("serial: pl011: UPSTAT_AUTORTS requires .throttle/unthrottle")
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
>  }
>  
>  static int pl011_startup(struct uart_port *port)

Thanks.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> 

-- 
 i.

--8323329-726188043-1668075890=:1867--
