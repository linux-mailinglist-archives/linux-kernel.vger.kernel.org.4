Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A336260086B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 10:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiJQIM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 04:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiJQIM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:12:56 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51840578BD;
        Mon, 17 Oct 2022 01:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665994375; x=1697530375;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BuoukK197kIH67kqksqI1W+6GwLk5Xk8TkrWNPLTHIw=;
  b=bFlME6oLuIj0f6AOitRD2Ry5u+4EXCrADxrkUt6PCbDmI+/rWcakca37
   zfcbBc62QBumNwriLwIwYj+d6GPpE4sZu3xf3Ajo45w9Ah0xJFmEiUIL2
   XWVpsihKxyc5dbfQK8fBU21SFrXqiFNdWZ3JO47pPb1B9kQYbu8f5dTUn
   JGl5w/lvA2UZBbLYv/zjNuqYY08PZ+Uhk343M4N97QPrCc0mFoX3413UV
   sj9CTYHzoxdRoBNRG8tfkvdRFCnWzkJDp8wVo959IZkeO//pTie7Nc5Yo
   bCLzHTH2Rgd3ur1zkufG+O6hWzUcfwWcn9owi9WtGqaKNg1yxIhyAt+xa
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="305727995"
X-IronPort-AV: E=Sophos;i="5.95,190,1661842800"; 
   d="scan'208";a="305727995"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 01:12:46 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="753552798"
X-IronPort-AV: E=Sophos;i="5.95,190,1661842800"; 
   d="scan'208";a="753552798"
Received: from ohoehne-mobl4.ger.corp.intel.com ([10.251.213.173])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 01:12:43 -0700
Date:   Mon, 17 Oct 2022 11:12:41 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Lindgren <tony@atomide.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250_omap: remove wait loop from Errata i202
 workaround
In-Reply-To: <20221013112339.2540767-1-matthias.schiffer@ew.tq-group.com>
Message-ID: <ea90b0ba-61bf-e56e-5120-9771122838cf@linux.intel.com>
References: <20221013112339.2540767-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1487723672-1665994365=:5493"
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1487723672-1665994365=:5493
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Thu, 13 Oct 2022, Matthias Schiffer wrote:

> We were occasionally seeing the "Errata i202: timedout" on an AM335x
> board when repeatedly opening and closing a UART connected to an active
> sender. As new input may arrive at any time, it is possible to miss the
> "RX FIFO empty" condition, forcing the loop to wait until it times out.

I can see this problem could occur and why your patch fixes it.

> Nothing in the i202 Advisory states that such a wait is even necessary;
> other FIFO clear functions like serial8250_clear_fifos() do not wait
> either. For this reason, it seems safe to remove the wait, fixing the
> mentioned issue.

Checking the commit that added this driver and the loop along with it, 
there was no information why it would be needed there either.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Thanks.

-- 
 i.


> Fixes: 61929cf0169d ("tty: serial: Add 8250-core based omap driver")
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  drivers/tty/serial/8250/8250_omap.c | 17 -----------------
>  1 file changed, 17 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index 41b8c6b27136..484f791617af 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -193,27 +193,10 @@ static void omap8250_set_mctrl(struct uart_port *port, unsigned int mctrl)
>  static void omap_8250_mdr1_errataset(struct uart_8250_port *up,
>  				     struct omap8250_priv *priv)
>  {
> -	u8 timeout = 255;
> -
>  	serial_out(up, UART_OMAP_MDR1, priv->mdr1);
>  	udelay(2);
>  	serial_out(up, UART_FCR, up->fcr | UART_FCR_CLEAR_XMIT |
>  			UART_FCR_CLEAR_RCVR);
> -	/*
> -	 * Wait for FIFO to empty: when empty, RX_FIFO_E bit is 0 and
> -	 * TX_FIFO_E bit is 1.
> -	 */
> -	while (UART_LSR_THRE != (serial_in(up, UART_LSR) &
> -				(UART_LSR_THRE | UART_LSR_DR))) {
> -		timeout--;
> -		if (!timeout) {
> -			/* Should *never* happen. we warn and carry on */
> -			dev_crit(up->port.dev, "Errata i202: timedout %x\n",
> -				 serial_in(up, UART_LSR));
> -			break;
> -		}
> -		udelay(1);
> -	}
>  }
>  
>  static void omap_8250_get_divisor(struct uart_port *port, unsigned int baud,
> 

--8323329-1487723672-1665994365=:5493--
