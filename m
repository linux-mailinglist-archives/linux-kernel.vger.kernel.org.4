Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208425BD088
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 17:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiISPTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 11:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiISPSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 11:18:42 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8F9399CA;
        Mon, 19 Sep 2022 08:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663600676; x=1695136676;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lyWtjXhG3QhRvIlRitPwxiBIgXlP2Igv2zzIEO7c0wk=;
  b=UK1iaNaFCOHeQiM15afCQioFkuV3SdRsQWpitnmayVjdJXZFfdlEvnUD
   9DSlxRTI0w8LzfmdgZXSjek/Q5wUitCv277laBagdaSytSFZJW2DnilHo
   XS49zYptWAINRYAtjWur55KEAiiyyuqWmplTZa698hHpw5N9BWJ3DxcEb
   1Eux0upnkY0uVrU1OOm3+dy5fW2/0xZ8o3YMqF+sHuTsERerSgXdvIaDw
   bqRunK45ygAqGiysnb4fRR0EDs0ofDS5/MX6mjiiecvW1v871sX9DOk8B
   7FSJhjboM7sA8vCeiC7d1GXtqSJDOpP9+0Tg/IMDMpgVJdKazMLaVLqgR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="279809041"
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="279809041"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 08:17:53 -0700
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="744148447"
Received: from iswiersz-mobl1.ger.corp.intel.com ([10.252.33.172])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 08:17:49 -0700
Date:   Mon, 19 Sep 2022 18:17:46 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Sergiu Moga <sergiu.moga@microchip.com>
cc:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        kavyasree.kotagiri@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 8/9] tty: serial: atmel: Only divide Clock Divisor if
 the IP is USART
In-Reply-To: <20220919150846.1148783-9-sergiu.moga@microchip.com>
Message-ID: <7173f82-4f14-6f89-9651-fd3fdc4b9dcc@linux.intel.com>
References: <20220919150846.1148783-1-sergiu.moga@microchip.com> <20220919150846.1148783-9-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-390606940-1663600673=:1603"
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

--8323329-390606940-1663600673=:1603
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Mon, 19 Sep 2022, Sergiu Moga wrote:

> Make sure that the driver only divides the clock divisor if the
> IP handled at that point is USART, since UART IP's do not support
> implicit peripheral clock division. Instead, in the case of UART,
> go with the highest possible clock divisor.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>

Look good.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.


> ---
> 
> 
> v1 -> v2:
> - Nothing, this patch was not here before and is mainly meant as both cleanup
> and as a way to introduce a new field into struct atmel_uart_port that will be
> used by the last patch to diferentiate between USART and UART regarding the
> location of the Baudrate Clock Source bitmask.
> 
> 
> 
> v2 -> v3:
> - Use ATMEL_US_CD instead of 65535
> - Previously [PATCH 10]
> 
> 
> 
> v3 -> v4:
> - Use min_t instead of &
> - Previously [PATCH 12]
> 
> 
>  drivers/tty/serial/atmel_serial.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index ab4a9dfae07d..c983798a4ab2 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -150,6 +150,7 @@ struct atmel_uart_port {
>  	u32			rts_low;
>  	bool			ms_irq_enabled;
>  	u32			rtor;	/* address of receiver timeout register if it exists */
> +	bool			is_usart;
>  	bool			has_frac_baudrate;
>  	bool			has_hw_timer;
>  	struct timer_list	uart_timer;
> @@ -1825,6 +1826,7 @@ static void atmel_get_ip_name(struct uart_port *port)
>  	 */
>  	atmel_port->has_frac_baudrate = false;
>  	atmel_port->has_hw_timer = false;
> +	atmel_port->is_usart = false;
>  
>  	if (name == new_uart) {
>  		dev_dbg(port->dev, "Uart with hw timer");
> @@ -1834,6 +1836,7 @@ static void atmel_get_ip_name(struct uart_port *port)
>  		dev_dbg(port->dev, "Usart\n");
>  		atmel_port->has_frac_baudrate = true;
>  		atmel_port->has_hw_timer = true;
> +		atmel_port->is_usart = true;
>  		atmel_port->rtor = ATMEL_US_RTOR;
>  		version = atmel_uart_readl(port, ATMEL_US_VERSION);
>  		switch (version) {
> @@ -1863,6 +1866,7 @@ static void atmel_get_ip_name(struct uart_port *port)
>  			dev_dbg(port->dev, "This version is usart\n");
>  			atmel_port->has_frac_baudrate = true;
>  			atmel_port->has_hw_timer = true;
> +			atmel_port->is_usart = true;
>  			atmel_port->rtor = ATMEL_US_RTOR;
>  			break;
>  		case 0x203:
> @@ -2283,10 +2287,21 @@ static void atmel_set_termios(struct uart_port *port,
>  		cd = uart_get_divisor(port, baud);
>  	}
>  
> -	if (cd > 65535) {	/* BRGR is 16-bit, so switch to slower clock */
> +	/*
> +	 * If the current value of the Clock Divisor surpasses the 16 bit
> +	 * ATMEL_US_CD mask and the IP is USART, switch to the Peripheral
> +	 * Clock implicitly divided by 8.
> +	 * If the IP is UART however, keep the highest possible value for
> +	 * the CD and avoid needless division of CD, since UART IP's do not
> +	 * support implicit division of the Peripheral Clock.
> +	 */
> +	if (atmel_port->is_usart && cd > ATMEL_US_CD) {
>  		cd /= 8;
>  		mode |= ATMEL_US_USCLKS_MCK_DIV8;
> +	} else {
> +		cd = min_t(unsigned int, cd, ATMEL_US_CD);
>  	}
> +
>  	quot = cd | fp << ATMEL_US_FP_OFFSET;
>  
>  	if (!(port->iso7816.flags & SER_ISO7816_ENABLED))


--8323329-390606940-1663600673=:1603--
