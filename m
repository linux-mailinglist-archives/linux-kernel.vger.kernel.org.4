Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0001632494
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 15:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiKUOA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 09:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbiKUOAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 09:00:06 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20151C92D;
        Mon, 21 Nov 2022 05:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669039159; x=1700575159;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=sj2b1TjV39Tt4i/TIED+Enb/63DlzwcLP/R2kSeUNTQ=;
  b=dBSKhY14Z+U91e4nbkQu2ZY8JS8OTAR0YMmdKjvRKJuImC5TgMRvW2Pv
   Vi+YxyBHfsNKLbI6k0sEOh2NWy0XEm47kkJJ9dF5bgRbBOTO7ApkcnL2R
   oe1yk6dus25m2fFiBc9oOxtbM6r9woOkkfyGWdeH1aqPoCNli4qXq5XB2
   gG061brKnsn5xaa+/8R7LHnuwSztz0cMFArCPdmqgjj0Wp8MJG33mFxgF
   YF06EtTjq7gC1x8UTxkoW3jV2XhQtGEf1EKmXeTrpOsIcWS1jEykskiiS
   rFoB3vNJeljW6GzCLPo2m6nPlHPGdEUxqj1HfSFI8k7vqNp/HEPIwhrFt
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="311189762"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="311189762"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 05:59:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="704568621"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="704568621"
Received: from ebarboza-mobl1.amr.corp.intel.com ([10.251.209.16])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 05:59:15 -0800
Date:   Mon, 21 Nov 2022 15:59:13 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jisheng Zhang <jszhang@kernel.org>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 2/7] serial: bflb_uart: add Bouffalolab UART Driver
In-Reply-To: <20221120082114.3030-3-jszhang@kernel.org>
Message-ID: <faa34e87-4633-31e7-144b-4fec46cb8f59@linux.intel.com>
References: <20221120082114.3030-1-jszhang@kernel.org> <20221120082114.3030-3-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Nov 2022, Jisheng Zhang wrote:

> Add the driver for Bouffalolab UART IP which is found in Bouffalolab
> SoCs such as bl808.
> 
> UART driver probe will create path named "/dev/ttySx".
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

> diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
> index 238a9557b487..8509cdc11d87 100644
> --- a/drivers/tty/serial/Makefile
> +++ b/drivers/tty/serial/Makefile
> @@ -25,6 +25,7 @@ obj-$(CONFIG_SERIAL_8250) += 8250/
>  
>  obj-$(CONFIG_SERIAL_AMBA_PL010) += amba-pl010.o
>  obj-$(CONFIG_SERIAL_AMBA_PL011) += amba-pl011.o
> +obj-$(CONFIG_SERIAL_BFLB) += bflb_uart.o
>  obj-$(CONFIG_SERIAL_CLPS711X) += clps711x.o
>  obj-$(CONFIG_SERIAL_PXA_NON8250) += pxa.o
>  obj-$(CONFIG_SERIAL_SA1100) += sa1100.o
> diff --git a/drivers/tty/serial/bflb_uart.c b/drivers/tty/serial/bflb_uart.c
> new file mode 100644
> index 000000000000..65f98ccf8fa8
> --- /dev/null
> +++ b/drivers/tty/serial/bflb_uart.c
> @@ -0,0 +1,659 @@
> +#define UART_FIFO_CONFIG_1		(0x84)
> +#define  UART_TX_FIFO_CNT_SFT		0
> +#define  UART_TX_FIFO_CNT_MSK		GENMASK(5, 0)
> +#define  UART_RX_FIFO_CNT_MSK		GENMASK(13, 8)
> +#define  UART_TX_FIFO_TH_SFT		16

Use FIELD_PREP() instead of adding a separate *_SFT define.

> +#define  UART_TX_FIFO_TH_MSK		GENMASK(20, 16)
> +#define  UART_RX_FIFO_TH_SFT		24
> +#define  UART_RX_FIFO_TH_MSK		GENMASK(28, 24)
> +#define UART_FIFO_WDATA			0x88
> +#define UART_FIFO_RDATA			0x8c
> +#define  UART_FIFO_RDATA_MSK		GENMASK(7, 0)


> +	val = rdl(port, UART_URX_CONFIG);
> +	val &= ~UART_CR_URX_EN;
> +	wrl(port, UART_URX_CONFIG, val);
> +
> +	val = rdl(port, UART_INT_MASK);
> +	val |= UART_URX_FIFO_INT | UART_URX_RTO_INT |
> +	       UART_URX_FER_INT;

Fits to single line.

> +	port->type = PORT_BFLB;
> +
> +	/* Clear mask, so no surprise interrupts. */
> +	val = rdl(port, UART_INT_MASK);
> +	val |= UART_UTX_END_INT;
> +	val |= UART_UTX_FIFO_INT;
> +	val |= UART_URX_FIFO_INT;
> +	val |= UART_URX_RTO_INT;
> +	val |= UART_URX_FER_INT;

Why to split it to this many lines?

> +	spin_lock_irqsave(&port->lock, flags);
> +
> +	val = rdl(port, UART_INT_MASK);
> +	val |= 0xfff;

In most of the other places, the bits used with UART_INT_MASK are named, 
but for some reason you don't do it here and the bits extend beyond the 
ones which are defined with name.

> +	wrl(port, UART_INT_MASK, val);
> +
> +	wrl(port, UART_DATA_CONFIG, 0);
> +	wrl(port, UART_SW_MODE, 0);
> +	wrl(port, UART_URX_RTO_TIMER, 0x4f);

FIELD_PREP(UART_CR_URX_RTO_VALUE_MSK, 0x4f)? It would document what field
is written explicitly.

> +
> +	val = rdl(port, UART_FIFO_CONFIG_1);
> +	val &= ~UART_RX_FIFO_TH_MSK;
> +	val |= BFLB_UART_RX_FIFO_TH << UART_RX_FIFO_TH_SFT;
> +	wrl(port, UART_FIFO_CONFIG_1, val);
> +
> +	/* Unmask RX interrupts now */
> +	val = rdl(port, UART_INT_MASK);
> +	val &= ~UART_URX_FIFO_INT;
> +	val &= ~UART_URX_RTO_INT;
> +	val &= ~UART_URX_FER_INT;

Combine to single line.

> +static int bflb_uart_request_port(struct uart_port *port)
> +{
> +	/* UARTs always present */
> +	return 0;
> +}
> +static void bflb_uart_release_port(struct uart_port *port)
> +{
> +	/* Nothing to release... */
> +}

Both release_port and request_port are NULL checked by the caller, there's 
no need to provide and empty one.

> +static const struct uart_ops bflb_uart_ops = {
> +	.tx_empty = bflb_uart_tx_empty,
> +	.get_mctrl = bflb_uart_get_mctrl,
> +	.set_mctrl = bflb_uart_set_mctrl,
> +	.start_tx = bflb_uart_start_tx,
> +	.stop_tx = bflb_uart_stop_tx,
> +	.stop_rx = bflb_uart_stop_rx,
> +	.break_ctl = bflb_uart_break_ctl,
> +	.startup = bflb_uart_startup,
> +	.shutdown = bflb_uart_shutdown,
> +	.set_termios = bflb_uart_set_termios,
> +	.type = bflb_uart_type,
> +	.request_port = bflb_uart_request_port,
> +	.release_port = bflb_uart_release_port,
> +	.config_port = bflb_uart_config_port,
> +	.verify_port = bflb_uart_verify_port,
> +};

> +static void bflb_uart_console_write(struct console *co, const char *s,
> +				    u_int count)
> +{
> +	struct uart_port *port = &bflb_uart_ports[co->index]->port;
> +	u32 status, reg, mask;
> +
> +	/* save then disable interrupts */
> +	mask = rdl(port, UART_INT_MASK);
> +	reg = -1;

Use ~0 instead. Why -1 here and 0xfff in the other place?


-- 
 i.
