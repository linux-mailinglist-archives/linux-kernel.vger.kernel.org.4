Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6537629EC0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 17:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238643AbiKOQRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 11:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238585AbiKOQRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:17:20 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755402C133;
        Tue, 15 Nov 2022 08:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668529038; x=1700065038;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=SsK9Yo3R9foh+0Ic3YagDaLNJGA7x0gWOyCfmmPxYmA=;
  b=HBqEJ4O+w+PRaHzB94T08ECQ9A5qFOd5xHPJ8eobGDRMBiJdsnAn/aUX
   iw9WK0jXDfZE/v62/lcBLpLjsmmuN07bxr0wXLpOrnJeKTjJLFQXUUl2J
   a+5Bfvbzy+Wl1foxtV3nvO9JXkAdjVMyxO8DqN/mUxxb7/LvTE7ZorEtH
   9mLWqfHDfJKxarS24EofhdVNBTZr+OxCiupotjMwAFacOgnSGgnEF4Jbv
   gXmxIISI328fBGTsBTeIxmAZHUw/kVGop4kmMomf7UG+T6G30Rut2fKI+
   50W1FlY2Njx4RgI3vxKXgnTETF2jbfiBBcTD8ByC2gebB8NCqmhTHssWU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="339092581"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="339092581"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 08:17:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="781395283"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="781395283"
Received: from mrosso-mobl1.ger.corp.intel.com ([10.249.45.244])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 08:16:59 -0800
Date:   Tue, 15 Nov 2022 18:16:57 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Gabriel Somlo <gsomlo@gmail.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kgugala@antmicro.com,
        mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        geert@linux-m68k.org
Subject: Re: [PATCH v3 14/14] serial: liteuart: move polling putchar()
 function
In-Reply-To: <20221112212125.448824-15-gsomlo@gmail.com>
Message-ID: <a8432f1f-1674-e2e0-8162-f8f8173ea42@linux.intel.com>
References: <20221112212125.448824-1-gsomlo@gmail.com> <20221112212125.448824-15-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-794393047-1668529023=:2268"
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-794393047-1668529023=:2268
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Sat, 12 Nov 2022, Gabriel Somlo wrote:

> The polling liteuart_putchar() function is only called from methods
> conditionally enabled by CONFIG_SERIAL_LITEUART_CONSOLE. Move its
> definition closer to the console code where it is dependent on the
> same config option.
> 
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> ---
>  drivers/tty/serial/liteuart.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> index 307c27398e30..767c356e60c9 100644
> --- a/drivers/tty/serial/liteuart.c
> +++ b/drivers/tty/serial/liteuart.c
> @@ -69,14 +69,6 @@ static struct uart_driver liteuart_driver = {
>  #endif
>  };
>  
> -static void liteuart_putchar(struct uart_port *port, unsigned char ch)
> -{
> -	while (litex_read8(port->membase + OFF_TXFULL))
> -		cpu_relax();
> -
> -	litex_write8(port->membase + OFF_RXTX, ch);
> -}
> -
>  static void liteuart_stop_tx(struct uart_port *port)
>  {
>  	if (port->irq) {
> @@ -389,6 +381,14 @@ static struct platform_driver liteuart_platform_driver = {
>  
>  #ifdef CONFIG_SERIAL_LITEUART_CONSOLE
>  
> +static void liteuart_putchar(struct uart_port *port, unsigned char ch)
> +{
> +	while (litex_read8(port->membase + OFF_TXFULL))
> +		cpu_relax();
> +
> +	litex_write8(port->membase + OFF_RXTX, ch);
> +}
> +
>  static void liteuart_console_write(struct console *co, const char *s,
>  	unsigned int count)
>  {

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-794393047-1668529023=:2268--
