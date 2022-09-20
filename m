Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3B05BE1BF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbiITJT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiITJTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:19:16 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CCC639F;
        Tue, 20 Sep 2022 02:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663665555; x=1695201555;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=BAbM1TqEtb44PX0/vS1qF8q9DcnRF8aqNBELI9rzAgQ=;
  b=AE8DQMEXSMEwIAe3wUkwPL+SrtdfdjQgE9NmScb5gEmPQ/c6KpsOlke4
   gow5198aR5MqZL4N22KAOGx8dEjxUbA/WJBPszGKSHz2vxqu0lW5Og/Sn
   e8SRT8Ec74Qly0eBFiDgMq/tIb93lWQ8B0nigQe3gckp41r6Z8iU+kp7P
   O07W9NNJl7KZIiPazo8uurQCqABwDBtw/t0tMyE6lKCrP7MC1BGQCrC6w
   g4IRtXJ8vDAGXts5ZSyTaqOpApMiby1kPKRAUjb9pKFU+js+gthKFwjlu
   u7oP1Sx/LIw4F3aSMWDlt/gFnRPzOSGCujjaopvt26kWjowvxV2njuawG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="361383639"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="361383639"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 02:19:15 -0700
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="744459621"
Received: from bdallmer-mobl.ger.corp.intel.com ([10.252.59.238])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 02:19:11 -0700
Date:   Tue, 20 Sep 2022 12:19:08 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 10/10] tty: serial: use uart_port_tx_limited()
In-Reply-To: <20220920075844.29360-1-jslaby@suse.cz>
Message-ID: <f2653c92-1769-fc7c-8ad8-abf34affef6b@linux.intel.com>
References: <20220920052049.20507-1-jslaby@suse.cz> <20220920075844.29360-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1250180477-1663664450=:1766"
Content-ID: <5186414d-2cc-26ad-bf70-acafdbdd2d7@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1250180477-1663664450=:1766
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <8a48e911-6d7c-c65b-e692-658250d45aa1@linux.intel.com>

On Tue, 20 Sep 2022, Jiri Slaby wrote:

> uart_port_tx_limited() is a new helper to send characters to the device.
> Use it in these drivers.
> 
> mux.c also needs to define tx_done(). But I'm not sure if the driver
> really wants to wait for all the characters to dismiss from the HW fifo
> at this code point. Hence I marked this as FIXME.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: "Pali Rohár" <pali@kernel.org>
> Cc: Kevin Cernekee <cernekee@gmail.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Baolin Wang <baolin.wang7@gmail.com>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: linux-riscv@lists.infradead.org

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

One improvement suggestion below.

> diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
> index 23f339757894..f224f5141726 100644
> --- a/drivers/tty/serial/altera_jtaguart.c
> +++ b/drivers/tty/serial/altera_jtaguart.c
> @@ -137,39 +137,17 @@ static void altera_jtaguart_rx_chars(struct altera_jtaguart *pp)
>  static void altera_jtaguart_tx_chars(struct altera_jtaguart *pp)
>  {
>  	struct uart_port *port = &pp->port;
> -	struct circ_buf *xmit = &port->state->xmit;
> -	unsigned int pending, count;
> -
> -	if (port->x_char) {
> -		/* Send special char - probably flow control */
> -		writel(port->x_char, port->membase + ALTERA_JTAGUART_DATA_REG);
> -		port->x_char = 0;
> -		port->icount.tx++;
> -		return;
> -	}
> +	unsigned int space;
> +	u8 ch;
>  
> -	pending = uart_circ_chars_pending(xmit);
> -	if (pending > 0) {
> -		count = (readl(port->membase + ALTERA_JTAGUART_CONTROL_REG) &
> -				ALTERA_JTAGUART_CONTROL_WSPACE_MSK) >>
> -			ALTERA_JTAGUART_CONTROL_WSPACE_OFF;
> -		if (count > pending)
> -			count = pending;
> -		if (count > 0) {
> -			pending -= count;
> -			while (count--) {
> -				writel(xmit->buf[xmit->tail],
> -				       port->membase + ALTERA_JTAGUART_DATA_REG);
> -				xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> -				port->icount.tx++;
> -			}
> -			if (pending < WAKEUP_CHARS)
> -				uart_write_wakeup(port);
> -		}
> -	}
> +	space = readl(port->membase + ALTERA_JTAGUART_CONTROL_REG);
> +	space &= ALTERA_JTAGUART_CONTROL_WSPACE_MSK;
> +	space >>= ALTERA_JTAGUART_CONTROL_WSPACE_OFF;

This is FIELD_GET(ALTERA_JTAGUART_CONTROL_WSPACE_MSK, ...) & then allows 
killing ALTERA_JTAGUART_CONTROL_WSPACE_OFF. I'd probably do it in a 
separate patch though.


-- 
 i.
--8323329-1250180477-1663664450=:1766--
