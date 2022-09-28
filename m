Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D59E5EDA0B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbiI1K1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiI1K1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:27:05 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A5AA284C;
        Wed, 28 Sep 2022 03:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664360824; x=1695896824;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qfBW59AwCRQoAtv+bPOlmxuESBI1xGytYj0d2LFe6yI=;
  b=j3WXBgydzxF/pgg6gIk5dx5/SPSzNegLAWUzOmpIbRrnewxOiV/UM5GW
   5CwuNY9kBhRagvLjQdpE02RUgHX62ueTRyPevMlBRNM50ul1TD0+7ZRyv
   sxXcB+xBXAVz43Dm2DKtxA3g+nzaAhYR6HCQVRz1VM9QR2mlV7lvuLdPX
   ugPE86IycwDpaGRjic1pieTxKwBJLxNGtvwxN+B4F1sHs64HJvIHYrpys
   UAhmeAJbaGqKw0UrnNHvAuHM3pLEbhWOzOFqc/TsFOOEXuUDIvV8ZjBPy
   NObLhn29Ae8I6yjal1Al4KjJVuCTv1aejhPJEm3NWaTxHtgf5X70mzqfn
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="288722532"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="288722532"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 03:27:03 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="655078285"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="655078285"
Received: from kjurkiew-mobl.ger.corp.intel.com ([10.251.211.248])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 03:27:01 -0700
Date:   Wed, 28 Sep 2022 13:26:56 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH 3/4] tty: serial: unify TX space reads under
 altera_jtaguart_tx_space()
In-Reply-To: <20220927111819.18516-3-jslaby@suse.cz>
Message-ID: <bcb0b523-3df0-82e0-51d2-ada0959134e@linux.intel.com>
References: <20220927111819.18516-1-jslaby@suse.cz> <20220927111819.18516-3-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-337446478-1664360823=:1695"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-337446478-1664360823=:1695
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 27 Sep 2022, Jiri Slaby wrote:

> TX space reads from the control register are performed in various forms
> on 4 places in altera_jtaguart. Unify all those and do the read and
> masking on a single place.
> 
> The new helper altera_jtaguart_tx_space() uses FIELD_GET(), so we can
> drop ALTERA_JTAGUART_CONTROL_WSPACE_OFF now.
> 
> Cc: Tobias Klauser <tklauser@distanz.ch>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
>  drivers/tty/serial/altera_jtaguart.c | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
> index 23f339757894..ac8ce418de36 100644
> --- a/drivers/tty/serial/altera_jtaguart.c
> +++ b/drivers/tty/serial/altera_jtaguart.c
> @@ -9,6 +9,7 @@
>   * (C) Copyright 2010, Tobias Klauser <tklauser@distanz.ch>
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
> @@ -48,7 +49,6 @@
>  #define ALTERA_JTAGUART_CONTROL_WI_MSK		0x00000200
>  #define ALTERA_JTAGUART_CONTROL_AC_MSK		0x00000400
>  #define ALTERA_JTAGUART_CONTROL_WSPACE_MSK	0xFFFF0000
> -#define ALTERA_JTAGUART_CONTROL_WSPACE_OFF	16
>  
>  /*
>   * Local per-uart structure.
> @@ -59,10 +59,19 @@ struct altera_jtaguart {
>  	unsigned long imr;	/* Local IMR mirror */
>  };
>  
> +static unsigned int altera_jtaguart_tx_space(struct uart_port *port, u32 *ctlp)
> +{
> +	u32 ctl = readl(port->membase + ALTERA_JTAGUART_CONTROL_REG);
> +
> +	if (ctlp)
> +		*ctlp = ctl;
> +
> +	return FIELD_GET(ALTERA_JTAGUART_CONTROL_WSPACE_MSK, ctl);
> +}
> +
>  static unsigned int altera_jtaguart_tx_empty(struct uart_port *port)
>  {
> -	return (readl(port->membase + ALTERA_JTAGUART_CONTROL_REG) &
> -		ALTERA_JTAGUART_CONTROL_WSPACE_MSK) ? TIOCSER_TEMT : 0;
> +	return altera_jtaguart_tx_space(port, NULL) ? TIOCSER_TEMT : 0;
>  }
>  
>  static unsigned int altera_jtaguart_get_mctrl(struct uart_port *port)
> @@ -150,9 +159,7 @@ static void altera_jtaguart_tx_chars(struct altera_jtaguart *pp)
>  
>  	pending = uart_circ_chars_pending(xmit);
>  	if (pending > 0) {
> -		count = (readl(port->membase + ALTERA_JTAGUART_CONTROL_REG) &
> -				ALTERA_JTAGUART_CONTROL_WSPACE_MSK) >>
> -			ALTERA_JTAGUART_CONTROL_WSPACE_OFF;
> +		count = altera_jtaguart_tx_space(port, NULL);
>  		if (count > pending)
>  			count = pending;
>  		if (count > 0) {
> @@ -298,12 +305,11 @@ static struct altera_jtaguart altera_jtaguart_ports[ALTERA_JTAGUART_MAXPORTS];
>  #if defined(CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE_BYPASS)
>  static void altera_jtaguart_console_putc(struct uart_port *port, unsigned char c)
>  {
> -	unsigned long status;
>  	unsigned long flags;
> +	u32 status;
>  
>  	spin_lock_irqsave(&port->lock, flags);
> -	while (((status = readl(port->membase + ALTERA_JTAGUART_CONTROL_REG)) &
> -		ALTERA_JTAGUART_CONTROL_WSPACE_MSK) == 0) {
> +	while (!altera_jtaguart_tx_space(port, &status)) {
>  		if ((status & ALTERA_JTAGUART_CONTROL_AC_MSK) == 0) {
>  			spin_unlock_irqrestore(&port->lock, flags);
>  			return;	/* no connection activity */
> @@ -321,8 +327,7 @@ static void altera_jtaguart_console_putc(struct uart_port *port, unsigned char c
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&port->lock, flags);
> -	while ((readl(port->membase + ALTERA_JTAGUART_CONTROL_REG) &
> -		ALTERA_JTAGUART_CONTROL_WSPACE_MSK) == 0) {
> +	while (!altera_jtaguart_tx_space(port, NULL)) {
>  		spin_unlock_irqrestore(&port->lock, flags);
>  		cpu_relax();
>  		spin_lock_irqsave(&port->lock, flags);

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

With caveats. This is not incorrect per se but I don't particularly like 
that pointer thing done in altera_jtaguart_tx_space(). IMHO, 
altera_jtaguart_console_putc() that needs the control register also for 
other uses than tx space check should read it locally and 
__altera_jtaguart_tx_space() could be added to handle just the 
tx space check without read. But this is of course just my opinion, 
there's no technical issue things done either way.

-- 
 i.

--8323329-337446478-1664360823=:1695--
