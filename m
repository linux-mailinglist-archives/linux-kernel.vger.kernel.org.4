Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF9562DA9C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239999AbiKQMZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240057AbiKQMZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:25:14 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9627C71F2A;
        Thu, 17 Nov 2022 04:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668687906; x=1700223906;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=0sNOymE8u3P7+u37WSBBeVl1/VkxHxomaZV+X9ilbG4=;
  b=C5jODyAwzv5szvHakc7pnIkQcYDUrIqJAUN/gDf3An/YbRQXt3D7hLLN
   kgLB9BE3QYAqWvwGxDqU8pWZulQUodHMUhuDN2T3sdCJISTHcSCfECSxb
   53m3zaw21ohlgmY4LvhIMN1HI8mL0EcO2+WJotrL5YOyNQUtE7vKiAeKu
   15k/4os4+k4XFPBZFLaHfmo1dEyEFh9LbvBWeb4y0wSzv6VmSkTAtjnHJ
   zCi7YgzP728f2poP3JeqCmWZelM0II12U2TF7TIFqqc0ncEONGaDByfj+
   F/hy1mCQf76nKN269mJMucnxJCNOPE0nOe5lb0wqEmS2Ist3KDmFR2sUn
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="314651817"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="314651817"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 04:25:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="764742286"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="764742286"
Received: from kvehmane-mobl1.ger.corp.intel.com ([10.252.61.113])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 04:24:59 -0800
Date:   Thu, 17 Nov 2022 14:24:51 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        macro@orcam.me.uk, jay.dolan@accesio.com, cang1@live.co.uk,
        u.kleine-koenig@pengutronix.de, wander@redhat.com,
        etremblay@distech-controls.com, jk@ozlabs.org,
        biju.das.jz@bp.renesas.com, geert+renesas@glider.be,
        phil.edworthy@renesas.com, Lukas Wunner <lukas@wunner.de>,
        UNGLinuxDriver@microchip.com, colin.i.king@gmail.com,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Subject: Re: [PATCH v5 tty-next 3/4] 8250: microchip: pci1xxxx: Add RS485
 support to quad-uart driver
In-Reply-To: <20221117050126.2966714-4-kumaravel.thiagarajan@microchip.com>
Message-ID: <56e2404f-1976-acca-3080-ce5633a0eb75@linux.intel.com>
References: <20221117050126.2966714-1-kumaravel.thiagarajan@microchip.com> <20221117050126.2966714-4-kumaravel.thiagarajan@microchip.com>
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

On Thu, 17 Nov 2022, Kumaravel Thiagarajan wrote:

> pci1xxxx uart supports RS485 mode of operation in the hardware with
> auto-direction control with configurable delay for releasing RTS after
> the transmission. This patch adds support for the RS485 mode.
> 
> Co-developed-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
> Signed-off-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
> Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> ---
> Changes in v5:
> - Removed unnecessary assignments
> - Corrected styling issues in comments
> 
> Changes in v4:
> - No Change
> 
> Changes in v3:
> - Remove flags sanitization in driver which is taken care in core
> 
> Changes in v2:
> - move pci1xxxx_rs485_config to a separate patch with
>   pci1xxxx_rs485_supported.
> ---
>  drivers/tty/serial/8250/8250_pci1xxxx.c | 50 +++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
> index 02b9c6959dcc..bead9fd4019e 100644
> --- a/drivers/tty/serial/8250/8250_pci1xxxx.c
> +++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
> @@ -139,6 +139,54 @@ static void pci1xxxx_set_divisor(struct uart_port *port, unsigned int baud,
>  	       port->membase + UART_BAUD_CLK_DIVISOR_REG);
>  }
>  
> +static int pci1xxxx_rs485_config(struct uart_port *port,
> +				 struct ktermios *termios,
> +				 struct serial_rs485 *rs485)
> +{
> +	u32 clock_div = readl(port->membase + UART_BAUD_CLK_DIVISOR_REG);
> +	u8 delay_in_baud_periods;
> +	u32 baud_period_in_ns;
> +	u32 data = 0;
> +
> +	/*
> +	 * pci1xxxx's uart hardware supports only RTS delay after
> +	 * Tx and in units of bit times to a maximum of 15
> +	 */
> +	if (rs485->flags & SER_RS485_ENABLED) {
> +		data = ADCL_CFG_EN | ADCL_CFG_PIN_SEL;
> +
> +		if (!(rs485->flags & SER_RS485_RTS_ON_SEND))
> +			data |= ADCL_CFG_POL_SEL;
> +
> +		if (rs485->delay_rts_after_send) {
> +			baud_period_in_ns =
> +				FIELD_GET(BAUD_CLOCK_DIV_INT_MSK, clock_div) *
> +				UART_BIT_SAMPLE_CNT;
> +			delay_in_baud_periods =
> +				(rs485->delay_rts_after_send * NSEC_PER_MSEC) /
> +				baud_period_in_ns;
> +			delay_in_baud_periods =
> +				min_t(u8, delay_in_baud_periods,
> +				      FIELD_MAX(ADCL_CFG_RTS_DELAY_MASK));

I'm a bit worried about overflows here. If the division result does not 
fit into u8, you might not get the max value value but some pseudo 
garbage from LSB of the division result. Also note that min_t casts first,
not after the compare (but that trap is currently hidden by the earlier 
loss of bits).

> +			data |= FIELD_PREP(ADCL_CFG_RTS_DELAY_MASK,
> +					   delay_in_baud_periods);
> +			rs485->delay_rts_after_send =
> +				(baud_period_in_ns * delay_in_baud_periods) /
> +				NSEC_PER_MSEC;

> +			rs485->delay_rts_before_send = 0;

This should be handled by the core (IIRC) when it is not set in 
pci1xxxx_rs485_supported.

-- 
 i.


> +		}
> +	}
> +	writel(data, port->membase + ADCL_CFG_REG);
> +	return 0;
> +}
> +
> +static const struct serial_rs485 pci1xxxx_rs485_supported = {
> +	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND |
> +		 SER_RS485_RTS_AFTER_SEND,
> +	.delay_rts_after_send = 1,
> +	/* Delay RTS before send is not supported */
> +};
> +
>  static int pci1xxxx_setup(struct pci1xxxx_8250 *priv,
>  			  struct uart_8250_port *port, int idx)
>  {
> @@ -193,6 +241,8 @@ static int pci1xxxx_setup(struct pci1xxxx_8250 *priv,
>  	port->port.set_termios = serial8250_do_set_termios;
>  	port->port.get_divisor = pci1xxxx_get_divisor;
>  	port->port.set_divisor = pci1xxxx_set_divisor;
> +	port->port.rs485_config = pci1xxxx_rs485_config;
> +	port->port.rs485_supported = pci1xxxx_rs485_supported;
>  	ret = serial8250_pci_setup_port(priv->dev, port, 0, offset, 0);
>  	if (ret < 0)
>  		return ret;
> 
