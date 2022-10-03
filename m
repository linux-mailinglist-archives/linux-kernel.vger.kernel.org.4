Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E675F2CD0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 11:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJCJIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 05:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiJCJHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 05:07:38 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1579A20A;
        Mon,  3 Oct 2022 02:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664787874; x=1696323874;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=EGHwVjKBUzsfHD1elygI7p1os485I7YAhC3qHrPK79w=;
  b=KZBU2amMoerQB1RbtuXeFygglqupNRmWXdID9fOCCmwJBIYJFdUmT1YL
   0hb3Vw4gn5M+y8SQ8t4uaoEbYLqeAOPqOiX3jI+7WBk/Iz0eNmsLz6SXo
   SQyCy+yOSZP3NlYlHUOexn5QTZlaYSJ5hVZzfhO6HB6gvOy0R0yc8vf2H
   vseKC3xwNq2dXuVzndpeinls3ygadF3pJndu0cQArQOlyUgQSJcsPEwh+
   qQ5B8jrY9gdhl8Bg9nxxuskUTRhlqskbD3Wi0DMFkAANU44O5sVgG/U4T
   wlBZhoVZViYZSinDbnfFctgzvdbthiOk6hLKSqbDAaqJ8IuZ+dCA7jaFz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="289747823"
X-IronPort-AV: E=Sophos;i="5.93,365,1654585200"; 
   d="scan'208";a="289747823"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 02:04:26 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="601144780"
X-IronPort-AV: E=Sophos;i="5.93,365,1654585200"; 
   d="scan'208";a="601144780"
Received: from rladysz-mobl2.ger.corp.intel.com ([10.252.38.50])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 02:04:22 -0700
Date:   Mon, 3 Oct 2022 12:04:22 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, andy.shevchenko@gmail.com,
        u.kleine-koenig@pengutronix.de, johan@kernel.org,
        wander@redhat.com, etremblay@distech-controls.com,
        macro@orcam.me.uk, geert+renesas@glider.be, jk@ozlabs.org,
        phil.edworthy@renesas.com, Lukas Wunner <lukas@wunner.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v2 tty-next 2/3] 8250: microchip: pci1xxxx: Add rs485
 support to quad-uart driver.
In-Reply-To: <20221001061507.3508603-3-kumaravel.thiagarajan@microchip.com>
Message-ID: <e433da81-46d5-5aad-4ce9-6d48b2e674e@linux.intel.com>
References: <20221001061507.3508603-1-kumaravel.thiagarajan@microchip.com> <20221001061507.3508603-3-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Oct 2022, Kumaravel Thiagarajan wrote:

> pci1xxxx uart supports rs485 mode of operation in the hardware with
> auto-direction control with configurable delay for releasing RTS after
> the transmission. This patch adds support for the rs485 mode.
> 
> Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> ---
> Changes in v2:
> - move pci1xxxx_rs485_config to a separate patch with
>   pci1xxxx_rs485_supported.
> ---
>  drivers/tty/serial/8250/8250_pci1xxxx.c | 57 +++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
> index 41a4b94f52b4..999e5a284266 100644
> --- a/drivers/tty/serial/8250/8250_pci1xxxx.c
> +++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
> @@ -137,6 +137,61 @@ static void pci1xxxx_set_divisor(struct uart_port *port, unsigned int baud,
>  	writel((quot << 8) | frac, (port->membase + CLK_DIVISOR_REG));
>  }
>  
> +static const struct serial_rs485 pci1xxxx_rs485_supported = {
> +	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND,
> +	.delay_rts_after_send = 1,
> +	/* Delay RTS before send is not supported */
> +};
> +
> +static int pci1xxxx_rs485_config(struct uart_port *port,
> +				 struct ktermios *termios,
> +				 struct serial_rs485 *rs485)
> +{
> +	u32 clock_div = readl(port->membase + CLK_DIVISOR_REG);
> +	u8 delay_in_baud_periods = 0;
> +	u32 baud_period_in_ns = 0;
> +	u8 data = 0;
> +
> +	/* pci1xxxx's uart hardware supports only RTS delay after
> +	 * Tx and in units of bit times to a maximum of 15
> +	 */
> +
> +	rs485->flags &= SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND |
> +			SER_RS485_RTS_AFTER_SEND;

Drop this, core handles it for you.

I think I already mentioned to you that there is a lot of stuff that core 
handles for you.

> +	if (rs485->flags & SER_RS485_ENABLED) {
> +		memset(rs485->padding, 0, sizeof(rs485->padding));

Core handles this for you.

> +		data = ADCL_CFG_EN | ADCL_CFG_PIN_SEL;
> +
> +		if (!(rs485->flags & SER_RS485_RTS_ON_SEND)) {
> +			data |= ADCL_CFG_POL_SEL;
> +			rs485->flags |=  SER_RS485_RTS_AFTER_SEND;
> +		} else {
> +			rs485->flags &= ~SER_RS485_RTS_AFTER_SEND;
> +		}

Core handles that flags sanitization for you.

> +		if (rs485->delay_rts_after_send) {
> +			baud_period_in_ns = ((clock_div >> 8) * 16);

If that >> 8 is there to take part of the CLK_DIVISOR_REG register's bits, 
you want to define a mask and use FIELD_GET().

> +			delay_in_baud_periods = (rs485->delay_rts_after_send * 1000000) /

NSEC_PER_MSEC?

> +						baud_period_in_ns;
> +			if (delay_in_baud_periods > 0xF)
> +				delay_in_baud_periods = 0xF;
> +			data |= delay_in_baud_periods << 8;

You want to add something along these lines:
#define ADCL_CFG_RTS_DELAY_MASK		GENMASK(11, 8)

Then do:
			delay_in_baud_periods = min(delay_in_baud_periods, 
						    FIELD_MAX(ADCL_CFG_RTS_DELAY_MASK));
			data |= FIELD_PREP(ADCL_CFG_RTS_DELAY_MASK, delay_in_baud_periods);

> +			rs485->delay_rts_after_send = (baud_period_in_ns * delay_in_baud_periods) /
> +						      1000000;

NSEC_PER_MSEC?

> +			rs485->delay_rts_before_send = 0;
> +		}
> +	} else {
> +		memset(rs485, 0, sizeof(*rs485));

Core handles this.

> +	}
> +
> +	writeb(data, (port->membase + ADCL_CFG_REG));
> +	port->rs485 = *rs485;

Core handles this.

> +	return 0;
> +}
> +
>  static int pci1xxxx_get_num_ports(struct pci_dev *dev)
>  {
>  	int nr_ports = 1;
> @@ -217,6 +272,8 @@ static int pci1xxxx_setup(struct pci1xxxx_8250 *priv,
>  	port->port.set_termios = serial8250_do_set_termios;
>  	port->port.get_divisor = pci1xxxx_get_divisor;
>  	port->port.set_divisor = pci1xxxx_set_divisor;
> +	port->port.rs485_config = pci1xxxx_rs485_config;
> +	port->port.rs485_supported = pci1xxxx_rs485_supported;
>  	ret = pci1xxxx_setup_port(priv, port, offset);
>  	if (ret < 0)
>  		return ret;
> 

-- 
 i.

