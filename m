Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3DF629DDF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiKOPob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbiKOPo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:44:27 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB4F1DDED;
        Tue, 15 Nov 2022 07:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668527066; x=1700063066;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=USym5oX9k54PcnynIq9soigokEvjd1nWZygxCD6cywI=;
  b=bsoL1EXSTncLVGNPwEy/DIomCD7mEifqzR+TcMJTN3xo/LEw0jv5nEzL
   6S4+CAp0C1alUAiowE56c2oCmrlpCQH47x5oAeiL8s/up81XMS79MvaFI
   AkG9KagkSkgT97O3+QVzxaiAkbkoG3aE83ewCYBRgqv3ibPHiCHcvZihO
   VOQPhBnsEWMyn5QfeCglqZVOgrlqtAEPlejNqwm7cf8QZk50EHrMhlC0a
   WcbZtM+QXw8/h77rFemEhUcGF365AGa6xTQMbsTbFzTqXY98/DCb7WXvJ
   LuFIEcmB1sJVLsfO9GzdkOe72X83qn9eNNGX1KLbHUdg2MUu7d9dvVb9a
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="292678434"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="292678434"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 07:44:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="672033565"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="672033565"
Received: from mrosso-mobl1.ger.corp.intel.com ([10.249.45.244])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 07:44:22 -0800
Date:   Tue, 15 Nov 2022 17:44:19 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Gabriel Somlo <gsomlo@gmail.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kgugala@antmicro.com,
        mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        geert@linux-m68k.org
Subject: Re: [PATCH v3 10/14] serial: liteuart: separate rx loop from poll
 timer
In-Reply-To: <20221112212125.448824-11-gsomlo@gmail.com>
Message-ID: <6bff9a8e-1360-32cf-e2cb-313cde8eb456@linux.intel.com>
References: <20221112212125.448824-1-gsomlo@gmail.com> <20221112212125.448824-11-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-855007299-1668527066=:2268"
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

--8323329-855007299-1668527066=:2268
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Sat, 12 Nov 2022, Gabriel Somlo wrote:

> Convert the rx loop into its own dedicated function, and (for now)
> call it from the poll timer. This is in preparation for adding irq
> support to the receive path.
> 
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> ---
>  drivers/tty/serial/liteuart.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> index 974da0f73257..172ac190ba2f 100644
> --- a/drivers/tty/serial/liteuart.c
> +++ b/drivers/tty/serial/liteuart.c
> @@ -67,10 +67,8 @@ static struct uart_driver liteuart_driver = {
>  #endif
>  };
>  
> -static void liteuart_timer(struct timer_list *t)
> +static void liteuart_rx_chars(struct uart_port *port)
>  {
> -	struct liteuart_port *uart = from_timer(uart, t, timer);
> -	struct uart_port *port = &uart->port;
>  	unsigned char __iomem *membase = port->membase;
>  	unsigned int status, ch;
>  
> @@ -87,6 +85,14 @@ static void liteuart_timer(struct timer_list *t)
>  	}
>  
>  	tty_flip_buffer_push(&port->state->port);
> +}
> +
> +static void liteuart_timer(struct timer_list *t)
> +{
> +	struct liteuart_port *uart = from_timer(uart, t, timer);
> +	struct uart_port *port = &uart->port;
> +
> +	liteuart_rx_chars(port);
>  
>  	mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
>  }

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-855007299-1668527066=:2268--
