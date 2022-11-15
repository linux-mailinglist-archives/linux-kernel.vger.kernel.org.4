Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DECE629DD8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiKOPnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiKOPnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:43:15 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733482DAB6;
        Tue, 15 Nov 2022 07:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668526994; x=1700062994;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=s9oaosGmUEUIu8B6Y80o7wEcDR5HzGUb+csj5/bQq/k=;
  b=mBns1BeqUILOTLpALM/0vNBo6ZmhH0Kh7YOPTI8C1GfOXkZriYGeQMgS
   sbQ+4q92oxFjBn0mye5haWl6hJB3oLicT7hgKobkocPkOuuFOKfPwzE0x
   QwVfDImCa45rr0JrhlbEqVYVdaVU7lq0v/yMA6OtelspJ/4PpEL/UaD9c
   vg0i2E5du43GDzirlMhbRzQAcLfVEX6iX84As7DhayRefKNybBeO5spUb
   V/4K1eqU2PV6yknHB9eCeE5sBguAyukkFTP0XbbTtsqsQfPFvGO3AtJXc
   XVY6vcF1VYVg4znOYG36iXfnPnAkX8DJMLPT1cxm2tLbx6JFcL1hZWbvq
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="292678077"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="292678077"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 07:43:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="763954388"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="763954388"
Received: from mrosso-mobl1.ger.corp.intel.com ([10.249.45.244])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 07:43:09 -0800
Date:   Tue, 15 Nov 2022 17:43:06 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Gabriel Somlo <gsomlo@gmail.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kgugala@antmicro.com,
        mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        geert@linux-m68k.org
Subject: Re: [PATCH v3 08/14] serial: liteuart: simplify passing of
 uart_insert_char() flag
In-Reply-To: <20221112212125.448824-9-gsomlo@gmail.com>
Message-ID: <14c6a4bc-8299-6259-135d-787889f71d2b@linux.intel.com>
References: <20221112212125.448824-1-gsomlo@gmail.com> <20221112212125.448824-9-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1293795107-1668526993=:2268"
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

--8323329-1293795107-1668526993=:2268
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Sat, 12 Nov 2022, Gabriel Somlo wrote:

> Simply provide the hard-coded TTY_NORMAL flag to uart_insert_char()
> directly -- no need to dedicate a variable for that exclusive purpose.
> 
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> ---
>  drivers/tty/serial/liteuart.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> index b5ab48aa35cf..e9e99d6b5fef 100644
> --- a/drivers/tty/serial/liteuart.c
> +++ b/drivers/tty/serial/liteuart.c
> @@ -72,7 +72,6 @@ static void liteuart_timer(struct timer_list *t)
>  	struct liteuart_port *uart = from_timer(uart, t, timer);
>  	struct uart_port *port = &uart->port;
>  	unsigned char __iomem *membase = port->membase;
> -	unsigned int flg = TTY_NORMAL;
>  	int ch;
>  	unsigned long status;
>  
> @@ -85,7 +84,7 @@ static void liteuart_timer(struct timer_list *t)
>  
>  		/* no overflow bits in status */
>  		if (!(uart_handle_sysrq_char(port, ch)))
> -			uart_insert_char(port, status, 0, ch, flg);
> +			uart_insert_char(port, status, 0, ch, TTY_NORMAL);
>  	}
>  
>  	tty_flip_buffer_push(&port->state->port);

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1293795107-1668526993=:2268--
